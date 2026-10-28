"""Capture finite named receivers needed for assigned compiled-literal predicates."""
import json,hashlib,sys,subprocess
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent;ROOT=OUT.parents[3];sys.path.insert(0,str(OUT))
from phase138.expand_roles import method_bodies
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
selections={
'viperTools.viperInput':'GetAxis',
'SoftSpriteMaskStrengthOnCollision2D':'Qualifies',
'viperOSK.OSK_Keyboard':'OutputTextUpdate,LoadLayout',
'viperOSK.OSK_UI_Keyboard':'OutputTextUpdate',
'viperOSK.OSK_Receiver':'SetText,AddText,Text,ClearText,ParsedText',
'viperOSK.OSK_Key_TFOL':'Relabel',
'TheForestOfLove.Narrative.StoryManager':'MarkConversationsAsPlayed,HasAvailableMessages',
'TheForestOfLove.Services.SceneManagement.SceneHelper':'LoadSoftResetScene,LoadSceneAdditive,InScenePartialMatch,InScenePartialMatchRaw',
'TheForestOfLove.Narrative.NarrativeActions':'CompleteQuest',
'TheForestOfLove.Gameplay.FastTravelController':'PlayerInitiatesFastTravel',
'TheForestOfLove.GameplayLogManager':'AddEventLog',
'TheForestOfLove.Narrative.InstancedStoryController':'Shared_Setup',
'TheForestOfLove.CCTeleport':'Teleport',
'TheForestOfLove.DialogueSettings':'SetDialogueDbName,SetArcDbName',
'TheForestOfLove.Audio.MusicManager':'Play',
'TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper':'ReadPlayerPrefsJsonStringList',
'TheForestOfLove.Services.Persistence.SavegameFileHelper':'ReadDataFromGameDirectory,WriteDataToGameDirectory',
}
assembly=ROOT/'localization/probes/ru-20261026-11/game/The Forest of Love_Data/Managed/Assembly-CSharp.dll';inspector=ROOT/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
assert sha(assembly)=='46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
assert sha(inspector)=='10e6da1a3ef09aff8ce89a1fc9f3e0fe56d15b776bc0e0ae70d56f42f304fc05'
cache={}
for path in list(OUT.glob('phase*/*.il'))+list((OUT/'phase144/producers').glob('*.il'))+list((OUT/'phase144/receivers').glob('*.il'))+list((HERE/'receivers').glob('*.il')):
 for m,b in method_bodies(path).items():cache.setdefault(m,dict(method=m,instructions=b,evidence=str(path.relative_to(ROOT)),fileSha256=sha(path)))
(HERE/'receivers').mkdir(exist_ok=True);result=[]
for n,(owner,names) in enumerate(selections.items()):
 names=set(names.split(','));found={m:b for m,b in cache.items() if m.split(' ',1)[1].split('::')[0]==owner and m.split('::')[1].split('(')[0] in names}
 absent=names-{m.split('::')[1].split('(')[0] for m in found}
 if absent:
  path=HERE/'receivers'/(hashlib.sha256((owner+'|'+','.join(sorted(absent))).encode()).hexdigest()[:16]+'.il')
  text=subprocess.run(['/opt/homebrew/bin/dotnet',str(inspector),str(assembly),owner,','.join(sorted(absent))],capture_output=True,text=True,check=True).stdout;path.write_text(text)
  for m,b in method_bodies(path).items():found[m]=dict(method=m,instructions=b,evidence=str(path.relative_to(ROOT)),fileSha256=sha(path))
 
 for record in found.values():assert sha(ROOT/record['evidence'])==record['fileSha256'],'receiver-capture-path-collision'
 result.extend(found.values())
(HERE/'receiver-bodies.jsonl').write_text(''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in result))
pins={};pins.update({r['evidence']:r['fileSha256'] for r in result});(HERE/'input-pins.json').write_text(json.dumps(pins,indent=2)+'\n')
print('finite receiver bodies',len(result))
