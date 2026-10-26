"""Audit-storage boundaries; fake CLI replaces the model, never semantic proof."""
from contextlib import redirect_stdout
import hashlib
import io
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from unittest.mock import patch

import editorial_lane as audit


def row(ident, text='Original', target='Перевод'):
    return {'id': ident, 'source': text, 'target': target,
            'sourceSha256': hashlib.sha256(text.encode()).hexdigest(),
            'targetSha256': hashlib.sha256(target.encode()).hexdigest()}


class EditorialStorage(unittest.TestCase):
    def test_counter_or_decisions_without_reads_cannot_complete(self):
        with tempfile.TemporaryDirectory() as temporary:
            phase=Path(temporary); (phase/'reads').mkdir()
            packet=[row('one'),row('two')]
            (phase/'pairs.jsonl').write_text(''.join(audit.encoded(r)+'\n' for r in packet))
            decisions=[{'id': r['id'],'verdict':'pass','rationale':'Explicit fixture decision; model replaced.'} for r in packet]
            (phase/'decisions.jsonl').write_text(''.join(audit.encoded(r)+'\n' for r in decisions))
            audit.save(phase/'result.json',{'outcome':'batch-reviewed','reviewedIds':2})
            with self.assertRaisesRegex(AssertionError,'Missing full emitted-read coverage'):
                audit.finalize(phase)
            with redirect_stdout(io.StringIO()):audit.read_packet(phase,0,20)
            output=audit.finalize(phase)
            self.assertEqual([r['id'] for r in output],['one','two'])
            self.assertEqual(output[1]['targetSha256'],packet[1]['targetSha256'])
            (phase/'decisions.jsonl').write_text(audit.encoded(decisions[0])+'\n')
            with self.assertRaisesRegex(AssertionError,'Incomplete/foreign semantic coverage'):
                audit.finalize(phase)

    def test_long_unit_needs_every_part_without_a_gap(self):
        with tempfile.TemporaryDirectory() as temporary:
            phase=Path(temporary); packet=row('long','Source '*2000,'訳文'*5000)
            (phase/'pairs.jsonl').write_text(audit.encoded(packet)+'\n')
            (phase/'decisions.jsonl').write_text(audit.encoded({'id':'long','verdict':'pass','rationale':'Fixture only'})+'\n')
            with self.assertRaisesRegex(AssertionError,'Oversized unit'):
                audit.read_packet(phase,0,1)
            position=0
            while position<len(audit.encoded(packet)):
                captured=io.StringIO()
                with redirect_stdout(captured):audit.read_unit(phase,'long',position)
                self.assertLess(len(captured.getvalue().encode()),8000)
                position=json.loads(captured.getvalue())['end']
            audit.finalize(phase)
            next((phase/'reads').glob('unit-*-1800.json')).unlink()
            with self.assertRaisesRegex(AssertionError,'Missing full emitted-read coverage'):
                audit.finalize(phase)

    def test_finding_needs_an_actual_correction_or_source_question(self):
        with tempfile.TemporaryDirectory() as temporary:
            phase=Path(temporary); (phase/'pairs.jsonl').write_text(audit.encoded(row('one'))+'\n')
            with redirect_stdout(io.StringIO()):audit.read_packet(phase,0,1)
            decision={'id':'one','verdict':'finding','rationale':'Objective fixture source question'}
            (phase/'decisions.jsonl').write_text(audit.encoded(decision)+'\n')
            with self.assertRaisesRegex(AssertionError,'Finding requires'):
                audit.finalize(phase)
            (phase/'decisions.jsonl').write_text(audit.encoded({**decision,'requiresSourceDecision':True})+'\n')
            self.assertEqual(audit.finalize(phase)[0]['verdict'],'finding')

    def fixture(self, root):
        source=root/'localization/source'; source.mkdir(parents=True)
        glossary=root/'localization/glossary'; glossary.mkdir()
        for locale in ['en','ru']:(glossary/(locale+'.json')).write_text('[]')
        tree={'actors':[],'conversations':[{'id':1,'fields':[], 'dialogueEntries':[
            {'id':i,'fields':[{'title':'Dialogue Text','value':'Source '+str(i)}],
             'outgoingLinks':[],'conditionsString':'','userScript':'','isGroup':0} for i in [1,2]]}]}
        raw=json.dumps(tree).encode(); trees=[]; originals=[]; targets=[]
        for name in ['one.json','two.json']:
            (source/name).write_bytes(raw); trees.append({'tree':str((source/name).relative_to(root)), 'treeSha256':hashlib.sha256(raw).hexdigest()})
        for i in [1,2]:
            original={'id':f'ds:1:{i}:Dialogue Text','source':'Source '+str(i),'conversationId':1,'conversation':'fixture',
                'pointer':f'/conversations/0/dialogueEntries/{i-1}/fields/0/value','occurrences':['a','b']}
            originals.append(original); targets.append({**original,**row(original['id'],original['source'],'Перевод '+str(i))})
        (source/'dialogue-candidates.jsonl').write_text(''.join(audit.encoded(r)+'\n' for r in originals))
        (source/'dialogue-manifest.json').write_text(json.dumps({'candidateUnits':2,'physicalOccurrences':4,'sources':trees}))
        assets=root/'localization/ru-assets'; assets.mkdir()
        (assets/'dialogue.ru.jsonl').write_text(''.join(audit.encoded(r)+'\n' for r in targets))
        directory=root/'outputs/audit'; config=audit.prepare(root,directory,'ru','Russian')
        config['batches']=[[r['id']] for r in originals]; audit.save(directory/'config.json',config)
        (directory/'contract.md').write_text('Explicit fixture contract; no real review acceptance.')
        for name in ['editorial_lane.py','cli_job_support.py']:shutil.copyfile(Path(__file__).with_name(name),directory/name)
        home=root/'home'; home.mkdir(); (home/'.codex').mkdir()
        (home/'.codex/models_cache.json').write_text(json.dumps({'models':[{'slug':'gpt-6.1-sol'}]}))
        return directory,home

    def test_two_fresh_phases_finish_only_initial_pass(self):
        with tempfile.TemporaryDirectory() as temporary:
            root=Path(temporary).resolve(); directory,home=self.fixture(root); calls=[]
            class Child:
                pid=99999999
                def __init__(self,command,**kwargs):
                    self.phase=Path(command[command.index('--output-last-message')+1]).parent
                    self.out=kwargs['stdout'];calls.append(command)
                def wait(self):
                    packet=audit.rows(self.phase/'pairs.jsonl')
                    with redirect_stdout(io.StringIO()):audit.read_packet(self.phase,0,20)
                    # Deliberately simulated model decisions. No semantic claim.
                    (self.phase/'decisions.jsonl').write_text(''.join(audit.encoded({'id':r['id'],'verdict':'pass','rationale':'Fake model fixture'})+'\n' for r in packet))
                    audit.finalize(self.phase)
                    self.out.write(json.dumps({'type':'thread.started','thread_id':'fixture-'+str(len(calls))})+'\n')
                    self.out.write(json.dumps({'type':'turn.completed','usage':{'input_tokens':10,'cached_input_tokens':4,'output_tokens':2}})+'\n');self.out.flush();return 0
            with patch.object(audit.Path,'home',return_value=home),patch.object(audit.shutil,'which',return_value='/fixture/codex'),patch.object(audit.subprocess,'Popen',Child):
                audit.run(directory)
            state=json.loads((directory/'job.json').read_text())
            self.assertEqual(state['status'],'full-pass-complete-awaiting-adjudication')
            self.assertEqual(state['reviewedIds'],2);self.assertEqual(state['measuredUsage']['total_tokens'],24)
            self.assertFalse((directory/'queue.lock').exists())
            self.assertTrue(all(c[c.index('--model')+1]=='gpt-6.1-sol' and '--ignore-user-config' in c for c in calls))
            self.assertTrue(all('resume' not in c for c in calls))
            self.assertNotEqual(calls[0][-1],calls[1][-1])

    def test_changed_input_rejects_before_a_model_request(self):
        with tempfile.TemporaryDirectory() as temporary:
            root=Path(temporary).resolve();directory,home=self.fixture(root)
            (root/'localization/glossary/ru.json').write_text('["changed"]')
            with patch.object(audit.Path,'home',return_value=home),patch.object(audit.subprocess,'Popen') as request:
                with self.assertRaisesRegex(AssertionError,'Pinned editorial input changed'):
                    audit.run(directory)
                request.assert_not_called()


if __name__=='__main__':unittest.main()
