"""Prepare a source-bound native-pixel detail for a fresh review; no model call."""
import argparse,hashlib,json,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def write(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--capture',type=Path,required=True)
p.add_argument('--order',type=int,required=True)
p.add_argument('--bounds',nargs=4,type=int,required=True,metavar=('X','Y','WIDTH','HEIGHT'))
p.add_argument('--output',type=Path,required=True)
p.add_argument('--context',type=Path,required=True)
a=p.parse_args();capture=a.capture.resolve();out=a.output.resolve();context=a.context.resolve()
assert all(v.is_relative_to(ROOT) for v in [capture,out,context])
assert not out.exists() and not out.is_relative_to(capture/'upload')
manifest=capture/'native-manifest.json';native=read(manifest)
row=next(r for r in native['images'] if r['order']==a.order)
source=capture/'upload'/row['filename'];assert sha(source)==row['sha256']
assert all(type(v)==int for v in a.bounds)
x,y,w,h=a.bounds;assert x>=0 and y>=0 and w>0 and h>0 and x+w<=row['width'] and y+h<=row['height']
out.mkdir();(out/'input').mkdir();crop=out/'input'/(source.stem+'-detail.webp')
helper=Path.home()/'.codex/tools/screenshot_preview.py'
result=subprocess.run([sys.executable,'-B',str(helper),str(source),'--output',str(crop),'--crop',*[str(v) for v in a.bounds]],capture_output=True,text=True,check=True)
receipt=json.loads(result.stdout);assert receipt['sourceSha256']==row['sha256'] and receipt['crop']==a.bounds and receipt['sha256']==sha(crop)
write(out/'crop-provenance.json',dict(**receipt,sourceManifest=dict(path=str(manifest),sha256=sha(manifest)),generatorSha256=sha(Path(__file__))))
bind=lambda p:dict(path=str(p),sha256=sha(p))
prepared=dict(row,filename=crop.name,sha256=sha(crop),width=receipt['width'],height=receipt['height'])
provenance=dict(native['provenance'],sourceImage=bind(source),sourceManifest=bind(manifest),crop=bind(out/'crop-provenance.json'))
write(out/'native-manifest.json',dict(schemaVersion=1,kind='native-screenshots',scope='Supplemental source-pixel detail for native slot '+str(a.order)+'; prior full-frame coverage remains separate',provenance=provenance,images=[prepared]))
text=context.read_text();assert len(text.encode())<=30000
text+='\nSupplemental detail, not a whole screenshot. Original SHA256 '+row['sha256']+'; source dimensions '+str([row['width'],row['height']])+'; crop x/y/width/height '+str(a.bounds)+'. Prepared WebP80, longest edge<=1280, no upscaling. Inspect the entire supplied detail and retain uncertainty if unresolved. This does not replace full-frame coverage.\n'
(out/'acceptance.txt').write_text(text)
print(json.dumps(dict(output=str(out),order=a.order,dimensions=[receipt['width'],receipt['height']],modelRequests=0)))
