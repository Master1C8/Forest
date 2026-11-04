"""Stage the parent-owned delivery only; keep unrelated working roots untouched."""
from pathlib import Path
import subprocess,json,hashlib
R=Path('/Users/antonkrutov/Desktop/Forest');C=R/'localization/completion/launcher-all30-20261104-01'
assert subprocess.check_output(['git','branch','--show-current'],cwd=R,text=True).strip()=='main'
assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=R,text=True).strip()=='c3585234cba759391f9a9ddd300b791edf5a4de1'
assert not subprocess.check_output(['git','diff','--cached','--name-only'],cwd=R,text=True).strip(),'Preserve unrelated staged work'
paths=['STORAGE_RECOVERY.md','MacOS/README.md','MacOS/README.txt','MacOS/Sources/InstallerApp.swift','MacOS/Sources/InstallerCore.swift','MacOS/Tests/CoreTests.swift','MacOS/build-receipt.json','MacOS/native-resources.json','MacOS/original-inputs.json','MacOS/payload-receipt.json','MacOS/validation.json','Windows/README.md','Windows/README.txt','Windows/THIRD-PARTY-NOTICES.txt','Windows/build-receipt.json','Windows/compiler-receipts.json','Windows/installer-config.json','Windows/locale-labels.generated.json','Windows/tests/Program.cs','Windows/validation.json','localization/languages/hi.json','localization/languages/sw.json','localization/languages/uk.json']
paths += ['tools/'+n for n in ['build_macos_installer.py','build_windows_installer.py','forest_macos.py','verify_macos_resources.py','test_macos_installer.py','locale_review_lifecycle.py','test_locale_review_lifecycle.py','locale_review_archive.py','test_locale_review_archive.py','test_macos_source_cache.py']]
paths += [str(p.relative_to(R)) for p in C.rglob('*') if p.is_file() and p.suffix in ['.json','.jsonl','.py','.md'] and 'root-index' not in p.parts and p.name!='staging-manifest.json']
D=R/'localization/editorial-delivery/launcher-all30-20261104-01'
paths += [str(p.relative_to(R)) for p in D.glob('closed-review-evidence-*/*') if p.is_file()]
paths += [str(p.relative_to(R)) for loc in ['hi','sw','uk'] for p in (D/loc/'editorial-closure-01').glob('*.json')]
paths=sorted(set(paths));assert all((R/p).is_file() for p in paths)
subprocess.run(['git','add','-f','--',*paths],cwd=R,check=True)
for name in ['README.md','CHECKPOINT.json']:
 p=C/'root-index'/name;blob=subprocess.check_output(['git','hash-object','-w',str(p)],cwd=R,text=True).strip();subprocess.run(['git','update-index','--cacheinfo','100644,'+blob+','+name],cwd=R,check=True)
expected=set(paths)|{'README.md','CHECKPOINT.json'};actual=set(subprocess.check_output(['git','diff','--cached','--name-only','--no-renames'],cwd=R,text=True).splitlines());assert actual==expected,(actual-expected,expected-actual)
for name in sorted(expected):
 data=subprocess.check_output(['git','show',':'+name],cwd=R);source=C/'root-index'/name if name in ['README.md','CHECKPOINT.json'] else R/name
 assert hashlib.sha256(data).digest()==hashlib.sha256(source.read_bytes()).digest(),('Staged byte normalization',name)
(C/'staging-manifest.json').write_text(json.dumps(dict(paths=sorted(expected),files=len(expected),parentOnlyGitOwnership=True,unrelatedWorkingRootChangesPreserved=True,stagedBlobsEqualSelectedSourceBytes=True),indent=2)+'\n')
print('Staged and byte-verified',len(expected),'owned files; no unrelated index contents')
