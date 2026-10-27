TYPE TheForestOfLove.OverworldAllInOneNotification
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::OnBioUnlocked(TheForestOfLove.Narrative.Actor,TheForestOfLove.Narrative.BioKeyword) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedNotebook()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldarg.0
IL_0009: ldarg.1
IL_000a: ldc.i4.6
IL_000b: call System.Void TheForestOfLove.OverworldAllInOneNotification::EnqueueGossipNotification(TheForestOfLove.Narrative.Actor,TheForestOfLove.OverworldAllInOneNotification/QueuedNotificationType)
IL_0010: ret
