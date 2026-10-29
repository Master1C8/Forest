#!/usr/bin/env python3
"""Reviewed complete dam minigame feedback labels, five native UI groups."""
import argparse
import importlib.metadata
import importlib.util
import json
from pathlib import Path
import shutil
import sys

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
LOCAL = Path(__file__).resolve().parent
if (LOCAL / 'dam-minigame/pins.json').exists(): LOCAL = LOCAL / 'dam-minigame'
PACKET = LOCAL / 'inputs' if (LOCAL / 'pins.json').exists() else PROJECT / 'localization/hotfixes/ru-dam-minigame30-20261029'
spec = importlib.util.spec_from_file_location('dam_tmp_projection', LOCAL / 'russian_bell_notifications.py')
engine = importlib.util.module_from_spec(spec); spec.loader.exec_module(engine)
sha = engine.sha
IDS = frozenset([28058, 28301, 28337, 29284, 29412, 29545, 29771, 29842, 30972, 31120, 32987, 33062, 33167, 33213, 34190, 34281, 34426, 34669, 35123, 35127, 35500, 35635, 35921, 35929, 36006, 36024, 36557, 36939, 37643, 37878])


def dependencies(lock):
    packages = {}
    for line in lock.read_text().splitlines():
        name, version = line.split('=='); dist = importlib.metadata.distribution(name); assert dist.version == version
        packages[name] = dict(version=version, files={str(p): sha(dist.locate_file(p)) for p in dist.files if '..' not in p.parts and Path(str(p)).suffix != '.pyc' and dist.locate_file(p).is_file()})
    return dict(python=list(sys.version_info[:3]), packages=packages)


def validate_groups(contract, trees):
    groups = {}
    for r in contract['rows']:
        assert r['id'] == f"sharedassets4.assets:{r['pathId']}/m_text"
        assert r['beforeTree']['m_text'] in ['Ready? ', 'Now! ', 'Too soon! ', 'Too late!  ', 'Great! ']
        assert len(r['target'])-len(r['target'].rstrip(' ')) == len(r['beforeTree']['m_text'])-len(r['beforeTree']['m_text'].rstrip(' '))
        assert '<' not in r['target'] and '>' not in r['target']
        assert r['beforeTree']['m_fontAsset'] == {'m_FileID':5, 'm_PathID':3323}
        base = r['hierarchy'].split('/NameGlowLeft')[0]; groups.setdefault(base, []).append(r)
    assert len(groups) == 5 and {r['pathId'] for r in contract['rows']} == set(trees) == IDS
    suffixes = {'','/NameGlowLeft','/NameGlowLeft/Name','/NameGlowLeft/NameGlowTop','/NameGlowLeft/NameGlowRight','/NameGlowLeft/NameGlowBottom'}
    for base, rows in groups.items():
        assert base.startswith('BuckyMinigame/')
        assert len(rows)==6 and {r['hierarchy'][len(base):] for r in rows}==suffixes
        assert len({trees[r['pathId']]['m_text'] for r in rows})==1


def load_inputs():
    if (LOCAL / 'pins.json').exists():
        for name, expected in json.loads((LOCAL / 'pins.json').read_text()).items(): assert sha(LOCAL/name)==expected, ('Dam snapshot pin',name)
        assert dependencies(LOCAL/'requirements-assets.lock')==json.loads((LOCAL/'runtime-dependencies.json').read_text())
    c=json.loads((PACKET/'contract.json').read_text()); t=json.loads((PACKET/'targets.json').read_text()); review=json.loads((PACKET/'independent-review.json').read_text()); font=json.loads((PACKET/'font-requirements.json').read_text())
    assert c['locale']=='ru' and c['resource']=='sharedassets4.assets'
    assert review['status']=='clean' and not review['findings']
    assert review['targetsSha256']==c['targetsSha256']==font['targetsSha256']==sha(PACKET/'targets.json')
    assert review['packetSha256']==sha(PACKET/'review-packet.json') and not font['missingCodepoints']
    assert len(c['rows'])==len(t)==30 and set(review['coverage']['allMembershipIds'])=={r['id'] for r in t}
    assert review['coverage']['complete'] and review['coverage']['memberships']==30
    byid={r['id']:r for r in t}
    for row in c['rows']:
        assert (row['beforeTree']['m_text'],row['target'],row['hierarchy'])==(byid[row['id']]['source'],byid[row['id']]['target'],byid[row['id']]['hierarchy'])
    validate_groups(c,{r['pathId']:dict(r['beforeTree'],m_text=r['target']) for r in c['rows']}); return c


def snapshot(out):
    load_inputs(); dest=Path(out)/'dam-minigame';dest.mkdir();(dest/'inputs').mkdir()
    for n in ['contract.json','targets.json','independent-review.json','review-packet.json','font-requirements.json']:shutil.copy2(PACKET/n,dest/'inputs'/n)
    for n in ['russian_dam_minigame.py','russian_bell_notifications.py','extract_assets.py']:shutil.copy2(LOCAL/n,dest/n)
    lock=LOCAL/'requirements-assets.lock';shutil.copy2(lock if lock.exists() else PROJECT/'requirements-assets.lock',dest/'requirements-assets.lock')
    (dest/'runtime-dependencies.json').write_text(json.dumps(dependencies(dest/'requirements-assets.lock'),indent=2)+'\n');shutil.copy2(dest/'russian_dam_minigame.py',Path(out)/'russian_dam_minigame.py')
    (dest/'pins.json').write_text(json.dumps({str(p.relative_to(dest)):sha(p) for p in sorted(dest.rglob('*')) if p.is_file()},indent=2)+'\n');return dest


def apply(source,output,*,locale='ru',fail_after_resource=False):
    c=load_inputs();source,output=Path(source),Path(output)
    assert locale=='ru' and not output.exists(),'New Russian dam output required'
    for n,h in [(c['resource'],c['sourceSha256']),('resources.assets',c['requiredResourcesSha256']),('Managed/Assembly-CSharp.dll',c['requiredAssemblySha256']),('sharedassets0.assets',c['fontContainerSha256'])]:assert sha(source/n)==h,('Dam source binding',n)
    engine._project_native_tmp(source,output,c,validate_groups)
    if fail_after_resource:raise RuntimeError('injected-after-dam-resource-before-receipt')
    result=dict(status='finite-dam-minigame30-pass',resource=c['resource'],sourceSha256=c['sourceSha256'],targetSha256=sha(output/c['resource']),targetsSha256=c['targetsSha256'],changedTextFields=30,sixLayerGroups=5,prefabRoots=1,allNontextFieldsAndUnselectedObjectsPreserved=True,actualSavedReadback=True,wholeContainerReversalByteExact=True,runtimeVisualAccepted=False,wholeGameAccepted=False,sourceGateAccepted=False,commitBoundary='One exclusive resource then separate receipt; interruption retains occupied output');(output/'Result.json').write_text(json.dumps(result,indent=2)+'\n');return result

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--source',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--locale',required=True);a=p.parse_args();print(json.dumps(apply(a.source,a.output,locale=a.locale)))
