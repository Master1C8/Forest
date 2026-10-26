TYPE TheForestOfLove.Narrative.ActorDialogueOracle
METHOD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetFirstEncounteredNewMainQuest() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorDialogueOracle::actor
IL_0006: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_000b: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetQuestDialoguesByPrimaryActor(System.String)
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0017: stloc.1
IL_0018: br.s IL_0050
IL_001a: ldloc.1
IL_001b: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0020: stloc.2
IL_0021: ldloc.2
IL_0022: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0027: ldfld System.Boolean TheForestOfLove.Narrative.Quest::isSideQuest
IL_002c: brtrue.s IL_0050
IL_002e: ldloc.2
IL_002f: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0034: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isStarted()
IL_0039: brtrue.s IL_0050
IL_003b: ldarg.0
IL_003c: ldloc.2
IL_003d: call System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsUnplayedPrimaryQuestDialogue(TheForestOfLove.Narrative.Dialogue)
IL_0042: brfalse.s IL_0050
IL_0044: ldloc.2
IL_0045: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::isFirstDialogueInQuest
IL_004a: brfalse.s IL_0050
IL_004c: ldloc.2
IL_004d: stloc.3
IL_004e: leave.s IL_00bf
IL_0050: ldloc.1
IL_0051: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0056: brtrue.s IL_001a
IL_0058: leave.s IL_0064
IL_005a: ldloc.1
IL_005b: brfalse.s IL_0063
IL_005d: ldloc.1
IL_005e: callvirt System.Void System.IDisposable::Dispose()
IL_0063: endfinally
IL_0064: ldloc.0
IL_0065: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_006a: stloc.1
IL_006b: br.s IL_00a9
IL_006d: ldloc.1
IL_006e: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0073: stloc.s V_4
IL_0075: ldloc.s V_4
IL_0077: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_007c: ldfld System.Boolean TheForestOfLove.Narrative.Quest::isSideQuest
IL_0081: brtrue.s IL_00a9
IL_0083: ldloc.s V_4
IL_0085: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_008a: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isStarted()
IL_008f: brtrue.s IL_00a9
IL_0091: ldarg.0
IL_0092: ldloc.s V_4
IL_0094: call System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsUnplayedSupportingQuestDialogue(TheForestOfLove.Narrative.Dialogue)
IL_0099: brfalse.s IL_00a9
IL_009b: ldloc.s V_4
IL_009d: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::isFirstDialogueInQuest
IL_00a2: brfalse.s IL_00a9
IL_00a4: ldloc.s V_4
IL_00a6: stloc.3
IL_00a7: leave.s IL_00bf
IL_00a9: ldloc.1
IL_00aa: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_00af: brtrue.s IL_006d
IL_00b1: leave.s IL_00bd
IL_00b3: ldloc.1
IL_00b4: brfalse.s IL_00bc
IL_00b6: ldloc.1
IL_00b7: callvirt System.Void System.IDisposable::Dispose()
IL_00bc: endfinally
IL_00bd: ldnull
IL_00be: ret
IL_00bf: ldloc.3
IL_00c0: ret
METHOD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetFirstEncounteredNewSideQuest() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorDialogueOracle::actor
IL_0006: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_000b: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetQuestDialoguesByPrimaryActor(System.String)
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0017: stloc.1
IL_0018: br.s IL_0050
IL_001a: ldloc.1
IL_001b: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0020: stloc.2
IL_0021: ldloc.2
IL_0022: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0027: ldfld System.Boolean TheForestOfLove.Narrative.Quest::isSideQuest
IL_002c: brfalse.s IL_0050
IL_002e: ldloc.2
IL_002f: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0034: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isStarted()
IL_0039: brtrue.s IL_0050
IL_003b: ldarg.0
IL_003c: ldloc.2
IL_003d: call System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsUnplayedPrimaryQuestDialogue(TheForestOfLove.Narrative.Dialogue)
IL_0042: brfalse.s IL_0050
IL_0044: ldloc.2
IL_0045: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::isFirstDialogueInQuest
IL_004a: brfalse.s IL_0050
IL_004c: ldloc.2
IL_004d: stloc.3
IL_004e: leave.s IL_00bf
IL_0050: ldloc.1
IL_0051: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0056: brtrue.s IL_001a
IL_0058: leave.s IL_0064
IL_005a: ldloc.1
IL_005b: brfalse.s IL_0063
IL_005d: ldloc.1
IL_005e: callvirt System.Void System.IDisposable::Dispose()
IL_0063: endfinally
IL_0064: ldloc.0
IL_0065: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_006a: stloc.1
IL_006b: br.s IL_00a9
IL_006d: ldloc.1
IL_006e: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0073: stloc.s V_4
IL_0075: ldloc.s V_4
IL_0077: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_007c: ldfld System.Boolean TheForestOfLove.Narrative.Quest::isSideQuest
IL_0081: brfalse.s IL_00a9
IL_0083: ldloc.s V_4
IL_0085: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_008a: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isStarted()
IL_008f: brtrue.s IL_00a9
IL_0091: ldarg.0
IL_0092: ldloc.s V_4
IL_0094: call System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsUnplayedSupportingQuestDialogue(TheForestOfLove.Narrative.Dialogue)
IL_0099: brfalse.s IL_00a9
IL_009b: ldloc.s V_4
IL_009d: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::isFirstDialogueInQuest
IL_00a2: brfalse.s IL_00a9
IL_00a4: ldloc.s V_4
IL_00a6: stloc.3
IL_00a7: leave.s IL_00bf
IL_00a9: ldloc.1
IL_00aa: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_00af: brtrue.s IL_006d
IL_00b1: leave.s IL_00bd
IL_00b3: ldloc.1
IL_00b4: brfalse.s IL_00bc
IL_00b6: ldloc.1
IL_00b7: callvirt System.Void System.IDisposable::Dispose()
IL_00bc: endfinally
IL_00bd: ldnull
IL_00be: ret
IL_00bf: ldloc.3
IL_00c0: ret
