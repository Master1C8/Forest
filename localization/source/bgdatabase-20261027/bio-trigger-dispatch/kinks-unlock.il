TYPE TheForestOfLove.Narrative.BioKinks
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
