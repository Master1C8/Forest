TYPE TheForestOfLove.Narrative.QuestProgressLogEntry
METHOD System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::Load(TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0004
IL_0003: ret
IL_0004: ldarg.0
IL_0005: ldarg.1
IL_0006: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry::isUnlocked
IL_000b: call System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::set_IsUnlocked(System.Boolean)
IL_0010: ldarg.0
IL_0011: ldarg.1
IL_0012: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry::timeUnlocked
IL_0017: call System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::set_UnlockedGameplayTime(System.Single)
IL_001c: ret
METHOD System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::Unlock(System.Boolean) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.QuestProgressLogEntry::get_IsUnlocked()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.1
IL_000b: call System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::set_IsUnlocked(System.Boolean)
IL_0010: ldarg.0
IL_0011: call System.Single Globals::get_StoryClock()
IL_0016: call System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::set_UnlockedGameplayTime(System.Single)
IL_001b: ldarg.1
IL_001c: brtrue.s IL_0029
IL_001e: ldsfld TheForestOfLove.Events.QuestProgressLogEvent TheForestOfLove.Events.NarrativeEvents::onQuestProgressLogUnlocked
IL_0023: ldarg.0
IL_0024: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::Invoke(!0)
IL_0029: ret
METHOD System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::ResetUnlock() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.QuestProgressLogEntry::get_IsUnlocked()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: call System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::set_IsUnlocked(System.Boolean)
IL_0010: ldarg.0
IL_0011: ldc.r4 0
IL_0016: call System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::set_UnlockedGameplayTime(System.Single)
IL_001b: ret
METHOD TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Narrative.QuestProgressLogEntry::GetRootUnlockedProgressLogRecursive() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Narrative.QuestProgressLogEntry::GetRootUnlockedProgressLogRecursive(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_0007: ret
METHOD TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Narrative.QuestProgressLogEntry::GetRootUnlockedProgressLogRecursive(TheForestOfLove.Narrative.QuestProgressLogEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.Boolean TheForestOfLove.Narrative.QuestProgressLogEntry::get_IsUnlocked()
IL_0006: brtrue.s IL_000a
IL_0008: ldnull
IL_0009: ret
IL_000a: ldarg.1
IL_000b: ldfld TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Narrative.QuestProgressLogEntry::replaceEarlierLog
IL_0010: brtrue.s IL_0014
IL_0012: ldarg.1
IL_0013: ret
IL_0014: ldarg.0
IL_0015: ldarg.1
IL_0016: ldfld TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Narrative.QuestProgressLogEntry::replaceEarlierLog
IL_001b: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Narrative.QuestProgressLogEntry::GetRootUnlockedProgressLogRecursive(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_0020: ret
