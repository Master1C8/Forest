TYPE TheForestOfLove.Narrative.NarrativeActions
METHOD System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItemType) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Services.Persistence.DataService::GetInventoryItemByItemType(TheForestOfLove.Inventory.InventoryItemType)
IL_0006: call System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItem)
IL_000b: ret
METHOD System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItem) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: brtrue.s IL_0005
IL_0003: ldc.i4.0
IL_0004: ret
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 TheForestOfLove.Inventory.InventoryItem::quantity
IL_000b: ret
