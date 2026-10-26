"""Pin original lifecycle/read-only dependencies; does not execute game methods."""
from pathlib import Path
import hashlib,json,subprocess
root=Path('/Users/antonkrutov/Desktop/Forest');out=Path(__file__).resolve().parent
assembly=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed/Assembly-CSharp.dll')
inspector=root/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
assert sha(assembly)=='46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
groups={
 'DataLifecycle':('Services.Persistence.DataService','Awake,RegisterServices,UnregisterServices,get_Manifest,GetGeneralData,GetPlayerRespawnData,GetActiveTags,GetQuestByDbName,GetDialogueByDbName,GetTriggerByName'),
 'ManifestFields':('Narrative.DataManifest','--fields'),
 'ManifestConstructor':('Narrative.DataManifest','.ctor'),
 'DialogueServiceReads':('Narrative.DialogueService','get_CurrentDialogueDbName,get_CurrentArcName'),
 'DialogueServiceFields':('Narrative.DialogueService','--fields'),
 'GameStateReads':('Events.GameStateManager','get_isAnyEventActive'),
 'SaveReads':('Services.Persistence.SaveManager','get_HasSavedPlaySession'),
 'CustomTypewriterEffectTextMeshPro':('CustomTypewriterEffectTextMeshPro','IsTyping'),
 'ServiceLocator':('Services.ServiceLocator','Get'),
 'SceneHelper':('Services.SceneManagement.SceneHelper','get_inGameplayScene,get_inDustinMinigame,get_inGlitchRoom,InScene,InScenePartialMatch,InScenePartialMatchRaw'),
 'SoftReset':('Services.SceneManagement.SceneHelper','LoadSoftResetScene'),
 'BaseLifecycle':('Core.BaseBehavior','Awake,OnDestroy,RegisterServices'),
}
commands={};files={}
for name,(typ,methods) in groups.items():
 argv=['dotnet',str(inspector),str(assembly),'TheForestOfLove.'+typ,methods]
 p=out/(name+'.il');value=subprocess.check_output(argv)
 if p.exists():assert p.read_bytes()==value
 else:p.write_bytes(value)
 commands[p.name]=argv;files[p.name]=sha(p)
(out/'extraction.json').write_text(json.dumps(dict(assemblySha256=sha(assembly),inspectorSha256=sha(inspector),recipeSha256=sha(Path(__file__)),commands=commands,files=files,boundary='Original read-only IL extraction, no runtime or source inventory edits'),indent=2)+'\n')
