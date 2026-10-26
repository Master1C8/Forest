TYPE TheForestOfLove.TutorialQuestBunnyIntroduction
METHOD System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Start()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::HideAll()
IL_000c: ldarg.0
IL_000d: ldfld TheForestOfLove.Gameplay.SwapCameraSettingsDuringDialogue TheForestOfLove.TutorialQuestBunnyIntroduction::swapCameraSettings
IL_0012: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.Gameplay.SwapCameraSettingsDuringDialogue::onCameraSettingsUnswapped
IL_0017: ldarg.0
IL_0018: ldftn System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Cleanup()
IL_001e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0023: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0028: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0032: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0037: callvirt System.Void TheForestOfLove.Player::RestInstantly()
IL_003c: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0041: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0046: ldc.i4.3
IL_0047: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_004c: ldc.r4 1
IL_0051: ldarg.0
IL_0052: ldftn System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::StartCutsceneConversation()
IL_0058: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_005d: call System.Void TheForestOfLove.CutsceneManager::FadeFromBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0062: ret
METHOD System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::RegisterServices()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RegisterServices()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.ServiceLocator::Register<TheForestOfLove.TutorialQuestBunnyIntroduction>(T)
IL_000c: ret
METHOD System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Show_TurnInQuest()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::HideAll()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.TutorialQuestBunnyIntroduction::turnInQuest
IL_000c: ldc.i4.1
IL_000d: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::SetPlayerIsClose(System.Boolean)
IL_0012: ldarg.0
IL_0013: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.TutorialQuestBunnyIntroduction::turnInQuest
IL_0018: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::Show()
IL_001d: ret
METHOD System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Show_NewQuestAvailable()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::HideAll()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.TutorialQuestBunnyIntroduction::newQuestAvailable
IL_000c: ldc.i4.1
IL_000d: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::SetPlayerIsClose(System.Boolean)
IL_0012: ldarg.0
IL_0013: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.TutorialQuestBunnyIntroduction::newQuestAvailable
IL_0018: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::Show()
IL_001d: ret
METHOD System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Show_RepromptQuest()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::HideAll()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.TutorialQuestBunnyIntroduction::repromptQuest
IL_000c: ldc.i4.1
IL_000d: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::SetPlayerIsClose(System.Boolean)
IL_0012: ldarg.0
IL_0013: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.TutorialQuestBunnyIntroduction::repromptQuest
IL_0018: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::Show()
IL_001d: ret
METHOD System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Show_ContinueTopic()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::HideAll()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.TutorialQuestBunnyIntroduction::continueTopic
IL_000c: ldc.i4.1
IL_000d: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::SetPlayerIsClose(System.Boolean)
IL_0012: ldarg.0
IL_0013: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.TutorialQuestBunnyIntroduction::continueTopic
IL_0018: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::Show()
IL_001d: ret
METHOD System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::StartCutsceneConversation()
IL_0000: ldstr "TutorialQuest_IntroFromBunny"
IL_0005: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_000a: ldstr "Scarlett"
IL_000f: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0014: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0019: ret
METHOD System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Cleanup()
IL_0000: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0005: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_000a: ldarg.0
IL_000b: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0010: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0015: ret
