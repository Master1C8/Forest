"""Regression fixtures for the bounded draft adapter; no game runtime mocks credited."""
import copy
import contextlib
import io
import importlib
import json
import pathlib
import tempfile
import unittest

from inline_guard import (controls, load_dispositions, sha, validate_preserve_manifest,
                          validate_target)

HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parents[1]
ROWS = {r['id']: r for r in map(json.loads, (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines())}
DECISIONS = load_dispositions(HERE/'source-dispositions.json', ROOT, ROWS)


class InlineGuardTests(unittest.TestCase):
    def fixture(self, source, target, **kwargs):
        return validate_target({'id': 'fixture', 'source': source}, target, **kwargs)

    def test_actual_flower_brackets(self):
        for ident in ('ds:131:153:Dialogue Text', 'ds:540:232:Dialogue Text'):
            r, d = ROWS[ident], DECISIONS[ident]
            target = '[На редкость крупный цветок. Он… шевелится… Спит, что ли?]'
            self.assertEqual(validate_target(r, target, d), 'translated-wording')
            self.assertEqual(controls(target, [0]), ['[', ']'])
            with self.assertRaisesRegex(AssertionError, 'Ordinary bracket layout'):
                validate_target(r, target[1:-1], d)
            with self.assertRaisesRegex(AssertionError, 'protected controls mismatch'):
                validate_target(r, '[Цветок [nosubtitle] спит?]', d)

    def test_engine_command_and_argument_exact(self):
        self.fixture('[pic=6]Hello', '[pic=6]Привет')
        with self.assertRaisesRegex(AssertionError, 'protected controls mismatch'):
            self.fixture('[pic=6]Hello', '[pic=7]Привет')
        with self.assertRaisesRegex(AssertionError, 'Ordinary bracket layout'):
            controls('[pic=6]', [0])

    def test_nested_and_quoted_lua(self):
        token = '[lua(Variable["actors"][1]["name"]) ]'.replace(') ]', ')]')
        source, target = token+' Hello', token+' Привет'
        self.fixture(source, target)
        self.assertEqual(controls(source), [token])
        with self.assertRaisesRegex(AssertionError, 'protected controls mismatch'):
            self.fixture(source, target.replace('[1]', '[2]'))
        with self.assertRaisesRegex(AssertionError, 'protected controls mismatch'):
            self.fixture(source, target.replace('actors', 'actor'))
        quoted = '[lua(Variable["a]b"]["x[\\\"q"])]'
        self.fixture(quoted+' Done', quoted+' Готово')
        self.assertEqual(controls(quoted), [quoted])

    def test_unapproved_bracket_stays_opaque(self):
        self.fixture('[unknown=exact]Hello', '[unknown=exact]Привет')
        with self.assertRaisesRegex(AssertionError, 'protected controls mismatch'):
            self.fixture('[unknown=exact]Hello', '[unknown=changed]Привет')
        with self.assertRaisesRegex(AssertionError, 'protected controls mismatch'):
            self.fixture('[A flower.]', '[Цветок.]')

    def test_other_engine_tags_placeholders_and_markup(self):
        prefix = '[var=Name][autocase=Town][position 3][panel=2][em1]'
        self.fixture(prefix+'Hello {item}[/em1]<b>now</b>', prefix+'Привет {item}[/em1]<b>сейчас</b>')
        for old, new in [('Name', 'Имя'), ('{item}', '{items}'), ('<b>', '<i>'), ('panel=2', 'panel=3')]:
            with self.subTest(old=old), self.assertRaisesRegex(AssertionError, 'protected controls mismatch'):
                self.fixture(prefix+'Hello {item}<b>now</b>', (prefix+'Привет {item}<b>сейчас</b>').replace(old, new))
        self.fixture('Hello {{item}}', 'Привет {{item}}')
        with self.assertRaisesRegex(AssertionError, 'Unbalanced brace placeholder'):
            self.fixture('Hello {{item}}', 'Привет {{item}')

    def test_numbers_and_separators(self):
        self.fixture('Take 3 apples\nNow|Go\r', 'Возьми 3 яблока\nСейчас|Иди\r')
        with self.assertRaisesRegex(AssertionError, 'number mismatch'):
            self.fixture('Take 3 apples', 'Возьми 4 яблока')
        for separator in ('\n', '\r', '|'):
            with self.subTest(separator=separator), self.assertRaisesRegex(AssertionError, 'line separator mismatch'):
                self.fixture('Hello'+separator+'there', 'Привет там')

    def test_typewriter_escape_exact(self):
        self.fixture(r'Hello\. Now\, go\^', r'Привет\. А теперь\, иди\^')
        with self.assertRaisesRegex(AssertionError, 'protected controls mismatch'):
            self.fixture(r'Hello\. Now', 'Привет. Теперь')

    def test_terminal_input_is_source_bound(self):
        for ident in ('ds:466:760:Dialogue Text', 'ds:466:821:Dialogue Text'):
            row, d = ROWS[ident], DECISIONS[ident]
            self.assertEqual(validate_target(row, row['source'], d), 'reviewed-unchanged-nonprose')
            # Same tags, numbers and separators: this must hit the whole-field guard.
            with self.assertRaisesRegex(AssertionError, 'unchanged nonprose mismatch'):
                validate_target(row, row['source'].replace('inventory.Add', 'inventory.Remove'), d)
            with self.assertRaisesRegex(AssertionError, 'unchanged nonprose mismatch'):
                validate_target(row, row['source']+' Готово', d)
            with self.assertRaisesRegex(AssertionError, 'Disposition source hash mismatch'):
                validate_target({**row, 'source': row['source']+'x'}, row['source']+'x', d)
            with self.assertRaisesRegex(AssertionError, 'no Russian text'):
                validate_target(row, row['source'])

    def test_technical_record_keeps_all_source_bytes(self):
        ident = 'ds:41:216:Dialogue Text'
        row, d = ROWS[ident], DECISIONS[ident]
        self.assertEqual(validate_target(row, row['source'], d), 'preserved-detached-source')
        with self.assertRaisesRegex(AssertionError, 'unchanged nonprose mismatch'):
            validate_target(row, row['source'].replace('Violet:', 'Вайолет:'), d)

    def test_advice_prefix_exact(self):
        ident = 'ds:227:180:Dialogue Text'
        self.assertEqual(validate_target(ROWS[ident], 'ADVICE Кто тут главный?', DECISIONS[ident]), 'translated-wording')
        with self.assertRaisesRegex(AssertionError, 'protected prefix mismatch'):
            validate_target(ROWS[ident], 'СОВЕТ Кто тут главный?', DECISIONS[ident])

    def test_evidence_tampering_and_source_spans(self):
        ident = 'ds:131:153:Dialogue Text'
        d = copy.deepcopy(DECISIONS[ident])
        with tempfile.TemporaryDirectory(dir=HERE) as td:
            td = pathlib.Path(td)
            evidence = td/'consumer.txt'
            evidence.write_text('pinned evidence')
            d['consumerEvidence'] = [{'path': str(evidence.relative_to(ROOT)), 'sha256': sha(evidence.read_bytes())}]
            p = td/'decisions.json'
            p.write_text(json.dumps({'schemaVersion': 1, 'records': [d]}))
            self.assertEqual(set(load_dispositions(p, ROOT, ROWS)), {ident})
            evidence.write_text('changed evidence')
            with self.assertRaisesRegex(AssertionError, 'Consumer evidence hash mismatch'):
                load_dispositions(p, ROOT, ROWS)
            evidence.write_text('pinned evidence')
            d['protectedSpans'][0]['text'] = 'wrong'
            p.write_text(json.dumps({'schemaVersion': 1, 'records': [d]}))
            with self.assertRaisesRegex(AssertionError, 'Source protected span mismatch'):
                load_dispositions(p, ROOT, ROWS)

    def test_preserve_manifest_completeness(self):
        validate_preserve_manifest(HERE/'preserve-exactly.json', HERE/'source-dispositions.json', DECISIONS, ROWS)
        doc = json.loads((HERE/'preserve-exactly.json').read_text())
        with tempfile.TemporaryDirectory(dir=HERE) as td:
            p = pathlib.Path(td)/'manifest.json'
            doc['records'].pop()
            p.write_text(json.dumps(doc))
            with self.assertRaisesRegex(AssertionError, 'Preserve manifest incomplete'):
                validate_preserve_manifest(p, HERE/'source-dispositions.json', DECISIONS, ROWS)

    def test_import_does_not_build(self):
        paths = [HERE/'dialogue.ru.jsonl', ROOT/'outputs/ru-assets-parallel-20261026/progress.json',
                 ROOT/'outputs/ru-assets-parallel-20261026/continuation.md']
        before = {str(p): sha(p.read_bytes()) for p in paths}
        importlib.import_module('corpus')
        self.assertEqual(before, {str(p): sha(p.read_bytes()) for p in paths})


class BuildRecoveryTests(unittest.TestCase):
    def setUp(self):
        self.c = importlib.import_module('corpus')
        self.temp = tempfile.TemporaryDirectory(dir=HERE)
        base = pathlib.Path(self.temp.name)
        self.assets, self.output = base/'assets', base/'run'
        (self.assets/'batches').mkdir(parents=True)
        self.output.mkdir()
        self.old_here, self.old_out, self.old_dump = self.c.HERE, self.c.OUT, self.c.dump
        self.c.HERE, self.c.OUT = self.assets, self.output
        (self.output/'input-pins.json').write_bytes((self.old_out/'input-pins.json').read_bytes())
        (self.assets/'source-dispositions.json').write_bytes((HERE/'source-dispositions.json').read_bytes())
        self.ident = 'ds:131:153:Dialogue Text'
        self.target = '[На редкость крупный цветок. Он… шевелится… Спит, что ли?]'
        (self.assets/'batches/0097.tsv').write_text('131:153\t'+self.target+'\n')

    def tearDown(self):
        self.c.HERE, self.c.OUT, self.c.dump = self.old_here, self.old_out, self.old_dump
        self.temp.cleanup()

    def build(self):
        with contextlib.redirect_stdout(io.StringIO()):
            self.c.build()

    def add_resolution(self):
        old = self.assets/'batches/0001.tsv'
        line = '131:153\t!HOLD Test source classification hold'
        old.write_text(line+'\n')
        d = DECISIONS[self.ident]
        receipt = {'id': self.ident, 'sourceSha256': d['sourceSha256'],
                   'targetSha256': sha(self.target.encode()), 'targetBatch': '0097',
                   'dispositionSha256': sha(json.dumps(d, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()),
                   'priorHold': {'path': str(old.relative_to(ROOT)), 'sha256': sha(old.read_bytes()),
                                 'locator': {'lineNumber': 1, 'lineSha256': sha(line.encode())},
                                 'reason': 'Test source classification hold'}}
        p = self.assets/'resolved-holds.json'
        p.write_text(json.dumps({'schemaVersion': 1, 'records': [receipt]}))
        return p, receipt

    def test_partial_write_then_rebuild(self):
        def fail_progress(path, value):
            if path == self.output/'progress.json':
                raise OSError('injected between overlay/unresolved and progress writes')
            self.old_dump(path, value)
        self.c.dump = fail_progress
        with self.assertRaisesRegex(OSError, 'injected between'):
            self.build()
        overlay = self.assets/'dialogue.ru.jsonl'
        first = overlay.read_bytes()
        self.assertEqual(json.loads(first)['target'], self.target)
        self.assertTrue((self.assets/'unresolved.json').exists())
        self.assertFalse((self.output/'progress.json').exists())
        self.c.dump = self.old_dump
        self.build()
        self.assertEqual(overlay.read_bytes(), first)
        self.assertEqual(json.loads((self.output/'progress.json').read_text())['savedTargetIds'], 1)
        # Verify the first successful postcondition before crediting a repeat.
        self.assertEqual(json.loads(first)['targetSha256'], sha(self.target.encode()))
        self.build()
        self.assertEqual(overlay.read_bytes(), first)

    def test_resolved_hold_checks_old_occurrence(self):
        self.add_resolution()
        self.build()
        old = self.assets/'batches/0001.tsv'
        old.write_text(old.read_text().replace('classification', 'different'))
        with self.assertRaisesRegex(AssertionError, 'Resolution prior hold mismatch'):
            self.build()

    def test_resolved_hold_checks_new_target(self):
        path, receipt = self.add_resolution()
        self.build()
        receipt['targetSha256'] = '0'*64
        path.write_text(json.dumps({'schemaVersion': 1, 'records': [receipt]}))
        with self.assertRaisesRegex(AssertionError, 'Resolution target mismatch'):
            self.build()


if __name__ == '__main__':
    unittest.main(verbosity=2)
