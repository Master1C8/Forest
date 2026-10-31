#!/usr/bin/env python3
"""Bind existing Forest jobs to the Russian-derived process; never call a model."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]
SPEC = 'localization/completion/process-spec.json'
QUEUE = 'localization/completion/locale-queue.json'
GUIDE = 'localization/PROCESS.md'
RECEIPT = 'localization/completion/queue-update-20261029.json'
STAGES = ('scope', 'probe', 'source', 'glossary', 'translate-edit', 'editorial',
          'resources', 'package', 'runtime', 'screenshot-upload', 'screenshot-review', 'delivery')


def read(path):
    return json.loads(Path(path).read_text())


def sha(path):
    result = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024**2), b''):
            result.update(block)
    return result.hexdigest()


def local(root, name):
    path = (root/name).resolve()
    if not path.is_relative_to(root.resolve()):
        raise ValueError('Path escapes canonical project: '+name)
    return path


def write(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    raw = (json.dumps(data, ensure_ascii=False, indent=2)+'\n').encode()
    if path.exists():
        if path.read_bytes() != raw:
            raise ValueError('Reconcile existing differing artifact: '+str(path))
        return
    with path.open('xb') as stream:
        stream.write(raw)


def rows(path):
    return [json.loads(s) for s in path.read_text().splitlines() if s.strip()]


def validate_spec(spec):
    if spec['model'] != {'name':'gpt-6.1-sol', 'reasoning':'high', 'provider':'openai', 'inheritedHistory':False}:
        raise ValueError('Only fresh explicitly pinned Sol/high/OpenAI; NEVER Astra/fallback')
    if spec['limits'] not in ({'linguistic':6, 'technical':0}, {'linguistic':6, 'technical':1}) or tuple(spec['stages']) != STAGES:
        raise ValueError('Shared stage or concurrency contract changed')
    family_ids = [f['id'] for f in spec['families']]
    if len(set(family_ids)) != len(family_ids):
        raise ValueError('Duplicate family ID')
    for family in spec['families']:
        if not family['evidence'] or not family['predicate'] or not family['nextAction']:
            raise ValueError('Finite family contract is incomplete')


def build_queue(root):
    root = Path(root).resolve()
    spec = read(root/SPEC)
    validate_spec(spec)  # Before localized files are read.
    scope = read(local(root, spec['localeScope']))
    locales = scope['targetLocales']
    if len(locales) != len(set(locales)) or 'en' in locales or 'ru' not in locales:
        raise ValueError('Invalid shared target locale set')
    if set(locales) != set(spec['languages']):
        raise ValueError('Process languages differ from existing shared locale scope')
    common_names = [SPEC, GUIDE, 'tools/locale_queue.py', spec['localeScope'], *spec['sharedEvidence']]
    common_names += [name for family in spec['families'] for name in family['evidence']]
    pins = {name:sha(local(root,name)) for name in dict.fromkeys(common_names)}
    for name in spec['universalReferences']:
        pins[name] = sha(Path(name))
    source = rows(local(root, spec['dialogueSource']))
    source_ids = {r['id'] for r in source}
    source_by_id = {r['id']:r for r in source}
    if len(source_ids) != len(source):
        raise ValueError('Duplicate canonical dialogue IDs')
    entries = []
    for locale in locales:
        if locale == 'ru':
            continue
        asset = root/f'localization/{locale}-assets'
        overlay = asset/f'dialogue.{locale}.jsonl'
        saved = None
        own_pins = {}
        if overlay.exists():
            targets = rows(overlay)
            ids = [r['id'] for r in targets]
            if len(set(ids)) != len(ids) or set(ids)-source_ids:
                raise ValueError('Duplicate/foreign saved dialogue IDs: '+locale)
            for row in targets:
                original = source_by_id[row['id']]
                if (any(row.get(k) != original.get(k) for k in ('source','occurrences'))
                        or row.get('sourceSha256') != hashlib.sha256(original['source'].encode()).hexdigest()):
                    raise ValueError('Saved source binding mismatch: '+locale)
                if not isinstance(row.get('target'),str) or not row['target'].strip():
                    raise ValueError('Empty saved target: '+locale)
                if hashlib.sha256(row['target'].encode()).hexdigest() != row['targetSha256']:
                    raise ValueError('Saved target hash mismatch: '+locale)
            saved = dict(path=str(overlay.relative_to(root)), sha256=sha(overlay),
                         authoredIds=len(ids), sourceFamilyIds=len(source),
                         meaning='Dialogue-family storage coverage only; never whole-game acceptance')
            own_pins[saved['path']] = saved['sha256']
        glossary = f'localization/glossary/{locale}.json'
        own_pins[glossary] = sha(local(root,glossary))
        owners = []
        for directory in [f'outputs/locale-assets-20261026/{locale}', f'outputs/editorial-20261027/{locale}']:
            job = local(root,directory)/'job.json'
            if job.exists():
                state = read(job)
                recorded_locale = (state.get('localeConfig') or {}).get('locale',state.get('locale'))
                if recorded_locale is not None and recorded_locale != locale:
                    raise ValueError('Existing job locale mismatch: '+directory)
                owners.append(dict(directory=directory, recordedStatus=state['status'],
                                   jobSha256=sha(job)))
                for name in ['job.json','config.json','contract.md','input-pins.json','supervise.py','cli_job_support.py','result.json']:
                    path=job.parent/name
                    if path.exists():own_pins[str(path.relative_to(root))] = sha(path)
        config_path=asset/'locale.json'
        if config_path.exists():
            config=read(config_path)
            if config.get('locale')!=locale or config.get('assetDirectory')!=f'localization/{locale}-assets':
                raise ValueError('Existing asset configuration locale mismatch: '+locale)
        own_files = [*asset.glob('*.json'), *asset.glob('*.py'), *(asset/'batches').rglob('*.tsv')]
        for path in own_files:
            if path.is_file():own_pins[str(path.relative_to(root))] = sha(path)
        # Keep final owning manifests, not just the old draft counters.
        editorial = root/f'localization/editorial-delivery/{locale}-current.json'
        old_review = None
        if editorial.exists():
            record = read(editorial)
            target = record.get('currentCorpus') or record.get('target') or {}
            old_review = dict(path=str(editorial.relative_to(root)), sha256=sha(editorial),
                             recordedStatus=record['status'],
                             targetHashMatches=bool(saved and target.get('sha256')==saved['sha256']),
                             applicability='needs-review; validate source/glossary/binding dependencies')
            own_pins[old_review['path']] = old_review['sha256']
        supplement = root/f'localization/supplemental-ui/20261027/{locale}.jsonl'
        if supplement.exists():
            own_pins[str(supplement.relative_to(root))] = sha(supplement)
        entries.append(dict(locale=locale, language=spec['languages'][locale],
            execution='prepared-not-started', existingOwners=owners,
            nextTask='reconcile-saved-evidence', savedDialogue=saved,
            savedEditorial=old_review, glossary=glossary, inputPins=own_pins,
            stages={stage:'needs-review' if stage in ('scope','source','glossary','editorial') else 'not-run'
                    for stage in STAGES},
            familyTasks=[dict(id=f['id'], state='prepared', admission='verify-per-selector-before-wording-or-application')
                         for f in spec['families']],
            dialogueAction='reuse-verified-work; no blanket retranslation' if saved else 'not-started; normal entry gates required',
            nativeRuntime='not-run', visual='not-run', release='not-run'))
    return dict(schemaVersion=2, revision=spec['revision'], game='The Forest of Love', build='0.45',
        referenceLocale='ru', referenceIsCompleteRelease=False, execution='prepared-not-started',
        model=spec['model'], limits=spec['limits'], commonInputPins=pins,
        sharedTasks=spec['sharedTasks'], locales=entries,
        coverage='Families overlap. No complete unique visible-text denominator is asserted.')


def check(root):
    root = Path(root).resolve()
    queue = read(root/QUEUE)
    if queue != build_queue(root):
        raise ValueError('Queue inputs/state changed; reconcile affected dependencies before continuation')
    receipt = read(root/RECEIPT)
    if receipt['queueSha256'] != sha(root/QUEUE):
        raise ValueError('Queue publication receipt mismatch')
    for name, expected in receipt['existingJobPointers'].items():
        if sha(local(root,name)) != expected:
            raise ValueError('Existing job workflow pointer changed: '+name)
    if receipt.get('groupBinding') and sha(local(root,receipt['groupBinding']['path'])) != receipt['groupBinding']['sha256']:
        raise ValueError('Existing group workflow binding changed')
    return queue


def assert_idle(directory):
    processes = subprocess.check_output(['ps','-axo','pid,ppid,command'], text=True)
    parsed = [line.split(None,2) for line in processes.splitlines()[1:]]
    parents = {int(parts[0]):int(parts[1]) for parts in parsed if len(parts)==3}
    ancestors = set(); current = os.getpid()
    while current and current not in ancestors:
        ancestors.add(current); current = parents.get(current,0)
    if any(int(parts[0]) not in ancestors and str(directory.resolve()) in parts[2]
           for parts in parsed if len(parts)==3):
        raise ValueError('Existing job still has a live process: '+str(directory))


def update(root, reconcile=False):
    root = Path(root).resolve()
    queue = build_queue(root)
    existing = [owner for row in queue['locales'] for owner in row['existingOwners']]
    for owner in existing:
        assert_idle(root/owner['directory'])
    group_path = root/'outputs/locale-assets-20261026/group.json'
    group = read(group_path) if group_path.exists() else None
    if group:
        for name in group['jobs']:
            assert_idle(local(root,name).parent)
    # Validate/reconcile existing outputs before publishing any replacement pointer.
    if (root/QUEUE).exists() and read(root/QUEUE) != queue and not reconcile:
        raise ValueError('Existing queue differs; preserve it and reconcile before updating')
    prior_key = sha(root/QUEUE) if (root/QUEUE).exists() else 'partial-'+sha(root/SPEC)
    archive = root/'localization/completion/queue-history'/prior_key

    def publish(path, value):
        if not path.exists() or read(path)==value:
            write(path,value)
            return
        if not reconcile:
            raise ValueError('Reconcile existing differing artifact: '+str(path))
        before = path.read_bytes()
        retained = archive/path.relative_to(root)
        retained.parent.mkdir(parents=True,exist_ok=True)
        if retained.exists():
            if retained.read_bytes()!=before:
                raise ValueError('Historical queue archive differs; reconcile partial update')
        else:
            with retained.open('xb') as stream:stream.write(before)
        pending = path.with_suffix(path.suffix+'.workflow-pending')
        with pending.open('x') as stream:
            json.dump(value,stream,ensure_ascii=False,indent=2);stream.write('\n')
        if path.read_bytes()!=before:
            raise ValueError('Published input changed during reconciliation; preserve pending output')
        pending.replace(path)

    publish(root/QUEUE, queue)
    pointers = {}
    for row in queue['locales']:
        for owner in row['existingOwners']:
            path = root/owner['directory']/'current-workflow.json'
            value = dict(revision=queue['revision'], locale=row['locale'], queue=QUEUE,
                         queueSha256=sha(root/QUEUE), legacyResumeAllowed=False,
                         nextTask=row['nextTask'], oldJobSha256=owner['jobSha256'],
                         nextCommand=['python3','-B','tools/locale_queue.py','prepare','--locale',row['locale'],
                                      '--output',row['existingOwners'][0]['directory']+'/workflow-v2/reconcile-saved-evidence'],
                         scope='Preparation only; no new model/runtime/publication authority')
            publish(path,value)
            pointers[str(path.relative_to(root))] = sha(path)
    if group and group.get('workflowBinding',{}).get('queueSha256') != sha(root/QUEUE):
        before = group_path.parent/'workflow-updates'/queue['revision']/sha(root/QUEUE)/'group-before.json'
        write(before,group)
        group.update(status='prepared-not-started', historicalObservationsOnly=True,
                     workflowBinding=dict(revision=queue['revision'],queue=QUEUE,
                     queueSha256=sha(root/QUEUE), previousGroup=str(before.relative_to(root)),
                     previousGroupSha256=sha(before), modelRequestsStarted=0))
        pending = group_path.with_suffix('.workflow-pending')
        with pending.open('x') as stream:
            json.dump(group,stream,ensure_ascii=False,indent=2);stream.write('\n')
        pending.replace(group_path)
    # Final receipt is the publication boundary, not a multi-file transaction.
    receipt = dict(revision=queue['revision'], queue=QUEUE,queueSha256=sha(root/QUEUE),
                   existingJobPointers=pointers, localeCount=len(queue['locales']),
                   existingLanguageCount=sum(bool(r['existingOwners']) for r in queue['locales']),
                   groupBinding=dict(path=str(group_path.relative_to(root)),sha256=sha(group_path)) if group else None,
                   modelRequestsStarted=0, localizationFilesChanged=False,
                   publication='manifest-last; partial writes require reconciliation')
    publish(root/RECEIPT,receipt)
    return receipt


def prepare(root, locale, output):
    root = Path(root).resolve()
    queue = check(root)
    matches = [r for r in queue['locales'] if r['locale']==locale]
    if len(matches)!=1:
        raise ValueError('Explicit known non-reference target locale required')
    row = matches[0]
    output = output.resolve()
    permitted = [root/o['directory'] for o in row['existingOwners']]
    if not permitted:
        permitted = [root/f'outputs/locale-assets-20261026/{locale}']
    if not any(output.is_relative_to(p.resolve()) and output != p.resolve() for p in permitted):
        raise ValueError('Packet must belong to its existing locale job')
    if output.exists():
        raise ValueError('Occupied output; reconcile existing packet before resubmission')
    for path in permitted:
        assert_idle(path)
    output.mkdir(parents=True)
    execution = output/'execution';execution.mkdir()
    for name in [SPEC,GUIDE,'tools/locale_queue.py','tools/cli_runtime_identity.py','tools/cli_job_support.py']:
        shutil.copyfile(local(root,name),execution/Path(name).name)
    pins = {**queue['commonInputPins'], **row['inputPins']}
    write(output/'input-pins.json',pins)
    text = (
        f'# Reconcile saved {row["language"]} localization evidence ({locale})\n\n'
        f'Game The Forest of Love 0.45; original English source; canonical root {root}.\n'
        f'Process revision {queue["revision"]}; existing job identities and saved inputs are in {root/QUEUE}.\n'
        'Fresh gpt-6.1-sol/high/OpenAI only, no inherited history, Astra, fallback or nested jobs. '
        'Before localized content verify actual runtime metadata/argv and every input pin. '
        'Read mandatory workstation references and the frozen PROCESS.md once. Do not search old chats.\n\n'
        'This is one finite read-only reconciliation assignment. Read your own saved dialogue metadata, '
        'glossary and owning immutable editorial manifests, custom corpus/display approvals, poetry '
        'receipts and unresolved groups. Verify current hashes and the universal applicability/restart '
        'boundary. Do not rerun a completed draft or generate translated wording in this assignment. '
        'List reuseable evidence separately from stale or unverified evidence; unknown is not passed.\n\n'
        f'Writable scope: this packet directory {output} only; no locale/source/glossary/Git changes. '
        'Other language data and original job files are read-only. No game, screenshot, installer, '
        'server, publication or deployment actions. Preserve owner saves and immutable execution files.\n\n'
        'Deliver result.json with exact artifact paths/hashes, dialogue-family and supplemental coverage '
        'separately, glossary compatibility, editorial applicability, explicit source/renderer holds, '
        'and exactly one next finite task from the process family catalog. Each proposed task names '
        'its artifact, predicate, dependency, bounded IDs/selectors, write scope and stop condition. '
        'Do not infer a complete visible-game denominator, native success, semantic acceptance or release '
        'readiness from deterministic counters. Source and language admission remain separate.\n\n'
        'Subsequent work follows the fixed stages and universal semantic/independent-diff/delta protocol. '
        'Use the Russian mechanisms as references only; author target wording from English and your '
        'approved locale glossary. Case-sensitive logic, 27 haiku outcomes, glow copies, dynamic CR/LF '
        'fragments, font-role allocation, texture/compression/catalog preservation and installer recovery '
        'are mandatory applicable regression surfaces. Stop after this reconciliation; the parent '
        'accepts the evidence and selects the next authorized queue item.\n')
    (output/'request.md').write_text(text)
    files = {str(p.relative_to(output)):sha(p) for p in output.rglob('*') if p.is_file()}
    manifest = dict(locale=locale, revision=queue['revision'],task='reconcile-saved-evidence',
                    queueSha256=sha(root/QUEUE), files=files, model=queue['model'],
                    status='prepared-not-started',modelRequestsStarted=0)
    write(output/'packet-manifest.json',manifest)
    return manifest


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('command',choices=['update','check','status','prepare','progress','text-gate'])
    parser.add_argument('--locale');parser.add_argument('--output',type=Path)
    parser.add_argument('--reconcile',action='store_true',help='Archive superseded queue/pointers before publishing reconciled inputs')
    parser.add_argument('--json',action='store_true',help='Print machine-readable progress')
    args=parser.parse_args()
    if args.command=='text-gate':
        if not args.locale:parser.error('text-gate requires --locale')
        from locale_dispatch_policy import text_gate
        result=text_gate(ROOT,args.locale)
        print(json.dumps(result,ensure_ascii=False,indent=2))
        if not result['passed']:raise SystemExit(2)
    elif args.command=='progress':
        from locale_progress import report, table, snapshot
        data=report(ROOT,args.locale)
        if not args.locale:
            snapshot(data,ROOT)
        if args.output:
            # A report is a derived immutable snapshot, never a competing checkpoint.
            args.output.parent.mkdir(parents=True,exist_ok=True)
            with args.output.open('x') as stream:
                json.dump(data,stream,ensure_ascii=False,indent=2)
                stream.write('\n')
        print(json.dumps(data,ensure_ascii=False,indent=2) if args.json else table(data))
    elif args.command=='update':
        print(json.dumps(update(ROOT,reconcile=args.reconcile),ensure_ascii=False,indent=2))
    elif args.command=='prepare':
        if not args.locale or not args.output:
            parser.error('prepare requires --locale and --output')
        print(json.dumps(prepare(ROOT,args.locale,args.output),ensure_ascii=False,indent=2))
    else:
        queue=check(ROOT)
        print(f'{queue["revision"]}: {len(queue["locales"])} target locales; prepared, no model launched')
        for row in queue['locales']:
            if args.locale and row['locale']!=args.locale:
                continue
            saved=row['savedDialogue']
            print(row['locale'],str(saved['authoredIds'])+'/'+str(saved['sourceFamilyIds']) if saved else 'not-started',
                  'dialogue IDs;',len(row['familyTasks']),'family tasks;',row['nextTask'])


if __name__=='__main__':
    main()
