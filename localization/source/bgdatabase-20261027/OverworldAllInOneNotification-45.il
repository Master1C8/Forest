TYPE TheForestOfLove.OverworldAllInOneNotification
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::OnItemAdded(TheForestOfLove.Inventory.InventoryItem,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isAchievementItem
IL_0006: brtrue.s IL_0036
IL_0008: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_000d: brtrue.s IL_002e
IL_000f: ldarg.1
IL_0010: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_0015: ldc.i4 400
IL_001a: bne.un.s IL_0025
IL_001c: ldarg.0
IL_001d: ldarg.1
IL_001e: ldc.i4.1
IL_001f: call System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueItemNotification(TheForestOfLove.Inventory.InventoryItem,TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType)
IL_0024: ret
IL_0025: ldarg.0
IL_0026: ldarg.1
IL_0027: ldc.i4.0
IL_0028: call System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueItemNotification(TheForestOfLove.Inventory.InventoryItem,TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType)
IL_002d: ret
IL_002e: ldarg.0
IL_002f: ldarg.1
IL_0030: ldc.i4.2
IL_0031: call System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueItemNotification(TheForestOfLove.Inventory.InventoryItem,TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType)
IL_0036: ret
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::OnItemRemoved(TheForestOfLove.Inventory.InventoryItem,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0005: brfalse.s IL_000f
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: ldc.i4.3
IL_000a: call System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueItemNotification(TheForestOfLove.Inventory.InventoryItem,TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType)
IL_000f: ret
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::InstantiateNewNotification() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.MovieManager::get_isPlayingMovie()
IL_0005: brfalse.s IL_0010
IL_0007: call TheForestOfLove.Narrative.Movie TheForestOfLove.MovieManager::get_currentMovie()
IL_000c: ldc.i4.2
IL_000d: beq.s IL_0010
IL_000f: ret
IL_0010: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isTutorialPlaying()
IL_0015: brfalse.s IL_0018
IL_0017: ret
IL_0018: ldarg.0
IL_0019: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.OverworldAllInOneNotification/QueuedNotification> TheForestOfLove.OverworldAllInOneNotification::pendingNotifications
IL_001e: callvirt !0 System.Collections.Generic.Queue`1<TheForestOfLove.OverworldAllInOneNotification/QueuedNotification>::Dequeue()
IL_0023: stloc.0
IL_0024: ldloc.0
IL_0025: ldfld TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::notificationType
IL_002a: ldc.i4.1
IL_002b: bne.un.s IL_0058
IL_002d: ldarg.0
IL_002e: ldfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::glitchNotificationItemPrefab
IL_0033: ldarg.0
IL_0034: ldfld UnityEngine.Transform TheForestOfLove.OverworldAllInOneNotification::messageContainer
IL_0039: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.OverworldAllInOneNotificationItem>(!!0,UnityEngine.Transform)
IL_003e: stloc.1
IL_003f: ldarg.0
IL_0040: ldfld System.Single TheForestOfLove.OverworldAllInOneNotification::notificationIntervalSeconds
IL_0045: ldarg.0
IL_0046: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::<InstantiateNewNotification>b__23_0()
IL_004c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0051: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimerUnscaled(System.Single,System.Action)
IL_0056: br.s IL_006a
IL_0058: ldarg.0
IL_0059: ldfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::notificationItemPrefab
IL_005e: ldarg.0
IL_005f: ldfld UnityEngine.Transform TheForestOfLove.OverworldAllInOneNotification::messageContainer
IL_0064: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.OverworldAllInOneNotificationItem>(!!0,UnityEngine.Transform)
IL_0069: stloc.1
IL_006a: ldloc.0
IL_006b: ldfld TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::notificationType
IL_0070: stloc.2
IL_0071: ldloc.2
IL_0072: switch IL_00a4,IL_012c,IL_00b8,IL_00cc,IL_00e0,IL_00ee,IL_00f6,IL_0104,IL_0112,IL_0120
IL_009f: br IL_012c
IL_00a4: ldloc.1
IL_00a5: ldloc.0
IL_00a6: ldfld UnityEngine.Sprite TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::itemSprite
IL_00ab: ldloc.0
IL_00ac: ldfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::itemTitle
IL_00b1: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureItemFoundNotification(UnityEngine.Sprite,System.String)
IL_00b6: br.s IL_012c
IL_00b8: ldloc.1
IL_00b9: ldloc.0
IL_00ba: ldfld UnityEngine.Sprite TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::itemSprite
IL_00bf: ldloc.0
IL_00c0: ldfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::itemTitle
IL_00c5: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureItemGetNotification(UnityEngine.Sprite,System.String)
IL_00ca: br.s IL_012c
IL_00cc: ldloc.1
IL_00cd: ldloc.0
IL_00ce: ldfld UnityEngine.Sprite TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::itemSprite
IL_00d3: ldloc.0
IL_00d4: ldfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::itemTitle
IL_00d9: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureItemLostNotification(UnityEngine.Sprite,System.String)
IL_00de: br.s IL_012c
IL_00e0: ldloc.1
IL_00e1: ldloc.0
IL_00e2: ldfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::actorName
IL_00e7: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureGossipUnlockedNotification(System.String)
IL_00ec: br.s IL_012c
IL_00ee: ldloc.1
IL_00ef: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureGlobalGossipUnlockedNotification()
IL_00f4: br.s IL_012c
IL_00f6: ldloc.1
IL_00f7: ldloc.0
IL_00f8: ldfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::actorName
IL_00fd: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureBioUnlockedNotification(System.String)
IL_0102: br.s IL_012c
IL_0104: ldloc.1
IL_0105: ldloc.0
IL_0106: ldfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::adventureTitle
IL_010b: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureAdventureUnlockedNotification(System.String)
IL_0110: br.s IL_012c
IL_0112: ldloc.1
IL_0113: ldloc.0
IL_0114: ldfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::adventureTitle
IL_0119: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureAdventureAbandonedNotification(System.String)
IL_011e: br.s IL_012c
IL_0120: ldloc.1
IL_0121: ldloc.0
IL_0122: ldfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::adventureTitle
IL_0127: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureAdventureCompletedNotification(System.String)
IL_012c: ldloc.1
IL_012d: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::FadeIn()
IL_0132: ldarg.0
IL_0133: ldloc.1
IL_0134: stfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::currentForegroundItem
IL_0139: ret
