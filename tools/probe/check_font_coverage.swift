// Static font-data diagnosis only. Does not establish Unity rendering or shaping.
import Foundation
import CoreText

let sample = "Ёж Йй Щщ Ъъ Ыы Ьь Ээ Юю Яя Е\u{0308} и\u{0306} 123 — Latin!"
for path in CommandLine.arguments.dropFirst() {
    let url = URL(fileURLWithPath: path)
    guard let descriptors = CTFontManagerCreateFontDescriptorsFromURL(url as CFURL) as? [CTFontDescriptor], !descriptors.isEmpty else {
        fatalError("No font descriptor: \(path)")
    }
    for descriptor in descriptors {
        let font = CTFontCreateWithFontDescriptor(descriptor, 14, nil)
        let chars = Array(sample.utf16)
        var glyphs = Array(repeating: CGGlyph(0), count: chars.count)
        CTFontGetGlyphsForCharacters(font, chars, &glyphs, chars.count)
        let missing = Set(zip(chars, glyphs).filter { $0.1 == 0 }.map { String(format: "U+%04X", $0.0) }).sorted()
        let row: [String: Any] = ["path": path, "postScriptName": CTFontCopyPostScriptName(font) as String,
            "size": 14, "ascent": CTFontGetAscent(font), "descent": CTFontGetDescent(font),
            "leading": CTFontGetLeading(font), "unitsPerEm": CTFontGetUnitsPerEm(font),
            "sample": sample, "missing": missing, "boundary": "Exported font data -> CoreText cmap/glyph lookup; replaces the Unity renderer"]
        let data = try JSONSerialization.data(withJSONObject: row, options: [.sortedKeys])
        print(String(data: data, encoding: .utf8)!)
    }
}
