#!/usr/bin/env python3
"""Version-bound Russian haiku identity adapter. No wording generation or game launch."""
import argparse
import hashlib
import itertools
import json
import shutil
import subprocess
from pathlib import Path

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
TOOL_DIR = Path(__file__).resolve().parent
FROZEN = (TOOL_DIR / 'contract/input-pins.json').is_file()
ROOT = TOOL_DIR / 'inputs' if FROZEN else PROJECT
CONTRACT = TOOL_DIR / 'contract' if FROZEN else ROOT / 'localization/source/haiku-identity-adapter-20261029'
PHASE = 'localization/source/shared-source-completion-20261028/admission-v1/phase134'
CASES = 'localization/case-decisions/ru-20261029'
CORPUS = 'localization/ru-assets/dialogue.ru.jsonl'
ORIGINAL = '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
CANDIDATE = '84f70452d94741489b37d97c8125bf107b4261d4a87e5a2ba294ebdf107dfacf'
TARGET = '462c91c948c3564225aeaf71da972c7426e5b5c068eaca7bab64e22e70e36587'
CONTEXT = 'oliver_coyotes_date2_haiku_finish'


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def utf8(s):
    return hashlib.sha256(s.encode('utf-8')).hexdigest()


def need(ok, reason):
    if not ok:
        raise ValueError(reason)


def read(p):
    return json.loads(Path(p).read_text())


def rows(p):
    return [json.loads(x) for x in Path(p).read_text().splitlines()]


def write(p, value):
    Path(p).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def validate_plan(plan):
    need(plan.get('locale') == 'ru', 'explicit-ru-locale-required')
    need(plan.get('context') == CONTEXT, 'wrong-context')
    choices = plan.get('choices', [])
    need(len(choices) == 9 and len({x['id'] for x in choices}) == 9, 'exact-nine-choices-required')
    need([[x['id'] for x in choices if x['slot'] == slot] for slot in [1, 2, 3]] == [
        ['ds:303:325:Dialogue Text', 'ds:303:410:Dialogue Text', 'ds:303:406:Dialogue Text'],
        ['ds:303:326:Dialogue Text', 'ds:303:411:Dialogue Text', 'ds:303:407:Dialogue Text'],
        ['ds:303:327:Dialogue Text', 'ds:303:412:Dialogue Text', 'ds:303:408:Dialogue Text']], 'wrong-slot-identity')
    for slot in [1, 2, 3]:
        group = [x for x in choices if x['slot'] == slot]
        need(len({x['target'] for x in group}) == 3, 'ambiguous-slot-labels')
        for x in group:
            need(x['context'] == CONTEXT and x['conversationId'] == 303, 'wrong-choice-context')
            need(x['sourceSha256'] == utf8(x['source']) and x['targetSha256'] == utf8(x['target']), 'choice-text-hash')
            need(x['acceptedVerdict'] == 'pass' and x['target'] != x['source'] and x['target'].strip(), 'accepted-russian-choice-required')
    need(plan['corpusSha256'] == TARGET and plan['originalAssemblySha256'] == ORIGINAL, 'wrong-source-or-target-version')


def derive_inputs(*, locale, root=ROOT, contract=CONTRACT):
    """All checks run before any output directory is created; never trust draft row status."""
    need(locale == 'ru', 'explicit-ru-locale-required')
    pins = read(contract / 'input-pins.json')
    for name, digest in pins.items():
        need(sha(root / name) == digest, 'input-pin:' + name)
    need(sha(root / CORPUS) == TARGET, 'target-corpus-hash')
    current = read(root / 'localization/editorial-delivery/ru-current.json')
    need(current['currentCorpus']['sha256'] == TARGET, 'accepted-corpus-version')
    case = next(x for x in rows(root / CASES / 'decisions.jsonl') if x['caseId'] == 'haiku-group')
    need(case['scope']['acceptedTargetBindingCount'] == 194 and case['wordingReferences']['bindings'] == 194, 'accepted-194-scope')
    corpus_rows = rows(root / CORPUS)
    corpus = {x['id']: x for x in corpus_rows}
    need(len(corpus) == len(corpus_rows), 'duplicate-corpus-id')
    bindings = [x for x in rows(root / CASES / 'source-bindings.jsonl') if x['caseId'] == 'haiku-group']
    deps = read(root / PHASE / 'haiku-source-dependencies.json')
    context = read(root / PHASE / 'haiku-source-context.json')
    need(sha(root / PHASE / 'haiku-source-context.json') == deps['contextSha256'], 'source-context-version')
    accepted = {x['bindingId']: x for x in bindings if x.get('priorReceipt')}
    need(set(accepted) == set(deps['sourceIds']) and len(accepted) == 194, 'complete-194-receipts')
    actual_receipts = {}
    receipt_paths = ['localization/editorial-delivery/ru-cycle-02/independent-full/reviews.jsonl',
                     'localization/editorial-delivery/ru-cycle-02/cycle/retained-reviews.jsonl',
                     'localization/editorial-delivery/ru-cycle-02/peer/0001-semantic/reviews.jsonl']
    for name in receipt_paths:
        need(sha(root / name) == current['evidence'][name]['sha256'], 'owning-editorial-receipt-pin')
        for r in rows(root / name):
            actual_receipts.setdefault(r['id'], []).append(r)
    counts = {'pass': 0, 'technical-preservation': 0}
    for ident, b in accepted.items():
        r = corpus[ident]
        prior = b['priorReceipt']
        need(b['source'] == r['source'] and prior['sourceSha256'] == utf8(r['source']) and prior['targetSha256'] == utf8(r['target']), 'version-matching-receipt:' + ident)
        need(any(all(p.get(k) == prior.get(k) for k in ['id', 'sourceSha256', 'targetSha256', 'verdict']) for p in actual_receipts.get(ident, [])), 'owning-peer-receipt:' + ident)
        need(prior['verdict'] in counts, 'unaccepted-receipt:' + ident)
        counts[prior['verdict']] += 1
        need(any(w['targetId'] == ident and w['targetUtf8Sha256'] == utf8(r['target']) for w in b['wordingReferences']), 'target-reference:' + ident)
    need(counts == {'pass': 125, 'technical-preservation': 69}, '194-dispositions')
    nodes = {(x['conversationId'], x['entryId']): x for x in context['nodes']}
    choices = []
    for slot, ids in enumerate(deps['choiceSlots'], 1):
        for ident in ids:
            r = corpus[ident]
            node = nodes[303, r['entryId']]
            fields = {x['title']: x['value'] for x in node['fields']}
            need(fields['Dialogue Text'] == r['source'] and fields['Menu Text'] == '', 'choice-source-display-binding')
            need(not node['conditionsString'] and not node['userScript'] and not node['onExecute']['m_PersistentCalls']['m_Calls'], 'choice-control-contract')
            need(len(node['outgoingLinks']) == 1 and node['outgoingLinks'][0]['destinationDialogueID'] == {1: 404, 2: 413, 3: 416}[slot], 'choice-destination')
            choices.append(dict(id=ident, slot=slot, conversationId=303, context=CONTEXT, source=r['source'], target=r['target'],
                                sourceSha256=utf8(r['source']), targetSha256=utf8(r['target']), acceptedVerdict=accepted[ident]['priorReceipt']['verdict'],
                                producerTrigger='oliver_coyotes_date2_haiku_line' + str(slot), destination=node['outgoingLinks'][0], occurrences=r['occurrences']))
    poem = read(root / 'localization/editorial-delivery/ru-cycle-02/author/poem-and-scansion-verification.json')
    need(poem['currentOverlaySha256'] == TARGET and poem['actualGraphProducts'] == 27 and not poem['missingPriorReceiptIds'], 'accepted-poem-receipts')
    products = {}
    for p in poem['assembledProducts']:
        key = tuple(p['stableIds'])
        need(p['target'] == '\n'.join(corpus[i]['target'] for i in key) and p['source'] == '\n'.join(corpus[i]['source'] for i in key), 'accepted-full-poem-output')
        need(p['judgment'] == 'retain' and p['targetSha256'] == utf8(p['target']), 'accepted-poem-judgment')
        products[key] = p
    need(set(products) == set(itertools.product(*deps['choiceSlots'])), 'complete-27-poems')
    plan = dict(schemaVersion=1, locale='ru', context=CONTEXT, originalAssemblySha256=ORIGINAL, corpusSha256=TARGET,
                supportedInputAssemblySha256=[CANDIDATE], choices=choices, receiptCounts=counts,
                comparisonLiteralIds=deps['comparisonLiteralIds'], branchContracts=deps['branchContracts'],
                triggerSuccessors=deps['triggerSuccessors'], products=list(products.values()))
    validate_plan(plan)
    return plan


def load_inputs(*, locale, root=ROOT, contract=CONTRACT):
    plan = derive_inputs(locale=locale, root=root, contract=contract)
    need(plan == read(contract / 'mapping.json'), 'canonical-map-version')
    return plan


def snapshot(out, *, locale):
    plan = load_inputs(locale=locale)
    out = Path(out)
    need(not (out / 'haiku-identity').exists(), 'new-snapshot-required')
    dest = out / 'haiku-identity'
    dest.mkdir(parents=True)
    shutil.copy2(Path(__file__), dest / 'russian_haiku_identity.py')
    shutil.copytree(CONTRACT, dest / 'contract')
    for name in read(CONTRACT / 'input-pins.json'):
        target = dest / 'inputs' / name
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(ROOT / name, target)
    shutil.copytree(TOOL_DIR / 'haiku_identity_patch', dest / 'haiku_identity_patch', ignore=shutil.ignore_patterns('bin', 'obj'))
    write(dest / 'snapshot-pins.json', {str(p.relative_to(dest)): sha(p) for p in sorted(dest.rglob('*')) if p.is_file()})
    return plan


def patch(source, output, receipt, *, locale, backend, plan=None):
    accepted = load_inputs(locale=locale)
    need(plan is None or plan == accepted, 'accepted-plan-version')
    plan = accepted
    validate_plan(plan)
    source, output, receipt, backend = map(Path, [source, output, receipt, backend])
    need(sha(source) == CANDIDATE, 'supported-input-assembly-hash')
    need(not output.exists() and not receipt.exists(), 'new-output-required')
    need(PROJECT in output.resolve().parents and PROJECT in receipt.resolve().parents, 'project-owned-output-required')
    subprocess.run(['dotnet', str(backend), 'patch', str(source), str(CONTRACT / 'mapping.json'), str(output), str(receipt)], check=True)
    result = read(receipt)
    need(sha(output) == result['outputSha256'] and result['wholeAssemblyReadback'] and result['structuralReversal'], 'patch-postcondition')
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--locale', required=True, choices=['ru'])
    commands = parser.add_subparsers(dest='command', required=True)
    commands.add_parser('preflight')
    snap = commands.add_parser('snapshot'); snap.add_argument('--output', required=True, type=Path)
    p = commands.add_parser('patch')
    for name in ['input', 'output', 'receipt', 'backend']:
        p.add_argument('--' + name, required=True, type=Path)
    args = parser.parse_args()
    if args.command == 'preflight':
        p = load_inputs(locale=args.locale)
        print(json.dumps({'passed': True, 'choices': len(p['choices']), 'poems': len(p['products']), 'receiptCounts': p['receiptCounts']}))
    elif args.command == 'snapshot':
        snapshot(args.output, locale=args.locale)
    else:
        patch(args.input, args.output, args.receipt, locale=args.locale, backend=args.backend)


if __name__ == '__main__':
    main()
