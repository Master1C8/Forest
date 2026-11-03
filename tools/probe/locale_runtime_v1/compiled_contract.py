"""Exact compiled-language text gate and resource view for the shared QA adapter."""
import hashlib
import json
from pathlib import Path


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def read_pin(root, pin):
    path = (Path(root) / pin['path']).resolve()
    if not path.is_relative_to(Path(root).resolve()) or sha(path) != pin['sha256']:
        raise ValueError('Compiled QA input changed: ' + pin['path'])
    return path


def text_gate(root, config):
    """Verify actual complete current-version judgments, never infer them from a build."""
    root = Path(root).resolve()
    language_path = read_pin(root, config['compiledLanguage'])
    language = json.loads(language_path.read_text())
    acceptance_path = read_pin(root, config['textAcceptance'])
    acceptance = json.loads(acceptance_path.read_text())
    if (acceptance.get('format') != 'forest-final-text-acceptance-v1' or
            acceptance.get('locale') != config['locale'] or language.get('locale') != config['locale'] or
            acceptance.get('language') != config['compiledLanguage'] or not acceptance.get('contextComplete')):
        raise ValueError('Missing exact current compiled-language editorial closure')
    source_path = read_pin(root, acceptance['sourcePacket'])
    source_rows = [json.loads(s) for s in source_path.read_text().splitlines() if s.strip()]
    source = {r['id']: r for r in source_rows}
    preservation_path = read_pin(root, acceptance['preservation'])
    protected = json.loads(preservation_path.read_text())['baselinePreserved']
    translations = language['translations']
    if (len(source_rows) != len(source) or len(source) != 14606 or len(protected) != 1781 or
            not protected.keys() <= source.keys() or source.keys() != translations.keys()):
        raise ValueError('Incomplete current text inventory')
    for ident, row in source.items():
        value = translations[ident]
        if value['source'] != row['source'] or not isinstance(value['target'], str):
            raise ValueError('Unresolved or changed original source')
        if ident in protected and (value['target'] != row['source'] or
                hashlib.sha256(row['source'].encode()).hexdigest() != protected[ident]):
            raise ValueError('Protected source changed')
    reviews_path = read_pin(root, acceptance['independentReviews'])
    reviews = [json.loads(s) for s in reviews_path.read_text().splitlines() if s.strip()]
    ordinary = source.keys() - protected.keys()
    if len(reviews) != len(ordinary) or {r['id'] for r in reviews} != ordinary:
        raise ValueError('Incomplete independent version coverage')
    if not acceptance.get('authorThreadIds'):
        raise ValueError('Missing author identity for independent comparison')
    for row in reviews:
        value = translations[row['id']]
        if (row.get('verdict') != 'pass' or row.get('reviewed') is False or
                not (row.get('rationale') or row.get('fidelityRationale')) or
                any(row.get(k) != hashlib.sha256(value[f].encode()).hexdigest()
                    for k, f in [('sourceSha256', 'source'), ('targetSha256', 'target')])):
            raise ValueError('Open finding or stale independent text version')
        if (row.get('model') != 'gpt-6.1-sol' or row.get('reasoning') != 'high' or
                row.get('provider') != 'openai' or not row.get('reviewerThreadId') or
                row['reviewerThreadId'] in acceptance.get('authorThreadIds', [])):
            raise ValueError('Independent reviewer identity not established')
    receipts = acceptance.get('contextReceipts', [])
    if not receipts:
        raise ValueError('Missing required context evidence')
    for pin in receipts:
        read_pin(root, pin)
    for pin in acceptance['glossaryPins']:
        read_pin(root, pin)
    return dict(locale=config['locale'], passed=True, ordinary=len(ordinary), protected=len(protected),
                languageSha256=sha(language_path), independentReviewsSha256=sha(reviews_path),
                boundary='Exact saved semantic receipts and preservation, not native/font/release acceptance')


def resource_manifest(root, config, candidate):
    """Normalize the existing compiler format without editing its delivered manifest."""
    manifest = json.loads((candidate / 'manifest.json').read_text())
    if (manifest.get('format') != 'forest-compiled-language-v1' or
            manifest['locale'] != config['locale'] or manifest['culture'] != config['culture'] or
            manifest['languageSha256'] != config['compiledLanguage']['sha256']):
        raise ValueError('Wrong compiled locale, culture or language version')
    for name, pin in manifest['files'].items():
        path = candidate / name
        if not path.resolve().is_relative_to(candidate.resolve()) or sha(path) != pin['sha256']:
            raise ValueError('Compiled resource changed: ' + name)
    return dict(outputs=manifest['files'], gameResources=manifest['files'],
                sourceCompanions={}, retainedOriginalBase={})


def empty_inventory_wording(language):
    """Bind the original four consumer branches to the compiler's stable managed IDs."""
    method='System.Void TheForestOfLove.InventoryInfoTicker::OnCellSelected(TheForestOfLove.InventoryCellUiController)'
    original=[('010c',82,'SOMETHING?'),('0111',83,'Nope, more nothing.'),
              ('011d',87,'Nothin’'),('0122',88,'You’ve got a whole lot of it.')]
    result=[]
    for offset,index,source in original:
        ident='managed:Managed/Assembly-CSharp.dll:'+method+'@'+str(index)
        row=language['translations'].get(ident)
        if not row or row['source']!=source or not isinstance(row['target'],str):
            raise ValueError('Missing exact original inventory branch: '+ident)
        result.append(dict(branch=offset,id=ident,target=row['target']))
    return result


def fixture_dialogue_ready(state, contract):
    """Reject silent transition nodes and prove the exact target subtitle is loaded."""
    return (state.get('scene')=='CentralForest' and state.get('conversationActive') is True and
            state.get('typing') is False and bool(contract.get('visibleText')) and
            (state.get('conversationId'),state.get('entryId'))==
            (contract['conversationId'],contract['entryId']) and
            state.get('conversationState')==contract['visibleText'] and
            state.get('visibleTypewriterText')==contract['visibleText'])
