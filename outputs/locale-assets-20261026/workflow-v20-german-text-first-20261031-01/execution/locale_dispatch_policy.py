"""Enforce linguistic/engineering ownership before a paid request is created."""
import json
from pathlib import Path
import subprocess
import sys

from locale_queue import local, read, sha


def text_gate(root, locale, report=None):
    """Read current version-bound acceptance; never infer it from a saved build."""
    if report is None:
        result = subprocess.run([sys.executable, '-B', str(root/'tools/locale_queue.py'),
                                 'progress', '--locale', locale, '--json'],
                                cwd=root, capture_output=True, text=True, check=True)
        report = json.loads(result.stdout)
    rows = [r for r in report['locales'] if r.get('locale') == locale]
    if len(rows) != 1:
        raise ValueError('Runtime text gate requires one exact locale')
    row = rows[0]
    missing = [stage for stage in ['translate-edit', 'editorial', 'resources', 'package']
               if row.get('gates', {}).get(stage) != 'passed']
    families = row.get('families', [])
    if not families:
        missing.append('complete-text-inventory')
    for family in families:
        count = family.get('expected')
        if (count is None or family.get('resolved') != count
                or family.get('reviewResolved') != count):
            missing.append('text-family:' + family['id'])
    return dict(locale=locale, passed=not missing, missing=missing,
                policyRevision=report.get('revision'), sourceScopeSha256=report.get('sourceScopeSha256'),
                wordingVersions=[dict(id=f['id'], sha256=f.get('wordingVersionSha256')) for f in families],
                meaning='Current full translation/editing, independent editorial, final resources and package acceptance before game execution; not runtime acceptance.')


def runtime_reason(root, job, task):
    if task.get('executionStage') not in {'runtime', 'screenshot-upload', 'screenshot-review'}:
        return None
    gate = text_gate(root, job['locale'])
    return None if gate['passed'] else 'Finish current translation and editorial acceptance before runtime: ' + ', '.join(gate['missing'])


def locale_owned_reason(root, task):
    """Keep deterministic transport inside its substantive locale assignment.

    Independent semantic/code/consumer review remains required when applicable;
    separate resource review must name its new judgment and pin the inputs.
    """
    if task.get('taskClass') in {'metadata-only', 'receipt-reconciliation',
            'resource-binding-only', 'manifest-publication', 'acknowledgement'}:
        return 'Run deterministic transport/checks in the owning substantive assignment; no separate model phase.'
    resource_review = task.get('taskClass') == 'independent-resource-review'
    if task.get('kind') == 'review':
        packet = local(root, task['reviewPacket'])
        if sha(packet) != task['reviewPacketSha256']:
            raise ValueError('Dispatch review packet changed')
        rows = [json.loads(line) for line in packet.read_text().splitlines() if line.strip()]
        resource_review |= any(
            r.get('reviewKind') in {'new-data-binding-only', 'technical-review', 'resource-binding', 'resource-contract'}
            or str(r.get('id', '')).startswith(('resource-binding:', 'technical:'))
            for r in rows)
    if not resource_review:
        return None
    judgment = task.get('newJudgment') or {}
    if (judgment.get('boundary') not in {'semantics', 'consumer', 'code', 'font-role'}
            or not isinstance(judgment.get('predicate'), str) or not judgment['predicate'].strip()
            or not judgment.get('inputs')):
        return ('Separate resource model review requires a concrete new semantic, consumer, code or font-role '
                'judgment with pinned inputs. Exact copying/readback of accepted wording uses deterministic checks.')
    for pin in judgment['inputs']:
        if sha(local(root, pin['path'])) != pin['sha256']:
            raise ValueError('New resource judgment input changed')
    return None


def defer_locale_owned(root, directory, job, state, task, why):
    """Preserve an unsubmitted task locally; never route to a retired stream."""
    folder = directory/'dispatch-holds'/job['locale']/task['briefSha256']
    folder.mkdir(parents=True, exist_ok=True)
    value = dict(schemaVersion=1, locale=job['locale'], predicate=why,
                 pendingTask=task, newModelRequestCreated=False,
                 nextAction='Bundle deterministic work into the substantive owning assignment. '
                 'For a genuinely new independent judgment, bind its exact boundary, predicate and inputs. '
                 'Do not create a technical stream, waive review or resubmit unchanged work.')
    path = folder/'request.json'
    if path.exists():
        if read(path) != value:
            raise ValueError('Immutable locale dispatch hold differs')
    else:
        with path.open('x') as stream:
            json.dump(value, stream, ensure_ascii=False, indent=2); stream.write('\n')
    state.update(status='held-dispatch-policy', reason=why, pendingTask=task,
                 dispatchHold=dict(path=str(path.relative_to(root)), sha256=sha(path)))
    return state


def reason(root, job, task):
    if job['locale'] == 'technical':
        return None
    if task['kind'] == 'review':
        packet = local(root, task['reviewPacket'])
        if sha(packet) != task['reviewPacketSha256']:
            raise ValueError('Dispatch review packet changed')
        rows = [json.loads(line) for line in packet.read_text().splitlines() if line.strip()]
        engineering = {'new-data-binding-only', 'technical-review', 'resource-binding', 'resource-contract'}
        if any(r.get('reviewKind') in engineering or 'binding' in str(r.get('reviewKind','')).lower()
               or '-resource-binding:' in str(r.get('id',''))
               or str(r.get('id', '')).startswith(('resource-binding:', 'technical:')) for r in rows):
            return 'Resource binding review belongs in the single shared technical batch, not another linguistic model request.'
        if task.get('taskClass') in {'shared-engineering', 'technical-review', 'technical-resource-build', 'technical-integration'}:
            return 'Engineering review must use the existing technical stream.'
        return None
    if task.get('taskClass') != 'linguistic-work':
        return 'A language author task needs an explicit linguistic-work scope. Unclassified resource/metadata work is not dispatched to a model.'
    return None


def defer(root, directory, plan, job, state, task, why):
    """Publish data for the existing engineering inbox; do not create a worker."""
    holds = local(root,plan.get('dispatchDirectory',str(directory/'dispatch-holds')))
    folder = holds/job['locale']/task['briefSha256']
    folder.mkdir(parents=True, exist_ok=True)
    phase = Path(state['phases'][-1]['phase'])
    request = dict(schemaVersion=1, id='dispatch-'+job['locale']+'-'+task['briefSha256'],
        locale=job['locale'], kind='existing-task-routing-correction',
        predicate=why, affectedIds=['task:'+task['briefSha256']],
        evidence=[dict(path=str((phase/'result.json').relative_to(root)),sha256=sha(phase/'result.json')),
                  dict(path=task['brief'],sha256=task['briefSha256'])],
        pendingTask=task, requiredResult='Reconcile this exact deferred task with the locale existing technical handoffs. '
        'For resource/data-binding work, consume accepted wording and generate/check data by the shared deterministic recipe. '
        'Combine any genuinely new selector/code judgments with the independent review of the actual composed artifact. '
        'Do not create another per-family/per-locale model phase for manifests, retained receipts or data wrapping. '
        'For a genuinely linguistic task missing classification, retain all actual source/target IDs and report the exact missing dispatch metadata; '
        'do not translate it in the technical stream. Never duplicate a fulfilled request or waive any editorial/native gate.',
        coordinatorTranslationRequired=False, newModelRequestCreated=False)
    def immutable(path, value):
        if path.exists():
            if read(path) != value: raise ValueError('Immutable dispatch hold differs')
        else:
            pending=path.with_suffix('.pending')
            if pending.exists():
                if read(pending)!=value:raise ValueError('Partial dispatch publication differs')
            else:
                with pending.open('x') as stream:
                    json.dump(value,stream,ensure_ascii=False,indent=2);stream.write('\n')
            pending.replace(path)
    manifest=folder/'request.json';immutable(manifest,request)
    pin=dict(path=str(manifest.relative_to(root)),sha256=sha(manifest))
    inbox=Path(plan['technicalInbox']);immutable(inbox/('00-'+request['id']+'.json'),
        dict(locale=job['locale'],request=pin,finiteDeliverable=request['requiredResult']))
    state.update(status='held-dispatch-policy',reason=why,pendingTask=task,dispatchHold=pin)
    return state
