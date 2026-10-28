TYPE TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationInputHelper
METHOD System.Void TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationInputHelper::SetAnimatorTriggers(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_0006: ldfld TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationTransitionNotifier TheForestOfLove.OliverBuckyOralMovie::transitionNotifier
IL_000b: ldc.i4.1
IL_000c: callvirt System.Void TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationTransitionNotifier::ResetAnimatorTriggers(System.Boolean)
IL_0011: ldarg.0
IL_0012: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.OliverBuckyOralMovie::charactersAnimator
IL_001c: ldarg.1
IL_001d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_0028: ldfld UnityEngine.Animator TheForestOfLove.OliverBuckyOralMovie::buckyBlinkAnimator
IL_002d: ldarg.1
IL_002e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0033: ldarg.0
IL_0034: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_0039: ldfld UnityEngine.Animator TheForestOfLove.OliverBuckyOralMovie::oliverBlinkAnimator
IL_003e: ldarg.1
IL_003f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0044: ldarg.0
IL_0045: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_004a: ldfld UnityEngine.Animator TheForestOfLove.OliverBuckyOralMovie::cumAnimator
IL_004f: ldarg.1
IL_0050: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0055: ret
