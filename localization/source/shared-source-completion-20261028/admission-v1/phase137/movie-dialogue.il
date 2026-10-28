TYPE TheForestOfLove.MovieDialogueManager
METHOD System.Void TheForestOfLove.MovieDialogueManager::StartDialogue(System.String,System.String,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: ldarg.3
IL_0004: ldnull
IL_0005: call System.Void TheForestOfLove.MovieDialogueManager::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_000a: ret
METHOD System.Void TheForestOfLove.MovieDialogueManager::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.MovieDialogueManager::get_dialogueStarted()
IL_0006: brtrue.s IL_0010
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean TheForestOfLove.MovieDialogueManager::preventAllDialogue
IL_000e: brfalse.s IL_0011
IL_0010: ret
IL_0011: ldarg.0
IL_0012: ldc.i4.1
IL_0013: call System.Void TheForestOfLove.MovieDialogueManager::set_dialogueStarted(System.Boolean)
IL_0018: ldarg.0
IL_0019: ldc.i4.1
IL_001a: stfld TheForestOfLove.MovieDialogueManager/MovieDialogueManagerInternalState TheForestOfLove.MovieDialogueManager::currentState
IL_001f: ldarg.0
IL_0020: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.MovieDialogueManager::settings
IL_0025: ldarg.1
IL_0026: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::conversationName
IL_002b: ldarg.0
IL_002c: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.MovieDialogueManager::settings
IL_0031: ldarg.2
IL_0032: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::actorName
IL_0037: ldarg.0
IL_0038: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.MovieDialogueManager::settings
IL_003d: ldarg.3
IL_003e: stfld System.String TheForestOfLove.Gameplay.ConversationSettings::dialogueArcName
IL_0043: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.DialogueService>()
IL_0048: ldarg.s overrideDialogueUi
IL_004a: callvirt System.Void TheForestOfLove.Narrative.DialogueService::SetOverrideDialogueUI(PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_004f: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueEndFinishOrCancel
IL_0054: ldarg.0
IL_0055: ldftn System.Void TheForestOfLove.MovieDialogueManager::OnDynamicConversationEnded(TheForestOfLove.Narrative.Dialogue)
IL_005b: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0060: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0065: ldc.i4.0
IL_0066: ldarg.0
IL_0067: ldfld TheForestOfLove.Gameplay.ConversationSettings TheForestOfLove.MovieDialogueManager::settings
IL_006c: call System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.Gameplay.ConversationSettings)
IL_0071: pop
IL_0072: ret
