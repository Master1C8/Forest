TYPE TheForestOfLove.QuestLog/<>c
METHOD System.Int32 TheForestOfLove.QuestLog/<>c::<GenerateLogTextHistory>b__44_0(TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldflda System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_0006: ldarg.2
IL_0007: ldfld System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_000c: call System.Int32 System.Int32::CompareTo(System.Int32)
IL_0011: ret
