"""Bind directly authored display text and exact preserved source to frozen evidence."""
import hashlib,json,pathlib
ROOT=pathlib.Path(__file__).resolve().parents[2]
HERE=pathlib.Path(__file__).resolve().parent
PHASE=ROOT/'outputs/locale-assets-20261026/ja/0031-translation'
def sha(raw):return hashlib.sha256(raw).hexdigest()
def ref(p):return {'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes())}
def freeze(p,x):
    raw=(json.dumps(x,ensure_ascii=False,indent=2)+'\n').encode()
    if p.exists():assert p.read_bytes()==raw,'Immutable receipt differs'
    else:p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(raw)
def main():
    facts=json.loads((PHASE/'source-facts.json').read_text())['records']
    rows={r['id']:r for r in map(json.loads,(ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines())}
    holds_path=PHASE/'original-holds.json'
    holds={r['id']:r['reason'] for r in json.loads((holds_path if holds_path.exists() else HERE/'unresolved.json').read_text())}
    freeze(PHASE/'original-holds.json',[{'id':f['id'],'reason':holds[f['id']]} for f in facts])
    authored={}
    for line in (PHASE/'flower-display.tsv').read_text().splitlines():
        key,text=line.split('\t',1);ident='ds:'+key+':Dialogue Text'
        assert ident not in authored;authored[ident]=text
    assert set(authored)=={'ds:131:153:Dialogue Text','ds:540:232:Dialogue Text'}
    records=[]
    for f in facts:
        r=rows[f['id']];d=f['disposition']
        if d=='preserved-detached-source':
            target=r['source']
            reason='Exact preservation of this detached source authoring record. Verified absent from the conservative graph reachable from every first, root, titled and arc-keyed node across both pinned source copies, including all cross-conversation links without filtering conditions. The inspected loader selects titled arcs and traverses their links. No Japanese wording, canonical exclusion or global runtime invisibility is claimed; arbitrary external direct-node selection remains unverified.'
        else:
            assert d=='translatable-bracketed-display'; target=authored[r['id']]
            reason='Ordinary flower narration spoken by narrator actor 7, addressed to actor 1, reached through the titled/keyed meet_the_plant arc. The concrete FormattedText parser does not consume this prose as a command, and the subtitle/typewriter consumer chain retains the square delimiters. Japanese preserves the unusually large flower, hesitant observed movement and question about sleep; no gender or decoded meaning added. Both occurrences use the same self-edited wording. Runtime rendering remains unrun.'
        records.append({'id':r['id'],'sourceSha256':f['sourceSha256'],'pointer':r['pointer'],'occurrences':r['occurrences'],
                        'disposition':d,'ordinaryBracketOrdinals':f.get('ordinaryBracketOrdinals',[]),
                        'target':target,'targetSha256':sha(target.encode()),'originalHoldReason':holds[r['id']],
                        'originalHoldReasonSha256':sha(holds[r['id']].encode()),'reason':reason})
    receipt={'schemaVersion':1,'locale':'ja','phase':'0031-translation','model':{'name':'gpt-6.1-sol','reasoning':'high','provider':'openai'},
             'manifestSha256':sha((ROOT/'localization/source/dialogue-manifest.json').read_bytes()),
             'candidatesSha256':sha((ROOT/'localization/source/dialogue-candidates.jsonl').read_bytes()),
             'evidence':{'facts':ref(PHASE/'source-facts.json'),'topology':ref(PHASE/'source-topology.json'),
                         'consumers':ref(PHASE/'consumer-verification.json'),'originalHolds':ref(PHASE/'original-holds.json'),
                         'authoredDisplay':ref(PHASE/'flower-display.tsv')},
             'limits':'Provisional own-lane source/adapter resolutions only. Original source, denominator, glossary and earlier targets unchanged. Full source, editorial, special-scene, resource and runtime acceptance remain open.',
             'records':records}
    freeze(HERE/'resolutions/0031-source-bound.json',receipt)
    print(json.dumps({'resolvedIds':len(records),'displayTargets':len(authored),'technicalPreservation':len(records)-len(authored),'receipt':str(HERE/'resolutions/0031-source-bound.json')}))
if __name__=='__main__':main()
