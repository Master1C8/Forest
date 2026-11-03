"""Separate actual continuation inputs from historical provenance, without removal."""
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

ROOT=Path('/Users/antonkrutov/Desktop/Forest');HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('bounded_storage_plan',HERE/'retention.py')
r=importlib.util.module_from_spec(spec);spec.loader.exec_module(r)


def main():
    with gzip.open(HERE/'source-retention-plan.json.gz','rt') as f:d=json.load(f)
    keep={x['path']:x for x in d['keep']};evidence={x['path']:x for x in d['evidence']};discard={x['path']:x for x in d['discard']}
    inputs=set(json.loads((HERE/'minimal-attempt-03/minimal-build-inputs.json').read_text())['files'])
    direct=set(inputs)
    for name in ['outputs/last-six-locales-20261103-01/hi/author-auto-0001/result.json',
                 'outputs/last-six-locales-20261103-01/sw/review-auto-0003/task.json']:
        obj=json.loads((ROOT/name).read_text())
        for ref in r.pinned(obj):direct.add(ref)
    # Preserve the owning Swahili review lifecycle's actual merged/retained rows.
    for p in (ROOT/'outputs/last-six-locales-20261103-01/independent-lifecycle-01').rglob('*sw*'):
        if p.is_file():direct.add(str(p.relative_to(ROOT)))
    for p in (ROOT/'localization/completion/last-six-locales-20261103-01').rglob('*'):
        if p.is_file() and p.suffix in {'.py','.md'}:direct.add(str(p.relative_to(ROOT)))
    sdk=[]
    for name,row in list(keep.items()):
        if name in direct or r.under(name,r.LIVE):continue
        reason=row['reason']
        move=(reason in {'unfinished-work-transitive-pinned-input','unique-untracked-source-input-preserved'} or
              reason=='editable-source-or-source-context' and not name.startswith('tools/') and len(Path(name).parts)>1)
        if not move:continue
        del keep[name]
        original=None
        for marker in ['/compiler/opt/','/compiler/usr/','/compiler/Applications/']:
            if marker in name:
                original=Path('/'+name.split('/compiler/',1)[1]);break
        if original and original.is_file() and r.sha(original)==row['sha256']:
            q=dict(row,reason='verified-exact-copy-of-installed-SDK',externalSource=str(original))
            discard[name]=q;sdk.append(dict(path=name,source=str(original),sha256=row['sha256']))
        elif reason=='unfinished-work-transitive-pinned-input' and name.startswith(('assets/source-v1/','assets/source-v2/')):
            discard[name]=dict(row,reason='replaceable-extraction-cache-not-a-direct-continuation-input')
        else:
            evidence[name]=dict(row,reason='original-source-or-evidence-preserved-outside-active-checkout')
    for name in direct:
        if not (ROOT/name).is_file():continue
        if name in evidence:keep[name]=evidence.pop(name)
        elif name in discard:
            q=discard.pop(name)
            if 'sha256' not in q:q['sha256']=r.sha(ROOT/name)
            q['mode']=(ROOT/name).stat().st_mode & 0o7777;q['mtimeNs']=(ROOT/name).stat().st_mtime_ns
            keep[name]=q
        if name in keep:keep[name]['reason']='explicit-complete-next-assignment-or-build-input'
    # Preserve only real historical restoration dependencies, with one CAS blob
    # per content identity; these are not extra model/build variants.
    prior=json.load(gzip.open(HERE/'plan.json.gz','rt'))['priorAnchors'];missing=[]
    for name in prior:
        p=ROOT/name
        if not p.is_file():missing.append(name);continue
        if name in keep:continue
        row=evidence.get(name) or discard.pop(name,None)
        if row is None:
            s=p.stat();row=dict(path=name,bytes=s.st_size,signature=[s.st_dev,s.st_ino,s.st_size,s.st_mtime_ns])
        if 'sha256' not in row:row['sha256']=r.sha(p)
        row.update(mode=p.stat().st_mode & 0o7777,mtimeNs=p.stat().st_mtime_ns,reason='indispensable-prior-restoration-companion')
        evidence[name]=row
    # Source and owner changes authored during this cleanup remain canonical.
    for p in list(HERE.rglob('*'))+[ROOT/'tools/forest_storage.py']:
        if not p.is_file() or p.is_symlink() or 'dotnet-home' in p.parts:continue
        name=str(p.relative_to(ROOT));s=p.stat()
        keep[name]=dict(path=name,bytes=s.st_size,mode=s.st_mode & 0o7777,mtimeNs=s.st_mtime_ns,
                       signature=[s.st_dev,s.st_ino,s.st_size,s.st_mtime_ns],sha256=r.sha(p),reason='current-verified-storage-source-and-record')
        evidence.pop(name,None);discard.pop(name,None)
    evidence={n:v for n,v in evidence.items() if n not in keep}
    discard={n:v for n,v in discard.items() if n not in keep and n not in evidence}
    out=dict(sourceHead=subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip(),keep=list(keep.values()),evidence=list(evidence.values()),discard=list(discard.values()),
             directContinuationPaths=sorted(direct),verifiedSdkDuplicates=sdk,preexistingMissingHistoricalAnchors=missing,
             sourceProvenanceBoundary='Current next-task entry pins and complete source/target/context packets stay local. Historical producer references are preserved evidence, not new mandatory local worker inputs. No review coverage/wording was changed.',
             ownerAuthorization=str(HERE.relative_to(ROOT)/'owner-authorization.json'),projectCompletion='unfinished; no worker or acceptance state closed')
    with gzip.open(HERE/'source-retention-plan-final.json.gz','xt') as f:json.dump(out,f)
    summary={k:dict(files=len(out[k]),bytes=sum(x['bytes'] for x in out[k])) for k in ['keep','evidence','discard']}
    summary.update(directContinuationFiles=len(direct),verifiedSdkDuplicateFiles=len(sdk),preexistingMissingHistoricalAnchors=len(missing))
    with (HERE/'source-retention-summary-final.json').open('x') as f:json.dump(summary,f,indent=2);f.write('\n')
    print(json.dumps(summary),flush=True)


if __name__=='__main__':main()
