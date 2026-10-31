"""Data-only resource dependency handoff. Never launches or retries a model.

A completed technical review publishes a receipt for an exact request and actual
saved outputs. The same six-lane supervisor consumes it once at the owning
blocked result. A draft, changed request or mere file appearance cannot wake it.
"""
import copy
import json
from pathlib import Path

from locale_queue import local, read, sha


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def pinned(root, pin):
    path = local(root, pin['path'])
    require(path.is_file() and sha(path) == pin['sha256'], 'dependency-pin-changed:' + pin['path'])
    return path


def refs(value):
    if isinstance(value, dict):
        if isinstance(value.get('path'), str) and isinstance(value.get('sha256'), str):
            yield dict(path=value['path'], sha256=value['sha256'])
        for item in value.values():
            yield from refs(item)
    elif isinstance(value, list):
        for item in value:
            yield from refs(item)


def request_id(value):
    identity = value.get('id') or value.get('requestId')
    require(isinstance(identity, str) and bool(identity), 'dependency-request-identity')
    return identity


def publish(root, plan, job, phase, task, result, *, verify_only=False, request_sha=None):
    entries = result.get('dependencyDeliveries', [])
    if not entries:
        return []
    require(job['locale'] == 'technical' and task['kind'] == 'review', 'dependency-needs-technical-review')
    coverage = result.get('verifiedReviewCoverage', {})
    require(coverage.get('assigned', 0) > 0 and not any(coverage.get(k) for k in
            ['pendingIds', 'unreadIds', 'missingReviewIds', 'pendingContextIds', 'nonPassRows']),
            'dependency-review-not-complete-clean')
    packet = [json.loads(s) for s in pinned(root, dict(path=task['reviewPacket'], sha256=task['reviewPacketSha256'])).read_text().splitlines() if s.strip()]
    judgments_path = local(root, result['reviews'])
    judgments = {r['id']: r for r in (json.loads(s) for s in judgments_path.read_text().splitlines() if s.strip())}
    inbox = Path(plan['technicalInbox']).resolve()
    destination = inbox / 'ready'
    if not verify_only: destination.mkdir(exist_ok=True)
    published = []
    for entry in entries:
        request_path = pinned(root, entry['request'])
        require(request_path.parent == inbox, 'dependency-foreign-inbox')
        envelope = read(request_path); request_pin = envelope['request']
        if request_sha is not None and request_pin['sha256'] != request_sha:
            continue
        request = read(pinned(root, request_pin))
        delivery_path = pinned(root, entry['delivery']); delivery = read(delivery_path)
        require(delivery.get('schemaVersion') == 1 and delivery.get('kind') == 'locale-resource-dependency', 'dependency-delivery-schema')
        require(delivery.get('locale') == envelope['locale'] and delivery.get('requestId') == request_id(request)
                and delivery.get('request') == request_pin, 'dependency-request-version')
        require(delivery.get('consumptionReady') is True and delivery.get('releaseAccepted') is False,
                'dependency-consumption-boundary')
        inputs = {(p['path'], p['sha256']) for p in delivery.get('inputs', [])}
        require({(p['path'], p['sha256']) for p in refs(request)} <= inputs, 'dependency-missing-request-inputs')
        for pin in delivery.get('inputs', []):
            pinned(root, pin)
        outputs = delivery.get('outputs', [])
        require(bool(outputs) and len({p['path'] for p in outputs}) == len(outputs), 'dependency-actual-outputs-required')
        require(any(Path(p['path']).suffix not in {'.json', '.jsonl', '.md', '.txt'} for p in outputs), 'dependency-game-resource-required')
        for pin in outputs:
            output = pinned(root, pin)
            require(any(output.is_relative_to(local(root, prefix)) for prefix in job['writePrefixes']), 'dependency-output-outside-technical-scope')
            require(output.stat().st_size > 0, 'dependency-empty-output')
        row_id = entry['reviewId']; pairs = [r for r in packet if r['id'] == row_id]
        require(len(pairs) == 1, 'dependency-review-row-not-assigned')
        pair, judgment = pairs[0], judgments.get(row_id, {})
        require(pair.get('source') == pinned(root, request_pin).read_text() and pair.get('target') == delivery_path.read_text(), 'dependency-reviewed-other-delivery')
        require(pair.get('sourceSha256') == request_pin['sha256'] and pair.get('targetSha256') == entry['delivery']['sha256']
                and all(judgment.get(k) == pair[k] for k in ['sourceSha256', 'targetSha256'])
                and judgment.get('verdict') in {'pass', 'clean'} and judgment.get('reviewed') is not False,
                'dependency-review-version-or-verdict')
        reviewer = read(phase / 'runtime-verification.json')
        producer = read(pinned(root, delivery['producerRuntime']))
        for runtime in [reviewer, producer]:
            actual = runtime['actualRuntime']
            require(actual['turn'] == {'model': 'gpt-6.1-sol', 'effort': 'high'} and
                    actual['session']['model_provider'] == 'openai' and actual['session']['parent_thread_id'] is None,
                    'dependency-runtime-selection')
        require(reviewer['threadId'] != producer['threadId'], 'dependency-review-not-independent')
        def pin(path): return dict(path=str(path.relative_to(root)), sha256=sha(path))
        receipt = dict(schemaVersion=1, locale=envelope['locale'], request=request_pin,
                       delivery=entry['delivery'], reviewId=row_id,
                       reviewTask=pin(phase / 'task.json'), reviewResult=pin(phase / 'result.json'),
                       judgments=pin(judgments_path), reviewerRuntime=pin(phase / 'runtime-verification.json'))
        target = destination / (request_pin['sha256'] + '.json')
        if verify_only:
            require(target.is_file() and read(target) == receipt, 'dependency-ready-receipt-differs')
        elif target.exists():
            require(read(target) == receipt, 'dependency-ready-receipt-immutable')
        else:
            pending = target.with_suffix('.pending')
            if pending.exists():
                require(read(pending) == receipt, 'dependency-partial-receipt-differs')
            else:
                with pending.open('x') as stream:
                    json.dump(receipt, stream, ensure_ascii=False, indent=2); stream.write('\n')
            pending.replace(target)
        published.append(str(target.relative_to(root)))
    return published


def waiting_task(root, plan, job, state):
    """None: no eligible work; []: quiet wait; task dict: new verified dependency."""
    if not plan.get('dependencyWake') or job['locale'] == 'technical' or state['status'] != 'blocked':
        return None
    record = state['phases'][-1]; phase = Path(record['phase'])
    require(sha(phase / 'result.json') == record['resultSha256'], 'dependency-owning-blocked-result-changed')
    result = read(phase / 'result.json'); task = result.get('nextTask') or {}
    declared = result.get('technicalHandoffs', [])
    requests = task.get('dependencyRequests', declared)
    if task.get('kind') != 'work' or not task.get('title') or not requests:
        return None
    brief = local(root, task['brief'])
    require(brief.is_relative_to(phase.resolve()) and sha(brief) == task['briefSha256'], 'dependency-owning-next-task-changed')
    require(all(request in declared for request in requests), 'dependency-task-request-not-declared')
    used = set(state.get('consumedDependencyReceipts', []))
    receipts = []
    for request in requests:
        request_path = pinned(root, request)
        payload = read(request_path)
        require(payload.get('locale') == job['locale'], 'dependency-language-request-scope')
        request_id(payload)
        ready = Path(plan['technicalInbox']) / 'ready' / (request['sha256'] + '.json')
        if not ready.exists():
            return []
        receipt = read(ready)
        require(receipt['request'] == request and receipt['locale'] == job['locale'], 'dependency-ready-request-mismatch')
        # Reconstruct and revalidate publication from its exact owning review;
        # no trust in a free-standing ready flag or an old resource manifest.
        task_doc = read(pinned(root, receipt['reviewTask']))
        reviewed = read(pinned(root, receipt['reviewResult']))
        pinned(root, receipt['judgments']); pinned(root, receipt['reviewerRuntime'])
        review_phase = local(root, receipt['reviewTask']['path']).parent
        from run_locale_completion import validate_result
        validate_result(root, task_doc['job'], review_phase, task_doc['task'], reviewed, set())
        published = publish(root, plan, task_doc['job'], review_phase, task_doc['task'], reviewed,
                            verify_only=True, request_sha=request['sha256'])
        require(str(ready.relative_to(root)) in published, 'dependency-receipt-not-owned-by-review-result')
        receipts.append(dict(path=str(ready.relative_to(root)), sha256=sha(ready)))
    if not any(pin['sha256'] not in used for pin in receipts):
        return []
    resolved = copy.deepcopy(task)
    resolved['dependencyReceipts'] = receipts
    resolved['dependencyReceipt'] = receipts[0]
    return resolved
