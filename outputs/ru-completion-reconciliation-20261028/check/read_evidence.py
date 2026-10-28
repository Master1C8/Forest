import pathlib,hashlib,json,sys,datetime
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest')
OUT=ROOT/'outputs/ru-completion-reconciliation-20261028/check'
def read(path, mode='content'):
 p=pathlib.Path(path);p=p if p.is_absolute() else ROOT/p
 b=p.read_bytes()
 with (OUT/'reads.jsonl').open('a') as f:f.write(json.dumps({'path':str(p),'sha256':hashlib.sha256(b).hexdigest(),'bytes':len(b),'mode':mode,'readAt':datetime.datetime.now(datetime.timezone.utc).isoformat()})+'\n')
 return b
if __name__=='__main__':
 for p in sys.argv[1:]:
  print('\nFILE '+p); print(read(p).decode())
