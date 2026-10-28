"""Bind the six static Adventure records and their exact display/key operands.

The coordinator authored the seven field roles after reading the complete
factory, property, page, overlay and notification dispatch bodies. Expansion
and preservation checks are deterministic; no target wording is generated.
"""
import argparse
import hashlib
import json
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[4]
HERE = Path(__file__).resolve().parent
INDEX = ROOT / 'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl'
FACTORY = 'System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::RegenerateAdventuresPleaseMoveThisDataToDbSoItsNotStaticBruh()'
DISPLAY = ('Title', 'NotificationTitle', 'Body')
PROTECTED = ('GatewayName', 'PlayerSpawnAreaDbName', 'Savekey', 'CompletionTrigger')
ORDER = DISPLAY + PROTECTED
ASSEMBLY_SHA = '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def value_hash(value):
    return hashlib.sha256(json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def operand_field(literal):
    next_instruction = literal['after'][0]
    assert next_instruction['index'] == literal['index'] + 1
    assert next_instruction['offset'] == literal['offset'] + 5
    if next_instruction['opcode'] == 'stfld':
        assert next_instruction['operand'] == 'System.String TheForestOfLove.Narrative.Adventure::Savekey'
        return 'Savekey'
    assert next_instruction['opcode'] == 'callvirt'
    prefix = 'System.Void TheForestOfLove.Narrative.Adventure::set_'
    value = next_instruction['operand']
    assert value.startswith(prefix) and value.endswith('(System.String)')
    field = value[len(prefix):-len('(System.String)')]
    assert field in ORDER
    return field


def validate_preserved(expected, delivered):
    if delivered['id'] != expected['id']:
        raise ValueError('adventure-selector-changed')
    if delivered['source'] != expected['source']:
        raise ValueError('protected-adventure-identity-changed')
    if value_hash(delivered['source']) != delivered['sourceValueSha256']:
        raise ValueError('adventure-fingerprint-mismatch')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    index_manifest = json.loads((INDEX.parent / 'manifest.json').read_text())
    assert index_manifest['sourceSha256'] == ASSEMBLY_SHA
    assert sha(INDEX) == index_manifest['files']['literals.jsonl']['sha256']
    literals = [json.loads(line) for line in INDEX.read_text().splitlines()]
    factory_literals = [r for r in literals if r['method'] == FACTORY]
    assert len(factory_literals) == 42
    roster = []
    for number, literal in enumerate(factory_literals):
        field = operand_field(literal)
        assert field == ORDER[number % 7]
        row = dict(id=f"il:Assembly-CSharp.dll/{literal['method']}/IL_{literal['offset']:04x}",
            method=literal['method'], offset=literal['offset'], source=literal['value'],
            sourceValueSha256=value_hash(literal['value']), adventureType=100 * (number // 7 + 1), field=field,
            role='display-source' if field in DISPLAY else 'preserve-adventure-identity',
            consumer=literal['after'][0],
            reason=('Factory property -> unchanged backing field/getter -> exact page/overlay/queued notification TMP consumer.'
                    if field in DISPLAY else 'Gateway/spawn-area/save/trigger identity; preserve lookup and persistence behavior.'))
        roster.append(row)
    overlay_methods = {
        'System.Void TheForestOfLove.InstancedStoryOverlayUI::OnInstancedStoryAbandoned(TheForestOfLove.Narrative.Adventure)',
        'System.Void TheForestOfLove.InstancedStoryOverlayUI::OnInstancedStoryCompleted(TheForestOfLove.Narrative.Adventure)',
    }
    overlays = [r for r in literals if r['method'] in overlay_methods]
    assert len(overlays) == 2
    for literal in overlays:
        assert literal['offset'] == 80
        assert literal['value'].startswith('<size=10>Adventure ') and literal['value'].endswith('</size>\n')
        roster.append(dict(id=f"il:Assembly-CSharp.dll/{literal['method']}/IL_{literal['offset']:04x}",
            method=literal['method'], offset=literal['offset'], source=literal['value'],
            sourceValueSha256=value_hash(literal['value']), field='overlay-status-prefix', role='display-source',
            reason='Original visible-state branch joins this status prefix with Adventure.Title, then EndNotification -> SetTitleText -> TMP.'))
    assert len(roster) == len({r['id'] for r in roster}) == 44
    assert Counter(r['role'] for r in roster) == {'display-source': 20, 'preserve-adventure-identity': 24}
    body = next(r for r in roster if r.get('adventureType') == 600 and r['field'] == 'Body')['source']
    assert body.count('\n') == 1 and '\\n' not in body
    original = next(r for r in roster if r['field'] == 'Savekey')
    validate_preserved(original, dict(original))
    changed = dict(original, source=original['source'] + '_changed')
    changed['sourceValueSha256'] = value_hash(changed['source'])
    try:
        validate_preserved(original, changed)
    except ValueError as error:
        assert str(error) == 'protected-adventure-identity-changed'
    else:
        raise AssertionError('changed save identity accepted')
    ui_source = ROOT / 'localization/source/shared-source-completion-20261028/evidence/ui-consumer-bodies.jsonl'
    ui_rows = [json.loads(line) for line in ui_source.read_text().splitlines()]
    assert json.loads((HERE / 'retained-ui-consumers.json').read_text()) == [ui_rows[i] for i in (73, 81, 82, 83)]
    provenance = json.loads((HERE / 'provenance.json').read_text())
    assert provenance['originalAssemblySha256'] == ASSEMBLY_SHA
    input_paths = [INDEX, INDEX.parent/'manifest.json', ui_source, HERE/'provenance.json',
                   HERE/'retained-ui-consumers.json', *sorted(HERE.glob('*.il'))]
    pins = {str(p.relative_to(ROOT)): sha(p) for p in input_paths}
    files = {
        'roster.jsonl': ''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':'))+'\n' for r in roster),
        'display-source.jsonl': ''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':'))+'\n' for r in roster if r['role']=='display-source'),
        'preserve-exactly.jsonl': ''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':'))+'\n' for r in roster if r['role']=='preserve-adventure-identity'),
    }
    report = dict(schemaVersion=1, status='passed-static-adventure-source-bindings',
        originalAssemblySha256=ASSEMBLY_SHA, inputPins=pins, scriptSha256=sha(Path(__file__)),
        factoryLiteralStates=42, adventures=6, displayOperands=20, preservedIdentityOperands=24,
        originalBodyLF=1, matchingPositiveControl=True, changedSaveIdentityRejected=True,
        completeSavedBodiesRead=sum(line.startswith('METHOD ') for p in HERE.glob('*.il')
                                   for line in p.read_text().splitlines()) + 4,
        modelJudgment='Sol/high coordinator authored field roles and source/consumer contracts; deterministic checks are not independent semantic review.',
        commonSourceGatePassed=False, translationEntryAllowed=False,
        runtime='not-run', targetEdits=False, textureEdits=False,
        boundary='Exact factory/setter/backing/getter/page/overlay/queue source roles only. Original movie/tutorial/visible/cheat/chapter guards, all keys and other instructions remain unchanged. Native execution, actual event registration, layout and locale adaptations are not accepted.',
        outputs={name: hashlib.sha256(data.encode()).hexdigest() for name,data in files.items()})
    files['verification.json'] = json.dumps(report,ensure_ascii=False,indent=2)+'\n'
    if args.write:
        assert all(not (HERE/name).exists() for name in files)
        for name, value in files.items():
            with (HERE/name).open('x') as stream:
                stream.write(value)
    else:
        for name,value in files.items():
            assert (HERE/name).read_text() == value, ('exact-output-mismatch', name)
    print(json.dumps({k:report[k] for k in ('status','adventures','displayOperands','preservedIdentityOperands')}))


if __name__ == '__main__':
    main()
