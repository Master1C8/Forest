TYPE TheForestOfLove.QuestLog/<>c
METHOD System.Int32 TheForestOfLove.QuestLog/<>c::<RefreshQuestLabels>b__40_0(TheForestOfLove.QuestLog/QuestLabel,TheForestOfLove.QuestLog/QuestLabel) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_0006: ldflda System.Int32 TheForestOfLove.Narrative.Quest::priority
IL_000b: ldarg.1
IL_000c: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_0011: ldfld System.Int32 TheForestOfLove.Narrative.Quest::priority
IL_0016: call System.Int32 System.Int32::CompareTo(System.Int32)
IL_001b: ret
METHOD System.Int32 TheForestOfLove.QuestLog/<>c::<RefreshQuestLabels>b__40_1(TheForestOfLove.QuestLog/QuestLabel,TheForestOfLove.QuestLog/QuestLabel) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_0006: ldflda System.Int32 TheForestOfLove.Narrative.Quest::priority
IL_000b: ldarg.1
IL_000c: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_0011: ldfld System.Int32 TheForestOfLove.Narrative.Quest::priority
IL_0016: call System.Int32 System.Int32::CompareTo(System.Int32)
IL_001b: ret
