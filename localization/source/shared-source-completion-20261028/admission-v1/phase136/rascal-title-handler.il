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
