"""Exact two-unit glitch display overlay; technical fake trace stays original."""
import copy
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

ROOT=Path('/Users/antonkrutov/Desktop/Forest')
PACKET=ROOT/'localization/supplemental-ui/20261028-glitch'

def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def load_inputs():
    local=Path(__file__).parent
    if (local/'glitch-inputs.json').exists():
        pins=json.loads((local/'glitch-inputs.json').read_text())
        for name,digest in pins.items():assert sha(local/name)==digest,('glitch-snapshot-pin',name)
        target=local/'glitch-targets.jsonl';accept=json.loads((local/'glitch-acceptance.json').read_text())
    else:
        target=PACKET/'ru.jsonl';accept=json.loads((PACKET/'ru.acceptance.json').read_text())
    assert accept['status']=='bounded-russian-editorial-accepted' and sha(target)==accept['targetSha256']
    rows=[json.loads(l) for l in target.read_text().splitlines()];assert len(rows)==2
    assert all(r['locale']=='ru' and hashlib.sha256(r['source'].encode()).hexdigest()==r['sourceSha256'] and hashlib.sha256(r['target'].encode()).hexdigest()==r['targetSha256'] for r in rows)
    return rows,accept

def snapshot(folder):
    rows,accept=load_inputs()
    (folder/'glitch-targets.jsonl').write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in rows))
    (folder/'glitch-acceptance.json').write_text(json.dumps(accept,ensure_ascii=False,indent=2)+'\n')
    (folder/'glitch-inputs.json').write_text(json.dumps({n:sha(folder/n) for n in ['glitch-targets.jsonl','glitch-acceptance.json']},indent=2)+'\n')
    source=Path(__file__).with_name('inventory_glitch_patch')
    if not source.exists():source=Path(__file__).with_name('glitch-patch-source')
    shutil.copytree(source,folder/'glitch-patch-source',ignore=shutil.ignore_patterns('bin','obj'))
    subprocess.run(['dotnet','build',str(folder/'glitch-patch-source/InventoryGlitchPatch.csproj'),'-o',str(folder/'glitch-patch')],capture_output=True,check=True)

def plan(objects,generator):
    from extract_assets import read_tree
    rows,_=load_inputs();row=next(r for r in rows if r['family']=='inventory-glitch-initial');obj=objects[15506]
    assert obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName=='TextMeshProUGUI'
    tree=read_tree(obj,generator);assert tree['m_text']==row['source'];target=copy.deepcopy(tree);target['m_text']=row['target']
    return {15506:target},dict(id=row['id'],sourceSha256=row['sourceSha256'],targetSha256=row['targetSha256'],selectedField='/m_text')

def patch(managed,recipe,receipt_path):
    rows,_=load_inputs();row=next(r for r in rows if r['family']=='inventory-glitch-suffix');target=recipe/'glitch-suffix-target.json';target.write_text(json.dumps(row,ensure_ascii=False,indent=2)+'\n')
    source=managed/'Assembly-CSharp.dll';output=managed/'Assembly-CSharp.glitch.dll'
    subprocess.run(['dotnet',str(recipe/'glitch-patch/InventoryGlitchPatch.dll'),str(source),sha(source),str(target),str(output),str(receipt_path),str(managed/'VNRevivalInventoryLayout.dll')],check=True)
    result=json.loads(receipt_path.read_text());assert result['selectedStrings']==1 and result['allOriginalBodiesRestored'] and sha(output)==result['targetSha256'];output.replace(source);return result
