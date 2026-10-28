TYPE TheForestOfLove.Gameplay.DynamicConversationCustomTrigger
METHOD System.Void TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::OnConversationStartCustomHandler() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Int32 TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::timesTriggered
IL_0007: ldarg.0
IL_0008: ldfld System.Int32 TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::maxTimesTriggerable
IL_000d: brfalse.s IL_002c
IL_000f: ldarg.0
IL_0010: ldfld System.Int32 TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::maxTimesTriggerable
IL_0015: ldc.i4.0
IL_0016: ble IL_00fe
IL_001b: ldarg.0
IL_001c: ldfld System.Int32 TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::timesTriggered
IL_0021: ldarg.0
IL_0022: ldfld System.Int32 TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::maxTimesTriggerable
IL_0027: bge IL_00fe
IL_002c: ldarg.0
IL_002d: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0032: ldarg.0
IL_0033: ldfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetActorName
IL_0038: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::actorName
IL_003d: ldarg.0
IL_003e: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0043: ldarg.0
IL_0044: ldfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetConversationName
IL_0049: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::conversationName
IL_004e: ldarg.0
IL_004f: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0054: ldarg.0
IL_0055: ldfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetDialogueArcName
IL_005a: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::dialogueArcName
IL_005f: ldarg.0
IL_0060: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0065: ldarg.0
IL_0066: ldfld System.Boolean TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::ignorePreferredConversantForDialogueBackground
IL_006b: stfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::ignorePreferredConversantForDialogueBackground
IL_0070: ldarg.0
IL_0071: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0076: ldarg.0
IL_0077: ldfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::preferredConversantName
IL_007c: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::preferredConversantName
IL_0081: ldarg.0
IL_0082: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0087: ldarg.0
IL_0088: ldfld TheForestOfLove.Direction TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::preferredPlayerDirection
IL_008d: stfld TheForestOfLove.Direction TheForestOfLove.Gameplay.ConversationSettings::preferredPlayerDirection
IL_0092: ldarg.0
IL_0093: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0098: ldarg.0
IL_0099: ldfld System.Boolean TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::usePreferredDirection
IL_009e: stfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::usePreferredPlayerDirection
IL_00a3: ldarg.0
IL_00a4: ldarg.0
IL_00a5: ldfld TheForestOfLove.Narrative.StoryManager TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::questManager
IL_00aa: ldnull
IL_00ab: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00b0: brtrue.s IL_00c7
IL_00b2: ldarg.0
IL_00b3: ldfld TheForestOfLove.Narrative.StoryManager TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::questManager
IL_00b8: callvirt System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_00bd: brtrue.s IL_00c7
IL_00bf: ldarg.0
IL_00c0: ldfld TheForestOfLove.Narrative.StoryManager TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::questManager
IL_00c5: br.s IL_00cc
IL_00c7: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.Narrative.StoryManager>()
IL_00cc: stfld TheForestOfLove.Narrative.StoryManager TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::questManager
IL_00d1: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_00d6: brtrue.s IL_00e5
IL_00d8: ldc.i4.0
IL_00d9: ldarg.0
IL_00da: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_00df: call System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.Gameplay.ConversationSettings)
IL_00e4: pop
IL_00e5: ldarg.0
IL_00e6: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.Gameplay.DynamicConversationTrigger::onConversationStart_Hook
IL_00eb: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00f0: ldarg.0
IL_00f1: ldarg.0
IL_00f2: ldfld System.Int32 TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::timesTriggered
IL_00f7: ldc.i4.1
IL_00f8: add
IL_00f9: stfld System.Int32 TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::timesTriggered
IL_00fe: ret
METHOD System.Void TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::Fire() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0006: ldarg.0
IL_0007: ldfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetActorName
IL_000c: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::actorName
IL_0011: ldarg.0
IL_0012: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0017: ldarg.0
IL_0018: ldfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetConversationName
IL_001d: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::conversationName
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0028: ldarg.0
IL_0029: ldfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetDialogueArcName
IL_002e: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::dialogueArcName
IL_0033: ldarg.0
IL_0034: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_0039: ldarg.0
IL_003a: ldfld System.Boolean TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::ignorePreferredConversantForDialogueBackground
IL_003f: stfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::ignorePreferredConversantForDialogueBackground
IL_0044: ldarg.0
IL_0045: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_004a: ldarg.0
IL_004b: ldfld System.Int32 TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::maxTimesTriggerable
IL_0050: stfld System.Int32 TheForestOfLove.Gameplay.ConversationSettings::maxTimesTriggerable
IL_0055: ldarg.0
IL_0056: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_005b: ldarg.0
IL_005c: ldfld System.Boolean TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::persistTimesTriggered
IL_0061: stfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::persistTimesTriggered
IL_0066: ldarg.0
IL_0067: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_006c: ldarg.0
IL_006d: ldfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::preferredConversantName
IL_0072: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::preferredConversantName
IL_0077: ldarg.0
IL_0078: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_007d: ldarg.0
IL_007e: ldfld TheForestOfLove.Direction TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::preferredPlayerDirection
IL_0083: stfld TheForestOfLove.Direction TheForestOfLove.Gameplay.ConversationSettings::preferredPlayerDirection
IL_0088: ldarg.0
IL_0089: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_008e: ldarg.0
IL_008f: ldfld PixelCrushers.DialogueSystem.DialogueSystemTriggerEvent TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::triggerEvent
IL_0094: stfld PixelCrushers.DialogueSystem.DialogueSystemTriggerEvent TheForestOfLove.Gameplay.ConversationSettings::triggerEvent
IL_0099: ldarg.0
IL_009a: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_009f: ldarg.0
IL_00a0: ldfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::triggerUniqueId
IL_00a5: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::triggerUniqueId
IL_00aa: ldarg.0
IL_00ab: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_00b0: ldarg.0
IL_00b1: ldfld System.Boolean TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::usePreferredDirection
IL_00b6: stfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::usePreferredPlayerDirection
IL_00bb: ldarg.0
IL_00bc: ldfld TheForestOfLove.Narrative.QuestManagerInteractionMode TheForestOfLove.Gameplay.DynamicConversationTrigger::interactionMode
IL_00c1: ldarg.0
IL_00c2: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.Gameplay.DynamicConversationTrigger::settings
IL_00c7: call System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.Gameplay.ConversationSettings)
IL_00cc: pop
IL_00cd: ret
