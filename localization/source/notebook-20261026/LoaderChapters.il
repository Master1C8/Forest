TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateChapters(TheForestOfLove.Narrative.DataManifest)
IL_0000: newobj System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld TheForestOfLove.Narrative.DialogueSystemLoader TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::<>4__this
IL_000d: ldloc.0
IL_000e: ldarg.1
IL_000f: stfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_0014: ldloc.0
IL_0015: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::<GenerateChapters>b__0(TheForestOfLove.DB.Chapter)
IL_001b: newobj System.Void System.Action`1<TheForestOfLove.DB.Chapter>::.ctor(System.Object,System.IntPtr)
IL_0020: ldnull
IL_0021: ldnull
IL_0022: call System.Void TheForestOfLove.DB.Chapter::ForEachEntity(System.Action`1<TheForestOfLove.DB.Chapter>,System.Predicate`1<TheForestOfLove.DB.Chapter>,System.Comparison`1<TheForestOfLove.DB.Chapter>)
IL_0027: ldloc.0
IL_0028: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_002d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chapters
IL_0032: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_0037: stloc.1
IL_0038: br.s IL_0073
IL_003a: ldloca.s V_1
IL_003c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_0041: stloc.2
IL_0042: ldloc.2
IL_0043: ldloc.2
IL_0044: ldfld TheForestOfLove.DB.Chapter TheForestOfLove.Narrative.ChapterRecord::dbChapter
IL_0049: callvirt TheForestOfLove.DB.Chapter TheForestOfLove.DB.Chapter::get_parent()
IL_004e: brtrue.s IL_0053
IL_0050: ldnull
IL_0051: br.s IL_006e
IL_0053: ldloc.0
IL_0054: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_0059: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByDbChapter
IL_005e: ldloc.2
IL_005f: ldfld TheForestOfLove.DB.Chapter TheForestOfLove.Narrative.ChapterRecord::dbChapter
IL_0064: callvirt TheForestOfLove.DB.Chapter TheForestOfLove.DB.Chapter::get_parent()
IL_0069: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord>::get_Item(!0)
IL_006e: stfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Narrative.ChapterRecord::parent
IL_0073: ldloca.s V_1
IL_0075: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::MoveNext()
IL_007a: brtrue.s IL_003a
IL_007c: leave.s IL_008c
IL_007e: ldloca.s V_1
IL_0080: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>
IL_0086: callvirt System.Void System.IDisposable::Dispose()
IL_008b: endfinally
IL_008c: ldloc.0
IL_008d: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_0092: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::globalChapters
IL_0097: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_009c: stloc.1
IL_009d: br.s IL_00d8
IL_009f: ldloca.s V_1
IL_00a1: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_00a6: stloc.3
IL_00a7: ldloc.3
IL_00a8: ldloc.3
IL_00a9: ldfld TheForestOfLove.DB.Chapter TheForestOfLove.Narrative.ChapterRecord::dbChapter
IL_00ae: callvirt TheForestOfLove.DB.Chapter TheForestOfLove.DB.Chapter::get_parent()
IL_00b3: brtrue.s IL_00b8
IL_00b5: ldnull
IL_00b6: br.s IL_00d3
IL_00b8: ldloc.0
IL_00b9: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_00be: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::globalChaptersByDbChapter
IL_00c3: ldloc.3
IL_00c4: ldfld TheForestOfLove.DB.Chapter TheForestOfLove.Narrative.ChapterRecord::dbChapter
IL_00c9: callvirt TheForestOfLove.DB.Chapter TheForestOfLove.DB.Chapter::get_parent()
IL_00ce: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Chapter,TheForestOfLove.Narrative.ChapterRecord>::get_Item(!0)
IL_00d3: stfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Narrative.ChapterRecord::parent
IL_00d8: ldloca.s V_1
IL_00da: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::MoveNext()
IL_00df: brtrue.s IL_009f
IL_00e1: leave.s IL_00f1
IL_00e3: ldloca.s V_1
IL_00e5: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>
IL_00eb: callvirt System.Void System.IDisposable::Dispose()
IL_00f0: endfinally
IL_00f1: ldloc.0
IL_00f2: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass50_0::manifest
IL_00f7: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chapters
IL_00fc: ldsfld System.Comparison`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__50_1
IL_0101: dup
IL_0102: brtrue.s IL_011b
IL_0104: pop
IL_0105: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_010a: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateChapters>b__50_1(TheForestOfLove.Narrative.ChapterRecord,TheForestOfLove.Narrative.ChapterRecord)
IL_0110: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.ChapterRecord>::.ctor(System.Object,System.IntPtr)
IL_0115: dup
IL_0116: stsfld System.Comparison`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__50_1
IL_011b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::Sort(System.Comparison`1<!0>)
IL_0120: ret
METHOD TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Narrative.DialogueSystemLoader::CreateChapterRecord(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.DB.Chapter)
IL_0000: newobj System.Void TheForestOfLove.Narrative.ChapterRecord::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.2
IL_0008: callvirt System.String TheForestOfLove.DB.Chapter::get_name()
IL_000d: stfld System.String TheForestOfLove.Narrative.ChapterRecord::dbName
IL_0012: ldloc.0
IL_0013: ldarg.2
IL_0014: stfld TheForestOfLove.DB.Chapter TheForestOfLove.Narrative.ChapterRecord::dbChapter
IL_0019: ldloc.0
IL_001a: ldarg.2
IL_001b: callvirt System.String TheForestOfLove.DB.Chapter::get_savekey()
IL_0020: stfld System.String TheForestOfLove.Narrative.ChapterRecord::savekey
IL_0025: ldloc.0
IL_0026: ldarg.2
IL_0027: callvirt TheForestOfLove.Narrative.Chapter TheForestOfLove.DB.Chapter::get_chapter()
IL_002c: stfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_0031: ldloc.0
IL_0032: ldarg.2
IL_0033: callvirt System.String TheForestOfLove.DB.Chapter::get_title()
IL_0038: stfld System.String TheForestOfLove.Narrative.ChapterRecord::title
IL_003d: ldloc.0
IL_003e: ldarg.2
IL_003f: callvirt System.String TheForestOfLove.DB.Chapter::get_description()
IL_0044: stfld System.String TheForestOfLove.Narrative.ChapterRecord::description
IL_0049: ldloc.0
IL_004a: ldarg.2
IL_004b: callvirt System.Int32 TheForestOfLove.DB.Chapter::get_priority()
IL_0050: stfld System.Int32 TheForestOfLove.Narrative.ChapterRecord::priority
IL_0055: ldloc.0
IL_0056: ldarg.2
IL_0057: callvirt System.Boolean TheForestOfLove.DB.Chapter::get_hide_in_list()
IL_005c: stfld System.Boolean TheForestOfLove.Narrative.ChapterRecord::isHiddenInList
IL_0061: ldarg.2
IL_0062: callvirt TheForestOfLove.DB.Area TheForestOfLove.DB.Chapter::get_respawn_area()
IL_0067: brfalse.s IL_007a
IL_0069: ldloc.0
IL_006a: ldarg.2
IL_006b: callvirt TheForestOfLove.DB.Area TheForestOfLove.DB.Chapter::get_respawn_area()
IL_0070: callvirt System.String TheForestOfLove.DB.Area::get_unity_scene_name()
IL_0075: stfld System.String TheForestOfLove.Narrative.ChapterRecord::respawnInScene
IL_007a: ldarg.2
IL_007b: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.Chapter::get_unlock_dialogues()
IL_0080: brfalse.s IL_00c8
IL_0082: ldarg.2
IL_0083: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.Chapter::get_unlock_dialogues()
IL_0088: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue>::GetEnumerator()
IL_008d: stloc.1
IL_008e: br.s IL_00af
IL_0090: ldloca.s V_1
IL_0092: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::get_Current()
IL_0097: stloc.2
IL_0098: ldloc.0
IL_0099: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.ChapterRecord::unlockDialogues
IL_009e: ldarg.1
IL_009f: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbDialogue
IL_00a4: ldloc.2
IL_00a5: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_00aa: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_00af: ldloca.s V_1
IL_00b1: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::MoveNext()
IL_00b6: brtrue.s IL_0090
IL_00b8: leave.s IL_00c8
IL_00ba: ldloca.s V_1
IL_00bc: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>
IL_00c2: callvirt System.Void System.IDisposable::Dispose()
IL_00c7: endfinally
IL_00c8: ldarg.2
IL_00c9: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.Chapter::get_unlock_triggers()
IL_00ce: brfalse.s IL_0118
IL_00d0: ldarg.2
IL_00d1: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.Chapter::get_unlock_triggers()
IL_00d6: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger>::GetEnumerator()
IL_00db: stloc.3
IL_00dc: br.s IL_00ff
IL_00de: ldloca.s V_3
IL_00e0: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::get_Current()
IL_00e5: stloc.s V_4
IL_00e7: ldloc.0
IL_00e8: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.ChapterRecord::unlockTriggers
IL_00ed: ldarg.1
IL_00ee: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_00f3: ldloc.s V_4
IL_00f5: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_00fa: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::Add(!0)
IL_00ff: ldloca.s V_3
IL_0101: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::MoveNext()
IL_0106: brtrue.s IL_00de
IL_0108: leave.s IL_0118
IL_010a: ldloca.s V_3
IL_010c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>
IL_0112: callvirt System.Void System.IDisposable::Dispose()
IL_0117: endfinally
IL_0118: ldarg.2
IL_0119: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Movie> TheForestOfLove.DB.Chapter::get_unlock_movies()
IL_011e: brfalse.s IL_0169
IL_0120: ldarg.2
IL_0121: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Movie> TheForestOfLove.DB.Chapter::get_unlock_movies()
IL_0126: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Movie>::GetEnumerator()
IL_012b: stloc.s V_5
IL_012d: br.s IL_0150
IL_012f: ldloca.s V_5
IL_0131: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Movie>::get_Current()
IL_0136: stloc.s V_6
IL_0138: ldloc.0
IL_0139: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.ChapterRecord::unlockMovies
IL_013e: ldarg.1
IL_013f: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesByDbMovie
IL_0144: ldloc.s V_6
IL_0146: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Movie,TheForestOfLove.Narrative.MovieRecord>::get_Item(!0)
IL_014b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord>::Add(!0)
IL_0150: ldloca.s V_5
IL_0152: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Movie>::MoveNext()
IL_0157: brtrue.s IL_012f
IL_0159: leave.s IL_0169
IL_015b: ldloca.s V_5
IL_015d: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Movie>
IL_0163: callvirt System.Void System.IDisposable::Dispose()
IL_0168: endfinally
IL_0169: ldarg.2
IL_016a: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.Chapter::get_enable_with_tags()
IL_016f: brfalse.s IL_01ba
IL_0171: ldarg.2
IL_0172: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.Chapter::get_enable_with_tags()
IL_0177: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_017c: stloc.s V_7
IL_017e: br.s IL_01a1
IL_0180: ldloca.s V_7
IL_0182: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_0187: stloc.s V_8
IL_0189: ldloc.0
IL_018a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.ChapterRecord::enableWithTags
IL_018f: ldarg.1
IL_0190: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_0195: ldloc.s V_8
IL_0197: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_019c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_01a1: ldloca.s V_7
IL_01a3: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_01a8: brtrue.s IL_0180
IL_01aa: leave.s IL_01ba
IL_01ac: ldloca.s V_7
IL_01ae: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_01b4: callvirt System.Void System.IDisposable::Dispose()
IL_01b9: endfinally
IL_01ba: ldloc.0
IL_01bb: ret
