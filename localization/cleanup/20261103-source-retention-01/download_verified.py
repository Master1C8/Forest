"""Download private recovery assets in verified HTTP ranges; never log auth URLs."""
import concurrent.futures
import hashlib
import json
import os
from pathlib import Path
import subprocess
import threading
import urllib.error
import urllib.parse
import urllib.request

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self,req,fp,code,msg,headers,newurl):return None


def main():
    release=json.loads((HERE/'release-all-assets.json').read_text())
    assert release['draft'] and release['tag_name']=='storage-recovery-20261103'
    assets={a['name']:a for a in release['assets']}
    receipts=[json.loads(p.read_text()) for p in HERE.glob('*-archive-v2.json')]
    assert len(receipts)==6
    dest=ROOT/'dist/recovery/ranged-20261103';dest.mkdir(parents=True,exist_ok=False)
    secret=subprocess.check_output(['gh','auth','token','--hostname','github.com'],text=True).strip()
    tasks=[];fds={};lock=threading.Lock();results=[]
    with (HERE/'remote-download-ranges.jsonl').open('x') as ledger:
        for r in sorted(receipts,key=lambda r:r['bytes']):
            name=Path(r['path']).name;a=assets[name]
            assert a['state']=='uploaded' and a['size']==r['bytes'] and a['digest']=='sha256:'+r['sha256']
            req=urllib.request.Request('https://api.github.com/repos/Master1C8/Forest/releases/assets/'+str(a['id']),headers={'Authorization':'Bearer '+secret,'Accept':'application/octet-stream','X-GitHub-Api-Version':'2022-11-28'})
            try:
                urllib.request.build_opener(NoRedirect).open(req,timeout=30)
                raise RuntimeError('Expected an asset redirect')
            except urllib.error.HTTPError as e:
                assert e.code==302
                url=e.headers['Location']
            host=urllib.parse.urlsplit(url).hostname
            assert host and host.endswith('.githubusercontent.com')
            fd=os.open(dest/name,os.O_CREAT|os.O_EXCL|os.O_RDWR,0o600);os.ftruncate(fd,r['bytes']);fds[name]=fd
            for start in range(0,r['bytes'],4*1024**2):tasks.append((name,url,start,min(start+4*1024**2,r['bytes'])-1,r['bytes']))
        def fetch(t):
            name,url,start,end,size=t
            req=urllib.request.Request(url,headers={'Range':'bytes=%d-%d'%(start,end)})
            try:
                with urllib.request.urlopen(req,timeout=60) as response:
                    assert response.status==206 and response.headers['Content-Range']=='bytes %d-%d/%d'%(start,end,size)
                    raw=response.read(end-start+2)
                assert len(raw)==end-start+1
                assert os.pwrite(fds[name],raw,start)==len(raw)
                with lock:
                    ledger.write(json.dumps(dict(asset=name,start=start,end=end,sha256=hashlib.sha256(raw).hexdigest()))+'\n');ledger.flush()
            except Exception as e:
                # HTTPError includes the signed URL in str(e); do not print it.
                raise RuntimeError('Range failure: asset=%s start=%d type=%s code=%s'%(name,start,type(e).__name__,getattr(e,'code',None))) from None
        try:
            with concurrent.futures.ThreadPoolExecutor(max_workers=16) as pool:list(pool.map(fetch,tasks))
        finally:
            for fd in fds.values():os.close(fd)
    for r in receipts:
        name=Path(r['path']).name;p=dest/name;h=hashlib.sha256()
        with p.open('rb') as stream:
            for chunk in iter(lambda:stream.read(1024**2),b''):h.update(chunk)
        digest=h.hexdigest()
        assert digest==r['sha256']
        results.append(dict(asset=name,bytes=p.stat().st_size,downloadSha256=digest,remoteDigest=assets[name]['digest']))
        print(json.dumps(results[-1]),flush=True)
    with (HERE/'remote-downloads-verified.json').open('x') as f:json.dump(dict(assets=results,credentialValuesOrSignedUrlsWritten=False),f,indent=2);f.write('\n')


if __name__=='__main__':main()
