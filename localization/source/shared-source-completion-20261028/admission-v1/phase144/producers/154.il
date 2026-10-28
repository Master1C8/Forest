TYPE TheForestOfLove.StormQuestLightningFlashController
METHOD System.Void TheForestOfLove.StormQuestLightningFlashController::<MegaFlash_Internal>b__29_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldstr "GameCameraPlane"
IL_0005: call EZCameraShake.CameraShaker EZCameraShake.CameraShaker::GetInstance(System.String)
IL_000a: ldarg.0
IL_000b: ldfld System.Single TheForestOfLove.StormQuestLightningFlashController::smashShakeMagnitude
IL_0010: ldarg.0
IL_0011: ldfld System.Single TheForestOfLove.StormQuestLightningFlashController::smashShakeRoughness
IL_0016: ldc.r4 0
IL_001b: ldarg.0
IL_001c: ldfld System.Single TheForestOfLove.StormQuestLightningFlashController::smashShakeFadeout
IL_0021: callvirt EZCameraShake.CameraShakeInstance EZCameraShake.CameraShaker::ShakeOnce(System.Single,System.Single,System.Single,System.Single)
IL_0026: pop
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.Animator TheForestOfLove.StormQuestLightningFlashController::animator
IL_002d: ldstr "strike"
IL_0032: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0037: ldstr "Strike"
IL_003c: stloc.0
IL_003d: ldarg.0
IL_003e: ldfld UnityEngine.Animator TheForestOfLove.StormQuestLightningFlashController::lightningBoltAnimator
IL_0043: ldloc.0
IL_0044: callvirt System.Void UnityEngine.Animator::Play(System.String)
IL_0049: ldarg.0
IL_004a: ldfld UnityEngine.Animator TheForestOfLove.StormQuestLightningFlashController::lightningScreenFlashAnimator
IL_004f: ldloc.0
IL_0050: callvirt System.Void UnityEngine.Animator::Play(System.String)
IL_0055: ldarg.0
IL_0056: ldfld UnityEngine.Animator TheForestOfLove.StormQuestLightningFlashController::lightningColorDodgeAnimator
IL_005b: ldloc.0
IL_005c: callvirt System.Void UnityEngine.Animator::Play(System.String)
IL_0061: ldarg.0
IL_0062: ldfld UnityEngine.Animator TheForestOfLove.StormQuestLightningFlashController::lightningAreaShadowsAnimator
IL_0067: ldloc.0
IL_0068: callvirt System.Void UnityEngine.Animator::Play(System.String)
IL_006d: ldarg.0
IL_006e: ldfld UnityEngine.Animator TheForestOfLove.StormQuestLightningFlashController::lightningStrikePlayerFxAnimator
IL_0073: ldloc.0
IL_0074: callvirt System.Void UnityEngine.Animator::Play(System.String)
IL_0079: ldc.r4 0.9
IL_007e: ldarg.0
IL_007f: ldftn System.Void TheForestOfLove.StormQuestLightningFlashController::EndMegaFlash()
IL_0085: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_008a: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_008f: ret
