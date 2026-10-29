"""Exercise the unchanged owning BG builder stages from exact cached original bytes."""
import pathlib,sys,json,hashlib
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest');C=R/'outputs/ru-remaining51-application-20261029/check';sys.path.insert(0,str(R/'tools'))
from russian_preview_ui import load_bg_parser,project_actor_display
from russian_quest_ui import project_quest_display
from russian_item_ui import project_item_display
from russian_quest_family import project_quest_family
from russian_inventory_descriptions import project_descriptions
from russian_chapter_gallery_case import project_bg,load_inputs
import russian_remaining51_case as h
parse,var=load_bg_parser();data=(R/'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin').read_bytes();steps=[]
for name,fn in [('actor',project_actor_display),('quest',project_quest_display),('item',project_item_display),('questFamily',project_quest_family),('inventoryDescriptions',project_descriptions)]:
 before=h.digest(data);data,receipt=fn(data,parse,var);steps.append({'stage':name,'before':before,'after':h.digest(data)})
before=h.digest(data);data,_=project_bg(data,parse,var,locale='ru',expected_before_sha256=before,plan=load_inputs(locale='ru'));steps.append({'stage':'chapterGallery','before':before,'after':h.digest(data)})
assert h.digest(data)==h.BG_PRIOR and data==(C/'bg-private-01/bg-before.bin').read_bytes()
projected,receipt=h.project_bg(data,parse,var,locale='ru');assert projected==(C/'bg-private-01/bg-after.bin').read_bytes()
(C/'normal-bg-stage-derivation.json').write_bytes(h.enc({'status':'passed','normalPriorEqualsActualCandidate02TextAsset':True,'newStageEqualsActualPrivateOutput':True,'stages':steps,'priorSha256':h.digest(data),'afterSha256':h.digest(projected),'boundary':'Real owning BG projection functions from original cached payload; does not clone/build game or run Unity.'}));print('normal BG stages equal exact candidate02 payload; new opt-in output equals serialized private readback')
