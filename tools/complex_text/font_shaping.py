"""Deterministic glyph preparation adapted from the verified Sonic adapter.

Only glyph preparation and validation are shared. Forest runtime texts stay logical.
"""
from __future__ import annotations
import hashlib, re, unicodedata
from pathlib import Path
from typing import Any, Iterable
import fontTools, uharfbuzz
from fontTools.pens.transformPen import TransformPen
from fontTools.pens.ttGlyphPen import TTGlyphPen
from fontTools.ttLib import TTFont
FONTTOOLS_VERSION = "4.60.2"
UHARFBUZZ_VERSION = "0.51.7"
PUA_START = 0xE000
PUA_END = 0xF8FF
KNOWN_TMP_TAG = re.compile(r"<br>|</?(?:style|size|color|i|b|u|noparse)(?:=[^<>]*)?>", re.IGNORECASE)
class FontAugmenter:
    def __init__(self, source: Path, spec: dict[str, Any]) -> None:
        self.source = source
        self.spec = spec
        self.font = TTFont(source)
        if "glyf" not in self.font:
            raise ValueError(f"Complex shaping requires a TrueType glyf font: {source}")
        self.source_glyph_order = list(self.font.getGlyphOrder())
        self.source_glyph_set = self.font.getGlyphSet()
        data = source.read_bytes()
        self.hb_face = uharfbuzz.Face(data)
        self.hb_font = uharfbuzz.Font(self.hb_face)
        self.hb_font.scale = (self.hb_face.upem, self.hb_face.upem)
        self.next_pua = PUA_START
        self.instances: dict[tuple[int, int, int, int], tuple[int, str]] = {}
        self.rows: list[dict[str, Any]] = []
        self.new_glyph_names: list[str] = []
        self.span_mappings: dict[str, str] = {}
        self.cluster_instances = {}

    def map_cluster(self, glyphs):
        """One visible cluster glyph, preserving HarfBuzz positions internally."""
        if len(glyphs)==1:
            return self.map_glyph(*glyphs[0])
        key=tuple(glyphs)
        if key in self.cluster_instances:return self.cluster_instances[key]
        if self.next_pua>PUA_END:raise ValueError('Complex cluster PUA exhausted')
        pua=self.next_pua;self.next_pua+=1;name=f'vnrevival.{pua:04X}'
        pen=TTGlyphPen(self.source_glyph_set);cursor=0
        for gid,advance,x,y in glyphs:
            if gid<=0 or gid>=len(self.source_glyph_order):raise ValueError('Invalid cluster glyph')
            self.source_glyph_set[self.source_glyph_order[gid]].draw(TransformPen(pen,(1,0,0,1,cursor+x,y)))
            cursor+=advance
        glyph=pen.glyph();self.font['glyf'].glyphs[name]=glyph;glyph.recalcBounds(self.font['glyf'])
        self.font['hmtx'].metrics[name]=(max(0,cursor),getattr(glyph,'xMin',0));self.new_glyph_names.append(name)
        self.instances[('cluster',key)]=(pua,name)
        self.rows.append(dict(codepoint=f'U+{pua:04X}',glyph=name,clusterGlyphs=glyphs,xAdvance=cursor,outlineDuplicated=True))
        value=chr(pua);self.cluster_instances[key]=value;return value

    def zero_glyph(self):
        cmap=self.font.getBestCmap();name=cmap[32]
        return self.map_glyph(self.source_glyph_order.index(name),0,0,0)

    def is_script_character(self, character: str) -> bool:
        codepoint = ord(character)
        # Arabic-Indic digits live inside the Arabic block but form a numeric
        # LTR run. Shaping them as Arabic letters reverses their value in TMP.
        return not character.isdecimal() and any(start <= codepoint <= end for start, end in self.spec["ranges"])

    def is_span_character(self, character: str) -> bool:
        return (
            self.is_script_character(character)
            or character in {"\u200c", "\u200d"}
            or unicodedata.category(character).startswith("M")
        )

    def has_script(self, value: str) -> bool:
        return any(self.is_script_character(character) for character in value)

    def compensate_ltr_run(self, value: str) -> str:
        """Pre-reverse LTR runs that TMP will reverse in an RTL text object."""
        if self.spec["baseDirection"] != "R":
            return value
        if not any(
            unicodedata.bidirectional(character) in {"L", "EN", "AN"}
            for character in value
        ):
            return value
        # Keep boundary whitespace on its logical side of the run. Reversing
        # it together with the Latin core makes TMP place the separator on the
        # outside edge (for example rendering Hebrew + `Shadow` as one glued
        # token while leaving a useless space after the name).
        start = 0
        while start < len(value) and value[start].isspace():
            start += 1
        end = len(value)
        while end > start and value[end - 1].isspace():
            end -= 1
        return value[:start] + value[start:end][::-1] + value[end:]

    def map_glyph(
        self,
        glyph_id: int,
        x_advance: int,
        x_offset: int,
        y_offset: int,
    ) -> str:
        if glyph_id <= 0 or glyph_id >= len(self.source_glyph_order):
            raise ValueError(f"HarfBuzz returned invalid glyph ID {glyph_id}")
        key = (glyph_id, x_advance, x_offset, y_offset)
        existing = self.instances.get(key)
        if existing is not None:
            return chr(existing[0])
        if self.next_pua > PUA_END:
            raise ValueError("Complex-script glyph instances exhausted the BMP private-use area")

        pua = self.next_pua
        self.next_pua += 1
        source_name = self.source_glyph_order[glyph_id]
        source_advance, source_lsb = self.font["hmtx"].metrics[source_name]
        if x_offset == 0 and y_offset == 0 and x_advance == source_advance:
            output_name = source_name
            duplicate = False
        else:
            output_name = f"vnrevival.{pua:04X}"
            pen = TTGlyphPen(self.source_glyph_set)
            transformed = TransformPen(pen, (1, 0, 0, 1, x_offset, y_offset))
            self.source_glyph_set[source_name].draw(transformed)
            glyph = pen.glyph()
            self.font["glyf"].glyphs[output_name] = glyph
            glyph.recalcBounds(self.font["glyf"])
            lsb = getattr(glyph, "xMin", source_lsb + x_offset)
            self.font["hmtx"].metrics[output_name] = (max(0, x_advance), lsb)
            self.new_glyph_names.append(output_name)
            duplicate = True

        self.instances[key] = (pua, output_name)
        self.rows.append(
            {
                "codepoint": f"U+{pua:04X}",
                "glyph": output_name,
                "sourceGlyph": source_name,
                "sourceGlyphId": glyph_id,
                "xAdvance": x_advance,
                "xOffset": x_offset,
                "yOffset": y_offset,
                "outlineDuplicated": duplicate,
            }
        )
        return chr(pua)

    def shape_span(
        self,
        characters: str,
    ) -> str:
        codepoints = [ord(character) for character in characters]
        buffer = uharfbuzz.Buffer()
        buffer.add_codepoints(codepoints)
        buffer.direction = "rtl" if self.spec["baseDirection"] == "R" else "ltr"
        buffer.script = self.spec["script"]
        buffer.language = self.spec["language"]
        uharfbuzz.shape(self.hb_font, buffer)
        groups = {}
        for info, position in zip(buffer.glyph_infos, buffer.glyph_positions):
            groups.setdefault(info.cluster,[]).append((info.codepoint,position.x_advance,position.x_offset,position.y_offset))
        starts=sorted(groups)
        if not starts or starts[0]!=0:raise ValueError('Incomplete HarfBuzz cluster coverage')
        result=[]
        for i,start in enumerate(starts):
            end=starts[i+1] if i+1<len(starts) else len(characters)
            count=end-start
            if count<1:raise ValueError('Invalid HarfBuzz cluster interval')
            # Dummy slots precede the visible composite: effect/character indices
            # remain logical, while conjuncts reveal as complete shaped clusters.
            if count>1:result.append(self.zero_glyph()*(count-1))
            result.append(self.map_cluster(groups[start]))
        shaped=''.join(result)
        if len(shaped)!=len(characters):raise ValueError('Logical character index drift')
        previous = self.span_mappings.get(characters)
        if previous is not None and previous != shaped:
            raise ValueError(f"Inconsistent shaping for span {characters!r}")
        self.span_mappings[characters] = shaped
        return shaped

    def shape_plain_text(self, value: str, *, rtl_context: bool = False) -> str:
        if not self.has_script(value) and not rtl_context:
            return value
        output: list[str] = []
        index = 0
        while index < len(value):
            if self.is_span_character(value[index]):
                end = index + 1
                while end < len(value) and self.is_span_character(value[end]):
                    end += 1
                output.append(self.shape_span(value[index:end]))
                index = end
            else:
                end = index + 1
                while end < len(value) and not self.is_span_character(value[end]):
                    end += 1
                # Keep logical run order here. The shared runtime bidi adapter
                # resolves numbers and neutral separators before TMP reversal.
                output.append(value[index:end])
                index = end
        return "".join(output)

    def shape_rich_text(self, value: str) -> str:
        rtl_context = self.spec["baseDirection"] == "R" and self.has_script(value)
        if not self.has_script(value):
            return value
        output: list[str] = []
        position = 0
        for match in KNOWN_TMP_TAG.finditer(value):
            output.append(
                self.shape_plain_text(
                    value[position : match.start()],
                    rtl_context=rtl_context,
                )
            )
            output.append(match.group(0))
            position = match.end()
        output.append(self.shape_plain_text(value[position:], rtl_context=rtl_context))
        return "".join(output)

    def save(self, output: Path) -> None:
        if self.new_glyph_names:
            self.font.setGlyphOrder(self.font.getGlyphOrder() + self.new_glyph_names)
        for table in self.font["cmap"].tables:
            if table.isUnicode() and table.format in {4, 12}:
                for row in self.rows:
                    table.cmap[int(row["codepoint"][2:], 16)] = row["glyph"]
        self.font.recalcTimestamp = False
        self.font["head"].created = 2082844800
        self.font["head"].modified = 2082844800
        output.parent.mkdir(parents=True, exist_ok=True)
        self.font.save(output)


def unique_strings(values: Iterable[str]) -> list[str]:
    return sorted(set(values))


def known_tag_sequence(value: str) -> list[str]:
    return [match.group(0) for match in KNOWN_TMP_TAG.finditer(value)]


def validate_shaped_value(
    logical: str,
    shaped: str,
    augmenter: FontAugmenter,
    description: str,
) -> None:
    if known_tag_sequence(logical) != known_tag_sequence(shaped):
        raise ValueError(f"TMP tag sequence changed in {description}: {logical!r}")
    visible = KNOWN_TMP_TAG.sub("", shaped)
    if any(augmenter.is_script_character(character) for character in visible):
        raise ValueError(f"Unshaped target-script character remains in {description}: {logical!r}")
    if any(character in {"\u200c", "\u200d"} for character in visible):
        raise ValueError(f"Unshaped joiner remains in {description}: {logical!r}")


