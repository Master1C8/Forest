TYPE TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationLoopController
METHOD System.Void TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationLoopController::DisableBlinking(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldc.i4.0
IL_0002: ble.s IL_0005
IL_0004: ret
IL_0005: ldarg.0
IL_0006: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationWorker::movie
IL_000b: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::ClearBlinkAnimatorTriggers()
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationWorker::movie
IL_0016: ldstr ""
IL_001b: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::SetBlinkBTreeTriggerName(System.String)
IL_0020: ldarg.0
IL_0021: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationWorker::movie
IL_0026: ldfld UnityEngine.Animator TheForestOfLove.BunnyCuckMoviePeter::blinkAnimator
IL_002b: ldstr "hide"
IL_0030: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0035: ret
METHOD System.Void TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationLoopController::EnableBlinking(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldc.i4.0
IL_0002: ble.s IL_0005
IL_0004: ret
IL_0005: ldarg.0
IL_0006: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationWorker::movie
IL_000b: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::ClearBlinkAnimatorTriggers()
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationWorker::movie
IL_0016: ldstr "main"
IL_001b: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter::SetBlinkBTreeTriggerName(System.String)
IL_0020: ldarg.0
IL_0021: ldfld TheForestOfLove.BunnyCuckMoviePeter TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationWorker::movie
IL_0026: ldfld UnityEngine.Animator TheForestOfLove.BunnyCuckMoviePeter::blinkAnimator
IL_002b: ldstr "hide"
IL_0030: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0035: ret
