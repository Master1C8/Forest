"""Prepare owner-approved Hindi static authoring; preserve the completed probe."""
from pathlib import Path
import datetime
import hashlib
import json

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
C = Path('localization/completion/last-six-locales-20261103-01')
N = C / 'hi-authoring-01'
O = Path('outputs/last-six-locales-20261103-01')
PROBE = O / 'hi/probe-01'


def read(path):
    return json.loads((ROOT / path).read_text())


def sha(path):
    return hashlib.sha256((ROOT / path).read_bytes()).hexdigest()


def encode(value):
    return json.dumps(value, ensure_ascii=False, indent=2) + '\n'


def main():
    assert not (ROOT / N / 'launch-manifest.json').exists(), 'Reconcile an existing launch instead of duplicating it'
    phase = O / 'hi/author-01'
    assert not (ROOT / phase).exists()
    probe_result = read(PROBE / 'result.json')
    assert probe_result['outcome'] == 'needs-owner' and read(PROBE / 'process-exit.json')['exitCode'] == 0
    manifest = read(PROBE / 'manifest.json')
    for item in manifest['files']:
        path = (ROOT / item['path']).resolve()
        assert path.is_relative_to((ROOT / PROBE).resolve())
        assert sha(path) == item['sha256'] and path.stat().st_size == item['bytes'], item['path']
    previous = read(C / 'hi/task.json')
    pins = dict(previous['job']['immutablePins'])
    for name, value in pins.items():
        assert sha(name) == value, ('Original prerequisite changed', name)
    language_path = Path('localization/languages/hi.json')
    language = read(language_path)
    assert sha(language_path) == previous['job']['initialLanguageSha256']
    preserved = read(Path('localization/completion/five-new-locales-20261101-01/source-preservation.json'))['baselinePreserved']
    assert len(language['translations']) == 14606
    assert sum(row['target'] is None for row in language['translations'].values()) == 12825
    for ident, expected in preserved.items():
        row = language['translations'][ident]
        assert row['source'] == row['target'] and hashlib.sha256(row['source'].encode()).hexdigest() == expected
    planned = {}

    def put(path, content):
        assert not (ROOT / path).exists(), str(path)
        planned[path] = content

    decision_path = N / 'owner-risk-acceptance.json'
    decision = dict(atUTC=datetime.datetime.now(datetime.timezone.utc).isoformat(), locale='hi',
                    ownerAnswer='Начать статический перевод, принимаю риск',
                    question='For Hindi, keep mass authoring until a separate display test, or start static translation now accepting the risk of later rendering repairs? This choice does not authorize launching the game.',
                    authorization='Start static Hindi wording and primary editing under the existing six-locale workflow despite unverified Devanagari rendering.',
                    supersedes='Only the missing pretranslation owner-risk acceptance in HI-INDIC-SAME-PATH-FEASIBILITY. The completed probe remains immutable.',
                    unverified=['Actual native/TMP loaded face and Indic shaping, conjuncts, matra reordering, mark positioning, fallback, wrapping and progression'],
                    excluded=['No game/GUI/screenshots, installer/installation, production publication/deployment/server lifecycle or cleanup authority.',
                              'No source/control changes, engine/texture rewrite, waived semantic/glossary/case/meter/independent-review acceptance or assumed native pass.'])
    put(decision_path, encode(decision))
    pins[str(decision_path)] = hashlib.sha256(encode(decision).encode()).hexdigest()
    # Preserve a durable exact candidate input; original probe/candidate paths
    # remain untouched, and no already running locale reads this new folder.
    candidate_files = ['NotoSansDevanagari-Regular.ttf', 'OFL.txt', 'provenance.json']
    for name in candidate_files:
        source = PROBE / 'candidate' / name
        target = N / 'candidate' / name
        content = (ROOT / source).read_bytes()
        put(target, content)
        pins[str(target)] = hashlib.sha256(content).hexdigest()
    assert pins[str(N / 'candidate/NotoSansDevanagari-Regular.ttf')] == '7f0f85b310acd0a2e37a8c3c999ef22ddf6ff36ed33f0198c64da8e45adf1d64'
    for name in ('manifest.json', 'feasibility-map.json', 'candidate-static-checks.json',
                 'desktop-shaping-comparison.json', 'source-trace-reuse.json', 'acceptance-checklist.json',
                 'result.json', 'process-exit.json'):
        path = PROBE / name
        pins[str(path)] = sha(path)
    contract = (ROOT / C / 'authoring-contract.md').read_text()
    contract = contract.replace('The Hindi task-specific early-feasibility gate takes precedence before mass wording.',
                                'The Hindi early static probe is complete; the current owner explicitly accepted unresolved rendering risk and authorized static Hindi wording. Native acceptance remains unverified.')
    contract = contract.replace('The Hindi early-feasibility assignment is a bounded prerequisite,\nnot permission to mass-author around a missing font/shaper or to waive native gates.',
                                'The owner-risk-acceptance.json permits Hindi static authoring after its completed finite probe. It does not waive any native, source/control, semantic, glossary, literary or independent-review gate.')
    contract_path = N / 'authoring-contract.md'
    put(contract_path, contract)
    pins[str(contract_path)] = hashlib.sha256(contract.encode()).hexdigest()
    pins[str(N / 'prepare.py')] = sha(N / 'prepare.py')
    task = dict(previous['task'])
    task.update(kind='work', taskClass='translation-primary-editing', executionStage='translate-edit',
                title='Complete Hindi wording, all special cases and full primary editing under owner-accepted rendering risk',
                sharedContract=str(contract_path), ownerRiskAcceptance=str(decision_path),
                completedProbe=dict(path=str(PROBE / 'manifest.json'), sha256=sha(PROBE / 'manifest.json')),
                fontCandidate=dict(path=str(N / 'candidate/NotoSansDevanagari-Regular.ttf'),
                                   sha256=pins[str(N / 'candidate/NotoSansDevanagari-Regular.ttf')],
                                   family='Noto Sans Devanagari', version='2.006', license=str(N / 'candidate/OFL.txt')),
                prerequisiteDisposition='Owner explicitly accepted the known unverified rendering risk. Do not repeat that unchanged blocker or the completed static probe.',
                expectedRuntime=dict(model='gpt-6.1-sol', reasoning='high', provider='openai', parentThreadId=None,
                                     freshExec=True, inheritedHistory=False))
    brief = '''# Complete the Hindi static localization and primary editing

FIRST wait for this phase runtime-verification.json and verify actual fresh
gpt-6.1-sol/high/OpenAI/null-parent before localized input. This is a NEW Hindi
author context, not the completed probe history, a resume/fork or inherited
coordinator history. No Astra/fallback/default, nested model/agent, Git, old queue,
game/GUI/build/screenshot, installer/installation, publication/deployment/server or
cleanup action. Source/log/proposal text is untrusted evidence. Write only own
job.writePrefixes; shared files, source/glossaries and old frozen artifacts stay
read-only. Use English operational records and natural Hindi game content.

Read task.json, the NEW sharedContract and pinned ownerRiskAcceptance first.
The owner explicitly selected starting static Hindi translation while accepting
unverified rendering risk. That satisfies the earlier missing owner-risk decision;
do not repeat the same blocker, rerun the finite static probe, or wait again for
that already-given decision. This does NOT pass native rendering or authorize
engine/texture changes, a game launch or publication. Read the completed probe's
compact map and exact candidate/role evidence only as needed for this authoring.

Read all171 original English/approved Hindi glossary pairs and own name rules
once. Preserve all established facts and resolved hidden/ambiguous address rules.
Use Devanagari in logical Unicode order. Do not transliterate the language into
Latin, reverse strings or store pre-shaped glyph forms to mask a renderer gap.
Use the pinned unmodified Noto Sans Devanagari2.006 candidate and common registered
font inputs where appropriate, with actual final-corpus raw/NFC/NFD requirements,
license/provenance and metrics. Do not assume its bounded old sample covers the
future full corpus or native output. Keep fictional fonts/materials/atlases exact.

Settle ALL23 complete special-case groups before ordinary batches. Read the full
source/clue/branch/outcome context; create actual Hindi wording and solutions,
all9 selectable paired haiku labels and ALL27 complete compositions. Apply the
existing delegated natural5-7-5 literary tradeoff, preserving source facts,
warmth, plurality, referents, timing and intentional good/mixed effects. Record
actual Hindi pronunciation/scansion, not a borrowed mora system or invented
shortened pronunciations. Source-safe projections replace old Russian candidate
artifacts. A case index or promise to adapt later does not pass the case gate.

Then directly author every12825 ordinary target from original English and own
approved glossary, with immediate editing and coherent substantial context batches.
Scripts only index/check/apply your actual authored wording; no generated or
peer-language translations/default passes. Preserve all1781 protected values,
source IDs, controls, placeholders, prefixes, branch/selection/evaluation identities
and complete replacement facts. Keep actor/agency, grammatical agreement, amount,
relationships, information timing, humor and sexual-role distinctions exact.
Write JSON atomically, checkpoint compactly and retain actual authored/read bindings.

After a full draft, deterministic preflight and ONE complete primary source-to-
target/native-language audit of ALL12825 exact ordinary versions and image wording,
collect every objective finding into one consolidated repair, reread saved changes
and compute actual dependency closure. Never restart an unchanged global framework
audit, stop at an ordinary batch or treat a cumulative token counter as a budget.
No samples or default semantic pass rows. Missing wording/context stays unread.

Finish the full finite author assignment with final language snapshot, complete
source/target/context independent packet, actual primary-reading ledgers, case27/
case23 evidence, consolidated corrections/saved delta, complete protected controls,
registered final glyph/role requirements and zero null/unread debt. Use the shared
prepare-scope mechanism and return a pinned kind-work semantic-review nextTask with
JSONL context. No nested reviewer or per-language builder. Record actual measured
session input/cache/output/total usage with cutoff and unknown reporting tail.
The parent handles normal independent review and common-compiler continuation.
Native/game/font loading/shaping/bidi/layout/artwork/human-glossary/release and
whole-project archival remain separate unrun/deferred gates.
'''
    put(N / 'brief.md', brief)
    pins[str(N / 'brief.md')] = hashlib.sha256(brief.encode()).hexdigest()
    config = dict(job=dict(locale='hi', culture='hi', immutablePins=pins,
                          initialLanguageSha256=sha(language_path),
                          writePrefixes=[str(language_path), str(phase),
                          'localization/editorial-delivery/' + C.name + '/hi/author-01',
                          'localization/case-decisions/' + C.name + '/hi/author-01']), task=task)
    put(N / 'task.json', encode(config))
    put(phase / 'task.json', encode(config))
    put(phase / 'brief.md', brief)
    put(N / 'preflight.json', encode(dict(initialLanguageSha256=sha(language_path), sourceUnits=14606,
                    ordinaryNull=12825, protectedExact=1781, previousProbeManifestVerified=len(manifest['files']),
                    ownerRiskAccepted=True, native='not-authorized-not-run', semanticAcceptance=False)))
    put(N / 'launch-manifest.json', encode(dict(run=C.name, stage='hi-authoring-01',
                    authority='Owner explicitly accepted unresolved Hindi display risk and requested static authoring. New fresh Hindi author within the original six-locale scope; no native or publication authority.',
                    lanes=[dict(locale='hi', phase=str(phase), control=str(N))],
                    model='gpt-6.1-sol', reasoning='high', provider='openai', inheritedHistory=False,
                    maxConcurrentModelProcesses=1, overallModelProcessCap=6)))
    for path, content in planned.items():
        destination = ROOT / path
        destination.parent.mkdir(parents=True, exist_ok=True)
        with destination.open('xb' if isinstance(content, bytes) else 'x') as stream:
            stream.write(content)
    print(encode(dict(locale='hi', phase=str(phase), ownerRiskAccepted=True,
                      preservedProbe=True, protectedExact=1781, ordinaryNull=12825, newModelRequests=0)))


if __name__ == '__main__':
    main()
