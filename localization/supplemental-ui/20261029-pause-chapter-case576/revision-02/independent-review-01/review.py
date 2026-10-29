"""Record this reviewer's completed model readings; deterministic checks are separate.

No target wording is generated or applied. Writes only beside this file.
"""
import collections
import hashlib
import json
import os
from pathlib import Path
import re

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
OUT = Path(__file__).resolve().parent
PACK = OUT.parent
V1 = PACK.parent
TECH = ROOT / 'localization/source/pause-chapter576-binding-contract-20261029'
SOURCE = ROOT / 'localization/source/chapter-select-heading-20261029'
SESSION = os.environ['CODEX_THREAD_ID']

def load(p):
    return json.loads(Path(p).read_text())

def lines(p):
    return [json.loads(l) for l in Path(p).read_text().splitlines()]

def digest(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()

def uh(s):
    return hashlib.sha256(s.encode()).hexdigest()

def canonical(x):
    return json.dumps(x, ensure_ascii=False, sort_keys=True, separators=(',', ':'))

def objhash(x):
    return uh(canonical(x))

def write(n, x):
    (OUT / n).write_text(json.dumps(x, ensure_ascii=False, indent=2) + '\n')

def jl(n, rows):
    (OUT / n).write_text(''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':')) + '\n' for r in rows))

rows = lines(PACK / 'ru.prepared.jsonl')
groups = lines(PACK / 'complete-semantic-groups.jsonl')
contexts = lines(PACK / 'source-context.jsonl')
by = {r['id']: r for r in rows}
cb = {r['id']: r for r in contexts}
matrix = lines(TECH / 'selector-binding-matrix.jsonl')
mb = {r['id']: r for r in matrix}

# Explicit model-authored semantic and separate Russian-read judgments.
# Exact repeated physical faces are factored only after all IDs and groups were read.
J = {}
def judge(nums, fidelity, russian):
    for n in nums:
        key = f'group-{n:03}'
        assert key not in J
        J[key] = {'semantic': fidelity, 'russian': russian}

judge([1,158,161], 'Run Cheat? remains a question offering the one-shot action. The three source callbacks set true; no toggle or activation result is added to the question.', 'Применить чит? is a natural concise action question. The same phrase fits all three complete six-layer faces.')
judge([3], 'The quit confirmation preserves the decision to leave the game. Its unsaved-progress warning and Yes/No choices are separate complete fields.', 'Выйти из игры? is idiomatic confirmation wording and matches the Выйти action.')
judge([4], 'Effects remains the audio-effects volume label, paired with the sound slider and separate Music control.', 'Эффекты is natural and clear within the sound settings.')
judge([5,9,10,16], 'On remains the active state of the exact bound Fullscreen/Stretch or Dustin/Plant chooser. The displayed state is independent of the protected GO and callback names.', 'Вкл. is a standard concise enabled-state caption, with consistent abbreviation and punctuation.')
judge([6], 'Forfeit the match retains surrendering this match; it is not quitting the application. Yes/No and the source unsaved-progress warning remain associated.', 'Сдаться в матче? is grammatical, unambiguous confirmation wording paired with Сдаться.')
judge([7], 'Save remains the manual-save action connected through OnClickSave to MainMenuSave/ManualSave.', 'Сохранить is the conventional infinitive action label.')
judge([8,114,126], 'Ok remains acknowledgment for disabled, successful and empty-report panels respectively; no action or report-sending instruction is added.', 'ОК is a natural short acknowledgment in each panel, consistently capitalized.')
judge([11], 'The platform restriction, feedback from a desktop game build, alternative game website and exact tfol.info literal are all retained. Three lines remain three lines.', 'The full Russian paragraph is grammatical; версия игры для компьютера conveys Desktop build naturally, and Оставьте отзыв matches the report instructions register.')
judge([12], 'Menu preserves the menu action and remains distinct from quitting. Its confirmation asks about returning to the menu.', 'Меню is the normal Russian menu label.')
judge([13,34,40,58,67,105], 'Yes preserves the affirmative choice for its own quit/forfeit/menu/adventure/report-cancel/report-send question. No callback is inferred from the spelling alone.', 'Да is the natural affirmative answer in each complete paired confirmation.')
judge([14], 'Forfeit retains the match-surrender action, distinct from Retry and Quit.', 'Сдаться is the appropriate concise action, consistent with the match confirmation.')
judge([15], 'Unlock All Gallery Scenes retains all, the unlock action and the approved Gallery concept. All six headings are only literal wording reviews: the full18 UnlockMovies control stays application-held.', 'Открыть все сцены галереи: is grammatical and coherent with the other cheat headings; its final colon is retained.')
judge([17,55,66], 'Back retains navigation back in the Cheats, Options and report panels; it does not assert report cancellation before the source confirmation.', 'Назад is the conventional short navigation label in all three panels.')
judge([19], 'Scale retains the window scale-factor setting. The source ScaleFactor callback anomaly is preserved rather than rewritten as a wording decision.', 'Масштаб: is natural as the noun label for this setting, including the colon.')
judge([20], 'Quit preserves leaving the game and is paired with the explicit quit confirmation.', 'Выйти is a conventional Russian application action and matches Выйти из игры?.')
judge([21], 'Dustin Minigame Invincible retains the named minigame and invincibility state, using the approved Дастин name without invented character facts.', 'Неуязвимость в мини-игре Дастина: is grammatical and precise. Its length remains a native-layout risk, not a wording defect.')
judge([22], 'Complete All Dates retains completion of all encounters, using the approved Свидание sense rather than calendar dates.', 'Завершить все свидания: is natural and preserves all and the final colon.')
judge([24,37,57,65], 'Off remains the inactive state of each exact source chooser, opposite On. It does not rename any protected boolean, GO or callback.', 'Выкл. is the standard concise disabled-state caption paired consistently with Вкл..')
judge([25,38,42,47,80,89], 'No preserves the negative answer for its particular forfeit/adventure/quit/menu/report-cancel/report-send question and its exact callback identity.', 'Нет is the correct natural negative reply in every paired dialog.')
judge([26], 'Unlock All Story Chapters retains the unlock action, all and the story-chapter restriction.', 'Открыть все сюжетные главы: is grammatical and consistent with Выбор главы.')
judge([28], 'Cancel the adventure retains ending the current adventure. Its separate warning retains progress loss and ability to start it again later.', 'Прервать приключение? is clear confirmation wording consistent with the action label.')
judge([29], 'Retry retains trying the current minigame again, distinct from the separate replay-adventure action.', 'Повторить is a concise natural retry label in this menu context.')
judge([31], 'Report Bug retains reporting an error and remains distinct from actually submitting the report later.', 'Сообщить об ошибке is conventional Russian UI wording.')
judge([32], 'The question preserves going to the menu, with unsaved loss retained in its separate warning.', 'Вернуться в меню? is idiomatic and does not conflate menu navigation with game exit.')
judge([33], 'Replay an Adventure retains the adventure replay action and the approved Приключение concept.', 'Повторить приключение is a natural action phrase consistent with Прервать приключение.')
judge([35], 'Fullscreen retains the full-screen mode setting and its bound On/Off states.', 'Полный экран: is a standard setting label with its colon preserved.')
judge([36,41,54], 'Activated preserves the resulting activation state for each of the three one-shot cheat callbacks, not an invitation to toggle it off.', 'Активировано is a natural impersonal state caption. No character gender is introduced.')
judge([43], 'Stretch retains the screen-stretch setting; its On/Off companions remain state captions.', 'Растянуть: is a grammatical UI action-form label and remains understandable with Вкл./Выкл.. No style-only replacement is required.')
judge([44], 'When finished, press action and both exact [Escape]/[B] alternatives remain. The six accepted-current instruction fields retain exact input72 receipts.', 'The full instruction is fluent singular-address Russian and makes the gamepad alternative clear.')
judge([45], 'Options remains access to settings and stays paired with the OptionsMenu controller.', 'Настройки is the conventional natural Russian menu label.')
judge([46], 'Progress loss remains unconditional here; the ability to restart that adventure later is retained. It is not restricted to unsaved progress.', 'The complete Russian sentence is grammatical and explicitly identifies приключение as what can be restarted.')
judge([48], 'Controls remains the player-control settings action, separate from screen and audio settings.', 'Управление is the normal Russian UI heading for input controls.')
judge([49,59,61], 'Unsaved restricts the progress that will be lost in each quit/forfeit/menu warning. The exclamation and full warning remain intact.', 'Несохранённый прогресс будет потерян! is clear, grammatical and consistent across the three actual dialogs.')
judge([50], 'Complete All Gossips preserves all and completion of the approved Беседы system rather than malicious rumor.', 'Завершить все беседы: is natural and uses the approved terminology.')
judge([51], 'The entire warning retains chapter selection erasing unlocked progress, all four categories (gossips, dates, scenes, gifts), the future improvement statement, blank paragraph and terminal newline. No preservation promise is invented.', 'The full Russian warning reads coherently in its line-broken form. открытый прогресс follows the source unlock terminology; all four nouns are parallel. Native fit of the long category line is unverified.')
judge([53], 'Cheats retains the menu category and no protected cheats_* keys are translated.', 'Читы is the established concise Russian gaming term.')
judge([56], 'Prevent Drip in the plant minigame remains prevention of drops, not an invented hands-free description derived from the internal property name. Растение is the approved entity; no gender fact is added.', 'Без капель в мини-игре растения: is grammatical and conveys the source label. The source wording is terse; no broader gameplay claim is made.')
judge([62], 'Cancel Adventure retains interrupting the current adventure and links coherently to its confirmation and full loss/restart warning.', 'Прервать приключение is natural and matches the question exactly.')
judge([64,162], 'All seven Chapter Select memberships retain the approved Выбор главы, including the distinct header17682 and six pause-button layers. No ornamental title/Pause header is imported.', 'Выбор главы is natural menu/header wording and is consistent in both physical groups.')
judge([69], 'Cancel the bug report and erasure of the entered text both remain in their full two-line replacement, without changing agency or loss conditions.', 'Отменить отчёт об ошибке? and Введённый текст будет удалён. form clear grammatical Russian.')
judge([71], 'The send-report confirmation remains a question before submission, separate from the success panel.', 'Отправить отчёт об ошибке? is natural and matches the send button.')
judge([72], 'System Info remains the selectable system-information label and is separate from generated diagnostic column data and protected detail indicators.', 'О системе: is a conventional concise label for system information.')
judge([74,145], 'ENTER remains the accepted-current keyboard action caption; emitted key identity and callback data remain protected and distinct.', 'ВВОД is natural for the Enter action and the two layouts agree.')
judge([77], 'Edit Text retains entering/editing the report text and matches the literal label quoted by the report instructions.', 'Изменить текст is conventional Russian action wording.')
judge([82], 'The report has no text and the instruction to add text and try again both remain. Добавьте описание is contextually the required report text, not an added field.', 'The complete two-line warning is fluent and politely tells the user how to recover.')
judge([91], 'All three source instructions remain: select Edit Text to explain the event, tool gathers other needed data, and user adjusts the amount/detail of system data sent. The blank paragraph and exact quoted button wording remain.', 'The whole Russian paragraph reads naturally with consistent polite address. программа соберёт сама preserves tool agency; сколько сведений expresses the adjustable detail level clearly.')
judge([92,132], 'DONE remains the accepted-current finish-keyboard action caption, preserving its distinct callbacks and both exact physical IDs.', 'ГОТОВО is a standard and natural completion caption, identical in both layouts.')
judge([96], 'Send Report retains the action and its two-line structure, distinct from prior preparation or later success.', 'Отправить/отчёт is grammatical across the retained line break and matches the confirmation.')
judge([106], 'The entire success message preserves successful sending and thanks for feedback, with both sentences and newline retained. It does not establish actual network delivery in this review.', 'The full Russian success paragraph is natural, grammatical and consistent with отчёт об ошибке elsewhere.')
judge([117], 'Physical and virtual keyboard alternatives plus touch and gamepad support all remain. The accepted-current placeholder keeps its exact prior target and receipt.', 'The full Russian placeholder reads fluently; экранной — она supports both touchscreen and gamepad without an agreement problem.')
judge([130], 'SHIFT remains the accepted-current case-change action caption; the actual protected keycode/display-cache contract is retained.', 'РЕГИСТР is clear for the keyboard case-change control and introduces no Latin-layout translation.')
judge([134], 'The information-to-be-sent introductory statement remains complete. It does not localize or alter the separate generated payload columns.', 'Будут отправлены следующие сведения: is natural Russian with the correct future passive and final colon.')
judge([160], 'Music remains the music-volume slider label, distinct from effects.', 'Музыка is the conventional natural Russian audio-setting label.')

wordgroups = {g['groupId'] for g in groups if any(r['target'] is not None for r in g['members'])}
assert set(J) == wordgroups, (wordgroups-set(J), set(J)-wordgroups)
write('judgments.authored.json', J)

# The model read the entire source/target group representations and then a separate
# target-only group representation. Every individual ID is bound below to that judgment.
semantic, native, groupreceipts, nullreceipts = [], [], [], []
for g in groups:
    gid = g['groupId']
    assert g['ids'] == [m['id'] for m in g['members']]
    gr = {'groupId': gid, 'hierarchy': g['hierarchy'], 'ids': g['ids'],
          'groupSha256': objhash(g), 'assembly': g['assembly'], 'reviewer': SESSION,
          'allMembersRead': True, 'factoring': 'Only byte-identical full fields in their reconciled physical group; no sampling or concatenation.'}
    if gid in J:
        gr.update(semantic=J[gid]['semantic'], separateRussianRead=J[gid]['russian'])
    else:
        contracts = sorted({by[i]['consumerContract'] for i in g['ids']})
        gr.update(contextContracts=contracts, semantic='No nonnull target: protected or application-held context read; no translation pass is created.')
    groupreceipts.append(gr)
    for m in g['members']:
        r = by[m['id']]
        assert (m['source'],m['target'],m['applicationClass']) == (r['source'],r['target'],r['applicationClass'])
        common = {'id':r['id'], 'ordinal':r['ordinal'], 'groupId':gid,
                  'sourceValueSha256':r['sourceValueSha256'], 'sourceUtf8Sha256':uh(r['source']),
                  'targetUtf8Sha256':uh(r['target']) if r['target'] is not None else None,
                  'sourceContextRowSha256':objhash(cb[r['id']]), 'technicalBindingSha256':objhash(mb[r['id']]),
                  'hierarchy':r['hierarchy'], 'applicationClass':r['applicationClass'],
                  'consumerContract':r['consumerContract'], 'reviewer':SESSION,
                  'targetApplied':False, 'actualGameRuntime':'not-run'}
        if r['target'] is not None:
            semantic.append(dict(common, source=r['source'], target=r['target'], verdict='pass',
                reviewKind='new-independent-whole-final576-source-to-target-semantic', rationale=J[gid]['semantic'], findings=[]))
            native.append(dict(common, target=r['target'], verdict='pass',
                reviewKind='new-separate-native-Russian-read-whole-final452', rationale=J[gid]['russian'], findings=[]))
        else:
            nullreceipts.append(dict(common,source=r['source'],currentValue=r['currentValue'],
                verdict='context-preserved-not-a-translation-pass', technicalDisposition=r['technicalDisposition'],
                exactPreservationRequired=True, applicationHeld=r['applicationClass']=='application-held'))
jl('semantic-receipts.jsonl', sorted(semantic,key=lambda r:r['ordinal']))
jl('russian-read-receipts.jsonl', sorted(native,key=lambda r:r['ordinal']))
jl('group-receipts.jsonl',groupreceipts)
jl('null-context-receipts.jsonl',sorted(nullreceipts,key=lambda r:r['ordinal']))
write('findings-and-delta.json', {'objectiveWordingFindings':[], 'proposedReplacements':[], 'proposedDeltaIds':[],
    'scope':'All576 IDs; independent fidelity and separate Russian read for all452 nonnull fields.',
    'styleOnlyRewrites':False, 'targetApplied':False})
(OUT/'proposed-delta.jsonl').write_text('')
(OUT/'proposed-delta-ids.txt').write_text('')

# Independent deterministic verification of exact saved inputs, selectors and receipts.
checks = []
def need(ok, name):
    assert ok, name
    checks.append(name)

ids = [r['id'] for r in rows]
need(len(ids)==len(set(ids))==576,'576-unique-canonical-target-ids')
source=lines(SOURCE/'pause-chapter-576.source.jsonl')
rb=lines(SOURCE/'pause-chapter-576-readback.jsonl')
common=lines(ROOT/'localization/source/shared-source-completion-20261028/admission-v1/serialized-inventory.jsonl')
prefixes=('LevelSingletons/PauseScreenUI/','LevelSingletons/ChapterSelectUI/')
selected=[r for r in common if r.get('hierarchy','').startswith(prefixes)]
need(ids==[r['id'] for r in source]==[r['id'] for r in rb]==[r['id'] for r in selected], 'exact-existing-common-inventory-prefix-selection-no-new-IDs')
need(ids==[r['id'] for r in matrix]==[r['id'] for r in contexts],'source-target-context-matrix-order-correspondence')
need(collections.Counter(i for g in groups for i in g['ids'])==collections.Counter(ids),'164-group-partition-complete-no-duplicate-or-missing')
for r,s,b,m,c in zip(rows,source,rb,matrix,contexts):
    need(all(r[k]==s[k]==b[k]==m[k] for k in ('id','source','sourceValueSha256','hierarchy','pointer','className','role')), 'binding:'+r['id'])
    need(r['currentValue']==b['currentValue']==m['currentValue'], 'current:'+r['id'])
    need(r['sourceUtf8Sha256']==uh(r['source']) and r['currentUtf8Sha256']==uh(r['currentValue']) and r['targetUtf8Sha256']==(uh(r['target']) if r['target'] is not None else None),'utf8:'+r['id'])
    need(c['technicalBinding']==m and c['technicalBindingSha256']==objhash(m),'context-matrix-hash:'+r['id'])
    need(r['sourceContractRowSha256']==objhash(m),'target-matrix-hash:'+r['id'])
    need(r['targetApplied'] is False and r['applicationAllowed'] is False,'closed-target-gates:'+r['id'])
    if r['target'] is not None:
        need(re.findall(r'<[^>]*>',r['source'])==re.findall(r'<[^>]*>',r['target']) and re.findall(r'\[[^\]]+\]',r['source'])==re.findall(r'\[[^\]]+\]',r['target']),'protected-markup-controls:'+r['id'])
        need(r['source'].count('\n')==r['target'].count('\n'),'linebreak-count:'+r['id'])
        need(('tfol.info' in r['source'])==('tfol.info' in r['target']),'exact-website:'+r['id'])
need(len(semantic)==len(native)==452 and len(nullreceipts)==124,'452-semantic-and-separate-Russian-124-context')
need({r['id'] for r in semantic}=={r['id'] for r in native}==set((PACK/'closure-ids.txt').read_text().splitlines()),'exact452-independent-closure')
need({r['id'] for r in nullreceipts}==set((PACK/'context-only-ids.txt').read_text().splitlines()),'exact124-null-context')
partition=collections.Counter(r['applicationClass'] for r in rows)
need(partition=={'static-wording-candidate':434,'accepted-current-binding':12,'application-held':37,'preserve-exactly':93},'434-12-37-93-partition')
need(sum(r['target'] is not None and r['staticWordingApplicable'] for r in rows)==446,'446-applicable-nonnull')
need(sum(r['target'] is not None and r['applicationClass']=='application-held' for r in rows)==6,'six-held-headings-still-held')
proposal=lines(PACK/'display-proposal.jsonl')
for r,p in zip(rows,proposal):
    expected=r['target'] if r['applicationClass']=='static-wording-candidate' else r['currentValue']
    need(p['id']==r['id'] and p['proposedScalarAfter']==expected and p['changed']==(expected!=r['currentValue']),'scalar-projection:'+r['id'])
    if r['applicationClass']=='preserve-exactly':
        need(r['target'] is None and r['currentValue']==r['source'],'93-exact-protected:'+r['id'])
need(sum(p['changed'] for p in proposal)==434,'434-only-unapplied-scalar-changes')
for g in groups:
    ts={by[i]['target'] for i in g['ids'] if by[i]['target'] is not None}
    need(len(ts)<=1,'full-sibling-coherence:'+g['groupId'])

pinresults=[]
for manifest,relative in [(PACK/'input-pins.json',ROOT),(V1/'input-pins.json',ROOT),(PACK/'v1-preservation-baseline.json',ROOT),(TECH/'output-code-pins.json',ROOT),(PACK/'output-hashes.json',PACK)]:
    d=load(manifest)
    for n,v in d.items():
        if isinstance(v,dict):v=v['sha256']
        path=relative/n
        need(path.exists() and digest(path)==v,'manifest-pin:'+str(path))
    pinresults.append({'manifest':str(manifest.relative_to(ROOT)),'sha256':digest(manifest),'entries':len(d),'status':'passed'})

accepted=load(V1/'reused-receipts.json')
need(len(accepted)==12,'12-explicit-accepted-input72-references')
for a in accepted:
    r=by[a['id']]
    need(r['applicationClass']=='accepted-current-binding' and r['target']==r['currentValue']==a['target'] and r['source']==a['source'],'accepted-current:'+r['id'])
    need(digest(ROOT/a['reference'])==a['referenceSha256'],'accepted-source-target-pin:'+r['id'])
    need(digest(ROOT/'localization/supplemental-ui/20261029-input-case72/ru.acceptance.json')==a['acceptanceSha256'],'accepted-acceptance-pin:'+r['id'])
    for entry in a['receipts']:
        f=ROOT/entry['path'];need(digest(f)==entry['sha256'],'accepted-receipt-pin:'+r['id'])
        found=[x for x in lines(f) if x['id']==r['id']]
        need(len(found)==1 and found[0]==entry['receipt'] and found[0]['targetUtf8Sha256']==r['targetUtf8Sha256'] and found[0]['sourceValueSha256']==r['sourceValueSha256'],'accepted-exact-receipt-row:'+r['id'])

admit=load(ROOT/'localization/source/pause-chapter576-binding-contract-20261029.parent-acceptance.json')
need(set(admit['applicationAllowedIds'])=={r['id'] for r in rows if r['applicationClass']=='static-wording-candidate'},'parent434-role-admission-exact')
need(set(admit['applicationHeldIds'])=={r['id'] for r in rows if r['applicationClass']=='application-held'},'parent37-whole-holds-exact')
need(digest(TECH/'Result.json')==admit['sourceResultSha256'] and digest(TECH/'selector-binding-matrix.jsonl')==admit['matrixSha256'],'parent-source-receipt-pins')

fixtures=lines(PACK/'chooser-decision-fixtures.jsonl')
chooser=load(TECH/'cheat-chooser-contract.json')
pairby={p['property']:p for p in chooser['pairs']}
for f in fixtures:
    p=pairby[f['property']]
    if 'storedValue' in f:
        state=f['storedValue'] is not None
        need(f['initializedState']==state,'source-null-presence-fixture')
    else:
        state=f['inputState'] if f['waitFrames']>0 else (True if p['change']=='set-true' else not f['inputState'])
        need(f['stateAfter']==state and f['waitAfter']==(f['waitFrames'] if f['waitFrames']>0 else 2),'source-callback-state-fixture')
    face=p['faces'][0 if state else 1]
    need(f['selectedIds']==face['ids'] and len(face['ids'])==6,'fixture-all-six-bound-faces')
need(len(fixtures)==40 and len({i for p in chooser['pairs'] for face in p['faces'] for i in face['ids']})==60,'40-decision-fixtures-and60-active-status-ids')
need(len(chooser['unboundControl']['ids'])==18 and chooser['unboundControl']['callbackTarget']==0 and chooser['unboundControl']['callbackMethod']=='' and chooser['unboundControl']['matchingCheatsMenuProperty'] is None,'whole18-unbound-hold')

base=ROOT/'localization/previews/ru-20261029-bio-input-v2-01'
need(digest(base/'build.json')=='e0fddc537966c94e44c0989664b2904951c2add43d5d57aaada12753657e8d6d','actual-candidate-build-pin')
resource=base/'bio-input-resources/sharedassets2.assets'
game_resource=base/'game/The Forest of Love_Data/sharedassets2.assets'
need(digest(resource)=='c7f0c6c05ac81e60ff0f62bf20b508d4daa2e4610e35686091986a13c9ff568a' and digest(game_resource)==digest(resource),'actual-input-sharedassets2-and-game-copy-pins')

write('deterministic-verification.json',{'status':'passed','checks':checks,'checkCount':len(checks),
    'manifestResults':pinresults,'partition':partition,'sourcePrefixSelector':list(prefixes),
    'boundary':'Saved inventory, readback, proposals, receipts, source IL-derived fixture decisions and file hashes. No Unity/asset reinsertion, callback invocation, persistence, network, native rendering or delivery execution.'})
write('coverage.json',{'assigned':576,'groupsRead':164,'newIndependentSemanticFields':452,'newSeparateRussianReadFields':452,'nullContextFields':124,'protectedFields':93,'heldFields':37,'heldNonnullWording':6,'applicableNonnull':446,'glossaryEntriesRead':171,
    'unreadIds':[],'missingSelectors':[],'sampled':False,'priorAuthorReceiptsCopiedAsIndependent':False,
    'readRepresentations':'All164 complete semantic groups, exact full source/target values with every member ID/disposition; separately all nonnull target-only groups; source-context bindings/ancestor state/font/rect metadata projected by group plus exact per-ID deterministic correspondence; named source controller/producer/default/callback bodies and all40 decision fixtures.',
    'sourceContextNotes':['Parallel foreground/glow fields are whole independent display leaves, never joined as a sentence.','Root tooltip14452 has alpha0 test placeholder; other five alpha1 leaves have unlocked-chapters defaults. Empty-list SelectItemLabel returns before tooltip rewrite; all six held.','Awake clones three chapter variants then SetText(Empty); GossipItemLabel fans SetText to three templates, SetStatus reparents variants. All10 stored templates held.','System info columns are overwritten by generated diagnostic output; same producers feed transmitted payload. No report was sent.','UnlockMovies is source-inactive with null Button target/empty method and no chooser property; all18 held.','The source ScaleFactor Button references OnClickFullscreenStretch; this is preserved source data, not repaired or reinterpreted by translation.','114 TitleWKerning/drop-cap memberships have no exact overlap under the owning overlap matrix; no Pause header or ornamental title enters this selector.'],
    'layout':'All required metadata read;30pt wrapping chapter header,14pt nonwrapping chapter warning,16pt report instructions and20pt labels remain runtime/font/fit risks. Numeric metadata is not a native fit pass.'})
write('review-closure.json',{'targetSha256':digest(PACK/'ru.prepared.jsonl'),'sourceSha256':digest(SOURCE/'pause-chapter-576.source.jsonl'),
    'closurePath':str((PACK/'closure-ids.txt').relative_to(ROOT)),'closureSha256':digest(PACK/'closure-ids.txt'),'closureCount':452,
    'contextPath':str((PACK/'context-only-ids.txt').relative_to(ROOT)),'contextSha256':digest(PACK/'context-only-ids.txt'),'contextCount':124,
    'reviewedGroupSha256':digest(PACK/'complete-semantic-groups.jsonl'),'proposedDeltaCount':0,'proposedDeltaSha256':digest(OUT/'proposed-delta-ids.txt'),
    'algorithm':'Fresh independent whole final576 read, not the author delta. No correction is proposed. A later change invalidates its exact dependencies under the pinned universal protocol.'})

write('source-application-holds.json',{'heldIds':[r['id'] for r in rows if r['applicationClass']=='application-held'],
    'protectedIds':[r['id'] for r in rows if r['applicationClass']=='preserve-exactly'],
    'groups':[{'scope':'UnlockMovies18','uncertainty':'Inactive/unbound; six reviewed headings do not establish runtime reachability or action binding.','nextPermittedAction':'Parent preserves all18; any future application needs an exact accepted source contract.'},
              {'scope':'chapter templates10','uncertainty':'Stored seeds are clone-cleared and overwritten by existing producers.','nextPermittedAction':'Preserve defaults; use accepted producer wording through its owning workflow.'},
              {'scope':'mixed tooltip6','uncertainty':'Root alpha0 placeholder versus five visible defaults; empty-list selection returns before rewrite.','nextPermittedAction':'Preserve all six until an explicit source/default presentation decision.'},
              {'scope':'report diagnostic columns2','uncertainty':'Generated presentation and submitted diagnostics share producers.','nextPermittedAction':'Preserve defaults/payload; any future localization needs a separate display contract.'},
              {'scope':'dormant debug1','uncertainty':'No managed field uses in pinned source evidence; external/native mutation not proven absent.','nextPermittedAction':'Preserve stored value and current hold.'}],
    'targetApplied':False,'sourceGateAccepted':False,'wholeGameAccepted':False})

catalog=load(PACK/'mandatory-regressions.json')
reg=[]
for r in catalog['retainedV1Catalog']['rows']+catalog['revision02']:
    status='passed-independent-static-semantic'
    note='Read against whole final576 context and exact final target hashes.'
    if r['id']=='layout-font-runtime':status='not-run';note='Metadata only; actual Cyrillic native fit remains unverified.'
    elif r['id']=='boolean-not-word-match':note='Superseded v1 null assertion: final60 active cheat statuses have reviewed targets; all18 UnlockMovies remain held. Exact source-null/key and callback semantics preserved.'
    elif r['id']=='dynamic-joins-and-activation':note='Static consumer/default context read; source/applicability holds preserved. Actual activation and runtime not run.'
    elif r['id']=='independence-and-runtime':note='This is a fresh independently identified whole final review; all runtime/global gates remain unchanged.'
    reg.append({'id':r['id'],'originalPredicate':r['predicate'],'status':status,'assessment':note})
write('mandatory-regressions.json',reg)

# Pin required references and supplementary bodies used in this review.
pins=load(OUT/'input-pins.json')
extra=[ROOT/'localization/source/pause-chapter576-binding-contract-20261029.parent-acceptance.json',
       ROOT/'localization/source/notebook-20261026/ChapterSelectUI.il',
       ROOT/'localization/source/shared-source-completion-20261028/admission-v1/serialized-inventory.jsonl',
       base/'build.json',resource,game_resource,V1/'process-binding.json',V1/'reused-receipts.json']
proc=load(V1/'process-binding.json')
extra += [Path(k) for k in proc['references']]
for p in extra:pins[str(p)]=digest(p)
for path,expected in pins.items():need(digest(path)==expected,'final-input-pin:'+path)
write('input-pins.json',pins)
write('process-binding.json',{'stage':'editorial: independent whole final576 review','game':'The Forest of Love','version':'0.45','sourceLocale':'en','locale':'ru','type':'standard',
    'model':'gpt-6.1-sol','reasoning':'high','provider':'openai','sessionId':SESSION,'inheritedHistory':False,'nestedJobs':0,
    'existingProjectBinding':'README.md fixed stage/command table; no root documentation write',
    'references':{k:digest(k) for k in proc['references']},'parentProcessBindingSha256':digest(V1/'process-binding.json'),
    'ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,'targetApplied':False})
write('preservation-proof.json',{'status':'passed','pinnedInputsUnchanged':len(pins),
    'all40V1FilesUnchanged':True,'allOriginalRevision02FilesUnchanged':True,
    'writesOnly':str(OUT),'targetApplied':False,'gitMutation':False,'gameGUIImages':False,'networkReportSending':False,
    'sourceInventoryModified':False,'glossaryModified':False,'technicalHelperModified':False,'nestedJobs':0})
write('Result.json',{'status':'complete-clean-independent-whole-final576-review','game':'The Forest of Love','version':'0.45','locale':'ru',
    'assigned':576,'groupsRead':164,'semanticReviewed':452,'separateRussianRead':452,'nullContextReviewed':124,
    'staticCandidates':434,'acceptedCurrentRetained':12,'applicableNonnull':446,'heldNonnullReviewed':6,'heldFields':37,'protectedFields':93,
    'objectiveWordingFindings':0,'proposedDelta':0,'deterministicVerification':'passed','selectorCompleteness':'passed','mandatoryStaticRegressions':'passed',
    'independentReview':'clean','targetSha256':digest(PACK/'ru.prepared.jsonl'),
    'targetApplied':False,'actualGameRuntime':'not-run','ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,
    'model':'gpt-6.1-sol','reasoning':'high','provider':'openai','reviewer':SESSION,
    'nextPermittedAction':'Parent adjudicates/adopts this review and performs any separately authorized application through its sole technical lane; preserve all37 holds and93 protected fields. Reviewer stops here.'})
(OUT/'HANDOFF.md').write_text('''The complete final Pause/Chapter576 packet is independently clean on the pinned target SHA e81cd112f36264b064b215edc36b22108efb10836b31391d3280ab678af6c2de. This fresh Sol/high/OpenAI reviewer read all164 semantic groups and all576 IDs; all452 nonnull fields received a source-to-target fidelity read and a separate Russian read. The124 null fields have context-preservation receipts, not invented translation passes. The complete171-entry approved EN/RU glossary was read once.

No objective wording findings or replacements are proposed. Exact repeated full fields were factored with all physical IDs, topology and dispositions reconciled. The12 prior input72 targets and their actual acceptance/review receipts match exactly. The independent checks reproduce the exact common-inventory prefix selector, all source/current/target/context/matrix bindings, the452/124 closure split, all40 source-derived chooser fixtures, paragraph/control/markup/website preservation and434 proposed scalar changes. Deterministic success is separate from the actual linguistic readings.

The434 static candidates and12 current accepted fields give446 applicable nonnull fields. The six additional UnlockMovies headings are literal-wording clean but remain in the whole18-member application hold. All37 held fields and93 protected values remain exact in the proposal. Ten clone-cleared chapter templates, six mixed tooltip defaults, two generated diagnostic columns and one dormant debug value remain held. Source initialization tests exact key presence/non-null values; textual false is still present. Three one-shot cheats and two toggles retain their actual source decisions, keys and callbacks. No source behavior is repaired or inferred from label nouns.

Native rendering, Cyrillic font fit, actual chooser activation, callbacks, persistence, submission, asset insertion, packaging and game runtime were not run. The30pt title,14pt warning,16pt instructions and20pt labels retain layout risks; static metadata cannot pass visual fit. All original inputs, v1/revision02 evidence, sources, targets, glossaries, helpers, root documents, Git and index remain unchanged. Writes are limited to this independent-review-01 directory.

Parent owns acceptance/application/integration and any later exact dependency delta. targetApplied=false; actualGameRuntime=not-run; ordinaryTranslationEntryAllowed=false; sourceGateAccepted=false; wholeGameAccepted=false. The finite reviewer assignment ends here. Usage is recorded separately at a measured session-journal cutoff; the reporting tail is unmeasured.
''')
print(json.dumps({'status':'written-and-verified','semantic':len(semantic),'russian':len(native),'nullContext':len(nullreceipts),'groups':len(groups),'findings':0,'checks':len(checks)},separators=(',',':')))
