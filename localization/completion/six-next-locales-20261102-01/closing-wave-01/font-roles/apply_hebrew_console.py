"""Supply the saved Hebrew console font through existing registered locale data."""
from pathlib import Path
import base64
import hashlib
import io
import json
import os
import unicodedata
from fontTools.ttLib import TTFont

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
HERE = Path(__file__).resolve().parent


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    target = ROOT / 'localization/languages/he.json'
    before = target.read_bytes()
    assert sha(before) == '0a7f6fb1c3fdc5b444cd4e1af01e2b0af541f0525f8aea79c04a92613ddd98c4'
    output = HERE / 'he-console-registration.json'
    assert not output.exists(), 'Reconcile existing application before another write'
    document = json.loads(before)
    assert not document['fonts'] and not document['fontAssets']
    framework = json.loads((ROOT / 'localization/framework/forest045-shared-v2/framework.json').read_text())
    role = 'resources.assets:437'
    assert framework['fontRoles'][role]['name'] == 'Consola'
    settings_path = ROOT / 'assets/source-v2/trees/90744c19ec-resources.assets-1006.json'
    settings = json.loads(settings_path.read_text())
    assert settings['m_Name'] == 'DevConsoleSettings' and settings['font'] == {'m_FileID': 0, 'm_PathID': 437}
    consumer = json.loads((HERE / 'console-font-consumer.json').read_text())
    body = next(m for m in consumer['methods'] if m['method'] == 'System.Void SickDev.DevConsole.GUIUtils::UpdateFont(UnityEngine.GUIStyle)')
    assert any(i.get('operand') == 'UnityEngine.Font SickDev.DevConsole.Settings::font' for i in body['instructions'])
    assert any(i.get('operand') == 'System.Void UnityEngine.GUIStyle::set_font(UnityEngine.Font)' for i in body['instructions'])
    face_path = ROOT / 'assets/source-v2/trees/90744c19ec-resources.assets-439.json'
    face = bytes(json.loads(face_path.read_text())['m_FontData'])
    face_sha = sha(face)
    assert face_sha == 'e5b0af421ea2bfbc1ac8d251d647268087ae82786234c57f757d1f0b90fa8b49'
    protected = json.loads((ROOT / 'localization/completion/five-new-locales-20261101-01/source-preservation.json').read_text())['baselinePreserved']
    with TTFont(io.BytesIO(face)) as font:
        cmap = font.getBestCmap()
        space = font['hmtx'][cmap[32]][0]
        assert space > 0
        requirements = {}
        for form in ('raw', 'NFC', 'NFD'):
            chars = {ord(ch) for ident, row in document['translations'].items() if ident not in protected
                     for ch in (row['target'] if form == 'raw' else unicodedata.normalize(form, row['target']))
                     if not unicodedata.category(ch).startswith('C')}
            missing = sorted(chars - cmap.keys())
            assert not missing, (form, missing)
            requirements[form] = dict(codepoints=sorted(chars), missing=missing)
        family = font['name'].getDebugName(1)
        assert family == 'Liberation Sans'
        metrics = dict(unitsPerEm=font['head'].unitsPerEm, ascent=font['hhea'].ascent,
                       descent=font['hhea'].descent, lineGap=font['hhea'].lineGap, spaceAdvance=space,
                       fixedPitch=font['post'].isFixedPitch)
    candidate = json.loads(before)
    candidate['fonts'][role] = dict(asset=face_sha, family=family)
    candidate['fontAssets'][face_sha] = base64.b64encode(face).decode()
    assert candidate['translations'] == document['translations'] and candidate['layout'] == document['layout']
    after = (json.dumps(candidate, ensure_ascii=False, indent=2, sort_keys=True) + '\n').encode()
    (HERE / 'he-language-before-font.json').write_bytes(before)
    prepared = HERE / 'he-font-prepared.json'
    with prepared.open('xb') as stream:
        stream.write(after)
    receipt = dict(status='prepared', language='localization/languages/he.json', beforeSha256=sha(before),
                   afterSha256=sha(after), registeredRole=role, faceSha256=face_sha, family=family,
                   sourceFace=dict(path=str(face_path.relative_to(ROOT)), sha256=sha(face_path.read_bytes())),
                   settings=dict(path=str(settings_path.relative_to(ROOT)), sha256=sha(settings_path.read_bytes())),
                   consumer=dict(path=str((HERE / 'console-font-consumer.json').relative_to(ROOT)), sha256=sha((HERE / 'console-font-consumer.json').read_bytes())),
                   translationChanges=0, sourceChanges=0, layoutChanges=0, fictionalMappingChanges=0,
                   requirements=requirements, metrics=metrics,
                   decision='Saved DevConsoleSettings font437 flows through GUIUtils.UpdateFont into GUIStyle.font. Supply the existing embedded face439, which covers the exact Hebrew ordinary corpus, via the common registered font override.',
                   limits=['This is a static candidate, not native loading, shaping/bidi, mark placement, wrapping, readability or release acceptance.',
                           'Liberation Sans is proportional; former Consola monospace alignment/style remains an explicit native console check.',
                           'Moire436/438 references are TOCK skin styles/fallbacks; no claim that runtime never selects them. They stay unchanged pending concrete demand evidence.',
                           'Existing embedded game face retained; no new download, public font redistribution or license approval.'],
                   semanticEvidence='All 12825 source/target strings remain exact; the integrated independent judgments are reusable per wording/context version despite the new document/font hash.')
    output.write_text(json.dumps(receipt, indent=2) + '\n')
    os.replace(prepared, target)
    assert sha(target.read_bytes()) == receipt['afterSha256']
    receipt['status'] = 'applied-and-readback-verified'
    output.write_text(json.dumps(receipt, indent=2) + '\n')
    print(json.dumps({key: receipt[key] for key in ('status', 'beforeSha256', 'afterSha256', 'registeredRole', 'translationChanges')}))


if __name__ == '__main__':
    main()
