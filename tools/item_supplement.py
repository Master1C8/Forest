"""Shared source and wording for the complete finite item notification repair."""
import hashlib
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
SOURCE=ROOT/'localization/source/item-notifications-20261027'
PACKET=ROOT/'localization/supplemental-ui/20261027'
KEYS=['item.got','item.received','item.delivered','item.found','item.plank','item.where','item.placeholder','item.seasons-card']
SOURCES=['You got {0}!','Item received:','Item delivered:','Item found:','Plank! <.<','Where Are My Items?','Adventure Placeholder Item','Seasons Greetings Card']
PHRASES=list(zip(KEYS,SOURCES))

def source_addendum(existing):
    inv=json.loads((SOURCE/'inventory.json').read_text())
    assert len(existing)==446 and len(inv['units'])==110
    assert len({u['id'] for u in existing+inv['units']})==556
    pins={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [SOURCE/'inventory.json',SOURCE/'code.json',ROOT/'tools/inspect_item_notifications.py',ROOT/'tools/item_supplement.py',SOURCE/'layout.json',SOURCE/'retained-website.json',SOURCE/'website-consumer.il',SOURCE/'width-providers.json',SOURCE/'placement.json',ROOT/'tools/item_notification_layout.py',ROOT/'tools/inspect_item_notification_layout.py']}
    return inv['units'],inv['preserveExactly'],pins

def wording():
    values=json.loads((PACKET/'item-wording.json').read_text())
    assert len(values)==30 and all(len(v)==len(KEYS) for v in values.values())
    return {locale:dict(zip(KEYS,texts)) for locale,texts in values.items()}

def render(unit,phrases,glossary):
    if 'glossaryId' in unit:return glossary[unit['glossaryId']]['term']
    text=phrases[unit['phrase']]
    if unit['family']=='item-prefab':return text+chr(10)+'??????'
    if unit.get('lineEnding'):text+= '\n' if unit['lineEnding']=='newline' else ' '
    return text
