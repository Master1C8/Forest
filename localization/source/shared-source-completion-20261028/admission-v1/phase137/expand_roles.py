"""Finite authored phase137 contracts expanded over the unchanged original index.

Only exact typed argument contracts and the read report bodies are selected.
No target wording, lexical role guess, model call, or source extraction.
"""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE.parent
ROOT = OUT.parents[3]
INDEX = ROOT / 'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl'


def load(p):
    return json.loads(p.read_text())


def rows(p):
    return [json.loads(s) for s in p.read_text().splitlines()]


def vh(value):
    return hashlib.sha256(json.dumps(value,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()).hexdigest()


def sid(r):
    return f"il:Assembly-CSharp.dll/{r['method']}/IL_{r['offset']:04x}"


# Every string parameter of these exact overloads has the SAME named contract.
# The argument window admits only independent loads/nullable initialization,
# and stops at any other processing, call, branch, store, return or stack edit.
LOAD_OPS = {'ldnull','ldstr','ldfld','ldsfld','ldflda','ldsflda','initobj'}


def first_typed_call(r):
    for i in r['after']:
        op = i['opcode']
        if op in ('call','callvirt','newobj'):
            return i
        if not (op in LOAD_OPS or op.startswith(('ldarg','ldloc','ldc.'))):
            return None
    return None


def contracts():
    result = []
    def add(target,role,reason,evidence,immediate=False):
        result.append(dict(target=target,role=role,reason=reason,evidence=evidence,immediate=immediate))
    lookup_evidence=['story-dialogue.il','movie-dialogue.il','../phase134/conversation-settings.il','../phase134/story-playdialogue.il']
    for owner in ('GeneralStoryUIController','MovieDialogueManager'):
        for suffix in ('System.String,System.String,System.String','System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI'):
            add(f'System.Void TheForestOfLove.{owner}::StartDialogue({suffix})','preserve-dialogue-selection-identity',
                'All three string arguments flow unchanged to ConversationSettings.conversationName/actorName/dialogueArcName, then the proved DB/tag/arc selectors. Preserve these lookup inputs; this does not exclude the selected dialogue or displayed actor alias.',lookup_evidence)
    for member,signature in [('SetFloat','System.Single'),('SetBool','System.Boolean'),('SetInteger','System.Int32'),('SetTrigger',None)]:
        target=f'System.Void UnityEngine.Animator::{member}(System.String'+(','+signature if signature else '')+')'
        add(target,'preserve-animation-parameter-identity','Exact Animator parameter-name argument; other argument is the original typed numeric/boolean value. Preserve animator resource binding, not a prose exclusion for the caller.',['original-index:exact-typed-Animator-argument'])
    for member,args in [('PlaySoundAndForget','System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>'),('AddSoundGroupToDuckList','System.String,System.Single,System.Single,System.Single,System.Boolean'),('StopAllOfSound','System.String'),('PauseSoundGroup','System.String'),('UnpauseSoundGroup','System.String')]:
        ret='System.Boolean' if member=='PlaySoundAndForget' else 'System.Void'
        add(f'{ret} DarkTonic.MasterAudio.MasterAudio::{member}({args})','preserve-audio-resource-identity',
            'Exact typed sound-group/variation resource-name argument. Both string parameters of PlaySoundAndForget are sound lookup identities; source captions and user-facing sound descriptions are separate.', ['audio-contract.il','audio-lookup.il','audio-variation-selection.il'])
    add('DarkTonic.MasterAudio.PlaylistController DarkTonic.MasterAudio.PlaylistController::InstanceByName(System.String,System.Boolean)','preserve-audio-resource-identity','Exact playlist-controller instance lookup name; boolean retains original creation policy.',['playlist-contract.il'])
    add('System.Boolean DarkTonic.MasterAudio.PlaylistController::IsSongPlaying(System.String)','preserve-audio-resource-identity','Exact song resource identity used in playback-state query.',['playlist-contract.il'])
    add('System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)','preserve-scene-identity','String -> current.LoadSceneSingle -> InitiateSceneLoad; final LoadScene override forwards unchanged to Unity SceneManager.LoadScene. Preserve scene selection key.',['scene-contract.il','scene-base.il'],True)
    add('System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::InScene(System.String)','preserve-scene-identity','Complete body compares argument to CurrentSceneName using ordinal source equality; preserve scene identity.',['scene-contract.il'],True)
    for owner,method,args in [('GlitchRascalPart1Story','SetAnimatorTrigger','UnityEngine.Animator,System.Collections.Generic.List`1<System.String>,System.String'),('OliverBuckyOralMovie/Internal_AnimationInputHelper','SetAnimatorTriggers','System.String'),('PlantMovie/Internal_AnimationInputHelper','SetAnimatorTriggers','System.String'),('SquirrelAnalMovie/Internal_AnimationInputHelper','SetAnimatorTriggers','System.String')]:
        evidence={'GlitchRascalPart1Story':'animation-key.il','OliverBuckyOralMovie/Internal_AnimationInputHelper':'animation-wrapper.il','PlantMovie/Internal_AnimationInputHelper':'plant-animation-wrapper.il','SquirrelAnalMovie/Internal_AnimationInputHelper':'squirrel-animation-wrapper.il'}[owner]
        add(f'System.Void TheForestOfLove.{owner}::{method}({args})','preserve-animation-parameter-identity','Complete wrapper sends its string unchanged to exact Animator.SetTrigger calls; reset/branch guards retained. No caller-method or other-string exclusion.',[evidence],True)
    add('System.Void System.Exception::.ctor(System.String)','preserve-diagnostic','Immediate actual Exception message constructor operand; not the fictional InventoryInfoTicker trace. Preserve program diagnostic.',['original-index:immediate-Exception-message'],True)
    for level in ('LogWarning','LogError'):
        add(f'System.Void SickDev.DevConsole.DevConsole::{level}(System.String)','preserve-console-diagnostic','Immediate explicit developer-console diagnostic message; command input/metadata and gameplay display text are separate.',['original-index:typed-developer-console-diagnostic'],True)
    for member in ('BroadcastMessage',):
        add(f'System.Void UnityEngine.Component::{member}(System.String)','preserve-method-dispatch-identity','Exact Unity message method-name dispatch argument, not player prose.',['original-index:typed-Unity-method-dispatch'],True)
    return result


def report_contract(r):
    t=r['type']; m=r['method'].split('::',1)[1].split('(',1)[0]; o=r['offset']
    evidence=['report.il'] if t=='TheForestOfLove.BugReportApiHelper' else ['report-test.il']
    def d(role,reason):return dict(role=role,reason=reason,evidence=evidence,contract='exact-read-report-body:'+m)
    if t not in ('TheForestOfLove.BugReportApiHelper','BugReportTest'):return None
    if m in ('GenerateApplicationInfo','AppendSystemSpecs'):
        fmt={'GenerateApplicationInfo':{0x0f,0x63},'AppendSystemSpecs':{5}}[m]
        return d('preserve-report-format' if o in fmt else 'preserve-report-diagnostic-caption',
            'Read body assembles version/resolution format or a system-spec label through AppendSystemSpecIfSupported, consumed in the diagnostic report content uploaded by SubmitBugReport/SendTestBugReport. Not a game UI caption; no global no-display claim for another caller.')
    if m=='GenerateSystemSpecs':
        if o in (0x1f,0x82):return d('preserve-report-filter-operand','Exact platform suffix replacement or OS regex input; preserve report-data filtering syntax.')
        return d('preserve-report-diagnostic-caption','Actual label argument -> AppendSystemSpecIfSupported -> generated report content -> Codecks upload. Preserve technical support captions; unrelated UI wording stays in scope.')
    if m=='AppendSystemSpecIfSupported':
        if (t=='BugReportTest' and o==0x0b) or (t!='BugReportTest' and o==0x15):
            return d('preserve-report-comparison-operand','Exact n/a comparison selects the original supported-value branch; not a translatable display source.')
        return d('preserve-report-diagnostic-template','Exact returned label/value diagnostic formatting, including [Unknown] and LF, consumed in report content. Preserve placeholders and delimiters.')
    if m in ('GenerateRecentStoryEvents','GenerateRecentMessagesCritical','GenerateRecentMessagesNoncritical'):
        return d('preserve-report-format','Exact LF separator between history/queue messages in the diagnostic report; not English wording.')
    if m=='OnApplicationMessageReceived':
        return d('preserve-report-filter-operand' if o in (0x13,0x7e) else 'preserve-report-format','Read body joins log and stacktrace, removes backticks, truncates under original caps, queues LF-terminated diagnostics. Exact formatting/filtering argument only.')
    if m=='LoadCodecksApiSettingsForLabel':
        return d('preserve-resource-identity' if o==6 else 'preserve-diagnostic','Codecks/ is the exact Resources.LoadAll path; the other exact operands join the requested settings label into Debug.LogError. Settings identity and diagnostic messages remain separate.')
    if m in ('SubmitBugReport','SendTestBugReport'):
        if t=='BugReportTest' and o==0:return d('preserve-external-service-identity','Embedded test report credential identity; value omitted from new evidence/prose, original source hash retained. Never emit or use it.')
        if (t=='BugReportTest' and o in (6,0x57,0x6a,0x77,0x7c)) or (t!='BugReportTest' and o in (0x25,0xd3,0xed,0x102,0x107)):
            return d('preserve-report-protocol-identity','Actual endpoint prefix, severity enum spelling, fileName cross-reference, HTTP header or MIME type in the report request. Preserve transport/schema identity.')
        return d('preserve-report-diagnostic-caption','Exact fallback test report content or report section heading stored in CodecksBugReport.content before serialization/upload, not rendered game wording.')
    if m=='UploadFiles':
        diag=(0x5a,) if t=='BugReportTest' else (0x16,0x76)
        return d('preserve-diagnostic' if o in diag else 'preserve-report-protocol-identity','Complete body separates Debug/Exception wording from screenshot file cross-reference, multipart field names, MIME switch and content-type header. Only the selected exact operand is classified.')
    if m=='CheckAndHandleErrors':return d('preserve-diagnostic','Actual response-state branch assembles this exact message/format into Debug.LogError/LogWarning; original return/error guards remain. No generic exception/prose lexical rule.')
    return None


def expanded():
    baseline=rows(HERE/'baseline/managed-literal-inventory.jsonl')
    pending={r['id'] for r in baseline if r['role']=='needs-consumer-decision'}
    assert len(pending)==2400
    index=rows(INDEX)
    adventure=rows(OUT.parent/'adventure-source/roster.jsonl')
    assert len(adventure)==44 and all(r['id'] in pending for r in adventure)
    selected={r['id']:dict(id=r['id'],method=r['method'],offset=r['offset'],sourceValueSha256=r['sourceValueSha256'],role=r['role'],reason=r['reason'],contract='parent-adventure-proof',evidence=['../../adventure-source/verification.json']) for r in adventure}
    rules=contracts()
    for r in index:
        id=sid(r)
        if id not in pending or id in selected:continue
        call=first_typed_call(r)
        match=[g for g in rules if call and call['operand']==g['target'] and (not g['immediate'] or call==r['after'][0])]
        assert len(match)<=1
        if match:
            rule=match[0]
            proof=dict(role=rule['role'],reason=rule['reason'],evidence=rule['evidence'],contract='typed-argument:'+rule['target'],consumer=call,
                       argumentWindow=[i for i in r['after'] if i['index']<=call['index']])
        else:
            proof=report_contract(r)
        if proof:
            selected[id]=dict(id=id,method=r['method'],offset=r['offset'],sourceValueSha256=vh(r['value']),**proof)
    result=[selected[sid(r)] for r in index if sid(r) in selected]
    assert len(result)==len(selected)
    return dict(schemaVersion=1,phase='0137-work',scope='material-subset-of-original8576-compiled-occurrences',sourceCount=8576,baselineUnresolved=2400,
                adventureOperands=44,contracts=rules,decisions=result,remaining=2400-len(result),
                boundary='Authored exact source-role judgments; independent semantic review, source application/renderer/reachability and full source acceptance remain pending. No target edits or inferred exclusions by spelling.')


if __name__=='__main__':
    import argparse
    p=argparse.ArgumentParser();p.add_argument('--write',action='store_true');a=p.parse_args()
    data=json.dumps(expanded(),ensure_ascii=False,indent=2)+'\n';target=HERE/'compiled-role-decisions.json'
    if a.write:
        with target.open('x') as s:s.write(data)
    else:assert target.read_text()==data,'compiled-role-expansion-mismatch'
    from collections import Counter
    result=json.loads(data)
    print(json.dumps(dict(decisions=len(result['decisions']),remaining=result['remaining'],roles=Counter(r['role'] for r in result['decisions']))))
