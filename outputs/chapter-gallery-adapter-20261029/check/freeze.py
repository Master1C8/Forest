import hashlib,json,pathlib,shutil,sys
root=pathlib.Path('/Users/antonkrutov/Desktop/Forest');check=root/'outputs/chapter-gallery-adapter-20261029/check';dest=check/sys.argv[1];dest.mkdir()
files=['tools/russian_chapter_gallery_case.py','tools/chapter_gallery_patch/Program.cs','tools/chapter_gallery_patch/ChapterGalleryPatch.csproj','tools/russian_actor_names.py','tools/extract_assets.py','localization/source/bgdatabase-20261027/decode_inventory.py']
# Preserve imported helpers and source/glossary/admission bytes before execution.
for name in files:
 target=dest/('chapter_gallery_patch/'+pathlib.Path(name).name if '/chapter_gallery_patch/' in name else pathlib.Path(name).name);target.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(root/name,target)
import sys
sys.path.insert(0,str(dest));import russian_chapter_gallery_case as a
for name in a.SOURCE_PINS:
 target=dest/'chapter-gallery-source'/name;target.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(a.SOURCE/name,target)
for name in a.DEPENDENCY_PINS:
 target=dest/'chapter-gallery-dependencies'/name;target.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(root/name,target)
shutil.copyfile(root/'localization/supplemental-ui/20261029-chapter-gallery-case/ru.case-preparation.full.jsonl',dest/'draft-targets.jsonl')
pins={str(p.relative_to(dest)):hashlib.sha256(p.read_bytes()).hexdigest() for p in dest.rglob('*') if p.is_file() and '__pycache__' not in str(p)}
(dest/'chapter-gallery-inputs.json').write_text(json.dumps({'schemaVersion':1,'purpose':'immutable-draft-static-preflight-execution-only','files':pins},indent=2)+'\n')
print(json.dumps({'files':len(pins),'execution':str(dest)}))
