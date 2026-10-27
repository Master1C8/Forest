"""Apply source-bound menu captions, caption layout and six gallery literals."""
import copy
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
from extract_assets import read_tree, canonical

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
PACKET = ROOT / 'localization/supplemental-ui/20261027'
SOURCE = ROOT / 'localization/source/menu-remaining-ui-20261027'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def load_inputs():
    local = Path(__file__).parent
    if (local / 'menu-inputs.json').exists():
        pins = json.loads((local / 'menu-inputs.json').read_text())
        for name, expected in pins.items(): assert sha(local/name)==expected, ('snapshot-menu-input',name)
        inventory = json.loads((local / 'menu-inventory.json').read_text())
        records = [json.loads(line) for line in (local / 'menu-targets.jsonl').read_text().splitlines()]
    else:
        inventory = json.loads((SOURCE / 'menu-inventory.json').read_text())
        manifest = json.loads((PACKET / 'manifest.json').read_text())
        assert sha(PACKET/'ru.jsonl') == manifest['locales']['ru']['sha256']
        assert sha(SOURCE/'menu-inventory.json') == '128a0cdec222e929d7217ec9520674c7f8c025febaf3d5bd1963f0e936173f08'
        records = [json.loads(line) for line in (PACKET/'ru.jsonl').read_text().splitlines()]
    targets = {r['id']:r for r in records}
    assert len(targets)==len(records)==446
    return inventory, targets


def menu_plan(objects,generator):
    inventory, targets = load_inputs()
    plan, receipt = {}, []
    for row in inventory['rows']:
        pid=row['pathId'];obj=objects[pid]
        assert obj.type.name=='MonoBehaviour' and obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName=='TextMeshProUGUI'
        value=read_tree(obj,generator);unit=targets[row['id']]
        assert unit['source']==row['source']
        assert value['m_fontAsset']==row['font'], ('menu-font-role',pid)
        assert value[row['field']] in (unit['source'],unit['target']), ('unexpected-menu-before-value',pid)
        fixed=copy.deepcopy(value);fixed[row['field']]=unit['target'];plan[pid]=fixed
        receipt.append(dict(id=row['id'],source=unit['source'],target=unit['target'],
                            changed=value[row['field']]!=unit['target'],hierarchy=row['hierarchy']))
    for row in inventory['captionLayout']:
        for pid,key in [(row['rectId'],'sourceRect'),(row['fitterId'],'sourceFitter')]:
            assert canonical(read_tree(objects[pid],generator))==canonical(row[key]), ('caption-layout-source',pid)
            plan[pid]=copy.deepcopy(row[key])
        rect=plan[row['rectId']];rect['m_Pivot']['x']=row['targetPivotX'];rect['m_AnchoredPosition']['x']=row['targetAnchoredX']
        plan[row['fitterId']]['m_HorizontalFit']=row['targetHorizontalFit']
    assert len(plan)==286 and len(receipt)==282
    return plan,receipt


def snapshot(folder):
    inventory, targets=load_inputs()
    (folder/'menu-inventory.json').write_text(json.dumps(inventory,ensure_ascii=False,indent=2)+'\n')
    (folder/'menu-targets.jsonl').write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in targets.values()))
    pins={name:sha(folder/name) for name in ['menu-inventory.json','menu-targets.jsonl']}
    (folder/'menu-inputs.json').write_text(json.dumps(pins,indent=2)+'\n')
    tool=folder/'menu-patch';tool.mkdir()
    built=ROOT/'tools/menu_patch/bin/Debug/net8.0'
    for path in built.iterdir():
        if path.is_file():shutil.copy2(path,tool/path.name)
    shutil.copy2(ROOT/'tools/menu_patch/Program.cs',tool/'Program.cs')
    shutil.copy2(ROOT/'tools/menu_patch/MenuPatch.csproj',tool/'MenuPatch.csproj')
    assert (tool/'MenuPatch.dll').is_file()


def patch_gallery(managed,recipe,receipt_path):
    _,targets=load_inputs()
    rows=[r for key,r in targets.items() if key.startswith('il:Assembly-CSharp.dll/')]
    assert len(rows)==6
    target_file=recipe/'gallery-targets.json';target_file.write_text(json.dumps(rows,ensure_ascii=False,indent=2)+'\n')
    output=managed/'Assembly-CSharp.localized.dll'
    subprocess.run(['dotnet',str(recipe/'menu-patch/MenuPatch.dll'),'patch',str(managed/'Assembly-CSharp.dll'),str(target_file),str(output),str(receipt_path)],check=True)
    receipt=json.loads(receipt_path.read_text());assert receipt['selectedStrings']==6 and receipt['allOriginalBodiesRestored']
    assert sha(output)==receipt['targetSha256']
    output.replace(managed/'Assembly-CSharp.dll')
    return receipt
