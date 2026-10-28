TYPE TheForestOfLove.MouseOrgyMovie
METHOD System.Boolean TheForestOfLove.MouseOrgyMovie::AdvanceMovie_CustomHandler() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.MouseOrgyMovie::IsNoDialogue()
IL_0006: brtrue.s IL_0022
IL_0008: ldarg.0
IL_0009: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_000e: callvirt System.Boolean TheForestOfLove.GeneralStoryUIController::get_SkipDialogue()
IL_0013: brtrue.s IL_0022
IL_0015: ldarg.0
IL_0016: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.MouseOrgyMovie::movieDialogueManager
IL_001b: callvirt System.Boolean TheForestOfLove.MovieDialogueManager::get_dialogueDisabled()
IL_0020: brfalse.s IL_0024
IL_0022: ldc.i4.0
IL_0023: ret
IL_0024: ldarg.0
IL_0025: ldfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_002a: brfalse.s IL_002e
IL_002c: ldc.i4.1
IL_002d: ret
IL_002e: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.CustomTypewriterEffectTextMeshPro>()
IL_0033: stloc.0
IL_0034: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0039: brfalse.s IL_0080
IL_003b: ldloc.0
IL_003c: ldnull
IL_003d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0042: brfalse.s IL_0080
IL_0044: ldstr "mouse ceremony movie got stuck in state {0}, unsticking..."
IL_0049: ldarg.0
IL_004a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_004f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0054: box System.Int32
IL_0059: call System.String System.String::Format(System.String,System.Object)
IL_005e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0063: call System.Void TheForestOfLove.Narrative.DialogueService::StopConversation()
IL_0068: ldarg.0
IL_0069: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_006e: ldarg.0
IL_006f: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0074: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0079: callvirt System.Void TheForestOfLove.GeneralStoryUIController::JumpToStateId(System.Int32)
IL_007e: ldc.i4.1
IL_007f: ret
IL_0080: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0085: brfalse.s IL_008e
IL_0087: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_008c: br.s IL_00b7
IL_008e: ldarg.0
IL_008f: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0094: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0099: ldc.i4.s 12
IL_009b: bne.un.s IL_00b7
IL_009d: ldarg.0
IL_009e: ldfld System.Boolean TheForestOfLove.MouseOrgyMovie::canDismissOrgyAnimationAfterDialogue
IL_00a3: brfalse.s IL_00b7
IL_00a5: ldarg.0
IL_00a6: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_00ab: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_00b0: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00b5: ldc.i4.1
IL_00b6: ret
IL_00b7: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_00bc: brtrue.s IL_00f3
IL_00be: ldarg.0
IL_00bf: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_00c4: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_00c9: ldarg.0
IL_00ca: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_00cf: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_StateCount()
IL_00d4: bge.s IL_00f3
IL_00d6: ldarg.0
IL_00d7: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.MouseOrgyMovie::movieWrapper
IL_00dc: callvirt System.Void TheForestOfLove.MovieWrapper::OnChangeTypewriter()
IL_00e1: ldarg.0
IL_00e2: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_00e7: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_00ec: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00f1: ldc.i4.1
IL_00f2: ret
IL_00f3: ldc.i4.0
IL_00f4: ret
METHOD System.Void TheForestOfLove.MouseOrgyMovie::<OnAdvanceMoment_Dialogue>b__185_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_0007: ldarg.0
IL_0008: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.Transform[] TheForestOfLove.MouseOrgyMovie::Frames
IL_0013: ldarg.0
IL_0014: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0019: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_001e: ldelem.ref
IL_001f: ldc.i4.1
IL_0020: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0025: ldarg.0
IL_0026: ldarg.0
IL_0027: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI[] TheForestOfLove.MouseOrgyMovie::dialogueUis
IL_002c: ldarg.0
IL_002d: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0032: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0037: ldelem.ref
IL_0038: stfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.MouseOrgyMovie::currentDialogueUi
IL_003d: ldarg.0
IL_003e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0043: ldstr "Movies_MouseOrgyMovie_Dialogue"
IL_0048: ldstr "Narrator"
IL_004d: ldstr "p{0:D2}"
IL_0052: ldarg.0
IL_0053: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0058: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: box System.Int32
IL_0064: call System.String System.String::Format(System.String,System.Object)
IL_0069: ldarg.0
IL_006a: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.MouseOrgyMovie::currentDialogueUi
IL_006f: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_0074: ldarg.0
IL_0075: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_007a: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_007f: ret
METHOD System.Void TheForestOfLove.MouseOrgyMovie::<OnAdvanceMoment_Dialogue>b__185_2() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_0007: ldarg.0
IL_0008: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.Transform[] TheForestOfLove.MouseOrgyMovie::Frames
IL_0013: ldarg.0
IL_0014: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0019: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_001e: ldelem.ref
IL_001f: ldc.i4.1
IL_0020: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0025: ldarg.0
IL_0026: ldarg.0
IL_0027: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI[] TheForestOfLove.MouseOrgyMovie::dialogueUis
IL_002c: ldarg.0
IL_002d: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0032: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0037: ldelem.ref
IL_0038: stfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.MouseOrgyMovie::currentDialogueUi
IL_003d: ldarg.0
IL_003e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0043: ldstr "Movies_MouseOrgyMovie_Dialogue"
IL_0048: ldstr "Narrator"
IL_004d: ldstr "p{0:D2}"
IL_0052: ldarg.0
IL_0053: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0058: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: box System.Int32
IL_0064: call System.String System.String::Format(System.String,System.Object)
IL_0069: ldarg.0
IL_006a: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.MouseOrgyMovie::currentDialogueUi
IL_006f: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_0074: ldarg.0
IL_0075: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_007a: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_007f: ldarg.0
IL_0080: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.MouseOrgyMovie::movieWrapper
IL_0085: callvirt System.Void TheForestOfLove.MovieWrapper::OnChangeTypewriter()
IL_008a: ret
METHOD System.Void TheForestOfLove.MouseOrgyMovie::<OnAdvanceMoment_Dialogue>b__185_3() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_0007: ldarg.0
IL_0008: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.Transform[] TheForestOfLove.MouseOrgyMovie::Frames
IL_0013: ldarg.0
IL_0014: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0019: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_001e: ldelem.ref
IL_001f: ldc.i4.1
IL_0020: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0025: ldarg.0
IL_0026: ldarg.0
IL_0027: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI[] TheForestOfLove.MouseOrgyMovie::dialogueUis
IL_002c: ldarg.0
IL_002d: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0032: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0037: ldelem.ref
IL_0038: stfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.MouseOrgyMovie::currentDialogueUi
IL_003d: ldarg.0
IL_003e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0043: ldstr "Movies_MouseOrgyMovie_Dialogue"
IL_0048: ldstr "Narrator"
IL_004d: ldstr "p{0:D2}"
IL_0052: ldarg.0
IL_0053: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0058: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: box System.Int32
IL_0064: call System.String System.String::Format(System.String,System.Object)
IL_0069: ldarg.0
IL_006a: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.MouseOrgyMovie::currentDialogueUi
IL_006f: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_0074: ldarg.0
IL_0075: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_007a: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_007f: ret
