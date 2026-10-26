TYPE TheForestOfLove.Narrative.DataManifest
METHOD System.Void TheForestOfLove.Narrative.DataManifest::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Utility.IAddressableAssetLoader>::.ctor()
IL_0006: stfld System.Collections.Generic.List`1<TheForestOfLove.Utility.IAddressableAssetLoader> TheForestOfLove.Narrative.DataManifest::addressableAssets
IL_000b: ldarg.0
IL_000c: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor()
IL_0011: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tags
IL_0016: ldarg.0
IL_0017: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag>::.ctor()
IL_001c: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbName
IL_0021: ldarg.0
IL_0022: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::.ctor()
IL_0027: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_002c: ldarg.0
IL_002d: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag>::.ctor()
IL_0032: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::activeTagsByDbName
IL_0037: ldarg.0
IL_0038: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::.ctor()
IL_003d: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0042: ldarg.0
IL_0043: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::.ctor()
IL_0048: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbName
IL_004d: ldarg.0
IL_004e: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::.ctor()
IL_0053: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_0058: ldarg.0
IL_0059: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::.ctor()
IL_005e: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByPluginDbTriggerName
IL_0063: ldarg.0
IL_0064: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::.ctor()
IL_0069: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsBySavekey
IL_006e: ldarg.0
IL_006f: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait>::.ctor()
IL_0074: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait> TheForestOfLove.Narrative.DataManifest::portraits
IL_0079: ldarg.0
IL_007a: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Portrait,TheForestOfLove.Narrative.Portrait>::.ctor()
IL_007f: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Portrait,TheForestOfLove.Narrative.Portrait> TheForestOfLove.Narrative.DataManifest::portraitsByDbPortrait
IL_0084: ldarg.0
IL_0085: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.AreaRecord>::.ctor()
IL_008a: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.AreaRecord> TheForestOfLove.Narrative.DataManifest::areas
IL_008f: ldarg.0
IL_0090: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord>::.ctor()
IL_0095: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord> TheForestOfLove.Narrative.DataManifest::areasByDbName
IL_009a: ldarg.0
IL_009b: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Area,TheForestOfLove.Narrative.AreaRecord>::.ctor()
IL_00a0: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Area,TheForestOfLove.Narrative.AreaRecord> TheForestOfLove.Narrative.DataManifest::areasByDbArea
IL_00a5: ldarg.0
IL_00a6: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord>::.ctor()
IL_00ab: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord> TheForestOfLove.Narrative.DataManifest::areasBySavekey
IL_00b0: ldarg.0
IL_00b1: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord>::.ctor()
IL_00b6: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord> TheForestOfLove.Narrative.DataManifest::areasByUnitySceneName
IL_00bb: ldarg.0
IL_00bc: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::.ctor()
IL_00c1: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggers
IL_00c6: ldarg.0
IL_00c7: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::.ctor()
IL_00cc: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByTriggerName
IL_00d1: ldarg.0
IL_00d2: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::.ctor()
IL_00d7: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_00dc: ldarg.0
IL_00dd: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::.ctor()
IL_00e2: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersBySavekey
IL_00e7: ldarg.0
IL_00e8: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord>::.ctor()
IL_00ed: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::movies
IL_00f2: ldarg.0
IL_00f3: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.MovieRecord>::.ctor()
IL_00f8: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesByDbName
IL_00fd: ldarg.0
IL_00fe: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Movie,TheForestOfLove.Narrative.MovieRecord>::.ctor()
IL_0103: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesByDbMovie
IL_0108: ldarg.0
IL_0109: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.MovieRecord>::.ctor()
IL_010e: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesBySavekey
IL_0113: ldarg.0
IL_0114: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord>::.ctor()
IL_0119: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesByMovie
IL_011e: ldarg.0
IL_011f: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord>::.ctor()
IL_0124: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::globalMovies
IL_0129: ldarg.0
IL_012a: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord>::.ctor()
IL_012f: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::globalMoviesByMovie
IL_0134: ldarg.0
IL_0135: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::.ctor()
IL_013a: stfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItems
IL_013f: ldarg.0
IL_0140: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem>::.ctor()
IL_0145: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByDbName
IL_014a: ldarg.0
IL_014b: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem>::.ctor()
IL_0150: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByDbItem
IL_0155: ldarg.0
IL_0156: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem>::.ctor()
IL_015b: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsBySavekey
IL_0160: ldarg.0
IL_0161: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem>::.ctor()
IL_0166: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByItemType
IL_016b: ldarg.0
IL_016c: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor>::.ctor()
IL_0171: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actors
IL_0176: ldarg.0
IL_0177: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::.ctor()
IL_017c: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByDbName
IL_0181: ldarg.0
IL_0182: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor>::.ctor()
IL_0187: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByDbActor
IL_018c: ldarg.0
IL_018d: newobj System.Void System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor>::.ctor()
IL_0192: stfld System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbId
IL_0197: ldarg.0
IL_0198: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::.ctor()
IL_019d: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_01a2: ldarg.0
IL_01a3: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ActorDialogueOracle>::.ctor()
IL_01a8: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ActorDialogueOracle> TheForestOfLove.Narrative.DataManifest::actorDialogueOracles
IL_01ad: ldarg.0
IL_01ae: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ActorDialogueOracle>::.ctor()
IL_01b3: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ActorDialogueOracle> TheForestOfLove.Narrative.DataManifest::actorDialogueOraclesByActorDbName
IL_01b8: ldarg.0
IL_01b9: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.GossipGreeting>::.ctor()
IL_01be: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.GossipGreeting> TheForestOfLove.Narrative.DataManifest::gossipGreetings
IL_01c3: ldarg.0
IL_01c4: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.GossipGreeting>>::.ctor()
IL_01c9: stfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.GossipGreeting>> TheForestOfLove.Narrative.DataManifest::gossipGreetingsByActorDbName
IL_01ce: ldarg.0
IL_01cf: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestStatusRecord>::.ctor()
IL_01d4: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestStatusRecord> TheForestOfLove.Narrative.DataManifest::questStatuses
IL_01d9: ldarg.0
IL_01da: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestStatusRecord>::.ctor()
IL_01df: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestStatusRecord> TheForestOfLove.Narrative.DataManifest::questStatusesByDbName
IL_01e4: ldarg.0
IL_01e5: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.QuestStatus,TheForestOfLove.Narrative.QuestStatusRecord>::.ctor()
IL_01ea: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.QuestStatus,TheForestOfLove.Narrative.QuestStatusRecord> TheForestOfLove.Narrative.DataManifest::questStatusesByDbStatus
IL_01ef: ldarg.0
IL_01f0: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestStatusRecord>::.ctor()
IL_01f5: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestStatusRecord> TheForestOfLove.Narrative.DataManifest::questStatusesBySavekey
IL_01fa: ldarg.0
IL_01fb: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestStatus,TheForestOfLove.Narrative.QuestStatusRecord>::.ctor()
IL_0200: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestStatus,TheForestOfLove.Narrative.QuestStatusRecord> TheForestOfLove.Narrative.DataManifest::questStatusesByStatus
IL_0205: ldarg.0
IL_0206: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::.ctor()
IL_020b: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::quests
IL_0210: ldarg.0
IL_0211: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::.ctor()
IL_0216: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_021b: ldarg.0
IL_021c: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest>::.ctor()
IL_0221: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbQuest
IL_0226: ldarg.0
IL_0227: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::.ctor()
IL_022c: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsBySavekey
IL_0231: ldarg.0
IL_0232: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::.ctor()
IL_0237: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntries
IL_023c: ldarg.0
IL_023d: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestProgressLogEntry>::.ctor()
IL_0242: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntriesByDbName
IL_0247: ldarg.0
IL_0248: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.QuestProgressLogText,TheForestOfLove.Narrative.QuestProgressLogEntry>::.ctor()
IL_024d: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.QuestProgressLogText,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntriesByDbLog
IL_0252: ldarg.0
IL_0253: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueStatusRecord>::.ctor()
IL_0258: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatuses
IL_025d: ldarg.0
IL_025e: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.DialogueStatusRecord>::.ctor()
IL_0263: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatusesByDbName
IL_0268: ldarg.0
IL_0269: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord>::.ctor()
IL_026e: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatusesByDbStatus
IL_0273: ldarg.0
IL_0274: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.DialogueStatusRecord>::.ctor()
IL_0279: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatusesBySavekey
IL_027e: ldarg.0
IL_027f: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord>::.ctor()
IL_0284: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatusesByStatus
IL_0289: ldarg.0
IL_028a: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_028f: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialogues
IL_0294: ldarg.0
IL_0295: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_029a: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbName
IL_029f: ldarg.0
IL_02a0: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_02a5: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbDialogue
IL_02aa: ldarg.0
IL_02ab: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_02b0: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesBySavekey
IL_02b5: ldarg.0
IL_02b6: newobj System.Void System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_02bb: stfld System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByPluginDbId
IL_02c0: ldarg.0
IL_02c1: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::.ctor()
IL_02c6: stfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesByActorDbName
IL_02cb: ldarg.0
IL_02cc: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::.ctor()
IL_02d1: stfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeManualByActorDbName
IL_02d6: ldarg.0
IL_02d7: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::.ctor()
IL_02dc: stfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestByActorDbName
IL_02e1: ldarg.0
IL_02e2: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::.ctor()
IL_02e7: stfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeFinalIdleByActorDbName
IL_02ec: ldarg.0
IL_02ed: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::.ctor()
IL_02f2: stfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGossipByActorDbName
IL_02f7: ldarg.0
IL_02f8: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::.ctor()
IL_02fd: stfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeDateByActorDbName
IL_0302: ldarg.0
IL_0303: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::.ctor()
IL_0308: stfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGiftByActorDbName
IL_030d: ldarg.0
IL_030e: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::.ctor()
IL_0313: stfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestionIdleByActorDbName
IL_0318: ldarg.0
IL_0319: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcStatusRecord>::.ctor()
IL_031e: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcStatusRecord> TheForestOfLove.Narrative.DataManifest::arcStatuses
IL_0323: ldarg.0
IL_0324: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ArcStatusRecord>::.ctor()
IL_0329: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ArcStatusRecord> TheForestOfLove.Narrative.DataManifest::arcStatusesByDbName
IL_032e: ldarg.0
IL_032f: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.DialogueArcStatus,TheForestOfLove.Narrative.ArcStatusRecord>::.ctor()
IL_0334: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.DialogueArcStatus,TheForestOfLove.Narrative.ArcStatusRecord> TheForestOfLove.Narrative.DataManifest::arcStatusesByDbStatus
IL_0339: ldarg.0
IL_033a: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ArcStatusRecord>::.ctor()
IL_033f: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ArcStatusRecord> TheForestOfLove.Narrative.DataManifest::arcStatusesBySavekey
IL_0344: ldarg.0
IL_0345: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.ArcStatus,TheForestOfLove.Narrative.ArcStatusRecord>::.ctor()
IL_034a: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.ArcStatus,TheForestOfLove.Narrative.ArcStatusRecord> TheForestOfLove.Narrative.DataManifest::arcStatusesByStatus
IL_034f: ldarg.0
IL_0350: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::.ctor()
IL_0355: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.DataManifest::arcs
IL_035a: ldarg.0
IL_035b: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::.ctor()
IL_0360: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chapters
IL_0365: ldarg.0
IL_0366: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord>::.ctor()
IL_036b: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByDbName
IL_0370: ldarg.0
IL_0371: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord>::.ctor()
IL_0376: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByDbChapter
IL_037b: ldarg.0
IL_037c: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord>::.ctor()
IL_0381: stfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersBySavekey
IL_0386: ldarg.0
IL_0387: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord>::.ctor()
IL_038c: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByChapter
IL_0391: ldarg.0
IL_0392: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::.ctor()
IL_0397: stfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::globalChapters
IL_039c: ldarg.0
IL_039d: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord>::.ctor()
IL_03a2: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::globalChaptersByDbChapter
IL_03a7: ldarg.0
IL_03a8: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord>::.ctor()
IL_03ad: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::globalChaptersByChapter
IL_03b2: ldarg.0
IL_03b3: newobj System.Void TheForestOfLove.Services.Persistence.GeneralData::.ctor()
IL_03b8: stfld TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Narrative.DataManifest::generalData
IL_03bd: ldarg.0
IL_03be: newobj System.Void TheForestOfLove.Services.Persistence.PlayerRespawnData::.ctor()
IL_03c3: stfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Narrative.DataManifest::playerRespawnData
IL_03c8: ldarg.0
IL_03c9: newobj System.Void TheForestOfLove.Services.Persistence.PlantQuestMinigameData::.ctor()
IL_03ce: stfld TheForestOfLove.Services.Persistence.PlantQuestMinigameData TheForestOfLove.Narrative.DataManifest::plantQuestMinigameData
IL_03d3: ldarg.0
IL_03d4: newobj System.Void TheForestOfLove.Services.Persistence.DashQuestMinigameData::.ctor()
IL_03d9: stfld TheForestOfLove.Services.Persistence.DashQuestMinigameData TheForestOfLove.Narrative.DataManifest::dashQuestMinigameData
IL_03de: ldarg.0
IL_03df: newobj System.Void TheForestOfLove.Services.Persistence.DustinMinigameTrainingData::.ctor()
IL_03e4: stfld TheForestOfLove.Services.Persistence.DustinMinigameTrainingData TheForestOfLove.Narrative.DataManifest::dustinMinigameTrainingData
IL_03e9: ldarg.0
IL_03ea: newobj System.Void TheForestOfLove.Services.Persistence.DustinMinigameNoviceData::.ctor()
IL_03ef: stfld TheForestOfLove.Services.Persistence.DustinMinigameNoviceData TheForestOfLove.Narrative.DataManifest::dustinMinigameNoviceData
IL_03f4: ldarg.0
IL_03f5: newobj System.Void TheForestOfLove.Services.Persistence.GlitchRascalPart1Data::.ctor()
IL_03fa: stfld TheForestOfLove.Services.Persistence.GlitchRascalPart1Data TheForestOfLove.Narrative.DataManifest::glitchRascalPart1Data
IL_03ff: ldarg.0
IL_0400: newobj System.Void TheForestOfLove.Services.Persistence.GlobalGeneralData::.ctor()
IL_0405: stfld TheForestOfLove.Services.Persistence.GlobalGeneralData TheForestOfLove.Narrative.DataManifest::globalGeneralData
IL_040a: ldarg.0
IL_040b: newobj System.Void System.Collections.Generic.List`1<GameplayLogHistory>::.ctor()
IL_0410: stfld System.Collections.Generic.List`1<GameplayLogHistory> TheForestOfLove.Narrative.DataManifest::gameplayLogHistory
IL_0415: ldarg.0
IL_0416: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::adventuresByStoryType
IL_041b: stfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.DataManifest::adventuresByAdventureType
IL_0420: ldarg.0
IL_0421: call System.Void System.Object::.ctor()
IL_0426: ret
