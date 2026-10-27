"""Translate the source-bound report form without changing data or send handlers."""
import collections
import copy
import hashlib
import json
from pathlib import Path

from extract_assets import read_tree

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
INVENTORY = ROOT / 'localization/source/bug-report-ui-20261027/inventory.json'
REPORT_TEXT = {
    'System Info:': 'О системе:',
    'Edit Text': 'Изменить текст',
    'Send\nReport': 'Отправить\nотчёт',
    "Select ''Edit Text'' to let us know what happened!\n\nThe report tool will gather the other information we need.\nYou can adjust the detail level of system information sent.":
        'Нажмите «Изменить текст», чтобы описать проблему!\n\nОстальные нужные сведения программа соберёт сама.\nВы можете выбрать, сколько сведений о системе отправлять.',
    'You can type your report with a physical keyboard.\nOr use our virtual keyboard. It supports touch and gamepad controls!':
        'Текст можно ввести с обычной клавиатуры\nили с экранной — она поддерживает сенсорный экран и геймпад!',
    'The bug report was sent successfully!\nThank you for your feedback.':
        'Отчёт об ошибке успешно отправлен!\nСпасибо за отзыв.',
    'The bug report text is empty!\nPlease add some text and try again.':
        'В отчёте об ошибке нет текста!\nДобавьте описание и попробуйте снова.',
    'Send the bug report?': 'Отправить отчёт об ошибке?',
    'Cancel the bug report?\nThe text you entered will be erased.':
        'Отменить отчёт об ошибке?\nВведённый текст будет удалён.',
    "The bug report cannot be sent on this platform.\nPlease share your feedback from a Desktop build\nor on the game's website tfol.info":
        'На этой платформе нельзя отправить отчёт.\nОставьте отзыв в версии игры для компьютера\nили на сайте игры tfol.info',
    'Yes': 'Да',
    'No': 'Нет',
    'Ok': 'ОК',
    'The following information will be sent:': 'Будут отправлены следующие сведения:',
    'Application Info': 'Сведения о приложении',
    'System Info': 'Сведения о системе',
}


def report_text_plan(objects, generator):
    assert hashlib.sha256(INVENTORY.read_bytes()).hexdigest() == 'dd7e3382ef8c2e0a3ef59106d7ed3c550a2e14e3fff34cdd0f202acf12cc48f3', 'report-inventory-fingerprint'
    inventory = json.loads(INVENTORY.read_text())
    assert inventory['sourceSha256'] == '5ff0636003eed46615678c124f42320eb9a8c66baa0870ec11c9faa42db78db0'
    assert len(inventory['rows']) == 131, 'report-source-inventory'
    cache = {}

    def tree(pid):
        if pid not in cache:
            cache[pid] = read_tree(objects[pid], generator)
        return cache[pid]

    def path(go):
        value = tree(go)
        rects = [c['component']['m_PathID'] for c in value['m_Component']
                 if objects[c['component']['m_PathID']].type.name == 'RectTransform']
        assert len(rects) == 1, ('report-transform', go)
        father = tree(rects[0])['m_Father']['m_PathID']
        return (path(tree(father)['m_GameObject']['m_PathID']) + '/' if father else '') + value['m_Name']

    repairs, groups = {}, {}
    for row in inventory['rows']:
        source = row['source']
        if source not in REPORT_TEXT:
            assert source in {'Back', '+', '++', '+++', '++++', '\u200b'}, ('report-unclassified-source', source)
            continue
        pid = row['pathId']
        obj = objects[pid]
        assert obj.type.name == 'MonoBehaviour'
        assert obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName == 'TextMeshProUGUI'
        value = tree(pid)
        assert value['m_text'] == source, ('report-before-text', pid)
        assert path(value['m_GameObject']['m_PathID']) == row['hierarchy'], ('report-hierarchy', pid)
        assert value['m_fontAsset'] == {'m_FileID': 5, 'm_PathID': 3323}, ('report-font-binding', pid)
        target = REPORT_TEXT[source]
        assert source.count('\n') == target.count('\n'), ('report-line-breaks', pid)
        fixed = copy.deepcopy(value)
        fixed['m_text'] = target
        repairs[pid] = fixed
        family = row['hierarchy'].split('/NameGlow')[0].split('/NameContainer')[0]
        group = groups.setdefault(family, {'hierarchy': family, 'source': source, 'target': target, 'textIds': []})
        assert group['source'] == source
        group['textIds'].append(pid)
    assert len(repairs) == 100 and len(groups) == 20, 'report-complete-text-coverage'
    assert collections.Counter(len(g['textIds']) for g in groups.values()) == {6: 16, 1: 4}
    return repairs, list(groups.values())
