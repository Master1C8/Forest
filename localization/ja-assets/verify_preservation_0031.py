"""Reconcile exact saved targets, authored batches, hold reasons, receipts and source pins."""
import hashlib,json,pathlib
ROOT=pathlib.Path(__file__).resolve().parents[2]
HERE=pathlib.Path(__file__).resolve().parent
OUT=ROOT/'outputs/locale-assets-20261026/ja'
PHASE=OUT/'0031-translation'
def sha(raw):return hashlib.sha256(raw).hexdigest()
def main():
    before=json.loads((PHASE/'before.json').read_text())
    baseline=json.loads((OUT/'owner-capacity-repair-20261027-044359/previous-progress.json').read_text())
    assert before['authoredIds']==baseline['authoredIds']==10657
    for r in baseline['batches']:assert sha((ROOT/r['path']).read_bytes())==r['sha256'],r['path']
    pins=json.loads((OUT/'input-pins.json').read_text())
    assert all(sha(pathlib.Path(p).read_bytes())==h for p,h in pins.items())
    rows=[json.loads(s) for s in (HERE/'dialogue.ja.jsonl').read_text().splitlines()]
    targets={r['id']:r for r in rows};assert len(targets)==len(rows)
    assert all(targets[i]['targetSha256']==h==sha(targets[i]['target'].encode()) for i,h in before['targetHashes'].items())
    holds=json.loads((HERE/'unresolved.json').read_text());held={r['id']:r['reason'] for r in holds};assert len(held)==len(holds)
    original_holds={}
    for p in sorted((HERE/'batches').glob('*.tsv')):
        for line in p.read_text().splitlines():
            if not line or line.startswith('#'):continue
            key,text=line.split('\t',1)
            if not text.startswith('!HOLD '):continue
            parts=key.split(':');ident='ds:'+':'.join(parts[:2])+':'+('Menu Text' if len(parts)>2 and parts[2]=='M' else 'Dialogue Text')
            assert ident not in original_holds;original_holds[ident]=text[6:]
    assert set(original_holds)==set(before['held'])
    assert all(original_holds[i]==v for i,v in held.items())
    retirement=json.loads((HERE/'retired-targets.json').read_text());assert len(retirement)==55
    assert {r['id']:r['targetSha256'] for r in retirement}==before['retiredTargets']
    for r in retirement:
        assert sha(r['target'].encode())==r['targetSha256']
        assert sha((ROOT/r['evidencePath']).read_bytes())==r['evidenceSha256']
    source=[json.loads(s) for s in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    assert set(targets).isdisjoint(held)
    assert set(targets)|set(held)=={r['id'] for r in source}
    receipt=json.loads((HERE/'resolutions/0031-source-bound.json').read_text())
    resolved={r['id'] for r in receipt['records']}
    assert resolved==set(targets)-set(before['targetHashes'])==set(before['held'])-set(held)
    assert len(resolved)==405
    assert targets['ds:131:153:Dialogue Text']['target']==targets['ds:540:232:Dialogue Text']['target']
    progress=json.loads((OUT/'progress.json').read_text())
    assert progress['retainedIds']==len(targets)==11062
    assert progress['translatedWordingIds']==10596
    assert progress['reviewedUnchangedPunctuationIds']==63
    assert progress['preservedTechnicalIds']==403
    assert progress['immediatelyEditedIds']==10659
    result={'status':'passed','before':{'retainedIds':10657,'heldIds':1589},'after':{'retainedIds':11062,'heldIds':1184},
            'savedTargetHashesPreserved':10657,'unchangedPriorBatchHashes':len(baseline['batches']),
            'remainingOriginalHoldReasonsPreserved':len(held),'retiredTargetReceiptsPreservedAndEvidenceVerified':len(retirement),
            'sourceCandidatesAccountedFor':len(source),'physicalOccurrencesRetained':sum(len(r['occurrences']) for r in rows),
            'newJapaneseTargets':2,'newExactTechnicalPreservations':403,'newRetirements':0,'inputPinsVerified':pins,
            'resolvedIds':[r['id'] for r in source if r['id'] in resolved],
            'overlaySha256':sha((HERE/'dialogue.ja.jsonl').read_bytes()),'limits':'Static own-lane checks; no full semantic/independent audit, renderer, reinsertion or runtime acceptance.'}
    (PHASE/'preservation-check.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:result[k] for k in ['status','savedTargetHashesPreserved','unchangedPriorBatchHashes','remainingOriginalHoldReasonsPreserved','retiredTargetReceiptsPreservedAndEvidenceVerified','sourceCandidatesAccountedFor','newJapaneseTargets','newExactTechnicalPreservations']}))
if __name__=='__main__':main()
