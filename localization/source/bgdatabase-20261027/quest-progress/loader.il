TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader::GenerateManifest() | attributes=Public, HideBySig | impl=IL
IL_0000: call PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueManager::get_databaseManager()
IL_0005: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_000a: stloc.0
IL_000b: newobj System.Void TheForestOfLove.Narrative.DataManifest::.ctor()
IL_0010: stloc.1
IL_0011: ldarg.0
IL_0012: ldloc.1
IL_0013: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateTags(TheForestOfLove.Narrative.DataManifest)
IL_0018: ldarg.0
IL_0019: ldloc.1
IL_001a: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateBioKeywords(TheForestOfLove.Narrative.DataManifest)
IL_001f: ldarg.0
IL_0020: ldloc.1
IL_0021: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateAreas(TheForestOfLove.Narrative.DataManifest)
IL_0026: ldarg.0
IL_0027: ldloc.1
IL_0028: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateTriggers(TheForestOfLove.Narrative.DataManifest)
IL_002d: ldarg.0
IL_002e: ldloc.1
IL_002f: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateMovies(TheForestOfLove.Narrative.DataManifest)
IL_0034: ldarg.0
IL_0035: ldloc.1
IL_0036: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateItems(TheForestOfLove.Narrative.DataManifest)
IL_003b: ldarg.0
IL_003c: ldloc.1
IL_003d: ldloc.0
IL_003e: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateActors(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0043: ldarg.0
IL_0044: ldloc.1
IL_0045: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GeneratePortraits(TheForestOfLove.Narrative.DataManifest)
IL_004a: ldarg.0
IL_004b: ldloc.1
IL_004c: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateActorBios(TheForestOfLove.Narrative.DataManifest)
IL_0051: ldarg.0
IL_0052: ldloc.1
IL_0053: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateGossipGreetings(TheForestOfLove.Narrative.DataManifest)
IL_0058: ldarg.0
IL_0059: ldloc.1
IL_005a: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateQuestStatuses(TheForestOfLove.Narrative.DataManifest)
IL_005f: ldarg.0
IL_0060: ldloc.1
IL_0061: ldloc.0
IL_0062: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateQuests(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0067: ldarg.0
IL_0068: ldloc.1
IL_0069: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateQuestProgressLogText(TheForestOfLove.Narrative.DataManifest)
IL_006e: ldarg.0
IL_006f: ldloc.1
IL_0070: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateDialogueStatuses(TheForestOfLove.Narrative.DataManifest)
IL_0075: ldarg.0
IL_0076: ldloc.1
IL_0077: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateArcStatuses(TheForestOfLove.Narrative.DataManifest)
IL_007c: ldarg.0
IL_007d: ldloc.1
IL_007e: ldloc.0
IL_007f: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateDialogues(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0084: ldarg.0
IL_0085: ldloc.1
IL_0086: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateChapters(TheForestOfLove.Narrative.DataManifest)
IL_008b: ldarg.0
IL_008c: ldloc.1
IL_008d: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddDialoguePreconditionsAndTriggers(TheForestOfLove.Narrative.DataManifest)
IL_0092: ldarg.0
IL_0093: ldloc.1
IL_0094: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddTriggerDialogueTriggers(TheForestOfLove.Narrative.DataManifest)
IL_0099: ldarg.0
IL_009a: ldloc.1
IL_009b: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddArcPreconditionsAndTriggers(TheForestOfLove.Narrative.DataManifest)
IL_00a0: ldarg.0
IL_00a1: ldloc.1
IL_00a2: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddDialoguePreconditionsOnscreenOffscreenWatchInferredTriggers(TheForestOfLove.Narrative.DataManifest)
IL_00a7: ldarg.0
IL_00a8: ldloc.1
IL_00a9: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers(TheForestOfLove.Narrative.DataManifest)
IL_00ae: ldloc.1
IL_00af: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateQuests(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::.ctor()
IL_0005: dup
IL_0006: ldarg.1
IL_0007: stfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::manifest
IL_000c: dup
IL_000d: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::<GenerateQuests>b__0(TheForestOfLove.DB.Quest)
IL_0013: newobj System.Void System.Action`1<TheForestOfLove.DB.Quest>::.ctor(System.Object,System.IntPtr)
IL_0018: ldnull
IL_0019: ldnull
IL_001a: call System.Void TheForestOfLove.DB.Quest::ForEachEntity(System.Action`1<TheForestOfLove.DB.Quest>,System.Predicate`1<TheForestOfLove.DB.Quest>,System.Comparison`1<TheForestOfLove.DB.Quest>)
IL_001f: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::manifest
IL_0024: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::quests
IL_0029: ldsfld System.Comparison`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__20_1
IL_002e: dup
IL_002f: brtrue.s IL_0048
IL_0031: pop
IL_0032: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_0037: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateQuests>b__20_1(TheForestOfLove.Narrative.Quest,TheForestOfLove.Narrative.Quest)
IL_003d: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.Quest>::.ctor(System.Object,System.IntPtr)
IL_0042: dup
IL_0043: stsfld System.Comparison`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__20_1
IL_0048: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::Sort(System.Comparison`1<!0>)
IL_004d: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateQuestProgressLogText(TheForestOfLove.Narrative.DataManifest) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::manifest
IL_000d: ldloc.0
IL_000e: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::<GenerateQuestProgressLogText>b__0(TheForestOfLove.DB.QuestProgressLogText)
IL_0014: newobj System.Void System.Action`1<TheForestOfLove.DB.QuestProgressLogText>::.ctor(System.Object,System.IntPtr)
IL_0019: ldnull
IL_001a: ldnull
IL_001b: call System.Void TheForestOfLove.DB.QuestProgressLogText::ForEachEntity(System.Action`1<TheForestOfLove.DB.QuestProgressLogText>,System.Predicate`1<TheForestOfLove.DB.QuestProgressLogText>,System.Comparison`1<TheForestOfLove.DB.QuestProgressLogText>)
IL_0020: ldloc.0
IL_0021: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::manifest
IL_0026: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntries
IL_002b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::GetEnumerator()
IL_0030: stloc.1
IL_0031: br.s IL_0069
IL_0033: ldloca.s V_1
IL_0035: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Current()
IL_003a: stloc.2
IL_003b: ldloc.2
IL_003c: ldfld TheForestOfLove.DB.QuestProgressLogText TheForestOfLove.Narrative.QuestProgressLogEntry::dbLog
IL_0041: callvirt TheForestOfLove.DB.QuestProgressLogText TheForestOfLove.DB.QuestProgressLogText::get_replace_earlier_log_text()
IL_0046: brfalse.s IL_0069
IL_0048: ldloc.2
IL_0049: ldloc.0
IL_004a: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::manifest
IL_004f: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.QuestProgressLogText,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntriesByDbLog
IL_0054: ldloc.2
IL_0055: ldfld TheForestOfLove.DB.QuestProgressLogText TheForestOfLove.Narrative.QuestProgressLogEntry::dbLog
IL_005a: callvirt TheForestOfLove.DB.QuestProgressLogText TheForestOfLove.DB.QuestProgressLogText::get_replace_earlier_log_text()
IL_005f: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.QuestProgressLogText,TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Item(!0)
IL_0064: stfld TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Narrative.QuestProgressLogEntry::replaceEarlierLog
IL_0069: ldloca.s V_1
IL_006b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>::MoveNext()
IL_0070: brtrue.s IL_0033
IL_0072: leave.s IL_0082
IL_0074: ldloca.s V_1
IL_0076: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>
IL_007c: callvirt System.Void System.IDisposable::Dispose()
IL_0081: endfinally
IL_0082: ldloc.0
IL_0083: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::manifest
IL_0088: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::quests
IL_008d: ldsfld System.Action`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__21_1
IL_0092: dup
IL_0093: brtrue.s IL_00ac
IL_0095: pop
IL_0096: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_009b: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateQuestProgressLogText>b__21_1(TheForestOfLove.Narrative.Quest)
IL_00a1: newobj System.Void System.Action`1<TheForestOfLove.Narrative.Quest>::.ctor(System.Object,System.IntPtr)
IL_00a6: dup
IL_00a7: stsfld System.Action`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__21_1
IL_00ac: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::ForEach(System.Action`1<!0>)
IL_00b1: ldloc.0
IL_00b2: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::manifest
IL_00b7: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntries
IL_00bc: ldsfld System.Comparison`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__21_2
IL_00c1: dup
IL_00c2: brtrue.s IL_00db
IL_00c4: pop
IL_00c5: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_00ca: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateQuestProgressLogText>b__21_2(TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_00d0: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::.ctor(System.Object,System.IntPtr)
IL_00d5: dup
IL_00d6: stsfld System.Comparison`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__21_2
IL_00db: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::Sort(System.Comparison`1<!0>)
IL_00e0: ret
