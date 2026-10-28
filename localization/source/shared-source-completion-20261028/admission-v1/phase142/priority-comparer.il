TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c
METHOD System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<PrioritizeArcTriggers>b__52_0(TheForestOfLove.Narrative.ArcTriggers.ArcTrigger,TheForestOfLove.Narrative.ArcTriggers.ArcTrigger) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldflda System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_0006: ldarg.2
IL_0007: ldfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_000c: call System.Int32 System.Int32::CompareTo(System.Int32)
IL_0011: ret
