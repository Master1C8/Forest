TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c__DisplayClass5_0
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c__DisplayClass5_0::<ExecuteTrigger>b__2() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldstr "Dates_OliverCoyotes_Dialogue2"
IL_0005: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_000a: ldstr "Oliver"
IL_000f: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0014: ldarg.0
IL_0015: ldfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c__DisplayClass5_0::targetDialogueArcName
IL_001a: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_001f: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0024: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0029: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_002e: ret
