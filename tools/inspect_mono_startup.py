#!/usr/bin/env python3
"""Extract the exact consumed39 native Mono startup boundary, without executing it.

Supplement only: no game, consumed probe, frozen corpus or asset-lane writes.
Uses PE section/unwind/export metadata and the installed macOS objdump.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess

ROOT = Path(__file__).resolve().parents[1]
PRIOR = ROOT / 'localization/probes/ru-20261026-39'
ORIGINAL = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
MONO = 'MonoBleedingEdge/EmbedRuntime/mono-2.0-bdwgc.dll'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


class PE:
    def __init__(self, path):
        self.data = path.read_bytes()
        assert self.data[:2] == b'MZ'
        header = struct.unpack_from('<I', self.data, 0x3c)[0]
        assert self.data[header:header+4] == b'PE\0\0'
        assert self.unpack('<H', header+4)[0] == 0x8664
        count = self.unpack('<H', header+6)[0]
        optional = header + 24
        assert self.unpack('<H', optional)[0] == 0x20b
        self.base = self.unpack('<Q', optional+24)[0]
        self.directories = [self.unpack('<II', optional+112+8*i) for i in range(16)]
        start = optional + self.unpack('<H', header+20)[0]
        self.sections = {}
        for i in range(count):
            at = start + 40*i
            name = self.data[at:at+8].rstrip(b'\0').decode('ascii')
            self.sections[name] = self.unpack('<IIII', at+8)

    def unpack(self, fmt, offset):
        return struct.unpack_from(fmt, self.data, offset)

    def offset(self, va):
        for _, rva, size, raw in self.sections.values():
            if rva <= va-self.base < rva+size:
                return raw + va-self.base-rva
        raise ValueError('VA outside file sections: ' + hex(va))

    def string(self, va):
        at = self.offset(va)
        return self.data[at:self.data.index(b'\0', at)].decode('ascii')

    def function(self, va):
        rva, size = self.directories[3]  # x64 exception/unwind table
        at = self.offset(self.base+rva)
        entries = list(struct.iter_unpack('<III', self.data[at:at+size]))
        matches = [row for row in entries if row[0] <= va-self.base < row[1]]
        assert len(matches) == 1, (hex(va), matches)

        def root(row, seen=()):
            assert row not in seen, 'Cyclic chained unwind metadata'
            unwind = self.offset(self.base+row[2])
            flags, _, codes, _ = self.unpack('<BBBB', unwind)
            if not (flags >> 3) & 4:  # UNW_FLAG_CHAININFO
                return row
            chain = unwind + 4 + ((codes+1)//2)*4
            return root(self.unpack('<III', chain), seen+(row,))

        selected = root(matches[0])
        # One C++ function can have several unwind entries (prologue/body/epilogue).
        # A single containing entry truncates MonoPaths before either log call.
        return [(self.base+a, self.base+b) for a, b, u in entries
                if root((a, b, u)) == selected]

    def exports(self):
        rva, _ = self.directories[0]
        at = self.offset(self.base+rva)
        fields = self.unpack('<IIHHIIIIIII', at)
        count, funcs, names, ordinals = fields[7], fields[8], fields[9], fields[10]
        result = {}
        for i in range(count):
            name_rva = self.unpack('<I', self.offset(self.base+names)+4*i)[0]
            ordinal = self.unpack('<H', self.offset(self.base+ordinals)+2*i)[0]
            code = self.unpack('<I', self.offset(self.base+funcs)+4*ordinal)[0]
            name = self.string(self.base+name_rva)
            assert name not in result
            result[name] = hex(code)
        return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    assert out.parent == ROOT / 'localization/source' and not out.exists()
    prior_files = json.loads((PRIOR / 'original-game-files.json').read_text())
    relevant = ['The Forest of Love.exe', 'UnityPlayer.dll', MONO,
                'MonoBleedingEdge/EmbedRuntime/MonoPosixHelper.dll',
                'MonoBleedingEdge/etc/mono/config',
                'The Forest of Love_Data/Managed/mscorlib.dll',
                'The Forest of Love_Data/boot.config']
    hashes = {}
    for name in relevant:
        a, b = ORIGINAL / name, PRIOR / 'game' / name
        hashes[name] = sha(a)
        assert sha(b) == hashes[name] == prior_files[name]
    player, mono = PE(PRIOR / 'game/UnityPlayer.dll'), PE(PRIOR / 'game' / MONO)
    # Exact dynamic-export resolver shape, including the RIP-relative destination.
    # Selected candidates must name a real exported Mono symbol; no symbol guessing.
    bindings = {}
    _, rva, size, raw = player.sections['.text']
    pattern = rb'\x48\x8d\x15(.{4})\x45\x33\xc0\xe8(.{4})\x48\x89\x05(.{4})'
    exports = mono.exports()
    for match in re.finditer(pattern, player.data[raw:raw+size], re.DOTALL):
        va = player.base + rva + match.start()
        name_va = va+7+struct.unpack('<i', match[1])[0]
        try:
            name = player.string(name_va)
        except (ValueError, UnicodeDecodeError):
            continue
        if not name.startswith('mono_'):
            continue
        slot = va+22+struct.unpack('<i', match[3])[0]
        bindings[hex(slot)] = dict(name=name, resolverVA=hex(va),
                                   exportedRVA=exports.get(name))
    required = {'0x181a2edc8': 'mono_set_dirs',
                '0x181a2ebb8': 'mono_set_assemblies_path_null_separated',
                '0x181a2e7b8': 'mono_jit_init_version'}
    assert all(bindings[k]['name'] == v and bindings[k]['exportedRVA'] for k, v in required.items())
    out.mkdir()
    commands = {}
    ranges = {}
    for name, address in [('MonoLoad', 0x1808d04c0), ('MonoPaths', 0x1808ca8b0),
                          ('MonoDomain', 0x1808c7880), ('EngineVersion', 0x18076dd30)]:
        ranges[name] = player.function(address)
        parts, commands[name+'.asm'] = [], []
        for start, end in ranges[name]:
            argv = ['/usr/bin/objdump', '-d', '--start-address='+hex(start),
                    '--stop-address='+hex(end), str(PRIOR / 'game/UnityPlayer.dll')]
            parts.append(subprocess.check_output(argv, text=True, timeout=30))
            commands[name+'.asm'].append(argv)
        assembly = '\n'.join(parts)
        annotated = []
        for line in assembly.splitlines():
            target = re.search(r'# (0x[0-9a-f]+)', line)
            if target and target[1] in bindings:
                line += ' ; ' + bindings[target[1]]['name']
            annotated.append(line)
        (out / (name+'.asm')).write_text('\n'.join(annotated)+'\n')
    paths = (out/'MonoPaths.asm').read_text()
    domain = (out/'MonoDomain.asm').read_text()
    assert all(token in paths for token in ['0x1816a3fe0', '0x1816a3ff8',
                                           '; mono_set_dirs', '; mono_set_assemblies_path_null_separated'])
    assert '; mono_jit_init_version' in domain and '1808c7cbd:' in domain
    env_strings = {}
    for key in ['MONO_LOG_LEVEL', 'MONO_LOG_MASK']:
        offsets = [hex(m.start()) for m in re.finditer(re.escape(key.encode()+b'\0'), mono.data)]
        assert len(offsets) == 1
        env_strings[key] = offsets
    report = dict(result='passed-static-only', originalAnd39Parity=hashes,
                  dynamicMonoBindings=bindings, monoLoggingEnvironmentStrings=env_strings,
                  commands=commands, chainedUnwindRanges=ranges, objdumpVersion=subprocess.check_output(
                      ['/usr/bin/objdump', '--version'], text=True).splitlines()[0],
                  inputs={name: sha(PRIOR/name) for name in ['launch.json', 'player.log', 'wine.log',
                      'runtime-diagnosis.json', 'bridge-build.json', 'final-verification.json']},
                  artifacts={p.name: sha(p) for p in out.glob('*.asm')},
                  recipeSha256=sha(Path(__file__)), gameLaunches=0, imagesOpened=0,
                  boundary='Native bytes/unwind bounds/export identities only; not proof of a specific39 runtime call, failure cause, debug emission or renderer behavior')
    (out/'extraction.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(dict(result=report['result'], nativeFiles=len(hashes),
                          monoBindings=len(bindings), disassemblies=len(commands))))


if __name__ == '__main__':
    main()
