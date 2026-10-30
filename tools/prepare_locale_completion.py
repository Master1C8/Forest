#!/usr/bin/env python3
"""Prepare continuous production lanes from the completed, preserved reconciliation."""
import argparse
import json
from pathlib import Path
import shutil
import subprocess

import locale_queue as queue
from cli_job_support import validate_model
from locale_efficiency import POLICY

ROOT=Path('/Users/antonkrutov/Desktop/Forest')
LOCALES=('zh','es','es-419','pt-BR','ja','de')
CONTRACT='''# Continuous Forest completion contract

The current owner explicitly ordered actual continuous completion of the six
existing locale-owned localization queues. There is no permanent technical
stream. Execute wording/editing/review/resource work directly within your locale.
Previous reconciliation results are accepted as planning/evidence handoffs only,
not semantic or release acceptance. Their old "stop for parent review" clauses
are superseded for routine authorized local continuation. Do not repeat them.

This v3 run's immutablePins and current lane state govern execution. The v2
locale_queue.py snapshot becomes historical after authorized own-locale edits;
do not use its expected target drift as an unchanged-source blocker or rerun
the initial reconciliation. Preserve old receipts and current frozen helpers.

Read applicable AGENTS.md, sitefor-mods.md and both mandatory universal game
localization manuals once per fresh context. Use vn-game-localize for linguistic
work, its universal editorial algorithm and the actual approved locale glossary.
Use English for instructions/reports and required language for authored game text.
Verify actual runtime-verification.json before localized inputs. Only explicit
Sol/high/OpenAI, fresh exec/no inherited history; NEVER Astra, fallback, resume,
fork, nested agents/CLI/models, external translation or generated wording.

One phase handles a finite substantive batch (normally 100–300 contextual units;
fewer for complex prose/verse). Finish before context exhaustion. A phase boundary
is not a job stop. Write a concise next brief within this phase and outcome
continue; the supervisor automatically starts the next fresh phase. Context size,
parent review, an ordinary batch end or an expected disjoint parent Git commit
are not blockers. Six locale-owned streams include Japanese. Never create a technical stream
or stop another locale. Only the parent may mutate Git/index/HEAD.

Perform real work: author/edit admitted target phrases, finish outstanding
independent review, apply adjudicated corrections, implement/reproduce resources,
or resolve exact source/locale decisions. Planning a next task alone is not work.
Do not perpetually reconcile the same evidence or follow framework callees.
Keep source-admitted special-case decisions before new ordinary translation.
Use the explicit preserved preliminary-dialogue exception only within its scope.
An unresolved source predicate holds its exact selectors, not independent work.
Preserve original source, protected glossary, old immutable reviews/execution
inputs and other languages. Do not reinterpret missing evidence as pass.

Review: universal deterministic preflight -> one full semantic reading -> one
consolidated correction batch -> reproducible dependency closure -> distinct fresh
independent diff review -> exact correction deltas -> final deterministic gate.
Retain matching unaffected receipts. Source/inventory/glossary/mapping changes
use the universal invalidation boundary. No extra full rereads for taste. Read
every assigned source/target/context; no default pass rows or sample acceptance.
The reviewer is a distinct fresh CLI process without author history. An author
prepares an immutable JSONL review packet with unique id/source/target and exact
sourceSha256/targetSha256. The next task kind is review. Reviewer writes JSONL
reviews with those IDs/hashes, explicit verdict and objective rationale. Findings
lead automatically to a work repair phase and then exact independent delta.

Current phase tasks and version-matching owning receipts define each locale's
resume point. Never restart an old initial packet or reread completed units
because a historical task description names them. Keep explicitly unread units
and context in the exact current pending ledger.

Review transport: explicit verdict/rationale (or fidelity plus native-language
rationale) and exact source/target hashes are required. A partial continue may
supply sparse judgments; every missing primary ID remains unread and version-bound
in its next review carryover. Declared context rows have separate coverage and
must not inflate primary counts. Unknown or changed context versions reject.
Retain exact inherited non-pass evidence without crediting unread units. Next
briefs remain owned by the completed phase and bounded to64KiB. Scope a new
wording packet with the shared preparation tool; preserve the complete evidence.

After the initial task, continue all useful admitted work in the28-family catalog:
saved dialogue repairs, 935 UI, inventory52/glitch, chapter/gallery, remaining51,
Bio/input/pause/counters/ornamental/narrative, exact native notifications, scene
labels, temporary speakers, storm/minigame, Adventures/Lantern/completion, haiku,
then corpus/font/resource/package checks. Reuse valid existing translations and
Russian mechanisms; author language wording from English and the approved locale
glossary. Do not copy Russian wording, sizes, script feasibility or acceptance.
Keep dormant/source-held selectors, fictional mouse mappings and technical keys.
All original textures/streams, source compression/CAB and Addressables CRC/size
must survive. Existing owner test build/saves are never disposable fixtures.

Apply the shared accepted-Russian procedures directly with explicit locale data.
Use tools/locale_build.py for saved candidate materialization/checks and the
existing tools/locale_resources.py for supported data-driven resource families.
These commands do not need a model to wrap manifests or acknowledge receipts.
Reuse historical immutable implementations and matching reviews by fingerprint.
The coordinator fixes a concrete shared defect once; never wait for a retired
technical stream, repeat whole-framework research or create per-family metadata
phases. Keep every genuine source/editorial/font/native/runtime gate explicit.

No game/GUI/image/screenshot/installer launch, owner installation/save write,
publication/deployment/server action. Required native checks remain not-run.
Do not claim the whole localization ready while any mandatory criterion is open.

Write result.json using this exact continuation schema:
{
  "outcome":"continue|blocked|static-complete", "summary":"concrete result",
  "progress":{"kind":"authored|edited|reviewed|source-decisions|resource-build|technical-proof","unitIds":["actual IDs"]},
  "evidence":[{"path":"project-relative own-lane artifact","sha256":"actual hash"}],
  "nextTask":{"kind":"work|review","title":"finite deliverable","brief":"project-relative path to this phase's next.md"}
}
For a review phase also provide reviews (project-relative JSONL path). A next
review task also provides reviewPacket (project-relative JSONL path). Put enough
source/context/dependency pins in the next brief for a fresh process; no history.
Keep source/target/control data exact. Do not edit task.json, copied brief.md,
supervisor status/plan, logs/events, runtime receipt, claims or execution files.

Use blocked only when all independent authorized static work is exhausted, with
independentWorkRemaining:false and blockers listing predicate/evidence/nextAction.
An unknown request/transport failure is held for exact reconciliation, never
automatically retried. Use static-complete only with a dispositionMatrix listing
every requiredDeliverables ID once, status accepted/not-applicable and actual
evidence. Source holds are not completion. Report public readiness simply:
ready yes/no; actual completed work; what remains; running/blocked with cause.
'''


def prepare(directory):
    directory=directory.resolve()
    validate_model('gpt-6.1-sol','high','openai')
    if directory.exists() or not directory.is_relative_to(ROOT/'outputs/locale-assets-20261026'):
        raise ValueError('Use a fresh continuation group under the existing queue')
    queue.check(ROOT)
    old=ROOT/'outputs/locale-assets-20261026/workflow-v2-launch-20261029-01'
    previous=queue.read(old/'status.json')
    if previous['status']!='finished-awaiting-parent-review':raise ValueError('Prior six outcomes are not reconciled')
    for row in previous['entries']:
        if row['status']!='completed-awaiting-parent-review' or row.get('exitCode')!=0:
            raise ValueError('Prior request did not complete successfully')
        if queue.sha(Path(row['packet'])/'result.json')!=row['resultSha256']:
            raise ValueError('Reconciliation result changed')
    for loc in LOCALES:
        for base in ['outputs/locale-assets-20261026','outputs/editorial-20261027']:
            queue.assert_idle(ROOT/base/loc)
    spec=queue.read(ROOT/'localization/completion/process-spec.json')
    registry=queue.read(Path.home()/'.codex/models_cache.json')
    if not any(r.get('slug')=='gpt-6.1-sol' for r in registry['models']):raise ValueError('Exact Sol model unavailable')
    directory.mkdir(parents=True);execution=directory/'execution';execution.mkdir()
    for name in ['run_locale_completion.py','cli_job_support.py','cli_runtime_identity.py','locale_queue.py','locale_efficiency.py','locale_review_work.py','locale_dependency_wake.py','locale_dispatch_policy.py']:
        shutil.copyfile(ROOT/'tools'/name,execution/name)
    (directory/'CONTRACT.md').write_text(CONTRACT+'\n'+POLICY)
    common=[ROOT/'localization/source/dialogue-candidates.jsonl',ROOT/'localization/source/dialogue-manifest.json',
            ROOT/'localization/glossary/en.json',ROOT/'localization/completion/process-spec.json',
            Path('/Users/antonkrutov/.codex/instructions/sitefor-mods.md'),
            Path('/Users/antonkrutov/.codex/instructions/game-localization-prompt.md'),
            Path('/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md')]
    jobs=[]
    for loc in LOCALES:
        lane=ROOT/f'outputs/locale-assets-20261026/{loc}/workflow-v3-completion-20261030';lane.mkdir()
        prior=ROOT/f'outputs/locale-assets-20261026/{loc}/workflow-v2/reconcile-saved-evidence/result.json'
        data=queue.read(prior);proposal=next(v for k,v in data.items() if 'next' in k.lower() and isinstance(v,dict))
        queue.write(lane/'selected-prior-task.json',proposal)
        kind='review' if loc=='ja' else 'work'
        initial=lane/'first.md'
        first_task=dict(kind=kind,title='Complete '+loc+' outstanding review/repairs and admitted localization work',brief=str(initial.relative_to(ROOT)))
        extra=''
        if loc=='ja':
            base=ROOT/'outputs/editorial-20261027/japanese-independent-review-v1/ja'
            remaining=(base/'remaining-semantic-ids.txt').read_text().splitlines()
            rows={r['id']:r for r in queue.rows(base/'review-cycle-01/review-rows.jsonl')}
            corpus={r['id']:r for r in queue.rows(ROOT/'localization/ja-assets/dialogue.ja.jsonl')}
            if len(remaining)!=3241 or len(set(remaining))!=3241:raise ValueError('Japanese remaining scope changed')
            packet=lane/'first-review.jsonl'
            with packet.open('x') as f:
                for ident in remaining[:150]:
                    row=rows[ident]
                    if any(row[k]!=corpus[ident][k] for k in ['sourceSha256','targetSha256']):raise ValueError('Japanese review input changed')
                    f.write(json.dumps(row,ensure_ascii=False)+'\n')
            first_task.update(reviewPacket=str(packet.relative_to(ROOT)),reviewPacketSha256=queue.sha(packet))
            extra=f'Actually read/review all150 IDs in {packet}, with their required original context. Retain the192 prior matching judgments. Continue the3241 unread IDs in successive fresh packets; never reread the completed draft or claim the first150 completes the whole closure.'
        elif loc=='es':
            extra='Adjudicate the four saved independent findings now, apply the objectively supported wording repair through the own-locale authored inputs, reproduce exact dependency closure, and hand off a fresh independent delta review. Preserve genuine consumer/source holds and continue admitted independent UI work.'
        elif loc=='es-419':
            extra='Actually author the coordinated nine-fragment haiku repair now. Preserve every English fact and choice identity; read/scan all27 products. Prepare the full immutable independent review packet, retain eight already-adjudicated prose proposals, and continue repair/review/application phases automatically.'
        else:
            extra='Settle the23 registered source/locale special-case decisions with exact existing evidence, then proceed automatically to actual admitted wording/editing work, starting with inventory52 and the existing935 UI supplement. Keep unsupported selectors held, but do not stop while any independent admitted units remain. A new ledger alone is only the first finite phase, not the job outcome.'
        initial.write_text(f'# Execute continuous {loc} localization production\n\nRead {prior} and {lane}/selected-prior-task.json as the verified previous handoff. The parent now selects this task for execution; obsolete proposed-only/stop-for-parent clauses do not block the current owner instruction.\n\n'+extra+'\n\nUse '+str(directory/'CONTRACT.md')+' for the continuation schema and full current scope. Do real work and return continue with the next finite brief.\n')
        first_task['briefSha256']=queue.sha(initial)
        jobs.append(dict(locale=loc,directory=str(lane.relative_to(ROOT)),
            writePrefixes=[f'localization/{loc}-assets',str(lane.relative_to(ROOT))],
            immutablePins={str(p):queue.sha(p) for p in [*common,ROOT/f'localization/glossary/{loc}.json',prior]},
            requiredDeliverables=[f['id'] for f in spec['families']],firstTask=first_task))
    cli=Path(shutil.which('codex')).resolve()
    plan=dict(root=str(ROOT),model=spec['model'],cli=str(cli),cliSha256=queue.sha(cli),jobs=jobs,localeOwned=True,
              efficiencyPolicy=True,efficiencyHelper=str(execution/'locale_efficiency.py'),
              authorization='Owner explicitly ordered six locale-owned streams and removal of the permanent technical stream',
              previousReconciliation=str(old.relative_to(ROOT)),
              executionPins={str(p.relative_to(directory)):queue.sha(p) for p in [*execution.iterdir(),directory/'CONTRACT.md']})
    queue.write(directory/'plan.json',plan)
    return plan


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--run',type=Path,required=True)
    plan=prepare(parser.parse_args().run)
    print(json.dumps(dict(lanes=[j['locale'] for j in plan['jobs']],automaticContinuation=True),indent=2))
