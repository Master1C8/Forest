"""Enforce linguistic/engineering ownership before a paid request is created."""
import json
from pathlib import Path

from locale_queue import local, read, sha


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
