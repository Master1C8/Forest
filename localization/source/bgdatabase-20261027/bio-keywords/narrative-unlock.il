TYPE TheForestOfLove.Narrative.NarrativeActions
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::UnlockBioKeyword(System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.QuestTriggerHelper::InVsliceStoryInstance()
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldarg.0
IL_0009: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_000e: ldarg.1
IL_000f: call TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Services.Persistence.DataService::GetBioKeywordByPluginDbTriggerName(System.String)
IL_0014: stloc.0
IL_0015: ldloc.0
IL_0016: callvirt System.Void TheForestOfLove.Narrative.Actor::UnlockBioKeyword(TheForestOfLove.Narrative.BioKeyword)
IL_001b: ret
