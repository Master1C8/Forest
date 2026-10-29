TYPE TheForestOfLove.DialogueCanvasItemGetNotificationController
METHOD System.Void TheForestOfLove.DialogueCanvasItemGetNotificationController::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld TheForestOfLove.Events.InventoryEvent TheForestOfLove.Events.NarrativeEvents::onInventoryItemAdded
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.DialogueCanvasItemGetNotificationController::OnItemAdded(TheForestOfLove.Inventory.InventoryItem,System.Int32)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_001c: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowItemGetAchievement
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.DialogueCanvasItemGetNotificationController::HideQuickly()
IL_0028: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0032: ret
METHOD System.Void TheForestOfLove.DialogueCanvasItemGetNotificationController::HideQuickly() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.DialogueCanvasItemGetNotificationController::showingNotification
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld UnityEngine.Animator TheForestOfLove.DialogueCanvasItemGetNotificationController::itemGetNotificationAnimator
IL_000f: ldstr "show"
IL_0014: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.Animator TheForestOfLove.DialogueCanvasItemGetNotificationController::itemGetNotificationAnimator
IL_001f: ldstr "hide_quickly"
IL_0024: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0029: ldarg.0
IL_002a: call System.Void TheForestOfLove.DialogueCanvasItemGetNotificationController::OnConversationEnded()
IL_002f: ret
