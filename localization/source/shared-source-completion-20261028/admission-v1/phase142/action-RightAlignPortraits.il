TYPE TheForestOfLove.Narrative.ArcTriggers.ArcTriggerRightAlignPortraits
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerRightAlignPortraits::.ctor(System.Int32,System.Int32,System.String) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::.ctor(System.Int32,System.Int32)
IL_0008: ldarg.0
IL_0009: ldarg.3
IL_000a: stfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerRightAlignPortraits::targetActorDbName
IL_000f: ldarg.0
IL_0010: ldc.i4.1
IL_0011: call System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_allowExecuteMoreThanOnce(System.Boolean)
IL_0016: ret
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerRightAlignPortraits::OnExecute() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerRightAlignPortraits::targetActorDbName
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::RightAlignActorPortraitsCurrentDialogue(System.String)
IL_000b: ret
