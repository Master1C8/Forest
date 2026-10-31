"""Finite actual-artifact checks; Python IL evaluation is not CLR/Unity execution."""
import argparse
import hashlib
import json
from pathlib import Path
import sys


def sha(data):
    return hashlib.sha256(data).hexdigest()


def need(ok, reason):
    if not ok:
        raise ValueError(reason)


def evaluate(method, args, fields=None, methods=None, start=0):
    """Read the delivered pure helper IL. Unknown operations fail closed."""
    fields = fields or {}
    code = []
    for line in method['body'].splitlines()[1:]:
        offset, rest = line.split(':', 1)
        opcode, _, operand = rest.partition(' ')
        code.append((opcode, operand))
    stack, pc, steps = [], start, 0
    locals_ = {}
    args = list(args)
    while True:
        need(steps < 500, 'bounded-pure-il'); steps += 1
        op, value = code[pc]; pc += 1
        if op.startswith('ldarg.'):
            stack.append(args[int(op[-1])])
        elif op == 'starg':
            args[int(value.split(':')[1])] = stack.pop()
        elif op.startswith('ldc.i4.'):
            stack.append(-1 if op.endswith('m1') else int(op[-1]))
        elif op == 'ldc.i4':
            stack.append(int(value))
        elif op == 'ldstr':
            stack.append(json.loads(value.removeprefix('str:')))
        elif op == 'ldfld':
            owner = stack.pop(); stack.append(owner[value.split('::')[-1]])
        elif op == 'stfld':
            new_value, owner = stack.pop(), stack.pop(); owner[value.split('::')[-1]] = new_value
        elif op == 'ldloc':
            stack.append(locals_[int(value.split(':')[1])])
        elif op == 'stloc':
            locals_[int(value.split(':')[1])] = stack.pop()
        elif op == 'ldsfld':
            stack.append(fields[value.removeprefix('field:')])
        elif op == 'sub':
            b, a = stack.pop(), stack.pop(); stack.append(a-b)
        elif op in ('call','callvirt'):
            if value == 'method:System.Boolean System.String::op_Equality(System.String,System.String)':
                b, a = stack.pop(), stack.pop(); stack.append(a == b)
            elif value == 'method:System.String TMPro.TMP_Text::get_text()':
                stack.append(stack.pop()['text'])
            elif value == 'method:System.Void TMPro.TMP_Text::set_text(System.String)':
                text, label = stack.pop(), stack.pop(); label['text'] = text
            elif methods is not None and value.removeprefix('method:') in methods:
                name = value.removeprefix('method:')
                need('VNRevivalSpecialKeyDisplay::Caption' in name or 'VNRevivalSetDisplayDefault' in name,'only-declared-pure-helper-calls')
                b, a = stack.pop(), stack.pop()
                got = evaluate(methods[name],[a,b],methods=methods)
                if not name.startswith('System.Void '):
                    stack.append(got)
            else:
                raise ValueError('unsupported-pure-call:'+value)
        elif op in ('brfalse', 'brtrue'):
            flag = stack.pop()
            if bool(flag) == (op == 'brtrue'):
                pc = int(value[1:])
        elif op == 'bne.un':
            b, a = stack.pop(), stack.pop()
            if a != b:
                pc = int(value[1:])
        elif op == 'switch':
            choices = [int(x[1:]) for x in value.split(',')]
            key = stack.pop()
            if 0 <= key < len(choices):
                pc = choices[key]
        elif op == 'nop':
            pass
        elif op == 'ret':
            need(len(stack) == (0 if method['method'].startswith('System.Void ') else 1), 'exact-helper-return-stack')
            return stack.pop() if stack else None
        else:
            raise ValueError('unsupported-pure-il:'+op)


def run(root, profile, candidate, inspection, context, output):
    root = root.resolve()
    def load(path):
        return json.loads(path.read_bytes())
    def pin(path):
        return dict(path=str(path.relative_to(root)), sha256=sha(path.read_bytes()))
    profile, candidate = profile.resolve(), candidate.resolve()
    inspection, context, output = inspection.resolve(), context.resolve(), output.resolve()
    spec, delivered, source = load(profile), load(candidate/'manifest.json'), load(context)
    request = load(candidate/'evidence/deferred-display-request.json')
    actual = load(inspection)
    need(actual['sha256'] == delivered['outputs']['Managed/Assembly-CSharp.dll']['sha256'] == sha((candidate/'Managed/Assembly-CSharp.dll').read_bytes()), 'actual-inspection-assembly')
    methods = {m['method']:m for m in actual['methods']}
    literals = {m['method']:m for m in actual['methods'] if 'VNRevivalDeferredLiteralDisplay::Literal_' in m['method']}
    need(len(literals) == len(request['rows']) == 28, 'exact-28-injected-methods')
    realized = []
    ordered_rows = sorted(request['rows'],key=lambda r:(0 if 'QuestLogDetailsPane::' in r['sourceContext']['method'] else 1,r['sourceContext']['offset']))
    for ordinal,row in enumerate(ordered_rows):
        expected_adapter = 'System.String VNRevivalDeferredLiteralDisplay::Literal_'+str(ordinal).zfill(2)+'(System.String)'
        method = methods[row['sourceContext']['method']]
        hits = []
        for i, ins in enumerate(method['instructions']):
            if ins['opcode'] == 'call' and ins['operand'] == expected_adapter:
                previous = method['instructions'][i-1]
                need(previous['opcode'] == 'ldstr', 'immediate-source-display-load')
                target = evaluate(literals[ins['operand']], [previous['operand']])
                if previous['operand'] == row['source'] and target == row['target']:
                    hits.append(dict(instructionIndex=i, adapter=ins['operand']))
        need(len(hits) == 1, 'exact-one-selector-bound-source-target-adapter:'+row['id'])
        realized.append(dict(id=row['id'], source=row['source'], target=row['target'], calls=hits))
    caption = methods['System.String VNRevivalSpecialKeyDisplay::Caption(System.String,System.Int32)']
    cases = []
    mapping = {(r['source'],r['keycode']):r['target'] for r in request['captions']}
    names = [None, '', 'SHIFT', 'ENTER', 'UMSCHALT', 'EINGABE', 'ENTERING', 'SHIFT SHIFT', '«', '+', ' ', 'ABC\n', '\u200b', 'Ä', '日本語']
    for name in names:
        for code in [0,8,13,32,43,302,303,304]:
            got = evaluate(caption, [name,code])
            need(got == mapping.get((name,code),name), 'caption-exact-key-and-source-guard')
            cases.append(dict(source=name,keycode=code,output=got))
    helper = methods['System.Boolean TheForestOfLove.QuestLog::VNRevivalPhotoCounterSlot(System.Int32,System.Boolean)']
    flag_names = ['System.Boolean TheForestOfLove.QuestLog::VNRevivalPhotoHistory'+str(i) for i in range(3)]
    photo_count = 0
    for mask in range(8):
        flags = {name:bool(mask & (1<<i)) for i,name in enumerate(flag_names)}
        for completed in [False, True]:
            for slot in range(-1,5):
                index = slot-int(completed)
                expected = flags[flag_names[index]] if 0 <= index < 3 else False
                need(evaluate(helper,[slot,completed],flags) == expected, 'actual-photo-slot-completion-shift')
                photo_count += 1
    keyboard = methods['System.Void viperOSK.OSK_Keyboard_TFOL::Generate()']['instructions']
    hook, = [i for i,x in enumerate(keyboard) if x['operand'] == 'System.Void VNRevivalSpecialKeyDisplay::Apply(viperOSK.OSK_Key_TFOL,viperOSK.OSK_SpecialKeys)']
    need(keyboard[hook-3]['operand'] == 'System.Void viperOSK.OSK_Key::Assign(UnityEngine.KeyCode,viperOSK.OSK_KEY_TYPES,System.String)', 'hook-after-original-Assign')
    for name,digest in source['pins'].items():
        need(sha((root/name).read_bytes()) == digest, 'consumer-context-pin:'+name)
    engine = root/Path(source['engineManifest']['path']).parent
    sys.path[:0] = [str(engine/'vendor'),str(engine/'engine')]
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    import extract_assets as ex
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(engine/'source/Managed'))
    inventory = [json.loads(x) for x in (root/source['sourceInventory']).read_text().splitlines()]
    domain = {r['id'].split('/')[0] for r in inventory if r.get('className') == 'viperOSK.OSK_Keyboard_TFOL'}
    selected = {x.split('/')[0] for x in request['oskSelectors']}
    need(domain == selected and len(domain) == 4, 'complete-actual-keyboard-domain')
    facts = [r for r in load(root/source['facts']) if 'queue' in r]
    native_rows = []
    for file in sorted({f['file'] for f in facts}):
        env = UnityPy.load(str(candidate/file));env.path = str(engine/'source')
        original = UnityPy.load(str(root/source['sourceResources'][file]['path']));original.path = str(engine/'source')
        objects = env.file.objects
        for fact in [r for r in facts if r['file'] == file]:
            tree = ex.read_tree(objects[fact['pathId']],generator)
            need(objects[fact['pathId']].get_raw_data() == next(a for a in original.assets if Path(a.name).name == file).objects[fact['pathId']].get_raw_data(), 'functional-keyboard-object-byte-exact')
            for key in fact['queue']:
                if key['key'] not in [13,303,304]:
                    continue
                special = next(s for s in tree['specialKeys'] if s['keycode'] == key['key'])
                target = evaluate(caption,[special['name'],special['keycode']])
                initial = ex.read_tree(objects[key['labelPathId']],generator)['m_text']
                need(evaluate(caption,[initial,key['key']]) == target, 'Awake-caption-input-accepted')
                native_rows.append(dict(keyboard=file+':'+str(fact['pathId']),keycode=key['key'],sourceFunctionalName=special['name'],display=target,initialCaption=initial,captionId=file+':'+str(key['labelPathId'])+'/m_text',resourceUnchanged=True))
    need(len(native_rows) == len(request['oskSelectors']) == 6,'six-actual-native-caption-bindings')
    awake = methods['System.Void viperOSK.OSK_Key_TFOL::Awake()']
    start = next(i for i,x in enumerate(awake['instructions']) if x['offset'] == 0x003e)
    need([x['opcode'] for x in awake['instructions'][start:start+4]] == ['ldarg.0','ldarg.0','ldfld','callvirt'],'exact-original-Awake-cache-tail')
    apply = methods['System.Void VNRevivalSpecialKeyDisplay::Apply(viperOSK.OSK_Key_TFOL,viperOSK.OSK_SpecialKeys)']
    lifecycle = []
    for row in native_rows:
        for order in ['Awake->Generate','Generate->Awake']:
            key = dict(key=row['keycode'],keyName=dict(text=row['initialCaption']),defaultLabelText=None)
            key_spec = dict(name=row['sourceFunctionalName'],keycode=row['keycode'])
            def generation():
                # Original Assign body is unchanged and sets its exact explicit name.
                key['keyName']['text'] = key_spec['name']
                evaluate(apply,[key,key_spec],methods=methods)
            if order == 'Awake->Generate':
                evaluate(awake,[key],methods=methods,start=start);generation()
            else:
                generation();evaluate(awake,[key],methods=methods,start=start)
            need(key['keyName']['text'] == key['defaultLabelText'] == row['display'],'delivered-cache-caption-parity')
            lifecycle.append(dict(captionId=row['captionId'],order=order,caption=key['keyName']['text'],cache=key['defaultLabelText']))

    base_path = root/delivered['input']['path']
    base = load(base_path)
    unchanged = []
    for name,entry in base['outputs'].items():
        if name == 'Managed/Assembly-CSharp.dll':
            continue
        need((candidate/name).read_bytes() == (base_path.parent/name).read_bytes(), 'retained-actual-resource:'+name)
        unchanged.append(name)
    report = dict(passed=True,locale=spec['locale'],culture=spec['culture'],candidate=pin(candidate/'manifest.json'),inspection=pin(inspection),profile=pin(profile),consumerInputs=pin(context),
        injectedLiteralAdapters=realized,captionCases=cases,photoSlotCases=photo_count,nativeCaptionBindings=native_rows,lifecycleCases=lifecycle,
        originalAssignArgumentsRetained=True,keyboardObjectsByteExact=4,unchangedPriorOutputs=unchanged,
        sourceCompanionsUnchanged=delivered['sourceCompanions']==base['sourceCompanions'],
        parserBoundary='Actual saved resource and delivered Cecil instruction readback. Python interprets only the pure injected helpers; no game/CLR/Unity/native rendering or input callbacks executed.',
        runtime='not-run',native='not-run',package='not-run',ready=False)
    need(not output.exists(),'fresh-consumer-check')
    output.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    return dict(passed=True,injectedAdapters=28,captionCases=len(cases),photoSlotCases=photo_count,nativeCaptionBindings=6,lifecycleCases=len(lifecycle),unchangedPriorOutputs=len(unchanged),ready=False)


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    for name in ['root','profile','candidate','inspection','context','output']:
        p.add_argument('--'+name,type=Path,required=True)
    a=p.parse_args();print(json.dumps(run(a.root,a.profile,a.candidate,a.inspection,a.context,a.output)))
