from pathlib import Path
import shutil,json,subprocess,hashlib
R=Path('/Users/antonkrutov/Desktop/Forest');d=R/'tools/remaining51_patch';d.mkdir()
s=(R/'tools/haiku_identity_patch/Program.cs').read_text(); prefix=s[:s.index('    static JsonElement Map(')]
prefix=prefix.replace('const string Candidate = "84f70452d94741489b37d97c8125bf107b4261d4a87e5a2ba294ebdf107dfacf";', 'const string Prior = "74a2f0e8a4851e128ba853837c31fc8d9c17fa7cdefae57505ae5c763ce0a9de";').replace('58cba42e3fe2c682ac6da28d7ddb476b313e20ff2810e47de8e8b26890a23f74','96ce2c8983eac73940ea86af512d67c21153c21185dadd24c89763bcc4609de1')
(d/'Program.cs').write_text(prefix)
shutil.copytree(R/'tools/haiku_identity_patch/deps',d/'deps')
(d/'Remaining51Patch.csproj').write_text((R/'tools/haiku_identity_patch/HaikuIdentityPatch.csproj').read_text().replace('<Nullable>enable</Nullable>','<Nullable>enable</Nullable><Deterministic>true</Deterministic>'))
(d/'global.json').write_text('{"sdk":{"version":"8.0.131","rollForward":"disable"}}\n')
dotnet=Path(shutil.which('dotnet')).resolve(); sdk=dotnet.parent/'sdk/8.0.131'; assert sdk.is_dir(),sdk
# Pin compiler, runtime, MSBuild SDK, reference packs and host: no mutable/default SDK selection.
files={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for tree in [dotnet.parent/'sdk/8.0.131',dotnet.parent/'packs',dotnet.parent/'shared',dotnet.parent/'host'] for p in tree.rglob('*') if p.is_file()}
files[str(dotnet)]=hashlib.sha256(dotnet.read_bytes()).hexdigest()
(d/'compiler-pins.json').write_text(json.dumps({'dotnet':str(dotnet),'sdk':'8.0.131','files':files},indent=2)+'\n')
print('compiler files',len(files))
