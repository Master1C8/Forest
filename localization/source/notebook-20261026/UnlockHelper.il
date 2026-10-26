TYPE TheForestOfLove.UnlockHelper
METHOD System.Void TheForestOfLove.UnlockHelper::Unlock(TheForestOfLove.Narrative.Chapter)
IL_0000: newobj System.Void System.Collections.Generic.Stack`1<TheForestOfLove.Narrative.ChapterRecord>::.ctor()
IL_0005: stloc.0
IL_0006: ldarg.0
IL_0007: call TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Services.Persistence.DataService::GetChapterRecordByChapter(TheForestOfLove.Narrative.Chapter)
IL_000c: stloc.1
IL_000d: ldloc.0
IL_000e: ldloc.1
IL_000f: callvirt System.Void System.Collections.Generic.Stack`1<TheForestOfLove.Narrative.ChapterRecord>::Push(!0)
IL_0014: ldloc.1
IL_0015: ldfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Narrative.ChapterRecord::parent
IL_001a: stloc.1
IL_001b: ldloc.1
IL_001c: brtrue.s IL_000d
IL_001e: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.StoryManager>()
IL_0023: stloc.2
IL_0024: br IL_0133
IL_0029: ldloc.0
IL_002a: callvirt !0 System.Collections.Generic.Stack`1<TheForestOfLove.Narrative.ChapterRecord>::Pop()
IL_002f: stloc.1
IL_0030: ldloc.1
IL_0031: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.ChapterRecord::unlockDialogues
IL_0036: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_003b: stloc.3
IL_003c: br.s IL_0061
IL_003e: ldloca.s V_3
IL_0040: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0045: stloc.s V_4
IL_0047: ldloc.s V_4
IL_0049: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_004e: stsfld System.String Globals::chapterSelectCurrentDialogueDbName
IL_0053: ldloc.2
IL_0054: ldloc.s V_4
IL_0056: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_005b: ldnull
IL_005c: callvirt System.Void TheForestOfLove.Narrative.StoryManager::MarkConversationsAsPlayed(System.String,System.String)
IL_0061: ldloca.s V_3
IL_0063: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0068: brtrue.s IL_003e
IL_006a: leave.s IL_007a
IL_006c: ldloca.s V_3
IL_006e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0074: callvirt System.Void System.IDisposable::Dispose()
IL_0079: endfinally
IL_007a: ldnull
IL_007b: stsfld System.String Globals::chapterSelectCurrentDialogueDbName
IL_0080: ldloc.1
IL_0081: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.ChapterRecord::unlockTriggers
IL_0086: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::GetEnumerator()
IL_008b: stloc.s V_5
IL_008d: br.s IL_009b
IL_008f: ldloca.s V_5
IL_0091: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::get_Current()
IL_0096: callvirt System.Void TheForestOfLove.Narrative.Trigger::ActivateTrigger()
IL_009b: ldloca.s V_5
IL_009d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::MoveNext()
IL_00a2: brtrue.s IL_008f
IL_00a4: leave.s IL_00b4
IL_00a6: ldloca.s V_5
IL_00a8: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>
IL_00ae: callvirt System.Void System.IDisposable::Dispose()
IL_00b3: endfinally
IL_00b4: ldloc.1
IL_00b5: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.ChapterRecord::unlockMovies
IL_00ba: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord>::GetEnumerator()
IL_00bf: stloc.s V_6
IL_00c1: br.s IL_00cf
IL_00c3: ldloca.s V_6
IL_00c5: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>::get_Current()
IL_00ca: callvirt System.Void TheForestOfLove.Narrative.MovieRecord::Unlock()
IL_00cf: ldloca.s V_6
IL_00d1: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>::MoveNext()
IL_00d6: brtrue.s IL_00c3
IL_00d8: leave.s IL_00e8
IL_00da: ldloca.s V_6
IL_00dc: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>
IL_00e2: callvirt System.Void System.IDisposable::Dispose()
IL_00e7: endfinally
IL_00e8: ldloc.1
IL_00e9: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger> TheForestOfLove.Narrative.ChapterRecord::unlockDialogueTriggers
IL_00ee: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::GetEnumerator()
IL_00f3: stloc.s V_7
IL_00f5: br.s IL_0103
IL_00f7: ldloca.s V_7
IL_00f9: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::get_Current()
IL_00fe: callvirt System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger::ForceExecute()
IL_0103: ldloca.s V_7
IL_0105: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::MoveNext()
IL_010a: brtrue.s IL_00f7
IL_010c: leave.s IL_011c
IL_010e: ldloca.s V_7
IL_0110: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>
IL_0116: callvirt System.Void System.IDisposable::Dispose()
IL_011b: endfinally
IL_011c: ldloc.1
IL_011d: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_0122: ldc.i4 2600
IL_0127: bne.un.s IL_0133
IL_0129: ldstr "return_to_centralforest_after_photoshoot"
IL_012e: call System.Void TheForestOfLove.Services.Persistence.DataService::ClearTriggerData(System.String)
IL_0133: ldloc.0
IL_0134: callvirt System.Int32 System.Collections.Generic.Stack`1<TheForestOfLove.Narrative.ChapterRecord>::get_Count()
IL_0139: ldc.i4.0
IL_013a: bgt IL_0029
IL_013f: ret
