TYPE TheForestOfLove.Content.BaseSpawner
METHOD System.Void TheForestOfLove.Content.BaseSpawner::TryShowOutOfSyncContentNotification() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Int32 TheForestOfLove.GameVersionHelper::GetLastSavedGameVersion()
IL_0005: ldc.i4 20240406
IL_000a: bgt.s IL_0037
IL_000c: ldstr "MelodyQuest_PhotoshootConclusion"
IL_0011: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0016: brfalse.s IL_0037
IL_0018: ldstr "act3_melodyquest_stormscene_continuation"
IL_001d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0022: brtrue.s IL_0037
IL_0024: ldarg.0
IL_0025: ldc.i4 20240406
IL_002a: ldc.i4 2600
IL_002f: call System.Boolean TheForestOfLove.Content.BaseSpawner::TryShowOutOfSyncContentNotification(System.Int32,TheForestOfLove.Narrative.Chapter)
IL_0034: brfalse.s IL_0037
IL_0036: ret
IL_0037: call System.Int32 TheForestOfLove.GameVersionHelper::GetLastSavedGameVersion()
IL_003c: ldc.i4 20240603
IL_0041: bgt.s IL_006e
IL_0043: ldstr "StormQuest_MabelGrabbedTheLastPage"
IL_0048: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_004d: brfalse.s IL_006e
IL_004f: ldstr "act3_stormquest_afterstorm_continuation"
IL_0054: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0059: brtrue.s IL_006e
IL_005b: ldarg.0
IL_005c: ldc.i4 20240603
IL_0061: ldc.i4 2700
IL_0066: call System.Boolean TheForestOfLove.Content.BaseSpawner::TryShowOutOfSyncContentNotification(System.Int32,TheForestOfLove.Narrative.Chapter)
IL_006b: brfalse.s IL_006e
IL_006d: ret
IL_006e: call System.Int32 TheForestOfLove.GameVersionHelper::GetLastSavedGameVersion()
IL_0073: ldc.i4 20250328
IL_0078: bgt.s IL_0096
IL_007a: ldc.i4 20250328
IL_007f: call System.Boolean TheForestOfLove.GameVersionHelper::HasShownOosNotificationForGameVersionKey(System.Int32)
IL_0084: brtrue.s IL_0096
IL_0086: ldc.i4 20250328
IL_008b: call System.Void TheForestOfLove.GameVersionHelper::SaveOosNotificationFlagForGameVersionKey(System.Int32)
IL_0090: ldarg.0
IL_0091: call System.Void TheForestOfLove.Content.BaseSpawner::DoAdventureModeUpgradeScriptV041()
IL_0096: call System.Int32 TheForestOfLove.GameVersionHelper::GetLastSavedGameVersion()
IL_009b: ldc.i4 20250522
IL_00a0: bge.s IL_00a8
IL_00a2: ldarg.0
IL_00a3: call System.Void TheForestOfLove.Content.BaseSpawner::DoMelodyFlipbookQuestUpgradeScriptV042()
IL_00a8: ret
METHOD System.Boolean TheForestOfLove.Content.BaseSpawner::TryShowOutOfSyncContentNotification(System.Int32,TheForestOfLove.Narrative.Chapter) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.Int32 TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::gameVersionKey
IL_000d: ldloc.0
IL_000e: ldfld System.Int32 TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::gameVersionKey
IL_0013: call System.Boolean TheForestOfLove.GameVersionHelper::HasShownOosNotificationForGameVersionKey(System.Int32)
IL_0018: brfalse.s IL_001c
IL_001a: ldc.i4.0
IL_001b: ret
IL_001c: ldloc.0
IL_001d: ldarg.2
IL_001e: call TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Services.Persistence.DataService::GetChapterRecordByChapter(TheForestOfLove.Narrative.Chapter)
IL_0023: stfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::chapterRecord
IL_0028: ldloc.0
IL_0029: ldfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::chapterRecord
IL_002e: brtrue.s IL_0032
IL_0030: ldc.i4.0
IL_0031: ret
IL_0032: ldloc.0
IL_0033: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ItemGetNotification>()
IL_0038: stfld TheForestOfLove.ItemGetNotification TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::itemGetNotification
IL_003d: ldloc.0
IL_003e: ldfld TheForestOfLove.ItemGetNotification TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::itemGetNotification
IL_0043: ldnull
IL_0044: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0049: brfalse.s IL_004d
IL_004b: ldc.i4.0
IL_004c: ret
IL_004d: ldloc.0
IL_004e: ldstr "''{0}''"
IL_0053: ldloc.0
IL_0054: ldfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::chapterRecord
IL_0059: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::title
IL_005e: call System.String System.String::Format(System.String,System.Object)
IL_0063: stfld System.String TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::chapterNameText
IL_0068: ldloc.0
IL_0069: ldloc.0
IL_006a: ldftn System.Void TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::<TryShowOutOfSyncContentNotification>b__0()
IL_0070: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0075: stfld System.Action TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::onYes
IL_007a: ldloc.0
IL_007b: ldsfld System.Action TheForestOfLove.Content.BaseSpawner/<>c::<>9__38_1
IL_0080: dup
IL_0081: brtrue.s IL_009a
IL_0083: pop
IL_0084: ldsfld TheForestOfLove.Content.BaseSpawner/<>c TheForestOfLove.Content.BaseSpawner/<>c::<>9
IL_0089: ldftn System.Void TheForestOfLove.Content.BaseSpawner/<>c::<TryShowOutOfSyncContentNotification>b__38_1()
IL_008f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0094: dup
IL_0095: stsfld System.Action TheForestOfLove.Content.BaseSpawner/<>c::<>9__38_1
IL_009a: stfld System.Action TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::onNo
IL_009f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_00a4: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00a9: ldc.r4 1.5
IL_00ae: ldloc.0
IL_00af: ldftn System.Void TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::<TryShowOutOfSyncContentNotification>b__2()
IL_00b5: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00ba: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00bf: ldc.i4.1
IL_00c0: ret
METHOD System.Void TheForestOfLove.Content.BaseSpawner::DoAdventureModeUpgradeScriptV041() | attributes=Private, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.StoryManager>()
IL_0005: stloc.0
IL_0006: ldc.i4.1
IL_0007: stsfld System.Boolean Globals::isCheatCode
IL_000c: ldstr "BotbMabel_ReturnToMabel"
IL_0011: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0016: brfalse.s IL_0038
IL_0018: ldc.i4.s 100
IL_001a: call TheForestOfLove.Narrative.Adventure TheForestOfLove.Services.Persistence.DataService::GetAdventureByAdventureType(TheForestOfLove.Narrative.AdventureType)
IL_001f: callvirt System.Void TheForestOfLove.Narrative.Adventure::UnlockAndCompleteOnce()
IL_0024: ldstr "unlock_adventure_blessing_of_the_bells"
IL_0029: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_002e: ldstr "completed_adventure_blessing_of_the_bells"
IL_0033: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0038: ldstr "BootyLineUpQuest_ReturnToBunnies"
IL_003d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0042: brfalse.s IL_0073
IL_0044: ldloc.0
IL_0045: ldstr "BootyLineUpQuest_BunniesAdventureTeaser"
IL_004a: ldnull
IL_004b: callvirt System.Void TheForestOfLove.Narrative.StoryManager::MarkConversationsAsPlayed(System.String,System.String)
IL_0050: ldc.i4 200
IL_0055: call TheForestOfLove.Narrative.Adventure TheForestOfLove.Services.Persistence.DataService::GetAdventureByAdventureType(TheForestOfLove.Narrative.AdventureType)
IL_005a: callvirt System.Void TheForestOfLove.Narrative.Adventure::UnlockAndCompleteOnce()
IL_005f: ldstr "unlock_adventure_dungeons_and_juices_1"
IL_0064: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0069: ldstr "completed_adventure_dungeons_and_juices_1"
IL_006e: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0073: ldstr "BootyLineUpFemalesQuest_ReturnToBunnies"
IL_0078: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_007d: brfalse.s IL_00ae
IL_007f: ldloc.0
IL_0080: ldstr "BootyLineUpFemalesQuest_BunniesAdventureTeaser"
IL_0085: ldnull
IL_0086: callvirt System.Void TheForestOfLove.Narrative.StoryManager::MarkConversationsAsPlayed(System.String,System.String)
IL_008b: ldc.i4 300
IL_0090: call TheForestOfLove.Narrative.Adventure TheForestOfLove.Services.Persistence.DataService::GetAdventureByAdventureType(TheForestOfLove.Narrative.AdventureType)
IL_0095: callvirt System.Void TheForestOfLove.Narrative.Adventure::UnlockAndCompleteOnce()
IL_009a: ldstr "unlock_adventure_dungeons_and_juices_2"
IL_009f: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_00a4: ldstr "completed_adventure_dungeons_and_juices_2"
IL_00a9: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_00ae: ldstr "SeasonsGreetingsQuest_TalkToDustin"
IL_00b3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00b8: brfalse.s IL_00dd
IL_00ba: ldc.i4 500
IL_00bf: call TheForestOfLove.Narrative.Adventure TheForestOfLove.Services.Persistence.DataService::GetAdventureByAdventureType(TheForestOfLove.Narrative.AdventureType)
IL_00c4: callvirt System.Void TheForestOfLove.Narrative.Adventure::UnlockAndCompleteOnce()
IL_00c9: ldstr "unlock_adventure_seasons_greetings"
IL_00ce: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_00d3: ldstr "completed_adventure_seasons_greetings"
IL_00d8: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_00dd: ldstr "MaverickSideHustleQuest_ReturnToOliver"
IL_00e2: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00e7: brfalse.s IL_010c
IL_00e9: ldc.i4 400
IL_00ee: call TheForestOfLove.Narrative.Adventure TheForestOfLove.Services.Persistence.DataService::GetAdventureByAdventureType(TheForestOfLove.Narrative.AdventureType)
IL_00f3: callvirt System.Void TheForestOfLove.Narrative.Adventure::UnlockAndCompleteOnce()
IL_00f8: ldstr "unlock_adventure_mystery_meets"
IL_00fd: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0102: ldstr "completed_adventure_mystery_meets"
IL_0107: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_010c: leave.s IL_0115
IL_010e: ldc.i4.0
IL_010f: stsfld System.Boolean Globals::isCheatCode
IL_0114: endfinally
IL_0115: ret
