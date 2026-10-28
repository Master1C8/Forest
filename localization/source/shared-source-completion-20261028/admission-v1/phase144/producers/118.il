TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::<GenerateChapters>b__0(TheForestOfLove.DB.Chapter) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.DialogueSystemLoader TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::<>4__this
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_000c: ldarg.1
IL_000d: call TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Narrative.DialogueSystemLoader::CreateChapterRecord(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.DB.Chapter)
IL_0012: stloc.0
IL_0013: ldarg.0
IL_0014: ldfld TheForestOfLove.Narrative.DialogueSystemLoader TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::<>4__this
IL_0019: ldarg.0
IL_001a: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_001f: ldarg.1
IL_0020: call TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Narrative.DialogueSystemLoader::CreateChapterRecord(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.DB.Chapter)
IL_0025: stloc.1
IL_0026: ldarg.0
IL_0027: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_002c: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chapters
IL_0031: ldloc.0
IL_0032: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::Add(!0)
IL_0037: ldarg.0
IL_0038: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_003d: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByDbName
IL_0042: ldloc.0
IL_0043: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::dbName
IL_0048: ldloc.0
IL_0049: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord>::Add(!0,!1)
IL_004e: ldarg.0
IL_004f: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_0054: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByDbChapter
IL_0059: ldloc.0
IL_005a: ldfld TheForestOfLove.DB.Chapter TheForestOfLove.Narrative.ChapterRecord::dbChapter
IL_005f: ldloc.0
IL_0060: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord>::Add(!0,!1)
IL_0065: ldarg.0
IL_0066: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_006b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersBySavekey
IL_0070: ldloc.0
IL_0071: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::savekey
IL_0076: ldloc.0
IL_0077: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord>::Add(!0,!1)
IL_007c: ldarg.0
IL_007d: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_0082: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByChapter
IL_0087: ldloc.0
IL_0088: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_008d: ldloc.0
IL_008e: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord>::Add(!0,!1)
IL_0093: ldarg.0
IL_0094: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_0099: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::globalChapters
IL_009e: ldloc.1
IL_009f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::Add(!0)
IL_00a4: ldarg.0
IL_00a5: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_00aa: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::globalChaptersByDbChapter
IL_00af: ldloc.1
IL_00b0: ldfld TheForestOfLove.DB.Chapter TheForestOfLove.Narrative.ChapterRecord::dbChapter
IL_00b5: ldloc.1
IL_00b6: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord>::Add(!0,!1)
IL_00bb: ldarg.0
IL_00bc: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_00c1: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::globalChaptersByChapter
IL_00c6: ldloc.1
IL_00c7: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_00cc: ldloc.1
IL_00cd: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord>::Add(!0,!1)
IL_00d2: ldarg.1
IL_00d3: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.Chapter::get_manage_items()
IL_00d8: brfalse IL_01ad
IL_00dd: ldarg.1
IL_00de: callvirt System.Collections.Generic.List`1<System.Int32> TheForestOfLove.DB.Chapter::get_item_quantities_parallel()
IL_00e3: brfalse.s IL_00fd
IL_00e5: ldarg.1
IL_00e6: callvirt System.Collections.Generic.List`1<System.Int32> TheForestOfLove.DB.Chapter::get_item_quantities_parallel()
IL_00eb: callvirt System.Int32 System.Collections.Generic.List`1<System.Int32>::get_Count()
IL_00f0: ldarg.1
IL_00f1: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.Chapter::get_manage_items()
IL_00f6: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem>::get_Count()
IL_00fb: beq.s IL_0113
IL_00fd: ldstr "manage items list length must match exact item quantities parallel list length "
IL_0102: ldloc.0
IL_0103: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::dbName
IL_0108: call System.String System.String::Concat(System.String,System.String)
IL_010d: newobj System.Void System.Exception::.ctor(System.String)
IL_0112: throw
IL_0113: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::.ctor()
IL_0118: stloc.2
IL_0119: ldc.i4.0
IL_011a: stloc.3
IL_011b: br.s IL_0190
IL_011d: ldarg.1
IL_011e: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.Chapter::get_manage_items()
IL_0123: ldloc.3
IL_0124: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem>::get_Item(System.Int32)
IL_0129: callvirt TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.DB.InventoryItem::get_item_type()
IL_012e: stloc.s V_4
IL_0130: ldarg.1
IL_0131: callvirt System.Collections.Generic.List`1<System.Int32> TheForestOfLove.DB.Chapter::get_item_quantities_parallel()
IL_0136: ldloc.3
IL_0137: callvirt !0 System.Collections.Generic.List`1<System.Int32>::get_Item(System.Int32)
IL_013c: stloc.s V_5
IL_013e: ldloc.s V_5
IL_0140: ldc.i4.0
IL_0141: bge.s IL_015f
IL_0143: ldloc.2
IL_0144: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToRemove
IL_0149: ldloc.s V_4
IL_014b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_0150: ldloc.2
IL_0151: ldfld System.Collections.Generic.List`1<System.Int32> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToRemoveQuantity
IL_0156: ldloc.s V_5
IL_0158: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Add(!0)
IL_015d: br.s IL_018c
IL_015f: ldloc.s V_5
IL_0161: brtrue.s IL_0172
IL_0163: ldloc.2
IL_0164: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToConsume
IL_0169: ldloc.s V_4
IL_016b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_0170: br.s IL_018c
IL_0172: ldloc.2
IL_0173: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToAdd
IL_0178: ldloc.s V_4
IL_017a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_017f: ldloc.2
IL_0180: ldfld System.Collections.Generic.List`1<System.Int32> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToAddQuantity
IL_0185: ldloc.s V_5
IL_0187: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Add(!0)
IL_018c: ldloc.3
IL_018d: ldc.i4.1
IL_018e: add
IL_018f: stloc.3
IL_0190: ldloc.3
IL_0191: ldarg.1
IL_0192: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.Chapter::get_manage_items()
IL_0197: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem>::get_Count()
IL_019c: blt IL_011d
IL_01a1: ldloc.0
IL_01a2: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger> TheForestOfLove.Narrative.ChapterRecord::unlockDialogueTriggers
IL_01a7: ldloc.2
IL_01a8: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_01ad: ret
