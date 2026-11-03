#!/usr/bin/env python3
"""Extract the first complete group icon from a PE file, without executing it."""
import argparse
from pathlib import Path
import struct


def extract(path):
    data = path.read_bytes()
    def u16(at): return struct.unpack_from('<H', data, at)[0]
    def u32(at): return struct.unpack_from('<I', data, at)[0]
    if data[:2] != b'MZ': raise ValueError('not a PE')
    pe = u32(60)
    if data[pe:pe+4] != b'PE\0\0': raise ValueError('not a PE')
    optional = pe + 24
    directories = optional + (112 if u16(optional) == 0x20b else 96)
    resource_rva = u32(directories + 16)
    sections = optional + u16(pe + 20)
    def offset(rva):
        for i in range(u16(pe + 6)):
            at = sections + i * 40
            start = u32(at + 12)
            if start <= rva < start + max(u32(at + 8), u32(at + 16)):
                return u32(at + 20) + rva - start
        raise ValueError('unmapped RVA')
    root = offset(resource_rva)
    def children(relative):
        at = root + relative
        return [struct.unpack_from('<II', data, at + 16 + i * 8) for i in range(u16(at + 12) + u16(at + 14))]
    def leaf(value):
        while value & 0x80000000:
            value = children(value & 0x7fffffff)[0][1]
        at = root + value
        pos = offset(u32(at))
        return data[pos:pos + u32(at + 4)]
    types = dict(children(0))
    icons = {key: leaf(value) for key, value in children(types[3] & 0x7fffffff)}
    group = leaf(types[14])
    reserved, kind, count = struct.unpack_from('<HHH', group)
    if (reserved, kind) != (0, 1): raise ValueError('invalid icon group')
    headers = bytearray(struct.pack('<HHH', 0, 1, count))
    bodies = bytearray(); cursor = 6 + count * 16
    for i in range(count):
        at = 6 + i * 14
        icon = icons[struct.unpack_from('<H', group, at + 12)[0]]
        headers += group[at:at+8] + struct.pack('<II', len(icon), cursor)
        bodies += icon; cursor += len(icon)
    return bytes(headers + bodies)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    with args.output.open('xb') as stream:
        stream.write(extract(args.source))
