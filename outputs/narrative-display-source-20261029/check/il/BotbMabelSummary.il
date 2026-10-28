TYPE TheForestOfLove.BotbMabelSummary
TYPE TheForestOfLove.BotbMabelSummary
METHOD System.Void TheForestOfLove.BotbMabelSummary::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.BotbMabelSummary::storyController
IL_000c: ldc.i4.3
IL_000d: callvirt System.Void TheForestOfLove.GeneralStoryUIController::set_StateCount(System.Int32)
IL_0012: ret
METHOD System.Void TheForestOfLove.BotbMabelSummary::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.BotbMabelSummary::storyController
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onAdvanceMoment
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.BotbMabelSummary::OnAdvanceMoment()
IL_0018: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.BotbMabelSummary::storyController
IL_0028: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUIController::onInitialBlankScreenDialogueMoment
IL_002d: ldarg.0
IL_002e: ldftn System.Void TheForestOfLove.BotbMabelSummary::OnAdvanceMoment()
IL_0034: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_003e: ret
METHOD System.Void TheForestOfLove.BotbMabelSummary::OnAdvanceMoment() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.BotbMabelSummary::storyController
IL_0006: callvirt System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()
IL_000b: stloc.0
IL_000c: ldloc.0
IL_000d: switch IL_001e,IL_003c,IL_005a
IL_001e: ldarg.0
IL_001f: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.BotbMabelSummary::storyController
IL_0024: ldarg.0
IL_0025: ldfld UnityEngine.Transform TheForestOfLove.BotbMabelSummary::FrameOne
IL_002a: ldc.i4.1
IL_002b: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_0030: ldarg.0
IL_0031: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.BotbMabelSummary::storyController
IL_0036: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_003b: ret
IL_003c: ldarg.0
IL_003d: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.BotbMabelSummary::storyController
IL_0042: ldarg.0
IL_0043: ldfld UnityEngine.Transform TheForestOfLove.BotbMabelSummary::FrameTwo
IL_0048: ldc.i4.1
IL_0049: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_004e: ldarg.0
IL_004f: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.BotbMabelSummary::storyController
IL_0054: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0059: ret
IL_005a: ldarg.0
IL_005b: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.BotbMabelSummary::storyController
IL_0060: ldarg.0
IL_0061: ldfld UnityEngine.Transform TheForestOfLove.BotbMabelSummary::FrameThree
IL_0066: ldc.i4.1
IL_0067: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryContent(UnityEngine.Transform,System.Boolean)
IL_006c: ldarg.0
IL_006d: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.BotbMabelSummary::storyController
IL_0072: callvirt System.Void TheForestOfLove.GeneralStoryUIController::Advance_FadeFromBlack()
IL_0077: ret
