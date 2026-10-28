TYPE TheForestOfLove.FastTravelAnimation
METHOD System.Void TheForestOfLove.FastTravelAnimation::ConfigureCutsceneConversation() | attributes=Private, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_0005: ldarg.0
IL_0006: ldflda System.String TheForestOfLove.FastTravelAnimation::targetConversationName
IL_000b: ldarg.0
IL_000c: ldflda System.String TheForestOfLove.FastTravelAnimation::targetActorName
IL_0011: ldarg.0
IL_0012: ldflda System.String TheForestOfLove.FastTravelAnimation::targetDialogueArcName
IL_0017: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::StartInflightDialogue(System.String&,System.String&,System.String&)
IL_001c: ldarg.0
IL_001d: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.FastTravelAnimation::dialogueHelper
IL_0022: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieDialogueManager::onDialogueFinished
IL_0027: ldarg.0
IL_0028: ldftn System.Void TheForestOfLove.FastTravelAnimation::OnDialogueFinished()
IL_002e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0033: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0038: ret
