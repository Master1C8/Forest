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
additional={
 'OriginalContinue':('TheForestOfLove.CustomTypewriterEffectTextMeshPro','FastForwardTextOrAdvanceDialogue'),
 'OriginalContinueInternal':('TheForestOfLove.CustomTypewriterEffectTextMeshPro','FastForwardTextOrAdvanceDialogue_Internal'),
}
groups.update({
 'SubtitleFinished':('ConversationController','OnFinishedSubtitle'),
 'ResponseContinueView':('ConversationView','HandleContinueButtonClick,FinishSubtitle,OnFinishedSubtitle,StartResponses'),
})
commands={};files={}
for name,(typ,methods) in groups.items():
 argv=['dotnet',str(inspector),str(assembly),'PixelCrushers.DialogueSystem.'+typ,methods]
 p=out/(name+'.il');value=subprocess.check_output(argv)
 if p.exists():assert p.read_bytes()==value
 else:p.write_bytes(value)
 commands[p.name]=argv;files[p.name]=sha(p)
game_assembly=assembly.with_name('Assembly-CSharp.dll')
assert sha(game_assembly)=='46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
for name,(typ,methods) in additional.items():
 argv=['dotnet',str(inspector),str(game_assembly),typ,methods]
 p=out/(name+'.il');value=subprocess.check_output(argv)
 if p.exists():assert p.read_bytes()==value
 else:p.write_bytes(value)
 commands[p.name]=argv;files[p.name]=sha(p)
(out/'extraction.json').write_text(json.dumps(dict(assembly=str(assembly),assemblySha256=sha(assembly),additionalAssemblySha256=sha(game_assembly),inspectorSha256=sha(inspector),recipeSha256=sha(Path(__file__)),commands=commands,files=files,boundary='Read-only IL; policy dispatch is source proof, actual154 display remains unobserved',additionalBoundary='After consumed46: original Continue and subtitle-finished response-menu path; frozen46 source supplement predates this bounded addendum'),indent=2)+'\n')
