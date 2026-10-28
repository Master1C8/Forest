TYPE TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0
METHOD System.Void TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::<OnMovieEnding>b__0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0005: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_000a: ldarg.0
IL_000b: ldfld System.String TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::targetConversationName
IL_0010: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0015: ldarg.0
IL_0016: ldfld System.String TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::targetActorName
IL_001b: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0020: ldarg.0
IL_0021: ldfld System.String TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::targetDialogueArcName
IL_0026: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_002b: ldarg.0
IL_002c: ldfld System.Action TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::postDialogueEvent
IL_0031: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_0036: ldc.i4.1
IL_0037: stsfld System.Boolean TheForestOfLove.QuestConversationHelper::usePreferredDirection
IL_003c: ldc.i4.3
IL_003d: stsfld TheForestOfLove.Direction TheForestOfLove.QuestConversationHelper::preferredPlayerDirection
IL_0042: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0047: ret
