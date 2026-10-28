"""Capture finite named receivers needed for assigned compiled-literal predicates."""
import json,hashlib,sys,subprocess
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent;ROOT=OUT.parents[3];sys.path.insert(0,str(OUT))
from phase138.expand_roles import method_bodies
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
selections={'TheForestOfLove.GalleryHintTutorial':'Start','TheForestOfLove.FastTravelAnimation':'ConfigureCutsceneConversation','viperOSK_Examples.Example4': 'TabKey,UsernameSubmit,PasswordSubmit', 'viperOSK.OSK_Key': 'Assign', 'viperOSK.OSK_UI_Key': 'Assign', 'viperOSK.OSK_Keyboard': 'LoadLayout', 'viperOSK.OSK_UI_Keyboard': 'LoadLayout', 'viperOSK.OSK_Receiver': 'Text,ParsedText,ClearText,SetText', 'TheForestOfLove.SmashableCrystalTest': 'Update,OnSlashImpact', 'TheForestOfLove.ItemPowerup': 'Start,ActivateTrigger,onClipEnded', 'TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0': '<OnMovieEnding>b__0', 'TheForestOfLove.Gameplay.DynamicConversationCustomTrigger': 'Fire,OnConversationStartCustomHandler', 'TheForestOfLove.MainMenuController': 'LoadOverworld', 'TheForestOfLove.StartScreenGalleryMenu': 'OnClickPlay', 'TheForestOfLove.BunnyCuckMoviePeter': 'JumpToLoop', 'TheForestOfLove.MovieDialogueManager': 'StartDialogue', 'TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer': 'SetAnimatorTriggers', 'TheForestOfLove.MabelSoloStory': 'OnShowPanel2,OnShowPanel3', 'TheForestOfLove.MapUIMarker': 'HideAll,ShowSelected', 'TheForestOfLove.GossipUI': 'SelectItemLabel,UpdateTooltipText', 'TheForestOfLove.OverworldAllInOneNotification': 'InstantiateNewNotification', 'TheForestOfLove.Content.BaseSpawner': 'NewEmptyContent,NewEmptyContentSet', 'TheForestOfLove.Content.CentralForestSpawner/<>c__DisplayClass299_0': '<SpawnDustin>b__1', 'TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0': '<TryShowOutOfSyncContentNotification>b__2', 'TheForestOfLove.Content.BearCaveSpawner': 'Act3AfterstormSetCharlotteInBedAnimatorTrigger,Act3AfterstormSetCharlotteInBedAnimatorTrigger_internal', 'TheForestOfLove.Gameplay.ObjectActor': 'SetTargetDialogue', 'TheForestOfLove.Gameplay.CritterActor': 'SetTargetDialogue', 'TheForestOfLove.Utility.ContentManagementExtensions': 'SetTargetDialogueInChildren', 'RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript': 'Start'}
assembly=ROOT/'localization/probes/ru-20261026-11/game/The Forest of Love_Data/Managed/Assembly-CSharp.dll';inspector=ROOT/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
assert sha(assembly)=='46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
assert sha(inspector)=='10e6da1a3ef09aff8ce89a1fc9f3e0fe56d15b776bc0e0ae70d56f42f304fc05'
cache={}
for path in list(OUT.glob('phase*/*.il'))+list((OUT/'phase144/producers').glob('*.il'))+list((OUT/'phase144/receivers').glob('*.il'))+list((OUT/'phase145/receivers').glob('*.il'))+list((HERE/'receivers').glob('*.il')):
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
# Canonicalize every receiver literal only after complete raw-span verification.
# Regression: GalleryHintTutorial.Start contains a literal LF; the historical
# one-line navigator representation truncates that operand. Do not retain it.
from phase144.validate_roles import literal_span
originals=[json.loads(x) for x in (ROOT/'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl').read_text().splitlines()]
by_method={r['method']:r for r in result};normalized=[]
for source in originals:
 if source['method'] not in by_method:continue
 record=by_method[source['method']];literal_span((ROOT/record['evidence']).read_bytes(),source)
 item=next(i for i in record['instructions'] if i['offset']==source['offset']);assert item['opcode']=='ldstr'
 value=json.dumps(source['value'],ensure_ascii=False)
 if item['operand']!=value:normalized.append(dict(method=source['method'],offset=source['offset'],rawEvidence=record['evidence'],canonicalOperand=value))
 item['operand']=value
(HERE/'literal-transport-normalization.json').write_text(json.dumps(normalized,ensure_ascii=False,indent=2)+'\n')
(HERE/'receiver-bodies.jsonl').write_text(''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in result))
pins={};pins.update({r['evidence']:r['fileSha256'] for r in result});(HERE/'input-pins.json').write_text(json.dumps(pins,indent=2)+'\n')
print('finite receiver bodies',len(result))
