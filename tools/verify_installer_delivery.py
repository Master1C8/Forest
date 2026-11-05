#!/usr/bin/env python3
"""Verify an actual delivery ZIP against its built tree and source receipt.

Read-only for the archive/application/source. Writes a separate integrity receipt;
does not install, launch, sign or publish anything.
"""
import argparse
import hashlib
import json
from pathlib import Path, PurePosixPath
import stat
import struct

ROOT = Path(__file__).resolve().parents[1]


def digest(stream):
    h = hashlib.sha256()
    while block := stream.read(1 << 20):
        h.update(block)
    return h.hexdigest()


def sha(path):
    with path.open('rb') as stream:
        return digest(stream)


def verify(receipt_path, directory, output, macos=False):
    import zipfile
    receipt = json.loads(receipt_path.read_bytes())
    archive = ROOT / receipt['artifact']
    assert archive.resolve().is_relative_to(ROOT / 'dist')
    assert directory.parent == ROOT / 'dist' and directory.is_dir()
    assert archive.stat().st_size == receipt['bytes'] and sha(archive) == receipt['sha256']
    source_pins = receipt['sourcePins']
    for name, expected in source_pins.items():
        source = ROOT / name
        assert source.resolve().is_relative_to(ROOT) and sha(source) == expected, ('source-pin-drift', name)
    expected = {}
    directories = {directory.name}
    for path in directory.rglob('*'):
        assert not path.is_symlink(), ('Unexpected delivery symlink', str(path))
        name = directory.name + '/' + path.relative_to(directory).as_posix()
        if path.is_dir():
            directories.add(name)
        elif path.is_file():
            expected[name] = path
        else:
            raise ValueError('Unexpected non-file delivery entry: ' + name)
    seen, files, metadata = set(), set(), []
    with zipfile.ZipFile(archive) as z:
        for entry in z.infolist():
            name = entry.filename.rstrip('/')
            assert name and not name.startswith('/') and '\\' not in name
            assert all(p not in ['', '.', '..'] for p in name.split('/'))
            assert name.casefold() not in seen, ('Duplicate archive identity', name)
            seen.add(name.casefold())
            assert not stat.S_ISLNK(entry.external_attr >> 16), ('Archive symlink', name)
            if entry.is_dir():
                assert name in directories or macos and (name == '__MACOSX' or name.removeprefix('__MACOSX/') in directories)
                continue
            if macos and (name.startswith('__MACOSX/') or PurePosixPath(name).name.startswith('._')):
                relative = PurePosixPath(name.removeprefix('__MACOSX/'))
                assert relative.name.startswith('._')
                target = str(relative.with_name(relative.name[2:]))
                assert target in expected or target in directories, ('Unassociated AppleDouble metadata', name)
                data = z.read(entry)  # Also exercises this metadata member's CRC.
                assert len(data) >= 26 and struct.unpack_from('>II', data) == (0x00051607, 0x00020000)
                count = struct.unpack_from('>H', data, 24)[0]
                assert len(data) >= 26 + count * 12
                for i in range(count):
                    _, offset, size = struct.unpack_from('>III', data, 26 + i * 12)
                    assert 26 + count * 12 <= offset <= offset + size <= len(data)
                metadata.append(name)
                continue
            assert name in expected, ('Unexpected archive member', name)
            path = expected[name]
            assert entry.file_size == path.stat().st_size
            with z.open(entry) as stream:
                assert digest(stream) == sha(path), ('Archive member differs', name)
            files.add(name)
    assert files == set(expected), ('Incomplete delivered inventory', sorted(set(expected) - files))
    assert output.resolve().is_relative_to(ROOT) and not output.exists()
    result = dict(passed=True, artifact=receipt['artifact'], bytes=receipt['bytes'], sha256=receipt['sha256'],
                  buildReceipt=dict(path=str(receipt_path), sha256=sha(receipt_path)),
                  sourcePinsMatched=True, completeZipInventoryMatched=True, regularFiles=len(files),
                  associatedAppleDoubleMetadata=metadata, sourceFileCount=len(source_pins),
                  boundary='Complete archive bytes, file inventory and current source pins; excludes GUI, installation and game execution')
    output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k: result[k] for k in ['passed', 'artifact', 'regularFiles', 'sourceFileCount']}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('receipt', type=Path)
    parser.add_argument('directory', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--macos', action='store_true')
    args = parser.parse_args()
    verify(args.receipt.resolve(), args.directory.resolve(), args.output.resolve(), args.macos)
