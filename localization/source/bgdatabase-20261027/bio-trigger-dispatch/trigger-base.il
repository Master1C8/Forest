TYPE TheForestOfLove.Narrative.ArcTriggers.ArcTrigger
METHOD System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_isExecuted() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::<isExecuted>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_isExecuted(System.Boolean) | attributes=Family, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::<isExecuted>k__BackingField
IL_0007: ret
METHOD System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_allowExecuteMoreThanOnce() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::<allowExecuteMoreThanOnce>k__BackingField
IL_0006: ret
METHOD System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_skipDuringDialogueSkip() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::<skipDuringDialogueSkip>k__BackingField
IL_0006: ret
METHOD System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_skipDuringChapterSelect() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::<skipDuringChapterSelect>k__BackingField
IL_0006: ret
METHOD System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_skipDuringCheatCode() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::<skipDuringCheatCode>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::.ctor(System.Int32,System.Int32) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: call System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_conversationId(System.Int32)
IL_000d: ldarg.0
IL_000e: ldarg.2
IL_000f: call System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_dialogueEntryId(System.Int32)
IL_0014: ret
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::CheckTrigger(TheForestOfLove.Narrative.Arc,System.Int32,System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.0
IL_0002: ldfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_0007: beq.s IL_0014
IL_0009: ldarg.1
IL_000a: brtrue.s IL_003b
IL_000c: ldarg.0
IL_000d: ldfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::allowNullArc
IL_0012: brfalse.s IL_003b
IL_0014: ldarg.0
IL_0015: call System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_isExecuted()
IL_001a: brfalse.s IL_0024
IL_001c: ldarg.0
IL_001d: call System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_allowExecuteMoreThanOnce()
IL_0022: brfalse.s IL_003b
IL_0024: ldarg.0
IL_0025: ldarg.2
IL_0026: ldarg.3
IL_0027: callvirt System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::IsConditionSatisfied(System.Int32,System.Int32)
IL_002c: brfalse.s IL_003b
IL_002e: ldarg.0
IL_002f: ldc.i4.1
IL_0030: call System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_isExecuted(System.Boolean)
IL_0035: ldarg.0
IL_0036: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::OnExecute()
IL_003b: ret
METHOD System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::IsConditionSatisfied(System.Int32,System.Int32) | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.0
IL_0002: call System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_conversationId()
IL_0007: bne.un.s IL_0013
IL_0009: ldarg.2
IL_000a: ldarg.0
IL_000b: call System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_dialogueEntryId()
IL_0010: ceq
IL_0012: ret
IL_0013: ldc.i4.0
IL_0014: ret
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::ForceExecute() | attributes=Public, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Globals::isDialogueSkip
IL_0005: brfalse.s IL_0010
IL_0007: ldarg.0
IL_0008: call System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_skipDuringDialogueSkip()
IL_000d: brfalse.s IL_0010
IL_000f: ret
IL_0010: ldsfld System.Boolean Globals::isChapterSelect
IL_0015: brfalse.s IL_0020
IL_0017: ldarg.0
IL_0018: call System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_skipDuringChapterSelect()
IL_001d: brfalse.s IL_0020
IL_001f: ret
IL_0020: ldsfld System.Boolean Globals::isCheatCode
IL_0025: brfalse.s IL_0030
IL_0027: ldarg.0
IL_0028: call System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_skipDuringCheatCode()
IL_002d: brfalse.s IL_0030
IL_002f: ret
IL_0030: ldarg.0
IL_0031: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::OnExecute()
IL_0036: ret
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::OnExecute() | attributes=Family, Virtual, HideBySig, VtableLayoutMask, Abstract | impl=IL
