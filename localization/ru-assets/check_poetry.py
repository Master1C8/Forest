"""Check and assemble existing model-authored verse; generates no new wording."""
import hashlib, itertools, json, pathlib, re
P=pathlib.Path(__file__).resolve().parent
raw=(P/'dialogue.ru.jsonl').read_bytes()
rows={r['id']:r for r in map(json.loads,raw.decode().splitlines())}
def get(c,e): return re.sub(r'^\[pic[ac]?=[0-9A-Za-z_]+\]','',rows[f'ds:{c}:{e}:Dialogue Text']['target'])
def syllables(s): return len(re.findall('[аеёиоуыэюя]',s.lower()))
checks=[]
for c,e in [(302,516),(302,559),(303,343),(303,350),(303,376)]:
    lines=get(c,e).split('\n'); counts=list(map(syllables,lines))
    assert counts==[5,7,5],(c,e,counts)
    checks.append({'ids':[f'ds:{c}:{e}:Dialogue Text'],'syllables':counts})
for c,ids in [(302,[504,581,580]),(303,[325,326,327]),(303,[406,407,408]),(303,[410,411,412])]:
    counts=[syllables(get(c,e)) for e in ids]; assert counts==[5,7,5],(c,ids,counts)
    checks.append({'ids':[f'ds:{c}:{e}:Dialogue Text' for e in ids],'syllables':counts})
assert get(303,343)==get(303,350)
assert '«Как нам повезло»' in get(303,330)
lines=get(302,516).split('\n')
for e,line in zip([483,484],lines):
    assert get(300,e).strip('"., ')==line.strip('"., ')
assert lines[-1].strip('.').upper() in get(302,520)
combinations=[]
families={325:'bridge',326:'bridge',327:'bridge',406:'penny',407:'penny',408:'penny',410:'bug',411:'bug',412:'bug'}
for ids in itertools.product([325,406,410],[326,407,411],[327,408,412]):
    parts=[get(303,e) for e in ids]; counts=list(map(syllables,parts)); assert counts==[5,7,5]
    cats={families[e] for e in ids}
    combinations.append({'ids':[f'ds:303:{e}:Dialogue Text' for e in ids],'target':'\n'.join(parts),'syllables':counts,'sourceFamilyCombination':next(iter(cats)) if len(cats)==1 else 'mixed'})
report={'status':'passed structural/syllable checks; semantic and independent review pending','overlaySha256':hashlib.sha256(raw).hexdigest(),'checkedPoemGroups':checks,'checkedSelectableCombinations':len(combinations),'callbackEquality':'passed for 300:483/484 and 302:516/520','pronounCorrection':'303:343/350 retain first-person singular; 303:330 proposes first-person plural','combinations':combinations,'limits':['Vowel counts are a syllable check, not poetic or semantic acceptance.','Static combinations are assembled from authored fields; actual game selection, conditions, timing and rendering are not exercised.','No source, links, conditions, executable operands or shared registry changed.']}
(P/'poetry-validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'groups':len(checks),'combinations':len(combinations),'callbacks':'passed','syllables':'passed','overlaySha256':report['overlaySha256']}))
