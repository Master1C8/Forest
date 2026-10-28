TYPE TheForestOfLove.OtterShopController/<>c__DisplayClass10_0
METHOD System.Void TheForestOfLove.OtterShopController/<>c__DisplayClass10_0::<AttemptPurchase>b__0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldstr "OtterShop_InitialItems"
IL_0005: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_000a: ldstr "Maverick"
IL_000f: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0014: ldarg.0
IL_0015: ldfld System.Boolean TheForestOfLove.OtterShopController/<>c__DisplayClass10_0::hasEnoughMoney
IL_001a: brtrue.s IL_0023
IL_001c: ldstr "not_enough_money"
IL_0021: br.s IL_0028
IL_0023: ldstr "purchase_complete"
IL_0028: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_002d: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0032: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0037: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_003c: ret
