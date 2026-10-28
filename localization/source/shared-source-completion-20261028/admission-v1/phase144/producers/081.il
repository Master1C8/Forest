TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerGossips
METHOD System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Events.TriggerHandlers.TriggerHandlerGossips::get_triggerFilters() | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "Gossip_"
IL_000b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0010: pop
IL_0011: dup
IL_0012: ldstr "Movies_RascalSoloBearStory_Dialogue"
IL_0017: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_001c: pop
IL_001d: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerGossips::ExecuteTrigger(System.String) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "squirrel_sex_scene"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_0034
IL_000d: ldarg.0
IL_000e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0013: brtrue.s IL_001d
IL_0015: ldarg.0
IL_0016: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_001b: brfalse.s IL_002d
IL_001d: ldc.i4.4
IL_001e: call System.Void TheForestOfLove.QuestTriggerHelper::UnlockMovie(TheForestOfLove.Narrative.Movie)
IL_0023: ldstr "sex_scene_unlocked_squirrel"
IL_0028: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_002d: ldc.i4.4
IL_002e: ldnull
IL_002f: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0034: ldarg.1
IL_0035: ldstr "show_cloaca_fisting_story"
IL_003a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_003f: brfalse.s IL_0048
IL_0041: ldc.i4.7
IL_0042: ldnull
IL_0043: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0048: ldarg.1
IL_0049: ldstr "show_penny_scarlett_cloaca_fisting_story_unlock"
IL_004e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0053: brfalse.s IL_005c
IL_0055: ldc.i4.7
IL_0056: ldnull
IL_0057: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_005c: ldarg.1
IL_005d: ldstr "show_mabel_solo_story"
IL_0062: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0067: brfalse.s IL_0071
IL_0069: ldc.i4.s 10
IL_006b: ldnull
IL_006c: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0071: ldarg.1
IL_0072: ldstr "show_mabel_solo_story_unlock"
IL_0077: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_007c: brfalse.s IL_0086
IL_007e: ldc.i4.s 10
IL_0080: ldnull
IL_0081: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0086: ldarg.1
IL_0087: ldstr "show_lanora_legend"
IL_008c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0091: brfalse.s IL_009a
IL_0093: ldc.i4.8
IL_0094: ldnull
IL_0095: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_009a: ldarg.1
IL_009b: ldstr "show_lanora_legend_unlock"
IL_00a0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00a5: brfalse.s IL_00ae
IL_00a7: ldc.i4.8
IL_00a8: ldnull
IL_00a9: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_00ae: ldarg.1
IL_00af: ldstr "show_lanora_legend_part2"
IL_00b4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00b9: brfalse.s IL_00c3
IL_00bb: ldc.i4.s 13
IL_00bd: ldnull
IL_00be: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_00c3: ldarg.1
IL_00c4: ldstr "show_lanora_legend_part2_unlock"
IL_00c9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00ce: brfalse.s IL_00d8
IL_00d0: ldc.i4.s 13
IL_00d2: ldnull
IL_00d3: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_00d8: ldarg.1
IL_00d9: ldstr "show_otter_solo_story"
IL_00de: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00e3: brfalse.s IL_00ed
IL_00e5: ldc.i4.s 14
IL_00e7: ldnull
IL_00e8: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_00ed: ldarg.1
IL_00ee: ldstr "show_maverick_solo_story_unlock"
IL_00f3: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00f8: brfalse.s IL_0102
IL_00fa: ldc.i4.s 14
IL_00fc: ldnull
IL_00fd: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0102: ldarg.1
IL_0103: ldstr "check_oliver_bottoming_unlock"
IL_0108: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_010d: brfalse.s IL_012f
IL_010f: ldarg.0
IL_0110: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0115: brtrue.s IL_011f
IL_0117: ldarg.0
IL_0118: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_011d: brfalse.s IL_0120
IL_011f: ret
IL_0120: ldstr "show_oliver_rascal_dildo_story_unlock"
IL_0125: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_012a: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_012f: ldarg.1
IL_0130: ldstr "show_oliver_rascal_dildo_story"
IL_0135: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_013a: brfalse.s IL_0155
IL_013c: ldarg.0
IL_013d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0142: brtrue.s IL_014c
IL_0144: ldarg.0
IL_0145: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_014a: brfalse.s IL_014d
IL_014c: ret
IL_014d: ldc.i4.s 25
IL_014f: ldnull
IL_0150: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0155: ldarg.1
IL_0156: ldstr "show_oliver_rascal_dildo_story_unlock"
IL_015b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0160: brfalse.s IL_016a
IL_0162: ldc.i4.s 25
IL_0164: ldnull
IL_0165: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_016a: ldarg.1
IL_016b: ldstr "check_dustin_orientation"
IL_0170: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0175: brfalse.s IL_0193
IL_0177: ldarg.0
IL_0178: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_017d: brtrue.s IL_0187
IL_017f: ldarg.0
IL_0180: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0185: brfalse.s IL_0188
IL_0187: ret
IL_0188: ldc.i4.4
IL_0189: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsMovieUnlocked(TheForestOfLove.Narrative.Movie)
IL_018e: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_0193: ldarg.1
IL_0194: ldstr "check_bunny_cuck"
IL_0199: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_019e: brfalse.s IL_01bc
IL_01a0: ldarg.0
IL_01a1: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_01a6: brtrue.s IL_01b0
IL_01a8: ldarg.0
IL_01a9: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_01ae: brfalse.s IL_01b1
IL_01b0: ret
IL_01b1: ldc.i4.6
IL_01b2: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsMovieUnlocked(TheForestOfLove.Narrative.Movie)
IL_01b7: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_01bc: ldarg.1
IL_01bd: ldstr "show_coyotes_party_story"
IL_01c2: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01c7: brfalse.s IL_01d1
IL_01c9: ldc.i4.s 17
IL_01cb: ldnull
IL_01cc: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_01d1: ldarg.1
IL_01d2: ldstr "show_coyotes_party_story_unlock"
IL_01d7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01dc: brfalse.s IL_01e6
IL_01de: ldc.i4.s 17
IL_01e0: ldnull
IL_01e1: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_01e6: ldarg.1
IL_01e7: ldstr "coyotes_bukkake_guys"
IL_01ec: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01f1: brfalse.s IL_0213
IL_01f3: ldarg.0
IL_01f4: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_01f9: brtrue.s IL_0203
IL_01fb: ldarg.0
IL_01fc: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0201: brfalse.s IL_0204
IL_0203: ret
IL_0204: ldstr "coyotes_bukkake_gender_preference"
IL_0209: ldstr "coyotes_bukkake_guys"
IL_020e: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0213: ldarg.1
IL_0214: ldstr "coyotes_bukkake_girls"
IL_0219: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_021e: brfalse.s IL_0240
IL_0220: ldarg.0
IL_0221: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0226: brtrue.s IL_0230
IL_0228: ldarg.0
IL_0229: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_022e: brfalse.s IL_0231
IL_0230: ret
IL_0231: ldstr "coyotes_bukkake_gender_preference"
IL_0236: ldstr "coyotes_bukkake_girls"
IL_023b: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0240: ldarg.1
IL_0241: ldstr "show_rascal_solo_fluids_story"
IL_0246: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_024b: brfalse.s IL_0261
IL_024d: ldarg.0
IL_024e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0253: brfalse.s IL_0256
IL_0255: ret
IL_0256: ldc.i4 3900
IL_025b: ldnull
IL_025c: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0261: ldarg.1
IL_0262: ldstr "show_rascal_solo_fluids_story_unlock"
IL_0267: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_026c: brfalse.s IL_0279
IL_026e: ldc.i4 3900
IL_0273: ldnull
IL_0274: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0279: ldarg.1
IL_027a: ldstr "show_rascal_solo_knot_story"
IL_027f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0284: brfalse.s IL_029a
IL_0286: ldarg.0
IL_0287: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_028c: brfalse.s IL_028f
IL_028e: ret
IL_028f: ldc.i4 4000
IL_0294: ldnull
IL_0295: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_029a: ldarg.1
IL_029b: ldstr "show_rascal_solo_knot_story_unlock"
IL_02a0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02a5: brfalse.s IL_02b2
IL_02a7: ldc.i4 4000
IL_02ac: ldnull
IL_02ad: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_02b2: ldarg.1
IL_02b3: ldstr "show_rascal_solo_anal_story"
IL_02b8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02bd: brfalse.s IL_02d3
IL_02bf: ldarg.0
IL_02c0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_02c5: brfalse.s IL_02c8
IL_02c7: ret
IL_02c8: ldc.i4 4100
IL_02cd: ldnull
IL_02ce: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_02d3: ldarg.1
IL_02d4: ldstr "show_rascal_solo_anal_story_unlock"
IL_02d9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02de: brfalse.s IL_02eb
IL_02e0: ldc.i4 4100
IL_02e5: ldnull
IL_02e6: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_02eb: ldarg.1
IL_02ec: ldstr "show_charlotte_melody_fantasy_story"
IL_02f1: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02f6: brfalse.s IL_0303
IL_02f8: ldc.i4 3700
IL_02fd: ldnull
IL_02fe: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0303: ldarg.1
IL_0304: ldstr "show_charlotte_melody_fantasy_story_unlock"
IL_0309: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_030e: brfalse.s IL_031b
IL_0310: ldc.i4 3700
IL_0315: ldnull
IL_0316: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_031b: ldarg.1
IL_031c: ldstr "show_melody_excursions_story"
IL_0321: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0326: brfalse.s IL_0333
IL_0328: ldc.i4 4300
IL_032d: ldnull
IL_032e: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0333: ldarg.1
IL_0334: ldstr "show_melody_excursions_story_unlock"
IL_0339: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_033e: brfalse.s IL_034b
IL_0340: ldc.i4 4300
IL_0345: ldnull
IL_0346: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_034b: ldarg.1
IL_034c: ldstr "show_bucky_rascal_bears_story"
IL_0351: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0356: brfalse.s IL_0363
IL_0358: ldc.i4 4400
IL_035d: ldnull
IL_035e: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0363: ldarg.1
IL_0364: ldstr "show_bucky_rascal_bears_story_unlock"
IL_0369: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_036e: brfalse.s IL_037b
IL_0370: ldc.i4 4400
IL_0375: ldnull
IL_0376: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_037b: ldarg.1
IL_037c: ldstr "show_rascal_solo_bears_story_timepasses"
IL_0381: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0386: brfalse.s IL_03d1
IL_0388: ldarg.0
IL_0389: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_038e: brtrue.s IL_0398
IL_0390: ldarg.0
IL_0391: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0396: brfalse.s IL_0399
IL_0398: ret
IL_0399: call System.Void TheForestOfLove.GossipUI::HideImmediately()
IL_039e: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_03a3: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_03a8: ldc.r4 1
IL_03ad: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerGossips/<>c::<>9__2_0
IL_03b2: dup
IL_03b3: brtrue.s IL_03cc
IL_03b5: pop
IL_03b6: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerGossips/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerGossips/<>c::<>9
IL_03bb: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerGossips/<>c::<ExecuteTrigger>b__2_0()
IL_03c1: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_03c6: dup
IL_03c7: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerGossips/<>c::<>9__2_0
IL_03cc: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_03d1: ldarg.1
IL_03d2: ldstr "show_rascal_solo_bear_story"
IL_03d7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03dc: brfalse.s IL_040e
IL_03de: ldarg.0
IL_03df: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_03e4: brtrue.s IL_03ee
IL_03e6: ldarg.0
IL_03e7: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_03ec: brfalse.s IL_03ef
IL_03ee: ret
IL_03ef: call System.Void TheForestOfLove.Content.LakeSpawner::DisableRascalSoloBearStoryInteraction()
IL_03f4: ldstr "rascal_solo_bear_story_enabled"
IL_03f9: ldstr "false"
IL_03fe: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0403: ldc.i4 4500
IL_0408: ldnull
IL_0409: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_040e: ldarg.1
IL_040f: ldstr "show_rascal_solo_bear_story_unlock"
IL_0414: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0419: pop
IL_041a: ldarg.1
IL_041b: ldstr "show_oliver_augustus_story_part_1"
IL_0420: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0425: brfalse.s IL_0448
IL_0427: ldarg.0
IL_0428: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_042d: brtrue.s IL_0437
IL_042f: ldarg.0
IL_0430: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0435: brfalse.s IL_0438
IL_0437: ret
IL_0438: call System.Void TheForestOfLove.GossipUI::HideImmediately()
IL_043d: ldc.i4 5000
IL_0442: ldnull
IL_0443: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0448: ldarg.1
IL_0449: ldstr "show_oliver_augustus_story_part_1_unlock"
IL_044e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0453: brfalse.s IL_0460
IL_0455: ldc.i4 5000
IL_045a: ldnull
IL_045b: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0460: ldarg.1
IL_0461: ldstr "show_oliver_augustus_story_part_2"
IL_0466: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_046b: brfalse.s IL_048e
IL_046d: ldarg.0
IL_046e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0473: brtrue.s IL_047d
IL_0475: ldarg.0
IL_0476: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_047b: brfalse.s IL_047e
IL_047d: ret
IL_047e: call System.Void TheForestOfLove.GossipUI::HideImmediately()
IL_0483: ldc.i4 5100
IL_0488: ldnull
IL_0489: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_048e: ldarg.1
IL_048f: ldstr "show_oliver_augustus_story_part_2_unlock"
IL_0494: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0499: brfalse.s IL_04a6
IL_049b: ldc.i4 5100
IL_04a0: ldnull
IL_04a1: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_04a6: ldarg.1
IL_04a7: ldstr "show_finley_penny_beakjob_story"
IL_04ac: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04b1: brfalse.s IL_04d4
IL_04b3: ldarg.0
IL_04b4: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_04b9: brtrue.s IL_04c3
IL_04bb: ldarg.0
IL_04bc: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_04c1: brfalse.s IL_04c4
IL_04c3: ret
IL_04c4: call System.Void TheForestOfLove.GossipUI::HideImmediately()
IL_04c9: ldc.i4 5200
IL_04ce: ldnull
IL_04cf: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_04d4: ldarg.1
IL_04d5: ldstr "show_finley_penny_beakjob_story_unlock"
IL_04da: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04df: brfalse.s IL_04ec
IL_04e1: ldc.i4 5200
IL_04e6: ldnull
IL_04e7: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_04ec: ldarg.1
IL_04ed: ldstr "unlock_adventure_blessing_of_the_bells"
IL_04f2: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04f7: brfalse.s IL_0508
IL_04f9: ldc.i4.s 100
IL_04fb: call System.Boolean TheForestOfLove.Narrative.NarrativeActions::UnlockAdventure(TheForestOfLove.Narrative.AdventureType)
IL_0500: brfalse.s IL_0508
IL_0502: ldarg.0
IL_0503: call System.Void TheForestOfLove.QuestTriggerHandler::ShowAdventureTutorialIfNotAlreadyShownOnce_WithDelayForOverworldUnlockNotification()
IL_0508: ldarg.1
IL_0509: ldstr "unlock_adventure_seasons_greetings"
IL_050e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0513: brfalse.s IL_0527
IL_0515: ldc.i4 500
IL_051a: call System.Boolean TheForestOfLove.Narrative.NarrativeActions::UnlockAdventure(TheForestOfLove.Narrative.AdventureType)
IL_051f: brfalse.s IL_0527
IL_0521: ldarg.0
IL_0522: call System.Void TheForestOfLove.QuestTriggerHandler::ShowAdventureTutorialIfNotAlreadyShownOnce_WithDelayForOverworldUnlockNotification()
IL_0527: ldarg.1
IL_0528: ldstr "gossips_check_charlotte_nearby"
IL_052d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0532: brfalse.s IL_0554
IL_0534: ldarg.0
IL_0535: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_053a: brtrue.s IL_0544
IL_053c: ldarg.0
IL_053d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0542: brfalse.s IL_0545
IL_0544: ret
IL_0545: ldstr "Charlotte"
IL_054a: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorOnScreen(System.String)
IL_054f: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_0554: ret
