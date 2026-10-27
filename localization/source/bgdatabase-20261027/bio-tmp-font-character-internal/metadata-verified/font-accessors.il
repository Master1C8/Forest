TYPE TMPro.TMP_FontAsset
METHOD TMPro.AtlasPopulationMode TMPro.TMP_FontAsset::get_atlasPopulationMode() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.AtlasPopulationMode TMPro.TMP_FontAsset::m_AtlasPopulationMode
IL_0006: ret
METHOD System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::get_characterLookupTable() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0006: brtrue.s IL_000e
IL_0008: ldarg.0
IL_0009: call System.Void TMPro.TMP_FontAsset::ReadFontAssetDefinition()
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0014: ret
METHOD System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::get_fallbackFontAssetTable() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable
IL_0006: ret
METHOD TMPro.TMP_FontWeightPair[] TMPro.TMP_FontAsset::get_fontWeightTable() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TMP_FontWeightPair[] TMPro.TMP_FontAsset::m_FontWeightTable
IL_0006: ret
