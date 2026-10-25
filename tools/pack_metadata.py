#!/usr/bin/env python3
"""Version large JSON exports in a deterministic compressed archive."""
import gzip
import hashlib
import io
import json
import tarfile
from pathlib import Path
from extract_assets import dump, sha

ROOT = Path(__file__).resolve().parents[1] / 'assets/source-v2'


def main():
    paths = sorted([ROOT/'objects.json',ROOT/'string-fields.json',*(ROOT/'trees').glob('*.json')])
    archive = ROOT/'metadata.tar.gz'
    digest = hashlib.sha256()
    with archive.open('wb') as raw, gzip.GzipFile(filename='',fileobj=raw,mode='wb',mtime=0,compresslevel=6) as zipped:
        with tarfile.open(fileobj=zipped,mode='w|') as tar:
            for path in paths:
                data = path.read_bytes()
                # Reject any interrupted/partial JSON before packaging.
                json.loads(data)
                name = path.relative_to(ROOT).as_posix()
                digest.update((name+'\t'+hashlib.sha256(data).hexdigest()+'\n').encode())
                info = tarfile.TarInfo(name)
                info.size=len(data);info.mode=0o644;info.mtime=0
                tar.addfile(info,io.BytesIO(data))
    # Read every member back and compare exact paths and bytes.
    observed = hashlib.sha256()
    with tarfile.open(archive,'r:gz') as tar:
        count=0
        for member in tar:
            data=tar.extractfile(member).read()
            assert data == (ROOT/member.name).read_bytes(),member.name
            observed.update((member.name+'\t'+hashlib.sha256(data).hexdigest()+'\n').encode())
            count+=1
    assert count==len(paths) and observed.digest()==digest.digest()
    result={'archive':'metadata.tar.gz','sha256':sha(archive),'bytes':archive.stat().st_size,
            'members':count,'memberPathAndSha256Digest':digest.hexdigest(),
            'readBackEquality':'passed','format':'tar+gzip; normalized headers, mtime=0',
            'restore':'tar -xzf assets/source-v2/metadata.tar.gz -C assets/source-v2',
            'scriptSha256':sha(Path(__file__))}
    dump(ROOT/'metadata-archive.json',result)
    print(json.dumps(result))


if __name__=='__main__':
    main()
