TYPE TheForestOfLove.OverworldAllInOneNotification
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueItemNotification(TheForestOfLove.Inventory.InventoryItem,TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_000e
IL_0003: ldstr "no schema found for item"
IL_0008: call System.Void UnityEngine.Debug::Log(System.Object)
IL_000d: ret
IL_000e: newobj System.Void TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::.ctor()
IL_0013: dup
IL_0014: ldarg.2
IL_0015: stfld TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::notificationType
IL_001a: dup
IL_001b: ldarg.1
IL_001c: ldfld UnityEngine.Sprite TheForestOfLove.Inventory.InventoryItem::sprite
IL_0021: stfld UnityEngine.Sprite TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::itemSprite
IL_0026: dup
IL_0027: ldarg.1
IL_0028: ldfld System.String TheForestOfLove.Inventory.InventoryItem::title
IL_002d: stfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::itemTitle
IL_0032: stloc.0
IL_0033: ldarg.0
IL_0034: ldloc.0
IL_0035: call System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueNotification(TheForestOfLove.OverworldAllInOneNotification/QueuedNotification)
IL_003a: ret
