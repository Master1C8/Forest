#!/usr/bin/env python3
"""Compile the lossless UnityFS adapter with the compiler's exact LZ4 version."""
import hashlib
import json
from pathlib import Path
import subprocess

WIN = Path(__file__).resolve().parent
SOURCE = WIN / 'vendor/lz4'
WORK = WIN.parent / 'dist/windows-installer-work'


def build():
    lzma = WIN / 'vendor/lzma'
    for directory in [SOURCE, lzma]:
        pins = json.loads((directory / 'provenance.json').read_bytes())
        for name, expected in pins['files'].items():
            if hashlib.sha256((directory / name).read_bytes()).hexdigest() != expected:
                raise ValueError('changed pinned codec source: ' + name)
    common = ['-std=c11', '-O2', '-Wall', '-Wextra', '-Werror', '-I', str(SOURCE), '-I', str(lzma), str(WIN / 'forest_bundle.c'),
              str(SOURCE / 'lz4.c'), str(SOURCE / 'lz4hc.c'), str(lzma / 'LzmaDec.c')]
    WORK.mkdir(parents=True, exist_ok=True)
    subprocess.run(['cc'] + common + ['-o', str(WORK / 'forest-bundle')], check=True)
    subprocess.run(['/opt/homebrew/bin/x86_64-w64-mingw32-gcc', '-static'] + common + ['-o', str(WORK / 'forest-bundle.exe')], check=True)


if __name__ == '__main__':
    build()
