"""Launch one finite existing locale review with verified fresh Sol/high identity."""
from pathlib import Path
import datetime,hashlib,json,subprocess,sys
ROOT=Path('/Users/antonkrutov/Desktop/Forest');sys.path.insert(0,str(ROOT/'tools'))
from cli_job_support import validate_model,cli_events
from cli_runtime_identity import publish_current_runtime
from locale_efficiency import make_view

CONTROL=ROOT/'localization/completion/launcher-all30-20261104-01'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,d):p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
def main():
    validate_model('gpt-6.1-sol','high','openai')
    locale=sys.argv[1];assert locale=='hi','Prepare other exact locale scopes before launch'
    phase=ROOT/'outputs/launcher-all30-20261104-01'/locale/'independent-01'
    assert not phase.exists(),'Reconcile the existing request; do not duplicate it'
    original=json.loads((ROOT/'localization/completion/last-six-locales-20261103-01/hi/task.json').read_bytes())
    task=json.loads((ROOT/'outputs/last-six-locales-20261103-01/hi/author-auto-0001/next-task.v2.json').read_bytes())
    pins=dict(original['job']['immutablePins'])
    for pin in task['entryPins']:
        assert pin['path'] not in pins or pins[pin['path']]==pin['sha256']
        pins[pin['path']]=pin['sha256']
    rebases=[]
    for name,pin in list(pins.items()):
        actual=sha(ROOT/name)
        if actual!=pin:
            assert name in ['LOCALIZATION.md','tools/forest_localization/core.py'],('Changed semantic prerequisite',name)
            old_bytes=subprocess.check_output(['git','show','bb29b8c2bf:'+name],cwd=ROOT)
            assert hashlib.sha256(old_bytes).hexdigest()==pin
            rebases.append(dict(path=name,oldSha256=pin,currentSha256=actual,reason='Reviewed bb29b8c2bf..f5931acf98: only registration/documentation of seven native quest-list point-size roles. Hindi layout is empty; wording, IDs, source, glossary, framework and all semantic review inputs are unchanged.'))
            pins[name]=actual
    assert json.loads((ROOT/'localization/languages/hi.json').read_bytes())['layout']=={}
    phase.mkdir(parents=True)
    save(phase/'operational-pin-rebase.json',rebases)
    rel=str(phase.relative_to(ROOT))
    job=dict(locale=locale,culture='hi',writePrefixes=[rel],immutablePins=pins,initialLanguageSha256=sha(ROOT/'localization/languages/hi.json'))
    task.update(kind='review',taskClass='semantic-review',ownerResume='Current owner request: finish Hindi, Swahili and Ukrainian for the all-30 launcher. Resume Hindi at its prepared independent semantic review; no old workers restarted.')
    packets=[ROOT/task['reviewPacket']]+[ROOT/n for n in task['contextPackets']]
    view=make_view(ROOT,packets,phase/'lossless-view')
    config=dict(job=job,task=task,losslessView=dict(path=str((phase/'lossless-view/manifest.json').relative_to(ROOT)),sha256=sha(phase/'lossless-view/manifest.json')),laneRole='locale-owned')
    save(phase/'task.json',config)
    brief='''# Complete the existing Hindi independent review

First await this phase runtime-verification.json. Only after it proves fresh gpt-6.1-sol/high/OpenAI and null parent may you read localization content. No inherited chat/author history, resume/fork, other model, nested agent, Git, game/GUI, screenshot, build, installer, publication or server action. Write only this phase; source, translations and sealed evidence are immutable. You are the independent reviewer, not an author.

Read task.json, its original pinned review brief, applicable instructions and the complete approved Hindi glossary once. Run python3 -B tools/locale_efficiency.py --phase PHASE inspect. Use its complete readingPages instead of duplicating the 14 MB raw packet. Resolve all references needed for wording and semantic context. Review all 12,825 ordinary units plus six artwork wordings, all 23 special groups, all 27 haiku compositions and every required context input. The original protected states remain source context. Never count a script/hash/default verdict as semantic reading. Read coherent substantial batches, preserving actual progress across compaction; do not stop after a routine batch or invent a token budget.

Judge fidelity and naturalness independently for each exact version, including speaker/addressee, quantities, branch conditions, sexual role versus dominance, reveal timing, markup scope, literary effects and approved terminology. Collect every objective finding before any parent consolidated repair. Propose complete replacements with source/context rationale when needed; do not change any language file. Record only actual judgments as JSONL with id, explicit pass/finding/needs-context verdict and concise substantive fidelity/native rationales. Identical default passes and inferred coverage are forbidden. Save explicit context-reading coverage separately. Missing primary/context stays unread.

Publish using tools/locale_review_work.py finish-review with this phase, actual judgments and an exact next task. It attaches the actual hashes/runtime metadata and retains missing IDs. A completed review returns a parent consolidated-finding-adjudication task, never another whole review or claimed native acceptance. If blocked, state the exact missing evidence and retain real reviewed rows; do not relaunch or fabricate a pass. The rendering-risk decision is already recorded and does not block this static semantic review. No paid follow-on request may be created by you.
'''.replace('PHASE',str(phase))
    (phase/'brief.md').write_text(brief)
    save(phase/'next-parent-task.json',dict(kind='work',taskClass='editorial-consolidated-repair',title='Adjudicate all actual Hindi independent findings and prepare one exact correction delta',brief=str((phase/'brief.md').relative_to(ROOT)),entryPins=[dict(path=task['reviewPacket'],sha256=task['reviewPacketSha256'])]))
    cli='/Applications/ChatGPT.app/Contents/Resources/codex-cli/CodexCLI.app/Contents/MacOS/codex'
    prompt=f'FIRST wait for {phase}/runtime-verification.json proving actual fresh Sol/high/OpenAI/null-parent before localized input. Then read {phase}/brief.md and task.json and complete that bounded assignment. No inherited history, nested agent/model or Git. Write only {phase}.'
    argv=[cli,'exec','--ignore-user-config','--model','gpt-6.1-sol','-c','model_provider="openai"','-c','model_reasoning_effort="high"','-c','approval_policy="never"','--sandbox','danger-full-access','--disable','multi_agent','--cd',str(ROOT),'--json','--output-last-message',str(phase/'last-message.txt'),prompt]
    save(phase/'submission.json',dict(argv=argv,model='gpt-6.1-sol',reasoning='high',provider='openai',fork_context=False,atUTC=datetime.datetime.now(datetime.timezone.utc).isoformat()))
    with (phase/'events.jsonl').open('xb') as out,(phase/'stderr.log').open('xb') as err:
        child=subprocess.Popen(argv,cwd=ROOT,stdin=subprocess.DEVNULL,stdout=out,stderr=err,start_new_session=True)
    save(phase/'process.json',dict(pid=child.pid,phase=rel))
    runtime=publish_current_runtime(phase,child,timeout=45)
    print(json.dumps(dict(phase=rel,pid=child.pid,threadId=runtime['threadId'],runtimeVerified=True)),flush=True)
    code=child.wait();thread,usage,errors=cli_events(phase/'events.jsonl')
    save(phase/'process-exit.json',dict(exitCode=code,threadId=thread,usage=usage,errors=errors,atUTC=datetime.datetime.now(datetime.timezone.utc).isoformat()))
    print(json.dumps(dict(exitCode=code,usage=usage,errors=errors)),flush=True)
if __name__=='__main__':main()
