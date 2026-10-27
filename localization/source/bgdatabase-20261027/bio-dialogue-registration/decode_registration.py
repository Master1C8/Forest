#!/usr/bin/env python3
"""Read-only original Dialogue identity/primary actor/arc-control supplement."""
import argparse
import json
from pathlib import Path
import sys
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
sys.path[:0]=[str(HERE.parent/'bio-detail')]
from decode_bio import SOURCE, SOURCE_SHA, sha, parse, sheet_decode
FIELDS=('name','savekey','plugin_db_name','type','primary_actor','initial_actor','has_player_initiated_question')
def decode(raw):
    assert sha(raw)==SOURCE_SHA
    envelope=parse(raw)
    assert envelope==json.loads((HERE.parent/'inventory-decoded.json').read_text())['envelope']
    original=next(s for s in envelope['sheets'] if s['name']=='Dialogue')
    selected=dict(original,fields=[f for f in original['fields'] if f['name'] in FIELDS])
    assert tuple(f['name'] for f in selected['fields'])==FIELDS
    sheet=sheet_decode(selected,raw)
    sheet['opaqueFields']=[f for f in original['fields'] if f['name'] not in FIELDS]
    assert len(sheet['rows'])==600 and len(set(sheet['rowIds']))==600
    return dict(schemaVersion=1,source=str(SOURCE.relative_to(ROOT)),sourceSha256=SOURCE_SHA,
                decoderSha256=sha(Path(__file__).read_bytes()),sheets=[sheet],
                scope='Selected registry identity, exact primary/initial actor relations and arc question flag only; other fields remain opaque',
                sourceAcceptance='needs-review; static scoped supplement',reinsertion='not-run',runtime='not-run',visual='not-run',editorial='not-run')
if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True);a=p.parse_args();assert not a.output.exists()
    a.output.write_text(json.dumps(decode(SOURCE.read_bytes()),ensure_ascii=False,indent=2)+'\n')
