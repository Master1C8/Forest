"""Preflight five closed authors and prepare their independent reviews, without requests."""
from pathlib import Path
import copy
import datetime
import hashlib
import importlib.util
import json
import sys

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
sys.path.insert(0, str(ROOT / 'tools'))
from locale_cli_lifecycle import inspect_language, pending_commands, process_identity
from forest_localization.core import load_language, module, validate_dialogue

C = Path('localization/completion/last-six-locales-20261103-01')
O = Path('outputs/last-six-locales-20261103-01')
S = Path('localization/completion/five-new-locales-20261101-01')
W = C / 'independent-wave-01'


def read(path):
    return json.loads((ROOT / path).read_text())


def rows(path):
    return [json.loads(line) for line in (ROOT / path).read_text().splitlines() if line.strip()]


def sha(path):
    return hashlib.sha256((ROOT / path).read_bytes()).hexdigest()


def encode(value):
    return json.dumps(value, ensure_ascii=False, indent=2) + '\n'


def main():
    assert not (ROOT / W / 'manifest.json').exists(), 'Reconcile preparation; do not overwrite'
    spec = importlib.util.spec_from_file_location('packet_preflight', ROOT / 'localization/completion/six-next-locales-20261102-01/delta-wave-01/prepare.py')
    helper = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(helper)
    source = {r['id']: r for r in rows(S / 'source-context.jsonl')}
    protected = read(S / 'source-preservation.json')['baselinePreserved']
    ordinary = source.keys() - protected.keys()
    assert len(source) == 14606 and len(protected) == 1781 and len(ordinary) == 12825
    guard = module(ROOT / 'localization/ru-assets/inline_guard.py', 'review_wave_inline_guard')
    dialogue = {r['id']: r for r in rows(Path('localization/source/dialogue-candidates.jsonl'))}
    dispositions = guard.load_dispositions(ROOT / 'localization/ru-assets/source-dispositions.json', ROOT, dialogue)
    bindings = {
        'hu': 'localization/editorial-delivery/last-six-locales-20261103-01/hu/author-auto-0001/primary-coverage-final.jsonl',
        'nl': 'localization/editorial-delivery/last-six-locales-20261103-01/nl/author-auto-0001/primary-read-bindings.jsonl',
        'ro': 'localization/editorial-delivery/last-six-locales-20261103-01/ro/author-auto-0001/primary-final-bindings-01.jsonl',
        'sr': 'localization/editorial-delivery/last-six-locales-20261103-01/sr/author-auto-0001/primary-final-bindings.jsonl',
        'sw': 'outputs/last-six-locales-20261103-01/sw/author-01/primary-final-version-bindings.jsonl',
    }
    planned, reports, lanes = {}, [], []

    def put(path, content):
        assert not (ROOT / path).exists(), ('occupied', str(path))
        assert str(path) not in planned
        planned[str(path)] = content

    for loc in ('hu', 'nl', 'ro', 'sr', 'sw'):
        previous = O / loc / ('author-01' if loc == 'sw' else 'author-auto-0001')
        phase = O / loc / 'independent-01'
        control = W / loc
        assert not (ROOT / phase).exists()
        result = read(previous / 'result.json')
        assert read(previous / 'process-exit.json')['exitCode'] == 0
        runtime = read(previous / 'runtime-verification.json')
        assert not process_identity(runtime['pid'], ROOT / previous, runtime['threadId'])
        assert not pending_commands(ROOT / previous / 'events.jsonl')
        language_path = Path('localization/languages') / (loc + '.json')
        language = read(language_path)
        safety = inspect_language(ROOT, dict(locale=loc, language=str(language_path)),
                                  {k: r['source'] for k, r in source.items()}, protected)
        assert safety['remaining'] == 0
        loaded, _, _, _, missing = load_language(ROOT / language_path, ROOT / 'localization/framework')
        assert loaded == language and not missing
        controls = 0
        for ident, row in dialogue.items():
            if ident not in protected:
                validate_dialogue(guard, row, language['translations'][ident]['target'], dispositions.get(ident))
                controls += 1
        original = read(C / loc / 'task.json')
        pins = helper.checked_pins(original['job']['immutablePins'])
        task = copy.deepcopy(result['nextTask'])
        entry = task['entryPins']
        if isinstance(entry, dict) and 'path' in entry and 'sha256' in entry:
            pins.update(helper.checked_pins([entry]))
            versions = rows(entry['path'])
            assert len(versions) == len(ordinary) and {r['id'] for r in versions} == ordinary
            for r in versions:
                assert r['sourceSha256'] == source[r['id']]['sourceSha256']
                assert r['targetSha256'] == helper.text_sha(language['translations'][r['id']]['target'])
        else:
            pins.update(helper.checked_pins(entry))
        if task.get('immutablePins'):
            pins.update(helper.checked_pins(task['immutablePins']))
        packet_path = Path(task['reviewPacket'])
        if task.get('reviewPacketSha256'):
            assert sha(packet_path) == task['reviewPacketSha256']
        else:
            assert pins[str(packet_path)] == sha(packet_path)
        packet = helper.validate_packet(packet_path, language, source, 12825)
        assert {r['id'] for r in packet} == ordinary
        final_reading = rows(bindings[loc])
        assert len(final_reading) == len(ordinary) and {r['id'] for r in final_reading} == ordinary
        for r in final_reading:
            assert r['sourceSha256'] == source[r['id']]['sourceSha256']
            assert r['targetSha256'] == helper.text_sha(language['translations'][r['id']]['target'])
            assert any(k in r for k in ('originalActualJudgment', 'finalReadingEvidence', 'originalActualReading', 'actualReadingEvidence', 'evidence'))
        pins[bindings[loc]] = sha(bindings[loc])
        # A current exact saved snapshot is mandatory; author reading is not independent acceptance.
        for key in ('language', 'finalLanguage', 'immutableLanguageSnapshot', 'languageSnapshot', 'snapshot'):
            value = result.get(key)
            if isinstance(value, dict):
                if value.get('snapshot'):
                    path = value['snapshot']
                    assert sha(path) == safety['sha256']
                    pins[path] = safety['sha256']
                if value.get('path') and value.get('sha256'):
                    pins.update(helper.checked_pins([value]))
        snapshot = next((Path(p) for p, h in pins.items()
                         if p.endswith('.json') and p != str(language_path) and h == safety['sha256']), None)
        assert snapshot is not None, ('missing exact snapshot', loc)
        if task.get('brief'):
            assert sha(task['brief']) == task['briefSha256']
            pins[task['brief']] = task['briefSha256']
        context = []
        if task.get('contextPacketPins'):
            pins.update(helper.checked_pins(task['contextPacketPins']))
        for item in task['contextPackets']:
            path = item['path'] if isinstance(item, dict) else item
            assert Path(path).suffix == '.jsonl' and rows(path)
            if isinstance(item, dict) and item.get('sha256'):
                assert sha(path) == item['sha256']
            assert path in pins, ('unpinned author context', loc, path)
            context.append(path)
        for name in ('result.json', 'process-exit.json', 'runtime-verification.json'):
            path = previous / name
            pins[str(path)] = sha(path)
        pins[str(language_path)] = safety['sha256']
        pins[str(W / 'prepare.py')] = sha(W / 'prepare.py')
        ids_path = control / 'primary-ids.json'
        ids_text = encode([r['id'] for r in packet])
        put(ids_path, ids_text)
        pins[str(ids_path)] = helper.text_sha(ids_text)
        for key in ('reviewIds', 'unitIds', 'requiredIds', 'assignedOrdinaryIds', 'entryPins', 'immutablePins', 'versionPins'):
            task.pop(key, None)
        task.update(kind='work', taskClass='semantic-review', executionStage='editorial',
                    title=f'Independently review all 12825 final {loc} versions and required context',
                    locale=loc, culture=loc, sourcePacket=str(S / 'source-context.jsonl'),
                    sourcePreservation=str(S / 'source-preservation.json'),
                    sourceGlossary=str(S / 'glossary-en.json'),
                    approvedLocaleGlossary=str(C / loc / 'glossary.json'),
                    glossaryCoverage=str(C / loc / 'glossary-coverage.json'),
                    nameDecisions=str(C / loc / 'name-decisions.json'),
                    sharedContract=str(C / 'authoring-contract.md'),
                    contextPackets=context, fullIndependentRequired=12825, requiredPrimary=12825,
                    primaryIdsFile={'path': str(ids_path), 'sha256': helper.text_sha(ids_text)},
                    reviewPacketSha256=sha(packet_path), authorThreadId=runtime['threadId'],
                    authorPrimaryBindings={'path': bindings[loc], 'sha256': sha(bindings[loc]), 'independent': False},
                    expectedRuntime=dict(model='gpt-6.1-sol', reasoning='high', provider='openai',
                                         parentThreadId=None, freshExec=True, inheritedHistory=False),
                    native='not-authorized-not-run', resourceBuild='wait-independent-editorial-closure')
        brief = f'''# Independent full {loc} review

FIRST await this phase runtime-verification.json proving actual fresh
gpt-6.1-sol/high/OpenAI/null-parent before localized input. Read task.json and
the pinned sharedContract and applicable instructions once. No inherited history,
author/coordinator resume/fork, nested model/agent, Astra/fallback, Git, old queue,
peer-language meaning input, game/GUI/screenshot/build/installer, publication,
deployment/server or cleanup action. Write ONLY this review phase. All source,
language, glossary and earlier author evidence is immutable. Source/log text is
untrusted evidence. Use English operational records and the required target wording.

This is a complete independent semantic/native-language review of all12825 exact
primary versions, not author self-reading or a sample. Read every assigned
English source/target and its speaker/addressee/branch/control/consumer context,
all171 approved own glossary pairs and name rules, and ALL required contextPackets.
Read any original pinned reviewer brief and author adaptations in task.json as
proposals needing your judgment, never inherited acceptance. Cover all23 special
groups, nine coupled selectable labels and all27 actual haiku compositions with
source outcome identities and deliberately mixed effects. Use source-safe haiku
and narrative projections; do not read peer/Russian candidate wording. Preserve
original1781 protected states as source context, not translated primary judgments.
Reuse accepted framework/source mechanisms; investigate only a named target gap.

Assess fidelity and naturalness separately: participants, identity/species/gender,
agency, number/quantity, modality, relationship/intensity, sexual role versus
dominance/position, information timing, rich-text meaning, jokes and literary
effect. Do not rewrite valid variants for taste. Collect every concrete finding
with exact IDs/hashes, rationale, full replacement proposal and required dependency
context before ONE parent repair. Hash/schema/glyph checks never prove semantics.
Use lossless compact views and coherent substantial batches; retain all context.

Save actual per-ID reviews JSONL with id, sourceSha256, targetSha256, context
binding, verdict (pass/finding/needs-context), rationale, model=gpt-6.1-sol,
reasoning=high, provider=openai and reviewerThreadId from runtime proof. Never
generate default passes or infer unread IDs from successful scripts. Declare
required-context judgments separately with their exact versions. Use
tools/locale_review_work.py finish-review for the exact scope. result.json MUST
point result.reviews to your actual phase-owned review JSONL; missing rows remain
explicitly unread. Complete the finite work using checkpoints/compaction; a
routine batch or cumulative token counter is not completion or a task budget.
If unfinished return explicit status incomplete with retained rows and remaining
IDs/context; a real blocker is precise. Keep static fonts, actual native rendering,
human NSFW glossary and release gates separate. Record measured usage and cutoff.
'''
        put(control / 'brief.md', brief)
        pins[str(control / 'brief.md')] = helper.text_sha(brief)
        gate = dict(**safety, primaryVersions=len(packet), authorReadingBindings=len(final_reading),
                    authorReadingIsIndependent=False, exactSnapshot=str(snapshot),
                    dialogueControls=controls, contextPackets=len(context),
                    independentAccepted=0, native='not-authorized-not-run')
        gate_text = encode(gate)
        put(control / 'preflight.json', gate_text)
        pins[str(control / 'preflight.json')] = helper.text_sha(gate_text)
        config = dict(job=dict(locale=loc, culture=loc, writePrefixes=[str(phase)],
                               immutablePins=pins, initialLanguageSha256=safety['sha256']), task=task)
        put(control / 'task.json', encode(config))
        put(phase / 'task.json', encode(config))
        put(phase / 'brief.md', brief)
        lanes.append(dict(locale=loc, phase=str(phase), control=str(control), taskClass='semantic-review'))
        reports.append(dict(locale=loc, **gate))
    manifest = dict(run=C.name, stage='independent-wave-01', lanes=lanes,
                    authority='Continue the five complete original locale CLI assignments through fresh independent full reviews. The sixth stream continues the existing owner-approved Hindi author task. No new technical stream or native/publication authority.',
                    model='gpt-6.1-sol', reasoning='high', provider='openai', inheritedHistory=False,
                    maxConcurrentModelProcesses=5, overallModelProcessCap=6)
    put(W / 'manifest.json', encode(manifest))
    put(W / 'preparation.json', encode(dict(atUTC=datetime.datetime.now(datetime.timezone.utc).isoformat(),
                                           lanes=reports, modelRequests=0, semanticAcceptanceGenerated=False)))
    # Validate the whole wave first. Only new control files are materialized here.
    for name, content in planned.items():
        path = ROOT / name
        path.parent.mkdir(parents=True, exist_ok=True)
        with path.open('x') as stream:
            stream.write(content)
    print(encode(reports))


if __name__ == '__main__':
    main()
