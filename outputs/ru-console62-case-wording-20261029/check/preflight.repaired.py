import pathlib,json,hashlib,re,copy,sys,itertools,unicodedata,collections
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest');C=ROOT/'outputs/ru-console62-case-wording-20261029/check';O=ROOT/'localization/supplemental-ui/20261029-console-case62';B=ROOT/'localization/source/shared-source-completion-20261028/admission-v1'
def h(b):return hashlib.sha256(b).hexdigest()
def load(p):return json.loads(p.read_text())
def rows(p):return [json.loads(x) for x in p.read_text().splitlines()]
def write(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
def jl(p,v):p.write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in v))
def reject(cond,reason):
 if not cond:raise ValueError(reason)
def fmt_tokens(s):
 out=[];i=0
 while i<len(s):
  if s[i:i+2] in ('{{','}}'):i+=2;continue
  if s[i]=='{':
   m=re.match(r'\{(\d+)(?:,(-?\d+))?(?::([^{}]+))?\}',s[i:]);reject(m is not None,'malformed-format');out.append(m[0]);i+=len(m[0]);continue
  reject(s[i]!='}','malformed-format');i+=1
 return out
def fmt(s,*a):
 fmt_tokens(s)
 def sub(m):
  ix=int(m[1]);reject(ix<len(a),'missing-format-argument');val=str(a[ix]);w=m[2]
  if w:val=val.ljust(abs(int(w))) if int(w)<0 else val.rjust(int(w))
  return val
 return re.sub(r'\{(\d+)(?:,(-?\d+))?\}',sub,s)
a=rows(C/'assigned.jsonl');ctx=rows(C/'context110.jsonl');ledger=rows(B/'managed-literal-inventory.jsonl');dm={r['bindingId']:r for r in ctx};assigned={r['bindingId'] for r in a};sc=rows(O/'source-context.jsonl');base_protected=rows(O/'protected-controls.jsonl');base_ext=rows(O/'protected-external-identities.jsonl');targets=rows(O/'ru.prepared.jsonl');pins=load(O/'input-pins.json')['files']
for p,digest in pins.items():reject(h((ROOT/p).read_bytes())==digest,'changed-input:'+p)
for r in sc:
 t=ledger[r['typedLedger']['line']-1];reject(t==r['typedRecord'],'changed-exact-typed-row');reject(h(json.dumps(r['source'],ensure_ascii=False).encode())==r['sourceValueSha256'],'source-value-hash-convention')

def validate(ts,ps,es):
 ids=[r['bindingId'] for r in ts];reject(len(ids)==len(set(ids)),'duplicate-target-id');reject(ids==[r['bindingId'] for r in a],'assigned-id-order-coverage')
 reject([r['bindingId'] for r in ps]==[r['bindingId'] for r in ctx if r['bindingId'] not in assigned],'protected-context-coverage')
 for r in ps:
  src=dm[r['bindingId']];reject(r['source']==src['source'] and r['preservedValue']==src['source'],'protected-context-value');reject(r['currentRole']==src['currentRole'],'protected-context-role');reject(r['sourceValueSha256']==src['sourceValueSha256'],'protected-source-hash')
 reject([r['bindingId'] for r in es]==[r['bindingId'] for r in base_ext],'external-identity-coverage')
 for r,e in zip(es,base_ext):reject(r==e,'external-identity-value')
 for r,s in zip(ts,a):
  reject(r['bindingId'] in assigned,'unassigned-target');reject(all(r[k]==s[k] for k in s),'source-record-changed');reject(r['locale']=='ru','locale');reject(r['status']=='prepared-conditional' and r['targetApplied'] is False,'application-or-gate-promotion');t=r['target'];reject(isinstance(t,str) and len(t)>0,'missing-target');reject(unicodedata.normalize('NFC',t)==t,'non-nfc-target');reject(fmt_tokens(s['source'])==fmt_tokens(t),'format-slots');reject(t.count('\n')==s['source'].count('\n') and t.count('\r')==s['source'].count('\r'),'newline-control');reject(not any(ord(c)<32 for c in t),'unexpected-control');reject(h(t.encode())==r['targetSha256'],'target-hash')
 return True
validate(targets,base_protected,base_ext)
# Execute declared concatenations/Format assemblies over immutable wording; this is a
# Python string model of the read IL, not CLR, lookup/state execution, or rendering.
source={r['bindingOrdinal']:r['source'] for r in ctx};target=dict(source);target.update({r['bindingOrdinal']:r['target'] for r in targets});cases=[]
def add(name,ns,op,args,predicate,sink,expected,source_args=None):
 def render(values,actual_args):
  if op=='concat':return ''.join(values[x] if isinstance(x,int) else x for x in ns)
  return fmt(values[ns[0]],*actual_args)
 sv=render(source,source_args if source_args is not None else args);tv=render(target,args);reject(tv==expected,'joined-output:'+name)
 cases.append({'case':name,'ordinals':[x for x in ns if isinstance(x,int)],'expression':ns,'operation':op,'arguments':args,'sourceArguments':source_args if source_args is not None else args,'predicate':predicate,'sink':sink,'sourceOutput':sv,'targetOutput':tv,'expectedTarget':expected,'boundary':'static assembly fixture; dynamic identities below are synthetic canaries, not observed gameplay'})
for n,suffix,cat in [(1,2,'диалогов'),(35,36,'диалогов'),(49,50,'заданий'),(75,76,'предметов'),(80,81,'глав')]:add('rank-header-'+str(n),[n,'10',suffix],'concat',[],'nonblank query; source limit10','DevConsole.LogWarning','Лучшие 10 совпадений среди '+cat+':')
# Exact per-occurrence prefix joins. Synthetic values deliberately contain punctuation
# or non-name forms so a target cannot rely on Russian noun/actor inflection.
prefix_specs=[(5,'42','Не удалось найти диалог 42'),(6,'42 - system/testconvo','Сведения о диалоге 42 - system/testconvo'),(27,'42','Не удалось воспроизвести диалог 42'),(28,'42','Не удалось воспроизвести диалог 42'),(29,'42','Не удалось найти диалог 42'),(30,'42','Завершён диалог с ID 42'),(31,'42','Сброшен диалог с ID 42'),(32,'42','Не удалось сбросить диалог с ID 42'),(41,'42','Не удалось найти диалог 42'),(44,'date/key-A','Отладочное свидание: date/key-A'),(53,'7','Не удалось найти задание 7'),(54,'7 - quest/key-A','Сведения о задании 7 - quest/key-A'),(61,'7','Не удалось найти задание 7'),(62,'7','Завершено задание с ID 7'),(63,'7','Не удалось найти задание 7'),(64,'7','Сброшено задание с ID 7'),(67,'item/key-A','Неизвестный тип предмета: item/key-A'),(69,'item/key-A','У игрока есть предмет: item/key-A'),(70,'item/key-A','У игрока нет предмета: item/key-A'),(71,'item/key-A','Неизвестный тип предмета: item/key-A'),(73,'item/key-A','Неизвестный тип предмета: item/key-A'),(83,'chapter/key-A','Не удалось найти главу: chapter/key-A'),(105,'trigger/key-A','Установлен триггер: trigger/key-A'),(106,'trigger/key-A','Сброшен триггер: trigger/key-A')]
for n,key,expected in prefix_specs:
 group=next(r for r in sc if r['bindingOrdinal']==n);add('prefix-'+str(n),[n,key],'concat',[key],group['assemblyContract'],'UI.Text.set_text' if n==44 else 'DevConsole; exact method/severity in source-context',expected)
add('date-not-date',[42,'42',43],'concat',['42'],'existing dialogueType!=500','DevConsole.LogError','Диалог 42 не является диалогом свидания')
for n,args,expected in [(10,['Quest','quest/key-A','Completed'],'тип: Quest (quest/key-A, Completed)'),(12,['Manual'],'тип: Manual'),(14,['Ready'],'статус: Ready'),(16,['Actor/Unknown'],'основной персонаж: Actor/Unknown'),(18,['Actor/Unknown'],'первый персонаж: Actor/Unknown'),(58,['Ready'],'статус: Ready'),(60,[3,7],'выполнено шагов: 3 из 7')]:add('format-'+str(n),[n],'format',args,'exact typed producer branch/arguments in source-context','DevConsole.Log',expected)
for n,text in [(20,'именованные ветви:'),(23,'именованные триггеры:')]:add('named-heading-'+str(n),['    ',n],'concat',[],'named list nonempty; trigger subtype exact','DevConsole.Log','    '+text)
for n,status in [(25,'готов'),(26,'сработал')]:add('named-trigger-'+str(n),['        trigger/key-A (',n,')'],'concat',['trigger/key-A'],'IsTriggerFired='+str(n==26),'DevConsole.Log','        trigger/key-A ('+status+')')
for status,n in [('inactive',107),('active',108),('missing',None)]:
 seq=[109,'trigger/key-A',110]+([n] if n else [])
 expected='Триггер trigger/key-A: '+({'inactive':'не установлен','active':'установлен','missing':''}[status]);add('trigger-info-'+status,seq,'concat',['trigger/key-A'],'trigger '+status,'DevConsole.LogWarning',expected)
# All actor/null and six+empty tag-caption branches, and 128 subsets of seven
# filter identities in canonical order. Arbitrary query orders/contents and actor
# keys remain unbounded; these checks make no exhaustive runtime assertion.
type_names=[r['source'] for r in ctx if r['currentRole']=='preserve-visible-filter-identity'];reject(len(type_names)==7,'type-name-count')
statcount=0;statdigest=hashlib.sha256()
for actor in ['Actor/Unknown',None]:
 for tag in [None,91,92,93,94,95,96]:
  for mask in range(128):
   original_caption='';localized_caption=''
   for i,name in enumerate(type_names):
    if mask&(1<<i):original_caption=fmt(source[101],original_caption,name);localized_caption=fmt(target[101],localized_caption,name)
   raw_actor=actor or source[98];ru_actor=actor or target[98];raw_tag=source[tag] if tag else '';ru_tag=target[tag] if tag else ''
   so=fmt(source[97],raw_actor,(' '+raw_tag) if raw_tag else '',(' '+original_caption) if original_caption else '')
   to=fmt(target[97],ru_actor,(' '+ru_tag) if ru_tag else '',(' '+localized_caption) if localized_caption else '')
   expected='Статистика: '+ru_actor+((' '+ru_tag) if ru_tag else '')+((' '+localized_caption) if localized_caption else '');reject(to==expected,'stats-header-join')
   reject([x for i,x in enumerate(type_names) if mask&(1<<i)]==re.findall(r' & тип ([^&]+?)(?= & тип |$)',localized_caption),'stats-filter-identity')
   statdigest.update(json.dumps([so,to],ensure_ascii=False).encode()+b'\n');statcount+=1
for n,actor_n,tag_n in [(97,98,91),(102,103,96)]:
 tag=target[tag_n];actor=target[actor_n]
 args=[actor,' '+tag,' '+fmt(target[101],'',type_names[0])] if n==97 else [actor,tag]
 expected='Статистика: все персонажи в акте 1  & тип quest' if n==97 else 'Статистика: все персонажи во всех разделах'
 source_args=[source[actor_n],' '+source[tag_n],' '+fmt(source[101],'',type_names[0])] if n==97 else [source[actor_n],source[tag_n]]
 add('stats-display-'+str(n),[n],'format',args,'actor null; exact tag/type caption path','DevConsole.LogWarning',expected,source_args=source_args)
# Explicit tag/fallback/recursive fragments are covered by the matrix; bind them to
# its digest instead of pretending individual fragments were unrelated sentences.
covered=set(x for c in cases for x in c['ordinals'])|{91,92,93,94,95,96,97,98,101,102,103}
reject({r['bindingOrdinal'] for r in a}<=covered,'joined-target-coverage')
jl(O/'assembly-fixtures.jsonl',cases)
regress=[]
def neg(name,reason,mut):
 ts=copy.deepcopy(targets);ps=copy.deepcopy(base_protected);es=copy.deepcopy(base_ext);mut(ts,ps,es)
 try:validate(ts,ps,es)
 except ValueError as exc:reject(str(exc)==reason,'wrong-negative-boundary:'+name+':'+str(exc))
 else:raise ValueError('negative-accepted:'+name)
 validate(targets,base_protected,base_ext);regress.append({'case':name,'expectedRejection':reason,'observedRejection':reason,'matchingPositive':'actual unchanged full62/48/120 packet passes','result':'passed'})
neg('missing62nd-target','assigned-id-order-coverage',lambda t,p,e:t.pop())
neg('duplicate-existing-ID','duplicate-target-id',lambda t,p,e:t.append(copy.deepcopy(t[0])))
neg('changed-original-source','source-record-changed',lambda t,p,e:t[0].update(source='Top '))
neg('lost-format-argument','format-slots',lambda t,p,e:next(r for r in t if r['bindingOrdinal']==60).update(target='выполнено шагов: {0}'))
neg('swapped-slot-identity','format-slots',lambda t,p,e:next(r for r in t if r['bindingOrdinal']==60).update(target='выполнено шагов: {1} из {0}'))
neg('translated-protected-filter','protected-context-value',lambda t,p,e:next(r for r in p if r['bindingOrdinal']==84).update(preservedValue='задание'))
neg('changed-protected-padding','protected-context-value',lambda t,p,e:p[0].update(preservedValue='{0,5}'))
neg('dropped-protected48th','protected-context-coverage',lambda t,p,e:p.pop())
neg('translated-command-namespace','external-identity-value',lambda t,p,e:e[0].update(preservedValue='диалог'))
neg('translated-scene-identity','external-identity-value',lambda t,p,e:next(r for r in e if r['contract']=='simulation-scene-state-and-label').update(preservedValue='лес'))
neg('target-applied-claim','application-or-gate-promotion',lambda t,p,e:t[0].update(targetApplied=True))
neg('target-hash-mismatch','target-hash',lambda t,p,e:t[0].update(targetSha256='0'*64))
neg('injected-newline','newline-control',lambda t,p,e:t[0].update(target=t[0]['target']+'\n'))
# Join-specific negative changes only the last protected separator of a selected
# word operand; all unrelated parse/ID/format guards are first satisfied.
bad=copy.deepcopy(targets);bad[0]['target']='Лучшие';bad[0]['targetSha256']=h(bad[0]['target'].encode());validate(bad,base_protected,base_ext)
def validate_join(ts,case):
 vals=dict(source);vals.update({r['bindingOrdinal']:r['target'] for r in ts})
 out=''.join(vals[x] if isinstance(x,int) else x for x in case['expression']) if case['operation']=='concat' else fmt(vals[case['expression'][0]],*case['arguments'])
 reject(out==case['expectedTarget'],'joined-output:'+case['case'])
validate_join(targets,cases[0])
try:validate_join(bad,cases[0])
except ValueError as exc:reject(str(exc)=='joined-output:rank-header-1','wrong-join-negative-boundary')
else:raise ValueError('join-negative-accepted')
regress.append({'case':'lost-prefix-boundary-space','expectedRejection':'joined-output:rank-header-1','observedRejection':'joined-output:rank-header-1','matchingPositive':cases[0]['targetOutput'],'result':'passed; generic schema intentionally passes before join boundary rejects'})
reject(h(json.dumps('top ',ensure_ascii=False).encode())==a[0]['sourceValueSha256'] and h('top '.encode())!=a[0]['sourceValueSha256'],'source-hash-positive-control')
regress.append({'case':'source-hash-convention','result':'passed','fact':'SourceValueSha256 hashes JSON string representation; raw UTF8 digest is a separate field. Initial helper assertion corrected before target authoring.'})
for r in targets:reject(h(r['target'].encode())==r['targetSha256'],'final-target-hash')
jl(O/'preflight-regressions.jsonl',regress)
report={'status':'passed','assigned':62,'target':62,'protectedContext':48,'contextTotal':110,'wholeProducerGroups':32,'assignedProducerGroups':25,'commandNamespaces':103,'sceneIDs':17,'typeNameFilters':7,'inputPinsChecked':len(pins),'exactTypedRows':110,'staticAssemblyFixtures':len(cases),'staticStatsCombinationFixtures':statcount,'statsFixtureDigest':statdigest.hexdigest(),'targetOrdinalsCovered':sorted(r['bindingOrdinal'] for r in targets),'negativeControls':len(regress)-1,'hashConventionRegression':True,'protectedValuesExact':True,'formatGrammar':'Full finite composite-format scanner; exact index/alignment/format sequence comparison, not token presence only','limitations':['Python String.Format/Concat model checks the declared source-derived assembly contract; CLR is not executed.','Stats128 membership subsets use canonical type order; arbitrary caller query orders, all dynamic values, native log presentation and actual eligibility remain open.','No lookup, state transition, rendering, font, package or runtime acceptance.'],'runtime':'not-run','independentReview':'pending','targetApplied':False,'ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False}
phase=sys.argv[1] if len(sys.argv)>1 else 'final';write(O/('preflight.'+phase+'.json'),report);print(json.dumps(report,ensure_ascii=False,indent=2))
