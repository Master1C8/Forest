import ctypes,hashlib,json,shutil,sys,copy,os,fnmatch
from pathlib import Path
PROJECT_ROOT=Path('/Users/antonkrutov/Desktop/Forest')
ROOT=Path(os.environ.get('FOREST_RU_INPUT_ROOT',str(PROJECT_ROOT))).resolve()
assert ROOT == PROJECT_ROOT or (PROJECT_ROOT/'outputs/ru-ui-repair-20261027') in ROOT.parents
sys.dont_write_bytecode=True
sys.path.insert(0,str(ROOT/'localization/ru-assets'))
import inline_guard as guard
from extract_assets import canonical

def sha(p):
 h=hashlib.sha256()
 with Path(p).open('rb') as f:
  for b in iter(lambda:f.read(1048576),b''):h.update(b)
 return h.hexdigest()
def value(tree,pointer):
 for k in pointer.strip('/').split('/'):
  tree=tree[int(k)] if isinstance(tree,list) else tree[k]
 return tree
def apply_overlay(tree,rows,name):
 man=json.loads((ROOT/'localization/source/dialogue-manifest.json').read_text())
 names={'sharedassets0.assets':0,man['sources'][1]['object'].split('!/')[0]:1}
 assert name in names,'Unknown physical dialogue source'
 index=names[name]
 expected=json.loads((ROOT/man['sources'][index]['tree']).read_text())
 assert canonical(tree)==expected, (name,'complete original tree mismatch')
 original=copy.deepcopy(tree); changes=[]
 for row in rows:
  assert value(tree,row['pointer'])==row['source']
  path=row['pointer'].strip('/').split('/');t=tree
  for k in path[:-1]:t=t[int(k)] if isinstance(t,list) else t[k]
  t[path[-1]]=row['target']
  changes.append({k:row[k] for k in ('id','pointer','sourceSha256','targetSha256')})
 restored=copy.deepcopy(tree)
 for r in rows:
  path=r['pointer'].strip('/').split('/');t=restored
  for k in path[:-1]:t=t[int(k)] if isinstance(t,list) else t[k]
  assert t[path[-1]]==r['target'];t[path[-1]]=r['source']
 assert restored==original, 'Noncandidate field changed'
 return tree, {'status':'passed-source-and-expected-target-plan','sourceObject':man['sources'][index], 'sourceTreeSha256':sha(ROOT/man['sources'][index]['tree']), 'expectedTargetTreeCanonicalSha256':hashlib.sha256(json.dumps(canonical(tree),sort_keys=True,separators=(',',':')).encode()).hexdigest(),'noncandidateFullTreeEqualityAfterReversal':True,'changes':changes,'independentFileReadback':'performed by builder against complete expected tree'}
def validate_overlay():
 pins=json.loads((ROOT/'outputs/ru-assets-parallel-20261026/input-pins.json').read_text())
 assert all(sha(ROOT/Path(p).relative_to(PROJECT_ROOT))==h for p,h in pins.items()),'Source/glossary pins changed'
 source=[json.loads(s) for s in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
 rows=[json.loads(s) for s in (ROOT/'localization/ru-assets/dialogue.ru.jsonl').read_text().splitlines()]
 assert len(rows)==len(source)==12246
 assert len({r['id'] for r in rows})==len(rows)
 assert len({r['pointer'] for r in rows})==len(rows),'Duplicate source field pointer'
 byid={r['id']:r for r in source}
 dispositions=guard.load_dispositions(ROOT/'localization/ru-assets/source-dispositions.json',ROOT,byid)
 guard.validate_preserve_manifest(ROOT/'localization/ru-assets/preserve-exactly.json',ROOT/'localization/ru-assets/source-dispositions.json',dispositions,byid)
 counts={}
 for r,s in zip(rows,source):
  assert all(r[k]==v for k,v in s.items()),r['id']
  assert r['sourceSha256']==hashlib.sha256(r['source'].encode()).hexdigest()
  assert r['targetSha256']==hashlib.sha256(r['target'].encode()).hexdigest()
  cat=guard.validate_target(s,r['target'],dispositions.get(r['id']));counts[cat]=counts.get(cat,0)+1
 assert sum(len(r['occurrences']) for r in rows)==24492
 trees=[]
 man=json.loads((ROOT/'localization/source/dialogue-manifest.json').read_text())
 for s in man['sources']:
  assert sha(ROOT/s['tree'])==s['treeSha256'];tree=json.loads((ROOT/s['tree']).read_text());trees.append(tree)
  for r in rows: assert value(tree,r['pointer'])==r['source']
 assert trees[0]['conversations']==trees[1]['conversations']
 paths=['localization/ru-assets/dialogue.ru.jsonl','localization/ru-assets/inline_guard.py','localization/ru-assets/source-dispositions.json','localization/ru-assets/preserve-exactly.json']+[s['tree'] for s in man['sources']]
 return rows,{'status':'passed-static-only','candidateUnits':len(rows),'physicalOccurrences':24492,'pins':pins,'overlayAndGuardHashes':{p:sha(ROOT/p) for p in paths},'classifications':counts,'sourceDefects':'six OPEN; exact preservation validated','editorialAcceptance':'pending; owner-authorized provisional preview'}
lib=ctypes.CDLL('/usr/lib/libSystem.B.dylib',use_errno=True)
CLONE_RECEIPTS=[]
def select_clone_source(source,source_root,cache_root):
 source,source_root,cache_root=Path(source),Path(source_root),Path(cache_root)
 relative=source.relative_to(source_root)
 candidate=cache_root/relative
 if candidate.is_file() and candidate.resolve().is_relative_to(cache_root.resolve()) and sha(candidate)==sha(source):
  return candidate
 return source
def clone_file(source,target):
 original=Path(source);selected=original
 cache=os.environ.get('FOREST_RU_CLONE_CACHE')
 if cache:
  cache=Path(cache).resolve()
  assert (PROJECT_ROOT/'localization/previews') in cache.parents and cache.name=='game','Invalid preview clone cache'
  selected=select_clone_source(original,Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest'),cache)
 cloned=lib.clonefile(os.fsencode(selected),os.fsencode(target),0)==0
 if not cloned: shutil.copy2(selected,target)
 assert os.stat(source).st_ino!=os.stat(target).st_ino
 assert os.stat(selected).st_ino!=os.stat(target).st_ino
 assert sha(target)==sha(original),'Clone differs from original source'
 CLONE_RECEIPTS.append({'source':str(original),'selected':str(selected),'target':str(target),'copyOnWrite':cloned,'sha256':sha(target)})
 return target
def clone_ignore(path,names):
 return [n for n in names if n.startswith('tfol.') or n.lower().endswith(('.log','.dmp')) or (Path(path)/n).is_dir() and any(x in n.lower() for x in ('test','probe','preview'))]
