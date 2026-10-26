TYPE TheForestOfLove.QuestConversationHelper
METHOD System.Void TheForestOfLove.QuestConversationHelper::StartConversation_Internal() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.QuestConversationHelper::ValidateInputs()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call TheForestOfLove.Gameplay.SwapCameraSettingsDuringConversation TheForestOfLove.QuestConversationHelper::get_conversationCameraSettingsSwapper()
IL_000f: ldsfld TheForestOfLove.Cameras.CameraSettings TheForestOfLove.QuestConversationHelper::targetCameraSettings
IL_0014: callvirt System.Void TheForestOfLove.Gameplay.SwapCameraSettingsDuringConversation::set_targetCameraSettings(TheForestOfLove.Cameras.CameraSettings)
IL_0019: ldarg.0
IL_001a: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.QuestConversationHelper::settings
IL_001f: ldsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0024: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::conversationName
IL_0029: ldarg.0
IL_002a: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.QuestConversationHelper::settings
IL_002f: ldsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0034: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::actorName
IL_0039: ldarg.0
IL_003a: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.QuestConversationHelper::settings
IL_003f: ldsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0044: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::dialogueArcName
IL_0049: ldarg.0
IL_004a: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.QuestConversationHelper::settings
IL_004f: ldsfld System.String TheForestOfLove.QuestConversationHelper::preferredConversantActorName
IL_0054: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::preferredConversantName
IL_0059: ldarg.0
IL_005a: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.QuestConversationHelper::settings
IL_005f: ldsfld System.Boolean TheForestOfLove.QuestConversationHelper::usePreferredDirection
IL_0064: stfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::usePreferredPlayerDirection
IL_0069: ldarg.0
IL_006a: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.QuestConversationHelper::settings
IL_006f: ldsfld TheForestOfLove.Direction TheForestOfLove.QuestConversationHelper::preferredPlayerDirection
IL_0074: stfld TheForestOfLove.Direction TheForestOfLove.Gameplay.ConversationSettings::preferredPlayerDirection
IL_0079: ldc.i4.0
IL_007a: ldarg.0
IL_007b: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.QuestConversationHelper::settings
IL_0080: call System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.Gameplay.ConversationSettings)
IL_0085: brtrue.s IL_008e
IL_0087: ldarg.0
IL_0088: ldnull
IL_0089: call System.Void TheForestOfLove.QuestConversationHelper::OnConversationEnd_Handler(TheForestOfLove.Narrative.Dialogue)
IL_008e: ret
METHOD System.Void TheForestOfLove.QuestConversationHelper::StartConversation() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0005: brfalse.s IL_0012
IL_0007: ldstr "QuestConversationHelper - conversation is already started! Did a script call this twice?"
IL_000c: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0011: ret
IL_0012: ldsfld TheForestOfLove.QuestConversationHelper TheForestOfLove.QuestConversationHelper::instance
IL_0017: callvirt System.Void TheForestOfLove.QuestConversationHelper::StartConversation_Internal()
IL_001c: ret
