"""Offline Thai word/TCC boundaries; glyphs and logical strings stay unchanged."""
import hashlib
import importlib.metadata
import re
from pathlib import Path

THAI = re.compile(r'[\u0e01-\u0e3a\u0e40-\u0e4e]+')
TAGS = re.compile(r'<br>|</?(?:style|size|color|i|b|u|noparse)(?:=[^<>]*)?>', re.I)
VERSION = '5.4.0'

def plain(value):
    return TAGS.sub(lambda m: '\n' if m[0].lower() == '<br>' else '', value)

def boundaries(value):
    from pythainlp.tokenize import word_tokenize
    from pythainlp.tokenize.tcc import tcc_pos
    tokens = word_tokenize(value, engine='newmm', keep_whitespace=True)
    assert ''.join(tokens) == value, 'Thai tokenizer must be lossless'
    clusters = set(tcc_pos(value))
    ends = set()
    position = 0
    for token in tokens:
        position += len(token)
        ends.add(position)
    # Unknown-word recovery in newmm can nominate a boundary inside a TCC.
    # Conservatively join those neighboring tokens; never split that cluster.
    ends.intersection_update(clusters)
    assert len(value) in ends, 'Thai run must end on a complete TCC'
    # 1: word end; 2: cluster end, used only if the first word exceeds its line;
    # 0: never save a wrap inside a cluster. No inserted display characters.
    return ''.join('1' if i in ends else '2' if i in clusters else '0'
                   for i in range(1, len(value) + 1))

def build(exact, spans):
    assert importlib.metadata.version('pythainlp') == VERSION
    import pythainlp
    dictionary = Path(pythainlp.__file__).parent / 'corpus/words_th.txt'
    rows = {}
    logical_runs = set()
    for logical, shaped in list(exact.items()) + list(spans.items()):
        source, display = plain(logical), plain(shaped)
        assert len(source) == len(display), 'Thai wrap indices must retain character slots'
        for match in THAI.finditer(source):
            run = match[0]
            flags = boundaries(run)
            logical_runs.add(run)
            for key in (run, display[match.start():match.end()]):
                assert key not in rows or rows[key] == flags, 'Ambiguous Thai wrap alias'
                rows[key] = flags
    assert rows
    return rows, dict(engine='PyThaiNLP/newmm', version=VERSION,
        dictionarySha256=hashlib.sha256(dictionary.read_bytes()).hexdigest(),
        dictionaryWordsFile='pythainlp/corpus/words_th.txt',
        dictionaryLicense='CC0-1.0', codeLicense='Apache-2.0',
        logicalRuns=len(logical_runs), aliases=len(rows),
        characterSlotsUnchanged=True, modelRequests=0)
