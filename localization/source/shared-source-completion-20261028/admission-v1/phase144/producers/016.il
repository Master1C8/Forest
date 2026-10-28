TYPE TheForestOfLove.BuckyStormQuestMinigameSubController
METHOD System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::UiAnimatorShow() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.BuckyStormQuestMinigameSubController::uiAnimatorLastSetTrigger
IL_0006: ldstr "show"
IL_000b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0010: brfalse.s IL_0013
IL_0012: ret
IL_0013: ldarg.0
IL_0014: call System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::UiAnimatorClearTriggers()
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::uiShowHideAnimator
IL_001f: ldstr "show"
IL_0024: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0029: ldarg.0
IL_002a: ldstr "show"
IL_002f: stfld System.String TheForestOfLove.BuckyStormQuestMinigameSubController::uiAnimatorLastSetTrigger
IL_0034: ret
METHOD System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::UiAnimatorHide() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.BuckyStormQuestMinigameSubController::uiAnimatorLastSetTrigger
IL_0006: ldstr "hide"
IL_000b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0010: brfalse.s IL_0013
IL_0012: ret
IL_0013: ldarg.0
IL_0014: call System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::UiAnimatorClearTriggers()
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::uiShowHideAnimator
IL_001f: ldstr "hide"
IL_0024: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0029: ldarg.0
IL_002a: ldstr "hide"
IL_002f: stfld System.String TheForestOfLove.BuckyStormQuestMinigameSubController::uiAnimatorLastSetTrigger
IL_0034: ret
METHOD System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::UiAnimatorReset() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.BuckyStormQuestMinigameSubController::uiAnimatorLastSetTrigger
IL_0006: ldstr "reset"
IL_000b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0010: brfalse.s IL_0013
IL_0012: ret
IL_0013: ldarg.0
IL_0014: call System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::UiAnimatorClearTriggers()
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::uiShowHideAnimator
IL_001f: ldstr "reset"
IL_0024: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0029: ldarg.0
IL_002a: ldstr "reset"
IL_002f: stfld System.String TheForestOfLove.BuckyStormQuestMinigameSubController::uiAnimatorLastSetTrigger
IL_0034: ret
METHOD System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::UiAnimatorVisible() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.BuckyStormQuestMinigameSubController::uiAnimatorLastSetTrigger
IL_0006: ldstr "visible"
IL_000b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0010: brfalse.s IL_0013
IL_0012: ret
IL_0013: ldarg.0
IL_0014: call System.Void TheForestOfLove.BuckyStormQuestMinigameSubController::UiAnimatorClearTriggers()
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.Animator TheForestOfLove.BuckyStormQuestMinigameSubController::uiShowHideAnimator
IL_001f: ldstr "visible"
IL_0024: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0029: ldarg.0
IL_002a: ldstr "visible"
IL_002f: stfld System.String TheForestOfLove.BuckyStormQuestMinigameSubController::uiAnimatorLastSetTrigger
IL_0034: ret
