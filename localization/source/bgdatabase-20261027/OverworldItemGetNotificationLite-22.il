TYPE TheForestOfLove.OverworldItemGetNotificationLite
METHOD System.Void TheForestOfLove.OverworldItemGetNotificationLite::OnItemAdded(TheForestOfLove.Inventory.InventoryItem,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0005: brtrue.s IL_001b
IL_0007: ldarg.1
IL_0008: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isAchievementItem
IL_000d: brtrue.s IL_001b
IL_000f: ldarg.0
IL_0010: ldarg.1
IL_0011: ldfld System.String TheForestOfLove.Inventory.InventoryItem::title
IL_0016: call System.Void TheForestOfLove.OverworldItemGetNotificationLite::ShowNotification(System.String)
IL_001b: ret
