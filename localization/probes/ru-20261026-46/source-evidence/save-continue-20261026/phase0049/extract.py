"""Bounded original response-consumer IL; no game execution or source changes."""
from pathlib import Path
import hashlib,json,subprocess
root=Path('/Users/antonkrutov/Desktop/Forest');out=Path(__file__).resolve().parent
assembly=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed/Auto-asmdef-FirstPass.dll')
inspector=root/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
assert sha(assembly)=='5ce4b3209650b64b760d63fa2ce289562a6cc2ee16a27f7157964f30c4abb1db'
groups={
 'ResponseButton':('StandardUIResponseButton','OnClick'),
 'ResponseConsumer':('ConversationController','OnSelectedResponse,GotoState'),
 'ResponseView':('ConversationView','StartSubtitle,ShouldShowSubtitle,SelectResponse'),
}
commands={};files={}
for name,(typ,methods) in groups.items():
 argv=['dotnet',str(inspector),str(assembly),'PixelCrushers.DialogueSystem.'+typ,methods]
 p=out/(name+'.il');value=subprocess.check_output(argv)
 if p.exists():assert p.read_bytes()==value
 else:p.write_bytes(value)
 commands[p.name]=argv;files[p.name]=sha(p)
(out/'extraction.json').write_text(json.dumps(dict(assembly=str(assembly),assemblySha256=sha(assembly),inspectorSha256=sha(inspector),recipeSha256=sha(Path(__file__)),commands=commands,files=files,boundary='Read-only IL; policy dispatch is source proof, actual154 display remains unobserved'),indent=2)+'\n')
