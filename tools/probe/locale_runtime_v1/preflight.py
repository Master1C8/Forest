"""Cheap exact-value gate for explicit native-test label expectations.

This checks serialization only; it does not judge or accept translated wording.
"""
import argparse, hashlib, importlib.util, json, sys
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]

def compare_rows(trees,rows):
    ids=[r['id'] for r in rows]
    if not rows or len(ids)!=len(set(ids)):raise ValueError('Nonempty unique static expectation IDs required')
    result=[]
    for row in rows:
        resource,pointer=row['id'].split(':',1);pid,field=pointer.split('/',1)
        if resource!='level1' or field!='m_text':raise ValueError('Explicit primary-menu m_text selector required')
        for k in ['source','target']:
            if not isinstance(row[k],str) or hashlib.sha256(row[k].encode()).hexdigest()!=row[k+'Sha256']:raise ValueError('Static expectation content hash differs')
        if row['source']==row['target']:raise ValueError('Expected source and localized target must differ')
        actual=trees[int(pid)][field]
        status='target' if actual==row['target'] else 'source' if actual==row['source'] else 'unknown'
        result.append(dict(id=row['id'],status=status,actual=actual,expected=row['target']))
    return dict(passed=all(r['status']=='target' for r in result),predicate='primary-menu-resource-language',rows=result,
                boundary='Exact saved strings only; no semantic, font, native, callback or whole-game acceptance')

def check(root,resource,rows_path):
    sys.path.insert(0,str(root/'tools'))
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree
    source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
    generator=TypeTreeGenerator('2020.3.24f1');generator.load_local_dll_folder(str(source/'Managed'))
    env=UnityPy.load(resource.read_bytes());env.path=str(source)
    rows=[json.loads(l) for l in rows_path.read_text().splitlines() if l.strip()]
    objects=env.file.objects
    trees={int(r['id'].split(':')[1].split('/')[0]):read_tree(objects[int(r['id'].split(':')[1].split('/')[0])],generator) for r in rows}
    return compare_rows(trees,rows)

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--resource',type=Path,required=True);parser.add_argument('--rows',type=Path,required=True);parser.add_argument('--output',type=Path,required=True);args=parser.parse_args()
    result=check(ROOT,args.resource,args.rows)
    assert not args.output.exists(),'Preserve prior gate evidence'
    args.output.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps(dict(passed=result['passed'],predicate=result['predicate'],fields=len(result['rows']),states={s:sum(r['status']==s for r in result['rows']) for s in ['source','target','unknown']})))
    sys.exit(0 if result['passed'] else 1)
