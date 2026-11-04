from pathlib import Path
import json,gzip,subprocess,hashlib,sys
root=Path('.').resolve();control=root/'localization/completion/launcher-all30-20261104-01';sys.path.insert(0,str(root/'tools'));from locale_efficiency import make_view
protected='localization/editorial-delivery/five-new-locales-20261101-01/uk/author-04/protected-source-context.jsonl'
p=root/protected
if not p.exists():
 with gzip.open(root/'localization/cleanup/20261103-source-retention-01/source-deletions.jsonl.gz','rt') as f:
  records=[json.loads(x) for x in f if protected in x]
 r=next(x for x in records if x['path']==protected);raw=subprocess.check_output(['git','cat-file','blob',r['gitBlob']],cwd=root);assert hashlib.sha256(raw).hexdigest()==r['sha256'];p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(raw)
phase=root/'outputs/launcher-all30-20261104-01/uk/independent-01';assert not (phase/'submission.json').exists();phase.mkdir(parents=True,exist_ok=True)
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
lang=root/'localization/languages/uk.json';language=json.loads(lang.read_bytes());assert sha(lang)=='4e931c945564f66d1e28297f65b6d52903e8837931a9b61424e1bcd939f8eed1'
base=root/'localization/editorial-delivery/five-new-locales-20261101-01/uk/author-04/independent-review';old=base/'review-packet.jsonl';rows=[json.loads(x) for x in old.read_text().splitlines() if x.strip()];assert len(rows)==12825
changed=[]
for row in rows:
 ident=row['id'];authored=language['translations'][ident];assert row['source']==authored['source'] and hashlib.sha256(row['source'].encode()).hexdigest()==row['sourceSha256']
 if row['target']!=authored['target']:changed.append(ident)
 row['target']=authored['target'];row['targetSha256']=hashlib.sha256(authored['target'].encode()).hexdigest()
 if 'languageSnapshotSha256' in row:row['languageSnapshotSha256']=sha(lang)
assert set(changed)=={'ds:127:299:Dialogue Text','ds:1444:1010:Dialogue Text','ds:256:201:Dialogue Text','ds:331:578:Dialogue Text','ds:517:987:Dialogue Text','ds:67:97:Dialogue Text'},changed
assert (root/'localization/editorial-delivery/five-new-locales-20261101-01/uk/quantity-repair-01/language-final.json').read_bytes()==lang.read_bytes()
packet=phase/'review-packet.jsonl';packet.write_text(''.join(json.dumps(x,ensure_ascii=False)+'\n' for x in rows))
contexts=[root/protected,base/'source-context.jsonl',root/'localization/editorial-delivery/five-new-locales-20261101-01/uk/quantity-repair-01/required-context-final.jsonl',root/'localization/completion/five-new-locales-20261101-01/source-safety-01/narrative150-source-only.jsonl']
casepaths=[root/'localization/case-decisions/five-new-locales-20261101-01/uk/author-04'/n for n in ['final-23-case-decisions.json','haiku27-final.json']]
extra=[root/'localization/completion/five-new-locales-20261101-01'/n for n in ['uk/glossary.json','uk/glossary-coverage.json','uk/name-decisions.json','glossary-en.json','actor-roster.json','source-preservation.json','source-context.jsonl','poetry-authority.json']]
missing=[str(p.relative_to(root)) for p in contexts+casepaths+extra if not p.exists()];assert not missing,missing
view=make_view(root,[packet,*contexts],phase/'lossless-view')
pins={str(p.relative_to(root)):sha(p) for p in [lang,old,packet,*contexts,*casepaths,*extra]}
save(phase/'coverage-recovery.json',dict(reason='Old final-review result and full primary judgment bodies are absent from retained archives; hash-only references cannot establish acceptance.',oldReviewPath='outputs/five-new-locales-20261101-01/uk/independent-01/primary-judgments.jsonl',oldReviewSha256='feff34d3432d6ab68f5f52392a5490f8327e7a60c483343c1bb571f7f6f39dc9',strategy='Fresh full independent review of exact current 12825 versions; preserve prior source and wording',sourceTargetsRebound=changed))
job=dict(locale='uk',culture='uk',writePrefixes=[str(phase.relative_to(root))],immutablePins=pins,initialLanguageSha256=sha(lang))
task=dict(kind='review',taskClass='semantic-review',title='Complete exact-current Ukrainian independent semantic coverage after unrecoverable old judgment bodies',reviewPacket=str(packet.relative_to(root)),reviewPacketSha256=sha(packet),contextPackets=[str(p.relative_to(root)) for p in contexts],caseInputs=[str(p.relative_to(root)) for p in casepaths],glossaryInputs=[str(p.relative_to(root)) for p in extra[:5]])
save(phase/'task.json',dict(job=job,task=task,losslessView=dict(path=str((phase/'lossless-view/manifest.json').relative_to(root)),sha256=sha(phase/'lossless-view/manifest.json')),laneRole='locale-owned'))
(phase/'brief.md').write_text('''# Complete the existing Ukrainian independent review

FIRST await runtime-verification.json proving fresh gpt-6.1-sol/high/OpenAI/null-parent before localized input. No inherited history, resume/fork, nested agent/model, Astra/fallback, Git, game/GUI/screenshots/build/installer, publication/deployment/server action. Write ONLY this phase; source, glossary, language and old evidence are immutable. This continues the owner-authorized Ukrainian locale assignment.

Read task.json, applicable instructions, complete pinned English/Ukrainian glossary and name/character rules once. Run tools/locale_efficiency.py inspect and read the complete lossless readingPages, resolving every wording/context reference needed. Read all 12,825 exact current ordinary source/target versions, full required context, all 23 special-case decisions and all 27 haiku combinations with actual source outcome identities. Preserve original 1,781 protected states as source context. Retained artwork/resource/runtime holds are separate; do not invent missing translated image units or claim those gates passed.

A storage minimization left hash-only references to the old full independent judgments but not their review bodies. They cannot be reused as semantic acceptance. This fresh full review is required by the missing-evidence boundary; do not manufacture 12,806 passes from the old count. Current authored text is already complete and remains unchanged. Six entries changed between the sealed author04 packet and current language (five prior corrections plus ds:517:987). The parent rebound every exact current target and included the final 266-row quantity-family context. Their IDs are in coverage-recovery.json; all current primary versions require actual review. Give particular care to participant counts, quantifier scope, comparisons, threshold versus exact number, branch joins and reveal timing.

Actually review every assigned unit for fidelity and naturalness against English, own glossary, speaker/addressee, branch/consumer context, gender/address, relationships, sexual role versus dominance, humor, poetry and markup. Source/control identities and selector metadata are verified mechanically, not substitute semantic reading. Read coherent substantial batches; keep actual judgments/checkpoints across compaction and finish the finite corpus rather than stopping after a routine batch. Collect all objective findings with exact IDs, full source-supported replacement proposals and dependencies. Do not rewrite equivalent valid wording for taste and do not edit any language.

Write real per-ID JSONL judgments with explicit verdict and concise substantive fidelity/native rationale. Never generate default passes or mark unread input reviewed. Record required-context reading separately. Publish with tools/locale_review_work.py finish-review and an exact parent adjudication task; missing IDs/context stay unread. Completing this review does not accept fonts, native rendering or release. No follow-on reviewer launch by you.
''')
save(phase/'next-parent-task.json',dict(kind='work',taskClass='editorial-consolidated-repair',title='Adjudicate Ukrainian full independent findings and prepare one exact correction delta',brief=str((phase/'brief.md').relative_to(root)),entryPins=[dict(path=str(packet.relative_to(root)),sha256=sha(packet))]))
print('Prepared exact-current Ukrainian review:',len(rows),'primary rows; source/control inventory unchanged')
