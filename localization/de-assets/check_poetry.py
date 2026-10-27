"""Validate directly authored German verse and static combinations; no wording generation.

Syllable segmentation is declared by the author, then bound to actual target bytes.
This checks segmentation consistency, not independent pronunciation or semantic acceptance.
"""
import hashlib, itertools, json, pathlib, re
HERE=pathlib.Path(__file__).resolve().parent
raw=(HERE/'dialogue.de.jsonl').read_bytes()
rows={r['id']:r for r in map(json.loads,raw.decode().splitlines())}
def get(c,e):
    return re.sub(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*','',rows[f'ds:{c}:{e}:Dialogue Text']['target'])
def letters(s):
    return ''.join(c.lower() for c in s if c.isalpha())
# Each slash separates one spoken syllable. No target wording is inferred here.
scans={
 '302:516':['Dein/Hin/tern/spru/delt','Saft/rinnt/dir/die/Bei/ne/lang','Tränkt/den/Erd/bo/den'],
 '302:559':['Ihr/zar/tes/Le/cken','Putzt/mei/ne/Sau/e/rei/weg','Ich/bin/wie/der/steif'],
 '303:343':['Gut’/Freun/de/gut’/Trank','An/dem/trä/gen/Nach/mit/tag','Wie/glück/lich/bin/ich'],
 '303:350':['Gut’/Freun/de/gut’/Trank','An/dem/trä/gen/Nach/mit/tag','Wie/glück/lich/bin/ich'],
 '303:376':['Für/im/mer/vo/ran','Ein/Weg/der/kein/En/de/kennt','Der/flie/ßen/de/Fluss'],
 '302:504':['Zwei/schö/ne/Da/men'],
 '302:581':['Mit/ei/nem/statt/li/chen/Hengst'],
 '302:580':['Es/ist/Paa/rungs/zeit'],
 '303:325':['Wir/form/ten/den/Grund'],
 '303:326':['Ü/ber/die/rei/ßen/de/Flut'],
 '303:327':['Uns/re/Freund’/ver/eint'],
 '303:406':['O/schö/ne/Fal/kin'],
 '303:407':['Trag/mich/hoch/ü/bers/Ge/wölk'],
 '303:408':['Wo/noch/nie/mand/war'],
 '303:410':['Re/ges/Kä/fer/lein'],
 '303:411':['Was/ist/dir/wirk/lich/wich/tig'],
 '303:412':['Wa/rum/jetzt/schuf/ten']}
# Accepted-version maintenance is explicit and exact, never a permissive fallback.
provenance=json.loads((HERE/'poetry-scansion-provenance.json').read_text())
assert provenance['schemaVersion']==1 and provenance['locale']=='de'
for fact in provenance['sourceFacts']:
    r=rows[fact['id']]
    assert r['source']==fact['source'],(fact['id'],'poetry source changed')
    assert r['target']==fact['target'],(fact['id'],'accepted poetry target changed')
    assert hashlib.sha256(r['source'].encode()).hexdigest()==fact['sourceSha256']
    assert hashlib.sha256(r['target'].encode()).hexdigest()==fact['targetSha256']
assert scans['303:411']==provenance['maintenance']['newScansion']
checked={}
for key,scan in scans.items():
    c,e=map(int,key.split(':'));lines=get(c,e).split('\n')
    assert len(lines)==len(scan),(key,'line count')
    for text,segmented in zip(lines,scan):
        assert letters(text)==letters(segmented),(key,text,segmented)
    checked[key]={'lines':lines,'declaredSyllables':scan,'counts':[len(s.split('/')) for s in scan],'targetSha256':rows[f'ds:{c}:{e}:Dialogue Text']['targetSha256']}
checks=[]
for key in ['302:516','302:559','303:343','303:350','303:376']:
    assert checked[key]['counts']==[5,7,5],key
    checks.append({'keys':[key],'syllables':[5,7,5]})
for c,ids in [(302,[504,581,580]),(303,[325,326,327]),(303,[406,407,408]),(303,[410,411,412])]:
    keys=[f'{c}:{e}' for e in ids];counts=[checked[k]['counts'][0] for k in keys]
    assert counts==[5,7,5],keys
    checks.append({'keys':keys,'syllables':counts})
assert get(303,343)==get(303,350),'Repeated poem differs'
assert get(303,343).split('\n')[-1]=='Wie glücklich bin ich'
assert '„Wie glücklich sind wir“' in get(303,330),'Singular-to-plural correction missing'
assert len('Wie/glück/lich/sind/wir'.split('/'))==5
for e,line in zip([483,484],get(302,516).split('\n')):
    assert get(300,e).strip('„“')==line,(300,e,'callback differs')
assert get(302,516).split('\n')[-1].upper() in get(302,520)
families={325:'bridge',326:'bridge',327:'bridge',406:'penny',407:'penny',408:'penny',410:'bug',411:'bug',412:'bug'}
combinations=[]
for ids in itertools.product([325,406,410],[326,407,411],[327,408,412]):
    keys=[f'303:{e}' for e in ids];counts=[checked[k]['counts'][0] for k in keys]
    assert counts==[5,7,5]
    cats={families[e] for e in ids}
    combinations.append({'ids':[f'ds:303:{e}:Dialogue Text' for e in ids],'target':'\n'.join(get(303,e) for e in ids),'syllables':counts,'family':next(iter(cats)) if len(cats)==1 else 'mixed'})
assert len(combinations)==27
report={'status':'passed declared-scansion, structure and static callback checks; semantic/independent/runtime acceptance pending','locale':'de','overlaySha256':hashlib.sha256(raw).hexdigest(),'scansion':checked,'poemGroups':checks,'combinations':combinations,'selectableCombinationCount':len(combinations),'callbackEquality':'passed: 300:483/484 to 302:516, and 302:516 to 302:520','personCorrection':'303:343/350 stay first-person singular; 303:330 proposes first-person plural','limits':['The author supplied syllable divisions; this is no independent phonological or semantic review.','Poetic apocope in 303:343/350 and 303:327 is deliberate and must remain audible as declared.','All 27 static line combinations checked; real selection, timing, display, branching and resource binding not exercised.','No source, scene links, runtime commands or shared registry modified.']}
report['acceptedVersionProvenance']={'path':'poetry-scansion-provenance.json','sha256':hashlib.sha256((HERE/'poetry-scansion-provenance.json').read_bytes()).hexdigest(),'scope':'Exact source/target facts and declared scansion; independent receipt applicability is checked separately.'}
(HERE/'poetry-validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'status':'passed','poemGroups':len(checks),'combinations':len(combinations),'callbacks':'passed','overlaySha256':report['overlaySha256']}))
