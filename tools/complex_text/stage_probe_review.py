"""Bind unchanged native probe originals to fresh, compressed CLI reviews."""
from pathlib import Path
import argparse, base64, hashlib, json, os, struct, subprocess, sys
ROOT=Path(__file__).resolve().parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--attempt',required=True);p.add_argument('--reference',action='store_true');p.add_argument('--orders',nargs='+',type=int);a=p.parse_args()
    assert a.attempt.isalnum()
    r=ROOT/'localization/probes'/('locale-owner-shots-20261104-ar-'+a.attempt)
    d=ROOT/'localization/screenshots/all30-owner-20261104-01/ar'/('shaping-probe-'+a.attempt)
    assert not d.exists();d.mkdir();i=d/'input';i.mkdir()
    cleanup=json.loads((r/'cleanup.json').read_bytes())
    assert all(cleanup[k] for k in ['taskProcessStopped','ownerSaveSettingsUnchanged','taskSaveByteExact','bridgeRemoved','localizedAssemblyRestored','settingsRestored'])
    images=[]
    names=[(1,'ar-01-shaped-menu.png'),(2,'ar-02-shaped-samples.png')]
    if (r/'ar-03-shaped-gallery.png').exists():names.append((3,'ar-03-shaped-gallery.png'))
    if a.orders:
        assert set(a.orders)<=set(n for n,_ in names)
        names=[row for row in names if row[0] in a.orders]
    for order,name in names:
        f=r/name;b=f.read_bytes();assert b[-12:]==b'\0\0\0\0IEND\xaeB`\x82'
        w,h=struct.unpack('>II',b[16:24]);os.link(f,i/name)
        images.append(dict(game='The Forest of Love',locale='ar',order=order,direction='rtl',filename=name,sha256=sha(f),width=w,height=h))
    names=['build.json','cleanup.json','probe-preparation.json','probe-resource-proof.json','shaping.json','logical-sample-readback.tsv']
    manifest=dict(schemaVersion=1,kind='native-screenshots',scope='Arabic native feasibility only; not final game screenshot acceptance',
        provenance={n:dict(path=str(r/n),sha256=sha(r/n)) for n in names},images=images)
    (d/'native-manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
    context=(ROOT/'localization/screenshots/all30-owner-20261104-01/ar/shaping-probe-01/acceptance.txt').read_text()
    if a.reference:
        context=context.replace('This is a blind readability test: no expected Arabic transcription is supplied.','The initial blind test is complete. Compare against these exact immutable logical source strings; the prior defect reversed Arabic-Indic123.')
        context=context.replace('No expected Arabic text should be inferred from file names or code.','The exact source strings below are references, not visual evidence.')
        shape=json.loads((r/'shaping.json').read_bytes())
        context+='\nExact sample logical rows (the PREPARED prefix is provenance, never visible): '+json.dumps(shape['samplesLogical'],ensure_ascii=False)+'\n'
        s=json.loads((r/'state-shaped-menu.json').read_bytes())
        menu=sorted(set(base64.b64decode(row.split('\t')[1]).decode() for row in s['texts'] if row.startswith('Canvas/MainMenu/')))
        context+='\nExact original menu logical text fields, including authored whitespace: '+json.dumps(menu,ensure_ascii=False)+'\n'
        if (r/'state-shaped-gallery.json').exists():
            s=json.loads((r/'state-shaped-gallery.json').read_bytes())
            gallery=sorted(set(base64.b64decode(row.split('\t')[1]).decode() for row in s['texts'] if row.startswith('Canvas/GalleryMenu/')))
            context+='\nFrame3 is the original gallery route. Inspect its native Text caption now rendered by a TMP display child; original Text, logical values and controls are retained. Exact gallery fields: '+json.dumps(gallery,ensure_ascii=False)+'\n'
    (d/'acceptance.txt').write_text(context)
    subprocess.run([sys.executable,'-B',str(ROOT/'tools/review_screenshots.py'),'init','--root',str(i),'--queue',str(d/'queue'),'--review',str(d/'review.json'),
        '--manifest',str(d/'native-manifest.json'),'--context',str(d/'acceptance.txt'),'--model','gpt-6.1-sol','--reasoning','high'],check=True)
    print(d)
if __name__=='__main__':main()
