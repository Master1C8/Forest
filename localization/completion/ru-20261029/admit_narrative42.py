"""Admit seven source-selected native pages while preserving inactive/held pages."""
import argparse
import collections
import hashlib
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CONTRACT = ROOT/'localization/source/narrative150-resource-contract-20261029'
PACKET = ROOT/'localization/supplemental-ui/20261029-narrative-case150'
OUTPUT = ROOT/'localization/source/narrative150-resource-contract-20261029.parent-admission.json'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def read(p):
    return json.loads(p.read_bytes())


def rows(p):
    return [json.loads(line) for line in p.read_text().splitlines()]


def verify(pins):
    for name,info in pins.items():
        path = ROOT/name
        assert sha(path) == info['sha256'], ('pin',name)
        assert path.stat().st_size == info['bytes'], ('bytes',name)


def receipt():
    assert sha(CONTRACT/'output-manifest.json') == '49fe4840468a9759630ca8d288299d4194314c2d581d52a7f730d16d36326b3d'
    manifest = read(CONTRACT/'output-manifest.json')
    verify(read(CONTRACT/'input-pins.json'))
    verify(manifest['files'])
    result = read(CONTRACT/'Result.json')
    assert result['status'] == 'complete-finite-static-resource-admission-contract'
    assert result['currentValuesSourceExact'] == result['physicalMemberships'] == 150
    assert result['rawNFCProjectionChecks'] == 120 and result['rectLayoutControllerExact']
    assert not result['sourceGateAccepted'] and not result['targetApplied']
    acceptance = read(PACKET/'ru.acceptance.json')
    assert acceptance['targetEditorialAccepted'] and acceptance['acceptedWholePageTargets'] == 20
    assert acceptance['targetSha256'] == result['targetSha256'] == sha(PACKET/'ru.prepared.jsonl')
    assert acceptance['sourceSha256'] == result['sourcePacketSha256']
    for name,digest in acceptance['evidence'].items():
        assert sha(ROOT/name) == digest
    pages = rows(CONTRACT/'pages25.jsonl')
    targets = {r['id']:r for r in rows(PACKET/'ru.prepared.jsonl')}
    assert len(pages) == len(targets) == 25
    lists = read(CONTRACT/'allowlists.json')
    allowed,protected,held = map(set,[lists['proposedApplication'],lists['protectedInactive'],lists['heldSource']])
    assert list(map(len,[allowed,protected,held])) == [42,78,30]
    assert not lists['executableApplication'] and not lists['applicationAuthorized']
    source = {r['id']:r for r in rows(CONTRACT/'selectors150.jsonl')}
    assert len(source) == 150 and allowed|protected|held == source.keys()
    assert sum(map(len,[allowed,protected,held])) == 150
    selected = []
    for page in pages:
        target = targets[page['id']]
        assert page['target'] == target['target'] and page['targetUtf8Sha256'] == target['targetUtf8Sha256']
        members = set(page['occurrenceIds'])
        assert len(members) == 6
        if members & allowed:
            assert members <= allowed and page['target'] is not None and not page['holdPredicates']
            assert page['producerContext']['staticNativeWording'] != ''
            assert page['reuseRelation']['selectionEvidence']['bodySha256']
            assert all(source[i]['acceptedWholePageTarget'] == page['target'] for i in members)
            selected.append(page)
        elif members & protected:
            assert members <= protected and page['family'] == 'MouseOrgyMovie'
        else:
            assert members <= held and page['target'] is None
    assert collections.Counter(p['family'] for p in selected) == {'BotbMabelSummary':3,'MaverickRascalShopStory':3,'RascalSoloBearStory':1}
    evidence = {name:info['sha256'] for name,info in manifest['files'].items()}
    evidence[str((CONTRACT/'output-manifest.json').relative_to(ROOT))] = sha(CONTRACT/'output-manifest.json')
    evidence[str((PACKET/'ru.acceptance.json').relative_to(ROOT))] = sha(PACKET/'ru.acceptance.json')
    return dict(status='bounded-narrative42-source-application-admitted',game='The Forest of Love',version='0.45',locale='ru',
                boundedSourceRolesAccepted=True,applicationAllowedIds=sorted(allowed),protectedInactiveIds=sorted(protected),sourceHeldIds=sorted(held),
                selectedPageIds=sorted(p['id'] for p in selected),selectedNativePages=7,selectedNativeFields=42,protectedInactiveFields=78,sourceHeldFields=30,
                targetSha256=result['targetSha256'],sourcePacketSha256=result['sourcePacketSha256'],candidateBuildSha256=result['candidateBuildSha256'],
                scope='Only seven whole source-selected native page literals,all six members per page. Mouse78 retain current values/activation;Penny30 remain null/source-held. No dialogue-row joining,controller/navigation/activation/font/layout change.',
                nativeFit='not-run',targetApplied=False,ordinaryTranslationEntryAllowed=False,sourceGateAccepted=False,wholeGameAccepted=False,
                evidence=evidence,reconciliationRecipe=str(Path(__file__).relative_to(ROOT)),reconciliationRecipeSha256=sha(Path(__file__)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--check',action='store_true')
    args = parser.parse_args()
    value = receipt()
    if args.check:
        assert read(OUTPUT) == value
    else:
        with OUTPUT.open('x') as stream:
            json.dump(value,stream,ensure_ascii=False,indent=2);stream.write('\n')
    print('Admitted42 exact fields/seven whole native pages;Mouse78 protected;Penny30 held;global gates remain false.')
