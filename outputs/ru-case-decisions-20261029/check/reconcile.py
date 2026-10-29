"""Exact joins only. Semantic case decisions are separately authored, never generated here."""
import collections
import hashlib
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CHECK = ROOT / 'outputs/ru-case-decisions-20261029/check'
OUT = ROOT / 'localization/case-decisions/ru-20261029'
BASE = 'localization/source/shared-source-completion-20261028/admission-v1/'
PINS = {}

def digest(b):
    return hashlib.sha256(b).hexdigest()

def value_hash(s):
    return digest(json.dumps(s, ensure_ascii=False, separators=(',', ':')).encode())

def read(path):
    p = Path(path)
    if not p.is_absolute():
        p = ROOT / p
    b = p.read_bytes()
    PINS[str(p.relative_to(ROOT)) if p.is_relative_to(ROOT) else str(p)] = {'sha256': digest(b), 'bytes': len(b)}
    return b.decode()

def js(path):
    return json.loads(read(path))

def jl(path):
    return [json.loads(x) for x in read(path).splitlines() if x]

def write(path, obj):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + '\n')

def lines(path, rows):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(''.join(json.dumps(x, ensure_ascii=False, separators=(',', ':')) + '\n' for x in rows))

def build():
    registry = js(BASE + 'special-cases.json')
    roles = {}
    for name in ['serialized-inventory.jsonl', 'bgdatabase-inventory.jsonl', 'managed-literal-inventory.jsonl', 'frozen-dialogue-bindings.jsonl']:
        for n, r in enumerate(jl(BASE + name), 1):
            assert r['id'] not in roles
            roles[r['id']] = (r, BASE + name, n)
    for n, r in enumerate(jl(BASE + 'dialogue-database-values.jsonl'), 1):
        for oid in r['occurrences']:
            roles[oid] = (r, BASE + 'dialogue-database-values.jsonl', n)
    raw = {}
    for r in jl('outputs/pause-inventory-bio-completion-20261028/serialized-nondialogue-roster.jsonl'):
        raw[r['id']] = r['value']
    for r in jl('localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl'):
        raw[r['id']] = r['source']
    for r in jl('outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl'):
        raw['il:Assembly-CSharp.dll/'+r['method']+'/IL_'+format(r['offset'],'04x')] = r['value']
    for r, _, _ in roles.values():
        if 'source' in r:
            if 'id' in r:
                raw[r['id']] = r['source']
            for oid in r.get('occurrences', []):
                raw[oid] = r['source']
    source = {}
    for name in ['source-selector-reconciliation.jsonl', 'compiled-display-reconciliation.jsonl']:
        for r in jl('outputs/ru-completion-reconciliation-20261028/check/' + name):
            source[r['id']] = r
    packets = {
        'ui935': 'localization/supplemental-ui/20261029-existing935/ru.edited.jsonl',
        'inventory52': 'localization/supplemental-ui/20261028-inventory/ru.edited.jsonl',
        'chapter134': 'localization/supplemental-ui/20261029-chapter-gallery-case/ru.edited.jsonl',
        'glitch2': 'localization/supplemental-ui/20261028-glitch/ru.jsonl',
        'dialogue12246': 'localization/ru-assets/dialogue.ru.jsonl',
    }
    targets = collections.defaultdict(list)
    for packet, path in packets.items():
        seen = set()
        for n, r in enumerate(jl(path), 1):
            assert r['id'] not in seen
            seen.add(r['id'])
            targets[r['id']].append({'packet': packet, 'path': path, 'line': n, 'targetId': r['id'], 'sourceValueSha256': value_hash(r['source']), 'targetUtf8Sha256': digest(r['target'].encode()), 'source': r['source'], 'target': r['target']})
    for a in js(BASE + 'old935-selector-bindings.json'):
        if a['valueMatches'] and a['id'] in targets:
            for t in list(targets[a['id']]):
                if t['packet'] == 'ui935' and a['id'] != a['sourceId']:
                    targets[a['sourceId']].append(dict(t, join='old935-exact-source-selector-alias'))
    narrative = {}
    for n, r in enumerate(jl('outputs/narrative-reuse-review-20261029/check/reuse-review.jsonl'), 1):
        for oid in r['occurrenceIds']:
            narrative[oid] = {'path': 'outputs/narrative-reuse-review-20261029/check/reuse-review.jsonl', 'line': n, 'pageId': r['pageId'], 'candidateDialogueIds': r['candidateDialogueIds'], 'review': {k:v for k,v in r.items() if k not in ['source','occurrenceIds','existingTargets','sourceContext','context']}}
    rows = []
    for c in registry['cases']:
        for ordinal, b in enumerate(c['sourceBindings'], 1):
            typed = roles.get(b['id'])
            ts = [t for t in targets[b['id']] if t['sourceValueSha256'] == b['sourceValueSha256']]
            row = {'caseId':c['id'], 'bindingOrdinal':ordinal, 'bindingId':b['id'], 'sourceValueSha256':b['sourceValueSha256'], 'registryRole':b['role'], 'currentRole':typed[0]['role'] if typed else None, 'typedLedger':{'path':typed[1],'line':typed[2]} if typed else None, 'typedHashMatches':typed[0]['sourceValueSha256']==b['sourceValueSha256'] if typed else False, 'rawValueHashMatches':b['id'] in raw and value_hash(raw[b['id']])==b['sourceValueSha256'], 'source':raw.get(b['id']), 'wordingReferences':[{k:v for k,v in t.items() if k not in ['source','target']} for t in ts], 'narrativeCompatibility':narrative.get(b['id']), 'disposition':'exact-current-target;case-contract-still-required' if ts else 'typed-role;no-exact-current-target' if typed else 'missing-typed-binding'}
            rows.append(row)
    lines(CHECK/'binding-draft.jsonl', rows)
    write(CHECK/'initial-input-pins.json', PINS)
    for c in registry['cases']:
        rr = [r for r in rows if r['caseId']==c['id']]
        print(c['id'],len(rr),'typed',sum(x['typedHashMatches'] for x in rr),'targets',sum(bool(x['wordingReferences']) for x in rr), 'roles',dict(collections.Counter(x['currentRole'] for x in rr)))
    return registry, roles, source, targets, narrative, rows

if __name__ == '__main__':
    build()
