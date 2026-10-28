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
TYPE TheForestOfLove.GeneralStoryUIController
METHOD System.Boolean TheForestOfLove.GeneralStoryUIController::get_SkipDialogue() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0005: brfalse.s IL_0014
IL_0007: ldsfld System.Boolean Globals::allowDialogueInStartMenu
IL_000c: brtrue.s IL_0014
IL_000e: call System.Boolean TheForestOfLove.MainMenuController::get_galleryMenuOpen()
IL_0013: ret
IL_0014: ldc.i4.0
IL_0015: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MovieDialogueManager>()
IL_000c: stfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0011: ldarg.0
IL_0012: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0017: ldnull
IL_0018: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001d: brfalse.s IL_002a
IL_001f: ldarg.0
IL_0020: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0025: callvirt System.Void TheForestOfLove.MovieDialogueManager::ResetAll()
IL_002a: ldarg.0
IL_002b: ldarg.0
IL_002c: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.MovieWrapper>()
IL_0031: stfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_0036: ldarg.0
IL_0037: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_003c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieWrapper::onSceneStarted
IL_0041: ldarg.0
IL_0042: ldftn System.Void TheForestOfLove.GeneralStoryUIController::OnSceneStarted()
IL_0048: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_004d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0052: ldarg.0
IL_0053: ldarg.0
IL_0054: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0059: stfld UnityEngine.Animator TheForestOfLove.GeneralStoryUIController::movieAnimator
IL_005e: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_000c: ldnull
IL_000d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0012: brfalse.s IL_0038
IL_0014: ldarg.0
IL_0015: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MovieDialogueManager>()
IL_001a: stfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_001f: ldarg.0
IL_0020: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0025: ldnull
IL_0026: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_002b: brfalse.s IL_0038
IL_002d: ldarg.0
IL_002e: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0033: callvirt System.Void TheForestOfLove.MovieDialogueManager::ResetAll()
IL_0038: ldarg.0
IL_0039: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_003e: ldarg.0
IL_003f: ldfld System.Single TheForestOfLove.GeneralStoryUIController::fadeInSeconds
IL_0044: callvirt System.Void TheForestOfLove.MovieWrapper::set_fadeSeconds(System.Single)
IL_0049: ldarg.0
IL_004a: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_004f: callvirt System.Void TheForestOfLove.MovieWrapper::MovieCanStart()
IL_0054: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginDetailed
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.GeneralStoryUIController::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_001c: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::OnSceneStarted() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.GeneralStoryUIController::get_SkipDialogue()
IL_0006: brfalse.s IL_001a
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.GeneralStoryUIController::OnDialogueFinished()
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_0014: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0019: ret
IL_001a: ldc.r4 1
IL_001f: ldarg.0
IL_0020: ldftn System.Void TheForestOfLove.GeneralStoryUIController::<OnSceneStarted>b__62_0()
IL_0026: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_002b: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0030: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::OnDialogueFinished() | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Globals::isDialogueSkip
IL_0005: brfalse.s IL_000e
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.GeneralStoryUIController::EndMovie()
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0014: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.MovieDialogueManager::onDialogueFinished
IL_0019: ldarg.0
IL_001a: ldftn System.Void TheForestOfLove.GeneralStoryUIController::OnDialogueFinished()
IL_0020: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0025: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_002a: ldarg.0
IL_002b: call System.Func`1<System.Boolean> TheForestOfLove.GeneralStoryUIController::get_DialogueFinishedCustomHandler()
IL_0030: brfalse.s IL_0040
IL_0032: ldarg.0
IL_0033: call System.Func`1<System.Boolean> TheForestOfLove.GeneralStoryUIController::get_DialogueFinishedCustomHandler()
IL_0038: callvirt !0 System.Func`1<System.Boolean>::Invoke()
IL_003d: brfalse.s IL_0040
IL_003f: ret
IL_0040: ldarg.0
IL_0041: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0046: callvirt System.Void TheForestOfLove.MovieDialogueManager::ResetAll()
IL_004b: ldarg.0
IL_004c: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_0051: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0056: ldarg.0
IL_0057: call System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_005c: ldarg.0
IL_005d: call System.Int32 TheForestOfLove.GeneralStoryUIController::get_StateCount()
IL_0062: blt.s IL_0073
IL_0064: ldarg.0
IL_0065: call System.Boolean TheForestOfLove.GeneralStoryUIController::get_SuppressShowFinalImageByItselfAfterDialogue()
IL_006a: brtrue.s IL_0073
IL_006c: ldarg.0
IL_006d: ldc.i4.1
IL_006e: stfld System.Boolean TheForestOfLove.GeneralStoryUIController::showCurrentImageAgainNoTransition
IL_0073: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::AdvanceMovie() | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Single TheForestOfLove.GeneralStoryUIController::timeSinceLastAdvance
IL_0006: ldc.r4 0.25
IL_000b: bge.un.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldc.r4 0
IL_0014: stfld System.Single TheForestOfLove.GeneralStoryUIController::timeSinceLastAdvance
IL_0019: ldarg.0
IL_001a: call System.Func`1<System.Boolean> TheForestOfLove.GeneralStoryUIController::get_AdvanceMovieCustomHandler()
IL_001f: brfalse.s IL_002f
IL_0021: ldarg.0
IL_0022: call System.Func`1<System.Boolean> TheForestOfLove.GeneralStoryUIController::get_AdvanceMovieCustomHandler()
IL_0027: callvirt !0 System.Func`1<System.Boolean>::Invoke()
IL_002c: brfalse.s IL_002f
IL_002e: ret
IL_002f: ldarg.0
IL_0030: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0035: callvirt System.Boolean TheForestOfLove.MovieDialogueManager::get_dialogueStarted()
IL_003a: brfalse.s IL_0055
IL_003c: ldarg.0
IL_003d: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0042: callvirt System.Boolean TheForestOfLove.MovieDialogueManager::get_dialogueFinished()
IL_0047: brtrue.s IL_0055
IL_0049: ldarg.0
IL_004a: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_004f: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0054: ret
IL_0055: ldarg.0
IL_0056: ldfld System.Boolean TheForestOfLove.GeneralStoryUIController::showCurrentImageAgainNoTransition
IL_005b: brfalse.s IL_0086
IL_005d: ldarg.0
IL_005e: ldc.i4.0
IL_005f: stfld System.Boolean TheForestOfLove.GeneralStoryUIController::showCurrentImageAgainNoTransition
IL_0064: ldarg.0
IL_0065: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_006a: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_006f: ldc.r4 1
IL_0074: ldarg.0
IL_0075: ldftn System.Void TheForestOfLove.GeneralStoryUIController::<AdvanceMovie>b__67_0()
IL_007b: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0080: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0085: ret
IL_0086: ldarg.0
IL_0087: call System.Boolean TheForestOfLove.GeneralStoryUIController::get_SkipDialogue()
IL_008c: brtrue.s IL_009b
IL_008e: ldarg.0
IL_008f: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_0094: callvirt System.Boolean TheForestOfLove.MovieDialogueManager::get_dialogueWillBeLater()
IL_0099: brfalse.s IL_00d6
IL_009b: ldarg.0
IL_009c: call System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_00a1: ldarg.0
IL_00a2: call System.Int32 TheForestOfLove.GeneralStoryUIController::get_StateCount()
IL_00a7: bge.s IL_00d6
IL_00a9: ldarg.0
IL_00aa: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_00af: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_00b4: ldarg.0
IL_00b5: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_00ba: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00bf: ldc.r4 1
IL_00c4: ldarg.0
IL_00c5: ldftn System.Void TheForestOfLove.GeneralStoryUIController::<AdvanceMovie>b__67_1()
IL_00cb: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00d0: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00d5: ret
IL_00d6: ldarg.0
IL_00d7: ldfld TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::movieDialogueManager
IL_00dc: callvirt System.Boolean TheForestOfLove.MovieDialogueManager::get_dialoguePlaying()
IL_00e1: brtrue.s IL_00f6
IL_00e3: ldarg.0
IL_00e4: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_00e9: callvirt System.Boolean TheForestOfLove.MovieWrapper::get_isNextButtonVisible()
IL_00ee: brfalse.s IL_00f6
IL_00f0: ldarg.0
IL_00f1: call System.Void TheForestOfLove.GeneralStoryUIController::EndMovie()
IL_00f6: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::EndMovie() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_0006: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_000b: ldarg.0
IL_000c: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_0011: callvirt System.Void TheForestOfLove.MovieWrapper::PlayOutro()
IL_0016: ldarg.0
IL_0017: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_001c: ldarg.0
IL_001d: ldfld System.Single TheForestOfLove.GeneralStoryUIController::fadeOutSeconds
IL_0022: callvirt System.Void TheForestOfLove.MovieWrapper::set_fadeSeconds(System.Single)
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onMovieEnding
IL_002d: dup
IL_002e: brtrue.s IL_0032
IL_0030: pop
IL_0031: ret
IL_0032: call System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0037: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_0006: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_000b: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: ldloc.0
IL_0009: ldc.i4.1
IL_000a: add
IL_000b: call System.Void TheForestOfLove.GeneralStoryUIController::set_CurrentStateId(System.Int32)
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::transitionController
IL_0016: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromBlack()
IL_001b: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: ldloc.0
IL_0009: ldc.i4.1
IL_000a: add
IL_000b: call System.Void TheForestOfLove.GeneralStoryUIController::set_CurrentStateId(System.Int32)
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::transitionController
IL_0016: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromWhite()
IL_001b: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: ldloc.0
IL_0009: ldc.i4.1
IL_000a: add
IL_000b: call System.Void TheForestOfLove.GeneralStoryUIController::set_CurrentStateId(System.Int32)
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::transitionController
IL_0016: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeToBlack()
IL_001b: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::Advance_Manual() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: ldloc.0
IL_0009: ldc.i4.1
IL_000a: add
IL_000b: call System.Void TheForestOfLove.GeneralStoryUIController::set_CurrentStateId(System.Int32)
IL_0010: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Image TheForestOfLove.GeneralStoryUIController::artworkPlaceholder
IL_0006: ldc.i4.1
IL_0007: callvirt System.Void UnityEngine.Behaviour::set_enabled(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.UI.Image TheForestOfLove.GeneralStoryUIController::artworkPlaceholder
IL_0012: ldarg.1
IL_0013: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.UI.Image TheForestOfLove.GeneralStoryUIController::artworkPlaceholder
IL_001e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0023: callvirt System.Collections.IEnumerator UnityEngine.Transform::GetEnumerator()
IL_0028: stloc.0
IL_0029: br.s IL_0041
IL_002b: ldloc.0
IL_002c: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_0031: castclass UnityEngine.Transform
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.Transform TheForestOfLove.GeneralStoryUIController::hiddenContent
IL_003c: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0041: ldloc.0
IL_0042: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0047: brtrue.s IL_002b
IL_0049: leave.s IL_005c
IL_004b: ldloc.0
IL_004c: isinst System.IDisposable
IL_0051: stloc.1
IL_0052: ldloc.1
IL_0053: brfalse.s IL_005b
IL_0055: ldloc.1
IL_0056: callvirt System.Void System.IDisposable::Dispose()
IL_005b: endfinally
IL_005c: ldarg.2
IL_005d: ldc.r4 0
IL_0062: bne.un.s IL_006c
IL_0064: ldarg.3
IL_0065: ldc.r4 0
IL_006a: beq.s IL_0090
IL_006c: ldarg.0
IL_006d: ldfld UnityEngine.UI.Image TheForestOfLove.GeneralStoryUIController::artworkPlaceholder
IL_0072: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.RectTransform>()
IL_0077: stloc.2
IL_0078: ldloc.2
IL_0079: ldarg.2
IL_007a: ldarg.3
IL_007b: ldloc.2
IL_007c: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_0081: ldfld System.Single UnityEngine.Vector3::z
IL_0086: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_008b: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_0090: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Image TheForestOfLove.GeneralStoryUIController::artworkPlaceholder
IL_0006: ldc.i4.0
IL_0007: callvirt System.Void UnityEngine.Behaviour::set_enabled(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.UI.Image TheForestOfLove.GeneralStoryUIController::artworkPlaceholder
IL_0012: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0017: callvirt System.Collections.IEnumerator UnityEngine.Transform::GetEnumerator()
IL_001c: stloc.0
IL_001d: br.s IL_0036
IL_001f: ldloc.0
IL_0020: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_0025: castclass UnityEngine.Transform
IL_002a: ldarg.0
IL_002b: ldfld UnityEngine.Transform TheForestOfLove.GeneralStoryUIController::hiddenContent
IL_0030: ldarg.2
IL_0031: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_0036: ldloc.0
IL_0037: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_003c: brtrue.s IL_001f
IL_003e: leave.s IL_0051
IL_0040: ldloc.0
IL_0041: isinst System.IDisposable
IL_0046: stloc.1
IL_0047: ldloc.1
IL_0048: brfalse.s IL_0050
IL_004a: ldloc.1
IL_004b: callvirt System.Void System.IDisposable::Dispose()
IL_0050: endfinally
IL_0051: ldarg.1
IL_0052: ldarg.0
IL_0053: ldfld UnityEngine.UI.Image TheForestOfLove.GeneralStoryUIController::artworkPlaceholder
IL_0058: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_005d: ldarg.2
IL_005e: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_0063: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::JumpToStateId(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldc.i4.1
IL_0003: ldarg.0
IL_0004: call System.Int32 TheForestOfLove.GeneralStoryUIController::get_StateCount()
IL_0009: ldc.i4.1
IL_000a: add
IL_000b: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_0010: call System.Void TheForestOfLove.GeneralStoryUIController::set_CurrentStateId(System.Int32)
IL_0015: ldarg.0
IL_0016: call System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_001b: stloc.0
IL_001c: ldarg.0
IL_001d: ldloc.0
IL_001e: ldc.i4.1
IL_001f: sub
IL_0020: call System.Void TheForestOfLove.GeneralStoryUIController::set_CurrentStateId(System.Int32)
IL_0025: ldarg.0
IL_0026: ldc.i4.1
IL_0027: call System.Void TheForestOfLove.GeneralStoryUIController::set_IsJumpingToState(System.Boolean)
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_0032: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0037: ldarg.0
IL_0038: ldc.i4.0
IL_0039: call System.Void TheForestOfLove.GeneralStoryUIController::set_IsJumpingToState(System.Boolean)
IL_003e: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::<OnSceneStarted>b__62_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onInitialBlankScreenDialogueMoment
IL_0006: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_000b: ldarg.0
IL_000c: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_0011: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0016: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::<AdvanceMovie>b__67_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_0006: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_000b: ret
METHOD System.Void TheForestOfLove.GeneralStoryUIController::<AdvanceMovie>b__67_1() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::movieWrapper
IL_0006: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_000b: ret
