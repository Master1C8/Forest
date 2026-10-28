"""Prepare fresh packet reviews using the existing universal editorial protocol."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil

from inventory_display_review import run

ROOT = Path('/Users/antonkrutov/Desktop/Forest')


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def prepare(job, target, locale, stage, family, contract, contexts, catalog=None):
    assert locale == 'ru', 'An explicit supported locale is required; no fallback'
    job, target = job.resolve(), target.resolve()
    contract = contract.resolve()
    contexts = [p.resolve() for p in contexts]
    catalog = catalog.resolve() if catalog is not None else None
    assert ROOT in job.parents and not job.exists() and ROOT in target.parents
    assert stage in ['initial', 'independent-diff', 'correction-delta']
    data = [json.loads(line) for line in target.read_text().splitlines()]
    assert len(data) == len({r['id'] for r in data})
    if family == 'existing-supplement935':
        assert catalog is not None
        units = json.loads(catalog.read_text())['units']
        source = {r['id']: r for r in units}
        assert len(source) == len(units) == 935
        assigned = {r['id'] for r in data}
        if stage == 'correction-delta':
            assert assigned and assigned <= set(source)
        else:
            assert len(data) == 935 and set(source) == assigned
        for row in data:
            assert row['source'] == source[row['id']]['source']
            row['context'] = {k: v for k, v in source[row['id']].items() if k not in ['id', 'source']}
    elif family == 'chapter-gallery-case134':
        assert len(data) == 134 or stage == 'correction-delta'
    else:
        raise ValueError('Unknown review family')
    for row in data:
        assert row.get('locale', locale) == locale
        row['locale'] = locale
        for key in ['source', 'target']:
            assert isinstance(row[key], str) and row[key]
            digest = hashlib.sha256(row[key].encode()).hexdigest()
            assert row.get(key + 'Sha256', digest) == digest
            row[key + 'Sha256'] = digest
    assert contract.is_file() and all(p.is_file() for p in contexts)
    assert all(ROOT in p.parents for p in [contract] + contexts)
    context_text = '\n\n'.join('SOURCE CONTEXT: ' + str(p.relative_to(ROOT)) + '\n' + p.read_text() for p in contexts)
    job.mkdir(parents=True)
    execution = job / 'execution'; execution.mkdir()
    for name in ['editorial_lane.py', 'cli_job_support.py', 'cli_runtime_identity.py', 'inventory_display_review.py', Path(__file__).name]:
        shutil.copy2(Path(__file__).with_name(name), execution / name)
    (job / 'pairs.jsonl').write_text(''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':')) + '\n' for r in data))
    glossary = ROOT / 'localization/glossary/inventory-display-20261028'
    for name in ['en', 'ru']:
        shutil.copy2(glossary / (name + '.json'), job / ('glossary-' + name + '.json'))
    shutil.copy2(contract, job / 'contract.md')
    context = job / 'packet-context.txt'
    context.write_text(context_text)
    files = [target, contract, context, job / 'pairs.jsonl', job / 'contract.md', job / 'glossary-en.json', job / 'glossary-ru.json', glossary / 'handoff.json'] + contexts + list(execution.iterdir())
    if catalog is not None:
        files.append(catalog)
    config = dict(root=str(ROOT), locale=locale, language='Russian', model='gpt-6.1-sol', reasoning='high', stage=stage,
                  candidateIds=len(data), family=family, pins={str(p.resolve()): sha(p) for p in files},
                  requiredReviewContextDocuments=[str(context)],
                  acceptanceScope='Complete assigned packet only. Existing-wording review or bounded special-case preparation; no ordinary-entry/global/source/resource/runtime/release promotion.')
    (job / 'config.json').write_text(json.dumps(config, indent=2) + '\n')
    (job / 'job.json').write_text(json.dumps(dict(status='prepared', stage=stage, phases=[], reviewedIds=0), indent=2) + '\n')
    print(json.dumps(dict(status='prepared', family=family, units=len(data), locale=locale)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest='action', required=True)
    p = sub.add_parser('prepare')
    p.add_argument('--job', type=Path, required=True); p.add_argument('--target', type=Path, required=True)
    p.add_argument('--locale', required=True); p.add_argument('--stage', required=True, choices=['initial', 'independent-diff', 'correction-delta'])
    p.add_argument('--family', required=True, choices=['existing-supplement935', 'chapter-gallery-case134'])
    p.add_argument('--contract', type=Path, required=True); p.add_argument('--context', type=Path, action='append', required=True)
    p.add_argument('--catalog', type=Path)
    p = sub.add_parser('run'); p.add_argument('--job', type=Path, required=True)
    args = parser.parse_args()
    if args.action == 'run':
        run(args.job)
    else:
        prepare(args.job, args.target, args.locale, args.stage, args.family, args.contract, args.context, args.catalog)
