TYPE TheForestOfLove.DevConsoleCommands/StatsCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_GenerateStats(System.String,TheForestOfLove.Narrative.Actor,System.Int32) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::.ctor()
IL_0005: dup
IL_0006: ldstr "quest"
IL_000b: stfld System.String TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::typeName
IL_0010: stloc.0
IL_0011: newobj System.Void TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::.ctor()
IL_0016: dup
IL_0017: ldstr "date"
IL_001c: stfld System.String TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::typeName
IL_0021: stloc.1
IL_0022: newobj System.Void TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::.ctor()
IL_0027: dup
IL_0028: ldstr "gossip"
IL_002d: stfld System.String TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::typeName
IL_0032: stloc.2
IL_0033: newobj System.Void TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::.ctor()
IL_0038: dup
IL_0039: ldstr "gift"
IL_003e: stfld System.String TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::typeName
IL_0043: stloc.3
IL_0044: newobj System.Void TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::.ctor()
IL_0049: dup
IL_004a: ldstr "manual"
IL_004f: stfld System.String TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::typeName
IL_0054: stloc.s V_4
IL_0056: newobj System.Void TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::.ctor()
IL_005b: dup
IL_005c: ldstr "final idles"
IL_0061: stfld System.String TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::typeName
IL_0066: stloc.s V_5
IL_0068: newobj System.Void TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::.ctor()
IL_006d: dup
IL_006e: ldstr "player choice"
IL_0073: stfld System.String TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::typeName
IL_0078: stloc.s V_6
IL_007a: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::.ctor()
IL_007f: dup
IL_0080: ldloc.0
IL_0081: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::Add(!0)
IL_0086: dup
IL_0087: ldloc.1
IL_0088: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::Add(!0)
IL_008d: dup
IL_008e: ldloc.2
IL_008f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::Add(!0)
IL_0094: dup
IL_0095: ldloc.3
IL_0096: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::Add(!0)
IL_009b: dup
IL_009c: ldloc.s V_4
IL_009e: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::Add(!0)
IL_00a3: dup
IL_00a4: ldloc.s V_5
IL_00a6: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::Add(!0)
IL_00ab: dup
IL_00ac: ldloc.s V_6
IL_00ae: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::Add(!0)
IL_00b3: stloc.s V_7
IL_00b5: ldsfld System.String System.String::Empty
IL_00ba: stloc.s V_8
IL_00bc: ldarg.0
IL_00bd: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_00c2: brtrue.s IL_00dc
IL_00c4: ldarg.0
IL_00c5: ldc.i4.1
IL_00c6: newarr System.Char
IL_00cb: dup
IL_00cc: ldc.i4.0
IL_00cd: ldc.i4.s 38
IL_00cf: stelem.i2
IL_00d0: callvirt System.String[] System.String::Split(System.Char[])
IL_00d5: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_00da: br.s IL_00e1
IL_00dc: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00e1: stloc.s V_9
IL_00e3: ldloc.s V_9
IL_00e5: ldloca.s V_8
IL_00e7: call System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_GenerateTags(System.Collections.Generic.List`1<System.String>,System.String&)
IL_00ec: stloc.s V_10
IL_00ee: ldstr "Disabled"
IL_00f3: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_00f8: stloc.s V_11
IL_00fa: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Services.Persistence.DataService::GetActors()
IL_00ff: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Actor>::GetEnumerator()
IL_0104: stloc.s V_12
IL_0106: br IL_031a
IL_010b: ldloc.s V_12
IL_010d: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Actor>::get_Current()
IL_0112: stloc.s V_13
IL_0114: ldarg.1
IL_0115: brfalse.s IL_011f
IL_0117: ldloc.s V_13
IL_0119: ldarg.1
IL_011a: bne.un IL_031a
IL_011f: ldloc.s V_13
IL_0121: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0126: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetQuestDialoguesByPrimaryActor(System.String)
IL_012b: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0130: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0135: stloc.s V_14
IL_0137: br.s IL_014e
IL_0139: ldloca.s V_14
IL_013b: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0140: stloc.s V_15
IL_0142: ldloc.s V_10
IL_0144: ldloc.s V_11
IL_0146: ldloc.s V_15
IL_0148: ldloc.0
IL_0149: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_Dialogue_IncrementIfAnyTagMatches(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>,TheForestOfLove.Narrative.Tag,TheForestOfLove.Narrative.Dialogue,TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry)
IL_014e: ldloca.s V_14
IL_0150: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0155: brtrue.s IL_0139
IL_0157: leave.s IL_0167
IL_0159: ldloca.s V_14
IL_015b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0161: callvirt System.Void System.IDisposable::Dispose()
IL_0166: endfinally
IL_0167: ldloc.s V_13
IL_0169: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_016e: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetDateDialoguesByPrimaryActor(System.String)
IL_0173: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0178: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_017d: stloc.s V_14
IL_017f: br.s IL_0196
IL_0181: ldloca.s V_14
IL_0183: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0188: stloc.s V_16
IL_018a: ldloc.s V_10
IL_018c: ldloc.s V_11
IL_018e: ldloc.s V_16
IL_0190: ldloc.1
IL_0191: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_Dialogue_IncrementIfAnyTagMatches(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>,TheForestOfLove.Narrative.Tag,TheForestOfLove.Narrative.Dialogue,TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry)
IL_0196: ldloca.s V_14
IL_0198: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_019d: brtrue.s IL_0181
IL_019f: leave.s IL_01af
IL_01a1: ldloca.s V_14
IL_01a3: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_01a9: callvirt System.Void System.IDisposable::Dispose()
IL_01ae: endfinally
IL_01af: ldloc.s V_13
IL_01b1: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_01b6: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetGossipDialoguesByPrimaryActor(System.String)
IL_01bb: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_01c0: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_01c5: stloc.s V_14
IL_01c7: br.s IL_01de
IL_01c9: ldloca.s V_14
IL_01cb: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_01d0: stloc.s V_17
IL_01d2: ldloc.s V_10
IL_01d4: ldloc.s V_11
IL_01d6: ldloc.s V_17
IL_01d8: ldloc.2
IL_01d9: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_Dialogue_IncrementIfAnyTagMatches(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>,TheForestOfLove.Narrative.Tag,TheForestOfLove.Narrative.Dialogue,TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry)
IL_01de: ldloca.s V_14
IL_01e0: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_01e5: brtrue.s IL_01c9
IL_01e7: leave.s IL_01f7
IL_01e9: ldloca.s V_14
IL_01eb: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_01f1: callvirt System.Void System.IDisposable::Dispose()
IL_01f6: endfinally
IL_01f7: ldloc.s V_13
IL_01f9: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_01fe: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetGiftDialoguesByPrimaryActor(System.String)
IL_0203: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0208: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_020d: stloc.s V_14
IL_020f: br.s IL_0226
IL_0211: ldloca.s V_14
IL_0213: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0218: stloc.s V_18
IL_021a: ldloc.s V_10
IL_021c: ldloc.s V_11
IL_021e: ldloc.s V_18
IL_0220: ldloc.3
IL_0221: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_Dialogue_IncrementIfAnyTagMatches(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>,TheForestOfLove.Narrative.Tag,TheForestOfLove.Narrative.Dialogue,TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry)
IL_0226: ldloca.s V_14
IL_0228: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_022d: brtrue.s IL_0211
IL_022f: leave.s IL_023f
IL_0231: ldloca.s V_14
IL_0233: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0239: callvirt System.Void System.IDisposable::Dispose()
IL_023e: endfinally
IL_023f: ldloc.s V_13
IL_0241: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0246: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetManualDialoguesByPrimaryActor(System.String)
IL_024b: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0250: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0255: stloc.s V_14
IL_0257: br.s IL_026f
IL_0259: ldloca.s V_14
IL_025b: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0260: stloc.s V_19
IL_0262: ldloc.s V_10
IL_0264: ldloc.s V_11
IL_0266: ldloc.s V_19
IL_0268: ldloc.s V_4
IL_026a: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_Dialogue_IncrementIfAnyTagMatches(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>,TheForestOfLove.Narrative.Tag,TheForestOfLove.Narrative.Dialogue,TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry)
IL_026f: ldloca.s V_14
IL_0271: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0276: brtrue.s IL_0259
IL_0278: leave.s IL_0288
IL_027a: ldloca.s V_14
IL_027c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0282: callvirt System.Void System.IDisposable::Dispose()
IL_0287: endfinally
IL_0288: ldloc.s V_13
IL_028a: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_028f: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetFinalIdleDialoguesByPrimaryActor(System.String)
IL_0294: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0299: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_029e: stloc.s V_14
IL_02a0: br.s IL_02b8
IL_02a2: ldloca.s V_14
IL_02a4: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_02a9: stloc.s V_20
IL_02ab: ldloc.s V_10
IL_02ad: ldloc.s V_11
IL_02af: ldloc.s V_20
IL_02b1: ldloc.s V_5
IL_02b3: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_Dialogue_IncrementIfAnyTagMatches(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>,TheForestOfLove.Narrative.Tag,TheForestOfLove.Narrative.Dialogue,TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry)
IL_02b8: ldloca.s V_14
IL_02ba: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_02bf: brtrue.s IL_02a2
IL_02c1: leave.s IL_02d1
IL_02c3: ldloca.s V_14
IL_02c5: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_02cb: callvirt System.Void System.IDisposable::Dispose()
IL_02d0: endfinally
IL_02d1: ldloc.s V_13
IL_02d3: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_02d8: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetQuestionIdleDialoguesByPrimaryActor(System.String)
IL_02dd: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_02e2: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_02e7: stloc.s V_14
IL_02e9: br.s IL_0301
IL_02eb: ldloca.s V_14
IL_02ed: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_02f2: stloc.s V_21
IL_02f4: ldloc.s V_10
IL_02f6: ldloc.s V_11
IL_02f8: ldloc.s V_21
IL_02fa: ldloc.s V_6
IL_02fc: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_Dialogue_IncrementIfAnyTagMatches(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>,TheForestOfLove.Narrative.Tag,TheForestOfLove.Narrative.Dialogue,TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry)
IL_0301: ldloca.s V_14
IL_0303: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0308: brtrue.s IL_02eb
IL_030a: leave.s IL_031a
IL_030c: ldloca.s V_14
IL_030e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0314: callvirt System.Void System.IDisposable::Dispose()
IL_0319: endfinally
IL_031a: ldloc.s V_12
IL_031c: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0321: brtrue IL_010b
IL_0326: leave.s IL_0334
IL_0328: ldloc.s V_12
IL_032a: brfalse.s IL_0333
IL_032c: ldloc.s V_12
IL_032e: callvirt System.Void System.IDisposable::Dispose()
IL_0333: endfinally
IL_0334: ldarg.2
IL_0335: ldc.i4.0
IL_0336: ble.s IL_0346
IL_0338: ldarg.1
IL_0339: ldloc.s V_7
IL_033b: ldloc.s V_9
IL_033d: ldloc.s V_8
IL_033f: ldarg.2
IL_0340: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::PrintUnplayed(TheForestOfLove.Narrative.Actor,System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>,System.Collections.Generic.List`1<System.String>,System.String,System.Int32)
IL_0345: ret
IL_0346: ldarg.1
IL_0347: ldloc.s V_7
IL_0349: ldloc.s V_8
IL_034b: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::PrintStats(TheForestOfLove.Narrative.Actor,System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>,System.String)
IL_0350: ret
METHOD System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_GenerateTags(System.Collections.Generic.List`1<System.String>,System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor()
IL_0005: stloc.0
IL_0006: ldstr "Main"
IL_000b: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_0010: stloc.1
IL_0011: ldstr "Main Act 1"
IL_0016: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_001b: stloc.2
IL_001c: ldstr "Main Act 2"
IL_0021: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_0026: stloc.3
IL_0027: ldstr "Main Act 3"
IL_002c: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_0031: stloc.s V_4
IL_0033: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor()
IL_0038: dup
IL_0039: ldloc.1
IL_003a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_003f: dup
IL_0040: ldloc.2
IL_0041: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0046: dup
IL_0047: ldloc.3
IL_0048: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_004d: dup
IL_004e: ldloc.s V_4
IL_0050: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0055: stloc.s V_5
IL_0057: ldloc.0
IL_0058: ldloc.s V_5
IL_005a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_005f: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor()
IL_0064: dup
IL_0065: ldstr "Instanced Event Booty Lineup Males"
IL_006a: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_006f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0074: dup
IL_0075: ldstr "Instanced Event Booty Lineup Females"
IL_007a: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_007f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0084: dup
IL_0085: ldstr "Instanced Event Blessing of the Bells"
IL_008a: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_008f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0094: dup
IL_0095: ldstr "Instanced Event Maverick Side Hustle"
IL_009a: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_009f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_00a4: dup
IL_00a5: ldstr "Instanced Event Seasons Greetings"
IL_00aa: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_00af: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_00b4: dup
IL_00b5: ldstr "Instanced Event Vslice"
IL_00ba: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_00bf: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_00c4: stloc.s V_6
IL_00c6: ldarg.0
IL_00c7: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_00cc: stloc.s V_7
IL_00ce: br IL_01c9
IL_00d3: ldloca.s V_7
IL_00d5: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_00da: stloc.s V_8
IL_00dc: ldloc.s V_8
IL_00de: brfalse IL_01c9
IL_00e3: ldloc.s V_8
IL_00e5: ldstr "act1"
IL_00ea: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00ef: brtrue.s IL_013c
IL_00f1: ldloc.s V_8
IL_00f3: ldstr "act2"
IL_00f8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00fd: brtrue.s IL_0152
IL_00ff: ldloc.s V_8
IL_0101: ldstr "act3"
IL_0106: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_010b: brtrue.s IL_0168
IL_010d: ldloc.s V_8
IL_010f: ldstr "nonlinear"
IL_0114: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0119: brtrue.s IL_017f
IL_011b: ldloc.s V_8
IL_011d: ldstr "adventure"
IL_0122: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0127: brtrue.s IL_0195
IL_0129: ldloc.s V_8
IL_012b: ldstr "all"
IL_0130: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0135: brtrue.s IL_01ac
IL_0137: br IL_01c9
IL_013c: ldloc.0
IL_013d: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Clear()
IL_0142: ldloc.0
IL_0143: ldloc.2
IL_0144: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0149: ldarg.1
IL_014a: ldstr "in Act 1"
IL_014f: stind.ref
IL_0150: br.s IL_01c9
IL_0152: ldloc.0
IL_0153: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Clear()
IL_0158: ldloc.0
IL_0159: ldloc.3
IL_015a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_015f: ldarg.1
IL_0160: ldstr "in Act 2"
IL_0165: stind.ref
IL_0166: br.s IL_01c9
IL_0168: ldloc.0
IL_0169: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Clear()
IL_016e: ldloc.0
IL_016f: ldloc.s V_4
IL_0171: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0176: ldarg.1
IL_0177: ldstr "in Act 3"
IL_017c: stind.ref
IL_017d: br.s IL_01c9
IL_017f: ldloc.0
IL_0180: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Clear()
IL_0185: ldloc.0
IL_0186: ldloc.1
IL_0187: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_018c: ldarg.1
IL_018d: ldstr "in nonlinear"
IL_0192: stind.ref
IL_0193: br.s IL_01c9
IL_0195: ldloc.0
IL_0196: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Clear()
IL_019b: ldloc.0
IL_019c: ldloc.s V_6
IL_019e: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_01a3: ldarg.1
IL_01a4: ldstr "in adventures"
IL_01a9: stind.ref
IL_01aa: br.s IL_01c9
IL_01ac: ldloc.0
IL_01ad: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Clear()
IL_01b2: ldloc.0
IL_01b3: ldloc.s V_5
IL_01b5: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_01ba: ldloc.0
IL_01bb: ldloc.s V_6
IL_01bd: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_01c2: ldarg.1
IL_01c3: ldstr "in all"
IL_01c8: stind.ref
IL_01c9: ldloca.s V_7
IL_01cb: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_01d0: brtrue IL_00d3
IL_01d5: leave.s IL_01e5
IL_01d7: ldloca.s V_7
IL_01d9: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_01df: callvirt System.Void System.IDisposable::Dispose()
IL_01e4: endfinally
IL_01e5: ldloc.0
IL_01e6: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::PrintUnplayed(TheForestOfLove.Narrative.Actor,System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>,System.Collections.Generic.List`1<System.String>,System.String,System.Int32) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldsfld System.String System.String::Empty
IL_0005: stloc.0
IL_0006: ldarg.1
IL_0007: ldarg.2
IL_0008: ldloca.s V_0
IL_000a: call System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry> TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_FilterDialogueTypes(System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>,System.Collections.Generic.List`1<System.String>,System.String&)
IL_000f: starg.s dialogueStats
IL_0011: ldloca.s V_1
IL_0013: initobj SickDev.DevConsole.EntryOptions
IL_0019: ldloca.s V_2
IL_001b: initobj SickDev.DevConsole.EntryOptions
IL_0021: ldloca.s V_1
IL_0023: ldc.r4 0.2509804
IL_0028: ldc.r4 0.5647059
IL_002d: ldc.r4 0.2509804
IL_0032: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0037: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_003c: ldloca.s V_2
IL_003e: ldc.r4 0.2509804
IL_0043: ldc.r4 0.76862746
IL_0048: ldc.r4 0.2509804
IL_004d: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0052: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0057: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_005c: ldstr "Stats for {0}{1}{2}"
IL_0061: ldarg.0
IL_0062: brtrue.s IL_006b
IL_0064: ldstr "All Actors"
IL_0069: br.s IL_0071
IL_006b: ldarg.0
IL_006c: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0071: ldarg.3
IL_0072: callvirt System.Int32 System.String::get_Length()
IL_0077: ldc.i4.0
IL_0078: bgt.s IL_0081
IL_007a: ldsfld System.String System.String::Empty
IL_007f: br.s IL_008c
IL_0081: ldstr " "
IL_0086: ldarg.3
IL_0087: call System.String System.String::Concat(System.String,System.String)
IL_008c: ldloc.0
IL_008d: callvirt System.Int32 System.String::get_Length()
IL_0092: ldc.i4.0
IL_0093: bgt.s IL_009c
IL_0095: ldsfld System.String System.String::Empty
IL_009a: br.s IL_00a7
IL_009c: ldstr " "
IL_00a1: ldloc.0
IL_00a2: call System.String System.String::Concat(System.String,System.String)
IL_00a7: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_00ac: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_00b1: ldc.i4.0
IL_00b2: stloc.3
IL_00b3: ldarg.1
IL_00b4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::GetEnumerator()
IL_00b9: stloc.s V_4
IL_00bb: br.s IL_012b
IL_00bd: ldloca.s V_4
IL_00bf: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::get_Current()
IL_00c4: stloc.s V_5
IL_00c6: ldloc.s V_5
IL_00c8: callvirt System.Int32 TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::get_total()
IL_00cd: brfalse.s IL_012b
IL_00cf: ldloc.s V_5
IL_00d1: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::notCompleted
IL_00d6: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_00db: stloc.s V_6
IL_00dd: br.s IL_0112
IL_00df: ldloca.s V_6
IL_00e1: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_00e6: stloc.s V_7
IL_00e8: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00ed: ldloc.s V_7
IL_00ef: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00f4: ldloc.3
IL_00f5: dup
IL_00f6: ldc.i4.1
IL_00f7: add
IL_00f8: stloc.3
IL_00f9: ldc.i4.2
IL_00fa: rem
IL_00fb: brfalse.s IL_0100
IL_00fd: ldloc.2
IL_00fe: br.s IL_0101
IL_0100: ldloc.1
IL_0101: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0106: ldarg.s remainingPrintUnplayed
IL_0108: ldc.i4.1
IL_0109: sub
IL_010a: dup
IL_010b: starg.s remainingPrintUnplayed
IL_010d: ldc.i4.0
IL_010e: bgt.s IL_0112
IL_0110: leave.s IL_0144
IL_0112: ldloca.s V_6
IL_0114: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0119: brtrue.s IL_00df
IL_011b: leave.s IL_012b
IL_011d: ldloca.s V_6
IL_011f: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0125: callvirt System.Void System.IDisposable::Dispose()
IL_012a: endfinally
IL_012b: ldloca.s V_4
IL_012d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::MoveNext()
IL_0132: brtrue.s IL_00bd
IL_0134: leave.s IL_0144
IL_0136: ldloca.s V_4
IL_0138: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>
IL_013e: callvirt System.Void System.IDisposable::Dispose()
IL_0143: endfinally
IL_0144: ret
METHOD System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry> TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_FilterDialogueTypes(System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>,System.Collections.Generic.List`1<System.String>,System.String&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::.ctor()
IL_0005: stloc.0
IL_0006: ldc.i4.0
IL_0007: stloc.1
IL_0008: ldarg.1
IL_0009: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_000e: stloc.2
IL_000f: br IL_00a0
IL_0014: ldloca.s V_2
IL_0016: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_001b: stloc.3
IL_001c: ldloc.3
IL_001d: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0022: brtrue.s IL_00a0
IL_0024: ldloc.3
IL_0025: callvirt System.String System.String::Trim()
IL_002a: callvirt System.Int32 System.String::get_Length()
IL_002f: ldc.i4.3
IL_0030: blt.s IL_00a0
IL_0032: ldarg.0
IL_0033: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::GetEnumerator()
IL_0038: stloc.s V_4
IL_003a: br.s IL_0087
IL_003c: ldloca.s V_4
IL_003e: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::get_Current()
IL_0043: stloc.s V_5
IL_0045: ldloc.s V_5
IL_0047: ldfld System.String TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::typeName
IL_004c: callvirt System.String System.String::ToLower()
IL_0051: ldloc.3
IL_0052: callvirt System.String System.String::ToLower()
IL_0057: callvirt System.Boolean System.String::Contains(System.String)
IL_005c: brfalse.s IL_0087
IL_005e: ldloc.0
IL_005f: ldloc.s V_5
IL_0061: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::Contains(!0)
IL_0066: brtrue.s IL_0087
IL_0068: ldarg.2
IL_0069: ldstr "{0} & type {1}"
IL_006e: ldarg.2
IL_006f: ldind.ref
IL_0070: ldloc.s V_5
IL_0072: ldfld System.String TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::typeName
IL_0077: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_007c: stind.ref
IL_007d: ldloc.0
IL_007e: ldloc.s V_5
IL_0080: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::Add(!0)
IL_0085: ldc.i4.1
IL_0086: stloc.1
IL_0087: ldloca.s V_4
IL_0089: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::MoveNext()
IL_008e: brtrue.s IL_003c
IL_0090: leave.s IL_00a0
IL_0092: ldloca.s V_4
IL_0094: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>
IL_009a: callvirt System.Void System.IDisposable::Dispose()
IL_009f: endfinally
IL_00a0: ldloca.s V_2
IL_00a2: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_00a7: brtrue IL_0014
IL_00ac: leave.s IL_00bc
IL_00ae: ldloca.s V_2
IL_00b0: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_00b6: callvirt System.Void System.IDisposable::Dispose()
IL_00bb: endfinally
IL_00bc: ldloc.1
IL_00bd: brtrue.s IL_00c1
IL_00bf: ldarg.0
IL_00c0: ret
IL_00c1: ldloc.0
IL_00c2: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::PrintStats(TheForestOfLove.Narrative.Actor,System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>,System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldloca.s V_0
IL_0002: initobj SickDev.DevConsole.EntryOptions
IL_0008: ldloca.s V_1
IL_000a: initobj SickDev.DevConsole.EntryOptions
IL_0010: ldloca.s V_0
IL_0012: ldc.r4 0.2509804
IL_0017: ldc.r4 0.5647059
IL_001c: ldc.r4 0.2509804
IL_0021: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0026: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_002b: ldloca.s V_1
IL_002d: ldc.r4 0.2509804
IL_0032: ldc.r4 0.76862746
IL_0037: ldc.r4 0.2509804
IL_003c: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0041: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0046: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_004b: ldstr "Stats for {0} {1}"
IL_0050: ldarg.0
IL_0051: brtrue.s IL_005a
IL_0053: ldstr "All Actors"
IL_0058: br.s IL_0060
IL_005a: ldarg.0
IL_005b: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0060: ldarg.2
IL_0061: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0066: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_006b: ldc.i4.0
IL_006c: stloc.2
IL_006d: ldc.i4.0
IL_006e: stloc.3
IL_006f: br.s IL_00e9
IL_0071: ldarg.1
IL_0072: ldloc.3
IL_0073: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::get_Item(System.Int32)
IL_0078: callvirt System.Int32 TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::get_total()
IL_007d: brfalse.s IL_00e5
IL_007f: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0084: ldstr "{0} / {1} {2}"
IL_0089: ldarg.1
IL_008a: ldloc.3
IL_008b: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::get_Item(System.Int32)
IL_0090: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::completed
IL_0095: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::get_Count()
IL_009a: ldarg.1
IL_009b: ldloc.3
IL_009c: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::get_Item(System.Int32)
IL_00a1: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::invalidated
IL_00a6: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::get_Count()
IL_00ab: add
IL_00ac: box System.Int32
IL_00b1: ldarg.1
IL_00b2: ldloc.3
IL_00b3: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::get_Item(System.Int32)
IL_00b8: callvirt System.Int32 TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::get_total()
IL_00bd: box System.Int32
IL_00c2: ldarg.1
IL_00c3: ldloc.3
IL_00c4: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::get_Item(System.Int32)
IL_00c9: ldfld System.String TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry::typeName
IL_00ce: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_00d3: ldloc.2
IL_00d4: dup
IL_00d5: ldc.i4.1
IL_00d6: add
IL_00d7: stloc.2
IL_00d8: ldc.i4.2
IL_00d9: rem
IL_00da: brfalse.s IL_00df
IL_00dc: ldloc.1
IL_00dd: br.s IL_00e0
IL_00df: ldloc.0
IL_00e0: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_00e5: ldloc.3
IL_00e6: ldc.i4.1
IL_00e7: add
IL_00e8: stloc.3
IL_00e9: ldloc.3
IL_00ea: ldarg.1
IL_00eb: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/StatsCommands/StatEntry>::get_Count()
IL_00f0: blt IL_0071
IL_00f5: ret
