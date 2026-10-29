TYPE TheForestOfLove.OverworldAllInOneNotification
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::ShowNextNotification(System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.r4 0
IL_0006: stfld System.Single TheForestOfLove.OverworldAllInOneNotification::timeSinceLastNotification
IL_000b: ldarg.0
IL_000c: ldfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::currentBackgroundItem
IL_0011: ldnull
IL_0012: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0017: brfalse.s IL_002b
IL_0019: ldarg.0
IL_001a: ldfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::currentBackgroundItem
IL_001f: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::FadeOut()
IL_0024: ldarg.0
IL_0025: ldnull
IL_0026: stfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::currentBackgroundItem
IL_002b: ldarg.0
IL_002c: ldfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::currentForegroundItem
IL_0031: ldnull
IL_0032: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0037: brfalse.s IL_0075
IL_0039: ldarg.1
IL_003a: brtrue.s IL_0063
IL_003c: ldarg.0
IL_003d: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.OverworldAllInOneNotification/QueuedNotification> TheForestOfLove.OverworldAllInOneNotification::pendingNotifications
IL_0042: callvirt System.Int32 System.Collections.Generic.Queue`1<TheForestOfLove.OverworldAllInOneNotification/QueuedNotification>::get_Count()
IL_0047: ldc.i4.0
IL_0048: ble.s IL_0063
IL_004a: ldarg.0
IL_004b: ldfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::currentForegroundItem
IL_0050: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::MoveToBackground()
IL_0055: ldarg.0
IL_0056: ldarg.0
IL_0057: ldfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::currentForegroundItem
IL_005c: stfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::currentBackgroundItem
IL_0061: br.s IL_006e
IL_0063: ldarg.0
IL_0064: ldfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::currentForegroundItem
IL_0069: callvirt System.Void TheForestOfLove.OverworldAllInOneNotificationItem::FadeOut()
IL_006e: ldarg.0
IL_006f: ldnull
IL_0070: stfld TheForestOfLove.OverworldAllInOneNotificationItem TheForestOfLove.OverworldAllInOneNotification::currentForegroundItem
IL_0075: ldarg.0
IL_0076: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.OverworldAllInOneNotification/QueuedNotification> TheForestOfLove.OverworldAllInOneNotification::pendingNotifications
IL_007b: callvirt System.Int32 System.Collections.Generic.Queue`1<TheForestOfLove.OverworldAllInOneNotification/QueuedNotification>::get_Count()
IL_0080: brtrue.s IL_0083
IL_0082: ret
IL_0083: ldarg.1
IL_0084: brfalse.s IL_0087
IL_0086: ret
IL_0087: ldarg.0
IL_0088: call System.Void TheForestOfLove.OverworldAllInOneNotification::InstantiateNewNotification()
IL_008d: ret
