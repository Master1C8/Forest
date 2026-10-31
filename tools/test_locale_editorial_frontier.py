"""Source-context transport checks; these do not establish semantic sufficiency."""
import importlib.util
from pathlib import Path
import unittest

path = Path(__file__).parent/'locale_completion/baseline_completion_v1/editorial_frontier_v1/prepare.py'
spec = importlib.util.spec_from_file_location('editorial_frontier', path)
frontier = importlib.util.module_from_spec(spec)
spec.loader.exec_module(frontier)


class ContextTests(unittest.TestCase):
    def conversation(self):
        entries = []
        for i in range(8):
            entries.append(dict(id=i, fields=[dict(title='Dialogue Text', value='…\r\nÄ' if i == 4 else str(i)),
                dict(title='Empty', value=''), dict(title='Zero', value=0), dict(title='False', value=False)],
                conversationID=1, isRoot=i == 0, isGroup=False,
                outgoingLinks=[dict(destinationConversationID=1, destinationDialogueID=i+1)] if i < 7 else [],
                conditionsString='Variable["flag"] == false', userScript='Variable["x"] = 0',
                onExecute={'persistent': []}, falseConditionAction=0, conditionPriority=0))
        return dict(id=1, dialogueEntries=entries)

    def test_context_keeps_exact_source_values_branches_and_controls(self):
        source = self.conversation()
        context = frontier.neighborhood(source, {4})
        self.assertEqual([r['id'] for r in context], [2, 3, 4, 5, 6])
        row = context[2]
        self.assertEqual(row['fields'], [['Dialogue Text', '…\r\nÄ'], ['Zero', 0], ['False', False]])
        for key in ['outgoingLinks', 'conditionsString', 'userScript', 'onExecute', 'falseConditionAction']:
            self.assertEqual(row[key], source['dialogueEntries'][4][key])
        self.assertEqual(source['dialogueEntries'][4]['fields'][1]['value'], '')

    def test_missing_entry_or_broken_branch_rejects(self):
        source = self.conversation()
        with self.assertRaisesRegex(ValueError, 'missing source entry'):
            frontier.neighborhood(source, {99})
        source['dialogueEntries'][4]['outgoingLinks'][0]['destinationDialogueID'] = 99
        with self.assertRaisesRegex(ValueError, 'Broken in-conversation source link'):
            frontier.neighborhood(source, {4})

    def test_duplicate_entry_identity_rejects(self):
        source = self.conversation()
        source['dialogueEntries'].append(source['dialogueEntries'][4])
        with self.assertRaisesRegex(ValueError, 'Ambiguous'):
            frontier.neighborhood(source, {4})


if __name__ == '__main__':
    unittest.main()
