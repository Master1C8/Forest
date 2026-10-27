TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddArcPreconditionsAndTriggers(TheForestOfLove.Narrative.DataManifest) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialogues
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br IL_03fc
IL_0011: ldloca.s V_0
IL_0013: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0018: stloc.1
IL_0019: ldc.i4.0
IL_001a: stloc.2
IL_001b: ldloc.1
IL_001c: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0021: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> PixelCrushers.DialogueSystem.Conversation::dialogueEntries
IL_0026: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::GetEnumerator()
IL_002b: stloc.3
IL_002c: br IL_031e
IL_0031: ldloca.s V_3
IL_0033: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>::get_Current()
IL_0038: stloc.s V_4
IL_003a: ldnull
IL_003b: stloc.s V_5
IL_003d: ldloc.s V_4
IL_003f: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0044: ldstr "("
IL_0049: callvirt System.Boolean System.String::Contains(System.String)
IL_004e: brfalse.s IL_0077
IL_0050: ldloc.s V_4
IL_0052: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0057: callvirt System.String System.String::ToUpper()
IL_005c: ldc.i4.0
IL_005d: ldloc.s V_4
IL_005f: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0064: ldstr "("
IL_0069: callvirt System.Int32 System.String::IndexOf(System.String)
IL_006e: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0073: stloc.s V_5
IL_0075: br.s IL_0085
IL_0077: ldloc.s V_4
IL_0079: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_007e: callvirt System.String System.String::ToUpper()
IL_0083: stloc.s V_5
IL_0085: ldloc.s V_5
IL_0087: brfalse IL_031e
IL_008c: ldloc.s V_5
IL_008e: call System.UInt32 <PrivateImplementationDetails>::ComputeStringHash(System.String)
IL_0093: stloc.s V_6
IL_0095: ldloc.s V_6
IL_0097: ldc.i4 -1455197612
IL_009c: bgt.un.s IL_00f6
IL_009e: ldloc.s V_6
IL_00a0: ldc.i4 -2055085242
IL_00a5: bgt.un.s IL_00d0
IL_00a7: ldloc.s V_6
IL_00a9: ldc.i4 1688225680
IL_00ae: beq IL_026a
IL_00b3: ldloc.s V_6
IL_00b5: ldc.i4 1991176353
IL_00ba: beq IL_018e
IL_00bf: ldloc.s V_6
IL_00c1: ldc.i4 -2055085242
IL_00c6: beq IL_0228
IL_00cb: br IL_031e
IL_00d0: ldloc.s V_6
IL_00d2: ldc.i4 -1891415706
IL_00d7: beq IL_01fc
IL_00dc: ldloc.s V_6
IL_00de: ldc.i4 -1763262857
IL_00e3: beq.s IL_0162
IL_00e5: ldloc.s V_6
IL_00e7: ldc.i4 -1455197612
IL_00ec: beq IL_01e6
IL_00f1: br IL_031e
IL_00f6: ldloc.s V_6
IL_00f8: ldc.i4 -683920676
IL_00fd: bgt.un.s IL_0125
IL_00ff: ldloc.s V_6
IL_0101: ldc.i4 -1321070438
IL_0106: beq IL_023e
IL_010b: ldloc.s V_6
IL_010d: ldc.i4 -1094603797
IL_0112: beq IL_01d0
IL_0117: ldloc.s V_6
IL_0119: ldc.i4 -683920676
IL_011e: beq.s IL_0178
IL_0120: br IL_031e
IL_0125: ldloc.s V_6
IL_0127: ldc.i4 -528355727
IL_012c: bgt.un.s IL_0148
IL_012e: ldloc.s V_6
IL_0130: ldc.i4 -530920170
IL_0135: beq IL_0254
IL_013a: ldloc.s V_6
IL_013c: ldc.i4 -528355727
IL_0141: beq.s IL_01a4
IL_0143: br IL_031e
IL_0148: ldloc.s V_6
IL_014a: ldc.i4 -404060752
IL_014f: beq IL_0212
IL_0154: ldloc.s V_6
IL_0156: ldc.i4 -74380573
IL_015b: beq.s IL_01ba
IL_015d: br IL_031e
IL_0162: ldloc.s V_5
IL_0164: ldstr "GET"
IL_0169: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_016e: brtrue IL_0280
IL_0173: br IL_031e
IL_0178: ldloc.s V_5
IL_017a: ldstr "GIVE"
IL_017f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0184: brtrue IL_028e
IL_0189: br IL_031e
IL_018e: ldloc.s V_5
IL_0190: ldstr "CONSUME"
IL_0195: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_019a: brtrue IL_029d
IL_019f: br IL_031e
IL_01a4: ldloc.s V_5
IL_01a6: ldstr "BIO"
IL_01ab: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01b0: brtrue IL_02a9
IL_01b5: br IL_031e
IL_01ba: ldloc.s V_5
IL_01bc: ldstr "TRIGGER"
IL_01c1: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01c6: brtrue IL_02b5
IL_01cb: br IL_031e
IL_01d0: ldloc.s V_5
IL_01d2: ldstr "PORTRAITS"
IL_01d7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01dc: brtrue IL_02c1
IL_01e1: br IL_031e
IL_01e6: ldloc.s V_5
IL_01e8: ldstr "PORTRAITSALIGNL"
IL_01ed: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01f2: brtrue IL_02cc
IL_01f7: br IL_031e
IL_01fc: ldloc.s V_5
IL_01fe: ldstr "PORTRAITSALIGNR"
IL_0203: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0208: brtrue IL_02d8
IL_020d: br IL_031e
IL_0212: ldloc.s V_5
IL_0214: ldstr "FINISHSTEP"
IL_0219: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_021e: brtrue IL_02e4
IL_0223: br IL_031e
IL_0228: ldloc.s V_5
IL_022a: ldstr "FINISHARC"
IL_022f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0234: brtrue IL_02f1
IL_0239: br IL_031e
IL_023e: ldloc.s V_5
IL_0240: ldstr "ENCOUNTER"
IL_0245: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_024a: brtrue IL_02fc
IL_024f: br IL_031e
IL_0254: ldloc.s V_5
IL_0256: ldstr "INTRODUCE"
IL_025b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0260: brtrue IL_0308
IL_0265: br IL_031e
IL_026a: ldloc.s V_5
IL_026c: ldstr "FONT"
IL_0271: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0276: brtrue IL_0314
IL_027b: br IL_031e
IL_0280: ldarg.0
IL_0281: ldloc.1
IL_0282: ldloc.s V_4
IL_0284: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationTriggerAddItemToInventory(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_0289: br IL_031e
IL_028e: ldarg.0
IL_028f: ldloc.1
IL_0290: ldloc.s V_4
IL_0292: ldc.i4.0
IL_0293: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationTriggerRemoveItemFromInventory(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean)
IL_0298: br IL_031e
IL_029d: ldarg.0
IL_029e: ldloc.1
IL_029f: ldloc.s V_4
IL_02a1: ldc.i4.1
IL_02a2: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationTriggerRemoveItemFromInventory(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean)
IL_02a7: br.s IL_031e
IL_02a9: ldarg.0
IL_02aa: ldarg.1
IL_02ab: ldloc.1
IL_02ac: ldloc.s V_4
IL_02ae: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationTriggerUnlockBioFragment(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_02b3: br.s IL_031e
IL_02b5: ldarg.0
IL_02b6: ldarg.1
IL_02b7: ldloc.1
IL_02b8: ldloc.s V_4
IL_02ba: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationFireNamedTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_02bf: br.s IL_031e
IL_02c1: ldarg.0
IL_02c2: ldloc.1
IL_02c3: ldloc.s V_4
IL_02c5: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationPortraitsTrigger(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_02ca: br.s IL_031e
IL_02cc: ldarg.0
IL_02cd: ldarg.1
IL_02ce: ldloc.1
IL_02cf: ldloc.s V_4
IL_02d1: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationLeftAlignPortraitsTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_02d6: br.s IL_031e
IL_02d8: ldarg.0
IL_02d9: ldarg.1
IL_02da: ldloc.1
IL_02db: ldloc.s V_4
IL_02dd: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationRightAlignPortraitsTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_02e2: br.s IL_031e
IL_02e4: ldarg.0
IL_02e5: ldloc.1
IL_02e6: ldloc.s V_4
IL_02e8: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationFinishDialogueTrigger(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_02ed: ldc.i4.1
IL_02ee: stloc.2
IL_02ef: br.s IL_031e
IL_02f1: ldarg.0
IL_02f2: ldloc.1
IL_02f3: ldloc.s V_4
IL_02f5: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddArcManualCompletionTrigger(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_02fa: br.s IL_031e
IL_02fc: ldarg.0
IL_02fd: ldarg.1
IL_02fe: ldloc.1
IL_02ff: ldloc.s V_4
IL_0301: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationActorEncounteredTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_0306: br.s IL_031e
IL_0308: ldarg.0
IL_0309: ldarg.1
IL_030a: ldloc.1
IL_030b: ldloc.s V_4
IL_030d: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationActorIntroducedTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_0312: br.s IL_031e
IL_0314: ldarg.0
IL_0315: ldarg.1
IL_0316: ldloc.1
IL_0317: ldloc.s V_4
IL_0319: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationTriggerChangeFont(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry)
IL_031e: ldloca.s V_3
IL_0320: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>::MoveNext()
IL_0325: brtrue IL_0031
IL_032a: leave.s IL_033a
IL_032c: ldloca.s V_3
IL_032e: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>
IL_0334: callvirt System.Void System.IDisposable::Dispose()
IL_0339: endfinally
IL_033a: ldloc.2
IL_033b: brtrue.s IL_0381
IL_033d: ldloc.1
IL_033e: ldfld TheForestOfLove.DB.Dialogue TheForestOfLove.Narrative.Dialogue::dbDialogue
IL_0343: callvirt TheForestOfLove.DB.DialogueArc TheForestOfLove.DB.Dialogue::get_completion_arc()
IL_0348: brfalse.s IL_0381
IL_034a: ldloc.1
IL_034b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcsByDbArcSuffix
IL_0350: ldloc.1
IL_0351: ldfld TheForestOfLove.DB.Dialogue TheForestOfLove.Narrative.Dialogue::dbDialogue
IL_0356: callvirt TheForestOfLove.DB.DialogueArc TheForestOfLove.DB.Dialogue::get_completion_arc()
IL_035b: callvirt System.String TheForestOfLove.DB.DialogueArc::get_name()
IL_0360: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Arc>::get_Item(!0)
IL_0365: stloc.s V_7
IL_0367: ldloc.s V_7
IL_0369: ldfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.Arc::dialogue
IL_036e: ldloc.1
IL_036f: bne.un.s IL_0381
IL_0371: ldarg.0
IL_0372: ldloc.1
IL_0373: ldloc.s V_7
IL_0375: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_037a: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredDialogueFinishTrigger(TheForestOfLove.Narrative.Dialogue,System.Collections.Generic.IEnumerable`1<PixelCrushers.DialogueSystem.DialogueEntry>)
IL_037f: ldc.i4.1
IL_0380: stloc.2
IL_0381: ldloc.2
IL_0382: brtrue.s IL_03fc
IL_0384: ldloc.1
IL_0385: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_038a: ldc.i4 700
IL_038f: beq.s IL_03fc
IL_0391: ldloc.1
IL_0392: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetLastPrimaryArc()
IL_0397: stloc.s V_8
IL_0399: ldloc.s V_8
IL_039b: brtrue.s IL_03a5
IL_039d: ldloc.1
IL_039e: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetLastSecondaryArc()
IL_03a3: stloc.s V_8
IL_03a5: ldloc.s V_8
IL_03a7: brtrue.s IL_03b1
IL_03a9: ldloc.1
IL_03aa: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetLastIdleArc()
IL_03af: stloc.s V_8
IL_03b1: ldloc.s V_8
IL_03b3: brtrue.s IL_03d4
IL_03b5: ldloc.1
IL_03b6: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_03bb: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::get_Count()
IL_03c0: ldc.i4.1
IL_03c1: beq.s IL_03c6
IL_03c3: ldnull
IL_03c4: br.s IL_03d2
IL_03c6: ldloc.1
IL_03c7: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_03cc: ldc.i4.0
IL_03cd: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::get_Item(System.Int32)
IL_03d2: stloc.s V_8
IL_03d4: ldloc.s V_8
IL_03d6: brtrue.s IL_03ee
IL_03d8: ldstr "missing dialogue completion trigger default arc "
IL_03dd: ldloc.1
IL_03de: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_03e3: call System.String System.String::Concat(System.String,System.String)
IL_03e8: newobj System.Void System.Exception::.ctor(System.String)
IL_03ed: throw
IL_03ee: ldarg.0
IL_03ef: ldloc.1
IL_03f0: ldloc.s V_8
IL_03f2: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_03f7: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredDialogueFinishTrigger(TheForestOfLove.Narrative.Dialogue,System.Collections.Generic.IEnumerable`1<PixelCrushers.DialogueSystem.DialogueEntry>)
IL_03fc: ldloca.s V_0
IL_03fe: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0403: brtrue IL_0011
IL_0408: leave.s IL_0418
IL_040a: ldloca.s V_0
IL_040c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0412: callvirt System.Void System.IDisposable::Dispose()
IL_0417: endfinally
IL_0418: ret
