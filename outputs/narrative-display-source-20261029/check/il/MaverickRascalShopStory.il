TYPE TheForestOfLove.MaverickRascalShopStory
TYPE TheForestOfLove.MaverickRascalShopStory
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000c: ldarg.0
IL_000d: ldftn System.Boolean TheForestOfLove.MaverickRascalShopStory::DialogueFinished_CustomHandler()
IL_0013: newobj System.Void System.Func`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0018: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_DialogueFinishedCustomHandler(System.Func`1<System.Boolean>)
IL_001d: ldarg.0
IL_001e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0023: ldarg.0
IL_0024: ldftn System.Boolean TheForestOfLove.MaverickRascalShopStory::AdvanceMovie_CustomHandler()
IL_002a: newobj System.Void System.Func`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_002f: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_AdvanceMovieCustomHandler(System.Func`1<System.Boolean>)
IL_0034: ldarg.0
IL_0035: call System.Boolean TheForestOfLove.MaverickRascalShopStory::IsNoDialogue()
IL_003a: brfalse.s IL_004a
IL_003c: ldarg.0
IL_003d: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0042: ldc.i4.s 13
IL_0044: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_StateCount(System.Int32)
IL_0049: ret
IL_004a: ldarg.0
IL_004b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0050: ldc.i4.s 16
IL_0052: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_StateCount(System.Int32)
IL_0057: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::OnAdvanceMoment()
IL_0018: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0028: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.GeneralStoryUIController::onDialogueLine
IL_002d: ldarg.0
IL_002e: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::OnDialogueLine(System.String)
IL_0034: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_003e: ldarg.0
IL_003f: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0044: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onInitialBlankScreenDialogueMoment
IL_0049: ldarg.0
IL_004a: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::OnInitialDialogueMoment()
IL_0050: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0055: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_005a: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::OnAdvanceMoment() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.MaverickRascalShopStory::IsNoDialogue()
IL_0006: brfalse.s IL_000f
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.MaverickRascalShopStory::OnAdvanceMovement_NoDialogue()
IL_000e: ret
IL_000f: ldarg.0
IL_0010: call System.Void TheForestOfLove.MaverickRascalShopStory::OnAdvanceMovement_Dialogue()
IL_0015: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::OnAdvanceMovement_NoDialogue() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0006: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_000b: stloc.0
IL_000c: ldloc.0
IL_000d: switch IL_0046,IL_0064,IL_008d,IL_00ab,IL_00c9,IL_00e7,IL_0110,IL_0139,IL_0162,IL_018b,IL_01b4,IL_01ef,IL_0218
IL_0046: ldarg.0
IL_0047: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_004c: ldarg.0
IL_004d: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame01
IL_0052: ldc.i4.1
IL_0053: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0058: ldarg.0
IL_0059: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_005e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0063: ret
IL_0064: ldarg.0
IL_0065: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_006a: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack()
IL_006f: ldarg.0
IL_0070: ldc.i4.1
IL_0071: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0076: ldc.r4 1
IL_007b: ldarg.0
IL_007c: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_0()
IL_0082: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0087: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_008c: ret
IL_008d: ldarg.0
IL_008e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0093: ldarg.0
IL_0094: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame03
IL_0099: ldc.i4.1
IL_009a: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_009f: ldarg.0
IL_00a0: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00a5: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_00aa: ret
IL_00ab: ldarg.0
IL_00ac: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00b1: ldarg.0
IL_00b2: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame04
IL_00b7: ldc.i4.1
IL_00b8: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_00bd: ldarg.0
IL_00be: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00c3: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_00c8: ret
IL_00c9: ldarg.0
IL_00ca: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00cf: ldarg.0
IL_00d0: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame05
IL_00d5: ldc.i4.1
IL_00d6: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_00db: ldarg.0
IL_00dc: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00e1: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_00e6: ret
IL_00e7: ldarg.0
IL_00e8: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00ed: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack()
IL_00f2: ldarg.0
IL_00f3: ldc.i4.1
IL_00f4: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_00f9: ldc.r4 1
IL_00fe: ldarg.0
IL_00ff: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_1()
IL_0105: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_010a: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_010f: ret
IL_0110: ldarg.0
IL_0111: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0116: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack()
IL_011b: ldarg.0
IL_011c: ldc.i4.1
IL_011d: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0122: ldc.r4 1
IL_0127: ldarg.0
IL_0128: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_2()
IL_012e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0133: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0138: ret
IL_0139: ldarg.0
IL_013a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_013f: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack()
IL_0144: ldarg.0
IL_0145: ldc.i4.1
IL_0146: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_014b: ldc.r4 1
IL_0150: ldarg.0
IL_0151: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_3()
IL_0157: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_015c: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0161: ret
IL_0162: ldarg.0
IL_0163: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0168: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack()
IL_016d: ldarg.0
IL_016e: ldc.i4.1
IL_016f: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0174: ldc.r4 1
IL_0179: ldarg.0
IL_017a: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_4()
IL_0180: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0185: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_018a: ret
IL_018b: ldarg.0
IL_018c: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0191: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack()
IL_0196: ldarg.0
IL_0197: ldc.i4.1
IL_0198: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_019d: ldc.r4 1
IL_01a2: ldarg.0
IL_01a3: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_5()
IL_01a9: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01ae: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_01b3: ret
IL_01b4: ldarg.0
IL_01b5: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_01ba: ldarg.0
IL_01bb: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame09
IL_01c0: ldc.i4.1
IL_01c1: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_01c6: ldarg.0
IL_01c7: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_01cc: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_01d1: ldarg.0
IL_01d2: ldc.i4.1
IL_01d3: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_01d8: ldc.r4 0.75
IL_01dd: ldarg.0
IL_01de: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_6()
IL_01e4: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01e9: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_01ee: ret
IL_01ef: ldarg.0
IL_01f0: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_01f5: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack()
IL_01fa: ldarg.0
IL_01fb: ldc.i4.1
IL_01fc: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0201: ldc.r4 1
IL_0206: ldarg.0
IL_0207: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_7()
IL_020d: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0212: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0217: ret
IL_0218: ldarg.0
IL_0219: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_021e: ldarg.0
IL_021f: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame12
IL_0224: ldc.i4.1
IL_0225: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_022a: ldarg.0
IL_022b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0230: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_0235: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::OnAdvanceMovement_Dialogue() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0006: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_000b: stloc.0
IL_000c: ldloc.0
IL_000d: switch IL_0052,IL_0080,IL_00c1,IL_00df,IL_00fd,IL_011b,IL_0142,IL_0169,IL_018b,IL_01a9,IL_01d0,IL_01f7,IL_0240,IL_0267,IL_0285,IL_02ac
IL_0052: ldarg.0
IL_0053: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0058: ldarg.0
IL_0059: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame01
IL_005e: ldc.i4.1
IL_005f: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0064: ldarg.0
IL_0065: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_006a: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_006f: ldarg.0
IL_0070: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0075: callvirt TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::get_MovieWrapper()
IL_007a: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_007f: ret
IL_0080: ldarg.0
IL_0081: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0086: ldstr "Movies_MaverickRascalShopStory_Dialogue"
IL_008b: ldstr "Maverick"
IL_0090: ldstr "maverick_rascal_shop_story_part1"
IL_0095: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String)
IL_009a: ldarg.0
IL_009b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00a0: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_00a5: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeToBlack()
IL_00aa: ldc.r4 1
IL_00af: ldarg.0
IL_00b0: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_0()
IL_00b6: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00bb: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00c0: ret
IL_00c1: ldarg.0
IL_00c2: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00c7: ldarg.0
IL_00c8: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame03
IL_00cd: ldc.i4.1
IL_00ce: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_00d3: ldarg.0
IL_00d4: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00d9: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_00de: ret
IL_00df: ldarg.0
IL_00e0: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00e5: ldarg.0
IL_00e6: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame04
IL_00eb: ldc.i4.1
IL_00ec: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_00f1: ldarg.0
IL_00f2: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00f7: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_00fc: ret
IL_00fd: ldarg.0
IL_00fe: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0103: ldarg.0
IL_0104: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame05
IL_0109: ldc.i4.1
IL_010a: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_010f: ldarg.0
IL_0110: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0115: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_011a: ret
IL_011b: ldarg.0
IL_011c: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0121: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_0126: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeToBlack()
IL_012b: ldc.r4 1
IL_0130: ldarg.0
IL_0131: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_1()
IL_0137: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_013c: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0141: ret
IL_0142: ldarg.0
IL_0143: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0148: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_014d: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeToBlack()
IL_0152: ldc.r4 1
IL_0157: ldarg.0
IL_0158: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_2()
IL_015e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0163: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0168: ret
IL_0169: ldarg.0
IL_016a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_016f: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack()
IL_0174: ldc.r4 1
IL_0179: ldarg.0
IL_017a: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_3()
IL_0180: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0185: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_018a: ret
IL_018b: ldarg.0
IL_018c: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0191: ldarg.0
IL_0192: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame08
IL_0197: ldc.i4.1
IL_0198: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_019d: ldarg.0
IL_019e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_01a3: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_01a8: ret
IL_01a9: ldarg.0
IL_01aa: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_01af: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_01b4: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeToBlack()
IL_01b9: ldc.r4 1
IL_01be: ldarg.0
IL_01bf: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_4()
IL_01c5: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01ca: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_01cf: ret
IL_01d0: ldarg.0
IL_01d1: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_01d6: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_01db: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeToBlack()
IL_01e0: ldc.r4 1
IL_01e5: ldarg.0
IL_01e6: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_5()
IL_01ec: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01f1: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_01f6: ret
IL_01f7: ldarg.0
IL_01f8: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_01fd: ldarg.0
IL_01fe: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame09
IL_0203: ldc.i4.1
IL_0204: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0209: ldarg.0
IL_020a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_020f: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_0214: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromWhite()
IL_0219: ldarg.0
IL_021a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_021f: callvirt TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::get_MovieWrapper()
IL_0224: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_0229: ldc.r4 0.75
IL_022e: ldarg.0
IL_022f: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_6()
IL_0235: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_023a: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_023f: ret
IL_0240: ldarg.0
IL_0241: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0246: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_024b: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeToBlack()
IL_0250: ldc.r4 1
IL_0255: ldarg.0
IL_0256: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_7()
IL_025c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0261: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0266: ret
IL_0267: ldarg.0
IL_0268: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_026d: ldarg.0
IL_026e: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame12
IL_0273: ldc.i4.1
IL_0274: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0279: ldarg.0
IL_027a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_027f: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_0284: ret
IL_0285: ldarg.0
IL_0286: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_028b: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_0290: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeToBlack()
IL_0295: ldc.r4 1
IL_029a: ldarg.0
IL_029b: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_8()
IL_02a1: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_02a6: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_02ab: ret
IL_02ac: ldarg.0
IL_02ad: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_02b2: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack()
IL_02b7: ldc.r4 1
IL_02bc: ldarg.0
IL_02bd: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_9()
IL_02c3: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_02c8: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_02cd: ret
METHOD System.Boolean TheForestOfLove.MaverickRascalShopStory::DialogueFinished_CustomHandler() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.MaverickRascalShopStory::IsNoDialogue()
IL_0006: brtrue.s IL_0027
IL_0008: ldarg.0
IL_0009: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000e: callvirt System.Boolean TheForestOfLove.GeneralStoryUIController::get_SkipDialogue()
IL_0013: brtrue.s IL_0027
IL_0015: ldarg.0
IL_0016: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_001b: callvirt TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::get_MovieDialogueManager()
IL_0020: callvirt System.Boolean TheForestOfLove.MovieDialogueManager::get_dialogueDisabled()
IL_0025: brfalse.s IL_0029
IL_0027: ldc.i4.0
IL_0028: ret
IL_0029: ldarg.0
IL_002a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_002f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0034: ldc.i4.5
IL_0035: beq.s IL_0090
IL_0037: ldarg.0
IL_0038: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_003d: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0042: ldc.i4.6
IL_0043: beq.s IL_0090
IL_0045: ldarg.0
IL_0046: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_004b: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0050: ldc.i4.s 9
IL_0052: beq.s IL_0090
IL_0054: ldarg.0
IL_0055: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_005a: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_005f: ldc.i4.s 10
IL_0061: beq.s IL_0090
IL_0063: ldarg.0
IL_0064: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0069: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_006e: ldc.i4.s 11
IL_0070: beq.s IL_0090
IL_0072: ldarg.0
IL_0073: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0078: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_007d: ldc.i4.s 12
IL_007f: beq.s IL_0090
IL_0081: ldarg.0
IL_0082: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0087: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_008c: ldc.i4.s 14
IL_008e: bne.un.s IL_00bd
IL_0090: ldarg.0
IL_0091: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0096: callvirt TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::get_MovieDialogueManager()
IL_009b: callvirt System.Void TheForestOfLove.MovieDialogueManager::ResetAll()
IL_00a0: ldarg.0
IL_00a1: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00a6: callvirt TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::get_MovieWrapper()
IL_00ab: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_00b0: ldarg.0
IL_00b1: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00b6: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_00bb: ldc.i4.1
IL_00bc: ret
IL_00bd: ldarg.0
IL_00be: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00c3: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_00c8: ldc.i4.s 15
IL_00ca: ble.s IL_00d9
IL_00cc: ldarg.0
IL_00cd: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00d2: callvirt System.Void TheForestOfLove.GeneralStoryUIController::EndMovie()
IL_00d7: ldc.i4.1
IL_00d8: ret
IL_00d9: ldc.i4.0
IL_00da: ret
METHOD System.Boolean TheForestOfLove.MaverickRascalShopStory::AdvanceMovie_CustomHandler() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0006: brfalse.s IL_000a
IL_0008: ldc.i4.1
IL_0009: ret
IL_000a: ldarg.0
IL_000b: call System.Boolean TheForestOfLove.MaverickRascalShopStory::IsNoDialogue()
IL_0010: brtrue.s IL_0031
IL_0012: ldarg.0
IL_0013: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0018: callvirt System.Boolean TheForestOfLove.GeneralStoryUIController::get_SkipDialogue()
IL_001d: brtrue.s IL_0031
IL_001f: ldarg.0
IL_0020: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0025: callvirt TheForestOfLove.MovieDialogueManager TheForestOfLove.GeneralStoryUIController::get_MovieDialogueManager()
IL_002a: callvirt System.Boolean TheForestOfLove.MovieDialogueManager::get_dialogueDisabled()
IL_002f: brfalse.s IL_0033
IL_0031: ldc.i4.0
IL_0032: ret
IL_0033: ldarg.0
IL_0034: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0039: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_003e: ldc.i4.5
IL_003f: beq.s IL_00a9
IL_0041: ldarg.0
IL_0042: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0047: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_004c: ldc.i4.6
IL_004d: beq.s IL_00a9
IL_004f: ldarg.0
IL_0050: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0055: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_005a: ldc.i4.s 9
IL_005c: beq.s IL_00a9
IL_005e: ldarg.0
IL_005f: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0064: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0069: ldc.i4.s 10
IL_006b: beq.s IL_00a9
IL_006d: ldarg.0
IL_006e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0073: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0078: ldc.i4.s 11
IL_007a: beq.s IL_00a9
IL_007c: ldarg.0
IL_007d: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0082: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0087: ldc.i4.s 12
IL_0089: beq.s IL_00a9
IL_008b: ldarg.0
IL_008c: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0091: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0096: ldc.i4.s 14
IL_0098: beq.s IL_00a9
IL_009a: ldarg.0
IL_009b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00a0: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_00a5: ldc.i4.s 15
IL_00a7: ble.s IL_00ab
IL_00a9: ldc.i4.1
IL_00aa: ret
IL_00ab: ldarg.0
IL_00ac: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00b1: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_00b6: ldc.i4.1
IL_00b7: beq.s IL_00d6
IL_00b9: ldarg.0
IL_00ba: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00bf: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_00c4: ldc.i4.7
IL_00c5: beq.s IL_00d6
IL_00c7: ldarg.0
IL_00c8: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00cd: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_00d2: ldc.i4.s 15
IL_00d4: bne.un.s IL_00f3
IL_00d6: ldarg.0
IL_00d7: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00dc: callvirt TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::get_MovieWrapper()
IL_00e1: callvirt System.Void TheForestOfLove.MovieWrapper::HideNextButton()
IL_00e6: ldarg.0
IL_00e7: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_00ec: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_00f1: ldc.i4.1
IL_00f2: ret
IL_00f3: ldc.i4.0
IL_00f4: ret
METHOD System.Boolean TheForestOfLove.MaverickRascalShopStory::IsNoDialogue() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0005: brfalse.s IL_0010
IL_0007: ldsfld System.Boolean Globals::allowDialogueInStartMenu
IL_000c: ldc.i4.0
IL_000d: ceq
IL_000f: ret
IL_0010: ldc.i4.0
IL_0011: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::OnInitialDialogueMoment() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0006: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_000b: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::OnDialogueLine(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "That better shut him up"
IL_0006: callvirt System.Boolean System.String::Contains(System.String)
IL_000b: brfalse.s IL_0018
IL_000d: ldarg.0
IL_000e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0013: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0018: ldarg.1
IL_0019: ldstr "Riiight riight"
IL_001e: callvirt System.Boolean System.String::Contains(System.String)
IL_0023: brfalse.s IL_0030
IL_0025: ldarg.0
IL_0026: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_002b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0030: ldarg.1
IL_0031: ldstr "Aghhh!"
IL_0036: callvirt System.Boolean System.String::Contains(System.String)
IL_003b: brfalse.s IL_0048
IL_003d: ldarg.0
IL_003e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0043: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0048: ldarg.1
IL_0049: ldstr "Buckyyyy!"
IL_004e: callvirt System.Boolean System.String::Contains(System.String)
IL_0053: brfalse.s IL_0060
IL_0055: ldarg.0
IL_0056: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_005b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0060: ldarg.1
IL_0061: ldstr "Aaaaanhhh"
IL_0066: callvirt System.Boolean System.String::Contains(System.String)
IL_006b: brfalse.s IL_0078
IL_006d: ldarg.0
IL_006e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0073: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0078: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame02
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0028: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_002d: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromBlack()
IL_0032: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_1() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame07
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0028: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_002d: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromBlack()
IL_0032: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_2() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame06
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0028: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_002d: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromBlack()
IL_0032: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_3() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame08
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0028: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_002d: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromBlack()
IL_0032: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_4() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame07
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0028: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_002d: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromBlack()
IL_0032: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_5() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame08
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0028: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_002d: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromBlack()
IL_0032: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_6() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld UnityEngine.Animator TheForestOfLove.MaverickRascalShopStory::raiseHandAnimator
IL_000f: ldstr "raise_hand"
IL_0014: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.Animator TheForestOfLove.MaverickRascalShopStory::raiseHandAnimator
IL_001f: ldstr "raise_hand"
IL_0024: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0029: ldc.r4 2
IL_002e: ldarg.0
IL_002f: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_8()
IL_0035: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_003a: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_003f: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_8() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame10
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0028: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_002d: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromWhite()
IL_0032: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_NoDialogue>b__23_7() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.MaverickRascalShopStory::waitingOnTransition
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame11
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0028: callvirt TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.GeneralStoryUIController::get_TransitionController()
IL_002d: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeFromBlack()
IL_0032: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0014: ldc.i4.1
IL_0015: beq.s IL_0018
IL_0017: ret
IL_0018: ldarg.0
IL_0019: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_001e: ldarg.0
IL_001f: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame02
IL_0024: ldc.i4.1
IL_0025: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_002a: ldarg.0
IL_002b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0030: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0035: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_1() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0014: ldc.i4.5
IL_0015: beq.s IL_0018
IL_0017: ret
IL_0018: ldarg.0
IL_0019: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_001e: ldstr "Movies_MaverickRascalShopStory_Dialogue"
IL_0023: ldstr "Maverick"
IL_0028: ldstr "maverick_rascal_shop_story_part2"
IL_002d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String)
IL_0032: ldarg.0
IL_0033: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame07
IL_003e: ldc.i4.1
IL_003f: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0044: ldarg.0
IL_0045: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_004a: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_004f: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_2() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0014: ldc.i4.6
IL_0015: beq.s IL_0018
IL_0017: ret
IL_0018: ldarg.0
IL_0019: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_001e: ldarg.0
IL_001f: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame06
IL_0024: ldc.i4.1
IL_0025: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_002a: ldarg.0
IL_002b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0030: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0035: ldarg.0
IL_0036: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_003b: callvirt TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::get_MovieWrapper()
IL_0040: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0045: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_3() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: ldstr "Movies_MaverickRascalShopStory_Dialogue"
IL_0014: ldstr "Maverick"
IL_0019: ldstr "maverick_rascal_shop_story_part3"
IL_001e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String)
IL_0023: ldarg.0
IL_0024: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0029: callvirt TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::get_MovieWrapper()
IL_002e: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0033: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_4() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0014: ldc.i4.s 9
IL_0016: beq.s IL_0019
IL_0018: ret
IL_0019: ldarg.0
IL_001a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_001f: ldstr "Movies_MaverickRascalShopStory_Dialogue"
IL_0024: ldstr "Maverick"
IL_0029: ldstr "maverick_rascal_shop_story_part4"
IL_002e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String)
IL_0033: ldarg.0
IL_0034: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0039: ldarg.0
IL_003a: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame07
IL_003f: ldc.i4.1
IL_0040: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0045: ldarg.0
IL_0046: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_004b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0050: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_5() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0014: ldc.i4.s 10
IL_0016: beq.s IL_0019
IL_0018: ret
IL_0019: ldarg.0
IL_001a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_001f: ldstr "Movies_MaverickRascalShopStory_Dialogue"
IL_0024: ldstr "Maverick"
IL_0029: ldstr "maverick_rascal_shop_story_part5"
IL_002e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String)
IL_0033: ldarg.0
IL_0034: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0039: ldarg.0
IL_003a: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame08
IL_003f: ldc.i4.1
IL_0040: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0045: ldarg.0
IL_0046: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_004b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0050: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_6() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0014: ldc.i4.s 11
IL_0016: beq.s IL_0019
IL_0018: ret
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.Animator TheForestOfLove.MaverickRascalShopStory::raiseHandAnimator
IL_001f: ldstr "raise_hand"
IL_0024: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.Animator TheForestOfLove.MaverickRascalShopStory::raiseHandAnimator
IL_002f: ldstr "raise_hand"
IL_0034: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0039: ldc.r4 2
IL_003e: ldarg.0
IL_003f: ldftn System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_10()
IL_0045: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_004a: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_004f: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_10() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0014: ldc.i4.s 11
IL_0016: beq.s IL_0019
IL_0018: ret
IL_0019: ldarg.0
IL_001a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_001f: ldstr "Movies_MaverickRascalShopStory_Dialogue"
IL_0024: ldstr "Maverick"
IL_0029: ldstr "maverick_rascal_shop_story_part6"
IL_002e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String)
IL_0033: ldarg.0
IL_0034: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0039: ldarg.0
IL_003a: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame10
IL_003f: ldc.i4.1
IL_0040: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0045: ldarg.0
IL_0046: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_004b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_0050: ldarg.0
IL_0051: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0056: callvirt TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::get_MovieWrapper()
IL_005b: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0060: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_7() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0014: ldc.i4.s 12
IL_0016: beq.s IL_0019
IL_0018: ret
IL_0019: ldarg.0
IL_001a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_001f: ldstr "Movies_MaverickRascalShopStory_Dialogue"
IL_0024: ldstr "Maverick"
IL_0029: ldstr "maverick_rascal_shop_story_part7"
IL_002e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String)
IL_0033: ldarg.0
IL_0034: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0039: ldarg.0
IL_003a: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame11
IL_003f: ldc.i4.1
IL_0040: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0045: ldarg.0
IL_0046: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_004b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0050: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_8() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_0014: ldc.i4.s 14
IL_0016: beq.s IL_0019
IL_0018: ret
IL_0019: ldarg.0
IL_001a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_001f: ldarg.0
IL_0020: ldfld UnityEngine.Transform TheForestOfLove.MaverickRascalShopStory::Frame13
IL_0025: ldc.i4.1
IL_0026: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_002b: ldarg.0
IL_002c: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0031: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0036: ldarg.0
IL_0037: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_003c: callvirt TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::get_MovieWrapper()
IL_0041: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0046: ret
METHOD System.Void TheForestOfLove.MaverickRascalShopStory::<OnAdvanceMovement_Dialogue>b__24_9() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_000f: ldstr "Movies_MaverickRascalShopStory_Dialogue"
IL_0014: ldstr "Maverick"
IL_0019: ldstr "maverick_rascal_shop_story_part8"
IL_001e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String)
IL_0023: ldarg.0
IL_0024: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.MaverickRascalShopStory::storyController
IL_0029: callvirt TheForestOfLove.MovieWrapper TheForestOfLove.GeneralStoryUIController::get_MovieWrapper()
IL_002e: callvirt System.Void TheForestOfLove.MovieWrapper::ShowNextButton()
IL_0033: ret
