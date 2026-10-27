#!/usr/bin/env python3
"""Bounded original pre-emphasis shape/readback, never a game/Lua execution."""
import argparse
import collections
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'bio-subtitle-inputs'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
DYNAMIC = ('[lua(', '[var=?', '[var=', '[autocase=')
FLAGS = ('[a]', '[f]', '[auto]', '[nosubtitle]')
PIC = (r'\[pic=[0-9a-zA-z_]+\]', r'\[pica=[0-9a-zA-z_]+\]', r'\[picc=[0-9a-zA-z_]+\]')


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for block in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def dump(p, value):
    p.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def prompt(s):
    """Synthetic IL transcription, Python regex/string in place of original .NET."""
    value = ''
    if '[var=?' not in s:
        return s, value
    cursor = len(s) - 1
    for _ in range(100):
        if cursor < 0:
            break
        start = s.rfind('[var=?', 0, cursor + 1)
        cursor = start - 1
        if start < 0:
            continue
        def replace(match):
            nonlocal value
            value = match[0][6:-1].strip()
            return ''
        s = s[:start] + re.sub(r'\[var=\?.*\]', replace, s[start:])
    return s, value


def extract_flag(s, flag):
    return s.replace(flag, ''), flag in s


def should_capitalize(s):
    for c in reversed(s):
        if c not in (' ', '\n'):
            return c in '.!?'
    return True


def first_case_ascii(s, upper):
    # Restricted ASCII synthetic controls. Original uses current-culture .NET
    # Char.ToUpper/Lower and UTF-16, which this does not establish for other text.
    assert s.isascii()
    if not s:
        return s
    if len(s) == 1:
        return s.upper()  # Original FirstLetterToLower also calls ToUpper here.
    return (s[0].upper() if upper else s[0].lower()) + s[1:]


def static_prefix(raw):
    """Original no-dynamic-prefix path up to emphasis; no full Parse claim."""
    s = raw or ''
    assert not any(t in s for t in DYNAMIC), 'dynamic evaluation is deliberately unsupported'
    assert '[position ' not in s and '[position=' not in s and '[panel=' not in s
    s = s.replace('|', '\n')
    pictures = [0, 0, 0]
    tokens = []
    if '[pic' in s:
        for index, pattern in enumerate(PIC):
            def replace(match):
                payload = match[0].split('=', 1)[1][:-1]
                assert re.fullmatch(r'[0-9]+', payload), 'variable picture index is unaccepted'
                value = int(payload)
                assert value <= 2147483647, 'Int32 fallback would require a Lua variable'
                pictures[index] = value
                tokens.append(dict(token=match[0], kind=('pic', 'pica', 'picc')[index], numericValue=value))
                return ''
            s = re.sub(pattern, replace, s)
    flags = {}
    for flag in FLAGS:
        s, flags[flag] = extract_flag(s, flag)
    return dict(textBeforeEmphasis=s, emptyBeforeEmphasis=(s == ''), variableInputPrompt='',
                noSubtitle=flags['[nosubtitle]'], flags=flags, pictures=pictures,
                extractedPictureTokens=tokens, position=-1, panel=-1)


def controls():
    rows = []
    def check(name, got, expected):
        assert got == expected, (name, got, expected)
        rows.append(dict(name=name, actual=got, expected=expected))
    check('prompt-removes-one-trimmed-key', prompt('a[var=? name ]b'), ('ab', 'name'))
    check('prompt-scan-right-to-left-final-key-leftmost', prompt('[var=?left] / [var=?right]'), (' / ', 'left'))
    check('prompt-greedy-through-last-bracket-on-line', prompt('[var=?name] x [pic=1]'), ('', 'name] x [pic=1'))
    check('prompt-dot-does-not-cross-LF', prompt('[var=?a\n]'), ('[var=?a\n]', ''))
    check('prompt-does-not-trim-remaining-text', prompt(' [var=?name] '), ('  ', 'name'))
    check('empty-prompt-key-has-no-nonempty-prompt', prompt('[var=?]'), ('', ''))
    check('prompt-case-sensitive', prompt('[VAR=?name]'), ('[VAR=?name]', ''))
    check('prompt-reverse-scan-cap-is-not-exhaustive', prompt('[var=?x]\n' * 101), ('[var=?x]\n' + '\n' * 100, 'x'))
    check('flag-removes-all-exact-tokens', extract_flag('[nosubtitle]a[nosubtitle]', '[nosubtitle]'), ('a', True))
    check('flag-case-and-spacing-preserved', extract_flag('[NoSubtitle] [nosubtitle ]', '[nosubtitle]'), ('[NoSubtitle] [nosubtitle ]', False))
    check('pipe-converts-to-LF', static_prefix('a||b')['textBeforeEmphasis'], 'a\n\nb')
    check('numeric-pictures-removed-last-value-wins', static_prefix('[pic=1]a[pic=2]')['pictures'], [2, 0, 0])
    check('picture-removal-does-not-trim', static_prefix('[pic=1] ')['textBeforeEmphasis'], ' ')
    check('picture-only-is-empty-at-emphasis-entry', static_prefix('[pic=1]')['emptyBeforeEmphasis'], True)
    check('bracketed-prose-preserved', static_prefix('[A flower]')['textBeforeEmphasis'], '[A flower]')
    check('noSubtitle-independent-of-nonempty-text', (static_prefix('[nosubtitle]text')['noSubtitle'], static_prefix('[nosubtitle]text')['emptyBeforeEmphasis']), (True, False))
    check('spaces-LF-only-prefix-capitalizes', should_capitalize(' \n '), True)
    check('period-prefix-capitalizes', should_capitalize('word. '), True)
    check('letter-prefix-lowercases', should_capitalize('word '), False)
    check('CR-does-not-count-as-skipped-space', should_capitalize('word.\r'), False)
    check('lower-helper-single-char-original-ToUpper', first_case_ascii('a', False), 'A')
    check('lower-helper-multiple-char-ToLower', first_case_ascii('AB', False), 'aB')
    for value in ('[lua(x)]', '[var=name]', '[autocase=name]', '[pic=Actor]'):
        try:
            static_prefix(value)
        except AssertionError as e:
            reason = str(e)
        else:
            raise AssertionError('unresolved dynamic input must reject')
        check('unsupported-boundary-' + value, reason, 'variable picture index is unaccepted' if value.startswith('[pic=') else 'dynamic evaluation is deliberately unsupported')
    return dict(boundary='Synthetic Python controls with supplied ASCII inputs; replaces original .NET execution, Lua, variables, callbacks, settings and renderer. No runtime/parser acceptance.', cases=rows)


def verify(out):
    baseline = load(HERE / 'baseline.json')
    for path, expected in baseline['priorFiles'].items():
        assert sha(ROOT / path) == expected, path
    # Reuse the unchanged phase79 recipe, writing only into this new supplement.
    spec = importlib.util.spec_from_file_location('frozen_phase79_inputs', PRIOR / 'verify_inputs.py')
    prior = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(prior)
    prior_out = out / 'prior-inputs'
    prior_out.mkdir()
    prior_stats = prior.verify(prior_out)
    assert prior_stats['frozenPinsUnchanged'] == 19 and prior_stats['helpersChecked'] == 7
    for p in prior_out.iterdir():
        assert p.read_bytes() == (PRIOR / 'readback-v2' / p.name).read_bytes(), p.name
    commands = load(HERE / 'il-commands.json')
    for c in commands:
        result = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
            str(DATA / 'Managed' / c['assembly']), c['type'], c['selection']])
        assert result == (HERE / c['output']).read_bytes(), c['output']
        assert hashlib.sha256(result).hexdigest() == c['sha256']
    # Validate the shared source in BOTH copies and bind every row to the exact entry.
    manifest = load(ROOT / 'localization/source/dialogue-manifest.json')
    candidates = [json.loads(s) for s in (ROOT / 'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    assert len(candidates) == len({c['id'] for c in candidates}) == 12246
    outputs = []
    source_copies = []
    for copy in manifest['sources']:
        assert sha(ROOT / copy['tree']) == copy['treeSha256']
        tree = load(ROOT / copy['tree'])
        for c in candidates:
            value = tree
            for part in c['pointer'].strip('/').split('/'):
                value = value[int(part)] if isinstance(value, list) else value[part]
            assert value == c['source'], c['id']
        convs = {c['id']: c for c in tree['conversations']}
        assert len(convs) == len(tree['conversations'])
        by_kind = {}
        for name in ('target-inputs', 'arc-first-inputs'):
            result = []
            for row in load(prior_out / (name + '.json')):
                entries = [e for e in convs[row['conversationId']]['dialogueEntries'] if e['id'] == row['entryId']]
                assert len(entries) == 1
                actual = prior.inputs(entries[0]['fields'], '')
                assert actual == row['defaultLanguageInputs']
                raw = actual['rawSubtitle']['value']
                shape = static_prefix(raw)
                identity = {k: row[k] for k in ('controlId', 'registrationIndex', 'conversationId', 'entryId', 'arcName') if k in row}
                result.append(dict(**identity, rawSubtitle=actual['rawSubtitle'], sequence=actual['sequence'],
                    originalEntryGroup=row['originalEntryGroup'], preEmphasis=shape,
                    rawTokens=[dict(value=m[0], startCodepoint=m.start(), endCodepoint=m.end()) for m in re.finditer(r'\[[^\]\n]*\]', raw or '')],
                    retainedBracketedText='[' in shape['textBeforeEmphasis'],
                    conditionalBoundary='Unchanged original field path up to emphasis only. Lua/variables/prompt/autocase absent in these exact inputs; callbacks may change them. Emphasis/settings, actual Subtitle, notification, display and reachability remain unaccepted.'))
            by_kind[name] = result
        outputs.append(by_kind)
        source_copies.append(dict(tree=copy['tree'], sha256=copy['treeSha256'], exactSourceValues=12246,
            targetRows=len(by_kind['target-inputs']), arcRows=len(by_kind['arc-first-inputs'])))
    assert len(outputs) == 2 and outputs[0] == outputs[1]
    stats = {}
    for name, rows in outputs[0].items():
        dump(out / (name.replace('inputs', 'formatting') + '.json'), rows)
        stats[name] = dict(rows=len(rows), emptyRaw=sum(not r['rawSubtitle']['value'] for r in rows),
            emptyBeforeEmphasis=sum(r['preEmphasis']['emptyBeforeEmphasis'] for r in rows),
            pictureRows=sum(bool(r['preEmphasis']['extractedPictureTokens']) for r in rows),
            pictureTokens=sum(len(r['preEmphasis']['extractedPictureTokens']) for r in rows),
            pictureValues=dict(collections.Counter(t['numericValue'] for r in rows for t in r['preEmphasis']['extractedPictureTokens'])),
            noSubtitle=sum(r['preEmphasis']['noSubtitle'] for r in rows),
            retainedBracketedText=sum(r['retainedBracketedText'] for r in rows),
            dynamicPrefixes={t: sum(t in (r['rawSubtitle']['value'] or '') for r in rows) for t in DYNAMIC},
            literalFlags={t: sum(t in (r['rawSubtitle']['value'] or '') for r in rows) for t in FLAGS})
    cases = controls()
    dump(out / 'source-copies.json', source_copies)
    dump(out / 'formatting-controls.json', cases)
    result = dict(status='passed-static-scoped', frozenPinsUnchanged=19, helpersChecked=7,
        priorSupplementFilesChecked=len(baseline['priorFiles']), priorEvidenceHashes=prior_stats['priorEvidenceHashes'],
        checkedInstalledSources=prior_stats['checkedInstalledSources'], priorFreshIlSelections=44,
        priorFreshMethodBodies=56, priorReadbacksByteIdentical=5,
        exactCandidateValuesPerCopy=12246, sourceCopies=2, exactSourceOccurrences=24492,
        freshMetadataSelections=len(commands), freshMethodBodies=sum((HERE / c['output']).read_text().count('\nMETHOD ') for c in commands),
        scopedInputStats=stats, syntheticControls=len(cases['cases']),
        originalGameCodeExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0,
        newDisplayCandidates=0, authoredTranslations=0, actualFormattedText='needs-review; emphasis/settings and mutable callbacks remain',
        sourceAcceptance='needs-review', runtime='not-run', visual='not-run', editorial='not-run', delivery='needs-review',
        usage='unknown in worker; parent measures telemetry')
    dump(out / 'verification.json', result)
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists(), 'output must be a new directory'
    args.output.mkdir(parents=True)
    print(json.dumps(verify(args.output)))
