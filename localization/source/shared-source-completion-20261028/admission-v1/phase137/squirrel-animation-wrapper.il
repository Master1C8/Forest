TYPE TheForestOfLove.SquirrelAnalMovie/Internal_AnimationInputHelper
METHOD System.Void TheForestOfLove.SquirrelAnalMovie/Internal_AnimationInputHelper::SetAnimatorTriggers(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.SquirrelAnalMovie TheForestOfLove.SquirrelAnalMovie/Internal_AnimationWorker::movie
IL_0006: ldfld TheForestOfLove.SquirrelAnalMovie/Internal_AnimationTransitionNotifier TheForestOfLove.SquirrelAnalMovie::transitionNotifier
IL_000b: ldc.i4.1
IL_000c: callvirt System.Void TheForestOfLove.SquirrelAnalMovie/Internal_AnimationTransitionNotifier::ResetAnimatorTriggers(System.Boolean)
IL_0011: ldarg.0
IL_0012: ldfld TheForestOfLove.SquirrelAnalMovie TheForestOfLove.SquirrelAnalMovie/Internal_AnimationWorker::movie
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.SquirrelAnalMovie::duoAnimator
IL_001c: ldarg.1
IL_001d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.SquirrelAnalMovie TheForestOfLove.SquirrelAnalMovie/Internal_AnimationWorker::movie
IL_0028: ldfld UnityEngine.Animator TheForestOfLove.SquirrelAnalMovie::cumAnimator
IL_002d: ldarg.1
IL_002e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0033: ret
