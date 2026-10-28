TYPE TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFinishDialogue
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFinishDialogue::.ctor(System.Int32,System.Int32,TheForestOfLove.Narrative.Dialogue) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::.ctor(System.Int32,System.Int32)
IL_0008: ldarg.0
IL_0009: ldarg.3
IL_000a: stfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFinishDialogue::targetDialogue
IL_000f: ret
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFinishDialogue::OnExecute() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFinishDialogue::targetDialogue
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteDialogue(TheForestOfLove.Narrative.Dialogue)
IL_000b: ret
