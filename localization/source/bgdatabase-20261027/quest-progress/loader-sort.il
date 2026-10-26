TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateQuestProgressLogText>b__21_1(TheForestOfLove.Narrative.Quest) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.Quest::progressLogEntries
IL_0006: ldsfld System.Comparison`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__21_3
IL_000b: dup
IL_000c: brtrue.s IL_0025
IL_000e: pop
IL_000f: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_0014: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateQuestProgressLogText>b__21_3(TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_001a: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::.ctor(System.Object,System.IntPtr)
IL_001f: dup
IL_0020: stsfld System.Comparison`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__21_3
IL_0025: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::Sort(System.Comparison`1<!0>)
IL_002a: ret
METHOD System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateQuestProgressLogText>b__21_3(TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldflda System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_0006: ldarg.2
IL_0007: ldfld System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_000c: call System.Int32 System.Int32::CompareTo(System.Int32)
IL_0011: ret
METHOD System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateQuestProgressLogText>b__21_2(TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldflda System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_0006: ldarg.2
IL_0007: ldfld System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_000c: call System.Int32 System.Int32::CompareTo(System.Int32)
IL_0011: ret
