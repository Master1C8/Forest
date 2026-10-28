TYPE TheForestOfLove.BunnyCuckMoviePeter
METHOD System.Void TheForestOfLove.BunnyCuckMoviePeter::JumpToLoop(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.BunnyCuckMoviePeter::DestroyAllSpawnedCum()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.BunnyCuckMoviePeter::ClearAllAnimatorTriggers()
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.Animator TheForestOfLove.BunnyCuckMoviePeter::peterAnimator
IL_0012: ldarg.0
IL_0013: ldarg.1
IL_0014: call System.String TheForestOfLove.BunnyCuckMoviePeter::GetTriggerNameFromLoopNumber(System.Int32)
IL_0019: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_001e: ldarg.0
IL_001f: ldfld TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationLoopController TheForestOfLove.BunnyCuckMoviePeter::loopController
IL_0024: callvirt System.Void TheForestOfLove.BunnyCuckMoviePeter/Internal_AnimationLoopController::OnJump()
IL_0029: ret
