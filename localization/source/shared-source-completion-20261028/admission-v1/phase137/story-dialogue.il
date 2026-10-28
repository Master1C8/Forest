TYPE TheForestOfLove.GeneralStoryUIController
METHOD System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: ldnull
IL_0004: call System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String)
IL_0009: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: ldarg.3
IL_0004: ldarg.0
IL_0005: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.GeneralStoryUIController::dialogueUi
IL_000a: call System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_000f: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0006: ldarg.1
IL_0007: ldarg.2
IL_0008: ldarg.3
IL_0009: ldarg.s overrideDialogueUi
IL_000b: callvirt System.Void TheForestOfLove.MovieDialogueManager::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0016: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieDialogueManager::onDialogueFinished
IL_001b: ldarg.0
IL_001c: ldftn System.Void TheForestOfLove.GeneralStoryUIController::OnDialogueFinished()
IL_0022: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0027: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_002c: ret
