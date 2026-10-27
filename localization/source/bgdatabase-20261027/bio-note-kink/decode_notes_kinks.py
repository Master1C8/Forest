#!/usr/bin/env python3
"""Read-only original BioNote17x16/BioKink17x22 typed supplement."""
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
    sheets = []
    for name, prefix, count in [('BioNote','note',6),('BioKink','kink',9)]:
        s = sheet_decode(next(s for s in envelope['sheets'] if s['name']==name), data)
        expected = ['actor','name'] + [f for i in range(1,count+1) for f in (f'{prefix}{i}',f'hide_in_list{i}')] + ['enable_with_tags','is_default']
        assert len(s['rows']) == 17 and [f['name'] for f in s['fields']] == expected
        assert len(set(s['rowIds'])) == 17
        sheets.append(s)
    return dict(schemaVersion=1,source=str(SOURCE.relative_to(HERE.parents[3])),sourceSha256=SOURCE_SHA,
                decoderSha256=sha(Path(__file__).read_bytes()),sheets=sheets,
                sourceAcceptance='needs-review; bounded static BioNote/BioKink supplement',
                reinsertion='not-run',runtime='not-run',visual='not-run',editorial='not-run')
if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',required=True,type=Path);a=p.parse_args()
    assert not a.output.exists()
    a.output.write_text(json.dumps(decode(SOURCE.read_bytes()),ensure_ascii=False,indent=2)+'\n')
