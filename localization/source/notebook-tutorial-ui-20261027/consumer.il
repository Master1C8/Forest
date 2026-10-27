TYPE TheForestOfLove.ItemGetNotification
METHOD TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification::ShowPagedTutorial(TheForestOfLove.PagedTutorial) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld TheForestOfLove.ItemGetNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<>4__this
IL_000d: ldarg.0
IL_000e: call System.Boolean TheForestOfLove.ItemGetNotification::get_visible()
IL_0013: brfalse.s IL_0017
IL_0015: ldnull
IL_0016: ret
IL_0017: ldloc.0
IL_0018: ldarg.1
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::messageContainer
IL_001f: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.PagedTutorial>(!!0,UnityEngine.Transform)
IL_0024: stfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0029: ldloc.0
IL_002a: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_002f: ldc.i4.0
IL_0030: stfld System.Boolean TheForestOfLove.PagedTutorial::allowNavigation
IL_0035: ldc.r4 2.5
IL_003a: ldloc.0
IL_003b: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__0()
IL_0041: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0046: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_004b: ldarg.0
IL_004c: ldloc.0
IL_004d: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0052: ldfld UnityEngine.Animator[] TheForestOfLove.PagedTutorial::nav
IL_0057: ldarg.0
IL_0058: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::extraControlsContainer
IL_005d: call System.Void TheForestOfLove.ItemGetNotification::ReparentTutorialNav(UnityEngine.Animator[],UnityEngine.Transform)
IL_0062: ldloc.0
IL_0063: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0068: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PagedTutorial::onSubmit
IL_006d: ldloc.0
IL_006e: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__1()
IL_0074: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0079: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_007e: ldloc.0
IL_007f: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0084: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PagedTutorial::onTutorialFinished
IL_0089: ldloc.0
IL_008a: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__2()
IL_0090: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0095: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_009a: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onTutorialStarting
IL_009f: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00a4: ldarg.0
IL_00a5: call System.Void TheForestOfLove.ItemGetNotification::StartNotification()
IL_00aa: ldloc.0
IL_00ab: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_00b0: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::ShowGossipTutorial() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification::gossipTutorialPrefab
IL_0007: call TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification::ShowPagedTutorial(TheForestOfLove.PagedTutorial)
IL_000c: pop
IL_000d: ret
