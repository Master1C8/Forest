"""Two disjoint screenshot review queues; one fresh Sol/high CLI per frame."""
import argparse,hashlib,json,os,shutil,subprocess,sys,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
FAMILY=ROOT/'localization/screenshots/all30-owner-20261104-01'
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def write(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
p=argparse.ArgumentParser(description=__doc__);p.add_argument('locale');p.add_argument('--attempt',default='01');p.add_argument('--execute',action='store_true');a=p.parse_args()
assert a.attempt.isalnum();directory=FAMILY/a.locale/a.attempt;manifest=read(directory/'native-manifest.json');capture=read(directory/'capture.json');assert 1<=len(manifest['images'])<=7
expected_orders=sorted(row['order'] for row in manifest['images']);assert len(set(expected_orders))==len(expected_orders)
doc=read(ROOT/'localization/languages'/(a.locale+'.json'));assert sha(ROOT/'localization/languages'/(a.locale+'.json'))==capture['config']['languageSha256']
gloss=read(ROOT/'localization/glossary'/(a.locale+'.json'))
context=('The Forest of Love0.45, native macOS; publishing/runtime locale '+a.locale+'. '
    'Review only your assigned frame, the whole frame including every visible panel. '
    'Native originals2880x1800; inspect prepared WebP80 at max1280, use source-bound crops/needs-review if unreadable. '
    'Seven-frame complete scene contract:1 main menu;2 settings;3 gallery with original unlocked counters11/11 and46/46;4 actual owned camera inventory;5 Scarlett resident card;6 completed Hot Takes quest including complete history;7 current Maverick dialogue279:144. '
    'The exact same owner save is loaded, with writes structurally disabled only in the isolated copy; no story replay or save modification. '
    'Protected original branding: The Forest of Love, Patreon, TFoL.info, v0.45.1. L/R and other key/controller prompts retain input identity. ??? in undiscovered facts are intentional unknowns. '
    'No blanket exemption for any other English UI, missing glyphs, clipping, isolated letters, overlapping text, unprocessed tags, or OS/Steam overlays. '
    'Do not describe sexual imagery in gallery thumbnails; inspect UI text and layout only. '
    'Independently check fidelity of the two new image-caption labels: Gallery means the scene/illustration gallery; Residents means the forest inhabitants roster, not a renamed species. '
    'Keep all existing dialogue/editorial acceptance separate from this bounded visual and caption-delta check. '
    'For RTL inspect actual word order, joining, paragraph direction/alignment, punctuation and mixed LTR names/counters. Do not infer success from a font or loaded string. '
    'Do not infer that a technical resource receipt or expected string proves visible correctness.\n')
context+='Exact target context: '+json.dumps(dict(camera=capture['config']['cameraTitle'],quest=capture['config']['questTitle'],maverickLine=capture['config']['dialogueTarget'],captions=doc.get('imageCaptions'),captionSizes=doc.get('imageCaptionSizes'),glossary={key:gloss[key] for key in ['tfol-002','tfol-008','tfol-056','tfol-062','tfol-149']}),ensure_ascii=False)+'\n'
facts={'BDSM - Dom','Switch','Interspecies','Town Gossip','Farmer Past','“The Town Mom”','Married'}
resident_context=[dict(id=k,**r) for k,r in doc['translations'].items() if k.startswith('bgdb:resources.assets:320/sheet/l7q0WkqA70qZcKsOchc8NQ/') and r['source'] in facts]
assert len(resident_context)==7
context+='Complete authored facts known in Scarlett fixture (??? elsewhere are undiscovered; complete wording must remain visible): '+json.dumps(resident_context,ensure_ascii=False)+'\n'
run=Path(capture['run']);visible_context={}
for order,prefix in [(1,'Canvas/MainMenu/'),(2,'Canvas/OptionsMenu/'),(3,'Canvas/GalleryMenu/'),(4,None),(6,None)]:
    snapshot=run/('state-before-'+str(order)+'.json')
    if not snapshot.exists():continue
    import base64
    values=set()
    for row in read(snapshot)['texts']:
        path,encoded,*_=row.split('\t')
        if ((prefix and path.startswith(prefix))
            or (order==4 and ('/ItemInfoMultilineFixedWidths/' in path or '/Labels/Inventory/' in path))
            or (order==6 and ('/QuestLog/' in path or '/Labels/QuestLog/' in path))):values.add(base64.b64decode(encoded).decode())
    authored=[]
    for value in sorted(values):
        if not value.strip():continue
        matches=sorted({r['source'] for r in doc['translations'].values() if r['target']==value})
        if matches:authored.append(dict(target=value,sourceVariants=matches))
    visible_context[order]=authored
terminology=FAMILY/'terminology-decisions'/(a.locale+'.json')
if terminology.exists():context+='Exact source/target terminology clarification (assess it; source equality alone proves neither pass nor defect): '+json.dumps(read(terminology),ensure_ascii=False)+'\n'
jobs=[]
for group,orders in [('a',[1,2,3,4]),('b',[5,6,7])]:
    orders=[order for order in orders if order in expected_orders]
    if not orders:continue
    d=directory/('review-'+group);d.mkdir(exist_ok=False);images=d/'input';images.mkdir()
    selected=[row for row in manifest['images'] if row['order'] in orders];assert len(selected)==len(orders)
    for row in selected:
        original=directory/'upload'/row['filename'];assert sha(original)==row['sha256'];os.link(original,images/row['filename'])
    m=dict(manifest);m['scope']='Complete assigned '+group+' partition of seven-frame '+a.locale+' capture';m['images']=selected;m['provenance']=dict(manifest['provenance'],completeCapture=dict(path=str(directory/'native-manifest.json'),sha256=sha(directory/'native-manifest.json')))
    scoped_context={k:v for k,v in visible_context.items() if k in orders}
    write(d/'native-manifest.json',m);(d/'acceptance.txt').write_text(context+'\nExact authored source/target context for assigned menu and quest-detail fields (loaded strings are references, never visual acceptance): '+json.dumps(scoped_context,ensure_ascii=False)+'\n')
    with (d/'init.log').open('wb') as log:
        subprocess.run([sys.executable,'-B',str(ROOT/'tools/review_screenshots.py'),'init','--root',str(images),'--queue',str(d/'queue'),'--review',str(d/'review.json'),'--manifest',str(d/'native-manifest.json'),'--context',str(d/'acceptance.txt'),'--model','gpt-6.1-sol','--reasoning','high'],check=True,stdout=log,stderr=subprocess.STDOUT)
    if a.execute:
        log=(d/'run.log').open('wb');child=subprocess.Popen([sys.executable,'-B',str(ROOT/'tools/review_screenshots.py'),'run','--queue',str(d/'queue'),'--execute','--all'],stdout=log,stderr=subprocess.STDOUT,start_new_session=True);jobs.append((group,d,child,log))
write(directory/'review-launch.json',dict(locale=a.locale,model='gpt-6.1-sol',reasoning='high',provider='openai',freshPerImage=True,maximumConcurrentWorkers=2,execute=a.execute,jobs=[dict(group=g,pid=c.pid,queue=str(d/'queue')) for g,d,c,l in jobs]))
if not a.execute:print('Two disjoint queues prepared; no model request sent');sys.exit(0)
while any(child.poll() is None for _,_,child,_ in jobs):
    states=[]
    for group,d,child,_ in jobs:
        ledger=read(d/'review.json');rows=ledger['images'];done=sum(row.get('reviewer') is not None for row in rows)
        states.append(dict(group=group,reviewed=done,total=len(rows),exitCode=child.poll()))
    write(directory/'review-progress.json',dict(locale=a.locale,groups=states));time.sleep(1)
for _,_,child,log in jobs:log.close()
assert all(child.returncode==0 for _,_,child,_ in jobs),'Review process/transport failed; preserve queues and reconcile before any new submission'
rows=[];usage=[];bindings=[]
for group,d,_,_ in jobs:
    ledger=read(d/'review.json');rows+=ledger['images'];bindings.append(dict(group=group,review=str((d/'review.json').relative_to(ROOT)),sha256=sha(d/'review.json')))
    for p in sorted((d/'queue').glob('attempt-*/usage.json')):
        record=read(p);u=record['usage'];usage.append(dict(group=group,attempt=p.parent.name,sessionId=record['sessionId'],model='gpt-6.1-sol',reasoning='high',**u,total_tokens=u['input_tokens']+u['output_tokens']))
rows.sort(key=lambda r:r['order']);assert [r['order'] for r in rows]==expected_orders
passed=sum(not row['findings'] and all(v in ('passed','not-applicable') for v in row['checks'].values()) for row in rows)
write(directory/'review.json',dict(schemaVersion=1,inputs={'nativeManifest':sha(directory/'native-manifest.json')},partitions=bindings,images=rows))
write(directory/'usage.json',dict(workers=usage,totals={key:sum(r[key] for r in usage) for key in ['input_tokens','cached_input_tokens','output_tokens','total_tokens']}))
total=len(rows);write(directory/'result.json',dict(locale=a.locale,total=total,reviewed=total,passed=passed,failed=total-passed,completeSevenFrameSet=expected_orders==list(range(1,8)),status='passed' if passed==total else 'findings'))
print(json.dumps(dict(locale=a.locale,reviewed=total,passed=passed,failed=total-passed)))
