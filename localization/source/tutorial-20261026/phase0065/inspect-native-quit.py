#!/usr/bin/env python3
"""Static readback of the exact installed CrossOver26.3 quit consumers; never launches Wine."""
import hashlib
import json
import plistlib
import re
import struct
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[4]
OUT = Path(__file__).resolve().parent
CX = Path('/Applications/CrossOver.app/Contents/SharedSupport/CrossOver')
PINS = {
    '/Applications/CrossOver.app/Contents/Info.plist': '48d3fedca14d94c970184003bef34997ca1c3fdb479fe2e6c0268f98502fd28b',
    str(CX/'etc/CrossOver.conf'): '8e342e4b366648e8b642e3ed30577eba0f4969d98fa04fecfaeedf040a667745',
    str(CX/'CrossOver-Hosted Application/wineloader'): 'ed1318f573bbcd7f153c6fc4c0de66dcf5642b5967e9665991503acb29ea9159',
    str(CX/'lib/wine/x86_64-unix/winemac.so'): 'a46e1c63a5096210626d64ef6c62ddea7632f95dbcf437b1a3bf006d43dcf532',
    str(CX/'lib/wine/x86_64-windows/winemac.drv'): '3d88a8e1f918e7593b396fff995ac344f7297eab74d3966eb6f1b1f1821b4955',
}
def digest(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def emit(name, data):
    (OUT/name).write_text(json.dumps(data, indent=2, ensure_ascii=False)+'\n')
def run(*args):
    return subprocess.run(args, check=True, capture_output=True, text=True).stdout
for p, h in PINS.items():
    assert digest(p) == h, p
# These were pinned before52 launched; the new consumers above extend that family.
startup = json.loads((ROOT/'localization/probes/ru-20261026-52/external-startup-dependencies.json').read_text())
assert all(digest(p) == h for p, h in startup.items())
plist = plistlib.loads(Path('/Applications/CrossOver.app/Contents/Info.plist').read_bytes())
assert plist['CFBundleVersion'] == '26.3.0.39832'
conf = (CX/'etc/CrossOver.conf').read_text()
assert '"BuildTag" = "cxoffice-26.3.0rc2"' in conf

so = CX/'lib/wine/x86_64-unix/winemac.so'
b = so.read_bytes()
assert b[:4] == bytes.fromhex('cffaedfe')
segments = []
o = 32
uuid = None
for _ in range(struct.unpack_from('<I', b, 16)[0]):
    cmd, size = struct.unpack_from('<II', b, o)
    if cmd == 0x19:
        vm, vs, fo, fs = struct.unpack_from('<QQQQ', b, o+24)
        segments.append((vm, fs, fo))
    if cmd == 0x1b:
        uuid = b[o+8:o+24].hex()
    o += size
def so_offset(va):
    for vm, fs, fo in segments:
        if vm <= va < vm+fs:
            return fo+va-vm
    raise ValueError(hex(va))
cfstrings = {}
for va in [0x56888, 0x568a8, 0x568c8, 0x56768, 0x568e8, 0x56908]:
    _, flags, ptr, count = struct.unpack_from('<QQQQ', b, so_offset(va))
    cfstrings[hex(va)] = b[so_offset(ptr):so_offset(ptr)+count].decode()
assert cfstrings['0x56768'] == 'WineExternalQuitRequestNotification'
meta = run('/usr/bin/otool', '-ov', str(so))
# Extract only actual implementations from WineApplicationController, excluding protocol declarations.
controller = meta.split('name           0x518de WineApplicationController', 1)[1].split('Meta Class', 1)[0]
methods = {}
for name, imp in re.findall(r'name\s+0x[0-9a-f]+ ([^\n]+)\n\s+types[^\n]+\n\s+imp\s+(0x[0-9a-f]+)', controller.split('baseProtocols', 1)[0]):
    if name in ['handleExternalQuitRequest:', 'postExternalQuitRequest', 'applicationShouldTerminate:', 'handleApplicationShouldTerminateReply:']:
        methods[name] = imp
assert methods == {'handleExternalQuitRequest:':'0xbc10', 'postExternalQuitRequest':'0xbeb0', 'applicationShouldTerminate:':'0xcaa0', 'handleApplicationShouldTerminateReply:':'0xcca0'}
method_blocks = []
for block in re.findall(r'            name[^\n]+\n            types[^\n]+\n            imp[^\n]+', controller.split('baseProtocols', 1)[0]):
    if any(name in block for name in methods):
        method_blocks.append(block)
ivar_rows = [line for line in controller.splitlines() if any(s in line for s in ['terminatingDueToExternalRequest', '0x60660', 'eventQueues', '0x60520', '0x60528'])]
(OUT/'objc-metadata.txt').write_text('WineApplicationController actual methods (protocol declarations excluded)\n'+'\n'.join(method_blocks)+'\nIvar excerpt\n'+'\n'.join(ivar_rows)+'\n')
assembly = run('/usr/bin/otool', '-tvV', str(so))
ranges = [('external-quit', 0xbc10, 0xc190), ('appkit-quit', 0xcaa0, 0xccf0), ('reply-dispatch',0xe020,0xe0b0), ('unix-quit-event',0x40c00,0x40c90)]
for label, start, end in ranges:
    lines = [line for line in assembly.splitlines() if (m := re.match(r'^([0-9a-f]{16})\s', line)) and start <= int(m[1],16) < end]
    assert lines and int(lines[0].split()[0],16) == start
    (OUT/(label+'.asm.txt')).write_text(f'{so}\nSHA256 {PINS[str(so)]}\nUnslid VM range {start:#x}..{end:#x} (exclusive)\n'+'\n'.join(lines)+'\n')
assert 'currentAppleEvent' in (OUT/'appkit-quit.asm.txt').read_text()
assert 'postEvent:' in (OUT/'appkit-quit.asm.txt').read_text()
assert 'replyToApplicationShouldTerminate:' in (OUT/'appkit-quit.asm.txt').read_text()
assert '_KeUserModeCallback' in (OUT/'unix-quit-event.asm.txt').read_text()

pe = CX/'lib/wine/x86_64-windows/winemac.drv'
b = pe.read_bytes()
o = struct.unpack_from('<I', b, 60)[0]
assert b[o:o+4] == b'PE\0\0'
assert struct.unpack_from('<H', b, o+24)[0] == 0x20b
base = struct.unpack_from('<Q', b, o+48)[0]
nsec = struct.unpack_from('<H', b, o+6)[0]
optsize = struct.unpack_from('<H', b, o+20)[0]
sections = []
for i in range(nsec):
    s = o+24+optsize+40*i
    vs, va, rs, rp = struct.unpack_from('<IIII', b, s+8)
    sections.append((va,max(vs,rs),rp))
def pe_offset(rva):
    for va, size, rp in sections:
        if va <= rva < va+size:
            return rp+rva-va
    raise ValueError(hex(rva))
def cstr(rva):
    return b[pe_offset(rva):].split(b'\0',1)[0].decode(errors='backslashreplace')
imports = {}
x = pe_offset(struct.unpack_from('<I',b,o+24+112+8)[0])
while any(b[x:x+20]):
    orig, _, _, name, iat = struct.unpack_from('<IIIII',b,x)
    dll = cstr(name)
    t, i = pe_offset(orig or iat), 0
    while (v := struct.unpack_from('<Q',b,t+8*i)[0]):
        if not v >> 63:
            imports[hex(base+iat+8*i)] = dll+'!'+cstr(v+2)
        i += 1
    x += 20
assert imports['0x180008250'] == 'kernel32.dll!TerminateProcess'
assert imports['0x180008320'] == 'user32.dll!SendMessageCallbackW'
assert cstr(0x3001) == 'macdrv'
strings = {hex(base+r): cstr(r) for r in [0x42d8,0x4318,0x434c,0x4368,0x43a8,0x43e0,0x4413,0x4430,0x4458,0x44b0,0x4500,0x4588,0x45f0]}
text = run('/usr/bin/objdump','-d','--no-show-raw-insn','--start-address=0x180002520','--stop-address=0x1800027d0',str(pe))
text += run('/usr/bin/objdump','-d','--no-show-raw-insn','--start-address=0x180002980','--stop-address=0x180002d60',str(pe))
for addr, value in {**imports, **strings}.items():
    text = re.sub(r'(# '+re.escape(addr)+r')(?=\s|$)', lambda m: m[1]+' '+json.dumps(value), text)
(OUT/'windows-quit.asm.txt').write_text(f'SHA256 {PINS[str(pe)]}\n'+text)
assert '0x180008250 "kernel32.dll!TerminateProcess"' in text
assert '0x180008320 "user32.dll!SendMessageCallbackW"' in text
assert 'macdrv_app_quit_request' in text and 'quit_callback' in text
sdk = Path('/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks')
headers = [sdk/'AppKit.framework/Headers/NSApplication.h',sdk/'CoreServices.framework/Frameworks/AE.framework/Headers/AERegistry.h']
header_rows = []
for p in headers:
    rows = [{'line':i,'text':line} for i,line in enumerate(p.read_text().splitlines(),1) if any(s in line for s in ['NSTerminateCancel =','NSTerminateNow =','NSTerminateLater =','kAEQuitReason ', 'kAELogOut ', 'kAEReallyLogOut ', 'kAEShowRestartDialog ', 'kAEShowShutdownDialog '])]
    header_rows.append({'path':str(p),'sha256':digest(p),'rows':rows})
emit('native-consumers.json', {
    'scope':'Static shipped binary readback, no execution/injection/debugger/game launch; no claim of every branch running in52',
    'installedFiles':PINS, 'candidate52StartupPinsRechecked':startup,
    'bundleVersion':plist['CFBundleVersion'], 'buildTag':'cxoffice-26.3.0rc2', 'buildTimestamp':'20260715T103801Z',
    'machOArchitecture':'x86_64','machOUuid':uuid,'controllerMethods':methods,'cfstrings':cfstrings,
    'windowsImageBase':hex(base),'windowsImports':imports,'windowsQuitStrings':strings,
    'debugChannel':{'name':cstr(0x3001),'dataAddress':'0x180003000','traceFlagMask':'0x08',
        'requestTraceGate':'0x18000261e','callbackTraceGate':'0x1800029b4','terminationTraceGate':'0x180002a03'},
    'sdkDefinitions':header_rows,
    'priorLogEnvironment':json.loads((ROOT/'localization/probes/ru-20261026-52/launch.json').read_text())['environmentOverrides'],
    'gameLaunches':0,'imagesOpened':0,
})
print('PASS: shipped identity, four Objective-C implementations, PE imports/strings/channel, six assembly excerpts and SDK enum/reason definitions')
