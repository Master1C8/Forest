"""Update only the existing current admission binding after real validators pass."""
import json,hashlib,copy
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent;ROOT=OUT.parents[3]
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
load=lambda p:json.loads(p.read_text())
def main():
 manifest=load(OUT/'manifest.json');validation=load(OUT/'continuation-validation.json');delta=validation['phase145CompiledDelta']
 assert validation['phase']=='0145-work' and validation['status']=='passed-fingerprinted-source-continuation'
 assert manifest['counts']['unresolvedCompiledStates']==delta['remainingOccurrences']==251
 assert validation['currentManifestSha256']==sha(OUT/'manifest.json')
 old=load(HERE/'previous-root-CHECKPOINT.json');current=load(ROOT/'CHECKPOINT.json')
 assert current==old,'root-checkpoint-changed-since-phase-baseline'
 next_action=load(OUT/'unresolved-consumers.json')['nextPredicate']
 summary='Phase0145 resolves318 of the assigned569 original compiled operands:84 conditional Unity-console wording inputs,8 direct display inputs,17 potential input/exception/notification operands and209 protected control/resource/schema/layout operands.8325 of8576 original roles now have exact contracts;251 remain across98 methods. All prior8007 precise roles and complete prior records reconstruct exactly.32 named receiver bodies and full443-producer evidence are pinned; capture is not semantic coverage. Conditional console application, exception presentation, database1655, Rewired1389, source/editorial/font/renderer/runtime/delivery gates remain open.'
 cp=copy.deepcopy(current);cp['nextAction']=next_action;cp['stages']['source']=summary;ad=cp['sharedCommonSourceAdmission']
 ad.update(phase='0145-work',status='complete-linked-storage-inventory;partial-source-admission;compiled569-material-progress',counts=manifest['counts'],unresolvedCompiledMethods=98,manifestSha256=sha(OUT/'manifest.json'),validationSha256=sha(OUT/'continuation-validation.json'),summary=summary,nextAction=next_action)
 ad['phase145CompiledDelta']=delta
 ad['compiledRoleEvidence']=str((HERE/'compiled-role-decisions.json').relative_to(ROOT))
 ad['sourceRoleDelta']=str((OUT/'compiled-source-role-delta.jsonl').relative_to(ROOT))
 ad['nextCompiledSelectors']=str((HERE/'next-compiled-selectors.json').relative_to(ROOT))
 ad['compiledTailSourceContext']=dict(path=str((OUT/'compiled-tail-source-context.json').relative_to(ROOT)),sha256=sha(OUT/'compiled-tail-source-context.json'),assignedOccurrences=569,resolvedRoles=318,remainingOccurrences=251,remainingMethods=98,producerSnapshot=str((OUT/'phase144/producer-bodies.jsonl').relative_to(ROOT)),receiverSnapshot=str((HERE/'receiver-bodies.jsonl').relative_to(ROOT)),captureIsNotSemanticCoverage=True)
 ad['compiledSourceHandoff'].update(sha256=sha(OUT/'compiled-source-handoff.json'),wordingOccurrences=315,protectedOccurrences=8022,resolvedOccurrences=8325,unresolvedOccurrences=251)
 ad['usage']=dict(input=None,cachedInput=None,output=None,total=None,boundary='Worker telemetry unavailable; parent measures actual per-request usage. No estimates or nested model jobs.')
 assert all(v==cp[k] for k,v in current.items() if k not in ('sharedCommonSourceAdmission','nextAction','stages')),'unrelated-root-checkpoint-sections'
 assert all(v==cp['stages'][k] for k,v in current['stages'].items() if k!='source'),'unrelated-root-stage-sections'
 (ROOT/'CHECKPOINT.json').write_text(json.dumps(cp,ensure_ascii=False,indent=2)+'\n')
 prior_readme=(HERE/'previous-root-README.md').read_bytes();assert (ROOT/'README.md').read_bytes()==prior_readme,'root-readme-changed-since-phase-baseline'
 addition='\n## Phase0145: exact remaining compiled-source contracts\n\n'+summary+'\n\nEvidence: `localization/source/shared-source-completion-20261028/admission-v1/compiled-tail-source-context.json`, `phase145/compiled-role-decisions.json`, `phase145/next-compiled-selectors.json` and `continuation-validation.json`. The normal builder and reproduction check, full continuation validator, exact whole prior-product reconstruction, argument-position and branch/store rejection controls bind this result. Historical validators read pinned historical products; current real memberships are validated separately. SoftSpriteMask emits actual LogWarning, correcting the older brief’s LogError reference.\n\n'+next_action+'\n\nParent integrates; no worker Git, target/font/texture, game/GUI/image, original-install/save or publication/deployment actions. Parallel authorized language/editorial/preview lanes remain untouched. Deterministic checks do not provide independent semantic/editorial or runtime acceptance.\n'
 (ROOT/'README.md').write_bytes(prior_readme+addition.encode())
 prior_adapter=(HERE/'baseline/ADAPTER.md').read_bytes();assert (OUT/'ADAPTER.md').read_bytes()==prior_adapter,'adapter-changed-since-phase-baseline'
 lead='# Current compiled-source tail, phase145\n\n'+summary+'\n\nExact per-selector assignments are in `phase145/selector_specs.py`. `phase145/expand_roles.py` navigates one literal argument only until branches/stores/unknown receivers; unassigned candidates never become default pass rows. Explicit original branch/cache/UI-local/array-message contracts are separate. Receiver capture filenames derive from owner and exact selection hashes, avoiding ordinal-path collision when a selection is inserted; validate every recorded actual file hash. Original producer bodies and raw multiline spans remain in phase144.\n\n'+next_action+'\n\nNormal commands remain `python3 -B build_inventory.py`, `python3 -B build_inventory.py --check` and `python3 -B validate_continuation.py` from this directory. Retain running tool session IDs and reconcile exact process identity before retrying an empty output yield. Writes are sequential, without rollback or a multi-output transaction. Current source-role checks are deterministic, not independent editorial or runtime acceptance.\n\nEarlier phase records follow unchanged.\n\n'
 (OUT/'ADAPTER.md').write_bytes(lead.encode()+prior_adapter)
 checklist=load(HERE/'baseline/acceptance-checklist.json');checklist['phase']='0145-work'
 row=next(r for r in checklist['items'] if r['id']=='managed-source-role-completion')
 row.update(evidence='phase145/compiled-role-decisions.json;phase145/next-compiled-selectors.json;compiled-tail-source-context.json',remainingUncertainty='8325 of8576 roles resolved.251 remain across98 methods.84 new conditional-console wording,8 direct display,17 potential input/exception/notification and209 protected operands have exact contracts. Actual caption/notification/input application, native console delivery, exception presentation and runtime remain unverified.',nextPermittedAction=next_action)
 row=next(r for r in checklist['items'] if r['id']=='remaining-family-joins');row['nextPermittedAction']='Preserve exact1655 residual values under existing source-policy/external holds or supply a named actual new reader/source-admission decision. Closed finite searches are exhausted; finish the251 compiled roles. TextAsset/resource-family joins remain separate.'
 (OUT/'acceptance-checklist.json').write_text(json.dumps(checklist,ensure_ascii=False,indent=2)+'\n')
 (HERE/'phase-summary.json').write_text(json.dumps(dict(summary=summary,nextAction=next_action,workerUsage='Unavailable; parent measures actual request telemetry'),indent=2)+'\n')
 result=dict(status='passed',unchangedRootSections=[k for k in current if k not in ('sharedCommonSourceAdmission','nextAction','stages')],unchangedOtherStageSections=True,priorReadmeExactPrefix=(ROOT/'README.md').read_bytes().startswith(prior_readme),priorAdapterExactSuffix=(OUT/'ADAPTER.md').read_bytes().endswith(prior_adapter),rootPins={n:sha(ROOT/n) for n in ['README.md','CHECKPOINT.json']},historicalRootSnapshotPins={n:sha(HERE/n) for n in ['previous-root-README.md','previous-root-CHECKPOINT.json']})
 (HERE/'root-preservation.json').write_text(json.dumps(result,indent=2)+'\n')
 print('Updated existing root admission/checklist; unrelated root sections and earlier documentation preserved.')
if __name__=='__main__':main()
