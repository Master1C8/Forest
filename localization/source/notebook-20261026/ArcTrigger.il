TYPE TheForestOfLove.Narrative.ArcTriggers.ArcTrigger
METHOD System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::CheckTrigger(TheForestOfLove.Narrative.Arc,System.Int32,System.Int32)
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
METHOD System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::IsConditionSatisfied(System.Int32,System.Int32)
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
