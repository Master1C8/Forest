#!/usr/bin/env python3
"""Prepare complete two-surface review provenance, never submit a review job.
Native PNGs stay unchanged. Shared review entry makes WebP80 <=1280 copies.
"""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT=Path('/Users/antonkrutov/Desktop/Forest')


def require(ok,reason):
    if not ok:raise ValueError(reason)


def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def read(p):return json.loads(Path(p).read_bytes())


def prepare(run,output):
    require(Path(run).is_absolute(),'explicit-absolute-run-required');run=Path(run).resolve();output=Path(output).resolve()
    helper=run/'cg-helpers/capture_chapter_completion_ui.py'
    spec=importlib.util.spec_from_file_location('cc_review',helper);capture=importlib.util.module_from_spec(spec);sys.modules[spec.name]=capture;spec.loader.exec_module(capture)
    capture.checked_run(run)
    require(sha(__file__)==sha(run/'cg-helpers/prepare_chapter_completion_review.py'),'version-matching-frozen-review-preparer-required')
    require(output.parent==ROOT/'localization/visual-qa' and not output.exists(),'new-project-review-output-required')
    completion=read(run/'cc-completion.json');require(completion['status']=='finite-runtime-observations-complete' and completion['measuredCases']==56,'finite56-completion-required')
    for name,key in [('runtime-result.json','runtimeResultSha256'),('cleanup.json','cleanupSha256'),('cc-restoration.json','restorationSha256')]:
        require(sha(run/name)==completion[key],'completion-receipt-version:'+name)
    prep=capture.pin_check(run,restored=True);capture.process().no_game_process(run);capture.parent_unchanged(prep)
    cleanup=read(run/'cleanup.json');restoration=read(run/'cc-restoration.json')
    require(all(cleanup[k] is True for k in ['taskOwnedProcessesAbsent','localizedAssemblyRestored','bridgeRemoved','parentArtifactUnchanged']),'cleanup-boundary')
    require(restoration['status']=='restored' and restoration['fixtureVerification']==completion['fixture'] and completion['fixture']['disposableSavegameByteExact'] is True,'fixture-restoration-boundary')
    data=run/'game/The Forest of Love_Data'
    require(sha(data/'Managed/Assembly-CSharp.dll')==prep['originalAssemblySha256'] and not (data/'Managed/ForestProbe.dll').exists(),'delivered-runtime-cleanup')
    for name,digest in prep['fixtureBefore'].items():require(sha(data/name)==digest,'exact-restored-input:'+name)
    for name,digest in restoration['postRuntimeSidecars'].items():require(sha(run/'cc-post-runtime'/name)==digest,'preserved-post-runtime-sidecar:'+name)
    require((run/'cg-readback.tsv').read_text(encoding='utf-8-sig')==(run/'cg-values.tsv').read_text(),'complete129-loaded-state-readback')
    work=read(run/'cc-workload.json');require(work['counts']==dict(oos=28,description=28) and len(work['cases'])==56,'finite-workload')
    sources=[run/n for n in ['cc-completion.json','cc-preparation.json','cc-execution-pins.json','cc-workload.json','cc-selectors.tsv','cg-readback.tsv','cg-values.tsv','cg-words.tsv','cg-cases.tsv','runtime-result.json','cleanup.json','cc-restoration.json','qa-preparation.json','build.json','player.log','task-process.json','bridge-ready.txt','cc-restoration-verified.txt']]
    frames=[];issues={}
    for surface in capture.SURFACES:
        folder=run/('cc-'+surface);r=read(folder/'result.json')
        require(sha(folder/'result.json')==completion['surfaces'][surface] and r['status']=='surface-observations-complete' and r['restored'] and r['measuredCases']==28,'surface-completion:'+surface)
        require(set(r['evidenceSha256'])=={'measurements.jsonl','display-diagnostics.tsv','native-display.json'},'complete-surface-evidence')
        for name,digest in r['evidenceSha256'].items():require(sha(folder/name)==digest,'surface-evidence-version:'+name)
        rows=[json.loads(x) for x in (folder/'measurements.jsonl').read_text().splitlines()];cases=[c for c in work['cases'] if c['surface']==surface]
        require([c['caseIndex'] for c in r['captures']]==capture.representatives(cases,rows),'complete-representatives:'+surface)
        # Recompute issues from original scalar data instead of trusting pass rows.
        for case,row in zip(cases,rows):
            require(row['sourceId']==case['sourceId'] and len(row['fields'])==6,'measurement-source-role')
            for field in row['fields']:
                checked=capture.metric_issues(field,case['expected']);require(checked['issues']==field['issues'] and checked['role']==field['role'],'geometry-recomputation')
        require(r['geometryIssueCases']==[x['index'] for x in rows if any(f['issues'] for f in x['fields'])],'complete-issue-denominator')
        issues[surface]=r['geometryIssueCases'];frames+=r['captures'];sources += [folder/n for n in ['result.json','measurements.jsonl','display-diagnostics.tsv','native-display.json']]
    require(frames==read(run/'runtime-result.json')['captures'] and len({f['filename'] for f in frames})==len(frames),'complete-unique-frame-set')
    from PIL import Image
    for f in frames:
        path=run/f['filename'];require(path.parent==run and sha(path)==f['sha256'],'original-frame-pin')
        with Image.open(path) as im:require(im.format=='PNG' and im.size==(f['width'],f['height']),'native-png-dimensions');im.verify()
    receipts=list((run/'cc-command-receipts').glob('*.json'))
    require(receipts and all(read(p)['status']=='acknowledged' for p in receipts),'unresolved-or-failed-command-remains')
    sources+=receipts+[p for p in (run/'cg-helpers').rglob('*') if p.is_file()]+[p for p in (run/'cg-inputs').rglob('*') if p.is_file()]
    context='''The Forest of Love0.45, Russian standard localization, full candidate02. This review covers only the complete finite representative frames for28 wrapped Chapter.title and28 Chapter.description fixtures. Gallery3367cases/10acceptedframes are outside this run and must not be recaptured or re-reviewed. Source/common-inventory/global pretranslation/ordinary translation/whole-game/release gates remain open.

The exact OOS factory is ItemGetNotification.ShowOutOfSyncContentNotification(string,null,null), serialized prefab18814 below original messageContainer. The factory is admitted only with NO persistent/runtime listeners on either global show event; unknown listeners block before invocation. Sound500/navigation timers and native UI animation are actual side effects; callbacks for yes/no progression are null and never clicked. It does not invoke BaseSpawner/version flags/awards/quests. Original event identities, cached factory delegate, source DB/cache strings, selection, UI state and fixture files are restored. Restoration is scoped; this is not actual progression or original input acceptance.

Description uses the original LockInteractions property while measuring; its prior value and native list spacing are restored, and the component stays enabled so the live service locator is preserved. Description uses original ChapterSelectUI17041.tooltipContainer -> GO2084, selected tooltip role. The original panel must already be visible through a separately justified parent route; this harness never calls ShowUi/Show or starts a chapter/movie. UpdateTooltipText is called with the28 original accepted description arguments. It is not the separate Adventure.Title confirmation root13363, and never activates unknown AdventureName GO2510/six inactive selectors.

Each surface has six source text layers: one authored alpha0 height provider and five authored alpha1 faces. Height-provider geometry is evidence, not visible ink. Check every visible face, actual glyph/font/point sizes, mask/viewport boundaries, wrapping, overlap, readability and source apostrophes (two U+0027 on each side in OOS). Preferred-height excess alone is a diagnostic warning. Full measurements precede representative selection; every recorded issue outside pictured representatives remains unresolved. Representatives cover tallest/widest/longest/smallest glyph-size cases and each issue class, not a visual pass for unpictured cases.

Actual PNG dimensions and independent Unity display/physical-screen diagnostics are recorded; launch1280x720 is not native-dimension proof. Review whole frames for contamination, ordinary unaccepted English, broken glyphs, clipping and layout. No font or rect was modified to obtain a metric pass. Originals remain unchanged; shared review prepares WebP quality80 <=1280 no upscale. Small uncertain text needs a source-bound crop or needs-review. No new review process is authorized by this preparation.

Expected text per frame:\n'''
    context+=''.join(json.dumps(f,ensure_ascii=False,separators=(',',':'))+'\n' for f in frames)
    context+='\nUnresolved geometry case IDs: '+json.dumps(issues)+'\n'
    require(len(context.encode())<=32768,'acceptance-context-too-large')
    manifest=dict(schemaVersion=1,kind='native-screenshots',scope=f'All{len(frames)} finite representative frames from56 two-surface UI fixtures; no gallery or gameplay acceptance.',provenance={str(p.relative_to(ROOT)):dict(path=str(p),sha256=sha(p)) for p in sources},images=[dict(game='the-forest-of-love',locale='ru',order=i,direction='ltr',filename=f['filename'],sha256=f['sha256'],width=f['width'],height=f['height']) for i,f in enumerate(frames,1)])
    output.mkdir();(output/'native-manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n');(output/'acceptance.txt').write_text(context)
    (output/'preparation.json').write_text(json.dumps(dict(status='review-packets-prepared-not-submitted',frames=len(frames),cases=56,manifestSha256=sha(output/'native-manifest.json'),contextSha256=sha(output/'acceptance.txt'),geometryIssueCases=issues,visualAccepted=False,wholeGameAccepted=False),indent=2)+'\n')
    return manifest


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--run',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args();r=prepare(a.run,a.output);print(json.dumps(dict(status='prepared-not-submitted',frames=len(r['images']))))
