TYPE TheForestOfLove.OverworldAllInOneNotification
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::OnAdventureUnlocked(TheForestOfLove.Narrative.Adventure) | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Globals::isChapterSelect
IL_0005: brtrue.s IL_000e
IL_0007: ldsfld System.Boolean Globals::isCheatCode
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: newobj System.Void TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::.ctor()
IL_0014: dup
IL_0015: ldc.i4.7
IL_0016: stfld TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::notificationType
IL_001b: dup
IL_001c: ldarg.1
IL_001d: callvirt System.String TheForestOfLove.Narrative.Adventure::get_NotificationTitle()
IL_0022: stfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::adventureTitle
IL_0027: stloc.0
IL_0028: ldarg.0
IL_0029: ldloc.0
IL_002a: call System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueNotification(TheForestOfLove.OverworldAllInOneNotification/QueuedNotification)
IL_002f: ret
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::OnAdventureAbandoned(TheForestOfLove.Narrative.Adventure) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::.ctor()
IL_0005: dup
IL_0006: ldc.i4.8
IL_0007: stfld TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::notificationType
IL_000c: dup
IL_000d: ldarg.1
IL_000e: callvirt System.String TheForestOfLove.Narrative.Adventure::get_NotificationTitle()
IL_0013: stfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::adventureTitle
IL_0018: stloc.0
IL_0019: ldarg.0
IL_001a: ldloc.0
IL_001b: call System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueNotification(TheForestOfLove.OverworldAllInOneNotification/QueuedNotification)
IL_0020: ret
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::OnAdventureCompleted(TheForestOfLove.Narrative.Adventure) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::.ctor()
IL_0005: dup
IL_0006: ldc.i4.s 9
IL_0008: stfld TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::notificationType
IL_000d: dup
IL_000e: ldarg.1
IL_000f: callvirt System.String TheForestOfLove.Narrative.Adventure::get_NotificationTitle()
IL_0014: stfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::adventureTitle
IL_0019: stloc.0
IL_001a: ldarg.0
IL_001b: ldloc.0
IL_001c: call System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueNotification(TheForestOfLove.OverworldAllInOneNotification/QueuedNotification)
IL_0021: ret
