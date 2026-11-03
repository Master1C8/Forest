"""Lossless storage view of Forest's two-member UnityFS bundles.

Never serialize game objects. Preserve every header/metadata byte and stream byte.
The matching native helper recompresses with pinned LZ4 1.9.4; exceptional blocks
retain their original encoded bytes. The normal compiler's full SHA must match.
"""
import hashlib
import io
import json
from pathlib import Path
import struct
import lz4.block


def sha(b): return hashlib.sha256(b).hexdigest()


def prepare(path, work):
    data = Path(path).read_bytes(); digest = sha(data)
    work.mkdir(parents=True, exist_ok=True)
    asset = work / (digest + '.asset'); recipe = work / (digest + '.recipe'); proof = work / (digest + '.json')
    if proof.exists():
        result = json.loads(proof.read_bytes())
        if sha(asset.read_bytes()) != result['assetSha256'] or sha(recipe.read_bytes()) != result['recipeSha256']:
            raise ValueError('bundle storage cache drift')
        return asset, recipe, result
    reader = io.BytesIO(data)
    def number(n): return int.from_bytes(reader.read(n), 'big')
    def cstring():
        out = bytearray()
        while True:
            c = reader.read(1)
            if not c: raise ValueError('truncated bundle string')
            if c == b'\0': return bytes(out)
            out += c
    if cstring() != b'UnityFS' or number(4) != 7: raise ValueError('unsupported bundle')
    cstring(); cstring()
    if number(8) != len(data): raise ValueError('bundle size mismatch')
    compressed_info, raw_info, flags = number(4), number(4), number(4)
    if flags & 0x200 or flags & 63 not in [0, 2, 3]: raise ValueError('unsupported metadata compression')
    start = (reader.tell() + 15) & ~15
    info_pos = len(data) - compressed_info if flags & 128 else start
    encoded = data[info_pos:info_pos + compressed_info]
    info = encoded if flags & 63 == 0 else lz4.block.decompress(encoded, uncompressed_size=raw_info)
    if len(info) != raw_info: raise ValueError('metadata length mismatch')
    r = io.BytesIO(info); r.read(16)
    def num(n): return int.from_bytes(r.read(n), 'big')
    blocks = [(num(4), num(4), num(2)) for _ in range(num(4))]
    nodes = []
    for _ in range(num(4)):
        offset, size, kind = num(8), num(8), num(4); name = bytearray()
        while True:
            c = r.read(1)
            if not c: raise ValueError('truncated node')
            if c == b'\0': break
            name += c
        nodes.append(dict(offset=offset, bytes=size, flags=kind, name=name.decode()))
    if len(nodes) != 2 or nodes[0]['offset'] != 0 or nodes[1]['offset'] != nodes[0]['bytes'] or r.tell() != len(info):
        raise ValueError('unexpected bundle directory')
    if sum(x[0] for x in blocks) != sum(x['bytes'] for x in nodes): raise ValueError('bundle stream gap')
    data_start = start if flags & 128 else start + compressed_info
    data_end = data_start + sum(x[1] for x in blocks)
    prefix, suffix = data[:data_start], data[data_end:]
    stream_hash = hashlib.sha256(); consumed = 0; pos = data_start; fallback = 0
    with asset.open('wb') as out, recipe.open('wb') as rec:
        rec.write(b'FRSTBND1' + struct.pack('>IIIQ', len(prefix), len(suffix), len(blocks), nodes[0]['bytes']) + prefix)
        for raw_size, packed_size, block_flags in blocks:
            packed = data[pos:pos + packed_size]; pos += packed_size
            if block_flags & 63 == 0: raw = packed; mode = 0
            elif block_flags & 63 in [2, 3]:
                raw = lz4.block.decompress(packed, uncompressed_size=raw_size)
                mode = 1 if lz4.block.compress(raw, mode='high_compression', compression=9, store_size=False) == packed else 2
            else: raise ValueError('unsupported block')
            if len(raw) != raw_size or raw_size > 131072: raise ValueError('unsupported block size')
            take = min(len(raw), max(0, nodes[0]['bytes'] - consumed))
            out.write(raw[:take]); stream_hash.update(raw[take:]); consumed += len(raw)
            rec.write(struct.pack('>IIHB', raw_size, packed_size, block_flags, mode))
            if mode == 2: rec.write(packed); fallback += packed_size
        rec.write(suffix)
    result = dict(sourceSha256=digest, sourceBytes=len(data), assetSha256=sha(asset.read_bytes()), assetBytes=asset.stat().st_size,
                  streamSha256=stream_hash.hexdigest(), streamBytes=nodes[1]['bytes'], directory=nodes,
                  recipeSha256=sha(recipe.read_bytes()), recipeBytes=recipe.stat().st_size, fallbackCompressedBytes=fallback,
                  lz4Version='1.9.4', gameObjectSerialization=False)
    proof.write_text(json.dumps(result, indent=2) + '\n')
    return asset, recipe, result
