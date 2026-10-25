#!/usr/bin/env python3
"""Re-read generated component metadata after correcting header alignment."""
import json
from pathlib import Path
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import canonical, dump, read_tree, sha

OUT=Path(__file__).resolve().parents[1]/'assets/source-v2'


def main():
    receipt=OUT/'schema-header-recovery.json'
    if receipt.exists():
        raise ValueError('Already repaired; verify the existing receipt')
    report=json.loads((OUT/'report.json').read_text());root=Path(report['sourceRoot'])
    sources=json.loads((OUT/'source-files.json').read_text())
    for name,row in sources.items():
        assert sha(root/name)==row['sha256'],name
    env=UnityPy.load(str(root));g=TypeTreeGenerator('2020.3.24f1');g.load_local_dll_folder(str(root/'Managed'))
    live={}
    for o in env.objects:
        a=o.assets_file;internal=[]
        while a.parent is not env:
            internal.insert(0,a.name);a=a.parent
        paths=[p for p in sources if Path(p).name==a.name];assert len(paths)==1
        name=paths[0]+(('!/'+'/'.join(internal)) if internal else '')
        key=f'{name}:{o.path_id}';assert key not in live;live[key]=o
    rows=json.loads((OUT/'objects.json').read_text());changed=[];checked=0
    for row in rows:
        if row.get('metadataRecovery')!='game-assemblies':continue
        old=json.loads((OUT/row['tree']).read_text());new=canonical(read_tree(live[row['id']],g));checked+=1
        if new==old:
            row['treeSha256']=sha(OUT/row['tree'])
            continue
        # The observed defect is bounded to header identity. Do not silently
        # credit a broader body change as this repair.
        assert {k:v for k,v in old.items() if k!='m_Script'}=={k:v for k,v in new.items() if k!='m_Script'},row['id']
        dump(OUT/row['tree'],new);row['treeSha256']=sha(OUT/row['tree'])
        changed.append({'id':row['id'],'before':old['m_Script'],'after':new['m_Script']})
    dump(OUT/'objects.json',rows)
    value={'checked':checked,'corrected':len(changed),'bodyAndAllStringValues':'unchanged; complete equality excluding m_Script',
           'scriptSha256':sha(Path(__file__)),'extractorSha256':sha(Path(__file__).with_name('extract_assets.py')),
           'corrections':changed}
    dump(receipt,value);report['schemaHeaderRecovery']={k:v for k,v in value.items() if k!='corrections'}
    dump(OUT/'report.json',report)
    print(json.dumps(report['schemaHeaderRecovery']),flush=True)


if __name__=='__main__':main()
