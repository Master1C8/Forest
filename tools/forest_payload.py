#!/usr/bin/env python3
"""Solid-compress an existing verified payload without changing any entry bytes."""
import argparse
import hashlib
import io
import json
import lzma
from pathlib import Path
import struct
import zipfile


def wrap(source, target, preset=6):
    class Writer(io.RawIOBase):
        def __init__(self, output):
            self.output = output; self.size = 0; self.hash = hashlib.sha256()
            self.encoder = lzma.LZMACompressor(format=lzma.FORMAT_ALONE, filters=[dict(id=lzma.FILTER_LZMA1, preset=preset, dict_size=128 << 20)])
        def writable(self): return True
        def seekable(self): return False
        def tell(self): return self.size
        def write(self, data):
            self.hash.update(data); self.size += len(data)
            self.output.write(self.encoder.compress(data)); return len(data)
    with Path(target).open('w+b') as output:
        output.write(b'FRSTPKG1' + bytes(72))
        writer = Writer(output)
        with zipfile.ZipFile(source) as old, zipfile.ZipFile(writer, 'w', zipfile.ZIP_STORED, allowZip64=True) as new:
            if len({x.filename.lower() for x in old.infolist()}) != len(old.infolist()): raise ValueError('duplicate input entry')
            for entry in old.infolist():
                info = zipfile.ZipInfo(entry.filename, (2026, 11, 4, 0, 0, 0)); info.external_attr = 0o100644 << 16
                with old.open(entry) as reader, new.open(info, 'w') as dest:
                    while True:
                        data = reader.read(1 << 20)
                        if not data: break
                        dest.write(data)
        output.write(writer.encoder.flush()); output.seek(8)
        output.write(struct.pack('>Q', writer.size) + writer.hash.hexdigest().encode('ascii'))
    result = dict(bytes=Path(target).stat().st_size, sha256=hashlib.sha256(Path(target).read_bytes()).hexdigest(),
                  decodedBytes=writer.size, decodedSha256=writer.hash.hexdigest(), sourceZipSha256=hashlib.sha256(Path(source).read_bytes()).hexdigest(),
                  dictionaryBytes=128 << 20, encoderPreset=preset, changedEntryContents=False)
    Path(str(target)+'.json').write_text(json.dumps(result, indent=2)+'\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path); parser.add_argument('target', type=Path)
    parser.add_argument('--preset', type=int, choices=[6, 9], default=6)
    args = parser.parse_args(); print(json.dumps(wrap(args.source, args.target, args.preset)), flush=True)
