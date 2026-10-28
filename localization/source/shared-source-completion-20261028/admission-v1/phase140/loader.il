TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddDialoguePreconditionsAndTriggers(TheForestOfLove.Narrative.DataManifest) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialogues
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br IL_0cd4
IL_0011: ldloca.s V_0
IL_0013: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0018: stloc.1
IL_0019: newobj System.Void TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::.ctor()
IL_001e: stloc.2
IL_001f: ldloc.1
IL_0020: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition> TheForestOfLove.Narrative.Dialogue::preconditions
IL_0025: ldloc.2
IL_0026: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::Add(!0)
IL_002b: ldloc.1
IL_002c: ldfld TheForestOfLove.DB.Dialogue TheForestOfLove.Narrative.Dialogue::dbDialogue
IL_0031: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueAvailabilityRule> TheForestOfLove.DB.Dialogue::get_RelatedDialogueAvailabilityRuleListUsingdialogue_filterRelation()
IL_0036: brfalse IL_0b75
IL_003b: ldloc.1
IL_003c: ldfld TheForestOfLove.DB.Dialogue TheForestOfLove.Narrative.Dialogue::dbDialogue
IL_0041: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueAvailabilityRule> TheForestOfLove.DB.Dialogue::get_RelatedDialogueAvailabilityRuleListUsingdialogue_filterRelation()
IL_0046: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueAvailabilityRule>::GetEnumerator()
IL_004b: stloc.3
IL_004c: br IL_0b59
IL_0051: ldloca.s V_3
IL_0053: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueAvailabilityRule>::get_Current()
IL_0058: stloc.s V_4
IL_005a: ldloc.s V_4
IL_005c: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueAvailabilityRule::get_quests_any()
IL_0061: brfalse.s IL_00b2
IL_0063: ldloc.s V_4
IL_0065: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueAvailabilityRule::get_quests_any()
IL_006a: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Quest>::GetEnumerator()
IL_006f: stloc.s V_5
IL_0071: br.s IL_0099
IL_0073: ldloca.s V_5
IL_0075: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::get_Current()
IL_007a: stloc.s V_6
IL_007c: ldloc.2
IL_007d: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::questsAny
IL_0082: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::quests
IL_0087: ldarg.1
IL_0088: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbQuest
IL_008d: ldloc.s V_6
IL_008f: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_0094: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::Add(!0)
IL_0099: ldloca.s V_5
IL_009b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::MoveNext()
IL_00a0: brtrue.s IL_0073
IL_00a2: leave.s IL_00b2
IL_00a4: ldloca.s V_5
IL_00a6: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>
IL_00ac: callvirt System.Void System.IDisposable::Dispose()
IL_00b1: endfinally
IL_00b2: ldloc.s V_4
IL_00b4: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueAvailabilityRule::get_quests_all()
IL_00b9: brfalse.s IL_010a
IL_00bb: ldloc.s V_4
IL_00bd: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueAvailabilityRule::get_quests_all()
IL_00c2: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Quest>::GetEnumerator()
IL_00c7: stloc.s V_5
IL_00c9: br.s IL_00f1
IL_00cb: ldloca.s V_5
IL_00cd: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::get_Current()
IL_00d2: stloc.s V_7
IL_00d4: ldloc.2
IL_00d5: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::questsAll
IL_00da: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::quests
IL_00df: ldarg.1
IL_00e0: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbQuest
IL_00e5: ldloc.s V_7
IL_00e7: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_00ec: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::Add(!0)
IL_00f1: ldloca.s V_5
IL_00f3: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::MoveNext()
IL_00f8: brtrue.s IL_00cb
IL_00fa: leave.s IL_010a
IL_00fc: ldloca.s V_5
IL_00fe: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>
IL_0104: callvirt System.Void System.IDisposable::Dispose()
IL_0109: endfinally
IL_010a: ldloc.s V_4
IL_010c: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueAvailabilityRule::get_antiquests_any()
IL_0111: brfalse.s IL_0162
IL_0113: ldloc.s V_4
IL_0115: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueAvailabilityRule::get_antiquests_any()
IL_011a: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Quest>::GetEnumerator()
IL_011f: stloc.s V_5
IL_0121: br.s IL_0149
IL_0123: ldloca.s V_5
IL_0125: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::get_Current()
IL_012a: stloc.s V_8
IL_012c: ldloc.2
IL_012d: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiQuestsAny
IL_0132: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::quests
IL_0137: ldarg.1
IL_0138: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbQuest
IL_013d: ldloc.s V_8
IL_013f: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_0144: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::Add(!0)
IL_0149: ldloca.s V_5
IL_014b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::MoveNext()
IL_0150: brtrue.s IL_0123
IL_0152: leave.s IL_0162
IL_0154: ldloca.s V_5
IL_0156: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>
IL_015c: callvirt System.Void System.IDisposable::Dispose()
IL_0161: endfinally
IL_0162: ldloc.s V_4
IL_0164: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueAvailabilityRule::get_antiquests_all()
IL_0169: brfalse.s IL_01ba
IL_016b: ldloc.s V_4
IL_016d: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueAvailabilityRule::get_antiquests_all()
IL_0172: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Quest>::GetEnumerator()
IL_0177: stloc.s V_5
IL_0179: br.s IL_01a1
IL_017b: ldloca.s V_5
IL_017d: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::get_Current()
IL_0182: stloc.s V_9
IL_0184: ldloc.2
IL_0185: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiQuestsAll
IL_018a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingQuests::quests
IL_018f: ldarg.1
IL_0190: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbQuest
IL_0195: ldloc.s V_9
IL_0197: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_019c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::Add(!0)
IL_01a1: ldloca.s V_5
IL_01a3: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::MoveNext()
IL_01a8: brtrue.s IL_017b
IL_01aa: leave.s IL_01ba
IL_01ac: ldloca.s V_5
IL_01ae: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>
IL_01b4: callvirt System.Void System.IDisposable::Dispose()
IL_01b9: endfinally
IL_01ba: ldloc.s V_4
IL_01bc: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueAvailabilityRule::get_dialogues_any()
IL_01c1: brfalse.s IL_0212
IL_01c3: ldloc.s V_4
IL_01c5: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueAvailabilityRule::get_dialogues_any()
IL_01ca: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue>::GetEnumerator()
IL_01cf: stloc.s V_10
IL_01d1: br.s IL_01f9
IL_01d3: ldloca.s V_10
IL_01d5: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::get_Current()
IL_01da: stloc.s V_11
IL_01dc: ldloc.2
IL_01dd: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::dialoguesAny
IL_01e2: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues::dialogues
IL_01e7: ldarg.1
IL_01e8: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbDialogue
IL_01ed: ldloc.s V_11
IL_01ef: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_01f4: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_01f9: ldloca.s V_10
IL_01fb: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::MoveNext()
IL_0200: brtrue.s IL_01d3
IL_0202: leave.s IL_0212
IL_0204: ldloca.s V_10
IL_0206: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>
IL_020c: callvirt System.Void System.IDisposable::Dispose()
IL_0211: endfinally
IL_0212: ldloc.s V_4
IL_0214: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueAvailabilityRule::get_dialogues_all()
IL_0219: brfalse.s IL_026a
IL_021b: ldloc.s V_4
IL_021d: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueAvailabilityRule::get_dialogues_all()
IL_0222: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue>::GetEnumerator()
IL_0227: stloc.s V_10
IL_0229: br.s IL_0251
IL_022b: ldloca.s V_10
IL_022d: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::get_Current()
IL_0232: stloc.s V_12
IL_0234: ldloc.2
IL_0235: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::dialoguesAll
IL_023a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues::dialogues
IL_023f: ldarg.1
IL_0240: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbDialogue
IL_0245: ldloc.s V_12
IL_0247: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_024c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_0251: ldloca.s V_10
IL_0253: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::MoveNext()
IL_0258: brtrue.s IL_022b
IL_025a: leave.s IL_026a
IL_025c: ldloca.s V_10
IL_025e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>
IL_0264: callvirt System.Void System.IDisposable::Dispose()
IL_0269: endfinally
IL_026a: ldloc.s V_4
IL_026c: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueAvailabilityRule::get_antidialogues_any()
IL_0271: brfalse.s IL_02c2
IL_0273: ldloc.s V_4
IL_0275: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueAvailabilityRule::get_antidialogues_any()
IL_027a: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue>::GetEnumerator()
IL_027f: stloc.s V_10
IL_0281: br.s IL_02a9
IL_0283: ldloca.s V_10
IL_0285: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::get_Current()
IL_028a: stloc.s V_13
IL_028c: ldloc.2
IL_028d: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiDialoguesAny
IL_0292: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues::dialogues
IL_0297: ldarg.1
IL_0298: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbDialogue
IL_029d: ldloc.s V_13
IL_029f: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_02a4: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_02a9: ldloca.s V_10
IL_02ab: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::MoveNext()
IL_02b0: brtrue.s IL_0283
IL_02b2: leave.s IL_02c2
IL_02b4: ldloca.s V_10
IL_02b6: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>
IL_02bc: callvirt System.Void System.IDisposable::Dispose()
IL_02c1: endfinally
IL_02c2: ldloc.s V_4
IL_02c4: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueAvailabilityRule::get_antidialogues_all()
IL_02c9: brfalse.s IL_031a
IL_02cb: ldloc.s V_4
IL_02cd: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueAvailabilityRule::get_antidialogues_all()
IL_02d2: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue>::GetEnumerator()
IL_02d7: stloc.s V_10
IL_02d9: br.s IL_0301
IL_02db: ldloca.s V_10
IL_02dd: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::get_Current()
IL_02e2: stloc.s V_14
IL_02e4: ldloc.2
IL_02e5: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiDialoguesAll
IL_02ea: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues::dialogues
IL_02ef: ldarg.1
IL_02f0: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbDialogue
IL_02f5: ldloc.s V_14
IL_02f7: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_02fc: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_0301: ldloca.s V_10
IL_0303: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::MoveNext()
IL_0308: brtrue.s IL_02db
IL_030a: leave.s IL_031a
IL_030c: ldloca.s V_10
IL_030e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>
IL_0314: callvirt System.Void System.IDisposable::Dispose()
IL_0319: endfinally
IL_031a: ldloc.s V_4
IL_031c: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueAvailabilityRule::get_tags_any()
IL_0321: brfalse.s IL_0392
IL_0323: ldloc.s V_4
IL_0325: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueAvailabilityRule::get_tags_any()
IL_032a: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_032f: stloc.s V_15
IL_0331: br.s IL_0379
IL_0333: ldloca.s V_15
IL_0335: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_033a: stloc.s V_16
IL_033c: ldarg.1
IL_033d: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_0342: ldloc.s V_16
IL_0344: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_0349: stloc.s V_17
IL_034b: ldloc.2
IL_034c: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::tagsAny
IL_0351: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_0356: ldloc.s V_17
IL_0358: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_035d: ldloc.1
IL_035e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Dialogue::tagsAnyInformationalOnly
IL_0363: ldloc.s V_17
IL_0365: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Contains(!0)
IL_036a: brtrue.s IL_0379
IL_036c: ldloc.1
IL_036d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Dialogue::tagsAnyInformationalOnly
IL_0372: ldloc.s V_17
IL_0374: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0379: ldloca.s V_15
IL_037b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_0380: brtrue.s IL_0333
IL_0382: leave.s IL_0392
IL_0384: ldloca.s V_15
IL_0386: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_038c: callvirt System.Void System.IDisposable::Dispose()
IL_0391: endfinally
IL_0392: ldloc.s V_4
IL_0394: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueAvailabilityRule::get_tags_all()
IL_0399: brfalse.s IL_040a
IL_039b: ldloc.s V_4
IL_039d: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueAvailabilityRule::get_tags_all()
IL_03a2: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_03a7: stloc.s V_15
IL_03a9: br.s IL_03f1
IL_03ab: ldloca.s V_15
IL_03ad: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_03b2: stloc.s V_18
IL_03b4: ldarg.1
IL_03b5: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_03ba: ldloc.s V_18
IL_03bc: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_03c1: stloc.s V_19
IL_03c3: ldloc.2
IL_03c4: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::tagsAll
IL_03c9: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_03ce: ldloc.s V_19
IL_03d0: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_03d5: ldloc.1
IL_03d6: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Dialogue::tagsAllInformationalOnly
IL_03db: ldloc.s V_19
IL_03dd: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Contains(!0)
IL_03e2: brtrue.s IL_03f1
IL_03e4: ldloc.1
IL_03e5: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Dialogue::tagsAllInformationalOnly
IL_03ea: ldloc.s V_19
IL_03ec: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_03f1: ldloca.s V_15
IL_03f3: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_03f8: brtrue.s IL_03ab
IL_03fa: leave.s IL_040a
IL_03fc: ldloca.s V_15
IL_03fe: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_0404: callvirt System.Void System.IDisposable::Dispose()
IL_0409: endfinally
IL_040a: ldloc.s V_4
IL_040c: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueAvailabilityRule::get_antitags_any()
IL_0411: brfalse.s IL_0462
IL_0413: ldloc.s V_4
IL_0415: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueAvailabilityRule::get_antitags_any()
IL_041a: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_041f: stloc.s V_15
IL_0421: br.s IL_0449
IL_0423: ldloca.s V_15
IL_0425: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_042a: stloc.s V_20
IL_042c: ldloc.2
IL_042d: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiTagsAny
IL_0432: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_0437: ldarg.1
IL_0438: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_043d: ldloc.s V_20
IL_043f: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_0444: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0449: ldloca.s V_15
IL_044b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_0450: brtrue.s IL_0423
IL_0452: leave.s IL_0462
IL_0454: ldloca.s V_15
IL_0456: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_045c: callvirt System.Void System.IDisposable::Dispose()
IL_0461: endfinally
IL_0462: ldloc.s V_4
IL_0464: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueAvailabilityRule::get_antitags_all()
IL_0469: brfalse.s IL_04ba
IL_046b: ldloc.s V_4
IL_046d: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueAvailabilityRule::get_antitags_all()
IL_0472: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_0477: stloc.s V_15
IL_0479: br.s IL_04a1
IL_047b: ldloca.s V_15
IL_047d: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_0482: stloc.s V_21
IL_0484: ldloc.2
IL_0485: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiTagsAll
IL_048a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTags::tags
IL_048f: ldarg.1
IL_0490: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_0495: ldloc.s V_21
IL_0497: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_049c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_04a1: ldloca.s V_15
IL_04a3: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_04a8: brtrue.s IL_047b
IL_04aa: leave.s IL_04ba
IL_04ac: ldloca.s V_15
IL_04ae: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_04b4: callvirt System.Void System.IDisposable::Dispose()
IL_04b9: endfinally
IL_04ba: ldloc.s V_4
IL_04bc: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.DialogueAvailabilityRule::get_triggers_any()
IL_04c1: brfalse.s IL_052f
IL_04c3: ldloc.s V_4
IL_04c5: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.DialogueAvailabilityRule::get_triggers_any()
IL_04ca: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger>::GetEnumerator()
IL_04cf: stloc.s V_22
IL_04d1: br.s IL_0516
IL_04d3: ldloca.s V_22
IL_04d5: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::get_Current()
IL_04da: stloc.s V_23
IL_04dc: ldloc.2
IL_04dd: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTriggers TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::triggersAny
IL_04e2: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTriggers::triggers
IL_04e7: ldarg.1
IL_04e8: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_04ed: ldloc.s V_23
IL_04ef: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_04f4: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::Add(!0)
IL_04f9: ldloc.1
IL_04fa: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.Dialogue::triggersRequireAny_bugfix
IL_04ff: ldarg.1
IL_0500: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_0505: ldloc.s V_23
IL_0507: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_050c: ldfld System.String TheForestOfLove.Narrative.Trigger::name
IL_0511: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0516: ldloca.s V_22
IL_0518: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::MoveNext()
IL_051d: brtrue.s IL_04d3
IL_051f: leave.s IL_052f
IL_0521: ldloca.s V_22
IL_0523: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>
IL_0529: callvirt System.Void System.IDisposable::Dispose()
IL_052e: endfinally
IL_052f: ldloc.s V_4
IL_0531: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.DialogueAvailabilityRule::get_triggers_all()
IL_0536: brfalse.s IL_05a4
IL_0538: ldloc.s V_4
IL_053a: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.DialogueAvailabilityRule::get_triggers_all()
IL_053f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger>::GetEnumerator()
IL_0544: stloc.s V_22
IL_0546: br.s IL_058b
IL_0548: ldloca.s V_22
IL_054a: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::get_Current()
IL_054f: stloc.s V_24
IL_0551: ldloc.2
IL_0552: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTriggers TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::triggersAll
IL_0557: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTriggers::triggers
IL_055c: ldarg.1
IL_055d: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_0562: ldloc.s V_24
IL_0564: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_0569: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::Add(!0)
IL_056e: ldloc.1
IL_056f: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.Dialogue::triggersRequireAll_bugfix
IL_0574: ldarg.1
IL_0575: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_057a: ldloc.s V_24
IL_057c: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_0581: ldfld System.String TheForestOfLove.Narrative.Trigger::name
IL_0586: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_058b: ldloca.s V_22
IL_058d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::MoveNext()
IL_0592: brtrue.s IL_0548
IL_0594: leave.s IL_05a4
IL_0596: ldloca.s V_22
IL_0598: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>
IL_059e: callvirt System.Void System.IDisposable::Dispose()
IL_05a3: endfinally
IL_05a4: ldloc.s V_4
IL_05a6: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.DialogueAvailabilityRule::get_antitriggers_any()
IL_05ab: brfalse.s IL_05fc
IL_05ad: ldloc.s V_4
IL_05af: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.DialogueAvailabilityRule::get_antitriggers_any()
IL_05b4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger>::GetEnumerator()
IL_05b9: stloc.s V_22
IL_05bb: br.s IL_05e3
IL_05bd: ldloca.s V_22
IL_05bf: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::get_Current()
IL_05c4: stloc.s V_25
IL_05c6: ldloc.2
IL_05c7: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTriggers TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiTriggersAny
IL_05cc: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTriggers::triggers
IL_05d1: ldarg.1
IL_05d2: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_05d7: ldloc.s V_25
IL_05d9: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_05de: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::Add(!0)
IL_05e3: ldloca.s V_22
IL_05e5: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::MoveNext()
IL_05ea: brtrue.s IL_05bd
IL_05ec: leave.s IL_05fc
IL_05ee: ldloca.s V_22
IL_05f0: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>
IL_05f6: callvirt System.Void System.IDisposable::Dispose()
IL_05fb: endfinally
IL_05fc: ldloc.s V_4
IL_05fe: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.DialogueAvailabilityRule::get_antitriggers_all()
IL_0603: brfalse.s IL_0654
IL_0605: ldloc.s V_4
IL_0607: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.DialogueAvailabilityRule::get_antitriggers_all()
IL_060c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger>::GetEnumerator()
IL_0611: stloc.s V_22
IL_0613: br.s IL_063b
IL_0615: ldloca.s V_22
IL_0617: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::get_Current()
IL_061c: stloc.s V_26
IL_061e: ldloc.2
IL_061f: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTriggers TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiTriggersAll
IL_0624: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingTriggers::triggers
IL_0629: ldarg.1
IL_062a: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_062f: ldloc.s V_26
IL_0631: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_0636: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::Add(!0)
IL_063b: ldloca.s V_22
IL_063d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::MoveNext()
IL_0642: brtrue.s IL_0615
IL_0644: leave.s IL_0654
IL_0646: ldloca.s V_22
IL_0648: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>
IL_064e: callvirt System.Void System.IDisposable::Dispose()
IL_0653: endfinally
IL_0654: ldloc.s V_4
IL_0656: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Area> TheForestOfLove.DB.DialogueAvailabilityRule::get_areas_allowed()
IL_065b: brfalse.s IL_06a6
IL_065d: ldloc.s V_4
IL_065f: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Area> TheForestOfLove.DB.DialogueAvailabilityRule::get_areas_allowed()
IL_0664: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Area>::GetEnumerator()
IL_0669: stloc.s V_27
IL_066b: br.s IL_068d
IL_066d: ldloca.s V_27
IL_066f: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>::get_Current()
IL_0674: stloc.s V_28
IL_0676: ldloc.2
IL_0677: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireArea TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::areas
IL_067c: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireArea::areasAllowed
IL_0681: ldloc.s V_28
IL_0683: callvirt System.String TheForestOfLove.DB.Area::get_unity_scene_name()
IL_0688: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_068d: ldloca.s V_27
IL_068f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>::MoveNext()
IL_0694: brtrue.s IL_066d
IL_0696: leave.s IL_06a6
IL_0698: ldloca.s V_27
IL_069a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>
IL_06a0: callvirt System.Void System.IDisposable::Dispose()
IL_06a5: endfinally
IL_06a6: ldloc.s V_4
IL_06a8: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Area> TheForestOfLove.DB.DialogueAvailabilityRule::get_areas_denied()
IL_06ad: brfalse.s IL_06f8
IL_06af: ldloc.s V_4
IL_06b1: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Area> TheForestOfLove.DB.DialogueAvailabilityRule::get_areas_denied()
IL_06b6: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Area>::GetEnumerator()
IL_06bb: stloc.s V_27
IL_06bd: br.s IL_06df
IL_06bf: ldloca.s V_27
IL_06c1: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>::get_Current()
IL_06c6: stloc.s V_29
IL_06c8: ldloc.2
IL_06c9: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireArea TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::areas
IL_06ce: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireArea::areasDenied
IL_06d3: ldloc.s V_29
IL_06d5: callvirt System.String TheForestOfLove.DB.Area::get_unity_scene_name()
IL_06da: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_06df: ldloca.s V_27
IL_06e1: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>::MoveNext()
IL_06e6: brtrue.s IL_06bf
IL_06e8: leave.s IL_06f8
IL_06ea: ldloca.s V_27
IL_06ec: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>
IL_06f2: callvirt System.Void System.IDisposable::Dispose()
IL_06f7: endfinally
IL_06f8: ldloc.s V_4
IL_06fa: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Area> TheForestOfLove.DB.DialogueAvailabilityRule::get_areas_prior_required()
IL_06ff: brfalse.s IL_074a
IL_0701: ldloc.s V_4
IL_0703: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Area> TheForestOfLove.DB.DialogueAvailabilityRule::get_areas_prior_required()
IL_0708: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Area>::GetEnumerator()
IL_070d: stloc.s V_27
IL_070f: br.s IL_0731
IL_0711: ldloca.s V_27
IL_0713: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>::get_Current()
IL_0718: stloc.s V_30
IL_071a: ldloc.2
IL_071b: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireArea TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::areas
IL_0720: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireArea::areasPriorRequired
IL_0725: ldloc.s V_30
IL_0727: callvirt System.String TheForestOfLove.DB.Area::get_unity_scene_name()
IL_072c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0731: ldloca.s V_27
IL_0733: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>::MoveNext()
IL_0738: brtrue.s IL_0711
IL_073a: leave.s IL_074a
IL_073c: ldloca.s V_27
IL_073e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>
IL_0744: callvirt System.Void System.IDisposable::Dispose()
IL_0749: endfinally
IL_074a: ldloc.s V_4
IL_074c: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Area> TheForestOfLove.DB.DialogueAvailabilityRule::get_areas_prior_disallowed()
IL_0751: brfalse.s IL_079c
IL_0753: ldloc.s V_4
IL_0755: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Area> TheForestOfLove.DB.DialogueAvailabilityRule::get_areas_prior_disallowed()
IL_075a: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Area>::GetEnumerator()
IL_075f: stloc.s V_27
IL_0761: br.s IL_0783
IL_0763: ldloca.s V_27
IL_0765: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>::get_Current()
IL_076a: stloc.s V_31
IL_076c: ldloc.2
IL_076d: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireArea TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::areas
IL_0772: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireArea::areasPriorDisallowed
IL_0777: ldloc.s V_31
IL_0779: callvirt System.String TheForestOfLove.DB.Area::get_unity_scene_name()
IL_077e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0783: ldloca.s V_27
IL_0785: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>::MoveNext()
IL_078a: brtrue.s IL_0763
IL_078c: leave.s IL_079c
IL_078e: ldloca.s V_27
IL_0790: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Area>
IL_0796: callvirt System.Void System.IDisposable::Dispose()
IL_079b: endfinally
IL_079c: ldloc.s V_4
IL_079e: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueAvailabilityRule::get_items_any()
IL_07a3: brfalse.s IL_07f4
IL_07a5: ldloc.s V_4
IL_07a7: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueAvailabilityRule::get_items_any()
IL_07ac: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem>::GetEnumerator()
IL_07b1: stloc.s V_32
IL_07b3: br.s IL_07db
IL_07b5: ldloca.s V_32
IL_07b7: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>::get_Current()
IL_07bc: stloc.s V_33
IL_07be: ldloc.2
IL_07bf: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingItems TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::itemsAny
IL_07c4: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingItems::items
IL_07c9: ldarg.1
IL_07ca: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByDbItem
IL_07cf: ldloc.s V_33
IL_07d1: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem>::get_Item(!0)
IL_07d6: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::Add(!0)
IL_07db: ldloca.s V_32
IL_07dd: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>::MoveNext()
IL_07e2: brtrue.s IL_07b5
IL_07e4: leave.s IL_07f4
IL_07e6: ldloca.s V_32
IL_07e8: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>
IL_07ee: callvirt System.Void System.IDisposable::Dispose()
IL_07f3: endfinally
IL_07f4: ldloc.s V_4
IL_07f6: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueAvailabilityRule::get_items_all()
IL_07fb: brfalse.s IL_084c
IL_07fd: ldloc.s V_4
IL_07ff: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueAvailabilityRule::get_items_all()
IL_0804: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem>::GetEnumerator()
IL_0809: stloc.s V_32
IL_080b: br.s IL_0833
IL_080d: ldloca.s V_32
IL_080f: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>::get_Current()
IL_0814: stloc.s V_34
IL_0816: ldloc.2
IL_0817: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingItems TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::itemsAll
IL_081c: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingItems::items
IL_0821: ldarg.1
IL_0822: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByDbItem
IL_0827: ldloc.s V_34
IL_0829: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem>::get_Item(!0)
IL_082e: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::Add(!0)
IL_0833: ldloca.s V_32
IL_0835: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>::MoveNext()
IL_083a: brtrue.s IL_080d
IL_083c: leave.s IL_084c
IL_083e: ldloca.s V_32
IL_0840: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>
IL_0846: callvirt System.Void System.IDisposable::Dispose()
IL_084b: endfinally
IL_084c: ldloc.s V_4
IL_084e: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueAvailabilityRule::get_antiitems_any()
IL_0853: brfalse.s IL_08a4
IL_0855: ldloc.s V_4
IL_0857: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueAvailabilityRule::get_antiitems_any()
IL_085c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem>::GetEnumerator()
IL_0861: stloc.s V_32
IL_0863: br.s IL_088b
IL_0865: ldloca.s V_32
IL_0867: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>::get_Current()
IL_086c: stloc.s V_35
IL_086e: ldloc.2
IL_086f: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingItems TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiItemsAny
IL_0874: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingItems::items
IL_0879: ldarg.1
IL_087a: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByDbItem
IL_087f: ldloc.s V_35
IL_0881: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem>::get_Item(!0)
IL_0886: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::Add(!0)
IL_088b: ldloca.s V_32
IL_088d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>::MoveNext()
IL_0892: brtrue.s IL_0865
IL_0894: leave.s IL_08a4
IL_0896: ldloca.s V_32
IL_0898: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>
IL_089e: callvirt System.Void System.IDisposable::Dispose()
IL_08a3: endfinally
IL_08a4: ldloc.s V_4
IL_08a6: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueAvailabilityRule::get_antiitems_all()
IL_08ab: brfalse.s IL_08fc
IL_08ad: ldloc.s V_4
IL_08af: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueAvailabilityRule::get_antiitems_all()
IL_08b4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem>::GetEnumerator()
IL_08b9: stloc.s V_32
IL_08bb: br.s IL_08e3
IL_08bd: ldloca.s V_32
IL_08bf: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>::get_Current()
IL_08c4: stloc.s V_36
IL_08c6: ldloc.2
IL_08c7: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingItems TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::antiItemsAll
IL_08cc: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingItems::items
IL_08d1: ldarg.1
IL_08d2: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByDbItem
IL_08d7: ldloc.s V_36
IL_08d9: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.InventoryItem,TheForestOfLove.Inventory.InventoryItem>::get_Item(!0)
IL_08de: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::Add(!0)
IL_08e3: ldloca.s V_32
IL_08e5: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>::MoveNext()
IL_08ea: brtrue.s IL_08bd
IL_08ec: leave.s IL_08fc
IL_08ee: ldloca.s V_32
IL_08f0: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.InventoryItem>
IL_08f6: callvirt System.Void System.IDisposable::Dispose()
IL_08fb: endfinally
IL_08fc: ldloc.2
IL_08fd: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::randomChance
IL_0902: ldloc.s V_4
IL_0904: callvirt System.Single TheForestOfLove.DB.DialogueAvailabilityRule::get_percent_chance()
IL_0909: stfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::percentChance
IL_090e: ldloc.s V_4
IL_0910: callvirt System.Single TheForestOfLove.DB.DialogueAvailabilityRule::get_percent_chance()
IL_0915: ldc.r4 0
IL_091a: blt.s IL_092a
IL_091c: ldloc.s V_4
IL_091e: callvirt System.Single TheForestOfLove.DB.DialogueAvailabilityRule::get_percent_chance()
IL_0923: ldc.r4 1
IL_0928: ble.un.s IL_0940
IL_092a: ldstr "percent chance must be between 0 and 1 "
IL_092f: ldloc.1
IL_0930: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0935: call System.String System.String::Concat(System.String,System.String)
IL_093a: newobj System.Void System.Exception::.ctor(System.String)
IL_093f: throw
IL_0940: ldloc.1
IL_0941: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0946: ldc.i4 600
IL_094b: beq.s IL_095a
IL_094d: ldloc.1
IL_094e: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0953: ldc.i4 500
IL_0958: bne.un.s IL_097e
IL_095a: ldloc.s V_4
IL_095c: callvirt System.Single TheForestOfLove.DB.DialogueAvailabilityRule::get_percent_chance()
IL_0961: ldc.r4 0
IL_0966: bne.un.s IL_097e
IL_0968: ldstr "percent chance is 0 so the gift or date can never occur "
IL_096d: ldloc.1
IL_096e: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0973: call System.String System.String::Concat(System.String,System.String)
IL_0978: newobj System.Void System.Exception::.ctor(System.String)
IL_097d: throw
IL_097e: ldloc.2
IL_097f: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::randomChance
IL_0984: ldloc.s V_4
IL_0986: callvirt System.Int32 TheForestOfLove.DB.DialogueAvailabilityRule::get_max_unlucky_rolls()
IL_098b: conv.r4
IL_098c: stfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::maxUnluckyRolls
IL_0991: ldloc.s V_4
IL_0993: callvirt System.Single TheForestOfLove.DB.DialogueAvailabilityRule::get_require_time_since_event()
IL_0998: ldc.r4 0
IL_099d: beq.s IL_09b1
IL_099f: ldloc.2
IL_09a0: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireTime TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::requireTime
IL_09a5: ldloc.s V_4
IL_09a7: callvirt System.Single TheForestOfLove.DB.DialogueAvailabilityRule::get_require_time_since_event()
IL_09ac: stfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireTime::requiredTime
IL_09b1: ldloc.s V_4
IL_09b3: callvirt TheForestOfLove.DB.Trigger TheForestOfLove.DB.DialogueAvailabilityRule::get_time_check_trigger()
IL_09b8: brfalse.s IL_09d1
IL_09ba: ldloc.2
IL_09bb: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireTime TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::requireTime
IL_09c0: ldloc.s V_4
IL_09c2: callvirt TheForestOfLove.DB.Trigger TheForestOfLove.DB.DialogueAvailabilityRule::get_time_check_trigger()
IL_09c7: callvirt System.String TheForestOfLove.DB.Trigger::get_name()
IL_09cc: stfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireTime::triggerName
IL_09d1: ldloc.s V_4
IL_09d3: callvirt TheForestOfLove.DB.Trigger TheForestOfLove.DB.DialogueAvailabilityRule::get_onscreen_check_trigger()
IL_09d8: brfalse.s IL_09f1
IL_09da: ldloc.2
IL_09db: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_09e0: ldloc.s V_4
IL_09e2: callvirt TheForestOfLove.DB.Trigger TheForestOfLove.DB.DialogueAvailabilityRule::get_onscreen_check_trigger()
IL_09e7: callvirt System.String TheForestOfLove.DB.Trigger::get_name()
IL_09ec: stfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::onscreenTriggerName
IL_09f1: ldloc.s V_4
IL_09f3: callvirt TheForestOfLove.DB.Trigger TheForestOfLove.DB.DialogueAvailabilityRule::get_offscreen_check_trigger()
IL_09f8: brfalse.s IL_0a11
IL_09fa: ldloc.2
IL_09fb: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_0a00: ldloc.s V_4
IL_0a02: callvirt TheForestOfLove.DB.Trigger TheForestOfLove.DB.DialogueAvailabilityRule::get_offscreen_check_trigger()
IL_0a07: callvirt System.String TheForestOfLove.DB.Trigger::get_name()
IL_0a0c: stfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::offscreenTriggerName
IL_0a11: ldloc.s V_4
IL_0a13: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Actor> TheForestOfLove.DB.DialogueAvailabilityRule::get_actors_required_offscreen_all()
IL_0a18: brfalse.s IL_0a63
IL_0a1a: ldloc.s V_4
IL_0a1c: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Actor> TheForestOfLove.DB.DialogueAvailabilityRule::get_actors_required_offscreen_all()
IL_0a21: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Actor>::GetEnumerator()
IL_0a26: stloc.s V_37
IL_0a28: br.s IL_0a4a
IL_0a2a: ldloca.s V_37
IL_0a2c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>::get_Current()
IL_0a31: stloc.s V_38
IL_0a33: ldloc.2
IL_0a34: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_0a39: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOffscreenAll
IL_0a3e: ldloc.s V_38
IL_0a40: callvirt System.String TheForestOfLove.DB.Actor::get_name()
IL_0a45: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0a4a: ldloca.s V_37
IL_0a4c: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>::MoveNext()
IL_0a51: brtrue.s IL_0a2a
IL_0a53: leave.s IL_0a63
IL_0a55: ldloca.s V_37
IL_0a57: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>
IL_0a5d: callvirt System.Void System.IDisposable::Dispose()
IL_0a62: endfinally
IL_0a63: ldloc.s V_4
IL_0a65: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Actor> TheForestOfLove.DB.DialogueAvailabilityRule::get_actors_required_offscreen_any()
IL_0a6a: brfalse.s IL_0ab5
IL_0a6c: ldloc.s V_4
IL_0a6e: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Actor> TheForestOfLove.DB.DialogueAvailabilityRule::get_actors_required_offscreen_any()
IL_0a73: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Actor>::GetEnumerator()
IL_0a78: stloc.s V_37
IL_0a7a: br.s IL_0a9c
IL_0a7c: ldloca.s V_37
IL_0a7e: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>::get_Current()
IL_0a83: stloc.s V_39
IL_0a85: ldloc.2
IL_0a86: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_0a8b: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOffscreenAny
IL_0a90: ldloc.s V_39
IL_0a92: callvirt System.String TheForestOfLove.DB.Actor::get_name()
IL_0a97: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0a9c: ldloca.s V_37
IL_0a9e: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>::MoveNext()
IL_0aa3: brtrue.s IL_0a7c
IL_0aa5: leave.s IL_0ab5
IL_0aa7: ldloca.s V_37
IL_0aa9: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>
IL_0aaf: callvirt System.Void System.IDisposable::Dispose()
IL_0ab4: endfinally
IL_0ab5: ldloc.s V_4
IL_0ab7: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Actor> TheForestOfLove.DB.DialogueAvailabilityRule::get_actors_required_onscreen_all()
IL_0abc: brfalse.s IL_0b07
IL_0abe: ldloc.s V_4
IL_0ac0: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Actor> TheForestOfLove.DB.DialogueAvailabilityRule::get_actors_required_onscreen_all()
IL_0ac5: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Actor>::GetEnumerator()
IL_0aca: stloc.s V_37
IL_0acc: br.s IL_0aee
IL_0ace: ldloca.s V_37
IL_0ad0: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>::get_Current()
IL_0ad5: stloc.s V_40
IL_0ad7: ldloc.2
IL_0ad8: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_0add: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOnscreenAll
IL_0ae2: ldloc.s V_40
IL_0ae4: callvirt System.String TheForestOfLove.DB.Actor::get_name()
IL_0ae9: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0aee: ldloca.s V_37
IL_0af0: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>::MoveNext()
IL_0af5: brtrue.s IL_0ace
IL_0af7: leave.s IL_0b07
IL_0af9: ldloca.s V_37
IL_0afb: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>
IL_0b01: callvirt System.Void System.IDisposable::Dispose()
IL_0b06: endfinally
IL_0b07: ldloc.s V_4
IL_0b09: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Actor> TheForestOfLove.DB.DialogueAvailabilityRule::get_actors_required_onscreen_any()
IL_0b0e: brfalse.s IL_0b59
IL_0b10: ldloc.s V_4
IL_0b12: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Actor> TheForestOfLove.DB.DialogueAvailabilityRule::get_actors_required_onscreen_any()
IL_0b17: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Actor>::GetEnumerator()
IL_0b1c: stloc.s V_37
IL_0b1e: br.s IL_0b40
IL_0b20: ldloca.s V_37
IL_0b22: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>::get_Current()
IL_0b27: stloc.s V_41
IL_0b29: ldloc.2
IL_0b2a: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_0b2f: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOnscreenAny
IL_0b34: ldloc.s V_41
IL_0b36: callvirt System.String TheForestOfLove.DB.Actor::get_name()
IL_0b3b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0b40: ldloca.s V_37
IL_0b42: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>::MoveNext()
IL_0b47: brtrue.s IL_0b20
IL_0b49: leave.s IL_0b59
IL_0b4b: ldloca.s V_37
IL_0b4d: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>
IL_0b53: callvirt System.Void System.IDisposable::Dispose()
IL_0b58: endfinally
IL_0b59: ldloca.s V_3
IL_0b5b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueAvailabilityRule>::MoveNext()
IL_0b60: brtrue IL_0051
IL_0b65: leave.s IL_0b8b
IL_0b67: ldloca.s V_3
IL_0b69: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueAvailabilityRule>
IL_0b6f: callvirt System.Void System.IDisposable::Dispose()
IL_0b74: endfinally
IL_0b75: ldstr "for now, all dialogues must have a corresponding availability rule "
IL_0b7a: ldloc.1
IL_0b7b: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0b80: call System.String System.String::Concat(System.String,System.String)
IL_0b85: newobj System.Void System.Exception::.ctor(System.String)
IL_0b8a: throw
IL_0b8b: ldloc.1
IL_0b8c: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0b91: ldc.i4 500
IL_0b96: bne.un.s IL_0bb4
IL_0b98: ldloc.1
IL_0b99: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition> TheForestOfLove.Narrative.Dialogue::preconditions
IL_0b9e: newobj System.Void TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionNoActorsOnDate::.ctor()
IL_0ba3: dup
IL_0ba4: ldloc.1
IL_0ba5: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_0baa: stfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionNoActorsOnDate::targetActorDbName
IL_0baf: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::Add(!0)
IL_0bb4: ldloc.1
IL_0bb5: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0bba: ldc.i4 300
IL_0bbf: bne.un.s IL_0bd8
IL_0bc1: ldloc.1
IL_0bc2: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition> TheForestOfLove.Narrative.Dialogue::preconditions
IL_0bc7: newobj System.Void TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireUnplayedPrimaryArcOrAnyIdleArc::.ctor()
IL_0bcc: dup
IL_0bcd: ldloc.1
IL_0bce: stfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionRequireUnplayedPrimaryArcOrAnyIdleArc::dialogue
IL_0bd3: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::Add(!0)
IL_0bd8: ldloc.1
IL_0bd9: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0bde: ldc.i4 200
IL_0be3: bne.un IL_0ca9
IL_0be8: ldloc.1
IL_0be9: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0bee: brfalse IL_0ca9
IL_0bf3: ldc.i4.0
IL_0bf4: stloc.s V_42
IL_0bf6: ldloc.2
IL_0bf7: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::dialoguesAny
IL_0bfc: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues::dialogues
IL_0c01: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0c06: stloc.s V_43
IL_0c08: br.s IL_0c23
IL_0c0a: ldloca.s V_43
IL_0c0c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0c11: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0c16: ldloc.1
IL_0c17: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0c1c: bne.un.s IL_0c23
IL_0c1e: ldc.i4.1
IL_0c1f: stloc.s V_42
IL_0c21: leave.s IL_0c3c
IL_0c23: ldloca.s V_43
IL_0c25: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0c2a: brtrue.s IL_0c0a
IL_0c2c: leave.s IL_0c3c
IL_0c2e: ldloca.s V_43
IL_0c30: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0c36: callvirt System.Void System.IDisposable::Dispose()
IL_0c3b: endfinally
IL_0c3c: ldloc.2
IL_0c3d: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::dialoguesAll
IL_0c42: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues::dialogues
IL_0c47: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0c4c: stloc.s V_43
IL_0c4e: br.s IL_0c69
IL_0c50: ldloca.s V_43
IL_0c52: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0c57: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0c5c: ldloc.1
IL_0c5d: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0c62: bne.un.s IL_0c69
IL_0c64: ldc.i4.1
IL_0c65: stloc.s V_42
IL_0c67: leave.s IL_0c82
IL_0c69: ldloca.s V_43
IL_0c6b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0c70: brtrue.s IL_0c50
IL_0c72: leave.s IL_0c82
IL_0c74: ldloca.s V_43
IL_0c76: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0c7c: callvirt System.Void System.IDisposable::Dispose()
IL_0c81: endfinally
IL_0c82: ldloc.s V_42
IL_0c84: brtrue.s IL_0ca9
IL_0c86: ldloc.1
IL_0c87: ldc.i4.1
IL_0c88: stfld System.Boolean TheForestOfLove.Narrative.Dialogue::isFirstDialogueInQuest
IL_0c8d: ldloc.1
IL_0c8e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger> TheForestOfLove.Narrative.Dialogue::dialogueTriggers
IL_0c93: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerStartQuest::.ctor()
IL_0c98: dup
IL_0c99: ldloc.1
IL_0c9a: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0c9f: stfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerStartQuest::targetQuest
IL_0ca4: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_0ca9: ldloc.1
IL_0caa: ldfld TheForestOfLove.DB.Dialogue TheForestOfLove.Narrative.Dialogue::dbDialogue
IL_0caf: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueStateTrigger> TheForestOfLove.DB.Dialogue::get_RelatedDialogueStateTriggerListUsingdialogue_filterRelation()
IL_0cb4: brfalse.s IL_0cd4
IL_0cb6: ldarg.0
IL_0cb7: ldarg.1
IL_0cb8: ldloc.1
IL_0cb9: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0cbe: ldloc.1
IL_0cbf: ldfld TheForestOfLove.DB.Dialogue TheForestOfLove.Narrative.Dialogue::dbDialogue
IL_0cc4: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueStateTrigger> TheForestOfLove.DB.Dialogue::get_RelatedDialogueStateTriggerListUsingdialogue_filterRelation()
IL_0cc9: ldloc.1
IL_0cca: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger> TheForestOfLove.Narrative.Dialogue::dialogueTriggers
IL_0ccf: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddDialogueStateTrigger(TheForestOfLove.Narrative.DataManifest,System.String,System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueStateTrigger>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>)
IL_0cd4: ldloca.s V_0
IL_0cd6: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0cdb: brtrue IL_0011
IL_0ce0: leave.s IL_0cf0
IL_0ce2: ldloca.s V_0
IL_0ce4: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0cea: callvirt System.Void System.IDisposable::Dispose()
IL_0cef: endfinally
IL_0cf0: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddDialoguePreconditionsOnscreenOffscreenWatchInferredTriggers(TheForestOfLove.Narrative.DataManifest) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialogues
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br IL_012e
IL_0011: ldloca.s V_0
IL_0013: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0018: stloc.1
IL_0019: ldloc.1
IL_001a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition> TheForestOfLove.Narrative.Dialogue::preconditions
IL_001f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::GetEnumerator()
IL_0024: stloc.2
IL_0025: br IL_0112
IL_002a: ldloca.s V_2
IL_002c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::get_Current()
IL_0031: stloc.3
IL_0032: ldloc.3
IL_0033: callvirt System.Type System.Object::GetType()
IL_0038: ldtoken TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule
IL_003d: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0042: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_0047: brfalse IL_0112
IL_004c: ldloc.3
IL_004d: castclass TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule
IL_0052: stloc.s V_4
IL_0054: ldloc.s V_4
IL_0056: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_005b: ldfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::offscreenTriggerName
IL_0060: brtrue.s IL_00b3
IL_0062: ldloc.s V_4
IL_0064: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_0069: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOffscreenAll
IL_006e: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0073: ldc.i4.0
IL_0074: bgt.s IL_008a
IL_0076: ldloc.s V_4
IL_0078: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_007d: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOffscreenAny
IL_0082: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0087: ldc.i4.0
IL_0088: ble.s IL_00b3
IL_008a: ldloc.1
IL_008b: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0090: ldstr "_WaitForActorsOffscreen"
IL_0095: call System.String System.String::Concat(System.String,System.String)
IL_009a: stloc.s V_5
IL_009c: ldarg.0
IL_009d: ldloc.1
IL_009e: ldloc.s V_5
IL_00a0: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues(TheForestOfLove.Narrative.Dialogue,System.String)
IL_00a5: ldloc.s V_4
IL_00a7: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_00ac: ldloc.s V_5
IL_00ae: stfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::offscreenTriggerName
IL_00b3: ldloc.s V_4
IL_00b5: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_00ba: ldfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::onscreenTriggerName
IL_00bf: brtrue.s IL_0112
IL_00c1: ldloc.s V_4
IL_00c3: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_00c8: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOnscreenAll
IL_00cd: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_00d2: ldc.i4.0
IL_00d3: bgt.s IL_00e9
IL_00d5: ldloc.s V_4
IL_00d7: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_00dc: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOnscreenAny
IL_00e1: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_00e6: ldc.i4.0
IL_00e7: ble.s IL_0112
IL_00e9: ldloc.1
IL_00ea: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00ef: ldstr "_WaitForActorsOnscreen"
IL_00f4: call System.String System.String::Concat(System.String,System.String)
IL_00f9: stloc.s V_6
IL_00fb: ldarg.0
IL_00fc: ldloc.1
IL_00fd: ldloc.s V_6
IL_00ff: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues(TheForestOfLove.Narrative.Dialogue,System.String)
IL_0104: ldloc.s V_4
IL_0106: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::actorsOnscreenOffscreen
IL_010b: ldloc.s V_6
IL_010d: stfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::onscreenTriggerName
IL_0112: ldloca.s V_2
IL_0114: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::MoveNext()
IL_0119: brtrue IL_002a
IL_011e: leave.s IL_012e
IL_0120: ldloca.s V_2
IL_0122: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>
IL_0128: callvirt System.Void System.IDisposable::Dispose()
IL_012d: endfinally
IL_012e: ldloca.s V_0
IL_0130: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0135: brtrue IL_0011
IL_013a: leave.s IL_014a
IL_013c: ldloca.s V_0
IL_013e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0144: callvirt System.Void System.IDisposable::Dispose()
IL_0149: endfinally
IL_014a: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues(TheForestOfLove.Narrative.Dialogue,System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_0005: stloc.0
IL_0006: ldarg.1
IL_0007: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition> TheForestOfLove.Narrative.Dialogue::preconditions
IL_000c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::GetEnumerator()
IL_0011: stloc.1
IL_0012: br.s IL_007d
IL_0014: ldloca.s V_1
IL_0016: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::get_Current()
IL_001b: stloc.2
IL_001c: ldloc.2
IL_001d: callvirt System.Type System.Object::GetType()
IL_0022: ldtoken TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues
IL_0027: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_002c: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_0031: brfalse.s IL_0042
IL_0033: ldloc.2
IL_0034: castclass TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues
IL_0039: stloc.3
IL_003a: ldarg.0
IL_003b: ldloc.3
IL_003c: ldloc.0
IL_003d: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues_ExtractPrecedingDialogues(TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>)
IL_0042: ldloc.2
IL_0043: callvirt System.Type System.Object::GetType()
IL_0048: ldtoken TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule
IL_004d: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0052: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_0057: brfalse.s IL_007d
IL_0059: ldloc.2
IL_005a: castclass TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule
IL_005f: stloc.s V_4
IL_0061: ldarg.0
IL_0062: ldloc.s V_4
IL_0064: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::dialoguesAny
IL_0069: ldloc.0
IL_006a: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues_ExtractPrecedingDialogues(TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>)
IL_006f: ldarg.0
IL_0070: ldloc.s V_4
IL_0072: ldfld TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionFullAvailabilityRule::dialoguesAll
IL_0077: ldloc.0
IL_0078: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues_ExtractPrecedingDialogues(TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>)
IL_007d: ldloca.s V_1
IL_007f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::MoveNext()
IL_0084: brtrue.s IL_0014
IL_0086: leave.s IL_0096
IL_0088: ldloca.s V_1
IL_008a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>
IL_0090: callvirt System.Void System.IDisposable::Dispose()
IL_0095: endfinally
IL_0096: ldloc.0
IL_0097: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::get_Count()
IL_009c: brtrue.s IL_00b4
IL_009e: ldstr "unable to add inferred event trigger for onscreen offscreen precondition since no dialogues precede the target "
IL_00a3: ldarg.1
IL_00a4: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00a9: call System.String System.String::Concat(System.String,System.String)
IL_00ae: newobj System.Void System.Exception::.ctor(System.String)
IL_00b3: throw
IL_00b4: ldloc.0
IL_00b5: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_00ba: stloc.s V_5
IL_00bc: br IL_0187
IL_00c1: ldloca.s V_5
IL_00c3: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_00c8: stloc.s V_6
IL_00ca: ldnull
IL_00cb: stloc.s V_7
IL_00cd: ldloc.s V_6
IL_00cf: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_00d4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::GetEnumerator()
IL_00d9: stloc.s V_8
IL_00db: br.s IL_0109
IL_00dd: ldloca.s V_8
IL_00df: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::get_Current()
IL_00e4: stloc.s V_9
IL_00e6: ldloc.s V_9
IL_00e8: callvirt System.Type System.Object::GetType()
IL_00ed: ldtoken TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFinishDialogue
IL_00f2: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_00f7: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_00fc: brfalse.s IL_0109
IL_00fe: ldloc.s V_9
IL_0100: castclass TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFinishDialogue
IL_0105: stloc.s V_7
IL_0107: leave.s IL_0122
IL_0109: ldloca.s V_8
IL_010b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::MoveNext()
IL_0110: brtrue.s IL_00dd
IL_0112: leave.s IL_0122
IL_0114: ldloca.s V_8
IL_0116: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>
IL_011c: callvirt System.Void System.IDisposable::Dispose()
IL_0121: endfinally
IL_0122: ldloc.s V_7
IL_0124: brfalse.s IL_0171
IL_0126: ldloc.s V_6
IL_0128: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_012d: ldloc.s V_7
IL_012f: callvirt System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::GetConversationId()
IL_0134: ldloc.s V_7
IL_0136: callvirt System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::GetDialogueEntryId()
IL_013b: ldarg.2
IL_013c: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::.ctor(System.Int32,System.Int32,System.String)
IL_0141: dup
IL_0142: ldloc.s V_7
IL_0144: ldfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_0149: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_014e: dup
IL_014f: ldloc.s V_7
IL_0151: ldfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::allowNullArc
IL_0156: stfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::allowNullArc
IL_015b: dup
IL_015c: ldloc.s V_7
IL_015e: ldfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_0163: ldc.i4.1
IL_0164: add
IL_0165: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_016a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_016f: br.s IL_0187
IL_0171: ldstr "unable to add inferred event trigger for onscreen offscreen precondition since a precededing dialogue is missing a completion trigger "
IL_0176: ldarg.1
IL_0177: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_017c: call System.String System.String::Concat(System.String,System.String)
IL_0181: newobj System.Void System.Exception::.ctor(System.String)
IL_0186: throw
IL_0187: ldloca.s V_5
IL_0189: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_018e: brtrue IL_00c1
IL_0193: leave.s IL_01a3
IL_0195: ldloca.s V_5
IL_0197: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_019d: callvirt System.Void System.IDisposable::Dispose()
IL_01a2: endfinally
IL_01a3: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddDialogueStateTrigger(TheForestOfLove.Narrative.DataManifest,System.String,System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueStateTrigger>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.3
IL_0001: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueStateTrigger>::GetEnumerator()
IL_0006: stloc.0
IL_0007: br IL_048c
IL_000c: ldloca.s V_0
IL_000e: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueStateTrigger>::get_Current()
IL_0013: stloc.1
IL_0014: ldloc.1
IL_0015: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueStateTrigger::get_complete_dialogues()
IL_001a: brfalse.s IL_0074
IL_001c: ldloc.1
IL_001d: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueStateTrigger::get_complete_dialogues()
IL_0022: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue>::GetEnumerator()
IL_0027: stloc.2
IL_0028: br.s IL_005b
IL_002a: ldloca.s V_2
IL_002c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::get_Current()
IL_0031: stloc.3
IL_0032: ldarg.s triggers
IL_0034: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerSetDialogueStatus::.ctor()
IL_0039: dup
IL_003a: ldarg.1
IL_003b: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbDialogue
IL_0040: ldloc.3
IL_0041: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_0046: stfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerSetDialogueStatus::targetDialogue
IL_004b: dup
IL_004c: ldc.i4 200
IL_0051: stfld TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerSetDialogueStatus::targetStatus
IL_0056: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_005b: ldloca.s V_2
IL_005d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::MoveNext()
IL_0062: brtrue.s IL_002a
IL_0064: leave.s IL_0074
IL_0066: ldloca.s V_2
IL_0068: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>
IL_006e: callvirt System.Void System.IDisposable::Dispose()
IL_0073: endfinally
IL_0074: ldloc.1
IL_0075: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueStateTrigger::get_invalidate_dialogues()
IL_007a: brfalse.s IL_00d6
IL_007c: ldloc.1
IL_007d: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueStateTrigger::get_invalidate_dialogues()
IL_0082: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue>::GetEnumerator()
IL_0087: stloc.2
IL_0088: br.s IL_00bd
IL_008a: ldloca.s V_2
IL_008c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::get_Current()
IL_0091: stloc.s V_4
IL_0093: ldarg.s triggers
IL_0095: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerSetDialogueStatus::.ctor()
IL_009a: dup
IL_009b: ldarg.1
IL_009c: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbDialogue
IL_00a1: ldloc.s V_4
IL_00a3: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_00a8: stfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerSetDialogueStatus::targetDialogue
IL_00ad: dup
IL_00ae: ldc.i4 300
IL_00b3: stfld TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerSetDialogueStatus::targetStatus
IL_00b8: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_00bd: ldloca.s V_2
IL_00bf: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::MoveNext()
IL_00c4: brtrue.s IL_008a
IL_00c6: leave.s IL_00d6
IL_00c8: ldloca.s V_2
IL_00ca: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>
IL_00d0: callvirt System.Void System.IDisposable::Dispose()
IL_00d5: endfinally
IL_00d6: ldloc.1
IL_00d7: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueStateTrigger::get_clear_dialogue_idles()
IL_00dc: brfalse.s IL_012d
IL_00de: ldloc.1
IL_00df: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.DialogueStateTrigger::get_clear_dialogue_idles()
IL_00e4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Dialogue>::GetEnumerator()
IL_00e9: stloc.2
IL_00ea: br.s IL_0114
IL_00ec: ldloca.s V_2
IL_00ee: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::get_Current()
IL_00f3: stloc.s V_5
IL_00f5: ldarg.s triggers
IL_00f7: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerClearIdles::.ctor()
IL_00fc: dup
IL_00fd: ldarg.1
IL_00fe: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbDialogue
IL_0103: ldloc.s V_5
IL_0105: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_010a: stfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerClearIdles::targetDialogue
IL_010f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_0114: ldloca.s V_2
IL_0116: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>::MoveNext()
IL_011b: brtrue.s IL_00ec
IL_011d: leave.s IL_012d
IL_011f: ldloca.s V_2
IL_0121: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Dialogue>
IL_0127: callvirt System.Void System.IDisposable::Dispose()
IL_012c: endfinally
IL_012d: ldloc.1
IL_012e: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.QuestProgressLogText> TheForestOfLove.DB.DialogueStateTrigger::get_quest_progress_logs()
IL_0133: brfalse.s IL_0185
IL_0135: ldloc.1
IL_0136: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.QuestProgressLogText> TheForestOfLove.DB.DialogueStateTrigger::get_quest_progress_logs()
IL_013b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.QuestProgressLogText>::GetEnumerator()
IL_0140: stloc.s V_6
IL_0142: br.s IL_016c
IL_0144: ldloca.s V_6
IL_0146: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.QuestProgressLogText>::get_Current()
IL_014b: stloc.s V_7
IL_014d: ldarg.s triggers
IL_014f: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerLogNewlyEnteredStep::.ctor()
IL_0154: dup
IL_0155: ldarg.1
IL_0156: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.QuestProgressLogText,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntriesByDbLog
IL_015b: ldloc.s V_7
IL_015d: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.QuestProgressLogText,TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Item(!0)
IL_0162: stfld TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerLogNewlyEnteredStep::logEntry
IL_0167: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_016c: ldloca.s V_6
IL_016e: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.QuestProgressLogText>::MoveNext()
IL_0173: brtrue.s IL_0144
IL_0175: leave.s IL_0185
IL_0177: ldloca.s V_6
IL_0179: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.QuestProgressLogText>
IL_017f: callvirt System.Void System.IDisposable::Dispose()
IL_0184: endfinally
IL_0185: ldloc.1
IL_0186: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueStateTrigger::get_start_quests()
IL_018b: brfalse.s IL_01e1
IL_018d: ldloc.1
IL_018e: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueStateTrigger::get_start_quests()
IL_0193: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Quest>::GetEnumerator()
IL_0198: stloc.s V_8
IL_019a: br.s IL_01c8
IL_019c: ldloca.s V_8
IL_019e: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::get_Current()
IL_01a3: stloc.s V_9
IL_01a5: ldarg.1
IL_01a6: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbQuest
IL_01ab: ldloc.s V_9
IL_01ad: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_01b2: stloc.s V_10
IL_01b4: ldarg.s triggers
IL_01b6: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerStartQuest::.ctor()
IL_01bb: dup
IL_01bc: ldloc.s V_10
IL_01be: stfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerStartQuest::targetQuest
IL_01c3: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_01c8: ldloca.s V_8
IL_01ca: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::MoveNext()
IL_01cf: brtrue.s IL_019c
IL_01d1: leave.s IL_01e1
IL_01d3: ldloca.s V_8
IL_01d5: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>
IL_01db: callvirt System.Void System.IDisposable::Dispose()
IL_01e0: endfinally
IL_01e1: ldloc.1
IL_01e2: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueStateTrigger::get_complete_quests()
IL_01e7: brfalse IL_0294
IL_01ec: ldloc.1
IL_01ed: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Quest> TheForestOfLove.DB.DialogueStateTrigger::get_complete_quests()
IL_01f2: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Quest>::GetEnumerator()
IL_01f7: stloc.s V_8
IL_01f9: br.s IL_0278
IL_01fb: ldloca.s V_8
IL_01fd: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::get_Current()
IL_0202: stloc.s V_11
IL_0204: ldarg.1
IL_0205: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbQuest
IL_020a: ldloc.s V_11
IL_020c: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_0211: stloc.s V_12
IL_0213: ldarg.s triggers
IL_0215: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerCompleteQuest::.ctor()
IL_021a: dup
IL_021b: ldloc.s V_12
IL_021d: stfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerCompleteQuest::targetQuest
IL_0222: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_0227: ldloc.s V_12
IL_0229: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.Quest::dialogues
IL_022e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0233: stloc.s V_13
IL_0235: br.s IL_025f
IL_0237: ldloca.s V_13
IL_0239: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_023e: stloc.s V_14
IL_0240: ldloc.1
IL_0241: callvirt TheForestOfLove.DB.Dialogue TheForestOfLove.DB.DialogueStateTrigger::get_dialogue_filter()
IL_0246: brfalse.s IL_025f
IL_0248: ldloc.s V_14
IL_024a: ldfld TheForestOfLove.DB.Dialogue TheForestOfLove.Narrative.Dialogue::dbDialogue
IL_024f: ldloc.1
IL_0250: callvirt TheForestOfLove.DB.Dialogue TheForestOfLove.DB.DialogueStateTrigger::get_dialogue_filter()
IL_0255: bne.un.s IL_025f
IL_0257: ldloc.s V_14
IL_0259: ldc.i4.1
IL_025a: stfld System.Boolean TheForestOfLove.Narrative.Dialogue::isLastDialogueInQuest
IL_025f: ldloca.s V_13
IL_0261: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0266: brtrue.s IL_0237
IL_0268: leave.s IL_0278
IL_026a: ldloca.s V_13
IL_026c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0272: callvirt System.Void System.IDisposable::Dispose()
IL_0277: endfinally
IL_0278: ldloca.s V_8
IL_027a: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>::MoveNext()
IL_027f: brtrue IL_01fb
IL_0284: leave.s IL_0294
IL_0286: ldloca.s V_8
IL_0288: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Quest>
IL_028e: callvirt System.Void System.IDisposable::Dispose()
IL_0293: endfinally
IL_0294: ldloc.1
IL_0295: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueStateTrigger::get_add_tags()
IL_029a: brtrue.s IL_02a7
IL_029c: ldloc.1
IL_029d: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueStateTrigger::get_remove_tags()
IL_02a2: brfalse IL_035b
IL_02a7: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerSetTags::.ctor()
IL_02ac: stloc.s V_15
IL_02ae: ldloc.1
IL_02af: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueStateTrigger::get_add_tags()
IL_02b4: brfalse.s IL_0300
IL_02b6: ldloc.1
IL_02b7: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueStateTrigger::get_add_tags()
IL_02bc: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_02c1: stloc.s V_16
IL_02c3: br.s IL_02e7
IL_02c5: ldloca.s V_16
IL_02c7: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_02cc: stloc.s V_17
IL_02ce: ldloc.s V_15
IL_02d0: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerSetTags::tagsToAdd
IL_02d5: ldarg.1
IL_02d6: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_02db: ldloc.s V_17
IL_02dd: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_02e2: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_02e7: ldloca.s V_16
IL_02e9: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_02ee: brtrue.s IL_02c5
IL_02f0: leave.s IL_0300
IL_02f2: ldloca.s V_16
IL_02f4: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_02fa: callvirt System.Void System.IDisposable::Dispose()
IL_02ff: endfinally
IL_0300: ldloc.1
IL_0301: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueStateTrigger::get_remove_tags()
IL_0306: brfalse.s IL_0352
IL_0308: ldloc.1
IL_0309: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.DialogueStateTrigger::get_remove_tags()
IL_030e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_0313: stloc.s V_16
IL_0315: br.s IL_0339
IL_0317: ldloca.s V_16
IL_0319: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_031e: stloc.s V_18
IL_0320: ldloc.s V_15
IL_0322: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerSetTags::tagsToRemove
IL_0327: ldarg.1
IL_0328: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_032d: ldloc.s V_18
IL_032f: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_0334: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0339: ldloca.s V_16
IL_033b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_0340: brtrue.s IL_0317
IL_0342: leave.s IL_0352
IL_0344: ldloca.s V_16
IL_0346: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_034c: callvirt System.Void System.IDisposable::Dispose()
IL_0351: endfinally
IL_0352: ldarg.s triggers
IL_0354: ldloc.s V_15
IL_0356: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_035b: ldloc.1
IL_035c: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueStateTrigger::get_manage_items()
IL_0361: brfalse IL_043a
IL_0366: ldloc.1
IL_0367: callvirt System.Collections.Generic.List`1<System.Int32> TheForestOfLove.DB.DialogueStateTrigger::get_item_quantities_parallel()
IL_036c: brfalse.s IL_0386
IL_036e: ldloc.1
IL_036f: callvirt System.Collections.Generic.List`1<System.Int32> TheForestOfLove.DB.DialogueStateTrigger::get_item_quantities_parallel()
IL_0374: callvirt System.Int32 System.Collections.Generic.List`1<System.Int32>::get_Count()
IL_0379: ldloc.1
IL_037a: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueStateTrigger::get_manage_items()
IL_037f: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem>::get_Count()
IL_0384: beq.s IL_0397
IL_0386: ldstr "manage items list length must match exact item quantities parallel list length "
IL_038b: ldarg.2
IL_038c: call System.String System.String::Concat(System.String,System.String)
IL_0391: newobj System.Void System.Exception::.ctor(System.String)
IL_0396: throw
IL_0397: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::.ctor()
IL_039c: stloc.s V_19
IL_039e: ldc.i4.0
IL_039f: stloc.s V_20
IL_03a1: br.s IL_041f
IL_03a3: ldloc.1
IL_03a4: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueStateTrigger::get_manage_items()
IL_03a9: ldloc.s V_20
IL_03ab: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem>::get_Item(System.Int32)
IL_03b0: callvirt TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.DB.InventoryItem::get_item_type()
IL_03b5: stloc.s V_21
IL_03b7: ldloc.1
IL_03b8: callvirt System.Collections.Generic.List`1<System.Int32> TheForestOfLove.DB.DialogueStateTrigger::get_item_quantities_parallel()
IL_03bd: ldloc.s V_20
IL_03bf: callvirt !0 System.Collections.Generic.List`1<System.Int32>::get_Item(System.Int32)
IL_03c4: stloc.s V_22
IL_03c6: ldloc.s V_22
IL_03c8: ldc.i4.0
IL_03c9: bge.s IL_03e9
IL_03cb: ldloc.s V_19
IL_03cd: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToRemove
IL_03d2: ldloc.s V_21
IL_03d4: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_03d9: ldloc.s V_19
IL_03db: ldfld System.Collections.Generic.List`1<System.Int32> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToRemoveQuantity
IL_03e0: ldloc.s V_22
IL_03e2: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Add(!0)
IL_03e7: br.s IL_0419
IL_03e9: ldloc.s V_22
IL_03eb: brtrue.s IL_03fd
IL_03ed: ldloc.s V_19
IL_03ef: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToConsume
IL_03f4: ldloc.s V_21
IL_03f6: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_03fb: br.s IL_0419
IL_03fd: ldloc.s V_19
IL_03ff: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToAdd
IL_0404: ldloc.s V_21
IL_0406: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::Add(!0)
IL_040b: ldloc.s V_19
IL_040d: ldfld System.Collections.Generic.List`1<System.Int32> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToAddQuantity
IL_0412: ldloc.s V_22
IL_0414: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Add(!0)
IL_0419: ldloc.s V_20
IL_041b: ldc.i4.1
IL_041c: add
IL_041d: stloc.s V_20
IL_041f: ldloc.s V_20
IL_0421: ldloc.1
IL_0422: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem> TheForestOfLove.DB.DialogueStateTrigger::get_manage_items()
IL_0427: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DB.InventoryItem>::get_Count()
IL_042c: blt IL_03a3
IL_0431: ldarg.s triggers
IL_0433: ldloc.s V_19
IL_0435: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_043a: ldloc.1
IL_043b: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Chapter> TheForestOfLove.DB.DialogueStateTrigger::get_unlock_chapters()
IL_0440: brfalse.s IL_048c
IL_0442: ldloc.1
IL_0443: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Chapter> TheForestOfLove.DB.DialogueStateTrigger::get_unlock_chapters()
IL_0448: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Chapter>::GetEnumerator()
IL_044d: stloc.s V_23
IL_044f: br.s IL_0473
IL_0451: ldloca.s V_23
IL_0453: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Chapter>::get_Current()
IL_0458: stloc.s V_24
IL_045a: ldarg.s triggers
IL_045c: newobj System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerUnlockChapter::.ctor()
IL_0461: dup
IL_0462: ldloc.s V_24
IL_0464: callvirt TheForestOfLove.Narrative.Chapter TheForestOfLove.DB.Chapter::get_chapter()
IL_0469: stfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerUnlockChapter::targetChapterUnlock
IL_046e: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::Add(!0)
IL_0473: ldloca.s V_23
IL_0475: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Chapter>::MoveNext()
IL_047a: brtrue.s IL_0451
IL_047c: leave.s IL_048c
IL_047e: ldloca.s V_23
IL_0480: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Chapter>
IL_0486: callvirt System.Void System.IDisposable::Dispose()
IL_048b: endfinally
IL_048c: ldloca.s V_0
IL_048e: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueStateTrigger>::MoveNext()
IL_0493: brtrue IL_000c
IL_0498: leave.s IL_04a8
IL_049a: ldloca.s V_0
IL_049c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueStateTrigger>
IL_04a2: callvirt System.Void System.IDisposable::Dispose()
IL_04a7: endfinally
IL_04a8: ret
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
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredDialogueFinishTrigger(TheForestOfLove.Narrative.Dialogue,System.Collections.Generic.IEnumerable`1<PixelCrushers.DialogueSystem.DialogueEntry>) | attributes=Private, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: ldarg.2
IL_0003: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<PixelCrushers.DialogueSystem.DialogueEntry>::GetEnumerator()
IL_0008: stloc.2
IL_0009: br.s IL_003a
IL_000b: ldloc.2
IL_000c: callvirt !0 System.Collections.Generic.IEnumerator`1<PixelCrushers.DialogueSystem.DialogueEntry>::get_Current()
IL_0011: stloc.3
IL_0012: ldloc.3
IL_0013: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0018: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_001d: brtrue.s IL_003a
IL_001f: ldloc.0
IL_0020: brfalse.s IL_0038
IL_0022: ldstr "ambiguous dialogue completion trigger "
IL_0027: ldarg.1
IL_0028: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_002d: call System.String System.String::Concat(System.String,System.String)
IL_0032: newobj System.Void System.Exception::.ctor(System.String)
IL_0037: throw
IL_0038: ldloc.3
IL_0039: stloc.0
IL_003a: ldloc.2
IL_003b: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0040: brtrue.s IL_000b
IL_0042: leave.s IL_004e
IL_0044: ldloc.2
IL_0045: brfalse.s IL_004d
IL_0047: ldloc.2
IL_0048: callvirt System.Void System.IDisposable::Dispose()
IL_004d: endfinally
IL_004e: ldloc.0
IL_004f: stloc.1
IL_0050: ldarg.1
IL_0051: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0056: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_005b: stloc.s V_4
IL_005d: br.s IL_00b7
IL_005f: ldloca.s V_4
IL_0061: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0066: stloc.s V_5
IL_0068: ldloc.s V_5
IL_006a: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_006f: ldloc.1
IL_0070: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0075: brfalse.s IL_00b7
IL_0077: ldarg.1
IL_0078: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_007d: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0082: ldloc.1
IL_0083: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0088: ldarg.1
IL_0089: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFinishDialogue::.ctor(System.Int32,System.Int32,TheForestOfLove.Narrative.Dialogue)
IL_008e: stloc.s V_6
IL_0090: ldarg.1
IL_0091: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_0096: ldloc.s V_6
IL_0098: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_009d: ldloc.s V_6
IL_009f: ldloc.s V_5
IL_00a1: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_00a6: ldloc.s V_6
IL_00a8: ldarg.0
IL_00a9: ldloc.s V_5
IL_00ab: ldloc.1
IL_00ac: ldc.i4.0
IL_00ad: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_00b2: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_00b7: ldloca.s V_4
IL_00b9: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_00be: brtrue.s IL_005f
IL_00c0: leave.s IL_00d0
IL_00c2: ldloca.s V_4
IL_00c4: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_00ca: callvirt System.Void System.IDisposable::Dispose()
IL_00cf: endfinally
IL_00d0: ret
METHOD System.String TheForestOfLove.Narrative.DialogueSystemLoader::ConvertToPascalCase(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0005
IL_0003: ldarg.1
IL_0004: ret
IL_0005: ldarg.1
IL_0006: callvirt System.Int32 System.String::get_Length()
IL_000b: ldc.i4.2
IL_000c: bge.s IL_0015
IL_000e: ldarg.1
IL_000f: callvirt System.String System.String::ToUpper()
IL_0014: ret
IL_0015: ldarg.1
IL_0016: ldc.i4.1
IL_0017: newarr System.Char
IL_001c: dup
IL_001d: ldc.i4.0
IL_001e: ldc.i4.s 95
IL_0020: stelem.i2
IL_0021: ldc.i4.1
IL_0022: callvirt System.String[] System.String::Split(System.Char[],System.StringSplitOptions)
IL_0027: ldstr ""
IL_002c: stloc.0
IL_002d: stloc.1
IL_002e: ldc.i4.0
IL_002f: stloc.2
IL_0030: br.s IL_0055
IL_0032: ldloc.1
IL_0033: ldloc.2
IL_0034: ldelem.ref
IL_0035: stloc.3
IL_0036: ldloc.0
IL_0037: ldloc.3
IL_0038: ldc.i4.0
IL_0039: ldc.i4.1
IL_003a: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_003f: callvirt System.String System.String::ToUpper()
IL_0044: ldloc.3
IL_0045: ldc.i4.1
IL_0046: callvirt System.String System.String::Substring(System.Int32)
IL_004b: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0050: stloc.0
IL_0051: ldloc.2
IL_0052: ldc.i4.1
IL_0053: add
IL_0054: stloc.2
IL_0055: ldloc.2
IL_0056: ldloc.1
IL_0057: ldlen
IL_0058: conv.i4
IL_0059: blt.s IL_0032
IL_005b: ldloc.0
IL_005c: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationLeftAlignPortraitsTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0006: ldarg.3
IL_0007: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_000c: ldc.i4.0
IL_000d: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0012: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0017: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_001c: stloc.0
IL_001d: ldarg.2
IL_001e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0023: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0028: stloc.1
IL_0029: br IL_0112
IL_002e: ldloca.s V_1
IL_0030: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0035: stloc.2
IL_0036: ldloc.2
IL_0037: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0042: brfalse IL_0112
IL_0047: ldarg.3
IL_0048: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_004d: ldarg.3
IL_004e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0053: ldstr "("
IL_0058: callvirt System.Int32 System.String::IndexOf(System.String)
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: ldarg.3
IL_0060: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0065: callvirt System.Int32 System.String::get_Length()
IL_006a: ldarg.3
IL_006b: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0070: ldstr "("
IL_0075: callvirt System.Int32 System.String::IndexOf(System.String)
IL_007a: sub
IL_007b: ldc.i4.2
IL_007c: sub
IL_007d: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0082: stloc.3
IL_0083: ldloc.3
IL_0084: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0089: brfalse.s IL_0096
IL_008b: ldstr "unrecognized command!"
IL_0090: newobj System.Void System.Exception::.ctor(System.String)
IL_0095: throw
IL_0096: ldarg.1
IL_0097: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_009c: ldloc.3
IL_009d: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::ContainsKey(!0)
IL_00a2: brtrue.s IL_00c0
IL_00a4: ldstr "unrecognized actor! "
IL_00a9: ldarg.2
IL_00aa: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00af: ldstr " "
IL_00b4: ldloc.3
IL_00b5: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00ba: newobj System.Void System.Exception::.ctor(System.String)
IL_00bf: throw
IL_00c0: ldarg.1
IL_00c1: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_00c6: ldloc.3
IL_00c7: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_00cc: stloc.s V_4
IL_00ce: ldarg.2
IL_00cf: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00d4: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00d9: ldloc.0
IL_00da: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00df: ldloc.s V_4
IL_00e1: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00e6: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerLeftAlignPortraits::.ctor(System.Int32,System.Int32,System.String)
IL_00eb: stloc.s V_5
IL_00ed: ldarg.2
IL_00ee: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_00f3: ldloc.s V_5
IL_00f5: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_00fa: ldloc.s V_5
IL_00fc: ldloc.2
IL_00fd: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_0102: ldloc.s V_5
IL_0104: ldarg.0
IL_0105: ldloc.2
IL_0106: ldloc.0
IL_0107: ldc.i4.0
IL_0108: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_010d: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_0112: ldloca.s V_1
IL_0114: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0119: brtrue IL_002e
IL_011e: leave.s IL_012e
IL_0120: ldloca.s V_1
IL_0122: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0128: callvirt System.Void System.IDisposable::Dispose()
IL_012d: endfinally
IL_012e: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationRightAlignPortraitsTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0006: ldarg.3
IL_0007: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_000c: ldc.i4.0
IL_000d: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0012: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0017: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_001c: stloc.0
IL_001d: ldarg.2
IL_001e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0023: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0028: stloc.1
IL_0029: br IL_0112
IL_002e: ldloca.s V_1
IL_0030: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0035: stloc.2
IL_0036: ldloc.2
IL_0037: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0042: brfalse IL_0112
IL_0047: ldarg.3
IL_0048: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_004d: ldarg.3
IL_004e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0053: ldstr "("
IL_0058: callvirt System.Int32 System.String::IndexOf(System.String)
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: ldarg.3
IL_0060: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0065: callvirt System.Int32 System.String::get_Length()
IL_006a: ldarg.3
IL_006b: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0070: ldstr "("
IL_0075: callvirt System.Int32 System.String::IndexOf(System.String)
IL_007a: sub
IL_007b: ldc.i4.2
IL_007c: sub
IL_007d: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0082: stloc.3
IL_0083: ldloc.3
IL_0084: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0089: brfalse.s IL_0096
IL_008b: ldstr "unrecognized command!"
IL_0090: newobj System.Void System.Exception::.ctor(System.String)
IL_0095: throw
IL_0096: ldarg.1
IL_0097: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_009c: ldloc.3
IL_009d: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::ContainsKey(!0)
IL_00a2: brtrue.s IL_00c0
IL_00a4: ldstr "unrecognized actor! "
IL_00a9: ldarg.2
IL_00aa: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00af: ldstr " "
IL_00b4: ldloc.3
IL_00b5: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00ba: newobj System.Void System.Exception::.ctor(System.String)
IL_00bf: throw
IL_00c0: ldarg.1
IL_00c1: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_00c6: ldloc.3
IL_00c7: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_00cc: stloc.s V_4
IL_00ce: ldarg.2
IL_00cf: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00d4: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00d9: ldloc.0
IL_00da: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00df: ldloc.s V_4
IL_00e1: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00e6: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerRightAlignPortraits::.ctor(System.Int32,System.Int32,System.String)
IL_00eb: stloc.s V_5
IL_00ed: ldarg.2
IL_00ee: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_00f3: ldloc.s V_5
IL_00f5: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_00fa: ldloc.s V_5
IL_00fc: ldloc.2
IL_00fd: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_0102: ldloc.s V_5
IL_0104: ldarg.0
IL_0105: ldloc.2
IL_0106: ldloc.0
IL_0107: ldc.i4.0
IL_0108: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_010d: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_0112: ldloca.s V_1
IL_0114: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0119: brtrue IL_002e
IL_011e: leave.s IL_012e
IL_0120: ldloca.s V_1
IL_0122: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0128: callvirt System.Void System.IDisposable::Dispose()
IL_012d: endfinally
IL_012e: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationTriggerUnlockBioFragment(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0006: ldarg.3
IL_0007: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_000c: ldc.i4.0
IL_000d: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0012: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0017: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_001c: stloc.0
IL_001d: ldarg.2
IL_001e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0023: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0028: stloc.1
IL_0029: br IL_01be
IL_002e: ldloca.s V_1
IL_0030: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0035: stloc.2
IL_0036: ldloc.2
IL_0037: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0042: brfalse IL_01be
IL_0047: ldarg.3
IL_0048: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_004d: ldarg.3
IL_004e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0053: ldstr "("
IL_0058: callvirt System.Int32 System.String::IndexOf(System.String)
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: ldarg.3
IL_0060: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0065: callvirt System.Int32 System.String::get_Length()
IL_006a: ldarg.3
IL_006b: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0070: ldstr "("
IL_0075: callvirt System.Int32 System.String::IndexOf(System.String)
IL_007a: sub
IL_007b: ldc.i4.2
IL_007c: sub
IL_007d: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0082: ldc.i4.1
IL_0083: newarr System.Char
IL_0088: dup
IL_0089: ldc.i4.0
IL_008a: ldc.i4.s 44
IL_008c: stelem.i2
IL_008d: callvirt System.String[] System.String::Split(System.Char[])
IL_0092: stloc.3
IL_0093: ldloc.3
IL_0094: ldlen
IL_0095: conv.i4
IL_0096: ldc.i4.2
IL_0097: bne.un.s IL_00af
IL_0099: ldloc.3
IL_009a: ldc.i4.0
IL_009b: ldelem.ref
IL_009c: callvirt System.String System.String::Trim()
IL_00a1: stloc.s V_4
IL_00a3: ldloc.3
IL_00a4: ldc.i4.1
IL_00a5: ldelem.ref
IL_00a6: callvirt System.String System.String::Trim()
IL_00ab: stloc.s V_5
IL_00ad: br.s IL_00c6
IL_00af: ldarg.2
IL_00b0: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_00b5: ldfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_00ba: stloc.s V_4
IL_00bc: ldloc.3
IL_00bd: ldc.i4.0
IL_00be: ldelem.ref
IL_00bf: callvirt System.String System.String::Trim()
IL_00c4: stloc.s V_5
IL_00c6: ldloc.s V_4
IL_00c8: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_00cd: brfalse.s IL_00da
IL_00cf: ldstr "unrecognized bio fragment actor name!"
IL_00d4: newobj System.Void System.Exception::.ctor(System.String)
IL_00d9: throw
IL_00da: ldloc.s V_5
IL_00dc: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_00e1: brfalse.s IL_00ee
IL_00e3: ldstr "unrecognized bio fragment key!"
IL_00e8: newobj System.Void System.Exception::.ctor(System.String)
IL_00ed: throw
IL_00ee: ldarg.1
IL_00ef: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_00f4: ldloc.s V_4
IL_00f6: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::ContainsKey(!0)
IL_00fb: brtrue.s IL_011a
IL_00fd: ldstr "unrecognized actor! "
IL_0102: ldloc.s V_4
IL_0104: ldstr " "
IL_0109: ldarg.2
IL_010a: ldfld System.String TheForestOfLove.Narrative.Dialogue::pluginDbName
IL_010f: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0114: newobj System.Void System.Exception::.ctor(System.String)
IL_0119: throw
IL_011a: ldarg.1
IL_011b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_0120: ldloc.s V_4
IL_0122: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_0127: stloc.s V_6
IL_0129: ldloc.s V_5
IL_012b: ldstr "note_"
IL_0130: ldsfld System.String System.String::Empty
IL_0135: callvirt System.String System.String::Replace(System.String,System.String)
IL_013a: ldstr "kink_"
IL_013f: ldsfld System.String System.String::Empty
IL_0144: callvirt System.String System.String::Replace(System.String,System.String)
IL_0149: stloc.s V_5
IL_014b: ldarg.2
IL_014c: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0151: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0156: ldloc.0
IL_0157: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_015c: ldloc.s V_6
IL_015e: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0163: ldloc.s V_5
IL_0165: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerUnlockBioFragment::.ctor(System.Int32,System.Int32,System.String,System.String)
IL_016a: stloc.s V_7
IL_016c: ldarg.2
IL_016d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_0172: ldloc.s V_7
IL_0174: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_0179: ldloc.s V_7
IL_017b: ldloc.2
IL_017c: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_0181: ldloc.s V_7
IL_0183: ldarg.0
IL_0184: ldloc.2
IL_0185: ldloc.0
IL_0186: ldc.i4.0
IL_0187: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_018c: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_0191: ldarg.1
IL_0192: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByPluginDbTriggerName
IL_0197: ldloc.s V_5
IL_0199: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::ContainsKey(!0)
IL_019e: brfalse.s IL_01be
IL_01a0: ldarg.1
IL_01a1: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByPluginDbTriggerName
IL_01a6: ldloc.s V_5
IL_01a8: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_01ad: ldfld System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Narrative.BioKeyword::unlockedByDialogueDbNames
IL_01b2: ldarg.2
IL_01b3: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_01b8: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_01bd: pop
IL_01be: ldloca.s V_1
IL_01c0: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_01c5: brtrue IL_002e
IL_01ca: leave.s IL_01da
IL_01cc: ldloca.s V_1
IL_01ce: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_01d4: callvirt System.Void System.IDisposable::Dispose()
IL_01d9: endfinally
IL_01da: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddArcManualCompletionTrigger(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0006: ldarg.2
IL_0007: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_000c: ldc.i4.0
IL_000d: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0012: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0017: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_001c: stloc.0
IL_001d: ldarg.1
IL_001e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0023: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0028: stloc.1
IL_0029: br IL_012d
IL_002e: ldloca.s V_1
IL_0030: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0035: stloc.2
IL_0036: ldloc.2
IL_0037: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0042: brfalse IL_012d
IL_0047: ldarg.2
IL_0048: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_004d: ldarg.2
IL_004e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0053: ldstr "("
IL_0058: callvirt System.Int32 System.String::IndexOf(System.String)
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: ldarg.2
IL_0060: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0065: callvirt System.Int32 System.String::get_Length()
IL_006a: ldarg.2
IL_006b: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0070: ldstr "("
IL_0075: callvirt System.Int32 System.String::IndexOf(System.String)
IL_007a: sub
IL_007b: ldc.i4.2
IL_007c: sub
IL_007d: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0082: stloc.3
IL_0083: ldnull
IL_0084: stloc.s V_4
IL_0086: ldarg.1
IL_0087: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_008c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0091: stloc.s V_6
IL_0093: br.s IL_00b3
IL_0095: ldloca.s V_6
IL_0097: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_009c: stloc.s V_7
IL_009e: ldloc.s V_7
IL_00a0: ldfld System.String TheForestOfLove.Narrative.Arc::pluginDbSuffix
IL_00a5: ldloc.3
IL_00a6: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00ab: brfalse.s IL_00b3
IL_00ad: ldloc.s V_7
IL_00af: stloc.s V_4
IL_00b1: leave.s IL_00cc
IL_00b3: ldloca.s V_6
IL_00b5: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_00ba: brtrue.s IL_0095
IL_00bc: leave.s IL_00cc
IL_00be: ldloca.s V_6
IL_00c0: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_00c6: callvirt System.Void System.IDisposable::Dispose()
IL_00cb: endfinally
IL_00cc: ldloc.s V_4
IL_00ce: brtrue.s IL_00e6
IL_00d0: ldstr "arc manual completion trigger, unrecognized or no matching arc name! "
IL_00d5: ldarg.1
IL_00d6: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00db: call System.String System.String::Concat(System.String,System.String)
IL_00e0: newobj System.Void System.Exception::.ctor(System.String)
IL_00e5: throw
IL_00e6: ldloc.s V_4
IL_00e8: ldc.i4.1
IL_00e9: stfld System.Boolean TheForestOfLove.Narrative.Arc::hasCustomFinishTrigger
IL_00ee: ldarg.1
IL_00ef: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00f4: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00f9: ldloc.0
IL_00fa: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00ff: ldloc.s V_4
IL_0101: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerManuallyCompleteArc::.ctor(System.Int32,System.Int32,TheForestOfLove.Narrative.Arc)
IL_0106: stloc.s V_5
IL_0108: ldarg.1
IL_0109: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_010e: ldloc.s V_5
IL_0110: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_0115: ldloc.s V_5
IL_0117: ldloc.2
IL_0118: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_011d: ldloc.s V_5
IL_011f: ldarg.0
IL_0120: ldloc.2
IL_0121: ldloc.0
IL_0122: ldc.i4.0
IL_0123: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_0128: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_012d: ldloca.s V_1
IL_012f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0134: brtrue IL_002e
IL_0139: leave.s IL_0149
IL_013b: ldloca.s V_1
IL_013d: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0143: callvirt System.Void System.IDisposable::Dispose()
IL_0148: endfinally
IL_0149: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationActorEncounteredTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0006: ldarg.3
IL_0007: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_000c: ldc.i4.0
IL_000d: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0012: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0017: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_001c: stloc.0
IL_001d: ldarg.2
IL_001e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0023: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0028: stloc.1
IL_0029: br IL_0118
IL_002e: ldloca.s V_1
IL_0030: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0035: stloc.2
IL_0036: ldloc.2
IL_0037: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0042: brfalse IL_0118
IL_0047: ldarg.3
IL_0048: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_004d: ldarg.3
IL_004e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0053: ldstr "("
IL_0058: callvirt System.Int32 System.String::IndexOf(System.String)
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: ldarg.3
IL_0060: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0065: callvirt System.Int32 System.String::get_Length()
IL_006a: ldarg.3
IL_006b: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0070: ldstr "("
IL_0075: callvirt System.Int32 System.String::IndexOf(System.String)
IL_007a: sub
IL_007b: ldc.i4.2
IL_007c: sub
IL_007d: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0082: stloc.3
IL_0083: ldloc.3
IL_0084: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0089: brfalse.s IL_009c
IL_008b: ldstr "unrecognized actor name! "
IL_0090: ldloc.3
IL_0091: call System.String System.String::Concat(System.String,System.String)
IL_0096: newobj System.Void System.Exception::.ctor(System.String)
IL_009b: throw
IL_009c: ldarg.1
IL_009d: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_00a2: ldloc.3
IL_00a3: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::ContainsKey(!0)
IL_00a8: brtrue.s IL_00c6
IL_00aa: ldstr "unrecognized actor! "
IL_00af: ldloc.3
IL_00b0: ldstr " "
IL_00b5: ldarg.2
IL_00b6: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00bb: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00c0: newobj System.Void System.Exception::.ctor(System.String)
IL_00c5: throw
IL_00c6: ldarg.1
IL_00c7: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_00cc: ldloc.3
IL_00cd: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_00d2: stloc.s V_4
IL_00d4: ldarg.2
IL_00d5: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00da: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00df: ldloc.0
IL_00e0: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00e5: ldloc.s V_4
IL_00e7: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00ec: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerEncounterActor::.ctor(System.Int32,System.Int32,System.String)
IL_00f1: stloc.s V_5
IL_00f3: ldarg.2
IL_00f4: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_00f9: ldloc.s V_5
IL_00fb: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_0100: ldloc.s V_5
IL_0102: ldloc.2
IL_0103: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_0108: ldloc.s V_5
IL_010a: ldarg.0
IL_010b: ldloc.2
IL_010c: ldloc.0
IL_010d: ldc.i4.0
IL_010e: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_0113: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_0118: ldloca.s V_1
IL_011a: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_011f: brtrue IL_002e
IL_0124: leave.s IL_0134
IL_0126: ldloca.s V_1
IL_0128: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_012e: callvirt System.Void System.IDisposable::Dispose()
IL_0133: endfinally
IL_0134: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationActorIntroducedTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0006: ldarg.3
IL_0007: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_000c: ldc.i4.0
IL_000d: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0012: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0017: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_001c: stloc.0
IL_001d: ldarg.2
IL_001e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0023: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0028: stloc.1
IL_0029: br IL_0118
IL_002e: ldloca.s V_1
IL_0030: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0035: stloc.2
IL_0036: ldloc.2
IL_0037: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0042: brfalse IL_0118
IL_0047: ldarg.3
IL_0048: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_004d: ldarg.3
IL_004e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0053: ldstr "("
IL_0058: callvirt System.Int32 System.String::IndexOf(System.String)
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: ldarg.3
IL_0060: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0065: callvirt System.Int32 System.String::get_Length()
IL_006a: ldarg.3
IL_006b: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0070: ldstr "("
IL_0075: callvirt System.Int32 System.String::IndexOf(System.String)
IL_007a: sub
IL_007b: ldc.i4.2
IL_007c: sub
IL_007d: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0082: stloc.3
IL_0083: ldloc.3
IL_0084: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0089: brfalse.s IL_009c
IL_008b: ldstr "unrecognized actor name! "
IL_0090: ldloc.3
IL_0091: call System.String System.String::Concat(System.String,System.String)
IL_0096: newobj System.Void System.Exception::.ctor(System.String)
IL_009b: throw
IL_009c: ldarg.1
IL_009d: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_00a2: ldloc.3
IL_00a3: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::ContainsKey(!0)
IL_00a8: brtrue.s IL_00c6
IL_00aa: ldstr "unrecognized actor! "
IL_00af: ldloc.3
IL_00b0: ldstr " "
IL_00b5: ldarg.2
IL_00b6: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00bb: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00c0: newobj System.Void System.Exception::.ctor(System.String)
IL_00c5: throw
IL_00c6: ldarg.1
IL_00c7: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_00cc: ldloc.3
IL_00cd: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_00d2: stloc.s V_4
IL_00d4: ldarg.2
IL_00d5: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00da: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00df: ldloc.0
IL_00e0: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00e5: ldloc.s V_4
IL_00e7: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00ec: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerIntroduceActor::.ctor(System.Int32,System.Int32,System.String)
IL_00f1: stloc.s V_5
IL_00f3: ldarg.2
IL_00f4: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_00f9: ldloc.s V_5
IL_00fb: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_0100: ldloc.s V_5
IL_0102: ldloc.2
IL_0103: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_0108: ldloc.s V_5
IL_010a: ldarg.0
IL_010b: ldloc.2
IL_010c: ldloc.0
IL_010d: ldc.i4.0
IL_010e: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_0113: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_0118: ldloca.s V_1
IL_011a: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_011f: brtrue IL_002e
IL_0124: leave.s IL_0134
IL_0126: ldloca.s V_1
IL_0128: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_012e: callvirt System.Void System.IDisposable::Dispose()
IL_0133: endfinally
IL_0134: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationTriggerChangeFont(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.3
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_000b: brtrue.s IL_000e
IL_000d: ret
IL_000e: ldarg.2
IL_000f: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0014: ldarg.3
IL_0015: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_001a: ldc.i4.0
IL_001b: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0020: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0025: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_002a: stloc.0
IL_002b: ldarg.2
IL_002c: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0031: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0036: stloc.1
IL_0037: br IL_00fa
IL_003c: ldloca.s V_1
IL_003e: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0043: stloc.2
IL_0044: ldloc.2
IL_0045: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_004a: ldloc.0
IL_004b: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0050: brfalse IL_00fa
IL_0055: ldarg.3
IL_0056: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_005b: ldarg.3
IL_005c: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0061: ldstr "("
IL_0066: callvirt System.Int32 System.String::IndexOf(System.String)
IL_006b: ldc.i4.1
IL_006c: add
IL_006d: ldarg.3
IL_006e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0073: callvirt System.Int32 System.String::get_Length()
IL_0078: ldarg.3
IL_0079: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_007e: ldstr "("
IL_0083: callvirt System.Int32 System.String::IndexOf(System.String)
IL_0088: sub
IL_0089: ldc.i4.2
IL_008a: sub
IL_008b: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0090: stloc.3
IL_0091: ldloc.3
IL_0092: ldstr "main"
IL_0097: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_009c: brfalse.s IL_00bc
IL_009e: ldloc.3
IL_009f: ldstr "mouse"
IL_00a4: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_00a9: brfalse.s IL_00bc
IL_00ab: ldstr "unrecognized font name! "
IL_00b0: ldloc.3
IL_00b1: call System.String System.String::Concat(System.String,System.String)
IL_00b6: newobj System.Void System.Exception::.ctor(System.String)
IL_00bb: throw
IL_00bc: ldarg.2
IL_00bd: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00c2: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00c7: ldloc.0
IL_00c8: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00cd: ldloc.3
IL_00ce: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireChangeFont::.ctor(System.Int32,System.Int32,System.String)
IL_00d3: stloc.s V_4
IL_00d5: ldarg.2
IL_00d6: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_00db: ldloc.s V_4
IL_00dd: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_00e2: ldloc.s V_4
IL_00e4: ldloc.2
IL_00e5: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_00ea: ldloc.s V_4
IL_00ec: ldarg.0
IL_00ed: ldloc.2
IL_00ee: ldloc.0
IL_00ef: ldc.i4.0
IL_00f0: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_00f5: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_00fa: ldloca.s V_1
IL_00fc: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0101: brtrue IL_003c
IL_0106: leave.s IL_0116
IL_0108: ldloca.s V_1
IL_010a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0110: callvirt System.Void System.IDisposable::Dispose()
IL_0115: endfinally
IL_0116: ret
METHOD System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldarg.1
IL_0002: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0007: bne.un.s IL_000b
IL_0009: ldarg.3
IL_000a: ret
IL_000b: ldnull
IL_000c: stloc.0
IL_000d: ldarg.1
IL_000e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_0013: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::GetEnumerator()
IL_0018: stloc.1
IL_0019: br.s IL_007f
IL_001b: ldloca.s V_1
IL_001d: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>::get_Current()
IL_0022: stloc.2
IL_0023: ldloc.2
IL_0024: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0029: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::GetEnumerator()
IL_002e: stloc.3
IL_002f: br.s IL_0061
IL_0031: ldloca.s V_3
IL_0033: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::get_Current()
IL_0038: stloc.s V_4
IL_003a: ldloc.s V_4
IL_003c: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_0041: ldarg.1
IL_0042: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0047: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_004c: bne.un.s IL_0061
IL_004e: ldloc.s V_4
IL_0050: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0055: ldarg.2
IL_0056: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_005b: bne.un.s IL_0061
IL_005d: ldloc.2
IL_005e: stloc.0
IL_005f: leave.s IL_007a
IL_0061: ldloca.s V_3
IL_0063: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::MoveNext()
IL_0068: brtrue.s IL_0031
IL_006a: leave.s IL_007a
IL_006c: ldloca.s V_3
IL_006e: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>
IL_0074: callvirt System.Void System.IDisposable::Dispose()
IL_0079: endfinally
IL_007a: ldloc.0
IL_007b: brfalse.s IL_007f
IL_007d: leave.s IL_0098
IL_007f: ldloca.s V_1
IL_0081: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>::MoveNext()
IL_0086: brtrue.s IL_001b
IL_0088: leave.s IL_0098
IL_008a: ldloca.s V_1
IL_008c: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>
IL_0092: callvirt System.Void System.IDisposable::Dispose()
IL_0097: endfinally
IL_0098: ldloc.0
IL_0099: brfalse.s IL_00a7
IL_009b: ldarg.0
IL_009c: ldarg.1
IL_009d: ldloc.0
IL_009e: ldarg.3
IL_009f: ldc.i4.1
IL_00a0: add
IL_00a1: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_00a6: ret
IL_00a7: ldstr "error finding parent dialogue entry in "
IL_00ac: ldarg.1
IL_00ad: ldfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.Arc::dialogue
IL_00b2: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00b7: ldstr "."
IL_00bc: ldarg.1
IL_00bd: ldfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_00c2: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00c7: newobj System.Void System.Exception::.ctor(System.String)
IL_00cc: throw
