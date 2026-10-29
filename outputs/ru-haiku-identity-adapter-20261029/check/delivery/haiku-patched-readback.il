TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::ExecuteTrigger(System.String) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "show_mabel_dustin_story"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_0015
IL_000d: ldc.i4.s 11
IL_000f: ldnull
IL_0010: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0015: ldarg.1
IL_0016: ldstr "show_mabel_dustin_story_unlock"
IL_001b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0020: brfalse.s IL_002a
IL_0022: ldc.i4.s 11
IL_0024: ldnull
IL_0025: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_002a: ldarg.1
IL_002b: ldstr "show_peter_bucky_scarlett_story"
IL_0030: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0035: brfalse.s IL_003f
IL_0037: ldc.i4.s 12
IL_0039: ldnull
IL_003a: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_003f: ldarg.1
IL_0040: ldstr "show_bucky_gus_date2_story"
IL_0045: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_004a: brfalse.s IL_0054
IL_004c: ldc.i4.s 15
IL_004e: ldnull
IL_004f: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0054: ldarg.1
IL_0055: ldstr "show_bucky_gus_date2_story_unlock"
IL_005a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_005f: brfalse.s IL_0069
IL_0061: ldc.i4.s 15
IL_0063: ldnull
IL_0064: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0069: ldarg.1
IL_006a: ldstr "oliver_coyotes_date1_cutscene"
IL_006f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0074: brfalse.s IL_00d6
IL_0076: ldarg.0
IL_0077: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_007c: brtrue.s IL_008e
IL_007e: ldarg.0
IL_007f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0084: brtrue.s IL_008e
IL_0086: ldarg.0
IL_0087: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_008c: brfalse.s IL_008f
IL_008e: ret
IL_008f: ldc.r4 0
IL_0094: ldc.r4 2
IL_0099: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_009e: call System.Void TheForestOfLove.Audio.MusicManager::FadeToVolume(System.Single,System.Nullable`1<System.Single>)
IL_00a3: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_00a8: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00ad: ldc.r4 5
IL_00b2: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<>9__5_0
IL_00b7: dup
IL_00b8: brtrue.s IL_00d1
IL_00ba: pop
IL_00bb: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<>9
IL_00c0: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<ExecuteTrigger>b__5_0()
IL_00c6: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00cb: dup
IL_00cc: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<>9__5_0
IL_00d1: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00d6: ldarg.1
IL_00d7: ldstr "oliver_coyotes_date2_haiku_start"
IL_00dc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00e1: brfalse.s IL_0141
IL_00e3: ldnull
IL_00e4: stsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine1
IL_00e9: ldnull
IL_00ea: stsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine2
IL_00ef: ldnull
IL_00f0: stsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine3
IL_00f5: ldarg.0
IL_00f6: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_00fb: brtrue.s IL_010d
IL_00fd: ldarg.0
IL_00fe: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0103: brtrue.s IL_010d
IL_0105: ldarg.0
IL_0106: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_010b: brfalse.s IL_010e
IL_010d: ret
IL_010e: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ResponseOptionsUI>()
IL_0113: dup
IL_0114: callvirt System.Void TheForestOfLove.ResponseOptionsUI::ShowHaikuBackground()
IL_0119: dup
IL_011a: ldnull
IL_011b: callvirt System.Void TheForestOfLove.ResponseOptionsUI::SetHaikuLine1(System.String)
IL_0120: dup
IL_0121: ldnull
IL_0122: callvirt System.Void TheForestOfLove.ResponseOptionsUI::SetHaikuLine2(System.String)
IL_0127: ldnull
IL_0128: callvirt System.Void TheForestOfLove.ResponseOptionsUI::SetHaikuLine3(System.String)
IL_012d: ldc.r4 0
IL_0132: ldc.r4 2
IL_0137: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_013c: call System.Void TheForestOfLove.Audio.MusicManager::FadeToVolume(System.Single,System.Nullable`1<System.Single>)
IL_0141: ldarg.1
IL_0142: ldstr "oliver_coyotes_date2_haiku_line1"
IL_0147: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_014c: brfalse.s IL_018a
IL_014e: ldarg.0
IL_014f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0154: brtrue.s IL_0166
IL_0156: ldarg.0
IL_0157: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_015c: brtrue.s IL_0166
IL_015e: ldarg.0
IL_015f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0164: brfalse.s IL_0167
IL_0166: ret
IL_0167: call System.String TheForestOfLove.ResponseOptionsUI::get_lastSelectedResponseOptionText()
IL_016c: stsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine1
IL_0171: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ResponseOptionsUI>()
IL_0176: ldsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine1
IL_017b: callvirt System.Void TheForestOfLove.ResponseOptionsUI::SetHaikuLine1(System.String)
IL_0180: ldc.i4 300
IL_0185: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_018a: ldarg.1
IL_018b: ldstr "oliver_coyotes_date2_haiku_line2"
IL_0190: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0195: brfalse.s IL_01d3
IL_0197: ldarg.0
IL_0198: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_019d: brtrue.s IL_01af
IL_019f: ldarg.0
IL_01a0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_01a5: brtrue.s IL_01af
IL_01a7: ldarg.0
IL_01a8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_01ad: brfalse.s IL_01b0
IL_01af: ret
IL_01b0: call System.String TheForestOfLove.ResponseOptionsUI::get_lastSelectedResponseOptionText()
IL_01b5: stsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine2
IL_01ba: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ResponseOptionsUI>()
IL_01bf: ldsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine2
IL_01c4: callvirt System.Void TheForestOfLove.ResponseOptionsUI::SetHaikuLine2(System.String)
IL_01c9: ldc.i4 300
IL_01ce: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_01d3: ldarg.1
IL_01d4: ldstr "oliver_coyotes_date2_haiku_line3"
IL_01d9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01de: brfalse.s IL_021c
IL_01e0: ldarg.0
IL_01e1: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_01e6: brtrue.s IL_01f8
IL_01e8: ldarg.0
IL_01e9: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_01ee: brtrue.s IL_01f8
IL_01f0: ldarg.0
IL_01f1: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_01f6: brfalse.s IL_01f9
IL_01f8: ret
IL_01f9: call System.String TheForestOfLove.ResponseOptionsUI::get_lastSelectedResponseOptionText()
IL_01fe: stsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine3
IL_0203: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ResponseOptionsUI>()
IL_0208: ldsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine3
IL_020d: callvirt System.Void TheForestOfLove.ResponseOptionsUI::SetHaikuLine3(System.String)
IL_0212: ldc.i4 300
IL_0217: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_021c: ldarg.1
IL_021d: ldstr "oliver_coyotes_date2_haiku_finish"
IL_0222: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0227: brfalse IL_038f
IL_022c: newobj System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c__DisplayClass5_0::.ctor()
IL_0231: stloc.0
IL_0232: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ResponseOptionsUI>()
IL_0237: stloc.1
IL_0238: ldloc.1
IL_0239: ldnull
IL_023a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_023f: brfalse.s IL_0247
IL_0241: ldloc.1
IL_0242: callvirt System.Void TheForestOfLove.ResponseOptionsUI::HideHaikuBackground()
IL_0247: ldc.r4 1
IL_024c: ldc.r4 1
IL_0251: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_0256: call System.Void TheForestOfLove.Audio.MusicManager::FadeToVolume(System.Single,System.Nullable`1<System.Single>)
IL_025b: ldarg.0
IL_025c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0261: brtrue.s IL_0273
IL_0263: ldarg.0
IL_0264: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0269: brtrue.s IL_0273
IL_026b: ldarg.0
IL_026c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0271: brfalse.s IL_0274
IL_0273: ret
IL_0274: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line1()
IL_0279: callvirt System.String System.String::ToLower()
IL_027e: ldstr "molded"
IL_0283: callvirt System.Boolean System.String::Contains(System.String)
IL_0288: brfalse.s IL_02c6
IL_028a: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line2()
IL_028f: callvirt System.String System.String::ToLower()
IL_0294: ldstr "raging"
IL_0299: callvirt System.Boolean System.String::Contains(System.String)
IL_029e: brfalse.s IL_02c6
IL_02a0: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line3()
IL_02a5: callvirt System.String System.String::ToLower()
IL_02aa: ldstr "friends"
IL_02af: callvirt System.Boolean System.String::Contains(System.String)
IL_02b4: brfalse.s IL_02c6
IL_02b6: ldloc.0
IL_02b7: ldstr "bridge_ending"
IL_02bc: stfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c__DisplayClass5_0::targetDialogueArcName
IL_02c1: br IL_036f
IL_02c6: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line1()
IL_02cb: callvirt System.String System.String::ToLower()
IL_02d0: ldstr "lovely"
IL_02d5: callvirt System.Boolean System.String::Contains(System.String)
IL_02da: brfalse.s IL_0315
IL_02dc: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line2()
IL_02e1: callvirt System.String System.String::ToLower()
IL_02e6: ldstr "high"
IL_02eb: callvirt System.Boolean System.String::Contains(System.String)
IL_02f0: brfalse.s IL_0315
IL_02f2: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line3()
IL_02f7: callvirt System.String System.String::ToLower()
IL_02fc: ldstr "gone"
IL_0301: callvirt System.Boolean System.String::Contains(System.String)
IL_0306: brfalse.s IL_0315
IL_0308: ldloc.0
IL_0309: ldstr "penny_ending"
IL_030e: stfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c__DisplayClass5_0::targetDialogueArcName
IL_0313: br.s IL_036f
IL_0315: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line1()
IL_031a: callvirt System.String System.String::ToLower()
IL_031f: ldstr "bug"
IL_0324: callvirt System.Boolean System.String::Contains(System.String)
IL_0329: brfalse.s IL_0364
IL_032b: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line2()
IL_0330: callvirt System.String System.String::ToLower()
IL_0335: ldstr "important"
IL_033a: callvirt System.Boolean System.String::Contains(System.String)
IL_033f: brfalse.s IL_0364
IL_0341: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line3()
IL_0346: callvirt System.String System.String::ToLower()
IL_034b: ldstr "work"
IL_0350: callvirt System.Boolean System.String::Contains(System.String)
IL_0355: brfalse.s IL_0364
IL_0357: ldloc.0
IL_0358: ldstr "bug_ending"
IL_035d: stfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c__DisplayClass5_0::targetDialogueArcName
IL_0362: br.s IL_036f
IL_0364: ldloc.0
IL_0365: ldstr "mixed_ending"
IL_036a: stfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c__DisplayClass5_0::targetDialogueArcName
IL_036f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0374: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0379: ldc.r4 1
IL_037e: ldloc.0
IL_037f: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c__DisplayClass5_0::<ExecuteTrigger>b__2()
IL_0385: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_038a: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_038f: ldarg.1
IL_0390: ldstr "oliver_coyotes_date3_haiku_line1"
IL_0395: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_039a: brtrue.s IL_03b6
IL_039c: ldarg.1
IL_039d: ldstr "oliver_coyotes_date3_haiku_line2"
IL_03a2: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03a7: brtrue.s IL_03b6
IL_03a9: ldarg.1
IL_03aa: ldstr "oliver_coyotes_date3_haiku_line3"
IL_03af: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03b4: brfalse.s IL_03d9
IL_03b6: ldarg.0
IL_03b7: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_03bc: brtrue.s IL_03ce
IL_03be: ldarg.0
IL_03bf: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_03c4: brtrue.s IL_03ce
IL_03c6: ldarg.0
IL_03c7: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_03cc: brfalse.s IL_03cf
IL_03ce: ret
IL_03cf: ldc.i4 300
IL_03d4: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_03d9: ldarg.1
IL_03da: ldstr "oliver_coyotes_date3_haiku_finish"
IL_03df: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03e4: brfalse.s IL_0415
IL_03e6: ldarg.0
IL_03e7: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_03ec: brtrue.s IL_03f6
IL_03ee: ldarg.0
IL_03ef: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_03f4: brfalse.s IL_03f7
IL_03f6: ret
IL_03f7: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ResponseOptionsUI>()
IL_03fc: callvirt System.Void TheForestOfLove.ResponseOptionsUI::HideHaikuBackground()
IL_0401: ldc.r4 1
IL_0406: ldc.r4 1
IL_040b: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_0410: call System.Void TheForestOfLove.Audio.MusicManager::FadeToVolume(System.Single,System.Nullable`1<System.Single>)
IL_0415: ldarg.1
IL_0416: ldstr "show_oliver_coyotes_date3_story"
IL_041b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0420: brfalse.s IL_042a
IL_0422: ldc.i4.s 16
IL_0424: ldnull
IL_0425: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_042a: ldarg.1
IL_042b: ldstr "show_oliver_coyotes_date3_story_unlock"
IL_0430: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0435: brfalse.s IL_043f
IL_0437: ldc.i4.s 16
IL_0439: ldnull
IL_043a: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_043f: ldarg.1
IL_0440: ldstr "show_coyotes_finley_date_story"
IL_0445: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_044a: brfalse.s IL_0454
IL_044c: ldc.i4.s 18
IL_044e: ldnull
IL_044f: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0454: ldarg.1
IL_0455: ldstr "show_coyotes_finley_date_story_unlock"
IL_045a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_045f: brfalse.s IL_0469
IL_0461: ldc.i4.s 18
IL_0463: ldnull
IL_0464: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0469: ldarg.1
IL_046a: ldstr "show_oliver_bucky_oral_movie"
IL_046f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0474: brfalse.s IL_047e
IL_0476: ldc.i4.s 19
IL_0478: ldnull
IL_0479: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_047e: ldarg.1
IL_047f: ldstr "show_oliver_bucky_oral_movie_unlock"
IL_0484: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0489: brfalse.s IL_0493
IL_048b: ldc.i4.s 19
IL_048d: ldnull
IL_048e: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0493: ldarg.1
IL_0494: ldstr "show_penny_mabel_date_story"
IL_0499: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_049e: brfalse.s IL_04a8
IL_04a0: ldc.i4.s 20
IL_04a2: ldnull
IL_04a3: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_04a8: ldarg.1
IL_04a9: ldstr "show_penny_mabel_date_story_unlock"
IL_04ae: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04b3: brfalse.s IL_04bd
IL_04b5: ldc.i4.s 20
IL_04b7: ldnull
IL_04b8: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_04bd: ldarg.1
IL_04be: ldstr "show_mabel_dustin_rascal_story"
IL_04c3: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04c8: brfalse.s IL_04d2
IL_04ca: ldc.i4.s 21
IL_04cc: ldnull
IL_04cd: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_04d2: ldarg.1
IL_04d3: ldstr "show_mabel_dustin_rascal_story_unlock"
IL_04d8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04dd: brfalse.s IL_052a
IL_04df: ldarg.0
IL_04e0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_04e5: brtrue.s IL_04ef
IL_04e7: ldarg.0
IL_04e8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_04ed: brfalse.s IL_04f7
IL_04ef: ldc.i4.s 21
IL_04f1: call System.Void TheForestOfLove.QuestTriggerHelper::UnlockMovie(TheForestOfLove.Narrative.Movie)
IL_04f6: ret
IL_04f7: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_04fc: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0501: ldc.r4 1
IL_0506: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<>9__5_1
IL_050b: dup
IL_050c: brtrue.s IL_0525
IL_050e: pop
IL_050f: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<>9
IL_0514: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<ExecuteTrigger>b__5_1()
IL_051a: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_051f: dup
IL_0520: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<>9__5_1
IL_0525: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_052a: ldarg.1
IL_052b: ldstr "show_scarlett_penny_rascal_story"
IL_0530: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0535: brfalse.s IL_053f
IL_0537: ldc.i4.s 22
IL_0539: ldnull
IL_053a: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_053f: ldarg.1
IL_0540: ldstr "check_coyote_bukkake_gender"
IL_0545: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_054a: brfalse.s IL_057f
IL_054c: ldarg.0
IL_054d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0552: brtrue.s IL_055c
IL_0554: ldarg.0
IL_0555: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_055a: brfalse.s IL_055d
IL_055c: ret
IL_055d: ldstr "coyotes_bukkake_gender_preference"
IL_0562: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_0567: dup
IL_0568: brtrue.s IL_0570
IL_056a: pop
IL_056b: ldstr "coyotes_bukkake_guys"
IL_0570: ldstr "coyotes_bukkake_guys"
IL_0575: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_057a: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_057f: ldarg.1
IL_0580: ldstr "show_coyotes_rascal_bukkake_males_story"
IL_0585: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_058a: brfalse.s IL_0594
IL_058c: ldc.i4.s 23
IL_058e: ldnull
IL_058f: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0594: ldarg.1
IL_0595: ldstr "show_coyotes_rascal_bukkake_males_story_unlock"
IL_059a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_059f: brfalse.s IL_05a9
IL_05a1: ldc.i4.s 23
IL_05a3: ldnull
IL_05a4: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_05a9: ldarg.1
IL_05aa: ldstr "show_coyotes_rascal_bukkake_females_story"
IL_05af: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05b4: brfalse.s IL_05be
IL_05b6: ldc.i4.s 24
IL_05b8: ldnull
IL_05b9: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_05be: ldarg.1
IL_05bf: ldstr "show_coyotes_rascal_bukkake_females_story_unlock"
IL_05c4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05c9: brfalse.s IL_05d3
IL_05cb: ldc.i4.s 24
IL_05cd: ldnull
IL_05ce: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_05d3: ldarg.1
IL_05d4: ldstr "show_charlotte_book_club_story_part1"
IL_05d9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05de: brfalse.s IL_060d
IL_05e0: ldarg.0
IL_05e1: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_05e6: brtrue.s IL_05f0
IL_05e8: ldarg.0
IL_05e9: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_05ee: brfalse.s IL_05fc
IL_05f0: ldc.i4 6500
IL_05f5: ldnull
IL_05f6: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_05fb: ret
IL_05fc: ldc.i4.1
IL_05fd: stsfld System.Int32 TheForestOfLove.CharlotteBookClubStory::Phase
IL_0602: ldc.i4 6500
IL_0607: ldnull
IL_0608: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_060d: ldarg.1
IL_060e: ldstr "show_charlotte_book_club_story_part2"
IL_0613: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0618: brfalse.s IL_0647
IL_061a: ldarg.0
IL_061b: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0620: brtrue.s IL_062a
IL_0622: ldarg.0
IL_0623: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0628: brfalse.s IL_0636
IL_062a: ldc.i4 6500
IL_062f: ldnull
IL_0630: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0635: ret
IL_0636: ldc.i4.2
IL_0637: stsfld System.Int32 TheForestOfLove.CharlotteBookClubStory::Phase
IL_063c: ldc.i4 6500
IL_0641: ldnull
IL_0642: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0647: ldarg.1
IL_0648: ldstr "show_charlotte_book_club_story_part3"
IL_064d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0652: brfalse.s IL_0681
IL_0654: ldarg.0
IL_0655: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_065a: brtrue.s IL_0664
IL_065c: ldarg.0
IL_065d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0662: brfalse.s IL_0670
IL_0664: ldc.i4 6500
IL_0669: ldnull
IL_066a: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_066f: ret
IL_0670: ldc.i4.3
IL_0671: stsfld System.Int32 TheForestOfLove.CharlotteBookClubStory::Phase
IL_0676: ldc.i4 6500
IL_067b: ldnull
IL_067c: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0681: ldarg.1
IL_0682: ldstr "show_charlotte_book_club_story_unlock"
IL_0687: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_068c: brfalse.s IL_06ba
IL_068e: ldarg.0
IL_068f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0694: brtrue.s IL_069e
IL_0696: ldarg.0
IL_0697: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_069c: brfalse.s IL_06aa
IL_069e: ldc.i4 6500
IL_06a3: ldnull
IL_06a4: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_06a9: ret
IL_06aa: ldc.i4 6500
IL_06af: ldnull
IL_06b0: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_06b5: call System.Void TheForestOfLove.Content.CentralForestSpawner::SpawnCharlotteBookClubPostDateInteractions()
IL_06ba: ret
METHOD System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Resolve(System.String,System.Int32,System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldstr "oliver_coyotes_date2_haiku_finish"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brtrue IL_001b
IL_0010: ldstr "haiku-identity:wrong-context"
IL_0015: newobj System.Void System.InvalidOperationException::.ctor(System.String)
IL_001a: throw
IL_001b: nop
IL_001c: ldarg.1
IL_001d: ldc.i4 1
IL_0022: bne.un IL_003d
IL_0027: ldarg.0
IL_0028: ldstr "Мы лепили твердь"
IL_002d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0032: brfalse IL_003d
IL_0037: ldstr "We molded the Earth"
IL_003c: ret
IL_003d: nop
IL_003e: ldarg.1
IL_003f: ldc.i4 1
IL_0044: bne.un IL_005f
IL_0049: ldarg.0
IL_004a: ldstr "Хлопотун-жучок,"
IL_004f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0054: brfalse IL_005f
IL_0059: ldstr "Busy little bug"
IL_005e: ret
IL_005f: nop
IL_0060: ldarg.1
IL_0061: ldc.i4 1
IL_0066: bne.un IL_0081
IL_006b: ldarg.0
IL_006c: ldstr "Сокол-красота,"
IL_0071: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0076: brfalse IL_0081
IL_007b: ldstr "Oh lovely Falcon"
IL_0080: ret
IL_0081: nop
IL_0082: ldarg.1
IL_0083: ldc.i4 2
IL_0088: bne.un IL_00a3
IL_008d: ldarg.0
IL_008e: ldstr "Через бурные воды"
IL_0093: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0098: brfalse IL_00a3
IL_009d: ldstr "Across the raging waters"
IL_00a2: ret
IL_00a3: nop
IL_00a4: ldarg.1
IL_00a5: ldc.i4 2
IL_00aa: bne.un IL_00c5
IL_00af: ldarg.0
IL_00b0: ldstr "Что так важно для тебя?"
IL_00b5: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00ba: brfalse IL_00c5
IL_00bf: ldstr "What is important to you?"
IL_00c4: ret
IL_00c5: nop
IL_00c6: ldarg.1
IL_00c7: ldc.i4 2
IL_00cc: bne.un IL_00e7
IL_00d1: ldarg.0
IL_00d2: ldstr "Неси меня выше туч,"
IL_00d7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00dc: brfalse IL_00e7
IL_00e1: ldstr "Take me high above the clouds"
IL_00e6: ret
IL_00e7: nop
IL_00e8: ldarg.1
IL_00e9: ldc.i4 3
IL_00ee: bne.un IL_0109
IL_00f3: ldarg.0
IL_00f4: ldstr "Чтоб сплотить друзей."
IL_00f9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00fe: brfalse IL_0109
IL_0103: ldstr "To unite our friends"
IL_0108: ret
IL_0109: nop
IL_010a: ldarg.1
IL_010b: ldc.i4 3
IL_0110: bne.un IL_012b
IL_0115: ldarg.0
IL_0116: ldstr "К чему труд сейчас?"
IL_011b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0120: brfalse IL_012b
IL_0125: ldstr "Why must you work now?"
IL_012a: ret
IL_012b: nop
IL_012c: ldarg.1
IL_012d: ldc.i4 3
IL_0132: bne.un IL_014d
IL_0137: ldarg.0
IL_0138: ldstr "Где никто не был."
IL_013d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0142: brfalse IL_014d
IL_0147: ldstr "Where no one has gone"
IL_014c: ret
IL_014d: nop
IL_014e: ldstr "haiku-identity:unknown-label-or-slot"
IL_0153: newobj System.Void System.InvalidOperationException::.ctor(System.String)
IL_0158: throw
METHOD System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line1() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine1
IL_0005: ldc.i4 1
IL_000a: ldstr "oliver_coyotes_date2_haiku_finish"
IL_000f: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Resolve(System.String,System.Int32,System.String)
IL_0014: pop
IL_0015: ldsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine2
IL_001a: ldc.i4 2
IL_001f: ldstr "oliver_coyotes_date2_haiku_finish"
IL_0024: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Resolve(System.String,System.Int32,System.String)
IL_0029: pop
IL_002a: ldsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine3
IL_002f: ldc.i4 3
IL_0034: ldstr "oliver_coyotes_date2_haiku_finish"
IL_0039: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Resolve(System.String,System.Int32,System.String)
IL_003e: pop
IL_003f: ldsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine1
IL_0044: ldc.i4 1
IL_0049: ldstr "oliver_coyotes_date2_haiku_finish"
IL_004e: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Resolve(System.String,System.Int32,System.String)
IL_0053: ret
METHOD System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line2() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine2
IL_0005: ldc.i4 2
IL_000a: ldstr "oliver_coyotes_date2_haiku_finish"
IL_000f: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Resolve(System.String,System.Int32,System.String)
IL_0014: ret
METHOD System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Line3() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::haikuLine3
IL_0005: ldc.i4 3
IL_000a: ldstr "oliver_coyotes_date2_haiku_finish"
IL_000f: call System.String TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::VNRevivalRuHaiku_Resolve(System.String,System.Int32,System.String)
IL_0014: ret
