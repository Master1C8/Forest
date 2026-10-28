TYPE TheForestOfLove.InstancedStoryOverlayUI
METHOD System.Void TheForestOfLove.InstancedStoryOverlayUI::BeginNotification(System.String,System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.2
IL_0002: stfld System.Boolean TheForestOfLove.InstancedStoryOverlayUI::usingManualAdvance
IL_0007: ldc.r4 0.35
IL_000c: stloc.0
IL_000d: ldarg.0
IL_000e: ldarg.1
IL_000f: call System.Void TheForestOfLove.InstancedStoryOverlayUI::SetTitleText(System.String)
IL_0014: ldloc.0
IL_0015: ldarg.0
IL_0016: ldftn System.Void TheForestOfLove.InstancedStoryOverlayUI::<BeginNotification>b__39_0()
IL_001c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0021: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0026: ldarg.0
IL_0027: ldfld System.Single TheForestOfLove.InstancedStoryOverlayUI::lockingLockPadSoundDelay
IL_002c: ldc.r4 0
IL_0031: ble.un.s IL_004c
IL_0033: ldarg.0
IL_0034: ldfld System.Single TheForestOfLove.InstancedStoryOverlayUI::lockingLockPadSoundDelay
IL_0039: ldarg.0
IL_003a: ldftn System.Void TheForestOfLove.InstancedStoryOverlayUI::PlayLockSound()
IL_0040: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0045: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_004a: br.s IL_0052
IL_004c: ldarg.0
IL_004d: call System.Void TheForestOfLove.InstancedStoryOverlayUI::PlayLockSound()
IL_0052: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationStarted_AutoClearListeners
IL_0057: dup
IL_0058: brtrue.s IL_005d
IL_005a: pop
IL_005b: br.s IL_0062
IL_005d: call System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0062: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationStarted_AutoClearListeners
IL_0067: callvirt System.Void UnityEngine.Events.UnityEventBase::RemoveAllListeners()
IL_006c: ldarg.0
IL_006d: ldfld System.Boolean TheForestOfLove.InstancedStoryOverlayUI::usingManualAdvance
IL_0072: brtrue.s IL_00a5
IL_0074: ldloc.0
IL_0075: ldarg.0
IL_0076: ldfld UnityEngine.Playables.PlayableAsset TheForestOfLove.InstancedStoryOverlayUI::lockBegin
IL_007b: callvirt System.Double UnityEngine.Playables.PlayableAsset::get_duration()
IL_0080: ldarg.0
IL_0081: ldfld UnityEngine.Playables.PlayableAsset TheForestOfLove.InstancedStoryOverlayUI::lockMinimize
IL_0086: callvirt System.Double UnityEngine.Playables.PlayableAsset::get_duration()
IL_008b: add
IL_008c: conv.r4
IL_008d: add
IL_008e: ldc.r4 -1.75
IL_0093: add
IL_0094: ldarg.0
IL_0095: ldftn System.Void TheForestOfLove.InstancedStoryOverlayUI::<BeginNotification>b__39_1()
IL_009b: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00a0: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00a5: ret
METHOD System.Void TheForestOfLove.InstancedStoryOverlayUI::EndNotification(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void TheForestOfLove.InstancedStoryOverlayUI::SetTitleText(System.String)
IL_0007: ldarg.0
IL_0008: ldarg.0
IL_0009: ldfld UnityEngine.Playables.PlayableAsset TheForestOfLove.InstancedStoryOverlayUI::lockUnlockFromMinimized
IL_000e: call System.Void TheForestOfLove.InstancedStoryOverlayUI::PlayTimelineAnimation(UnityEngine.Playables.PlayableAsset)
IL_0013: ldarg.0
IL_0014: ldfld System.Single TheForestOfLove.InstancedStoryOverlayUI::unlockingLockPadSoundDelay
IL_0019: ldc.r4 0
IL_001e: ble.un.s IL_0039
IL_0020: ldarg.0
IL_0021: ldfld System.Single TheForestOfLove.InstancedStoryOverlayUI::unlockingLockPadSoundDelay
IL_0026: ldarg.0
IL_0027: ldftn System.Void TheForestOfLove.InstancedStoryOverlayUI::PlayUnlockSound()
IL_002d: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0032: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0037: br.s IL_003f
IL_0039: ldarg.0
IL_003a: call System.Void TheForestOfLove.InstancedStoryOverlayUI::PlayUnlockSound()
IL_003f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationStarted_AutoClearListeners
IL_0044: dup
IL_0045: brtrue.s IL_004a
IL_0047: pop
IL_0048: br.s IL_004f
IL_004a: call System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_004f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InstancedStoryOverlayUI::onNotificationStarted_AutoClearListeners
IL_0054: callvirt System.Void UnityEngine.Events.UnityEventBase::RemoveAllListeners()
IL_0059: ldarg.0
IL_005a: ldfld UnityEngine.Playables.PlayableAsset TheForestOfLove.InstancedStoryOverlayUI::lockUnlockFromMinimized
IL_005f: callvirt System.Double UnityEngine.Playables.PlayableAsset::get_duration()
IL_0064: conv.r4
IL_0065: ldc.r4 -0.5
IL_006a: add
IL_006b: ldsfld System.Action TheForestOfLove.InstancedStoryOverlayUI/<>c::<>9__42_0
IL_0070: dup
IL_0071: brtrue.s IL_008a
IL_0073: pop
IL_0074: ldsfld TheForestOfLove.InstancedStoryOverlayUI/<>c TheForestOfLove.InstancedStoryOverlayUI/<>c::<>9
IL_0079: ldftn System.Void TheForestOfLove.InstancedStoryOverlayUI/<>c::<EndNotification>b__42_0()
IL_007f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0084: dup
IL_0085: stsfld System.Action TheForestOfLove.InstancedStoryOverlayUI/<>c::<>9__42_0
IL_008a: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_008f: ret
