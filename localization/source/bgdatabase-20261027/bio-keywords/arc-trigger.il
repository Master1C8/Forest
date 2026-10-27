TYPE TheForestOfLove.Narrative.ArcTriggers.ArcTriggerUnlockBioFragment
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerUnlockBioFragment::OnExecute() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerUnlockBioFragment::targetActorDbName
IL_0006: ldarg.0
IL_0007: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerUnlockBioFragment::pluginDbKeywordName
IL_000c: call System.Void TheForestOfLove.Narrative.NarrativeActions::UnlockBioKeyword(System.String,System.String)
IL_0011: ret
