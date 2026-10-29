"""Select existing common-source records for three cases; no semantic judgments."""
import hashlib
import json
import pathlib
import re
from collections import defaultdict

ROOT = pathlib.Path('/Users/antonkrutov/Desktop/Forest')
OUT = pathlib.Path(__file__).resolve().parent
assert OUT == ROOT / 'localization/source/ru-item-wordplay-closure-20261029'
PINS = {}

def sha(data):
    return hashlib.sha256(data).hexdigest()

def compact(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':')).encode()

def read(path):
    p = ROOT / path
    b = p.read_bytes()
    PINS[str(p)] = {'sha256': sha(b), 'bytes': len(b)}
    return b.decode()

def jread(path):
    return json.loads(read(path))

def lines(path):
    return [json.loads(s) for s in read(path).splitlines()]

def write(name, value):
    (OUT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')

def jl(name, rows):
    (OUT / name).write_bytes(b''.join(compact(r) + b'\n' for r in rows))

CASES = {
    'inventory-sugar-euphemism': {'item': 'IE0fMrRWeU+WqLMl0zGPgg', 'conversations': [120,143,128,129]},
    'inventory-rosetta-glyph-reference': {'item': 'qCat8UqD5E2o5HBd+m/d5Q', 'conversations': [276,153,154,204,202,294,312]},
    'inventory-apology-cookie-icing': {'item': 'rcrNBKenO0iUhEJYQ3fEJw', 'conversations': [199,388,409,413,414,422,423,425,426,427,428,429]},
}
TREE = 'assets/source-v2/trees/57009919ee-sharedassets0.assets-3336.json'
OTHER = 'assets/source-v2/trees/c1a187d8bb-CAB-7cd732d37ea0297d073a22a52ce72d28--9011735310751668748.json'
BG = 'localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl'
FROZEN = 'localization/source/dialogue-candidates.jsonl'
tree, other = jread(TREE), jread(OTHER)
frozen = {x['id']: x for x in lines(FROZEN)}
cells = lines(BG)
rows = defaultdict(list)
for lineno, cell in enumerate(cells, 1):
    rows[(cell['sheet'], cell['rowId'])].append((lineno, cell))
values = {k: {x['field']: x['source'] for _, x in v} for k, v in rows.items()}
packet, coverage, callbacks = [], [], []
for case, spec in CASES.items():
    titles, trigger_names, displayed = [], set(), []
    for ci, c in enumerate(tree['conversations']):
        if c['id'] not in spec['conversations']:
            continue
        assert c == other['conversations'][ci]
        titles.append(next(f['value'] for f in c['fields'] if f['title'] == 'Title'))
        packet.append({'caseId': case, 'kind': 'complete-authored-conversation', 'sourcePath': TREE,
                       'otherPhysicalPath': OTHER, 'pointer': f'/conversations/{ci}', 'conversationId': c['id'],
                       'canonicalCompactSha256': sha(compact(c)), 'value': c})
        for ei, e in enumerate(c['dialogueEntries']):
            for fi, f in enumerate(e['fields']):
                logical = f"ds:{c['id']}:{e['id']}:{f['title']}"
                if logical in frozen:
                    assert f['value'] == frozen[logical]['source']
                    displayed.append(logical)
            title = next(f['value'] for f in e['fields'] if f['title'] == 'Title')
            m = re.fullmatch(r'TRIGGER\((.+)\)', title)
            if m:
                trigger_names.add(m[1])
            if title:
                callbacks.append({'caseId': case, 'conversationId': c['id'], 'entryId': e['id'],
                                  'title': title, 'conditionsString': e['conditionsString'],
                                  'userScript': e['userScript'], 'onExecute': e['onExecute'],
                                  'outgoingLinks': e['outgoingLinks']})
    dialogue_rows = {r for (s, r), v in values.items() if s == 'Dialogue' and v.get('plugin_db_name') in titles}
    quest_rows = {values[('Dialogue', r)]['quest'] for r in dialogue_rows} - {None}
    selected = {('InventoryItem', spec['item'])} | {('Dialogue', r) for r in dialogue_rows}
    selected |= {('Quest', r) for r in quest_rows}
    # Direct authored control relationships only. Never recurse through framework callees.
    for (s, r), v in values.items():
        if s == 'Trigger' and v.get('plugin_db_named_trigger') in trigger_names:
            selected.add((s, r))
        if s in ['DialogueAvailabilityRule', 'DialogueStateTrigger']:
            ref = v.get('dialogue_filter')
            refs = ref if isinstance(ref, list) else [ref]
            if dialogue_rows.intersection(refs):
                selected.add((s, r))
    # Include exact directly referenced identities and logs, without expanding unrelated scenes.
    reference_fields = {
        'DialogueAvailabilityRule': {'dialogues_any':'Dialogue','dialogues_all':'Dialogue','items_all':'InventoryItem',
            'items_any':'InventoryItem','triggers_all':'Trigger','triggers_any':'Trigger','tags_all':'Tag','antitags_any':'Tag'},
        'DialogueStateTrigger': {'quest_progress_logs':'QuestProgressLogText','trigger_filter':'Trigger'},
        'Quest': {'initial_progress_log_unlocks':'QuestProgressLogText'},
    }
    for k in list(selected):
        for field, sheet in reference_fields.get(k[0], {}).items():
            refs = values[k].get(field)
            refs = refs if isinstance(refs, list) else [refs]
            selected |= {(sheet, r) for r in refs if r is not None and (sheet, r) in rows}
    for key in sorted(selected):
        packet.append({'caseId':case,'kind':'complete-existing-BG-row','sheet':key[0],'rowId':key[1],
                       'sourcePath':BG,'cells':[{'line':n, **x} for n,x in rows[key]]})
    coverage.append({'caseId':case,'conversationIds':spec['conversations'],'frozenDisplayIds':displayed,
                     'frozenDisplayCount':len(displayed),'selectedBGRowCount':len(selected),
                     'selectedBGCellCount':sum(len(rows[k]) for k in selected),
                     'selectedBGRowIdentities':[list(k) for k in sorted(selected)]})

prior = 'localization/case-decisions/ru-20261029/'
case_ids = set(CASES)
for filename in ['decisions.jsonl', 'source-bindings.jsonl', 'wording-references.jsonl']:
    selected = [x for x in lines(prior + filename) if x['caseId'] in case_ids]
    jl('prior-' + filename, selected)
for row in lines(prior+'wording-references.jsonl'):
    if row['caseId'] not in case_ids:
        continue
    for ref in row['references']:
        matches = [x for x in lines(ref['path']) if x['id'] == ref['targetId']]
        assert len(matches) == 1
        x = matches[0]
        assert sha(x['target'].encode()) == ref['targetUtf8Sha256']
        assert sha(compact(x['source'])) == ref['sourceValueSha256']
        packet.append({'caseId':row['caseId'],'kind':'unchanged-accepted-target-reference',
                       'reference':ref,'value':x})

for path in [
    'AGENTS.md','outputs/ru-item-wordplay-context-20261029/check/brief.md',
    'outputs/ru-item-wordplay-context-20261029/check/dispatch.json',
    'outputs/ru-item-wordplay-context-20261029/check/runtime-verification.json',
    'outputs/ru-item-wordplay-context-20261029/check/runtime-check.json',
    'localization/glossary/inventory-display-20261028/en.json',
    'localization/glossary/inventory-display-20261028/ru.json',
    'localization/glossary/inventory-display-20261028/handoff.json',
    'localization/source/shared-source-completion-20261028/admission-v1/phase134/build_dependencies.py',
    'localization/source/shared-source-completion-20261028/admission-v1/phase134/trigger-key-consumers.il',
    'localization/source/shared-source-completion-20261028/admission-v1/phase134/data-key-consumers.il',
    'localization/source/shared-source-completion-20261028/admission-v1/phase134/haiku-trigger-single.il',
    'localization/source/shared-source-completion-20261028/admission-v1/phase134/haiku-trigger-binding.il',
    'localization/source/shared-source-completion-20261028/admission-v1/phase134/haiku-source-dependencies.json',
    'localization/ru-assets/SOURCE-CONSUMER-RECIPE.md',
    'localization/ru-assets/CONSTRUCTED-LANGUAGE-RECIPE.md',
    'assets/source-v2/string-fields.json','assets/source-v2/textures.json','assets/source-v2/objects.json',
]:
    read(path)
write('selector-spec.json', {'cases':CASES,'boundary':'Selection from existing shared inventory only; no new source extraction or semantic generation.'})
jl('selected-source-context.jsonl', packet)
jl('authored-control-bindings.jsonl', callbacks)
write('selected-coverage.json',coverage)
write('input-pins.json',PINS)
print(json.dumps({'contextRecords':len(packet),'coverage':[{k:v for k,v in c.items() if k not in ['frozenDisplayIds','selectedBGRowIdentities']} for c in coverage]},ensure_ascii=False))
