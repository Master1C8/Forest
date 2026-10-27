#!/usr/bin/env python3
"""Reproduce the nine exact selected feature-upgrade bodies with frozen Cecil readers."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
OLD = HERE.parent / 'bio-tmp-font-upgrade'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
READER = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
SCOPES = HERE.parent / 'bio-tmp-backing-style-replacement/bin/Debug/net8.0/BackingScopes.dll'
COUNTS = [110, 9, 3, 3, 3, 13, 7, 3, 12]
def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for block in iter(lambda: f.read(4194304), b''): h.update(block)
    return h.hexdigest()
def load(p): return json.loads(p.read_text())
def write(p, d): p.write_text(json.dumps(d, indent=2) + '\n')
def ordered(t, *tokens):
    pos = 0
    for token in tokens: pos = t.index(token, pos) + len(token)
def retained():
    baseline = load(HERE / 'baseline.json')
    for p, h in baseline['priorFiles'].items(): assert sha(ROOT / p) == h, p
    for p, a in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / a) == baseline['summaryPins'][p]
    spec = importlib.util.spec_from_file_location('frozen_phase108', OLD / 'verify_upgrade.py')
    m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
    prior = m.retained()
    for group in ['codeHashes', 'outputHashes']:
        for p, h in load(OLD / 'reproducibility.json')[group].items(): assert sha(OLD / p) == h, p
    reuse = load(HERE / 'retained-consumers.json')
    for entry in reuse['consumers'] + [reuse['pairRebuild']]:
        trace = ROOT / entry['trace']
        assert sha(trace) == entry.get('traceSha256', entry.get('sha256'))
        for e in entry['bodyEvidence']: assert sha(trace.parent / e['path']) == e['sha256']
    for p, e in load(HERE / 'process-reference-verification.json').items():
        assert sha(Path(p)) == e['expected'] == e['actual'] and e['matches']
    return dict(status='passed-hash-parity', phase108Files=len(baseline['priorFiles']), previousRetained=prior,
                processReferences=7, reusedDirectManagedBodies=1, readerRebuilds=0)
def checks(texts, s):
    chunks = [c for t in texts for c in t.split('METHOD ')[1:]]
    expected = [sig for row in load(HERE / 'il-commands.json') for sig in row['signatures']]
    assert [c.split(' |')[0] for c in chunks] == expected
    assert [sum(l.startswith('IL_') for l in c.splitlines()) for c in chunks] == COUNTS
    assert [d['signature'] for d in s['selectedMethods']] == expected
    assert s['selectedMethods'][0] == load(OLD / 'next-consumer.json')['nextMetadata'][0]
    for d in s['selectedMethods']:
        assert d['hasBody'] and d['implementation'] == 'IL'
        assert not d['isVirtual'] and not d['isNewSlot'] and not d['isFinal']
        assert d['genericArity'] == 0 and not d['explicitOverrides']
    assert [len(s[k]) for k in ['directMethodOperands', 'fieldOperands', 'opaqueRuntimeOperands', 'exceptionHandlers']] == [20, 38, 11, 9]
    assert all(not row['handlers'] for row in s['exceptionHandlers']) and s['nextDeclarations'] == []
    t = chunks[0]
    ordered(t, '::get_name()', '::Log(System.Object,UnityEngine.Object)', 'IL_0021: brtrue.s IL_002e', 'TMPro.TMP_FontFeatureTable::.ctor()', 'IL_0029: stfld', '::get_Count()', 'IL_003e: stloc.0', 'List`1<TMPro.TMP_GlyphPairAdjustmentRecord>::.ctor(System.Int32)', 'IL_004b: stfld')
    assert t.count('::get_Count()') == 1
    ordered(t, 'IL_0069: ldc.i4.0', 'IL_006a: stloc.3', '::get_firstGlyph()', '::TryGetValue(!0,!1&)', 'IL_007e: brfalse.s IL_0088', '::get_glyphIndex()', 'IL_0087: stloc.3', 'IL_0088: ldc.i4.0', 'IL_0089: stloc.s V_5', '::get_secondGlyph()', '::TryGetValue(!0,!1&)', 'IL_009e: brfalse.s IL_00a9', '::get_glyphIndex()', 'IL_00a7: stloc.s V_5')
    for getter in ['get_firstGlyphAdjustments', 'get_secondGlyphAdjustments']:
        assert t.count('::' + getter + '()') == 4
    for name in ['xPlacement', 'yPlacement', 'xAdvance', 'yAdvance']:
        assert t.count('GlyphValueRecord_Legacy::' + name) == 2
    ordered(t, 'IL_00a9: ldloc.3', 'TMPro.TMP_GlyphValueRecord::.ctor(', 'TMPro.TMP_GlyphAdjustmentRecord::.ctor(', 'IL_00e2: ldloc.s V_5', 'TMPro.TMP_GlyphValueRecord::.ctor(', 'TMPro.TMP_GlyphAdjustmentRecord::.ctor(', 'TMPro.TMP_GlyphPairAdjustmentRecord::.ctor(', '::Add(!0)', 'IL_0139: ldloc.1', 'IL_013a: ldloc.0', 'IL_013b: blt IL_0057', 'IL_0146: ldnull', 'IL_0147: stfld System.Collections.Generic.List`1<TMPro.KerningPair> TMPro.KerningTable::kerningPairs', 'IL_014d: ldnull', 'IL_014e: stfld TMPro.KerningTable TMPro.TMP_FontAsset::m_KerningTable', 'IL_0153: ret')
    assert 'm_GlyphPairAdjustmentRecordLookupDictionary' not in t and '::Clear()' not in t
    for c in [chunks[i] for i in [2, 3, 4, 7]]:
        assert c.count(': ldfld ') == 1 and ': call' not in c
    assert chunks[5].count(': stfld ') == 4 and chunks[6].count(': stfld ') == 2
    ordered(chunks[8], '::m_FirstAdjustmentRecord', '::m_SecondAdjustmentRecord', 'ldc.i4.0', '::m_FeatureLookupFlags')
    assert chunks[8].count(': stfld ') == 3
    assert all('Register' not in c and 'Material::' not in c for c in chunks)
    consumers = load(HERE / 'consumer-boundaries.json')['consumers']
    assert {r['definition']['signature']: r['definition'] for r in consumers} == {r['definition']['signature']: r['definition'] for r in s['directMethodOperands']}
    assert len(consumers) == 11
    assert [sum(x['bodyStatus'] == status for x in consumers) for status in ['read-this-phase', 'prior-complete-reading-reused-by-hash', 'managed-body-unread']] == [8, 1, 2]
    coverage = load(HERE / 'source-trace.json')['coverage']
    for e, text in zip(coverage['exportFiles'], texts):
        assert sha(HERE / e['path']) == e['sha256']
        assert e['lines'] == len(text.splitlines())
        assert [i for lo, hi in e['modelReadLineRanges'] for i in range(lo, hi + 1)] == list(range(1, e['lines'] + 1))
    assert not coverage['unreadSelectedBodyRanges']
    return dict(selectedBodies=9, instructions=163, perBodyInstructions=COUNTS, fullReadCoverage=True,
                exportLines=181, methodOperands=20, fieldOperands=38, opaqueRuntimeOperands=11,
                handlers=0, uniqueMethodDeclarations=11, reusedDirectManagedBodies=1, unreadDirectManagedBodies=2)
def verify(out):
    pins = retained(); write(out / 'retained-input-verification.json', pins)
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    rows = load(HERE / 'il-commands.json'); texts = []
    for name, group in [('font-feature-upgrade.il', rows[:1]), ('direct-dependencies.il', rows[1:])]:
        text = ''
        for row in group:
            run = subprocess.run(['dotnet', str(READER), str(DATA / row['assembly']), row['type'], row['selection']], capture_output=True, text=True, check=True)
            assert not run.stderr
            chunks = [c for c in run.stdout.split('METHOD ')[1:] if c.split(' |')[0] in row['signatures']]
            assert [c.split(' |')[0] for c in chunks] == row['signatures']
            text += 'TYPE ' + row['type'] + '\n' + ''.join('METHOD ' + c for c in chunks)
        (out / name).write_text(text); assert sha(out / name) == sha(HERE / name); texts.append(text)
    run = subprocess.run(['dotnet', str(SCOPES), str(DATA), str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')], capture_output=True, check=True)
    assert not run.stderr; (out / 'dependency-scopes.json').write_bytes(run.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = load(out / 'dependency-scopes.json')
    for row in scopes['directMethodOperands'] + scopes['fieldOperands']:
        assert sha(DATA / row['definition']['module']) == row['definition']['sha256']
    for d in scopes['selectedMethods'] + load(HERE / 'next-consumer.json')['nextMetadata']:
        assert sha(DATA / d['module']) == d['sha256']
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', **checks(texts, scopes), retained=pins,
                  originalResourcesDecoded=0, gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0,
                  gitMutations=0, readerRebuilds=0, authoredTranslations=0, noMocks=True,
                  sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None)
    write(out / 'verification.json', result); return result
if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__); p.add_argument('--output', type=Path, required=True)
    out = p.parse_args().output.resolve(); assert HERE in out.parents and not out.exists(); out.mkdir()
    print(json.dumps(verify(out)))
