TYPE TheForestOfLove.BuckyStormQuestMinigameSubController
METHOD System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::OnSuccess() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Events.UnityEvent`1<System.Int32> TheForestOfLove.BuckyStormQuestMinigameSubController::onPlayerStoppedTicker
IL_0006: ldc.i4.0
IL_0007: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Int32>::Invoke(!0)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::uiBackgroundAnimatorSuccess
IL_0012: ldstr "stormQuest_BuckyMinigameUiBackground_Action"
IL_0017: callvirt System.Void UnityEngine.Animator::Play(System.String)
IL_001c: ldc.r4 0.7
IL_0021: ldarg.0
IL_0022: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.BuckyStormQuestMinigameSubController::onFinishedBackgroundAnimation
IL_0027: ldftn System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_002d: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0032: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0037: ret
METHOD System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::OnFailure(System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Events.UnityEvent`1<System.Int32> TheForestOfLove.BuckyStormQuestMinigameSubController::onPlayerStoppedTicker
IL_0006: ldarg.1
IL_0007: brtrue.s IL_000c
IL_0009: ldc.i4.1
IL_000a: br.s IL_000d
IL_000c: ldc.i4.m1
IL_000d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Int32>::Invoke(!0)
IL_0012: ldarg.0
IL_0013: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::uiBackgroundAnimatorFailure
IL_0018: ldstr "stormQuest_BuckyMinigameUiBackground_Action"
IL_001d: callvirt System.Void UnityEngine.Animator::Play(System.String)
IL_0022: ldc.r4 0.7
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.BuckyStormQuestMinigameSubController::onFinishedBackgroundAnimation
IL_002d: ldftn System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0033: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0038: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_003d: ret
METHOD System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::ChooseNewTargets(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::FreezeTickerAndDisableInput()
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::uiBackgroundAnimatorSuccess
IL_000c: ldstr "stormQuest_BuckyMinigameUiBackground_Idle"
IL_0011: callvirt System.Void UnityEngine.Animator::Play(System.String)
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::uiBackgroundAnimatorFailure
IL_001c: ldstr "stormQuest_BuckyMinigameUiBackground_Idle"
IL_0021: callvirt System.Void UnityEngine.Animator::Play(System.String)
IL_0026: ldarg.1
IL_0027: ldc.i4.3
IL_0028: bne.un.s IL_003f
IL_002a: ldarg.0
IL_002b: ldfld System.Int32 TheForestOfLove.BuckyStormQuestMinigameSubController::level3TargetWidth
IL_0030: stloc.0
IL_0031: ldarg.0
IL_0032: ldarg.0
IL_0033: ldfld System.Single TheForestOfLove.BuckyStormQuestMinigameSubController::level3TickerSpeed
IL_0038: stfld System.Single TheForestOfLove.BuckyStormQuestMinigameSubController::currentSpeed
IL_003d: br.s IL_006b
IL_003f: ldarg.1
IL_0040: ldc.i4.2
IL_0041: bne.un.s IL_0058
IL_0043: ldarg.0
IL_0044: ldfld System.Int32 TheForestOfLove.BuckyStormQuestMinigameSubController::level2TargetWidth
IL_0049: stloc.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld System.Single TheForestOfLove.BuckyStormQuestMinigameSubController::level2TickerSpeed
IL_0051: stfld System.Single TheForestOfLove.BuckyStormQuestMinigameSubController::currentSpeed
IL_0056: br.s IL_006b
IL_0058: ldarg.0
IL_0059: ldfld System.Int32 TheForestOfLove.BuckyStormQuestMinigameSubController::level1TargetWidth
IL_005e: stloc.0
IL_005f: ldarg.0
IL_0060: ldarg.0
IL_0061: ldfld System.Single TheForestOfLove.BuckyStormQuestMinigameSubController::level1TickerSpeed
IL_0066: stfld System.Single TheForestOfLove.BuckyStormQuestMinigameSubController::currentSpeed
IL_006b: ldloc.0
IL_006c: ldc.i4.s 18
IL_006e: ldc.i4.s 95
IL_0070: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_0075: stloc.0
IL_0076: ldarg.0
IL_0077: ldfld System.Int32 TheForestOfLove.BuckyStormQuestMinigameSubController::targetAreaBorderPadding
IL_007c: ldc.i4.s 113
IL_007e: ldloc.0
IL_007f: sub
IL_0080: ldarg.0
IL_0081: ldfld System.Int32 TheForestOfLove.BuckyStormQuestMinigameSubController::targetAreaBorderPadding
IL_0086: sub
IL_0087: call System.Int32 UnityEngine.Random::Range(System.Int32,System.Int32)
IL_008c: stloc.1
IL_008d: ldarg.0
IL_008e: ldfld UnityEngine.RectTransform TheForestOfLove.BuckyStormQuestMinigameSubController::targetArea
IL_0093: ldloc.1
IL_0094: conv.r4
IL_0095: ldarg.0
IL_0096: ldfld UnityEngine.RectTransform TheForestOfLove.BuckyStormQuestMinigameSubController::targetArea
IL_009b: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_00a0: ldfld System.Single UnityEngine.Vector3::y
IL_00a5: ldarg.0
IL_00a6: ldfld UnityEngine.RectTransform TheForestOfLove.BuckyStormQuestMinigameSubController::targetArea
IL_00ab: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_00b0: ldfld System.Single UnityEngine.Vector3::z
IL_00b5: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_00ba: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_00bf: ldarg.0
IL_00c0: ldfld UnityEngine.RectTransform TheForestOfLove.BuckyStormQuestMinigameSubController::targetArea
IL_00c5: ldloc.0
IL_00c6: conv.r4
IL_00c7: ldarg.0
IL_00c8: ldfld UnityEngine.RectTransform TheForestOfLove.BuckyStormQuestMinigameSubController::targetArea
IL_00cd: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_sizeDelta()
IL_00d2: ldfld System.Single UnityEngine.Vector2::y
IL_00d7: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_00dc: callvirt System.Void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)
IL_00e1: ldloc.1
IL_00e2: stloc.2
IL_00e3: ldc.i4.s 95
IL_00e5: ldloc.1
IL_00e6: ldloc.0
IL_00e7: add
IL_00e8: sub
IL_00e9: stloc.3
IL_00ea: ldloc.2
IL_00eb: ldloc.3
IL_00ec: ble.s IL_0106
IL_00ee: ldc.r4 0
IL_00f3: ldc.r4 1
IL_00f8: call System.Single UnityEngine.Random::Range(System.Single,System.Single)
IL_00fd: ldloc.2
IL_00fe: ldc.i4.8
IL_00ff: sub
IL_0100: conv.r4
IL_0101: mul
IL_0102: stloc.s V_4
IL_0104: br.s IL_0125
IL_0106: ldc.r4 0
IL_010b: ldc.r4 1
IL_0110: call System.Single UnityEngine.Random::Range(System.Single,System.Single)
IL_0115: ldloc.3
IL_0116: ldc.i4.8
IL_0117: sub
IL_0118: conv.r4
IL_0119: mul
IL_011a: stloc.s V_4
IL_011c: ldloc.s V_4
IL_011e: ldloc.1
IL_011f: ldloc.0
IL_0120: add
IL_0121: conv.r4
IL_0122: add
IL_0123: stloc.s V_4
IL_0125: ldloc.s V_4
IL_0127: ldc.r4 95
IL_012c: div
IL_012d: stloc.s V_5
IL_012f: ldc.r4 0
IL_0134: ldc.r4 1
IL_0139: call System.Single UnityEngine.Random::Range(System.Single,System.Single)
IL_013e: ldc.r4 0.5
IL_0143: clt
IL_0145: brfalse.s IL_0153
IL_0147: ldloc.s V_5
IL_0149: ldc.r4 0.5
IL_014e: mul
IL_014f: stloc.s V_6
IL_0151: br.s IL_0163
IL_0153: ldc.r4 1
IL_0158: ldloc.s V_5
IL_015a: ldc.r4 0.5
IL_015f: mul
IL_0160: sub
IL_0161: stloc.s V_6
IL_0163: ldarg.0
IL_0164: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::tickerAnimator
IL_0169: ldarg.0
IL_016a: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::tickerAnimator
IL_016f: ldc.i4.0
IL_0170: callvirt UnityEngine.AnimatorStateInfo UnityEngine.Animator::GetCurrentAnimatorStateInfo(System.Int32)
IL_0175: stloc.s V_7
IL_0177: ldloca.s V_7
IL_0179: call System.Int32 UnityEngine.AnimatorStateInfo::get_fullPathHash()
IL_017e: ldc.i4.0
IL_017f: ldloc.s V_6
IL_0181: callvirt System.Void UnityEngine.Animator::Play(System.Int32,System.Int32,System.Single)
IL_0186: ldarg.0
IL_0187: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::tickerShadowAnimator
IL_018c: ldarg.0
IL_018d: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::tickerAnimator
IL_0192: ldc.i4.0
IL_0193: callvirt UnityEngine.AnimatorStateInfo UnityEngine.Animator::GetCurrentAnimatorStateInfo(System.Int32)
IL_0198: stloc.s V_7
IL_019a: ldloca.s V_7
IL_019c: call System.Int32 UnityEngine.AnimatorStateInfo::get_fullPathHash()
IL_01a1: ldc.i4.0
IL_01a2: ldloc.s V_6
IL_01a4: callvirt System.Void UnityEngine.Animator::Play(System.Int32,System.Int32,System.Single)
IL_01a9: ldarg.0
IL_01aa: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::resultAnimator
IL_01af: ldarg.0
IL_01b0: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::tickerAnimator
IL_01b5: ldc.i4.0
IL_01b6: callvirt UnityEngine.AnimatorStateInfo UnityEngine.Animator::GetCurrentAnimatorStateInfo(System.Int32)
IL_01bb: stloc.s V_7
IL_01bd: ldloca.s V_7
IL_01bf: call System.Int32 UnityEngine.AnimatorStateInfo::get_fullPathHash()
IL_01c4: ldc.i4.0
IL_01c5: ldloc.s V_6
IL_01c7: callvirt System.Void UnityEngine.Animator::Play(System.Int32,System.Int32,System.Single)
IL_01cc: ret
