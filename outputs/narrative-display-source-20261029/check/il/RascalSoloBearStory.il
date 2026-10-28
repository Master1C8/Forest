TYPE TheForestOfLove.RascalSoloBearStory
METHOD System.Void TheForestOfLove.RascalSoloBearStory::OnDialogueEmptyWithTitledLine(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "show ending screen"
IL_0006: callvirt System.Boolean System.String::Contains(System.String)
IL_000b: brfalse.s IL_0028
IL_000d: ldc.r4 0.25
IL_0012: ldarg.0
IL_0013: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0018: ldftn System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_001e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0023: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0028: ret
METHOD System.Void TheForestOfLove.RascalSoloBearStory::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.RascalSoloBearStory::OnAdvanceMoment()
IL_0018: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0028: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.GeneralStoryUIController::onDialogueLine
IL_002d: ldarg.0
IL_002e: ldftn System.Void TheForestOfLove.RascalSoloBearStory::OnDialogueLine(System.String)
IL_0034: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_003e: ldarg.0
IL_003f: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0044: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.GeneralStoryUIController::onDialogueEmptyWithTitledLine
IL_0049: ldarg.0
IL_004a: ldftn System.Void TheForestOfLove.RascalSoloBearStory::OnDialogueEmptyWithTitledLine(System.String)
IL_0050: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0055: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_005a: ldarg.0
IL_005b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0060: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onInitialBlankScreenDialogueMoment
IL_0065: ldarg.0
IL_0066: ldftn System.Void TheForestOfLove.RascalSoloBearStory::OnInitialDialogueMoment()
IL_006c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0071: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0076: ret
TYPE TheForestOfLove.RascalSoloBearStory
METHOD System.Void TheForestOfLove.RascalSoloBearStory::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_000c: ldc.i4.1
IL_000d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_SuppressShowFinalImageByItselfAfterDialogue(System.Boolean)
IL_0012: ldarg.0
IL_0013: call System.Boolean TheForestOfLove.RascalSoloBearStory::IsNoDialogue()
IL_0018: brfalse.s IL_0027
IL_001a: ldarg.0
IL_001b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0020: ldc.i4.5
IL_0021: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_StateCount(System.Int32)
IL_0026: ret
IL_0027: ldarg.0
IL_0028: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_002d: ldc.i4.7
IL_002e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_StateCount(System.Int32)
IL_0033: ret
METHOD System.Void TheForestOfLove.RascalSoloBearStory::OnAdvanceMoment() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.RascalSoloBearStory::IsNoDialogue()
IL_0006: brfalse.s IL_000f
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.RascalSoloBearStory::OnAdvanceMovement_NoDialogue()
IL_000e: ret
IL_000f: ldarg.0
IL_0010: call System.Void TheForestOfLove.RascalSoloBearStory::OnAdvanceMovement_Dialogue()
IL_0015: ret
METHOD System.Void TheForestOfLove.RascalSoloBearStory::OnAdvanceMovement_NoDialogue() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0006: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_000b: stloc.0
IL_000c: ldloc.0
IL_000d: switch IL_0026,IL_004d,IL_0074,IL_009b,IL_00c2
IL_0026: ldarg.0
IL_0027: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.Sprite TheForestOfLove.RascalSoloBearStory::FrameOne
IL_0032: ldc.r4 0
IL_0037: ldc.r4 0
IL_003c: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_0041: ldarg.0
IL_0042: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0047: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_004c: ret
IL_004d: ldarg.0
IL_004e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0053: ldarg.0
IL_0054: ldfld UnityEngine.Sprite TheForestOfLove.RascalSoloBearStory::FrameTwo
IL_0059: ldc.r4 0
IL_005e: ldc.r4 0
IL_0063: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_0068: ldarg.0
IL_0069: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_006e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_0073: ret
IL_0074: ldarg.0
IL_0075: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_007a: ldarg.0
IL_007b: ldfld UnityEngine.Sprite TheForestOfLove.RascalSoloBearStory::FrameThree
IL_0080: ldc.r4 0
IL_0085: ldc.r4 0
IL_008a: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_008f: ldarg.0
IL_0090: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0095: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_009a: ret
IL_009b: ldarg.0
IL_009c: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_00a1: ldarg.0
IL_00a2: ldfld UnityEngine.Sprite TheForestOfLove.RascalSoloBearStory::FrameFour
IL_00a7: ldc.r4 0
IL_00ac: ldc.r4 0
IL_00b1: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_00b6: ldarg.0
IL_00b7: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_00bc: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_00c1: ret
IL_00c2: ldarg.0
IL_00c3: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_00c8: ldarg.0
IL_00c9: ldfld UnityEngine.Sprite TheForestOfLove.RascalSoloBearStory::FrameFive
IL_00ce: ldc.r4 0
IL_00d3: ldc.r4 0
IL_00d8: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_00dd: ldarg.0
IL_00de: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_00e3: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_00e8: ret
METHOD System.Void TheForestOfLove.RascalSoloBearStory::OnAdvanceMovement_Dialogue() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0006: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_000b: stloc.0
IL_000c: ldloc.0
IL_000d: switch IL_002e,IL_003a,IL_0061,IL_0088,IL_00af,IL_00d6,IL_00fd
IL_002e: ldarg.0
IL_002f: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0034: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeToBlack()
IL_0039: ret
IL_003a: ldarg.0
IL_003b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0040: ldarg.0
IL_0041: ldfld UnityEngine.Sprite TheForestOfLove.RascalSoloBearStory::FrameOne
IL_0046: ldc.r4 0
IL_004b: ldc.r4 0
IL_0050: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_0055: ldarg.0
IL_0056: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_005b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0060: ret
IL_0061: ldarg.0
IL_0062: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0067: ldarg.0
IL_0068: ldfld UnityEngine.Sprite TheForestOfLove.RascalSoloBearStory::FrameTwo
IL_006d: ldc.r4 0
IL_0072: ldc.r4 0
IL_0077: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_007c: ldarg.0
IL_007d: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0082: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_0087: ret
IL_0088: ldarg.0
IL_0089: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_008e: ldarg.0
IL_008f: ldfld UnityEngine.Sprite TheForestOfLove.RascalSoloBearStory::FrameThree
IL_0094: ldc.r4 0
IL_0099: ldc.r4 0
IL_009e: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_00a3: ldarg.0
IL_00a4: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_00a9: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_00ae: ret
IL_00af: ldarg.0
IL_00b0: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_00b5: ldarg.0
IL_00b6: ldfld UnityEngine.Sprite TheForestOfLove.RascalSoloBearStory::FrameFour
IL_00bb: ldc.r4 0
IL_00c0: ldc.r4 0
IL_00c5: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_00ca: ldarg.0
IL_00cb: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_00d0: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_00d5: ret
IL_00d6: ldarg.0
IL_00d7: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_00dc: ldarg.0
IL_00dd: ldfld UnityEngine.Sprite TheForestOfLove.RascalSoloBearStory::FrameFive
IL_00e2: ldc.r4 0
IL_00e7: ldc.r4 0
IL_00ec: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_00f1: ldarg.0
IL_00f2: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_00f7: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromWhite()
IL_00fc: ret
IL_00fd: ldarg.0
IL_00fe: ldfld TheForestOfLove.GeneralStoryUITransitionController TheForestOfLove.RascalSoloBearStory::transitionController
IL_0103: callvirt System.Void TheForestOfLove.GeneralStoryUITransitionController::FadeToBlack()
IL_0108: ldc.r4 1
IL_010d: ldarg.0
IL_010e: ldftn System.Void TheForestOfLove.RascalSoloBearStory::<OnAdvanceMovement_Dialogue>b__15_0()
IL_0114: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0119: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_011e: ret
METHOD System.Boolean TheForestOfLove.RascalSoloBearStory::IsNoDialogue() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0005: brfalse.s IL_0010
IL_0007: ldsfld System.Boolean Globals::allowDialogueInStartMenu
IL_000c: ldc.i4.0
IL_000d: ceq
IL_000f: ret
IL_0010: ldc.i4.0
IL_0011: ret
METHOD System.Void TheForestOfLove.RascalSoloBearStory::OnInitialDialogueMoment() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0006: ldstr "Movies_RascalSoloBearStory_Dialogue"
IL_000b: ldstr "Rascal"
IL_0010: ldnull
IL_0011: callvirt System.Void TheForestOfLove.GeneralStoryUIController::StartDialogue(System.String,System.String,System.String)
IL_0016: ldarg.0
IL_0017: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_001c: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0021: ret
METHOD System.Void TheForestOfLove.RascalSoloBearStory::OnDialogueLine(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "Mmmm yeah"
IL_0006: callvirt System.Boolean System.String::Contains(System.String)
IL_000b: brfalse.s IL_0018
IL_000d: ldarg.0
IL_000e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0013: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0018: ldarg.1
IL_0019: ldstr "better not pull out"
IL_001e: callvirt System.Boolean System.String::Contains(System.String)
IL_0023: brfalse.s IL_0030
IL_0025: ldarg.0
IL_0026: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_002b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0030: ldarg.1
IL_0031: ldstr "Ahhh yeah"
IL_0036: callvirt System.Boolean System.String::Contains(System.String)
IL_003b: brfalse.s IL_0048
IL_003d: ldarg.0
IL_003e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0043: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0048: ldarg.1
IL_0049: ldstr "Mmmf~"
IL_004e: callvirt System.Boolean System.String::Contains(System.String)
IL_0053: brfalse.s IL_0060
IL_0055: ldarg.0
IL_0056: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_005b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0060: ldarg.1
IL_0061: ldstr "How was that?"
IL_0066: callvirt System.Boolean System.String::Contains(System.String)
IL_006b: brfalse.s IL_0078
IL_006d: ldarg.0
IL_006e: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0073: callvirt System.Void TheForestOfLove.GeneralStoryUIController::TriggerAdvanceMoment()
IL_0078: ret
METHOD System.Void TheForestOfLove.RascalSoloBearStory::<OnAdvanceMovement_Dialogue>b__15_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.Transform TheForestOfLove.RascalSoloBearStory::FrameSix
IL_000c: ldc.i4.1
IL_000d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0012: ldarg.0
IL_0013: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.RascalSoloBearStory::storyController
IL_0018: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_001d: ret
