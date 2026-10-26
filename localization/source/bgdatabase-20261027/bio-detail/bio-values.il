TYPE TheForestOfLove.Narrative.BioDetail
METHOD System.String TheForestOfLove.Narrative.BioDetail::get_bioSpeciesText() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioSpeciesKeyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioSpeciesKeyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioDetail::get_isBioSpeciesUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioSpeciesKeyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioDetail::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioSpeciesKeyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioDetail::get_bioAgeText() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioAgeKeyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioAgeKeyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioDetail::get_isBioAgeUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioAgeKeyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioDetail::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioAgeKeyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.String TheForestOfLove.Narrative.BioDetail::get_bioRoleText() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioRoleKeyword
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioRoleKeyword
IL_0010: ldfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_0015: ret
METHOD System.Boolean TheForestOfLove.Narrative.BioDetail::get_isBioRoleUnlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioRoleKeyword
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioDetail::keywordData
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioRoleKeyword
IL_0016: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_001b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_0020: ret
METHOD System.Void TheForestOfLove.Narrative.BioDetail::.ctor(System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::.ctor()
IL_0006: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioDetail::bios
IL_000b: ldarg.0
IL_000c: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor()
IL_0011: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.BioDetail::enableWithTags
IL_0016: ldarg.0
IL_0017: call System.Void System.Object::.ctor()
IL_001c: ldarg.0
IL_001d: ldarg.1
IL_001e: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioDetail::keywordData
IL_0023: ret
