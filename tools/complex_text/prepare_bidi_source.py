"""Reproduce the minimal index/type adapter over unchanged, pinned BidiSharp."""
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parent
vendor=ROOT/'vendor/BidiSharp'
manifest=json.loads((vendor/'provenance.json').read_bytes())
for name,digest in manifest['files'].items():
    assert hashlib.sha256((vendor/name).read_bytes()).hexdigest()==digest,'Changed vendor input: '+name
source=(vendor/'BidiSharp/Source/Bidi.cs').read_text()
changes={
    'public static string LogicalToVisual(string input, int[] lineBreaks = null)':
        'public static int[] LogicalToVisualIndexes(string input, out byte[] resolvedLevels, int[] lineBreaks = null, byte[] initialTypes = null, byte? forcedBase = null)',
    'ClassifyCharacters(input, ref typesList);':
        'if(initialTypes == null) ClassifyCharacters(input, ref typesList); else { if(initialTypes.Length != input.Length) throw new ArgumentException("Bidi type count"); typesList=(byte[])initialTypes.Clone(); }',
    'byte baseLevel = GetParagraphEmbeddingLevel(typesList, matchingPDI);':
        'byte baseLevel = forcedBase ?? GetParagraphEmbeddingLevel(typesList, matchingPDI);',
    'var finalStr = GetOrderedString(input, newIndexes);\n\n            return finalStr;':'resolvedLevels=levelsList; return newIndexes;',
}
for old,new in changes.items():
    assert source.count(old)==1,'Vendor patch boundary changed'
    source=source.replace(old,new)
out=ROOT/'BidiForForest.cs'
if '--write' in __import__('sys').argv:out.write_text(source)
elif out.exists():assert out.read_text()==source,'Generated bidi adapter drift'
else:out.write_text(source)
print(hashlib.sha256(out.read_bytes()).hexdigest())

unicode=ROOT/'vendor/Unicode-17.0.0'
pins=json.loads((unicode/'provenance.json').read_bytes())
data=unicode/'BidiMirroring.txt'
assert hashlib.sha256(data.read_bytes()).hexdigest()==pins[data.name]['sha256']
pairs=[]
for line in data.read_text().splitlines():
    fields=line.split('#',1)[0].strip().split(';')
    if len(fields)!=2:continue
    left,right=(int(x.strip(),16) for x in fields)
    if left<=0xFFFF and right<=0xFFFF:pairs.append((left,right))
mirrors='// Unicode17.0.0 BidiMirroring; Unicode License V3 in vendor/Unicode-17.0.0.\nnamespace ForestComplexText { public static class MirrorGlyph { public static char Get(char c) { switch(c) {\n'
mirrors+='\n'.join("case '\\u%04X': return '\\u%04X';"%r for r in pairs)
mirrors+='\ndefault:return c; } } } }\n'
out=ROOT/'MirrorGlyph.cs'
if '--write' in __import__('sys').argv:out.write_text(mirrors)
elif out.exists():assert out.read_text()==mirrors,'Generated mirror table drift'
else:out.write_text(mirrors)
