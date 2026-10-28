TYPE TheForestOfLove.CharlotteBookClubCutsceneStoryController
METHOD System.Void TheForestOfLove.CharlotteBookClubCutsceneStoryController::OnMovieEnding(TheForestOfLove.Narrative.Movie) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld TheForestOfLove.CharlotteBookClubCutsceneStoryController TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::<>4__this
IL_000d: ldarg.1
IL_000e: ldc.i4 6500
IL_0013: beq.s IL_0016
IL_0015: ret
IL_0016: ldsfld System.Boolean Globals::isChapterSelect
IL_001b: brtrue.s IL_0024
IL_001d: ldsfld System.Boolean Globals::isCheatCode
IL_0022: brfalse.s IL_0025
IL_0024: ret
IL_0025: ldloc.0
IL_0026: ldstr "Dates_CharlotteBookClub_Dialogue"
IL_002b: stfld System.String TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::targetConversationName
IL_0030: ldloc.0
IL_0031: ldstr "Charlotte"
IL_0036: stfld System.String TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::targetActorName
IL_003b: ldloc.0
IL_003c: ldnull
IL_003d: stfld System.Action TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::postDialogueEvent
IL_0042: ldarg.0
IL_0043: ldfld System.Int32 TheForestOfLove.CharlotteBookClubCutsceneStoryController::lastPhase
IL_0048: stloc.1
IL_0049: ldloc.1
IL_004a: ldc.i4.1
IL_004b: sub
IL_004c: switch IL_005d,IL_006a,IL_0077
IL_005d: ldloc.0
IL_005e: ldstr "charlottebookclub_afterpart1"
IL_0063: stfld System.String TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::targetDialogueArcName
IL_0068: br.s IL_0094
IL_006a: ldloc.0
IL_006b: ldstr "charlottebookclub_afterpart2"
IL_0070: stfld System.String TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::targetDialogueArcName
IL_0075: br.s IL_0094
IL_0077: ldloc.0
IL_0078: ldstr "charlottebookclub_afterpart3"
IL_007d: stfld System.String TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::targetDialogueArcName
IL_0082: ldloc.0
IL_0083: ldloc.0
IL_0084: ldftn System.Void TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::<OnMovieEnding>b__1()
IL_008a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_008f: stfld System.Action TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::postDialogueEvent
IL_0094: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0099: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_009e: ldc.r4 0.25
IL_00a3: ldloc.0
IL_00a4: ldftn System.Void TheForestOfLove.CharlotteBookClubCutsceneStoryController/<>c__DisplayClass16_0::<OnMovieEnding>b__0()
IL_00aa: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00af: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00b4: ret
