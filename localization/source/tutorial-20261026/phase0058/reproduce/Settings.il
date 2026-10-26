TYPE TheForestOfLove.DialogueSettings
METHOD System.String TheForestOfLove.DialogueSettings::get_ActorDbName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::actor
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_0015
IL_000e: ldarg.0
IL_000f: ldfld System.String TheForestOfLove.DialogueSettings::actorDbName
IL_0014: ret
IL_0015: ldarg.0
IL_0016: ldfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::actor
IL_001b: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_0020: ret
METHOD System.String TheForestOfLove.DialogueSettings::get_DialogueDbName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::dialogue
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_0015
IL_000e: ldarg.0
IL_000f: ldfld System.String TheForestOfLove.DialogueSettings::dialogueDbName
IL_0014: ret
IL_0015: ldarg.0
IL_0016: ldfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::dialogue
IL_001b: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_0020: ret
METHOD System.String TheForestOfLove.DialogueSettings::get_ArcDbName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.DialogueSettings::arcDbName
IL_0006: ret
