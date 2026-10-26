TYPE TheForestOfLove.Narrative.ArcTriggers.ArcTriggerManuallyCompleteArc
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerManuallyCompleteArc::OnExecute() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTriggerManuallyCompleteArc::targetArc
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::ManuallyCompleteArc(TheForestOfLove.Narrative.Arc)
IL_000b: ret
