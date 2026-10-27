TYPE TheForestOfLove.Narrative.ArcTriggers.ArcTriggerUnlockBioFragment
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerUnlockBioFragment::.ctor(System.Int32,System.Int32,System.String,System.String) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::.ctor(System.Int32,System.Int32)
IL_0008: ldarg.0
IL_0009: ldarg.3
IL_000a: stfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerUnlockBioFragment::targetActorDbName
IL_000f: ldarg.0
IL_0010: ldarg.s pluginDbKeywordName
IL_0012: stfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerUnlockBioFragment::pluginDbKeywordName
IL_0017: ret
