TYPE TheForestOfLove.ItemGetNotification
METHOD System.Void TheForestOfLove.ItemGetNotification::ResetAnimatorTriggers() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::notificationAnimator
IL_0006: ldstr "hide"
IL_000b: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::notificationAnimator
IL_0016: ldstr "show"
IL_001b: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_0020: ret
