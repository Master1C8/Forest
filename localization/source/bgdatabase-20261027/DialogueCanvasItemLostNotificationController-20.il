TYPE TheForestOfLove.DialogueCanvasItemLostNotificationController
METHOD System.Void TheForestOfLove.DialogueCanvasItemLostNotificationController::OnItemRemoved(TheForestOfLove.Inventory.InventoryItem,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0005: brfalse.s IL_0013
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: ldfld System.String TheForestOfLove.Inventory.InventoryItem::title
IL_000e: call System.Void TheForestOfLove.DialogueCanvasItemLostNotificationController::TakeItem(System.String)
IL_0013: ret
