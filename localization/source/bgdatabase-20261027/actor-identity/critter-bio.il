TYPE TheForestOfLove.CritterLogBioPane
METHOD System.Void TheForestOfLove.CritterLogBioPane::UpdateSelectedBio(TheForestOfLove.Narrative.Actor) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_001b
IL_0003: ldarg.1
IL_0004: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0009: brfalse.s IL_001b
IL_000b: ldarg.1
IL_000c: callvirt TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::get_CurrentBioNotes()
IL_0011: brfalse.s IL_001b
IL_0013: ldarg.1
IL_0014: callvirt TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::get_CurrentBioKinks()
IL_0019: brtrue.s IL_0097
IL_001b: ldarg.0
IL_001c: ldfld UnityEngine.UI.Image TheForestOfLove.CritterLogBioPane::portrait
IL_0021: ldarg.0
IL_0022: ldfld UnityEngine.Sprite TheForestOfLove.CritterLogBioPane::emptyPortrait
IL_0027: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.UI.Text TheForestOfLove.CritterLogBioPane::fullName
IL_0032: ldsfld System.String System.String::Empty
IL_0037: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.UI.Text TheForestOfLove.CritterLogBioPane::subtitles
IL_0042: ldsfld System.String System.String::Empty
IL_0047: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_004c: ldc.i4.0
IL_004d: stloc.0
IL_004e: br.s IL_008b
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_0056: ldloc.0
IL_0057: ldelem.ref
IL_0058: ldstr "???"
IL_005d: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0062: ldarg.0
IL_0063: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_0068: ldloc.0
IL_0069: ldelem.ref
IL_006a: ldarg.0
IL_006b: ldfld UnityEngine.Color TheForestOfLove.CritterLogBioPane::colorUnrevealedValue
IL_0070: callvirt System.Void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)
IL_0075: ldarg.0
IL_0076: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_007b: ldloc.0
IL_007c: ldelem.ref
IL_007d: ldc.r4 0
IL_0082: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0087: ldloc.0
IL_0088: ldc.i4.1
IL_0089: add
IL_008a: stloc.0
IL_008b: ldloc.0
IL_008c: ldarg.0
IL_008d: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_0092: ldlen
IL_0093: conv.i4
IL_0094: blt.s IL_0050
IL_0096: ret
IL_0097: ldarg.1
IL_0098: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_009d: brfalse.s IL_00ec
IL_009f: ldarg.1
IL_00a0: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_00a5: brfalse.s IL_00ec
IL_00a7: ldarg.1
IL_00a8: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_00ad: ldarg.1
IL_00ae: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_00b3: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioSpeciesKeyword
IL_00b8: callvirt System.Boolean TheForestOfLove.Narrative.BioDetail::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword)
IL_00bd: pop
IL_00be: ldarg.1
IL_00bf: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_00c4: ldarg.1
IL_00c5: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_00ca: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioAgeKeyword
IL_00cf: callvirt System.Boolean TheForestOfLove.Narrative.BioDetail::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword)
IL_00d4: pop
IL_00d5: ldarg.1
IL_00d6: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_00db: ldarg.1
IL_00dc: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_00e1: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioRoleKeyword
IL_00e6: callvirt System.Boolean TheForestOfLove.Narrative.BioDetail::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword)
IL_00eb: pop
IL_00ec: ldarg.0
IL_00ed: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.CritterLogBioPane::critterBiosViewed
IL_00f2: ldarg.1
IL_00f3: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00f8: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00fd: ldarg.0
IL_00fe: ldfld UnityEngine.UI.Image TheForestOfLove.CritterLogBioPane::portrait
IL_0103: ldarg.1
IL_0104: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0109: ldfld UnityEngine.Sprite TheForestOfLove.Narrative.BioDetail::bioPortrait
IL_010e: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_0113: ldarg.0
IL_0114: ldfld UnityEngine.UI.Text TheForestOfLove.CritterLogBioPane::fullName
IL_0119: ldarg.1
IL_011a: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_011f: brtrue.s IL_0128
IL_0121: ldstr "???"
IL_0126: br.s IL_012e
IL_0128: ldarg.1
IL_0129: callvirt System.String TheForestOfLove.Narrative.Actor::get_FullName()
IL_012e: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0133: ldarg.1
IL_0134: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0139: callvirt System.Boolean TheForestOfLove.Narrative.BioDetail::get_isBioSpeciesUnlocked()
IL_013e: brtrue.s IL_0147
IL_0140: ldstr "???"
IL_0145: br.s IL_0152
IL_0147: ldarg.1
IL_0148: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_014d: callvirt System.String TheForestOfLove.Narrative.BioDetail::get_bioSpeciesText()
IL_0152: stloc.1
IL_0153: ldarg.1
IL_0154: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0159: callvirt System.Boolean TheForestOfLove.Narrative.BioDetail::get_isBioAgeUnlocked()
IL_015e: brtrue.s IL_0167
IL_0160: ldstr "???"
IL_0165: br.s IL_0172
IL_0167: ldarg.1
IL_0168: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_016d: callvirt System.String TheForestOfLove.Narrative.BioDetail::get_bioAgeText()
IL_0172: stloc.2
IL_0173: ldarg.1
IL_0174: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0179: callvirt System.Boolean TheForestOfLove.Narrative.BioDetail::get_isBioRoleUnlocked()
IL_017e: brtrue.s IL_0187
IL_0180: ldstr "???"
IL_0185: br.s IL_0192
IL_0187: ldarg.1
IL_0188: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_018d: callvirt System.String TheForestOfLove.Narrative.BioDetail::get_bioRoleText()
IL_0192: stloc.3
IL_0193: ldarg.0
IL_0194: ldfld UnityEngine.UI.Text TheForestOfLove.CritterLogBioPane::subtitles
IL_0199: ldstr "{0}
{1}
{2}"
IL_019e: ldloc.1
IL_019f: ldloc.2
IL_01a0: ldloc.3
IL_01a1: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_01a6: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_01ab: ldarg.1
IL_01ac: callvirt TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::get_CurrentBioNotes()
IL_01b1: stloc.s V_4
IL_01b3: ldarg.0
IL_01b4: ldarg.0
IL_01b5: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_01ba: ldc.i4.0
IL_01bb: ldelem.ref
IL_01bc: ldarg.0
IL_01bd: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_01c2: ldc.i4.0
IL_01c3: ldelem.ref
IL_01c4: ldarg.1
IL_01c5: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_01ca: ldloc.s V_4
IL_01cc: callvirt System.String TheForestOfLove.Narrative.BioNotes::get_note1Text()
IL_01d1: ldloc.s V_4
IL_01d3: ldfld System.Boolean TheForestOfLove.Narrative.BioNotes::note1Hidden
IL_01d8: ldloc.s V_4
IL_01da: callvirt System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote1Unlocked()
IL_01df: ldloc.s V_4
IL_01e1: callvirt System.Single TheForestOfLove.Narrative.BioNotes::get_note1TimeUnlocked()
IL_01e6: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_01eb: ldarg.0
IL_01ec: ldarg.0
IL_01ed: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_01f2: ldc.i4.1
IL_01f3: ldelem.ref
IL_01f4: ldarg.0
IL_01f5: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_01fa: ldc.i4.1
IL_01fb: ldelem.ref
IL_01fc: ldarg.1
IL_01fd: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_0202: ldloc.s V_4
IL_0204: callvirt System.String TheForestOfLove.Narrative.BioNotes::get_note2Text()
IL_0209: ldloc.s V_4
IL_020b: ldfld System.Boolean TheForestOfLove.Narrative.BioNotes::note2Hidden
IL_0210: ldloc.s V_4
IL_0212: callvirt System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote2Unlocked()
IL_0217: ldloc.s V_4
IL_0219: callvirt System.Single TheForestOfLove.Narrative.BioNotes::get_note2TimeUnlocked()
IL_021e: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_0223: ldarg.0
IL_0224: ldarg.0
IL_0225: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_022a: ldc.i4.2
IL_022b: ldelem.ref
IL_022c: ldarg.0
IL_022d: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_0232: ldc.i4.2
IL_0233: ldelem.ref
IL_0234: ldarg.1
IL_0235: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_023a: ldloc.s V_4
IL_023c: callvirt System.String TheForestOfLove.Narrative.BioNotes::get_note3Text()
IL_0241: ldloc.s V_4
IL_0243: ldfld System.Boolean TheForestOfLove.Narrative.BioNotes::note3Hidden
IL_0248: ldloc.s V_4
IL_024a: callvirt System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote3Unlocked()
IL_024f: ldloc.s V_4
IL_0251: callvirt System.Single TheForestOfLove.Narrative.BioNotes::get_note3TimeUnlocked()
IL_0256: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_025b: ldarg.0
IL_025c: ldarg.0
IL_025d: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_0262: ldc.i4.3
IL_0263: ldelem.ref
IL_0264: ldarg.0
IL_0265: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_026a: ldc.i4.3
IL_026b: ldelem.ref
IL_026c: ldarg.1
IL_026d: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_0272: ldloc.s V_4
IL_0274: callvirt System.String TheForestOfLove.Narrative.BioNotes::get_note4Text()
IL_0279: ldloc.s V_4
IL_027b: ldfld System.Boolean TheForestOfLove.Narrative.BioNotes::note4Hidden
IL_0280: ldloc.s V_4
IL_0282: callvirt System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote4Unlocked()
IL_0287: ldloc.s V_4
IL_0289: callvirt System.Single TheForestOfLove.Narrative.BioNotes::get_note4TimeUnlocked()
IL_028e: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_0293: ldarg.0
IL_0294: ldarg.0
IL_0295: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_029a: ldc.i4.4
IL_029b: ldelem.ref
IL_029c: ldarg.0
IL_029d: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_02a2: ldc.i4.4
IL_02a3: ldelem.ref
IL_02a4: ldarg.1
IL_02a5: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_02aa: ldloc.s V_4
IL_02ac: callvirt System.String TheForestOfLove.Narrative.BioNotes::get_note5Text()
IL_02b1: ldloc.s V_4
IL_02b3: ldfld System.Boolean TheForestOfLove.Narrative.BioNotes::note5Hidden
IL_02b8: ldloc.s V_4
IL_02ba: callvirt System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote5Unlocked()
IL_02bf: ldloc.s V_4
IL_02c1: callvirt System.Single TheForestOfLove.Narrative.BioNotes::get_note5TimeUnlocked()
IL_02c6: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_02cb: ldarg.0
IL_02cc: ldarg.0
IL_02cd: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_02d2: ldc.i4.5
IL_02d3: ldelem.ref
IL_02d4: ldarg.0
IL_02d5: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_02da: ldc.i4.5
IL_02db: ldelem.ref
IL_02dc: ldarg.1
IL_02dd: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_02e2: ldloc.s V_4
IL_02e4: callvirt System.String TheForestOfLove.Narrative.BioNotes::get_note6Text()
IL_02e9: ldloc.s V_4
IL_02eb: ldfld System.Boolean TheForestOfLove.Narrative.BioNotes::note6Hidden
IL_02f0: ldloc.s V_4
IL_02f2: callvirt System.Boolean TheForestOfLove.Narrative.BioNotes::get_isNote6Unlocked()
IL_02f7: ldloc.s V_4
IL_02f9: callvirt System.Single TheForestOfLove.Narrative.BioNotes::get_note6TimeUnlocked()
IL_02fe: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_0303: ldarg.1
IL_0304: callvirt TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::get_CurrentBioKinks()
IL_0309: stloc.s V_5
IL_030b: ldarg.0
IL_030c: ldarg.0
IL_030d: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_0312: ldc.i4.6
IL_0313: ldelem.ref
IL_0314: ldarg.0
IL_0315: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_031a: ldc.i4.6
IL_031b: ldelem.ref
IL_031c: ldarg.1
IL_031d: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_0322: ldloc.s V_5
IL_0324: callvirt System.String TheForestOfLove.Narrative.BioKinks::get_kink1Text()
IL_0329: ldloc.s V_5
IL_032b: ldfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink1Hidden
IL_0330: ldloc.s V_5
IL_0332: callvirt System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink1Unlocked()
IL_0337: ldloc.s V_5
IL_0339: callvirt System.Single TheForestOfLove.Narrative.BioKinks::get_kink1TimeUnlocked()
IL_033e: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_0343: ldarg.0
IL_0344: ldarg.0
IL_0345: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_034a: ldc.i4.7
IL_034b: ldelem.ref
IL_034c: ldarg.0
IL_034d: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_0352: ldc.i4.7
IL_0353: ldelem.ref
IL_0354: ldarg.1
IL_0355: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_035a: ldloc.s V_5
IL_035c: callvirt System.String TheForestOfLove.Narrative.BioKinks::get_kink2Text()
IL_0361: ldloc.s V_5
IL_0363: ldfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink2Hidden
IL_0368: ldloc.s V_5
IL_036a: callvirt System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink2Unlocked()
IL_036f: ldloc.s V_5
IL_0371: callvirt System.Single TheForestOfLove.Narrative.BioKinks::get_kink2TimeUnlocked()
IL_0376: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_037b: ldarg.0
IL_037c: ldarg.0
IL_037d: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_0382: ldc.i4.8
IL_0383: ldelem.ref
IL_0384: ldarg.0
IL_0385: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_038a: ldc.i4.8
IL_038b: ldelem.ref
IL_038c: ldarg.1
IL_038d: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_0392: ldloc.s V_5
IL_0394: callvirt System.String TheForestOfLove.Narrative.BioKinks::get_kink3Text()
IL_0399: ldloc.s V_5
IL_039b: ldfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink3Hidden
IL_03a0: ldloc.s V_5
IL_03a2: callvirt System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink3Unlocked()
IL_03a7: ldloc.s V_5
IL_03a9: callvirt System.Single TheForestOfLove.Narrative.BioKinks::get_kink3TimeUnlocked()
IL_03ae: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_03b3: ldarg.0
IL_03b4: ldarg.0
IL_03b5: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_03ba: ldc.i4.s 9
IL_03bc: ldelem.ref
IL_03bd: ldarg.0
IL_03be: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_03c3: ldc.i4.s 9
IL_03c5: ldelem.ref
IL_03c6: ldarg.1
IL_03c7: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_03cc: ldloc.s V_5
IL_03ce: callvirt System.String TheForestOfLove.Narrative.BioKinks::get_kink4Text()
IL_03d3: ldloc.s V_5
IL_03d5: ldfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink4Hidden
IL_03da: ldloc.s V_5
IL_03dc: callvirt System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink4Unlocked()
IL_03e1: ldloc.s V_5
IL_03e3: callvirt System.Single TheForestOfLove.Narrative.BioKinks::get_kink4TimeUnlocked()
IL_03e8: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_03ed: ldarg.0
IL_03ee: ldarg.0
IL_03ef: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_03f4: ldc.i4.s 10
IL_03f6: ldelem.ref
IL_03f7: ldarg.0
IL_03f8: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_03fd: ldc.i4.s 10
IL_03ff: ldelem.ref
IL_0400: ldarg.1
IL_0401: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_0406: ldloc.s V_5
IL_0408: callvirt System.String TheForestOfLove.Narrative.BioKinks::get_kink5Text()
IL_040d: ldloc.s V_5
IL_040f: ldfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink5Hidden
IL_0414: ldloc.s V_5
IL_0416: callvirt System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink5Unlocked()
IL_041b: ldloc.s V_5
IL_041d: callvirt System.Single TheForestOfLove.Narrative.BioKinks::get_kink5TimeUnlocked()
IL_0422: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_0427: ldarg.0
IL_0428: ldarg.0
IL_0429: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_042e: ldc.i4.s 11
IL_0430: ldelem.ref
IL_0431: ldarg.0
IL_0432: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_0437: ldc.i4.s 11
IL_0439: ldelem.ref
IL_043a: ldarg.1
IL_043b: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_0440: ldloc.s V_5
IL_0442: callvirt System.String TheForestOfLove.Narrative.BioKinks::get_kink6Text()
IL_0447: ldloc.s V_5
IL_0449: ldfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink6Hidden
IL_044e: ldloc.s V_5
IL_0450: callvirt System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink6Unlocked()
IL_0455: ldloc.s V_5
IL_0457: callvirt System.Single TheForestOfLove.Narrative.BioKinks::get_kink6TimeUnlocked()
IL_045c: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_0461: ldarg.0
IL_0462: ldarg.0
IL_0463: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_0468: ldc.i4.s 12
IL_046a: ldelem.ref
IL_046b: ldarg.0
IL_046c: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_0471: ldc.i4.s 12
IL_0473: ldelem.ref
IL_0474: ldarg.1
IL_0475: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_047a: ldloc.s V_5
IL_047c: callvirt System.String TheForestOfLove.Narrative.BioKinks::get_kink7Text()
IL_0481: ldloc.s V_5
IL_0483: ldfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink7Hidden
IL_0488: ldloc.s V_5
IL_048a: callvirt System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink7Unlocked()
IL_048f: ldloc.s V_5
IL_0491: callvirt System.Single TheForestOfLove.Narrative.BioKinks::get_kink7TimeUnlocked()
IL_0496: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_049b: ldarg.0
IL_049c: ldarg.0
IL_049d: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_04a2: ldc.i4.s 13
IL_04a4: ldelem.ref
IL_04a5: ldarg.0
IL_04a6: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_04ab: ldc.i4.s 13
IL_04ad: ldelem.ref
IL_04ae: ldarg.1
IL_04af: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_04b4: ldloc.s V_5
IL_04b6: callvirt System.String TheForestOfLove.Narrative.BioKinks::get_kink8Text()
IL_04bb: ldloc.s V_5
IL_04bd: ldfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink8Hidden
IL_04c2: ldloc.s V_5
IL_04c4: callvirt System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink8Unlocked()
IL_04c9: ldloc.s V_5
IL_04cb: callvirt System.Single TheForestOfLove.Narrative.BioKinks::get_kink8TimeUnlocked()
IL_04d0: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_04d5: ldarg.0
IL_04d6: ldarg.0
IL_04d7: ldfld UnityEngine.UI.Text[] TheForestOfLove.CritterLogBioPane::fragments
IL_04dc: ldc.i4.s 14
IL_04de: ldelem.ref
IL_04df: ldarg.0
IL_04e0: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.CritterLogBioPane::newLabels
IL_04e5: ldc.i4.s 14
IL_04e7: ldelem.ref
IL_04e8: ldarg.1
IL_04e9: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_04ee: ldloc.s V_5
IL_04f0: callvirt System.String TheForestOfLove.Narrative.BioKinks::get_kink9Text()
IL_04f5: ldloc.s V_5
IL_04f7: ldfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink9Hidden
IL_04fc: ldloc.s V_5
IL_04fe: callvirt System.Boolean TheForestOfLove.Narrative.BioKinks::get_isKink9Unlocked()
IL_0503: ldloc.s V_5
IL_0505: callvirt System.Single TheForestOfLove.Narrative.BioKinks::get_kink9TimeUnlocked()
IL_050a: call System.Void TheForestOfLove.CritterLogBioPane::UpdateKeywordText(UnityEngine.UI.Text,UnityEngine.CanvasGroup,System.Single,System.String,System.Boolean,System.Boolean,System.Single)
IL_050f: ret
