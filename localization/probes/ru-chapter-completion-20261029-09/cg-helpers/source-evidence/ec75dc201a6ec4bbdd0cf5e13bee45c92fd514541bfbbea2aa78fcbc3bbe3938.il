TYPE TheForestOfLove.ItemGetNotification
METHOD System.Void TheForestOfLove.ItemGetNotification::ShowItemGetNotification() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.ItemGetNotification::itemGetNotifications
IL_0006: callvirt System.Int32 System.Collections.Generic.Queue`1<TheForestOfLove.Inventory.InventoryItemType>::get_Count()
IL_000b: ldc.i4.0
IL_000c: ble.s IL_002c
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.ItemGetNotification::itemGetNotifications
IL_0014: callvirt !0 System.Collections.Generic.Queue`1<TheForestOfLove.Inventory.InventoryItemType>::Dequeue()
IL_0019: stloc.0
IL_001a: ldarg.0
IL_001b: ldloc.0
IL_001c: call System.Void TheForestOfLove.ItemGetNotification::ShowInventoryItemNotification(TheForestOfLove.Inventory.InventoryItemType)
IL_0021: ldarg.0
IL_0022: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.ItemGetNotification::itemGetNotifications
IL_0027: callvirt System.Void System.Collections.Generic.Queue`1<TheForestOfLove.Inventory.InventoryItemType>::Clear()
IL_002c: ret
