TYPE TheForestOfLove.MasterLog
METHOD TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::GetRightPage(TheForestOfLove.MasterLogPage) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldc.i4.1
IL_0002: add
IL_0003: ldarg.0
IL_0004: ldfld System.Int32 TheForestOfLove.MasterLog::totalNumPages
IL_0009: rem
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: ldc.i4.2
IL_000d: bne.un.s IL_0016
IL_000f: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedMap()
IL_0014: brfalse.s IL_0019
IL_0016: ldloc.0
IL_0017: br.s IL_001a
IL_0019: ldc.i4.3
IL_001a: stloc.0
IL_001b: ldloc.0
IL_001c: ret
METHOD TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::GetLeftPage(TheForestOfLove.MasterLogPage) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: stloc.0
IL_0002: ldloc.0
IL_0003: ldc.i4.0
IL_0004: bgt.s IL_0010
IL_0006: ldarg.0
IL_0007: ldfld System.Int32 TheForestOfLove.MasterLog::totalNumPages
IL_000c: ldc.i4.1
IL_000d: sub
IL_000e: br.s IL_0013
IL_0010: ldloc.0
IL_0011: ldc.i4.1
IL_0012: sub
IL_0013: stloc.1
IL_0014: ldloc.1
IL_0015: ldc.i4.2
IL_0016: bne.un.s IL_001f
IL_0018: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedMap()
IL_001d: brfalse.s IL_0022
IL_001f: ldloc.1
IL_0020: br.s IL_0023
IL_0022: ldc.i4.1
IL_0023: stloc.1
IL_0024: ldloc.1
IL_0025: ret
