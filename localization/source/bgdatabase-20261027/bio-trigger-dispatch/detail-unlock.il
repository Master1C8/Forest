TYPE TheForestOfLove.Narrative.BioDetail
METHOD System.Boolean TheForestOfLove.Narrative.BioDetail::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0005
IL_0003: ldc.i4.0
IL_0004: ret
IL_0005: ldarg.0
IL_0006: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioDetail::bios
IL_000b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::GetEnumerator()
IL_0010: stloc.0
IL_0011: br.s IL_005e
IL_0013: ldloca.s V_0
IL_0015: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKeyword>::get_Current()
IL_001a: ldarg.1
IL_001b: bne.un.s IL_005e
IL_001d: ldarg.0
IL_001e: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioDetail::keywordData
IL_0023: ldarg.1
IL_0024: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_0029: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_002e: brtrue.s IL_005e
IL_0030: newobj System.Void TheForestOfLove.Narrative.BioKeywordData::.ctor()
IL_0035: stloc.1
IL_0036: ldloc.1
IL_0037: ldarg.1
IL_0038: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKeywordData::keyword
IL_003d: ldloc.1
IL_003e: call System.Single Globals::get_StoryClock()
IL_0043: stfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0048: ldarg.0
IL_0049: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioDetail::keywordData
IL_004e: ldarg.1
IL_004f: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_0054: ldloc.1
IL_0055: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::Add(!0,!1)
IL_005a: ldc.i4.1
IL_005b: stloc.2
IL_005c: leave.s IL_0079
IL_005e: ldloca.s V_0
IL_0060: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKeyword>::MoveNext()
IL_0065: brtrue.s IL_0013
IL_0067: leave.s IL_0077
IL_0069: ldloca.s V_0
IL_006b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKeyword>
IL_0071: callvirt System.Void System.IDisposable::Dispose()
IL_0076: endfinally
IL_0077: ldc.i4.0
IL_0078: ret
IL_0079: ldloc.2
IL_007a: ret
