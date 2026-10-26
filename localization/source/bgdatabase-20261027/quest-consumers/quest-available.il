TYPE TheForestOfLove.QuestLog
METHOD System.Boolean TheForestOfLove.QuestLog::IsAvailableInQuestLog(TheForestOfLove.Narrative.Quest) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Boolean TheForestOfLove.Narrative.Quest::isHiddenInQuestLog
IL_0006: brfalse.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.1
IL_000b: callvirt System.Boolean TheForestOfLove.Narrative.Quest::IsAvailableWithTags()
IL_0010: ret
