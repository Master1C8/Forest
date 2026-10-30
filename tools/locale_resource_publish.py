"""Shared manifest-last publisher extracted from verified revision06 author03.

The immutable predecessor stays untouched. This module has no source-inventory,
locale, model, or game dependencies. Callers own derivation and final verification.
"""
import json
import os
from pathlib import Path


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def publish(files, out, allowed_root, manifest, verify, resume=False, fail_after=None):
    out, allowed_root = Path(out).resolve(), Path(allowed_root).resolve()
    require(out.is_relative_to(allowed_root) and out != allowed_root, 'output-outside-lane')
    require(not (out/'manifest.json').exists(), 'published-manifest-immutable')
    if out.exists():
        require(resume or not any(out.iterdir()), 'nonempty-output-without-resume')
        for path in out.rglob('*'):
            if path.is_file():
                name=str(path.relative_to(out))
                require(name in files and path.read_bytes()==files[name], 'conflicting-partial-output:'+name)
    out.mkdir(parents=True,exist_ok=True)
    for completed,(name,data) in enumerate(sorted(files.items()),1):
        path=out/name
        require(path.resolve().is_relative_to(out), 'output-path-escape')
        path.parent.mkdir(parents=True,exist_ok=True)
        if not path.exists():
            pending=path.with_suffix(path.suffix+'.pending')
            with pending.open('xb') as stream:
                stream.write(data); stream.flush(); os.fsync(stream.fileno())
            os.replace(pending,path)
        if fail_after is not None and completed==fail_after:
            raise InterruptedError('injected-after-completed-output:'+name)
    for name,data in files.items():
        require((out/name).read_bytes()==data, 'pre-publication-readback')
    marker=(json.dumps(manifest,ensure_ascii=False,sort_keys=True,indent=2,allow_nan=False)+'\n').encode()
    pending=out/'manifest.pending'
    with pending.open('xb') as stream:
        stream.write(marker); stream.flush(); os.fsync(stream.fileno())
    os.replace(pending,out/'manifest.json')
    verify(out,manifest,files)
    return marker
