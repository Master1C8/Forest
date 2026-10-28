TYPE TheForestOfLove.GeneralStoryUITransitionController
TYPE TheForestOfLove.GeneralStoryUITransitionController
METHOD System.Void TheForestOfLove.GeneralStoryUITransitionController::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.AnimationStateEventListener TheForestOfLove.GeneralStoryUITransitionController::animationStateEventListener
IL_000c: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.GeneralStoryUITransitionController::OnClipFinishedLoop(System.String)
IL_0018: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0022: ret
METHOD System.Void TheForestOfLove.GeneralStoryUITransitionController::OnClipFinishedLoop(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: call System.Void TheForestOfLove.GeneralStoryUITransitionController::set_IsTransitioning(System.Boolean)
IL_0007: ldarg.1
IL_0008: brfalse.s IL_0072
IL_000a: ldarg.1
IL_000b: ldstr "GeneralStoryAnimator_FadeFromBlack"
IL_0010: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0015: brtrue.s IL_0040
IL_0017: ldarg.1
IL_0018: ldstr "GeneralStoryAnimator_FadeFromWhite"
IL_001d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0022: brtrue.s IL_004d
IL_0024: ldarg.1
IL_0025: ldstr "GeneralStoryAnimator_FadeToBlack"
IL_002a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_002f: brtrue.s IL_005a
IL_0031: ldarg.1
IL_0032: ldstr "GeneralStoryAnimator_IdleBlack"
IL_0037: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_003c: brtrue.s IL_0067
IL_003e: br.s IL_0072
IL_0040: ldarg.0
IL_0041: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUITransitionController::onFadedFromBlack
IL_0046: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_004b: br.s IL_0072
IL_004d: ldarg.0
IL_004e: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUITransitionController::onFadedFromWhite
IL_0053: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0058: br.s IL_0072
IL_005a: ldarg.0
IL_005b: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUITransitionController::onFadedToBlack
IL_0060: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0065: br.s IL_0072
IL_0067: ldarg.0
IL_0068: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUITransitionController::onIdleBlack
IL_006d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0072: ldarg.0
IL_0073: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.GeneralStoryUITransitionController::onFinishedTransition
IL_0078: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_007d: ret
