TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerGossips/<>c
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerGossips/<>c::<ExecuteTrigger>b__2_2() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldstr "rascal_solo_bear_story_enabled"
IL_0005: ldstr "true"
IL_000a: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_000f: ldstr "Gossip_Beaver_DateSomeBears2"
IL_0014: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0019: ldstr "time_passes"
IL_001e: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0023: ldstr "Bucky"
IL_0028: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_002d: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0032: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0037: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_003c: ret
