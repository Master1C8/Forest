"""Exact old/new strings, partial application, LF and unknown-state regression."""
import hashlib, unittest
from preflight import compare_rows

def row(pid,source='Options\n',target='Optionen\n'):
    return dict(id=f'level1:{pid}/m_text',source=source,target=target,sourceSha256=hashlib.sha256(source.encode()).hexdigest(),targetSha256=hashlib.sha256(target.encode()).hexdigest())

class PreflightTests(unittest.TestCase):
    def test_exact_complete_and_partial_layers(self):
        rows=[row(1),row(2)]
        good={1:{'m_text':'Optionen\n'},2:{'m_text':'Optionen\n'}}
        self.assertTrue(compare_rows(good,rows)['passed'])
        partial={1:{'m_text':'Optionen\n'},2:{'m_text':'Options\n'}}
        result=compare_rows(partial,rows)
        self.assertFalse(result['passed']);self.assertEqual([r['status'] for r in result['rows']],['target','source'])
    def test_unknown_newline_and_substring_never_pass(self):
        for actual in ['Optionen','Optionen\nOptions\n','Optionen\n extra']:
            result=compare_rows({1:{'m_text':actual}},[row(1)])
            self.assertFalse(result['passed']);self.assertEqual(result['rows'][0]['status'],'unknown')
    def test_duplicate_and_hash_guards(self):
        r=row(1)
        with self.assertRaisesRegex(ValueError,'unique'):compare_rows({1:{'m_text':'Optionen\n'}},[r,r])
        r['target']='Other'
        with self.assertRaisesRegex(ValueError,'content hash'):compare_rows({1:{'m_text':'Other'}},[r])
if __name__=='__main__':unittest.main()
