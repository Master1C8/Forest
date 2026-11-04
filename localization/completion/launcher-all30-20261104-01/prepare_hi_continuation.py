"""Freeze the existing Hindi independent review's unread continuation, not a new stream."""
import json,hashlib,shutil
from pathlib import Path
R=Path('/Users/antonkrutov/Desktop/Forest'); C=R/'localization/completion/launcher-all30-20261104-01/hi-review-continuation';C.mkdir(exist_ok=False)
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,d):p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
source='localization/completion/five-new-locales-20261101-01/source-context.jsonl'
preservation='localization/completion/five-new-locales-20261101-01/source-preservation.json'
ids={json.loads(l)['id'] for l in (R/source).read_text().splitlines()}
phase='outputs/launcher-all30-20261104-01/hi/independent-01';task=json.loads((R/phase/'task.json').read_bytes());packet=task['task']['reviewPacket']
extra=[json.loads(l) for l in (R/packet).read_text().splitlines() if json.loads(l)['id'] not in ids];assert len(extra)==6
supp=C/'supplemental-wording.jsonl';supp.write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in extra))
frozen=C/'runtime';frozen.mkdir()
for name in ['locale_review_lifecycle.py','locale_cli_lifecycle.py','cli_job_support.py']:shutil.copyfile(R/'tools'/name,frozen/name)
pins={str(p.relative_to(R)):digest(p) for p in [*frozen.glob('*.py'),supp,R/source,R/preservation,R/packet]}
lane=dict(locale='hi',language='localization/languages/hi.json',phase=phase,assignmentTask=phase+'/task.json',progressRoots=['outputs/launcher-all30-20261104-01/hi'],status='adopted-running',fullReviewPacket=packet,fullReviewPacketSha256=digest(R/packet),supplementalReviewPacket=dict(path=str(supp.relative_to(R)),sha256=digest(supp)),sequence=0)
cfg=dict(root=str(R),model='gpt-6.1-sol',reasoning='high',provider='openai',streamCap=1,sourcePacket=source,preservation=preservation,lanes=[lane],phaseRoot='outputs/launcher-all30-20261104-01',output='outputs/launcher-all30-20261104-01/hi-review-controller',cli='/Applications/ChatGPT.app/Contents/Resources/codex-cli/CodexCLI.app/Contents/MacOS/codex',capacityBackoffSeconds=60,maxCapacityRetries=2,maxNoProgressTurns=2,pollSeconds=5,immutablePins=pins)
save(C/'manifest.json',cfg)
print(C/'manifest.json')
