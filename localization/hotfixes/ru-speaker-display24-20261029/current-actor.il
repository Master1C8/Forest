TYPE TheForestOfLove.Narrative.Actor
METHOD System.String TheForestOfLove.Narrative.Actor::get_NameplateName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0006: brfalse.s IL_0015
IL_0008: ldarg.0
IL_0009: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_000e: ldfld System.String TheForestOfLove.Narrative.BioDetail::overrideNameplateName
IL_0013: brtrue.s IL_001c
IL_0015: ldarg.0
IL_0016: ldfld System.String TheForestOfLove.Narrative.Actor::nameplateNameDbDefault
IL_001b: ret
IL_001c: ldarg.0
IL_001d: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0022: ldfld System.String TheForestOfLove.Narrative.BioDetail::overrideNameplateName
IL_0027: ret
