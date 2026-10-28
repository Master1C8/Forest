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
TYPE TheForestOfLove.MouseOrgyMovie
METHOD System.Void TheForestOfLove.MouseOrgyMovie::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_000c: ldc.i4.1
IL_000d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_SuppressShowFinalImageByItselfAfterDialogue(System.Boolean)
IL_0012: ldarg.0
IL_0013: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0018: ldarg.0
IL_0019: ldftn System.Boolean TheForestOfLove.MouseOrgyMovie::AdvanceMovie_CustomHandler()
IL_001f: newobj System.Void System.Func`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0024: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_AdvanceMovieCustomHandler(System.Func`1<System.Boolean>)
IL_0029: ldarg.0
IL_002a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_002f: ldarg.0
IL_0030: ldftn System.Boolean TheForestOfLove.MouseOrgyMovie::DialogueFinished_CustomHandler()
IL_0036: newobj System.Void System.Func`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_003b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_DialogueFinishedCustomHandler(System.Func`1<System.Boolean>)
IL_0040: ldarg.0
IL_0041: call System.Boolean TheForestOfLove.MouseOrgyMovie::IsNoDialogue()
IL_0046: brfalse.s IL_0056
IL_0048: ldarg.0
IL_0049: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_004e: ldc.i4.1
IL_004f: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_StateCount(System.Int32)
IL_0054: br.s IL_0063
IL_0056: ldarg.0
IL_0057: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_005c: ldc.i4.s 14
IL_005e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_StateCount(System.Int32)
IL_0063: ldarg.0
IL_0064: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MovieDialogueManager>()
IL_0069: stfld TheForestOfLove.MovieDialogueManager TheForestOfLove.MouseOrgyMovie::movieDialogueManager
IL_006e: ldarg.0
IL_006f: ldarg.0
IL_0070: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.MovieWrapper>()
IL_0075: stfld TheForestOfLove.MovieWrapper TheForestOfLove.MouseOrgyMovie::movieWrapper
IL_007a: ldarg.0
IL_007b: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.MouseOrgyMovie::movieDialogueManager
IL_0080: ldnull
IL_0081: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0086: brfalse.s IL_0093
IL_0088: ldarg.0
IL_0089: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.MouseOrgyMovie::movieDialogueManager
IL_008e: callvirt System.Void TheForestOfLove.MovieDialogueManager::DelayUntilLater()
IL_0093: ldarg.0
IL_0094: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_CunnlingusMice
IL_0099: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_009e: ldarg.0
IL_009f: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop1Long
IL_00a4: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_00a9: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_00ae: pop
IL_00af: ldarg.0
IL_00b0: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_CunnlingusMice
IL_00b5: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_00ba: ldarg.0
IL_00bb: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop1Short
IL_00c0: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_00c5: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_00ca: pop
IL_00cb: ldarg.0
IL_00cc: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_CunnlingusMice
IL_00d1: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_00d6: ldarg.0
IL_00d7: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop2Long
IL_00dc: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_00e1: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_00e6: pop
IL_00e7: ldarg.0
IL_00e8: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_CunnlingusMice
IL_00ed: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_00f2: ldarg.0
IL_00f3: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop2Short
IL_00f8: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_00fd: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0102: pop
IL_0103: ldarg.0
IL_0104: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_CunnlingusMice
IL_0109: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_010e: ldarg.0
IL_010f: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop3
IL_0114: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0119: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_011e: pop
IL_011f: ldarg.0
IL_0120: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_CunnlingusMice
IL_0125: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_012a: ldarg.0
IL_012b: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Transition1
IL_0130: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0135: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_013a: pop
IL_013b: ldarg.0
IL_013c: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_CunnlingusMice
IL_0141: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0146: ldarg.0
IL_0147: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Transition2
IL_014c: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0151: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0156: pop
IL_0157: ldarg.0
IL_0158: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_CunnlingusMice
IL_015d: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0162: ldarg.0
IL_0163: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Transition3
IL_0168: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_016d: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0172: pop
IL_0173: ldarg.0
IL_0174: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_FootlickRat
IL_0179: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_017e: ldarg.0
IL_017f: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Loop1
IL_0184: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0189: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_018e: pop
IL_018f: ldarg.0
IL_0190: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_FootlickRat
IL_0195: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_019a: ldarg.0
IL_019b: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Loop2
IL_01a0: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_01a5: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_01aa: pop
IL_01ab: ldarg.0
IL_01ac: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_FootlickRat
IL_01b1: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_01b6: ldarg.0
IL_01b7: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Transition1
IL_01bc: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_01c1: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_01c6: pop
IL_01c7: ldarg.0
IL_01c8: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_FootlickRat
IL_01cd: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_01d2: ldarg.0
IL_01d3: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Transition2
IL_01d8: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_01dd: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_01e2: pop
IL_01e3: ldarg.0
IL_01e4: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_FrontBJ_Mice
IL_01e9: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_01ee: ldarg.0
IL_01ef: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Loop1
IL_01f4: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_01f9: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_01fe: pop
IL_01ff: ldarg.0
IL_0200: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_FrontBJ_Mice
IL_0205: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_020a: ldarg.0
IL_020b: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Loop2
IL_0210: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0215: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_021a: pop
IL_021b: ldarg.0
IL_021c: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_FrontBJ_Mice
IL_0221: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0226: ldarg.0
IL_0227: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Loop3
IL_022c: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0231: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0236: pop
IL_0237: ldarg.0
IL_0238: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_FrontBJ_Mice
IL_023d: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0242: ldarg.0
IL_0243: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Transition1
IL_0248: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_024d: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0252: pop
IL_0253: ldarg.0
IL_0254: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_FrontBJ_Mice
IL_0259: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_025e: ldarg.0
IL_025f: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Transition2
IL_0264: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0269: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_026e: pop
IL_026f: ldarg.0
IL_0270: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_FrontBJ_Mice
IL_0275: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_027a: ldarg.0
IL_027b: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Transition3
IL_0280: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0285: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_028a: pop
IL_028b: ldarg.0
IL_028c: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Bot
IL_0291: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0296: ldarg.0
IL_0297: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Bot_Loop1
IL_029c: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_02a1: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_02a6: pop
IL_02a7: ldarg.0
IL_02a8: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Bot
IL_02ad: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_02b2: ldarg.0
IL_02b3: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Bot_Loop2
IL_02b8: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_02bd: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_02c2: pop
IL_02c3: ldarg.0
IL_02c4: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Bot
IL_02c9: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_02ce: ldarg.0
IL_02cf: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Bot_Transition1
IL_02d4: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_02d9: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_02de: pop
IL_02df: ldarg.0
IL_02e0: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Bot
IL_02e5: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_02ea: ldarg.0
IL_02eb: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Bot_Transition2
IL_02f0: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_02f5: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_02fa: pop
IL_02fb: ldarg.0
IL_02fc: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Mid
IL_0301: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0306: ldarg.0
IL_0307: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Mid_Loop1
IL_030c: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0311: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0316: pop
IL_0317: ldarg.0
IL_0318: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Mid
IL_031d: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0322: ldarg.0
IL_0323: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Mid_Loop2
IL_0328: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_032d: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0332: pop
IL_0333: ldarg.0
IL_0334: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Mid
IL_0339: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_033e: ldarg.0
IL_033f: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Mid_Transition1
IL_0344: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0349: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_034e: pop
IL_034f: ldarg.0
IL_0350: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Mid
IL_0355: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_035a: ldarg.0
IL_035b: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Mid_Transition2
IL_0360: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0365: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_036a: pop
IL_036b: ldarg.0
IL_036c: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Top
IL_0371: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0376: ldarg.0
IL_0377: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Top_Loop1
IL_037c: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0381: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0386: pop
IL_0387: ldarg.0
IL_0388: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Top
IL_038d: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0392: ldarg.0
IL_0393: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Top_Loop2
IL_0398: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_039d: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_03a2: pop
IL_03a3: ldarg.0
IL_03a4: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Top
IL_03a9: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_03ae: ldarg.0
IL_03af: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Top_Transition1
IL_03b4: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_03b9: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_03be: pop
IL_03bf: ldarg.0
IL_03c0: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalAndMice_Top
IL_03c5: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_03ca: ldarg.0
IL_03cb: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Top_Transition2
IL_03d0: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_03d5: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_03da: pop
IL_03db: ldarg.0
IL_03dc: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalTail_Bot
IL_03e1: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_03e6: ldarg.0
IL_03e7: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalTail_EE_Bot_Loop1
IL_03ec: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_03f1: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_03f6: pop
IL_03f7: ldarg.0
IL_03f8: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalTail_Mid
IL_03fd: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0402: ldarg.0
IL_0403: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalTail_EE_Mid_Loop1
IL_0408: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_040d: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0412: pop
IL_0413: ldarg.0
IL_0414: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RascalTail_Top
IL_0419: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_041e: ldarg.0
IL_041f: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalTail_EE_Top_Loop1
IL_0424: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0429: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_042e: pop
IL_042f: ldarg.0
IL_0430: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RearMiceFull
IL_0435: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_043a: ldarg.0
IL_043b: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Loop1
IL_0440: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0445: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_044a: pop
IL_044b: ldarg.0
IL_044c: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RearMiceFull
IL_0451: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0456: ldarg.0
IL_0457: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Loop2
IL_045c: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0461: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0466: pop
IL_0467: ldarg.0
IL_0468: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RearMiceFull
IL_046d: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_0472: ldarg.0
IL_0473: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Transition1
IL_0478: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_047d: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_0482: pop
IL_0483: ldarg.0
IL_0484: ldfld Animancer.AnimancerComponent TheForestOfLove.MouseOrgyMovie::Animator_RearMiceFull
IL_0489: callvirt Animancer.AnimancerPlayable/StateDictionary Animancer.AnimancerComponent::get_States()
IL_048e: ldarg.0
IL_048f: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Transition2
IL_0494: callvirt UnityEngine.AnimationClip Animancer.ClipTransition::get_Clip()
IL_0499: callvirt Animancer.ClipState Animancer.AnimancerPlayable/StateDictionary::Create(UnityEngine.AnimationClip)
IL_049e: pop
IL_049f: ldarg.0
IL_04a0: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop1Long
IL_04a5: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_04aa: dup
IL_04ab: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_04b0: ldarg.0
IL_04b1: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnCunnlingusMiceClipEnd()
IL_04b7: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_04bc: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_04c1: castclass System.Action
IL_04c6: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_04cb: ldarg.0
IL_04cc: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop1Short
IL_04d1: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_04d6: dup
IL_04d7: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_04dc: ldarg.0
IL_04dd: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnCunnlingusMiceClipEnd()
IL_04e3: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_04e8: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_04ed: castclass System.Action
IL_04f2: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_04f7: ldarg.0
IL_04f8: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop2Long
IL_04fd: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_0502: dup
IL_0503: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_0508: ldarg.0
IL_0509: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnCunnlingusMiceClipEnd()
IL_050f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0514: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0519: castclass System.Action
IL_051e: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_0523: ldarg.0
IL_0524: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop2Short
IL_0529: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_052e: dup
IL_052f: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_0534: ldarg.0
IL_0535: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnCunnlingusMiceClipEnd()
IL_053b: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0540: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0545: castclass System.Action
IL_054a: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_054f: ldarg.0
IL_0550: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop3
IL_0555: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_055a: dup
IL_055b: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_0560: ldarg.0
IL_0561: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnCunnlingusMiceClipEnd()
IL_0567: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_056c: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0571: castclass System.Action
IL_0576: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_057b: ldarg.0
IL_057c: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Transition1
IL_0581: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_0586: dup
IL_0587: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_058c: ldarg.0
IL_058d: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnCunnlingusMiceClipEnd()
IL_0593: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0598: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_059d: castclass System.Action
IL_05a2: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_05a7: ldarg.0
IL_05a8: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Transition2
IL_05ad: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_05b2: dup
IL_05b3: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_05b8: ldarg.0
IL_05b9: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnCunnlingusMiceClipEnd()
IL_05bf: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_05c4: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_05c9: castclass System.Action
IL_05ce: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_05d3: ldarg.0
IL_05d4: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Transition3
IL_05d9: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_05de: dup
IL_05df: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_05e4: ldarg.0
IL_05e5: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnCunnlingusMiceClipEnd()
IL_05eb: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_05f0: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_05f5: castclass System.Action
IL_05fa: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_05ff: ldarg.0
IL_0600: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Loop1
IL_0605: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_060a: dup
IL_060b: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_0610: ldarg.0
IL_0611: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnFootlickRatClipEnd()
IL_0617: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_061c: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0621: castclass System.Action
IL_0626: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_062b: ldarg.0
IL_062c: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Loop2
IL_0631: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_0636: dup
IL_0637: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_063c: ldarg.0
IL_063d: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnFootlickRatClipEnd()
IL_0643: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0648: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_064d: castclass System.Action
IL_0652: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_0657: ldarg.0
IL_0658: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Transition1
IL_065d: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_0662: dup
IL_0663: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_0668: ldarg.0
IL_0669: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnFootlickRatClipEnd()
IL_066f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0674: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0679: castclass System.Action
IL_067e: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_0683: ldarg.0
IL_0684: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Transition2
IL_0689: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_068e: dup
IL_068f: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_0694: ldarg.0
IL_0695: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnFootlickRatClipEnd()
IL_069b: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_06a0: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_06a5: castclass System.Action
IL_06aa: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_06af: ldarg.0
IL_06b0: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Loop1
IL_06b5: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_06ba: dup
IL_06bb: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_06c0: ldarg.0
IL_06c1: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnFrontBJ_Mice_ClipEnd()
IL_06c7: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_06cc: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_06d1: castclass System.Action
IL_06d6: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_06db: ldarg.0
IL_06dc: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Loop2
IL_06e1: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_06e6: dup
IL_06e7: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_06ec: ldarg.0
IL_06ed: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnFrontBJ_Mice_ClipEnd()
IL_06f3: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_06f8: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_06fd: castclass System.Action
IL_0702: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_0707: ldarg.0
IL_0708: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Loop3
IL_070d: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_0712: dup
IL_0713: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_0718: ldarg.0
IL_0719: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnFrontBJ_Mice_ClipEnd()
IL_071f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0724: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0729: castclass System.Action
IL_072e: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_0733: ldarg.0
IL_0734: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Transition1
IL_0739: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_073e: dup
IL_073f: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_0744: ldarg.0
IL_0745: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnFrontBJ_Mice_ClipEnd()
IL_074b: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0750: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0755: castclass System.Action
IL_075a: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_075f: ldarg.0
IL_0760: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Transition2
IL_0765: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_076a: dup
IL_076b: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_0770: ldarg.0
IL_0771: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnFrontBJ_Mice_ClipEnd()
IL_0777: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_077c: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0781: castclass System.Action
IL_0786: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_078b: ldarg.0
IL_078c: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Transition3
IL_0791: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_0796: dup
IL_0797: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_079c: ldarg.0
IL_079d: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnFrontBJ_Mice_ClipEnd()
IL_07a3: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_07a8: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_07ad: castclass System.Action
IL_07b2: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_07b7: ldarg.0
IL_07b8: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Loop1
IL_07bd: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_07c2: dup
IL_07c3: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_07c8: ldarg.0
IL_07c9: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnRearMiceFullClipEnd()
IL_07cf: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_07d4: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_07d9: castclass System.Action
IL_07de: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_07e3: ldarg.0
IL_07e4: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Loop2
IL_07e9: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_07ee: dup
IL_07ef: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_07f4: ldarg.0
IL_07f5: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnRearMiceFullClipEnd()
IL_07fb: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0800: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0805: castclass System.Action
IL_080a: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_080f: ldarg.0
IL_0810: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Transition1
IL_0815: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_081a: dup
IL_081b: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_0820: ldarg.0
IL_0821: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnRearMiceFullClipEnd()
IL_0827: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_082c: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0831: castclass System.Action
IL_0836: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_083b: ldarg.0
IL_083c: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Transition2
IL_0841: callvirt Animancer.AnimancerEvent/Sequence Animancer.AnimancerTransition`1<Animancer.ClipState>::get_Events()
IL_0846: dup
IL_0847: callvirt System.Action Animancer.AnimancerEvent/Sequence::get_OnEnd()
IL_084c: ldarg.0
IL_084d: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnRearMiceFullClipEnd()
IL_0853: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0858: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_085d: castclass System.Action
IL_0862: callvirt System.Void Animancer.AnimancerEvent/Sequence::set_OnEnd(System.Action)
IL_0867: ldarg.0
IL_0868: ldc.i4.8
IL_0869: newarr System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_086e: dup
IL_086f: ldc.i4.0
IL_0870: ldarg.0
IL_0871: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop1Long
IL_0876: ldc.i4.0
IL_0877: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_087c: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0881: dup
IL_0882: ldc.i4.1
IL_0883: ldarg.0
IL_0884: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop1Short
IL_0889: ldc.i4.0
IL_088a: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_088f: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0894: dup
IL_0895: ldc.i4.2
IL_0896: ldarg.0
IL_0897: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Transition1
IL_089c: ldc.i4.1
IL_089d: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_08a2: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_08a7: dup
IL_08a8: ldc.i4.3
IL_08a9: ldarg.0
IL_08aa: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop2Long
IL_08af: ldc.i4.2
IL_08b0: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_08b5: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_08ba: dup
IL_08bb: ldc.i4.4
IL_08bc: ldarg.0
IL_08bd: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop2Short
IL_08c2: ldc.i4.2
IL_08c3: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_08c8: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_08cd: dup
IL_08ce: ldc.i4.5
IL_08cf: ldarg.0
IL_08d0: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Transition2
IL_08d5: ldc.i4.3
IL_08d6: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_08db: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_08e0: dup
IL_08e1: ldc.i4.6
IL_08e2: ldarg.0
IL_08e3: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Loop3
IL_08e8: ldc.i4.4
IL_08e9: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_08ee: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_08f3: dup
IL_08f4: ldc.i4.7
IL_08f5: ldarg.0
IL_08f6: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::CunnlingusMice_EE_Transition3
IL_08fb: ldc.i4.5
IL_08fc: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0901: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0906: stfld System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>[] TheForestOfLove.MouseOrgyMovie::CunnlingusMiceStateMap
IL_090b: ldarg.0
IL_090c: ldc.i4.4
IL_090d: newarr System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0912: dup
IL_0913: ldc.i4.0
IL_0914: ldarg.0
IL_0915: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Loop1
IL_091a: ldc.i4.0
IL_091b: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0920: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0925: dup
IL_0926: ldc.i4.1
IL_0927: ldarg.0
IL_0928: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Transition1
IL_092d: ldc.i4.1
IL_092e: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0933: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0938: dup
IL_0939: ldc.i4.2
IL_093a: ldarg.0
IL_093b: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Loop2
IL_0940: ldc.i4.2
IL_0941: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0946: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_094b: dup
IL_094c: ldc.i4.3
IL_094d: ldarg.0
IL_094e: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FootlickRat_EE_Transition2
IL_0953: ldc.i4.3
IL_0954: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0959: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_095e: stfld System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>[] TheForestOfLove.MouseOrgyMovie::FootlickRatStateMap
IL_0963: ldarg.0
IL_0964: ldc.i4.6
IL_0965: newarr System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_096a: dup
IL_096b: ldc.i4.0
IL_096c: ldarg.0
IL_096d: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Loop1
IL_0972: ldc.i4.0
IL_0973: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0978: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_097d: dup
IL_097e: ldc.i4.1
IL_097f: ldarg.0
IL_0980: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Transition1
IL_0985: ldc.i4.1
IL_0986: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_098b: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0990: dup
IL_0991: ldc.i4.2
IL_0992: ldarg.0
IL_0993: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Loop2
IL_0998: ldc.i4.2
IL_0999: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_099e: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_09a3: dup
IL_09a4: ldc.i4.3
IL_09a5: ldarg.0
IL_09a6: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Transition2
IL_09ab: ldc.i4.3
IL_09ac: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_09b1: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_09b6: dup
IL_09b7: ldc.i4.4
IL_09b8: ldarg.0
IL_09b9: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Loop3
IL_09be: ldc.i4.4
IL_09bf: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_09c4: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_09c9: dup
IL_09ca: ldc.i4.5
IL_09cb: ldarg.0
IL_09cc: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_EE_Transition3
IL_09d1: ldc.i4.5
IL_09d2: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_09d7: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_09dc: stfld System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>[] TheForestOfLove.MouseOrgyMovie::FrontBJ_Mice_StateMap
IL_09e1: ldarg.0
IL_09e2: ldc.i4.4
IL_09e3: newarr System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_09e8: dup
IL_09e9: ldc.i4.0
IL_09ea: ldarg.0
IL_09eb: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Bot_Loop1
IL_09f0: ldc.i4.0
IL_09f1: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_09f6: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_09fb: dup
IL_09fc: ldc.i4.1
IL_09fd: ldarg.0
IL_09fe: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Bot_Transition1
IL_0a03: ldc.i4.1
IL_0a04: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0a09: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0a0e: dup
IL_0a0f: ldc.i4.2
IL_0a10: ldarg.0
IL_0a11: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Bot_Loop2
IL_0a16: ldc.i4.2
IL_0a17: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0a1c: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0a21: dup
IL_0a22: ldc.i4.3
IL_0a23: ldarg.0
IL_0a24: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RascalAndMice_EE_Bot_Transition2
IL_0a29: ldc.i4.3
IL_0a2a: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0a2f: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0a34: stfld System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>[] TheForestOfLove.MouseOrgyMovie::RascalAndMiceStateMap
IL_0a39: ldarg.0
IL_0a3a: ldc.i4.4
IL_0a3b: newarr System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0a40: dup
IL_0a41: ldc.i4.0
IL_0a42: ldarg.0
IL_0a43: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Loop1
IL_0a48: ldc.i4.0
IL_0a49: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0a4e: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0a53: dup
IL_0a54: ldc.i4.1
IL_0a55: ldarg.0
IL_0a56: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Transition1
IL_0a5b: ldc.i4.1
IL_0a5c: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0a61: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0a66: dup
IL_0a67: ldc.i4.2
IL_0a68: ldarg.0
IL_0a69: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Loop2
IL_0a6e: ldc.i4.2
IL_0a6f: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0a74: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0a79: dup
IL_0a7a: ldc.i4.3
IL_0a7b: ldarg.0
IL_0a7c: ldfld Animancer.ClipTransition TheForestOfLove.MouseOrgyMovie::RearMiceFull_EE_Transition2
IL_0a81: ldc.i4.3
IL_0a82: newobj System.Void System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>::.ctor(!0,!1)
IL_0a87: stelem.any System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>
IL_0a8c: stfld System.ValueTuple`2<Animancer.ClipTransition,TheForestOfLove.MouseOrgyMovie/MouseOrgyAnimationState>[] TheForestOfLove.MouseOrgyMovie::RearMiceFullStateMap
IL_0a91: ret
METHOD System.Void TheForestOfLove.MouseOrgyMovie::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onInitialBlankScreenDialogueMoment
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnAdvanceMoment()
IL_0018: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0028: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_002d: ldarg.0
IL_002e: ldftn System.Void TheForestOfLove.MouseOrgyMovie::OnAdvanceMoment()
IL_0034: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_003e: ret
METHOD System.Boolean TheForestOfLove.MouseOrgyMovie::IsNoDialogue() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0005: brfalse.s IL_0014
IL_0007: ldsfld System.Boolean Globals::allowDialogueInStartMenu
IL_000c: brtrue.s IL_0014
IL_000e: call System.Boolean TheForestOfLove.MainMenuController::get_galleryMenuOpen()
IL_0013: ret
IL_0014: ldc.i4.0
IL_0015: ret
METHOD System.Void TheForestOfLove.MouseOrgyMovie::OnAdvanceMoment() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.MouseOrgyMovie::IsNoDialogue()
IL_0006: brfalse.s IL_000f
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.MouseOrgyMovie::OnAdvanceMoment_NoDialogue()
IL_000e: ret
IL_000f: ldarg.0
IL_0010: call System.Void TheForestOfLove.MouseOrgyMovie::OnAdvanceMoment_Dialogue()
IL_0015: ret
METHOD System.Void TheForestOfLove.MouseOrgyMovie::InitMovie() | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.LetterboxCameraController TheForestOfLove.LetterboxCameraController::current
IL_0005: callvirt System.Void TheForestOfLove.LetterboxCameraController::InstantCinematicMode()
IL_000a: ret
METHOD System.Void TheForestOfLove.MouseOrgyMovie::OnAdvanceMoment_NoDialogue() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.MouseOrgyMovie::InitMovie()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.Transform[] TheForestOfLove.MouseOrgyMovie::Frames
IL_0012: ldc.i4.s 11
IL_0014: ldelem.ref
IL_0015: ldc.i4.1
IL_0016: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_001b: ldarg.0
IL_001c: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0021: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0026: ldarg.0
IL_0027: call System.Void TheForestOfLove.MouseOrgyMovie::InitOrgyAnimation()
IL_002c: ldarg.0
IL_002d: ldc.i4.1
IL_002e: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_0033: ldarg.0
IL_0034: ldc.r4 1.5
IL_0039: ldarg.0
IL_003a: ldftn System.Void TheForestOfLove.MouseOrgyMovie::<OnAdvanceMoment_NoDialogue>b__184_0()
IL_0040: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0045: call System.Void TheForestOfLove.MouseOrgyMovie::SafeTimer(System.Single,System.Action)
IL_004a: ret
METHOD System.Void TheForestOfLove.MouseOrgyMovie::OnAdvanceMoment_Dialogue() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0006: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_000b: brtrue.s IL_0047
IL_000d: ldarg.0
IL_000e: call System.Void TheForestOfLove.MouseOrgyMovie::InitMovie()
IL_0013: ldarg.0
IL_0014: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.MouseOrgyMovie::movieDialogueManager
IL_0019: ldnull
IL_001a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_001f: brfalse.s IL_002c
IL_0021: ldarg.0
IL_0022: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MovieDialogueManager>()
IL_0027: stfld TheForestOfLove.MovieDialogueManager TheForestOfLove.MouseOrgyMovie::movieDialogueManager
IL_002c: ldarg.0
IL_002d: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.MouseOrgyMovie::movieDialogueManager
IL_0032: ldnull
IL_0033: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0038: brfalse.s IL_0061
IL_003a: ldarg.0
IL_003b: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.MouseOrgyMovie::movieDialogueManager
IL_0040: callvirt System.Void TheForestOfLove.MovieDialogueManager::DelayUntilLater()
IL_0045: br.s IL_0061
IL_0047: ldarg.0
IL_0048: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_004d: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0052: ldc.i4.s 11
IL_0054: bne.un.s IL_0061
IL_0056: ldarg.0
IL_0057: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.MouseOrgyMovie::movieDialogueManager
IL_005c: callvirt System.Void TheForestOfLove.MovieDialogueManager::ResetAll()
IL_0061: ldarg.0
IL_0062: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0067: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_006c: stloc.0
IL_006d: ldloc.0
IL_006e: switch IL_00ab,IL_00ab,IL_00ab,IL_00ab,IL_00ab,IL_00ab,IL_00ab,IL_00ab,IL_00ab,IL_00ab,IL_00ab,IL_00d5,IL_012e,IL_0163
IL_00ab: ldarg.0
IL_00ac: ldc.i4.1
IL_00ad: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_00b2: ldarg.0
IL_00b3: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.MouseOrgyMovie::movieWrapper
IL_00b8: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_00bd: ldarg.0
IL_00be: ldc.r4 0.25
IL_00c3: ldarg.0
IL_00c4: ldftn System.Void TheForestOfLove.MouseOrgyMovie::<OnAdvanceMoment_Dialogue>b__185_0()
IL_00ca: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00cf: call System.Void TheForestOfLove.MouseOrgyMovie::SafeTimer(System.Single,System.Action)
IL_00d4: ret
IL_00d5: ldarg.0
IL_00d6: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_00db: ldarg.0
IL_00dc: ldfld UnityEngine.Transform[] TheForestOfLove.MouseOrgyMovie::Frames
IL_00e1: ldarg.0
IL_00e2: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_00e7: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_00ec: ldelem.ref
IL_00ed: ldc.i4.1
IL_00ee: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_00f3: ldarg.0
IL_00f4: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_00f9: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_00fe: ldarg.0
IL_00ff: call System.Void TheForestOfLove.MouseOrgyMovie::InitOrgyAnimation()
IL_0104: ldarg.0
IL_0105: ldc.i4.1
IL_0106: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_010b: ldarg.0
IL_010c: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.MouseOrgyMovie::movieWrapper
IL_0111: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_0116: ldarg.0
IL_0117: ldc.r4 1.5
IL_011c: ldarg.0
IL_011d: ldftn System.Void TheForestOfLove.MouseOrgyMovie::<OnAdvanceMoment_Dialogue>b__185_1()
IL_0123: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0128: call System.Void TheForestOfLove.MouseOrgyMovie::SafeTimer(System.Single,System.Action)
IL_012d: ret
IL_012e: ldarg.0
IL_012f: ldfld TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.MouseOrgyMovie::transitionController
IL_0134: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeToBlack()
IL_0139: ldarg.0
IL_013a: ldc.i4.1
IL_013b: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_0140: ldarg.0
IL_0141: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.MouseOrgyMovie::movieWrapper
IL_0146: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_014b: ldarg.0
IL_014c: ldc.r4 1.25
IL_0151: ldarg.0
IL_0152: ldftn System.Void TheForestOfLove.MouseOrgyMovie::<OnAdvanceMoment_Dialogue>b__185_2()
IL_0158: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_015d: call System.Void TheForestOfLove.MouseOrgyMovie::SafeTimer(System.Single,System.Action)
IL_0162: ret
IL_0163: ldarg.0
IL_0164: ldc.i4.1
IL_0165: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_016a: ldarg.0
IL_016b: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.MouseOrgyMovie::movieWrapper
IL_0170: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_0175: ldarg.0
IL_0176: ldc.r4 0.25
IL_017b: ldarg.0
IL_017c: ldftn System.Void TheForestOfLove.MouseOrgyMovie::<OnAdvanceMoment_Dialogue>b__185_3()
IL_0182: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0187: call System.Void TheForestOfLove.MouseOrgyMovie::SafeTimer(System.Single,System.Action)
IL_018c: ret
METHOD System.Boolean TheForestOfLove.MouseOrgyMovie::DialogueFinished_CustomHandler() | attributes=Private, HideBySig | impl=IL
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
IL_0025: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_002a: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_002f: ldarg.0
IL_0030: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0035: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_StateCount()
IL_003a: bge.s IL_0049
IL_003c: ldarg.0
IL_003d: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.MouseOrgyMovie::movieDialogueManager
IL_0042: callvirt System.Void TheForestOfLove.MovieDialogueManager::ResetAll()
IL_0047: ldc.i4.1
IL_0048: ret
IL_0049: ldc.i4.0
IL_004a: ret
METHOD System.Void TheForestOfLove.MouseOrgyMovie::<OnAdvanceMoment_NoDialogue>b__184_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_0007: ldarg.0
IL_0008: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.MouseOrgyMovie::movieWrapper
IL_000d: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0012: ret
METHOD System.Void TheForestOfLove.MouseOrgyMovie::<OnAdvanceMoment_Dialogue>b__185_1() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::hasPendingDialogue
IL_0007: ldarg.0
IL_0008: ldarg.0
IL_0009: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.MouseOrgyMovie::mainDialogueUi
IL_000e: stfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.MouseOrgyMovie::currentDialogueUi
IL_0013: ldarg.0
IL_0014: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MouseOrgyMovie::storyController
IL_0019: ldstr "Movies_MouseOrgyMovie_Dialogue"
IL_001e: ldstr "Narrator"
IL_0023: ldstr "dialogue"
IL_0028: ldarg.0
IL_0029: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.MouseOrgyMovie::currentDialogueUi
IL_002e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String,PixelCrushers.DialogueSystem.StandardDialogueUI)
IL_0033: ldarg.0
IL_0034: ldc.i4.1
IL_0035: stfld System.Boolean TheForestOfLove.MouseOrgyMovie::canDismissOrgyAnimationAfterDialogue
IL_003a: ret
