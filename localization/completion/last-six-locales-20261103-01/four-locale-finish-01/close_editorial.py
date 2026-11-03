"""Bind actual exact independent judgments into final text evidence; no verdict generation."""
import argparse
import datetime
import hashlib
import json
from pathlib import Path
import sys

ROOT=Path('/Users/antonkrutov/Desktop/Forest')
sys.path.insert(0,str(ROOT/'tools'))
from locale_review_lifecycle import checked_rows
from locale_cli_lifecycle import inspect_language, process_identity, validate_identity

C=Path('localization/completion/last-six-locales-20261103-01')
O=Path('outputs/last-six-locales-20261103-01')
S=Path('localization/completion/five-new-locales-20261101-01')
W=C/'four-locale-finish-01'


def read(p):return json.loads((ROOT/p).read_text())
def rows(p):return [json.loads(s) for s in (ROOT/p).read_text().splitlines() if s.strip()]
def sha(p):return hashlib.sha256((ROOT/p).read_bytes()).hexdigest()
def pin(p):return dict(path=str(p),sha256=sha(p))


def main(loc):
    control=W/(loc+'-delta');phase=O/loc/'independent-delta-01'
    assert read(phase/'process-exit.json')['exitCode']==0
    runtime=read(phase/'runtime-verification.json');validate_identity(runtime)
    assert not process_identity(runtime['pid'],ROOT/phase,runtime['threadId'])
    task=read(control/'task.json')['task'];author=task['authorThreadId']
    assert runtime['threadId']!=author
    result=read(phase/'result.json');p=result['reviews'];p=p['path'] if isinstance(p,dict) else p
    packet={r['id']:r for r in rows(Path(task['reviewPacket']))}
    judged=checked_rows(ROOT/p,packet,runtime['threadId'])
    assert set(judged)==set(packet) and all(r['verdict']=='pass' for r in judged.values()),'Delta has unread versions or findings'
    ledger=read(Path(p).parent/'pending-ledger.json')
    assert ledger['contextComplete'] and not ledger['pendingIds']
    assert not result.get('blocker') and not result.get('blockers')
    retained_path=Path(task['retainedIndependent']['path'])
    assert sha(retained_path)==task['retainedIndependent']['sha256']
    retained=rows(retained_path);all_rows=retained+list(judged.values())
    assert len(all_rows)==12825 and len({r['id'] for r in all_rows})==12825
    language_path=Path('localization/languages')/(loc+'.json');language=read(language_path)
    source={r['id']:r for r in rows(S/'source-context.jsonl')};protected=read(S/'source-preservation.json')['baselinePreserved']
    safety=inspect_language(ROOT,dict(locale=loc,language=str(language_path)),{k:v['source'] for k,v in source.items()},protected)
    assert not safety['remaining'] and {r['id'] for r in all_rows}==source.keys()-protected.keys()
    for r in all_rows:
        assert r['verdict']=='pass' and r['sourceSha256']==source[r['id']]['sourceSha256']
        assert r['targetSha256']==hashlib.sha256(language['translations'][r['id']]['target'].encode()).hexdigest()
    original_author_phase=O/loc/('author-01' if loc=='sw' else 'author-auto-0001')
    original_author=read(original_author_phase/'runtime-verification.json')['threadId']
    assert all(r['reviewerThreadId'] not in [author,original_author] for r in all_rows)
    directory=W/'editorial';directory.mkdir(exist_ok=True)
    out=directory/(loc+'-independent-final.jsonl')
    with (ROOT/out).open('x') as f:
        for r in all_rows:f.write(json.dumps(r,ensure_ascii=False)+'\n')
    contexts={'hu':'coverage-verification-delivery.json','nl':'required-context-status.json','ro':'required-context-status-final-01.json','sr':'context-completion.json'}
    context_paths=[O/loc/'review-auto-0001'/contexts[loc],Path(p).parent/'pending-ledger.json',phase/'result.json',phase/'runtime-verification.json']
    acceptance=dict(format='forest-final-text-acceptance-v1',atUTC=datetime.datetime.now(datetime.timezone.utc).isoformat(),locale=loc,
                    language=pin(language_path),sourcePacket=pin(S/'source-context.jsonl'),preservation=pin(S/'source-preservation.json'),
                    independentReviews=pin(out),ordinary=12825,protected=1781,contextComplete=True,
                    contextReceipts=[pin(p) for p in context_paths],authorThreadIds=[original_author,author],
                    glossaryPins=[pin(S/'glossary-en.json'),pin(C/loc/'glossary.json'),pin(C/loc/'glossary-coverage.json'),pin(C/loc/'name-decisions.json')],
                    independentFinalDelta=pin(Path(p)),retainedIndependent=pin(retained_path),
                    native='not-run',release='not-accepted',humanGlossary='owner-deferred',
                    boundary='Saved exact independent wording/context closure, separate from resource/native/font/artwork acceptance.')
    dest=directory/(loc+'.json')
    with (ROOT/dest).open('x') as f:json.dump(acceptance,f,ensure_ascii=False,indent=2);f.write('\n')
    print(json.dumps(dict(locale=loc,passed=True,ordinary=12825,delta=len(judged),retained=len(retained),acceptance=str(dest))))


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('locale',choices=['hu','nl','ro','sr']);main(p.parse_args().locale)
