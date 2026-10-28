TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<OnBuckyStormQuestMinigameEnded>b__17_1() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: ldc.i4.7
IL_0003: ldc.i4 420
IL_0008: call System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItemType)
IL_000d: sub
IL_000e: stloc.1
IL_000f: ldloc.1
IL_0010: brfalse.s IL_001c
IL_0012: ldloc.1
IL_0013: ldc.i4.1
IL_0014: beq.s IL_0029
IL_0016: ldloc.1
IL_0017: ldc.i4.7
IL_0018: beq.s IL_0031
IL_001a: br.s IL_0039
IL_001c: ldstr "stormquest_page_minigame_none_left"
IL_0021: stloc.0
IL_0022: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::StormQuest_SpawnStuckPage()
IL_0027: br.s IL_003f
IL_0029: ldstr "stormquest_page_minigame_one_left"
IL_002e: stloc.0
IL_002f: br.s IL_003f
IL_0031: ldstr "stormquest_page_minigame_all_left"
IL_0036: stloc.0
IL_0037: br.s IL_003f
IL_0039: ldstr "stormquest_page_minigame_multiple_left"
IL_003e: stloc.0
IL_003f: ldstr "StormQuest_MabelIntoTheStorm"
IL_0044: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0049: ldstr "Mabel"
IL_004e: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0053: ldloc.0
IL_0054: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0059: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_005e: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0063: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0068: ret
