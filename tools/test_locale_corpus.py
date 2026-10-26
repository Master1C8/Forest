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
    def test_source_bound_display_approval_preserves_nested_controls(self):
        with tempfile.TemporaryDirectory() as temporary:
            root=Path(temporary).resolve()
            source=root/'localization/source'; source.mkdir(parents=True)
            here=root/'localization/es-assets'; (here/'batches').mkdir(parents=True)
            out=root/'outputs/es'; out.mkdir(parents=True)
            (out/'input-pins.json').write_text('{}')
            (here/'locale.json').write_text(json.dumps({'locale':'es','sourceLocale':'en','jobDirectory':'outputs/es'}))
            shutil.copyfile(Path(__file__).with_name('locale_corpus.py'),here/'corpus.py')
            evidence=source/'consumer-fixture.txt'
            evidence.write_text('Fixture replaces source consumer evidence; no runtime or semantic acceptance.')
            token='[lua(Variable["names"][1])]'
            original='[A flower 3. '+token+']'
            translated='[Una flor 3. '+token+']'
            def setup(text):
                tree={'conversations':[{'id':1,'dialogueEntries':[{'fields':[{'value':text}]}]}]}
                raw=json.dumps(tree).encode(); trees=[]
                for name in ['one.json','two.json']:
                    (source/name).write_bytes(raw)
                    trees.append({'tree':str((source/name).relative_to(root)),'treeSha256':hashlib.sha256(raw).hexdigest()})
                (source/'dialogue-manifest.json').write_text(json.dumps({'candidateUnits':1,'physicalOccurrences':2,'conversations':1,'sources':trees}))
                row={'id':'ds:1:1:Dialogue Text','conversationId':1,'conversation':'fixture','source':text,
                     'pointer':'/conversations/0/dialogueEntries/0/fields/0/value','occurrences':['one','two']}
                inventory=source/'dialogue-candidates.jsonl'; inventory.write_text(json.dumps(row)+'\n')
                return {'schemaVersion':1,'locale':'es','sourceInventorySha256':hashlib.sha256(inventory.read_bytes()).hexdigest(),
                    'records':[{'id':row['id'],'sourceSha256':hashlib.sha256(text.encode()).hexdigest(),
                        'pointer':row['pointer'],'occurrences':row['occurrences'],'ordinaryBracketOrdinals':[0],
                        'reason':'Explicit display-prose fixture approval',
                        'consumerEvidence':[{'path':str(evidence.relative_to(root)),'sha256':hashlib.sha256(evidence.read_bytes()).hexdigest()}]}]}
            manifest=setup(original)
            def run(target):
                (here/'batches/0001.tsv').write_text('1:1\t'+target+'\n')
                return subprocess.run([sys.executable,str(here/'corpus.py'),'build'],capture_output=True,text=True)
            rejected=run(translated)
            self.assertNotEqual(rejected.returncode,0)
            self.assertIn('protected controls mismatch',rejected.stderr)
            approvals=here/'display-approvals.json'
            approvals.write_text(json.dumps(manifest))
            accepted=run(translated)
            self.assertEqual(accepted.returncode,0,accepted.stderr)
            overlay=here/'dialogue.es.jsonl'; saved=overlay.read_bytes()
            self.assertEqual(json.loads(saved)['target'],translated)
            self.assertIn('dialogue.es.jsonl',(out/'continuation.md').read_text())
            self.assertNotIn('Russian',(out/'continuation.md').read_text())
            self.assertEqual(run(translated).returncode,0)
            self.assertEqual(overlay.read_bytes(),saved)
            for target,reason in [(translated.replace('[1]','[2]'),'protected controls mismatch'),
                                  (translated.replace('3.','4.'),'number mismatch'),
                                  (translated.replace('Una','[nosubtitle]Una'),'protected controls mismatch')]:
                with self.subTest(reason=reason):
                    rejected=run(target)
                    self.assertNotEqual(rejected.returncode,0)
                    self.assertIn(reason,rejected.stderr)
                    self.assertEqual(overlay.read_bytes(),saved)
            for field,value,reason in [('sourceSha256','wrong','Display source mismatch'),
                                       ('pointer','/wrong','Display occurrence mismatch')]:
                changed=json.loads(json.dumps(manifest)); changed['records'][0][field]=value
                approvals.write_text(json.dumps(changed)); rejected=run(translated)
                self.assertNotEqual(rejected.returncode,0); self.assertIn(reason,rejected.stderr)
            changed={**manifest,'locale':'ja'}; approvals.write_text(json.dumps(changed))
            rejected=run(translated)
            self.assertNotEqual(rejected.returncode,0); self.assertIn('Display approval locale mismatch',rejected.stderr)
            approvals.write_text(json.dumps(manifest)); evidence.write_text('changed evidence')
            rejected=run(translated)
            self.assertNotEqual(rejected.returncode,0); self.assertIn('Display evidence mismatch',rejected.stderr)
            evidence.write_text('Fixture replaces source consumer evidence; no runtime or semantic acceptance.')
            manifest=setup('[pic=6]Hello')
            approvals.unlink()
            self.assertEqual(run('Hola').returncode,0)
            approvals.write_text(json.dumps(manifest)); rejected=run('Hola')
            self.assertNotEqual(rejected.returncode,0); self.assertIn('Display span became engine control',rejected.stderr)

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
