TYPE TheForestOfLove.Narrative.BioNotes
METHOD System.String TheForestOfLove.Narrative.BioNotes::get_note1Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note1Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note1Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioNotes::get_note1TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote1Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note1Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote1Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note1Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note1Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioNotes::get_note2Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note2Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note2Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioNotes::get_note2TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote2Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note2Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote2Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note2Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note2Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioNotes::get_note3Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note3Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note3Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioNotes::get_note3TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote3Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note3Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote3Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note3Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note3Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioNotes::get_note4Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note4Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note4Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioNotes::get_note4TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote4Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note4Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote4Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note4Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note4Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioNotes::get_note5Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note5Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note5Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioNotes::get_note5TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote5Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note5Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote5Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note5Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note5Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioNotes::get_note6Text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note6Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note6Keyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Single TheForestOfLove.Narrative.BioNotes::get_note6TimeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote6Unlocked()
IL_0006: brtrue.s IL_000e
IL_0008: ldc.r4 0
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note6Keyword
IL_001a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Item(!0)
IL_0024: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0029: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote6Unlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note6Keyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note6Keyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.Void TheForestOfLove.Narrative.BioNotes::.ctor(System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::.ctor()
IL_0006: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioNotes::notes
IL_000b: ldarg.0
IL_000c: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor()
IL_0011: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.BioNotes::enableWithTags
IL_0016: ldarg.0
IL_0017: call System.Void System.Object::.ctor()
IL_001c: ldarg.0
IL_001d: ldarg.1
IL_001e: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0023: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioNotes::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioNotes::notes
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_0059
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKeyword>::get_Current()
IL_0015: ldarg.1
IL_0016: bne.un.s IL_0059
IL_0018: ldarg.0
IL_0019: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
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
IL_0044: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
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
