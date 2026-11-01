"""Verify and reconcile actual semantic receipts; never manufacture judgments."""
from pathlib import Path
import hashlib
import json
import sys

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CONTROL = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'tools'))
from forest_localization import core

CACHE = {}


def sha(path):
    path = Path(path)
    if path not in CACHE:
        CACHE[path] = hashlib.sha256(path.read_bytes()).hexdigest()
    return CACHE[path]


def read(path):
    return json.loads(Path(path).read_text())


def rows(path):
    return [json.loads(line) for line in Path(path).read_text().splitlines() if line.strip()]


def bind(path):
    return dict(path=str(path.relative_to(ROOT)), sha256=sha(path), bytes=path.stat().st_size)


def pin(path, expected, snapshots):
    path = Path(path)
    if sha(path) == expected:
        return
    replacement = snapshots.get((str(path.relative_to(ROOT)), expected))
    assert replacement and sha(replacement) == expected, ('Unreconciled changed input', path)


def review(phase, translations, preserved, snapshots):
    task = read(phase / 'task.json')
    runtime = read(phase / 'runtime-verification.json')
    actual = runtime['actualRuntime']
    assert actual['session']['source'] == 'exec' and actual['session']['parent_thread_id'] is None
    assert actual['session']['model_provider'] == 'openai'
    assert actual['turn'] == dict(model='gpt-6.1-sol', effort='high')
    exit_receipt = read(phase / 'process-exit.json')
    assert exit_receipt['exitCode'] == 0
    for name, expected in task['job']['immutablePins'].items():
        pin(ROOT / name, expected, snapshots)
    packet_path = ROOT / task['task']['reviewPacket']
    assert sha(packet_path) == task['task']['reviewPacketSha256']
    packet = {r['id']: r for r in rows(packet_path)}
    result = read(phase / 'result.json')
    coverage = result['verifiedReviewCoverage']
    assert not coverage['pendingIds'] and not coverage['unreadIds'] and not coverage['missingReviewIds']
    for evidence in result['evidence']:
        assert sha(ROOT / evidence['path']) == evidence['sha256']
    assert read(phase / 'review-output/pending-ledger.json')['contextComplete'] is True
    judgments = rows(ROOT / result['reviews'])
    assert len(judgments) == len(packet) == len({r['id'] for r in judgments})
    for judgment in judgments:
        ident = judgment['id']
        assert judgment.get('reviewed') is not False and ident in packet
        assert judgment['reviewerThreadId'] == runtime['threadId']
        assert judgment['model'] == 'gpt-6.1-sol' and judgment['reasoning'] == 'high' and judgment['provider'] == 'openai'
        assert judgment.get('rationale') or judgment.get('fidelityRationale')
        for field in ['sourceSha256', 'targetSha256']:
            assert judgment[field] == packet[ident][field]
        if judgment['verdict'] == 'technical-preservation':
            assert ident in preserved and judgment['sourceSha256'] == judgment['targetSha256'] == preserved[ident]
    return dict(phase=bind(phase / 'result.json'), packet=bind(packet_path),
                reviewerThreadId=runtime['threadId'], usage=exit_receipt['usage'],
                inputPinsVerified=len(task['job']['immutablePins']), contextComplete=True), judgments


def main():
    shared = ROOT / 'localization/completion/single-file-parallel-20261101-01'
    source_glossary = shared / 'shared/glossary-en.json'
    master = ROOT.parent / 'SiteForMods/data/games/the-forest-of-love'
    assert sha(source_glossary) == sha(master / 'glossary.json')
    master_layers = read(master / 'glossary-translations.json')
    preserved = read(shared / 'shared/source-preservation.json')['baselinePreserved']
    assert len(preserved) == 1781
    framework_path = ROOT / 'localization/framework/forest045-shared-v2/framework.json'
    framework, catalog = core.framework_manifest(framework_path.parent)
    catalog_map = {r['id']: r for r in catalog}
    assert len(catalog_map) == len(catalog) == 14606
    engine_pins, engine_hash = core.engine_fingerprint()
    repair = ROOT / 'localization/editorial-delivery/zh-single-file-20261101-01/repair-02'
    repairs = {r['id']: r for r in rows(repair / 'authored-corrections.jsonl')}
    assert len(repairs) == 18
    snapshots = {('localization/languages/zh.json', 'c68dee191f1556f65ea9cb614fd87487e4a6911f01c77116ce4d24db5ee5cc34'): repair / 'language-before.json'}
    configs = {
        'es-419': dict(primary='localization/editorial-delivery/es-419-single-file-20261101-01/final-v2/primary-wording-read.jsonl',
                       primaryBinding='localization/editorial-delivery/es-419-single-file-20261101-01/final-v2/primary-notes.json',
                       artifact='dist/Forest-es-419-0e39c375aae5'),
        'pt-BR': dict(primary='localization/editorial-delivery/pt-BR-single-file-20261101-01/final-v2/primary-ledger.jsonl',
                      primaryBinding='localization/editorial-delivery/pt-BR-single-file-20261101-01/final-v2/coverage.json',
                      artifact='dist/Forest-pt-BR-996baeefc8a2'),
        'zh': dict(primary='localization/editorial-delivery/zh-single-file-20261101-01/primary-evidence-ledger.jsonl',
                   primaryBinding='localization/editorial-delivery/zh-single-file-20261101-01/primary-reading-binding.json',
                   artifact='dist/Forest-zh-ec9f055c7d07')}
    reports = {}
    for locale, config in configs.items():
        language = ROOT / 'localization/languages' / (locale + '.json')
        doc = read(language)
        target = doc['translations']
        assert set(target) == set(catalog_map)
        assert doc['framework']['sha256'] == sha(framework_path)
        assert read(shared / locale / 'glossary.json') == master_layers[locale]
        for ident, item in target.items():
            assert item['source'] == catalog_map[ident]['source'] and isinstance(item['target'], str)
        for ident, expected in preserved.items():
            item = target[ident]
            assert item['source'] == item['target'] and hashlib.sha256(item['target'].encode()).hexdigest() == expected
        hashes = {ident: {f + 'Sha256': hashlib.sha256(item[f].encode()).hexdigest() for f in ['source', 'target']}
                  for ident, item in target.items()}
        primary_path = ROOT / config['primary']
        primary_rows = rows(primary_path)
        primary = {r['id']: r for r in primary_rows}
        assert len(primary) == len(primary_rows)
        ordinary = set(target) - set(preserved)
        assert ordinary <= set(primary) and len(ordinary) == 12825
        corrected_primary = []
        for ident, judgment in primary.items():
            assert judgment['sourceSha256'] == hashes[ident]['sourceSha256']
            if locale == 'zh' and ident in repairs:
                correction = repairs[ident]
                assert judgment['targetSha256'] == correction['beforeSha256']
                assert correction['targetSha256'] == hashes[ident]['targetSha256']
                assert correction['rationale'] and correction['independent'] is False
                corrected_primary.append(ident)
            else:
                assert judgment['targetSha256'] == hashes[ident]['targetSha256']
        phase = ROOT / 'outputs/single-file-review-20261101-01' / locale / 'independent-01'
        receipt, judgments = review(phase, target, preserved, snapshots if locale == 'zh' else {})
        current = {r['id']: r for r in judgments}
        independent_receipts = [receipt]
        if locale == 'zh':
            delta_phase = ROOT / 'outputs/single-file-editorial-acceptance-20261101-01/zh/independent-02'
            delta_receipt, delta = review(delta_phase, target, preserved, {})
            policy = read(repair / 'closure-policy.json')['components']
            assert set(current) == set(policy['previousClosure'])
            assert {r['id'] for r in delta} == set(policy['exactDelta'])
            assert set(policy['exactDelta']) == set(policy['corrected']) | (set(policy['currentClosure']) - set(policy['previousClosure']))
            assert set(policy['corrected']) == set(repairs) == set(corrected_primary)
            assert {r['id'] for r in judgments if r['verdict'] not in ['pass', 'clean', 'technical-preservation']} == set(repairs)
            current.update({r['id']: r for r in delta})
            assert set(current) == set(policy['currentClosure']) and len(current) == 1730
            independent_receipts.append(delta_receipt)
        for ident, judgment in current.items():
            assert judgment['verdict'] in ['pass', 'clean', 'technical-preservation'], (locale, ident, judgment['verdict'])
            assert all(judgment[f] == hashes[ident][f] for f in ['sourceSha256', 'targetSha256'])
        if locale == 'pt-BR':
            context_rows = rows(phase / 'context-reading-ledger.jsonl')
            assert len(context_rows) == len({r['id'] for r in context_rows}) == 1056
            for row in context_rows:
                assert all(row[f] == hashes[row['id']][f] for f in ['sourceSha256', 'targetSha256'])
        artifact = ROOT / config['artifact']
        manifest = read(artifact / 'manifest.json')
        assert manifest['languageSha256'] == sha(language) and manifest['compilerSha256'] == engine_hash
        assert manifest['engineInputs'] == engine_pins
        assert len(manifest['files']) == 16 and manifest['frameworkSha256'] == sha(framework_path)
        for name, expected in manifest['files'].items():
            path = artifact / name
            assert path.stat().st_size == expected['bytes'] and sha(path) == expected['sha256']
        reports[locale] = dict(status='game-text-editorial-and-static-accepted-under-pinned-glossary',
            language=bind(language), sourceCatalog=bind(framework_path.parent / 'catalog.json'),
            glossarySource=bind(source_glossary), glossaryTarget=bind(shared / locale / 'glossary.json'),
            primaryEvidence=bind(primary_path), primaryBinding=bind(ROOT / config['primaryBinding']),
            primaryLinguisticUnits=12825, sourcePreservedUnits=1781, totalUnits=14606,
            correctedPrimaryVersions=len(corrected_primary), independentReceipts=independent_receipts,
            independentCurrentClosureUnits=len(current), independentSourcePreservationJudgments=sum(r['id'] in preserved for r in current.values()),
            unreadPrimary=0, unreadIndependent=0, unreadRequiredContext=0, unresolvedObjectiveFindings=0,
            artifact=bind(artifact / 'manifest.json'), verifiedResourceCount=16,
            unchangedHistoricalReviewCandidates='Not promoted; complete current primary pass and required independent closure/delta supply this acceptance',
            excludedGates=dict(humanNSFWGlossary='owner-deferred', fontsNativeLayout='not-accepted', gameRuntime='not-run', installerRelease='not-accepted', publicationDeployment='not-run'))
        print(locale, 'verified', reports[locale]['totalUnits'], 'units,', len(current), 'current independent closure IDs and16 resources')
    report = dict(format='forest-three-locale-game-text-acceptance-v1', locales=reports,
        scope='Current pinned-glossary game text and static resources only; independent closure does not claim every unchanged target was independently reread',
        compilerSha256=engine_hash, deterministicReconciliation='Exact IDs/hashes/coverage/contexts only; semantic judgments remain their original model evidence',
        sourceAndGlossaryChanges=False, newGameOrReleaseActions=False)
    output = CONTROL / 'acceptance.json'
    assert not output.exists(), 'Acceptance already published; reconcile before rewriting'
    output.write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
