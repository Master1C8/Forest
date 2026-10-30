#!/usr/bin/env python3
"""Freeze a reviewed locale instance of the existing haiku identity resource.

No game patch input is admitted. Original CIL is read with Cecil, never loaded.
The upstream AddHelpers/Fixture/Test implementation is reused with explicit
locale/map parameters; only extracted isolated fixtures are saved/executed.
"""
import argparse
import collections
import copy
import difflib
import hashlib
import itertools
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CONTEXT = 'oliver_coyotes_date2_haiku_finish'
ORIGINAL = '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
SLOTS = [[325, 410, 406], [326, 411, 407], [327, 412, 408]]

def sha(p): return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def utf(s): return hashlib.sha256(s.encode()).hexdigest()
def read(p): return json.loads(Path(p).read_text())
def rows(p): return [json.loads(s) for s in Path(p).read_text().splitlines() if s]
def need(v, s):
    if not v: raise ValueError(s)
def write(p, j): Path(p).write_text(json.dumps(j, ensure_ascii=False, indent=2) + '\n')
def jsonl(p, rs): Path(p).write_text(''.join(json.dumps(r, ensure_ascii=False) + '\n' for r in rs))
def unique(rs):
    need(len(rs) == len({r['id'] for r in rs}), 'duplicate-id')
    return {r['id']: r for r in rs}

def validate(plan, expected):
    need(plan.get('locale') == expected['locale'], 'explicit-locale')
    need(plan.get('context') == CONTEXT, 'wrong-context')
    choices = plan.get('choices', [])
    need(len(choices) == 9, 'exact-nine-choices')
    unique(choices)
    need([[int(c['id'].split(':')[2]) for c in choices if c['slot'] == s] for s in [1,2,3]] == SLOTS, 'slot-identity')
    for s in [1,2,3]:
        need(len({c['target'] for c in choices if c['slot'] == s}) == 3, 'ambiguous-slot-labels')
    for c in choices:
        need(c['conversationId'] == 303 and c['context'] == CONTEXT, 'choice-context')
        need(c['sourceSha256'] == utf(c['source']) and c['targetSha256'] == utf(c['target']), 'text-hash')
        need(c == next(e for e in expected['choices'] if e['id'] == c['id']), 'accepted-choice-version')
    need(plan == expected, 'accepted-resource-version')

def derive(inp, locale):
    manifest = read(inp / 'manifest.json')
    need(locale == manifest['locale'], 'explicit-locale')
    for name, pin in manifest['files'].items():
        need(sha(inp / name) == pin['sha256'], 'input-pin:' + name)
    need(sha(inp / 'original.dll') == ORIGINAL, 'original-source-version')
    if manifest.get('bindingMode') == 'unchanged-retained-literary-v1':
        return derive_retained(inp, locale)
    request, deps, context = [read(inp / n) for n in ['request.json', 'dependencies.json', 'context.json']]
    need(request['locale'] == locale, 'request-locale')
    need(sha(inp / 'context.json') == deps['contextSha256'], 'source-context-version')
    need(request['affectedIds'] == deps['sourceIds'], 'complete-request-scope')
    basis = unique(rows(inp / 'basis.jsonl'))
    need(set(basis) == set(request['affectedIds']) and len(basis) == 194, 'complete-194-basis')
    old = unique(rows(inp / 'prior-reviews.jsonl'))
    delta = unique(rows(inp / 'delta-reviews.jsonl'))
    retained = read(inp / 'retention.json')
    need(set(retained['retainedMatchingIds']) == set(basis) - set(delta) and set(delta) == {'ds:303:327:Dialogue Text'}, 'exact-retention')
    need(retained['count'] == 193 and sha(inp / 'prior-reviews.jsonl') == retained['priorReviews']['sha256'], 'retention-version')
    reviews = {i: old[i] for i in retained['retainedMatchingIds']}
    reviews.update(delta)
    for i, r in basis.items():
        evidence = reviews[i]
        need(evidence['verdict'] == 'pass' and evidence.get('reviewed') is not False, 'unreviewed-version:' + i)
        need(all(r[k+'Sha256'] == utf(r[k]) == evidence[k+'Sha256'] for k in ['source','target']), 'review-version:' + i)
    update = read(inp / 'version-update.json')
    need(basis[update['id']]['targetSha256'] == update['targetSha256'], 'superseding-choice')
    need(next(c for c in request['choiceVersions'] if c['id'] == update['id'])['targetSha256'] == update['priorTargetSha256'], 'request-prior-version')
    nodes = {(n['conversationId'], n['entryId']): n for n in context['nodes']}
    accepted = []
    for slot, group in enumerate(deps['choiceSlots'], 1):
        for i in group:
            r = basis[i]; n = nodes[303, int(i.split(':')[2])]
            f = {x['title']:x['value'] for x in n['fields']}
            need(f['Dialogue Text'] == r['source'] and f['Menu Text'] == '', 'choice-source-display')
            need(not n['conditionsString'] and not n['userScript'] and not n['onExecute']['m_PersistentCalls']['m_Calls'], 'choice-control')
            need(len(n['outgoingLinks']) == 1 and n['outgoingLinks'][0]['destinationDialogueID'] == {1:404,2:413,3:416}[slot], 'choice-successor')
            old_choice = next(c for c in request['choiceVersions'] if c['id'] == i)
            need(old_choice['sourceSha256'] == r['sourceSha256'] and (i == update['id'] or old_choice['targetSha256'] == r['targetSha256']), 'request-version-reconciliation')
            accepted.append(dict(id=i, slot=slot, conversationId=303, context=CONTEXT, source=r['source'],target=r['target'],sourceSha256=r['sourceSha256'],targetSha256=r['targetSha256'],acceptedVerdict='pass',producerTrigger=CONTEXT.replace('finish','line'+str(slot)),destination=n['outgoingLinks'][0],occurrences=r['occurrences']))
    for t in deps['triggerSuccessors']:
        n=nodes[303,t['triggerEntry']];f={x['title']:x['value'] for x in n['fields']}
        need(f['Title'] == 'TRIGGER('+t['triggerName']+')' and n['outgoingLinks'][0]['destinationDialogueID'] == t['successor'], 'trigger-successor')
    shared = read(inp / 'shared-map.json')
    need(deps['branchContracts'] == shared['branchContracts'] and deps['triggerSuccessors'] == shared['triggerSuccessors'], 'shared-consumer-contract')
    for branch in deps['branchContracts'] + [deps['defaultBranch']]:
        n=nodes[303,branch['namedEntry']]
        need(next(f['value'] for f in n['fields'] if f['title']=='Title') == branch['arc'], 'named-arc')
    # Reuse the owning full poem contexts, superseding only exact delta versions.
    poems = unique(rows(inp / 'poem-context-original.jsonl'))
    updates = unique(rows(inp / 'poem-context-delta.jsonl'))
    judgments = unique(rows(inp / 'poem-delta-judgments.jsonl'))
    need(set(updates) == set(judgments) and len(updates) == 10, 'complete-poem-delta')
    for ident, row in updates.items():
        j=judgments[ident]
        need(j['verdict']=='pass' and all(j[k+'Sha256']==row[k+'Sha256']==utf(row[k]) for k in ['source','target']), 'poem-delta-version')
        need(poems[ident]['targetSha256'] == row['priorTargetSha256'], 'poem-prior-version')
    poems.update(updates)
    products=[r for r in poems.values() if r['kind']=='assembled-choice-poem']
    need(len(products)==27 and {tuple(r['unitIds']) for r in products}==set(itertools.product(*deps['choiceSlots'])), 'all-accepted-poem-contexts')
    for r in products:
        need(all(r[k]=='\n'.join(basis[i][k] for i in r['unitIds']) and r[k+'Sha256']==utf(r[k]) for k in ['source','target']), 'assembled-context-version')
    plan=dict(schemaVersion=1, locale=locale, context=CONTEXT, originalAssemblySha256=ORIGINAL,
              scopeSha256=sha(inp/'basis.jsonl'), supportedInputAssemblySha256=[], choices=accepted,
              supersededChoices=[c for c in request['choiceVersions'] if c['id'] == update['id']],
              comparisonLiteralIds=deps['comparisonLiteralIds'],branchContracts=deps['branchContracts'],defaultBranch=deps['defaultBranch'],triggerSuccessors=deps['triggerSuccessors'],
              sourceGateAccepted=False, applicationAllowed=False, nativeRuntime='not-run')
    validate(plan, plan)
    return plan, basis, reviews, deps

def derive_retained(inp, locale):
    """Bind an unchanged locale to its own complete receipts, without a fake delta."""
    need(locale != 'es' or read(inp/'manifest.json').get('culture') == 'es-ES', 'explicit-culture')
    request, deps, context, bindings, assembled, index, literary = [read(inp / n) for n in [
        'request.json', 'dependencies.json', 'context.json', 'choice-bindings.json',
        'assembled.json', 'receipt-index.json', 'literary-result.json']]
    need(request['locale'] == bindings['locale'] == assembled['locale'] == literary['locale'] == locale, 'request-locale')
    need(sha(inp / 'context.json') == deps['contextSha256'], 'source-context-version')
    basis = unique(rows(inp / 'basis.jsonl'))
    need(list(basis) == deps['sourceIds'] and len(basis) == 194, 'complete-194-basis')
    need(request['affectedIds'] == [i for group in deps['choiceSlots'] for i in group], 'complete-request-scope')
    choices = unique(bindings['choices']); versions = unique(index['rows'])
    need(set(choices) == set(request['affectedIds']) and set(versions) == set(basis), 'complete-receipt-scope')
    retained = unique([r['review'] for r in rows(inp / 'retained-reviews.jsonl')])
    initial = unique(rows(inp / 'initial-reviews.jsonl'))
    reviews = {}; accepted = []; nodes = {(n['conversationId'], n['entryId']): n for n in context['nodes']}
    for i, r in basis.items():
        v = versions[i]; evidence = retained.get(i, initial.get(i))
        need(evidence is not None and evidence.get('reviewed') is not False, 'missing-receipt:' + i)
        need(evidence['verdict'] == v['retainedVerdict'], 'retained-verdict:' + i)
        need(all(r[k+'Sha256'] == utf(r[k]) == evidence[k+'Sha256'] == v[k+'Sha256'] for k in ['source','target']), 'review-version:' + i)
        reviews[i] = dict(evidence, reviewerThreadId=evidence.get('reviewerThreadId'), coverageClass='retained-original-judgment')
    held = read(inp / 'family-disposition.json')['consumerHeldIds']
    need({i for i, r in reviews.items() if r['verdict'] == 'needs-context'} == set(held) and len(held) == 6, 'six-consumer-holds')
    need(literary['poem']['all27SourceTargetCombinationsRead'] is True, 'complete-literary-reading')
    for slot, group in enumerate(deps['choiceSlots'], 1):
        for i in group:
            r = basis[i]; c = choices[i]; n = nodes[303, int(i.split(':')[2])]; f = {x['title']:x['value'] for x in n['fields']}
            need(reviews[i]['verdict'] in ['pass','clean'], 'choice-not-accepted:' + i)
            need(c['slot'] == slot and all(c[k] == r[k] and c[k+'Sha256'] == r[k+'Sha256'] for k in ['source','target']), 'choice-binding:' + i)
            need(c['evaluationValue'] == r['source'] and c['evaluationKey'] in r['source'].lower(), 'full-evaluation-line:' + i)
            receipt = c['retainedReceipt']['original']['review']
            need(receipt == retained[i], 'owning-choice-receipt:' + i)
            need(f['Dialogue Text'] == r['source'] and f['Menu Text'] == '', 'choice-source-display')
            need(not n['conditionsString'] and not n['userScript'] and not n['onExecute']['m_PersistentCalls']['m_Calls'], 'choice-control')
            need(n['outgoingLinks'] == c['originalLinks'] and len(n['outgoingLinks']) == 1 and n['outgoingLinks'][0]['destinationDialogueID'] == {1:404,2:413,3:416}[slot], 'choice-successor')
            accepted.append(dict(id=i, slot=slot, conversationId=303, context=CONTEXT, source=r['source'], target=r['target'], sourceSha256=r['sourceSha256'], targetSha256=r['targetSha256'], acceptedVerdict=reviews[i]['verdict'], producerTrigger=c['producerTrigger'], destination=n['outgoingLinks'][0], occurrences=r['occurrences']))
    shared = read(inp / 'shared-map.json')
    need(all(deps[k] == shared[k] for k in ['branchContracts','triggerSuccessors','comparisonLiteralIds']), 'shared-consumer-contract')
    for t in deps['triggerSuccessors']:
        n=nodes[303,t['triggerEntry']]; f={x['title']:x['value'] for x in n['fields']}
        need(f['Title'] == 'TRIGGER('+t['triggerName']+')' and n['outgoingLinks'][0]['destinationDialogueID'] == t['successor'], 'trigger-successor')
    for b in deps['branchContracts'] + [deps['defaultBranch']]:
        need(next(f['value'] for f in nodes[303,b['namedEntry']]['fields'] if f['title']=='Title') == b['arc'], 'named-arc')
    products=assembled['combinations']; prior=read(inp/'poem-products.json'); independently_read=read(inp/'literary-combinations.json')
    tuples=set(itertools.product(*deps['choiceSlots']))
    need(len(products) == len(prior) == len(independently_read) == 27 and len({r['id'] for r in products}) == 27 and {tuple(r['choiceIds']) for r in products} == {tuple(r['ids']) for r in prior} == {tuple(r['ids']) for r in independently_read} == tuples, 'all-accepted-poem-contexts')
    prior_by_tuple={tuple(r['ids']):r for r in prior}
    independent_by_tuple={tuple(r['ids']):r for r in independently_read}
    for r in products:
        old=prior_by_tuple[tuple(r['choiceIds'])]
        need(all(r[k]=='\n'.join(basis[i][k] for i in r['choiceIds']) and r[k+'Sha256']==utf(r[k]) for k in ['source','target']), 'assembled-context-version')
        need(old['source'] == r['sourceLines'] and old['rawTarget'] == r['targetLines'], 'retained-product-version')
        evidence=independent_by_tuple[tuple(r['choiceIds'])]
        need(evidence['source'] == r['sourceLines'] and evidence['newTarget'] == r['targetLines'], 'independent-product-version')
        branch=next((b for b in deps['branchContracts'] if b['ids']==[int(i.split(':')[2]) for i in r['choiceIds']]), deps['defaultBranch'])
        need(r['expectedArc'] == r['callback']['arc'] == branch['arc'] and r['namedEntry'] == branch['namedEntry'] and r['feedbackEntry'] == branch['feedbackEntry'], 'assembled-branch-contract')
    plan=dict(schemaVersion=1, locale=locale, context=CONTEXT, originalAssemblySha256=ORIGINAL,
        scopeSha256=sha(inp/'basis.jsonl'), supportedInputAssemblySha256=[], choices=accepted, supersededChoices=[],
        comparisonLiteralIds=deps['comparisonLiteralIds'], branchContracts=deps['branchContracts'], defaultBranch=deps['defaultBranch'], triggerSuccessors=deps['triggerSuccessors'],
        sourceGateAccepted=False, applicationAllowed=False, nativeRuntime='not-run')
    validate(plan,plan)
    return plan,basis,reviews,deps

def generate_backend(upstream, plan_hash, locale, superseded, culture=None):
    # Preserve the upstream helper, resolver, CIL extraction and comparison bodies.
    source = upstream
    source = source.replace('const string MapHash = "58cba42e3fe2c682ac6da28d7ddb476b313e20ff2810e47de8e8b26890a23f74";', 'const string MapHash = "'+plan_hash+'";')
    source = source.replace('GetString()=="ru" &&', 'GetString()=="'+locale+'" &&')
    source = source.replace('VNRevivalRuHaiku_', 'VNRevivalHaiku_')
    start=source.index('    static object Patch('); end=source.index('    static ModuleDefinition Fixture(', start)
    source=source[:start]+source[end:] # No game assembly writer exists in this resource tool.
    source=source.replace('static object Test(string originalPath,string patchedPath,string mapping,string report,string fixtureDir)', 'static object Test(string originalPath,string mapping,string report,string fixtureDir)')
    source=source.replace('using var source=ModuleDefinition.ReadModule(originalPath);using var patched=ModuleDefinition.ReadModule(patchedPath);', '''using var source=ModuleDefinition.ReadModule(originalPath);using var patched=ModuleDefinition.ReadModule(originalPath);
        Guard(patched,source);AddHelpers(patched,map);
        for(int k=0;k<9;k++){var i=At(Execute(patched),Loads[k]);i.OpCode=OpCodes.Call;i.Operand=Handler(patched).Methods.Single(x=>x.Name==Prefix+"Line"+(k%3+1));}''')
    source=source.replace('new[]{"en-US","ru-RU","tr-TR"}', 'new[]{"en-US","'+(culture or locale)+'","tr-TR"}')
    source=source.replace('russian=string.Join', 'display=string.Join').replace('russian-fields-preserved', 'display-fields-preserved').replace('English-key-in-Russian-label','English-key-in-display-label')
    if not superseded:
        # The unchanged-version contract additionally proves full evaluation values,
        # not merely equivalence of keyword outcomes. Preserve legacy generation.
        source=source.replace('var resolve=b.GetMethod(Prefix+"Resolve")!;', '''var resolve=b.GetMethod(Prefix+"Resolve")!;
        var resolverResults=new List<object>();
        foreach(var choice in choices) {
            var label=choice.GetProperty("target").GetString()!;var slot=choice.GetProperty("slot").GetInt32();
            var actual=(string)resolve.Invoke(null,new object[]{label,slot,Context})!;
            Need(actual==choice.GetProperty("source").GetString(),"exact-full-source-evaluation-value");
            resolverResults.Add(new{id=choice.GetProperty("id").GetString(),slot,display=label,evaluation=actual,passed=true});
        }''')
        source=source.replace('structuralNegative,\n            boundary=', 'structuralNegative,resolverResults,\n            boundary=')
    if superseded:
        source=source.replace('Set(b,good);Need(Eval(b)=="bridge_ending","matching-positive-after-runtime-negatives");', '''Set(b,good);Need(Eval(b)=="bridge_ending","matching-positive-after-runtime-negatives");
        var obsolete=good.ToArray();obsolete[2]=OBSOLETE_LABEL_LITERAL;Set(b,obsolete);
        Reject("superseded-third-line-before-short-circuit",()=>Eval(b),"haiku-identity:unknown-label-or-slot");
        Set(b,good);Need(Eval(b)=="bridge_ending","matching-positive-after-superseded-version");'''.replace('OBSOLETE_LABEL_LITERAL',json.dumps(superseded[0]['target'],ensure_ascii=False)))
    # Expose only resource generation and metadata dump; no Patch entry remains.
    start=source.index('            if(args.Length==5&&args[0]=="patch")'); end=source.index('            return 0;', start)
    source=source[:start]+'''            if(args.Length==5&&args[0]=="resource")Test(args[1],args[2],args[3],args[4]);
            else if(args.Length==3&&args[0]=="dump") {using var m=ModuleDefinition.ReadModule(args[1]);Save(args[2],Tree(m));}
            else throw new InvalidOperationException("usage: resource original map report fixtures | dump input report");
'''+source[end:]
    need('static object Patch(' not in source and 'patchedPath' not in source, 'no-game-patcher')
    return source

def build(inp, output, locale):
    plan,basis,reviews,deps=derive(inp,locale) # All cheap prerequisites before output/build.
    need(not output.exists(), 'fresh-output-required')
    output.mkdir(parents=True)
    write(output/'mapping.json',plan)
    controls=[]
    def reject(name, edit, reason):
        p=copy.deepcopy(plan);edit(p)
        try: validate(p,plan)
        except ValueError as e: need(str(e)==reason, 'wrong-negative-boundary:'+name)
        else: raise ValueError('negative-accepted:'+name)
        validate(plan,plan);controls.append(dict(name=name,passed=True,expectedReason=reason,positiveControl='unchanged final map before/after one mutation'))
    reject('missing-ninth-choice',lambda p:p['choices'].pop(),'exact-nine-choices')
    reject('ambiguous-slot',lambda p:p['choices'][1].update(target=p['choices'][0]['target']),'ambiguous-slot-labels')
    reject('wrong-slot',lambda p:p['choices'][0].update(slot=2),'slot-identity')
    reject('wrong-locale',lambda p:p.update(locale='different-locale'),'explicit-locale')
    old_choice=plan['supersededChoices'][0] if plan['supersededChoices'] else dict(plan['choices'][0],target=plan['choices'][0]['target']+'!',targetSha256=utf(plan['choices'][0]['target']+'!'))
    reject('mixed-version-with-valid-hash' if plan['supersededChoices'] else 'unaccepted-version-with-valid-hash',lambda p:next(c for c in p['choices'] if c['id']==old_choice['id']).update(target=old_choice['target'],targetSha256=old_choice['targetSha256']),'accepted-choice-version')
    reject('wrong-context',lambda p:p.update(context='different-scene'),'wrong-context')
    reject('changed-source-hash',lambda p:p['choices'][0].update(sourceSha256='0'*64),'text-hash')
    write(output/'map-controls.json',controls)
    choices={c['id']:c for c in plan['choices']}
    shared=read(inp/'shared-fixtures.json'); fixtures=[]
    for f in shared['fixtures']:
        f=copy.deepcopy(f)
        for step,i in zip(f['steps'],f['ids']):
            c=choices[i];need(step['choiceEntryId']==int(i.split(':')[2]) and step['slot']==c['slot'], 'shared-fixture-slot')
            step['expectedLabel']=c['target'];step['targetSha256']=c['targetSha256']
        f['expectedPoemLines']=[choices[i]['target'] for i in f['ids']]
        branch=next((b for b in plan['branchContracts'] if b['ids']==[int(i.split(':')[2]) for i in f['ids']]),plan['defaultBranch'])
        need(f['expectedArc']==branch['arc'] and f['expectedCallback']['arc']==branch['arc'], 'shared-fixture-outcome')
        f['expectedNamedEntry']=branch['namedEntry']; f['expectedFeedbackEntry']=branch['feedbackEntry']
        fixtures.append(f)
    need({tuple(f['ids']) for f in fixtures} == set(itertools.product(*deps['choiceSlots'])), 'complete-27-fixtures')
    write(output/'runtime27-fixtures.json',dict(locale=locale,runtime='not-run',requiredGameAssembly=None,targetScopeSha256=plan['scopeSha256'],fixtures=fixtures))
    dispositions=[]
    for i,r in basis.items():
        rr=reviews[i]
        dispositions.append(dict(id=i,sourceSha256=r['sourceSha256'],targetSha256=r['targetSha256'],occurrences=r['occurrences'],editorialVerdict=rr['verdict'],coverageClass=rr.get('coverageClass','linguistic-wording'),reviewerThreadId=rr['reviewerThreadId'],sourceAdmission='held: consumer context unresolved' if rr['verdict']=='needs-context' else 'held: common grammar/reachability/source gate',resourceDisposition='version-bound identity choice' if i in choices else 'held heading/fade/template consumer; no resource write' if rr['verdict']=='needs-context' else 'retained reviewed dependency; no resource write',applicationAllowed=False,fontAllocation='not-run',nativeProgression='not-run'))
    jsonl(output/'selector-dispositions.jsonl',dispositions)
    backend=output/'resource-tool';backend.mkdir()
    culture=read(inp/'manifest.json').get('culture',locale)
    original=(inp/'Program.cs').read_text();generated=generate_backend(original,sha(output/'mapping.json'),locale,plan['supersededChoices'],culture)
    (backend/'Program.cs').write_text(generated)
    (output/'upstream-reuse.diff').write_text(''.join(difflib.unified_diff(original.splitlines(True),generated.splitlines(True),fromfile='pinned-upstream/Program.cs',tofile='resource-tool/Program.cs')))
    shutil.copy2(inp/'project.csproj',backend/'HaikuIdentityPatch.csproj')
    (backend/'deps').mkdir();shutil.copy2(inp/'Mono.Cecil.dll',backend/'deps/Mono.Cecil.dll');shutil.copy2(inp/'original.dll',backend/'deps/Assembly-CSharp.original.dll')
    subprocess.run(['dotnet','build',str(backend/'HaikuIdentityPatch.csproj'),'--nologo','--verbosity','quiet','-o',str(backend/'compiled')],check=True)
    exe=backend/'compiled/HaikuIdentityPatch.dll'
    subprocess.run(['dotnet',str(exe),'resource',str(inp/'original.dll'),str(output/'mapping.json'),str(output/'clr-tests.json'),str(output/'fixtures')],check=True)
    tests=read(output/'clr-tests.json')
    need(tests['passed'] and len(tests['fixtures'])==27 and tests['cultureResults']=={'en-US':27,culture:27,'tr-TR':27}, '27-clr-postcondition')
    by_tuple={tuple(f['ids']):f for f in fixtures}
    for t in tests['fixtures']:
        f=by_tuple[tuple(t['ids'])]
        need(t['actual']==f['expectedArc'] and t['display']=='\n'.join(f['expectedPoemLines']) and t['fieldsUnchanged'], 'saved-resource-output')
    for name in ['HaikuOriginalPredicate','HaikuPatchedPredicate']:
        subprocess.run(['dotnet',str(exe),'dump',str(output/'fixtures'/ (name+'.dll')),str(output/(name+'-readback.json'))],check=True)
    write(output/'manifest.json',dict(locale=locale,status='implemented-isolated-resource; independent technical review pending',request=read(inp/'manifest.json')['files']['request.json'],choiceCount=9,affectedSelectors=194,tuples=27,outcomes=dict(collections.Counter(f['expectedArc'] for f in fixtures)),mapControls=len(controls),clrRuntimeControls=len(tests['negative']),sharedStructuralControls=len(tests['structuralNegative']),sourceGateAccepted=False,applicationAllowed=False,gamePatchInput=None,ready=False,nativeRuntime='not-run',
        boundary='Only isolated extracted CIL fixtures are loaded in .NET 8. No original game assembly load/execution or game patch. Callbacks/timers/UI/Unity are replaced at the existing fixture boundary. Native resource/package compatibility is unproved.',
        files={str(p.relative_to(output)):sha(p) for p in sorted(output.rglob('*')) if p.is_file()}))
    print(json.dumps({k:v for k,v in read(output/'manifest.json').items() if k!='files'}))

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--inputs',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--locale',required=True)
    a=p.parse_args();build(a.inputs.resolve(),a.output.resolve(),a.locale)
