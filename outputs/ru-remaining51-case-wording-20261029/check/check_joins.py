import json,pathlib,re,hashlib
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest');O=R/'localization/supplemental-ui/20261029-remaining-case51';C=R/'outputs/ru-remaining51-case-wording-20261029/check'
a=[json.loads(l) for l in (O/'ru.prepared.jsonl').open()];t={x['ordinal']:x['target'] for x in a};build=json.loads((R/'localization/previews/ru-20261029-chapter-gallery-02/build.json').read_text());names=[x for x in build['actorDisplayProjection'] if x['field']=='nameplate_name'];fixtures=[]
for i in [25,27]:
 for x in names:
  fixtures.append({'kind':'actual-saved-nameplate-join','ordinal':i,'actorRowId':x['rowId'],'suffix':x['target'],'output':t[i]+x['target'],'contract':'Supplied nominative display label follows colon+space, no case adapter.'})
 fixtures.append({'kind':'unintroduced-actor-join','ordinal':i,'suffix':'???','output':t[i]+'???','contract':'Source-hidden identity is not replaced by known name.'})
for n in [33,36,39,42,45,48]:
 rich,plain,body=t[n],t[n+1],t[n+2];assert re.sub('<[^>]+>','',rich)==plain.upper()
 for i in [23,24]:fixtures.append({'kind':'complete-overlay-output','ordinal':i,'titleOrdinal':n,'output':t[i]+rich})
 for i in [28,29,30]:fixtures.append({'kind':'complete-adventure-notification','ordinal':i,'titleOrdinal':n+1,'output':t[i]+plain})
 fixtures.append({'kind':'complete-adventure-page','titleOrdinal':n,'bodyOrdinal':n+2,'title':rich,'body':body})
for i in [19,20]:
 for zero in [0,1,9,99]:fixtures.append({'kind':'accepted-one-based-identifier','ordinal':i,'index':zero,'output':t[i].format(zero+1),'meaning':'Source branch still adds1; no changed format arg.'})
for n in [0,1,2,5,21,2147483647]:fixtures.append({'kind':'counter-output','ordinal':31,'number':n,'output':t[31]+str(n)})
(O/'assembled-outputs.jsonl').write_text(''.join(json.dumps(f,ensure_ascii=False)+'\n' for f in fixtures))
# Actual source snapshots demonstrate raw Concat; generated fixtures replace game/TMP rendering only.
result={'status':'passed-static-assembly-fixtures','fixtures':len(fixtures),'savedNameplateBindings':len(names),'actorJoinFixtures':2*(len(names)+1),'richPlainPairs':6,'fullOverlayOutputs':12,'adventureNotifications':18,'completePages':6,'oneBasedIdentifiers':8,'counterExamples':6,'boundary':'Source-bound raw Concat/format expectations and complete prepared strings; no game or actual renderer executed. Numbers are examples, not exhaustive Int32 enumeration. Selected saved actor-name bindings plus source ??? branch; no claim about future runtime names.','sha256':hashlib.sha256((O/'assembled-outputs.jsonl').read_bytes()).hexdigest()}
(C/'assembled-output-validation.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))
