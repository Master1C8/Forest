TYPE TheForestOfLove.QuestLog
METHOD System.Void TheForestOfLove.QuestLog::GenerateLogTextHistory(TheForestOfLove.Narrative.Quest,System.String&,System.String&,System.String&) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlocksClosestUnlockedChildByUnlockedRoot
IL_0005: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry>::Clear()
IL_000a: ldsfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlockedRootsSortedByPriority
IL_000f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::Clear()
IL_0014: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.QuestLog::questProgressLogUnlocksFiltered
IL_0019: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_001e: ldarg.0
IL_001f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.Quest::progressLogEntries
IL_0024: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::GetEnumerator()
IL_0029: stloc.0
IL_002a: br IL_00cc
IL_002f: ldloca.s V_0
IL_0031: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Current()
IL_0036: stloc.1
IL_0037: ldloc.1
IL_0038: callvirt TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Narrative.QuestProgressLogEntry::GetRootUnlockedProgressLogRecursive()
IL_003d: stloc.2
IL_003e: ldloc.2
IL_003f: brfalse IL_00cc
IL_0044: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlocksClosestUnlockedChildByUnlockedRoot
IL_0049: ldloc.1
IL_004a: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry>::ContainsKey(!0)
IL_004f: brtrue.s IL_006a
IL_0051: ldsfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlockedRootsSortedByPriority
IL_0056: ldloc.2
IL_0057: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::Add(!0)
IL_005c: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlocksClosestUnlockedChildByUnlockedRoot
IL_0061: ldloc.2
IL_0062: ldloc.1
IL_0063: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry>::Add(!0,!1)
IL_0068: br.s IL_00cc
IL_006a: ldloc.1
IL_006b: ldfld System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_0070: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlocksClosestUnlockedChildByUnlockedRoot
IL_0075: ldloc.2
IL_0076: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Item(!0)
IL_007b: ldfld System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_0080: bge.s IL_0090
IL_0082: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlocksClosestUnlockedChildByUnlockedRoot
IL_0087: ldloc.2
IL_0088: ldloc.1
IL_0089: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry>::set_Item(!0,!1)
IL_008e: br.s IL_00cc
IL_0090: ldloc.1
IL_0091: ldfld System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_0096: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlocksClosestUnlockedChildByUnlockedRoot
IL_009b: ldloc.2
IL_009c: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Item(!0)
IL_00a1: ldfld System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_00a6: bne.un.s IL_00cc
IL_00a8: ldloc.1
IL_00a9: callvirt System.Single TheForestOfLove.Narrative.QuestProgressLogEntry::get_UnlockedGameplayTime()
IL_00ae: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlocksClosestUnlockedChildByUnlockedRoot
IL_00b3: ldloc.2
IL_00b4: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Item(!0)
IL_00b9: callvirt System.Single TheForestOfLove.Narrative.QuestProgressLogEntry::get_UnlockedGameplayTime()
IL_00be: ble.un.s IL_00cc
IL_00c0: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlocksClosestUnlockedChildByUnlockedRoot
IL_00c5: ldloc.2
IL_00c6: ldloc.1
IL_00c7: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry>::set_Item(!0,!1)
IL_00cc: ldloca.s V_0
IL_00ce: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>::MoveNext()
IL_00d3: brtrue IL_002f
IL_00d8: leave.s IL_00e8
IL_00da: ldloca.s V_0
IL_00dc: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>
IL_00e2: callvirt System.Void System.IDisposable::Dispose()
IL_00e7: endfinally
IL_00e8: ldsfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlockedRootsSortedByPriority
IL_00ed: ldsfld System.Comparison`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog/<>c::<>9__44_0
IL_00f2: dup
IL_00f3: brtrue.s IL_010c
IL_00f5: pop
IL_00f6: ldsfld TheForestOfLove.QuestLog/<>c TheForestOfLove.QuestLog/<>c::<>9
IL_00fb: ldftn System.Int32 TheForestOfLove.QuestLog/<>c::<GenerateLogTextHistory>b__44_0(TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_0101: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::.ctor(System.Object,System.IntPtr)
IL_0106: dup
IL_0107: stsfld System.Comparison`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog/<>c::<>9__44_0
IL_010c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::Sort(System.Comparison`1<!0>)
IL_0111: ldsfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlockedRootsSortedByPriority
IL_0116: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::GetEnumerator()
IL_011b: stloc.0
IL_011c: br.s IL_0140
IL_011e: ldloca.s V_0
IL_0120: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Current()
IL_0125: stloc.3
IL_0126: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.QuestLog::questProgressLogUnlocksFiltered
IL_012b: ldsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.QuestLog::questProgressLogUnlocksClosestUnlockedChildByUnlockedRoot
IL_0130: ldloc.3
IL_0131: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestProgressLogEntry,TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Item(!0)
IL_0136: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_013b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0140: ldloca.s V_0
IL_0142: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>::MoveNext()
IL_0147: brtrue.s IL_011e
IL_0149: leave.s IL_0159
IL_014b: ldloca.s V_0
IL_014d: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>
IL_0153: callvirt System.Void System.IDisposable::Dispose()
IL_0158: endfinally
IL_0159: ldarg.3
IL_015a: ldnull
IL_015b: stind.ref
IL_015c: ldarg.2
IL_015d: ldnull
IL_015e: stind.ref
IL_015f: ldarg.1
IL_0160: ldnull
IL_0161: stind.ref
IL_0162: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.QuestLog::questProgressLogUnlocksFiltered
IL_0167: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_016c: ldc.i4.0
IL_016d: ble.s IL_01e8
IL_016f: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.QuestLog::questProgressLogUnlocksFiltered
IL_0174: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0179: ldc.i4.1
IL_017a: sub
IL_017b: stloc.s V_4
IL_017d: br.s IL_01e3
IL_017f: ldloc.s V_4
IL_0181: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.QuestLog::questProgressLogUnlocksFiltered
IL_0186: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_018b: ldc.i4.1
IL_018c: sub
IL_018d: bne.un.s IL_019f
IL_018f: ldarg.1
IL_0190: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.QuestLog::questProgressLogUnlocksFiltered
IL_0195: ldloc.s V_4
IL_0197: callvirt !0 System.Collections.Generic.List`1<System.String>::get_Item(System.Int32)
IL_019c: stind.ref
IL_019d: br.s IL_01dd
IL_019f: ldloc.s V_4
IL_01a1: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.QuestLog::questProgressLogUnlocksFiltered
IL_01a6: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_01ab: ldc.i4.2
IL_01ac: sub
IL_01ad: bne.un.s IL_01bf
IL_01af: ldarg.2
IL_01b0: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.QuestLog::questProgressLogUnlocksFiltered
IL_01b5: ldloc.s V_4
IL_01b7: callvirt !0 System.Collections.Generic.List`1<System.String>::get_Item(System.Int32)
IL_01bc: stind.ref
IL_01bd: br.s IL_01dd
IL_01bf: ldloc.s V_4
IL_01c1: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.QuestLog::questProgressLogUnlocksFiltered
IL_01c6: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_01cb: ldc.i4.3
IL_01cc: sub
IL_01cd: bne.un.s IL_01e8
IL_01cf: ldarg.3
IL_01d0: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.QuestLog::questProgressLogUnlocksFiltered
IL_01d5: ldloc.s V_4
IL_01d7: callvirt !0 System.Collections.Generic.List`1<System.String>::get_Item(System.Int32)
IL_01dc: stind.ref
IL_01dd: ldloc.s V_4
IL_01df: ldc.i4.1
IL_01e0: sub
IL_01e1: stloc.s V_4
IL_01e3: ldloc.s V_4
IL_01e5: ldc.i4.0
IL_01e6: bge.s IL_017f
IL_01e8: ret
