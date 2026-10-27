TYPE TheForestOfLove.Narrative.BioKinks
METHOD System.String TheForestOfLove.Narrative.BioKinks::get_kink1Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink1Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink1Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioKinks::get_kink1TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink1Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink1Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink1Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink1Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink1Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioKinks::get_kink2Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink2Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink2Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioKinks::get_kink2TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink2Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink2Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink2Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink2Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink2Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioKinks::get_kink3Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink3Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink3Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioKinks::get_kink3TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink3Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink3Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink3Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink3Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink3Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioKinks::get_kink4Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink4Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink4Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioKinks::get_kink4TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink4Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink4Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink4Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink4Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink4Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioKinks::get_kink5Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink5Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink5Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioKinks::get_kink5TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink5Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink5Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink5Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink5Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink5Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioKinks::get_kink6Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink6Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink6Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioKinks::get_kink6TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink6Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink6Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink6Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink6Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink6Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioKinks::get_kink7Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink7Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink7Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioKinks::get_kink7TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink7Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink7Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink7Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink7Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink7Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioKinks::get_kink8Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink8Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink8Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioKinks::get_kink8TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink8Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink8Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink8Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink8Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink8Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioKinks::get_kink9Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink9Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink9Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioKinks::get_kink9TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink9Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink9Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink9Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink9Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink9Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.Void TheForestOfLove.Narrative.BioKinks::.ctor(System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::.ctor()
IL_0006: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_000b: ldarg.0
IL_000c: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor()
IL_0011: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.BioKinks::enableWithTags
IL_0016: ldarg.0
IL_0017: call System.Void System.Object::.ctor()
IL_001c: ldarg.0
IL_001d: ldarg.1
IL_001e: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0023: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioKinks::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_0059
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKeyword>::get_Current()
IL_0015: ldarg.1
IL_0016: bne.un.s IL_0059
IL_0018: ldarg.0
IL_0019: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_001e: ldarg.1
IL_001f: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_0024: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0029: brtrue.s IL_0059
IL_002b: newobj System.Void TheForestOfLove.Narrative.BioKeywordData::.ctor()
IL_0030: stloc.1
IL_0031: ldloc.1
IL_0032: ldarg.1
IL_0033: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKeywordData::keyword
IL_0038: ldloc.1
IL_0039: call System.Single Globals::get_StoryClock()
IL_003e: stfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0043: ldarg.0
IL_0044: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0049: ldarg.1
IL_004a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_004f: ldloc.1
IL_0050: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::Add(!0,!1)
IL_0055: ldc.i4.1
IL_0056: stloc.2
IL_0057: leave.s IL_0074
IL_0059: ldloca.s V_0
IL_005b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKeyword>::MoveNext()
IL_0060: brtrue.s IL_000e
IL_0062: leave.s IL_0072
IL_0064: ldloca.s V_0
IL_0066: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKeyword>
IL_006c: callvirt System.Void System.IDisposable::Dispose()
IL_0071: endfinally
IL_0072: ldc.i4.0
IL_0073: ret
IL_0074: ldloc.2
IL_0075: ret
