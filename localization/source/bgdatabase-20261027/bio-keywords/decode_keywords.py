#!/usr/bin/env python3
"""Read-only exact original BioKeyword111x4 supplement; no target text."""
import argparse
import json
from pathlib import Path
import sys
HERE = Path(__file__).resolve().parent
sys.path[:0] = [str(HERE.parent/'bio-detail')]
from decode_bio import SOURCE, SOURCE_SHA, sha, parse, sheet_decode

def decode(data):
    assert sha(data) == SOURCE_SHA
    envelope = parse(data)
    assert envelope == json.loads((HERE.parent/'inventory-decoded.json').read_text())['envelope']
    sheet = sheet_decode(next(s for s in envelope['sheets'] if s['name']=='BioKeyword'), data)
    assert len(sheet['rows']) == 111
    assert [f['name'] for f in sheet['fields']] == ['name','bio_text','savekey','plugin_db_trigger_name']
    old = json.loads((HERE.parent/'bio-detail/decoded.json').read_text())['sheets'][1]
    assert all(next(r for r in sheet['rows'] if r['id']==prior['id'])==prior for prior in old['rows'])
    assert all(sheet[k] == old[k] for k in sheet if k not in ('rows',))
    return dict(schemaVersion=1,source=str(SOURCE.relative_to(HERE.parents[3])),sourceSha256=SOURCE_SHA,
                decoderSha256=sha(Path(__file__).read_bytes()),sheets=[sheet],
                reconciledPriorRows=len(old['rows']),newlyDecodedRows=86,
                sourceAcceptance='needs-review; bounded static full BioKeyword supplement',
                reinsertion='not-run',runtime='not-run',visual='not-run',editorial='not-run')
if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',required=True,type=Path);a=p.parse_args()
    assert not a.output.exists()
    a.output.write_text(json.dumps(decode(SOURCE.read_bytes()),ensure_ascii=False,indent=2)+'\n')
