TYPE TheForestOfLove.Services.Persistence.Savestate
METHOD TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.Savestate::DeepCopy() | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Services.Persistence.Savestate::.ctor()
IL_0005: stloc.0
IL_0006: ldarg.0
IL_0007: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData> TheForestOfLove.Services.Persistence.Savestate::actorData
IL_000c: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::GetEnumerator()
IL_0011: stloc.1
IL_0012: br.s IL_003a
IL_0014: ldloca.s V_1
IL_0016: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::get_Current()
IL_001b: stloc.2
IL_001c: ldloc.0
IL_001d: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData> TheForestOfLove.Services.Persistence.Savestate::actorData
IL_0022: ldloca.s V_2
IL_0024: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::get_Key()
IL_0029: ldloca.s V_2
IL_002b: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::get_Value()
IL_0030: callvirt TheForestOfLove.Services.Persistence.SavegameActorData TheForestOfLove.Services.Persistence.SavegameActorData::DeepCopy()
IL_0035: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::Add(!0,!1)
IL_003a: ldloca.s V_1
IL_003c: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>::MoveNext()
IL_0041: brtrue.s IL_0014
IL_0043: leave.s IL_0053
IL_0045: ldloca.s V_1
IL_0047: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameActorData>
IL_004d: callvirt System.Void System.IDisposable::Dispose()
IL_0052: endfinally
IL_0053: ldarg.0
IL_0054: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData> TheForestOfLove.Services.Persistence.Savestate::actorOracleData
IL_0059: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData>::GetEnumerator()
IL_005e: stloc.3
IL_005f: br.s IL_0088
IL_0061: ldloca.s V_3
IL_0063: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData>::get_Current()
IL_0068: stloc.s V_4
IL_006a: ldloc.0
IL_006b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData> TheForestOfLove.Services.Persistence.Savestate::actorOracleData
IL_0070: ldloca.s V_4
IL_0072: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData>::get_Key()
IL_0077: ldloca.s V_4
IL_0079: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData>::get_Value()
IL_007e: callvirt TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData::DeepCopy()
IL_0083: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData>::Add(!0,!1)
IL_0088: ldloca.s V_3
IL_008a: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData>::MoveNext()
IL_008f: brtrue.s IL_0061
IL_0091: leave.s IL_00a1
IL_0093: ldloca.s V_3
IL_0095: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData>
IL_009b: callvirt System.Void System.IDisposable::Dispose()
IL_00a0: endfinally
IL_00a1: ldarg.0
IL_00a2: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData> TheForestOfLove.Services.Persistence.Savestate::triggerData
IL_00a7: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData>::GetEnumerator()
IL_00ac: stloc.s V_5
IL_00ae: br.s IL_00d7
IL_00b0: ldloca.s V_5
IL_00b2: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData>::get_Current()
IL_00b7: stloc.s V_6
IL_00b9: ldloc.0
IL_00ba: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData> TheForestOfLove.Services.Persistence.Savestate::triggerData
IL_00bf: ldloca.s V_6
IL_00c1: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData>::get_Key()
IL_00c6: ldloca.s V_6
IL_00c8: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData>::get_Value()
IL_00cd: callvirt TheForestOfLove.Services.Persistence.SavegameTriggerData TheForestOfLove.Services.Persistence.SavegameTriggerData::DeepCopy()
IL_00d2: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData>::Add(!0,!1)
IL_00d7: ldloca.s V_5
IL_00d9: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData>::MoveNext()
IL_00de: brtrue.s IL_00b0
IL_00e0: leave.s IL_00f0
IL_00e2: ldloca.s V_5
IL_00e4: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameTriggerData>
IL_00ea: callvirt System.Void System.IDisposable::Dispose()
IL_00ef: endfinally
IL_00f0: ldarg.0
IL_00f1: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameAdventureData> TheForestOfLove.Services.Persistence.Savestate::adventureData
IL_00f6: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameAdventureData>::GetEnumerator()
IL_00fb: stloc.s V_7
IL_00fd: br.s IL_0126
IL_00ff: ldloca.s V_7
IL_0101: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameAdventureData>::get_Current()
IL_0106: stloc.s V_8
IL_0108: ldloc.0
IL_0109: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameAdventureData> TheForestOfLove.Services.Persistence.Savestate::adventureData
IL_010e: ldloca.s V_8
IL_0110: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameAdventureData>::get_Key()
IL_0115: ldloca.s V_8
IL_0117: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameAdventureData>::get_Value()
IL_011c: callvirt TheForestOfLove.Services.Persistence.SavegameAdventureData TheForestOfLove.Services.Persistence.SavegameAdventureData::DeepCopy()
IL_0121: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameAdventureData>::Add(!0,!1)
IL_0126: ldloca.s V_7
IL_0128: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameAdventureData>::MoveNext()
IL_012d: brtrue.s IL_00ff
IL_012f: leave.s IL_013f
IL_0131: ldloca.s V_7
IL_0133: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameAdventureData>
IL_0139: callvirt System.Void System.IDisposable::Dispose()
IL_013e: endfinally
IL_013f: ldarg.0
IL_0140: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestData> TheForestOfLove.Services.Persistence.Savestate::questData
IL_0145: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestData>::GetEnumerator()
IL_014a: stloc.s V_9
IL_014c: br.s IL_0175
IL_014e: ldloca.s V_9
IL_0150: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameQuestData>::get_Current()
IL_0155: stloc.s V_10
IL_0157: ldloc.0
IL_0158: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestData> TheForestOfLove.Services.Persistence.Savestate::questData
IL_015d: ldloca.s V_10
IL_015f: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestData>::get_Key()
IL_0164: ldloca.s V_10
IL_0166: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestData>::get_Value()
IL_016b: callvirt TheForestOfLove.Services.Persistence.SavegameQuestData TheForestOfLove.Services.Persistence.SavegameQuestData::DeepCopy()
IL_0170: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestData>::Add(!0,!1)
IL_0175: ldloca.s V_9
IL_0177: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameQuestData>::MoveNext()
IL_017c: brtrue.s IL_014e
IL_017e: leave.s IL_018e
IL_0180: ldloca.s V_9
IL_0182: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameQuestData>
IL_0188: callvirt System.Void System.IDisposable::Dispose()
IL_018d: endfinally
IL_018e: ldarg.0
IL_018f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry> TheForestOfLove.Services.Persistence.Savestate::questProgressLogData
IL_0194: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry>::GetEnumerator()
IL_0199: stloc.s V_11
IL_019b: br.s IL_01c4
IL_019d: ldloca.s V_11
IL_019f: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry>::get_Current()
IL_01a4: stloc.s V_12
IL_01a6: ldloc.0
IL_01a7: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry> TheForestOfLove.Services.Persistence.Savestate::questProgressLogData
IL_01ac: ldloca.s V_12
IL_01ae: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry>::get_Key()
IL_01b3: ldloca.s V_12
IL_01b5: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry>::get_Value()
IL_01ba: callvirt TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry::DeepCopy()
IL_01bf: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry>::Add(!0,!1)
IL_01c4: ldloca.s V_11
IL_01c6: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry>::MoveNext()
IL_01cb: brtrue.s IL_019d
IL_01cd: leave.s IL_01dd
IL_01cf: ldloca.s V_11
IL_01d1: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry>
IL_01d7: callvirt System.Void System.IDisposable::Dispose()
IL_01dc: endfinally
IL_01dd: ldarg.0
IL_01de: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameDialogueData> TheForestOfLove.Services.Persistence.Savestate::dialogueData
IL_01e3: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameDialogueData>::GetEnumerator()
IL_01e8: stloc.s V_13
IL_01ea: br.s IL_0213
IL_01ec: ldloca.s V_13
IL_01ee: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameDialogueData>::get_Current()
IL_01f3: stloc.s V_14
IL_01f5: ldloc.0
IL_01f6: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameDialogueData> TheForestOfLove.Services.Persistence.Savestate::dialogueData
IL_01fb: ldloca.s V_14
IL_01fd: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameDialogueData>::get_Key()
IL_0202: ldloca.s V_14
IL_0204: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameDialogueData>::get_Value()
IL_0209: callvirt TheForestOfLove.Services.Persistence.SavegameDialogueData TheForestOfLove.Services.Persistence.SavegameDialogueData::DeepCopy()
IL_020e: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameDialogueData>::Add(!0,!1)
IL_0213: ldloca.s V_13
IL_0215: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameDialogueData>::MoveNext()
IL_021a: brtrue.s IL_01ec
IL_021c: leave.s IL_022c
IL_021e: ldloca.s V_13
IL_0220: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameDialogueData>
IL_0226: callvirt System.Void System.IDisposable::Dispose()
IL_022b: endfinally
IL_022c: ldarg.0
IL_022d: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameArcData> TheForestOfLove.Services.Persistence.Savestate::arcData
IL_0232: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameArcData>::GetEnumerator()
IL_0237: stloc.s V_15
IL_0239: br.s IL_0262
IL_023b: ldloca.s V_15
IL_023d: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameArcData>::get_Current()
IL_0242: stloc.s V_16
IL_0244: ldloc.0
IL_0245: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameArcData> TheForestOfLove.Services.Persistence.Savestate::arcData
IL_024a: ldloca.s V_16
IL_024c: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameArcData>::get_Key()
IL_0251: ldloca.s V_16
IL_0253: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameArcData>::get_Value()
IL_0258: callvirt TheForestOfLove.Services.Persistence.SavegameArcData TheForestOfLove.Services.Persistence.SavegameArcData::DeepCopy()
IL_025d: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameArcData>::Add(!0,!1)
IL_0262: ldloca.s V_15
IL_0264: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameArcData>::MoveNext()
IL_0269: brtrue.s IL_023b
IL_026b: leave.s IL_027b
IL_026d: ldloca.s V_15
IL_026f: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameArcData>
IL_0275: callvirt System.Void System.IDisposable::Dispose()
IL_027a: endfinally
IL_027b: ldarg.0
IL_027c: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.Services.Persistence.Savestate::variables
IL_0281: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,System.String>::GetEnumerator()
IL_0286: stloc.s V_17
IL_0288: br.s IL_02ac
IL_028a: ldloca.s V_17
IL_028c: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,System.String>::get_Current()
IL_0291: stloc.s V_18
IL_0293: ldloc.0
IL_0294: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.Services.Persistence.Savestate::variables
IL_0299: ldloca.s V_18
IL_029b: call !0 System.Collections.Generic.KeyValuePair`2<System.String,System.String>::get_Key()
IL_02a0: ldloca.s V_18
IL_02a2: call !1 System.Collections.Generic.KeyValuePair`2<System.String,System.String>::get_Value()
IL_02a7: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.String>::Add(!0,!1)
IL_02ac: ldloca.s V_17
IL_02ae: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,System.String>::MoveNext()
IL_02b3: brtrue.s IL_028a
IL_02b5: leave.s IL_02c5
IL_02b7: ldloca.s V_17
IL_02b9: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,System.String>
IL_02bf: callvirt System.Void System.IDisposable::Dispose()
IL_02c4: endfinally
IL_02c5: ldarg.0
IL_02c6: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameInventoryItemData> TheForestOfLove.Services.Persistence.Savestate::inventoryItemData
IL_02cb: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameInventoryItemData>::GetEnumerator()
IL_02d0: stloc.s V_19
IL_02d2: br.s IL_02fb
IL_02d4: ldloca.s V_19
IL_02d6: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameInventoryItemData>::get_Current()
IL_02db: stloc.s V_20
IL_02dd: ldloc.0
IL_02de: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameInventoryItemData> TheForestOfLove.Services.Persistence.Savestate::inventoryItemData
IL_02e3: ldloca.s V_20
IL_02e5: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameInventoryItemData>::get_Key()
IL_02ea: ldloca.s V_20
IL_02ec: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameInventoryItemData>::get_Value()
IL_02f1: callvirt TheForestOfLove.Services.Persistence.SavegameInventoryItemData TheForestOfLove.Services.Persistence.SavegameInventoryItemData::DeepCopy()
IL_02f6: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameInventoryItemData>::Add(!0,!1)
IL_02fb: ldloca.s V_19
IL_02fd: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameInventoryItemData>::MoveNext()
IL_0302: brtrue.s IL_02d4
IL_0304: leave.s IL_0314
IL_0306: ldloca.s V_19
IL_0308: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameInventoryItemData>
IL_030e: callvirt System.Void System.IDisposable::Dispose()
IL_0313: endfinally
IL_0314: ldarg.0
IL_0315: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameChapterData> TheForestOfLove.Services.Persistence.Savestate::chapterData
IL_031a: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameChapterData>::GetEnumerator()
IL_031f: stloc.s V_21
IL_0321: br.s IL_034a
IL_0323: ldloca.s V_21
IL_0325: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameChapterData>::get_Current()
IL_032a: stloc.s V_22
IL_032c: ldloc.0
IL_032d: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameChapterData> TheForestOfLove.Services.Persistence.Savestate::chapterData
IL_0332: ldloca.s V_22
IL_0334: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameChapterData>::get_Key()
IL_0339: ldloca.s V_22
IL_033b: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameChapterData>::get_Value()
IL_0340: callvirt TheForestOfLove.Services.Persistence.SavegameChapterData TheForestOfLove.Services.Persistence.SavegameChapterData::DeepCopy()
IL_0345: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameChapterData>::Add(!0,!1)
IL_034a: ldloca.s V_21
IL_034c: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameChapterData>::MoveNext()
IL_0351: brtrue.s IL_0323
IL_0353: leave.s IL_0363
IL_0355: ldloca.s V_21
IL_0357: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameChapterData>
IL_035d: callvirt System.Void System.IDisposable::Dispose()
IL_0362: endfinally
IL_0363: ldarg.0
IL_0364: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameMovieData> TheForestOfLove.Services.Persistence.Savestate::movieData
IL_0369: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameMovieData>::GetEnumerator()
IL_036e: stloc.s V_23
IL_0370: br.s IL_0399
IL_0372: ldloca.s V_23
IL_0374: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameMovieData>::get_Current()
IL_0379: stloc.s V_24
IL_037b: ldloc.0
IL_037c: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameMovieData> TheForestOfLove.Services.Persistence.Savestate::movieData
IL_0381: ldloca.s V_24
IL_0383: call !0 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameMovieData>::get_Key()
IL_0388: ldloca.s V_24
IL_038a: call !1 System.Collections.Generic.KeyValuePair`2<System.String,TheForestOfLove.Services.Persistence.SavegameMovieData>::get_Value()
IL_038f: callvirt TheForestOfLove.Services.Persistence.SavegameMovieData TheForestOfLove.Services.Persistence.SavegameMovieData::DeepCopy()
IL_0394: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameMovieData>::Add(!0,!1)
IL_0399: ldloca.s V_23
IL_039b: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameMovieData>::MoveNext()
IL_03a0: brtrue.s IL_0372
IL_03a2: leave.s IL_03b2
IL_03a4: ldloca.s V_23
IL_03a6: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameMovieData>
IL_03ac: callvirt System.Void System.IDisposable::Dispose()
IL_03b1: endfinally
IL_03b2: ldarg.0
IL_03b3: ldfld System.Collections.Generic.List`1<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory> TheForestOfLove.Services.Persistence.Savestate::gameplayLogHistory
IL_03b8: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory>::GetEnumerator()
IL_03bd: stloc.s V_25
IL_03bf: br.s IL_03dc
IL_03c1: ldloca.s V_25
IL_03c3: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory>::get_Current()
IL_03c8: stloc.s V_26
IL_03ca: ldloc.0
IL_03cb: ldfld System.Collections.Generic.List`1<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory> TheForestOfLove.Services.Persistence.Savestate::gameplayLogHistory
IL_03d0: ldloc.s V_26
IL_03d2: callvirt TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory::DeepCopy()
IL_03d7: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory>::Add(!0)
IL_03dc: ldloca.s V_25
IL_03de: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory>::MoveNext()
IL_03e3: brtrue.s IL_03c1
IL_03e5: leave.s IL_03f5
IL_03e7: ldloca.s V_25
IL_03e9: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory>
IL_03ef: callvirt System.Void System.IDisposable::Dispose()
IL_03f4: endfinally
IL_03f5: ldarg.0
IL_03f6: ldfld System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Services.Persistence.Savestate::tags
IL_03fb: callvirt System.Collections.Generic.HashSet`1/Enumerator<!0> System.Collections.Generic.HashSet`1<System.String>::GetEnumerator()
IL_0400: stloc.s V_27
IL_0402: br.s IL_041b
IL_0404: ldloca.s V_27
IL_0406: call !0 System.Collections.Generic.HashSet`1/Enumerator<System.String>::get_Current()
IL_040b: stloc.s V_28
IL_040d: ldloc.0
IL_040e: ldfld System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Services.Persistence.Savestate::tags
IL_0413: ldloc.s V_28
IL_0415: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_041a: pop
IL_041b: ldloca.s V_27
IL_041d: call System.Boolean System.Collections.Generic.HashSet`1/Enumerator<System.String>::MoveNext()
IL_0422: brtrue.s IL_0404
IL_0424: leave.s IL_0434
IL_0426: ldloca.s V_27
IL_0428: constrained. System.Collections.Generic.HashSet`1/Enumerator<System.String>
IL_042e: callvirt System.Void System.IDisposable::Dispose()
IL_0433: endfinally
IL_0434: ldloc.0
IL_0435: ldarg.0
IL_0436: ldfld TheForestOfLove.Services.Persistence.SavegameGeneralData TheForestOfLove.Services.Persistence.Savestate::generalData
IL_043b: callvirt TheForestOfLove.Services.Persistence.SavegameGeneralData TheForestOfLove.Services.Persistence.SavegameGeneralData::DeepCopy()
IL_0440: stfld TheForestOfLove.Services.Persistence.SavegameGeneralData TheForestOfLove.Services.Persistence.Savestate::generalData
IL_0445: ldloc.0
IL_0446: ldarg.0
IL_0447: ldfld TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData TheForestOfLove.Services.Persistence.Savestate::playerRespawnData
IL_044c: callvirt TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData::DeepCopy()
IL_0451: stfld TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData TheForestOfLove.Services.Persistence.Savestate::playerRespawnData
IL_0456: ldloc.0
IL_0457: ldarg.0
IL_0458: ldfld TheForestOfLove.Services.Persistence.SavegamePlantQuestMinigameData TheForestOfLove.Services.Persistence.Savestate::plantQuestMinigameData
IL_045d: callvirt TheForestOfLove.Services.Persistence.SavegamePlantQuestMinigameData TheForestOfLove.Services.Persistence.SavegamePlantQuestMinigameData::DeepCopy()
IL_0462: stfld TheForestOfLove.Services.Persistence.SavegamePlantQuestMinigameData TheForestOfLove.Services.Persistence.Savestate::plantQuestMinigameData
IL_0467: ldloc.0
IL_0468: ldarg.0
IL_0469: ldfld TheForestOfLove.Services.Persistence.SavegameDashQuestMinigameData TheForestOfLove.Services.Persistence.Savestate::dashQuestMinigameData
IL_046e: callvirt TheForestOfLove.Services.Persistence.SavegameDashQuestMinigameData TheForestOfLove.Services.Persistence.SavegameDashQuestMinigameData::DeepCopy()
IL_0473: stfld TheForestOfLove.Services.Persistence.SavegameDashQuestMinigameData TheForestOfLove.Services.Persistence.Savestate::dashQuestMinigameData
IL_0478: ldloc.0
IL_0479: ldarg.0
IL_047a: ldfld TheForestOfLove.Services.Persistence.SavegameDustinMinigameTrainingData TheForestOfLove.Services.Persistence.Savestate::dustinMinigameTrainingData
IL_047f: callvirt TheForestOfLove.Services.Persistence.SavegameDustinMinigameTrainingData TheForestOfLove.Services.Persistence.SavegameDustinMinigameTrainingData::DeepCopy()
IL_0484: stfld TheForestOfLove.Services.Persistence.SavegameDustinMinigameTrainingData TheForestOfLove.Services.Persistence.Savestate::dustinMinigameTrainingData
IL_0489: ldloc.0
IL_048a: ldarg.0
IL_048b: ldfld TheForestOfLove.Services.Persistence.SavegameDustinMinigameNoviceData TheForestOfLove.Services.Persistence.Savestate::dustinMinigameNoviceData
IL_0490: callvirt TheForestOfLove.Services.Persistence.SavegameDustinMinigameNoviceData TheForestOfLove.Services.Persistence.SavegameDustinMinigameNoviceData::DeepCopy()
IL_0495: stfld TheForestOfLove.Services.Persistence.SavegameDustinMinigameNoviceData TheForestOfLove.Services.Persistence.Savestate::dustinMinigameNoviceData
IL_049a: ldloc.0
IL_049b: ldarg.0
IL_049c: ldfld TheForestOfLove.Services.Persistence.SavegameGlitchRascalPart1Data TheForestOfLove.Services.Persistence.Savestate::glitchRascalPart1Data
IL_04a1: callvirt TheForestOfLove.Services.Persistence.SavegameGlitchRascalPart1Data TheForestOfLove.Services.Persistence.SavegameGlitchRascalPart1Data::DeepCopy()
IL_04a6: stfld TheForestOfLove.Services.Persistence.SavegameGlitchRascalPart1Data TheForestOfLove.Services.Persistence.Savestate::glitchRascalPart1Data
IL_04ab: ldloc.0
IL_04ac: ldstr "cheats_dustin_minigame_invincible"
IL_04b1: ldarg.0
IL_04b2: ldstr "cheats_dustin_minigame_invincible"
IL_04b7: call System.String TheForestOfLove.Services.Persistence.Savestate::LoadVariable(System.String)
IL_04bc: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveVariable(System.String,System.String)
IL_04c1: ldloc.0
IL_04c2: ldstr "cheats_plant_minigame_handsfree"
IL_04c7: ldarg.0
IL_04c8: ldstr "cheats_plant_minigame_handsfree"
IL_04cd: call System.String TheForestOfLove.Services.Persistence.Savestate::LoadVariable(System.String)
IL_04d2: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveVariable(System.String,System.String)
IL_04d7: ldloc.0
IL_04d8: ret
