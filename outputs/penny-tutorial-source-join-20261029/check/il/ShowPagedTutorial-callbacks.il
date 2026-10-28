TYPE TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0
METHOD System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: ret
METHOD System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0006: ldc.i4.1
IL_0007: stfld System.Boolean TheForestOfLove.PagedTutorial::allowNavigation
IL_000c: ret
METHOD System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__1() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.ItemGetNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<>4__this
IL_0006: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::continueButtonAnimator
IL_000b: ldstr "pressed"
IL_0010: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0015: ret
METHOD System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__2() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.ItemGetNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<>4__this
IL_0006: call System.Void TheForestOfLove.ItemGetNotification::HideNotification()
IL_000b: ldc.r4 2
IL_0010: ldarg.0
IL_0011: ldfld System.Action TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<>9__3
IL_0016: dup
IL_0017: brtrue.s IL_002f
IL_0019: pop
IL_001a: ldarg.0
IL_001b: ldarg.0
IL_001c: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__3()
IL_0022: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0027: dup
IL_0028: stloc.0
IL_0029: stfld System.Action TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<>9__3
IL_002e: ldloc.0
IL_002f: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0034: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onTutorialEnding
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_003e: ret
