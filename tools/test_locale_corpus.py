"""Real deterministic builds for six locale parameters; no model or game requests."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


class LocaleCorpus(unittest.TestCase):
    def test_six_locale_outputs_preserve_source_controls_and_bindings(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary).resolve()
            source = root / 'localization/source'
            source.mkdir(parents=True)
            tree = {'conversations': [{'id': 1, 'dialogueEntries': [{'fields': [{'value': '[pic=6]Hello!'}]}]}]}
            raw = json.dumps(tree).encode()
            trees = []
            for n in ('one.json', 'two.json'):
                (source / n).write_bytes(raw)
                trees.append({'tree': str((source / n).relative_to(root)), 'treeSha256': hashlib.sha256(raw).hexdigest()})
            (source / 'dialogue-manifest.json').write_text(json.dumps({'candidateUnits': 1, 'physicalOccurrences': 2, 'conversations': 1, 'sources': trees}))
            row = {'id': 'ds:1:1:Dialogue Text', 'conversationId': 1, 'conversation': 'fixture',
                   'source': '[pic=6]Hello!', 'pointer': '/conversations/0/dialogueEntries/0/fields/0/value',
                   'occurrences': ['one', 'two']}
            (source / 'dialogue-candidates.jsonl').write_text(json.dumps(row) + '\n')
            # Authored fixture wording is never a claimed game translation.
            phrases = {'zh': '你好！', 'es': '¡Hola!', 'es-419': '¡Hola!', 'pt-BR': 'Olá!', 'ja': 'こんにちは！', 'de': 'Hallo!'}
            for locale, phrase in phrases.items():
                with self.subTest(locale=locale):
                    here = root / 'localization' / (locale + '-assets')
                    (here / 'batches').mkdir(parents=True)
                    out = root / 'outputs' / locale
                    out.mkdir(parents=True)
                    (out / 'input-pins.json').write_text('{}')
                    config = {'locale': locale, 'sourceLocale': 'en', 'jobDirectory': str(out.relative_to(root))}
                    (here / 'locale.json').write_text(json.dumps(config))
                    shutil.copyfile(Path(__file__).with_name('locale_corpus.py'), here / 'corpus.py')
                    (here / 'batches/0001.tsv').write_text('1:1\t' + phrase + '\n')
                    result = subprocess.run([sys.executable, str(here / 'corpus.py'), 'build'], capture_output=True, text=True)
                    self.assertEqual(result.returncode, 0, result.stderr)
                    target = json.loads((here / ('dialogue.' + locale + '.jsonl')).read_text())
                    self.assertEqual(target['target'], '[pic=6]' + phrase)
                    self.assertEqual(target['occurrences'], ['one', 'two'])
                    progress = json.loads((out / 'progress.json').read_text())
                    self.assertEqual(progress['locale'], locale)
                    self.assertEqual(progress['authoredIds'], 1)
                    self.assertFalse((here / 'dialogue.ru.jsonl').exists())
                    (here / 'locale.json').write_text(json.dumps({**config, 'locale': 'ru'}))
                    rejected = subprocess.run([sys.executable, str(here / 'corpus.py'), 'build'], capture_output=True, text=True)
                    self.assertNotEqual(rejected.returncode, 0)
                    self.assertIn('Explicit matching locale required', rejected.stderr)


if __name__ == '__main__':
    unittest.main()
