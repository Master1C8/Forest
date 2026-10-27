"""Build the finite acquisition-notification inventory from verified source evidence."""
import hashlib
import json
from pathlib import Path
import sys
from urllib.parse import quote
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'localization/source/bgdatabase-20261027'))
from decode_inventory import parse

def build():
    src=ROOT/'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin'
    data=src.read_bytes();assert hashlib.sha256(data).hexdigest()=='41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9'
    sheet=next(s for s in parse(data)['sheets'] if s['name']=='InventoryItem')
    decoded_path=ROOT/'localization/source/bgdatabase-20261027/inventory-decoded.json'
    decoded=json.loads(decoded_path.read_text())
    en=json.loads((ROOT/'localization/glossary/en.json').read_text());byterm={u['term']:u['id'] for u in en}
    units=[]
    for r in decoded['inventoryRows']:
        for name in ['title','notification_phrase']:
            f=next(f for f in sheet['fields'] if f['name']==name)
            ident='bgdb:resources.assets:320/sheet/{}/row/{}/field/{}'.format(*[quote(x,safe='') for x in [sheet['id'],r['id'],f['id']]])
            u=dict(id=ident,family='item',source=r['cells'][name],field=name,rowIndex=r['index'],rowId=r['id'],context=r['cells']['name'])
            if r['index']==46:u['phrase']='item.where' if name=='title' else 'item.placeholder'
            elif r['index']==37 and name=='notification_phrase':u['phrase']='item.seasons-card'
            else:u['glossaryId']=byterm[r['cells']['title']]
            units.append(u)
    protected=[]
    for f in sheet['fields']:
        if f['name'] not in ['title','notification_phrase']:
            protected.append(dict(field=f['name'],fieldId=f['id'],expectedBlobHex=data[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']].hex()))
    code=json.loads((ROOT/'localization/source/item-notifications-20261027/code.json').read_text())
    keys={'You got {0}!':'item.got','Item received: ':'item.received','Item delivered: ':'item.delivered','Item found: ':'item.found','Plank! <.<':'item.plank','Item found:\n':'item.found','Item received:\n':'item.received','Item delivered:\n':'item.delivered'}
    for r in code['units']:
        u=dict(r,family='item-code',phrase=keys[r['source']],context=r['method'])
        if r['source'].endswith('\n'):u['lineEnding']='newline'
        elif r['source'].endswith(' '):u['lineEnding']='space'
        units.append(u)
    assert len(units)==104
    layout=json.loads((ROOT/'localization/source/item-notifications-20261027/layout.json').read_text())
    for row in layout['rows']:
        if row['prefab']!=1279:continue
        assert row['text']['m_text']=='Item found:'+chr(10)+'??????'
        units.append(dict(id=f"sharedassets1.assets:{row['pathId']}/m_text",family='item-prefab',source=row['text']['m_text'],phrase='item.found',context='Glitch notification branch1 skips Configure methods; these six serialized TMP values are displayed directly',pathId=row['pathId'],prefab=1279))
    assert len(units)==110 and len({u['id'] for u in units})==110 and len(protected)==16
    return dict(schemaVersion=1,sourcePath=str(src.relative_to(ROOT)),sourceSha256=hashlib.sha256(data).hexdigest(),decodedSha256=hashlib.sha256(decoded_path.read_bytes()).hexdigest(),sheetId=sheet['id'],rowIds=sheet['rowIds'],fieldIds={f['name']:f['id'] for f in sheet['fields'] if f['name'] in ['title','notification_phrase']},units=units,preserveExactly=protected,protectedAnimatorTriggers=[dict(method=typ,source='show',offset=offset) for typ,offset in [('DialogueCanvasItemGetNotificationController',46),('DialogueCanvasItemLostNotificationController',46),('OverworldItemGetNotificationLite',66)]],scope='All 48 item titles and 48 acquisition phrases; eight display literals in seven notification methods and six directly displayed glitch-prefab labels. Descriptions remain an explicit separate inventory scope.',grammar='Notification prefixes are label constructions, so item terms remain in dictionary form. The formatted legacy message also uses an acquisition label. Do not prepend source-language articles.',editorial='Pending independent review for all 30 locales; approved glossary terms reused exactly.')

if __name__=='__main__':
    value=(json.dumps(build(),ensure_ascii=False,indent=2)+'\n').encode();out=ROOT/'localization/source/item-notifications-20261027/inventory.json'
    if '--check' in sys.argv:assert out.read_bytes()==value
    else:out.write_bytes(value)
    print('110 display units; 16 protected inventory columns; three protected animator triggers')
