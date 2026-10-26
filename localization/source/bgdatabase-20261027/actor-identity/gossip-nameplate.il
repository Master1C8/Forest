TYPE TheForestOfLove.OverworldAllInOneNotification
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueGossipNotification(TheForestOfLove.Narrative.Actor,TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::.ctor()
IL_0005: dup
IL_0006: ldarg.2
IL_0007: stfld TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::notificationType
IL_000c: dup
IL_000d: ldarg.1
IL_000e: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_0013: brtrue.s IL_001c
IL_0015: ldstr "???"
IL_001a: br.s IL_0022
IL_001c: ldarg.1
IL_001d: callvirt System.String TheForestOfLove.Narrative.Actor::get_NameplateName()
IL_0022: stfld System.String TheForestOfLove.OverworldAllInOneNotification/QueuedNotification::actorName
IL_0027: stloc.0
IL_0028: ldarg.0
IL_0029: ldloc.0
IL_002a: call System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueNotification(TheForestOfLove.OverworldAllInOneNotification/QueuedNotification)
IL_002f: ret
