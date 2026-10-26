TYPE TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition
METHOD System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition::get_IsSatisfied() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call System.Boolean Globals::get_DisablePreconditions()
IL_0005: brtrue.s IL_000e
IL_0007: ldarg.0
IL_0008: callvirt System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition::IsConditionSatisfied()
IL_000d: ret
IL_000e: ldc.i4.1
IL_000f: ret
