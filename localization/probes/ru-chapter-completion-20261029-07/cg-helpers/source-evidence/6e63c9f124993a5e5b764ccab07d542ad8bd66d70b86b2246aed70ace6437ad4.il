TYPE TheForestOfLove.ItemGetNotification/<>c
METHOD System.Void TheForestOfLove.ItemGetNotification/<>c::<ShowOutOfSyncContentNotification>b__82_0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldc.i4 500
IL_0005: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_000a: ret

TYPE TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0
METHOD System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::<ShowOutOfSyncContentNotification>b__1() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.OutOfSyncContentNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::notification
IL_0006: callvirt System.Void TheForestOfLove.OutOfSyncContentNotification::EnableNavigation()
IL_000b: ret
METHOD System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::<ShowOutOfSyncContentNotification>b__2() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.ItemGetNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::<>4__this
IL_0006: call System.Void TheForestOfLove.ItemGetNotification::HideNotification_CleanedUp()
IL_000b: ldc.r4 1
IL_0010: ldarg.0
IL_0011: ldfld System.Action TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::<>9__3
IL_0016: dup
IL_0017: brtrue.s IL_002f
IL_0019: pop
IL_001a: ldarg.0
IL_001b: ldarg.0
IL_001c: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::<ShowOutOfSyncContentNotification>b__3()
IL_0022: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0027: dup
IL_0028: stloc.0
IL_0029: stfld System.Action TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::<>9__3
IL_002e: ldloc.0
IL_002f: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0034: ret

TYPE TheForestOfLove.ItemGetNotification
METHOD System.Void TheForestOfLove.ItemGetNotification::StartNotification_CleanedUp(System.Boolean,System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.ItemGetNotification::get_visible()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.1
IL_000b: call System.Void TheForestOfLove.ItemGetNotification::set_visible(System.Boolean)
IL_0010: ldarg.0
IL_0011: call System.Void TheForestOfLove.ItemGetNotification::ResetAnimatorTriggers()
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::notificationAnimator
IL_001c: ldstr "show"
IL_0021: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0026: ldarg.0
IL_0027: ldc.r4 0
IL_002c: stfld System.Single TheForestOfLove.ItemGetNotification::currentOpenTime
IL_0031: ldarg.0
IL_0032: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::continueButtonAnimator
IL_0037: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_003c: ldarg.1
IL_003d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0042: ldarg.0
IL_0043: ldfld UnityEngine.CanvasGroup TheForestOfLove.ItemGetNotification::itemGetPanelGroup
IL_0048: ldarg.2
IL_0049: callvirt System.Void UnityEngine.CanvasGroup::set_interactable(System.Boolean)
IL_004e: ldarg.0
IL_004f: ldfld UnityEngine.CanvasGroup TheForestOfLove.ItemGetNotification::messageGroup
IL_0054: ldarg.2
IL_0055: callvirt System.Void UnityEngine.CanvasGroup::set_interactable(System.Boolean)
IL_005a: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowItemGetAchievement
IL_005f: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0064: ldsfld UnityEngine.Events.UnityEvent`1<System.Boolean> TheForestOfLove.Events.GameEvents::onShowItemGetAchievementOverloadedForAdventures
IL_0069: ldarg.0
IL_006a: ldfld System.Boolean TheForestOfLove.ItemGetNotification::showingAdventureNotification
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Boolean>::Invoke(!0)
IL_0074: ret
