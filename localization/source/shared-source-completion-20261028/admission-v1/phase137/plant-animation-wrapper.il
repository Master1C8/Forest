TYPE TheForestOfLove.PlantMovie/Internal_AnimationInputHelper
METHOD System.Void TheForestOfLove.PlantMovie/Internal_AnimationInputHelper::SetAnimatorTriggers(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.PlantMovie TheForestOfLove.PlantMovie/Internal_AnimationWorker::movie
IL_0006: ldfld TheForestOfLove.PlantMovie/Internal_AnimationTransitionNotifier TheForestOfLove.PlantMovie::transitionNotifier
IL_000b: ldc.i4.1
IL_000c: callvirt System.Void TheForestOfLove.PlantMovie/Internal_AnimationTransitionNotifier::ResetAnimatorTriggers(System.Boolean)
IL_0011: ldarg.0
IL_0012: ldfld TheForestOfLove.PlantMovie TheForestOfLove.PlantMovie/Internal_AnimationWorker::movie
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.PlantMovie::backTentacleAnimator
IL_001c: ldstr "jump_to_loop_flaccid"
IL_0021: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0026: ldarg.1
IL_0027: ldstr "jump_to_loop_flaccid"
IL_002c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0031: brfalse.s IL_004a
IL_0033: ldarg.0
IL_0034: ldfld TheForestOfLove.PlantMovie TheForestOfLove.PlantMovie/Internal_AnimationWorker::movie
IL_0039: ldfld UnityEngine.Animator TheForestOfLove.PlantMovie::tentaclesAnimator
IL_003e: ldstr "jump_to_loop_flaccid"
IL_0043: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0048: br.s IL_005f
IL_004a: ldarg.0
IL_004b: ldfld TheForestOfLove.PlantMovie TheForestOfLove.PlantMovie/Internal_AnimationWorker::movie
IL_0050: ldfld UnityEngine.Animator TheForestOfLove.PlantMovie::tentaclesAnimator
IL_0055: ldstr "jump_to_loop_erect"
IL_005a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_005f: ldarg.0
IL_0060: ldfld TheForestOfLove.PlantMovie TheForestOfLove.PlantMovie/Internal_AnimationWorker::movie
IL_0065: ldfld UnityEngine.Animator TheForestOfLove.PlantMovie::redAnimator
IL_006a: ldarg.1
IL_006b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0070: ldarg.0
IL_0071: ldfld TheForestOfLove.PlantMovie TheForestOfLove.PlantMovie/Internal_AnimationWorker::movie
IL_0076: ldfld UnityEngine.Animator TheForestOfLove.PlantMovie::cumAnimator
IL_007b: ldarg.1
IL_007c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0081: ret
