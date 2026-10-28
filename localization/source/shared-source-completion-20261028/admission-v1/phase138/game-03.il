TYPE TheForestOfLove.DevConsoleCommands/QuestCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::List() | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldc.i4.s 10
IL_0002: stloc.0
IL_0003: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Services.Persistence.DataService::GetQuests()
IL_0008: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_000d: ldc.i4.m1
IL_000e: stloc.1
IL_000f: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::.ctor()
IL_0014: stloc.2
IL_0015: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::GetEnumerator()
IL_001a: stloc.s V_5
IL_001c: br.s IL_0040
IL_001e: ldloca.s V_5
IL_0020: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::get_Current()
IL_0025: stloc.s V_6
IL_0027: ldloc.1
IL_0028: ldc.i4.1
IL_0029: add
IL_002a: stloc.1
IL_002b: ldloc.2
IL_002c: ldloc.s V_6
IL_002e: ldloc.1
IL_002f: ldloc.s V_6
IL_0031: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0036: newobj System.Void TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>::.ctor(T,System.Int32,System.String)
IL_003b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::Add(!0)
IL_0040: ldloca.s V_5
IL_0042: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::MoveNext()
IL_0047: brtrue.s IL_001e
IL_0049: leave.s IL_0059
IL_004b: ldloca.s V_5
IL_004d: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>
IL_0053: callvirt System.Void System.IDisposable::Dispose()
IL_0058: endfinally
IL_0059: ldloca.s V_3
IL_005b: initobj SickDev.DevConsole.EntryOptions
IL_0061: ldloca.s V_4
IL_0063: initobj SickDev.DevConsole.EntryOptions
IL_0069: ldloca.s V_3
IL_006b: ldc.r4 0.2509804
IL_0070: ldc.r4 0.5647059
IL_0075: ldc.r4 0.2509804
IL_007a: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_007f: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0084: ldloca.s V_4
IL_0086: ldc.r4 0.2509804
IL_008b: ldc.r4 0.76862746
IL_0090: ldc.r4 0.2509804
IL_0095: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_009a: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_009f: ldc.i4.0
IL_00a0: stloc.s V_7
IL_00a2: br IL_012c
IL_00a7: ldloc.2
IL_00a8: ldloc.s V_7
IL_00aa: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::get_Item(System.Int32)
IL_00af: stloc.s V_8
IL_00b1: ldstr "{0,-5}"
IL_00b6: ldloc.s V_8
IL_00b8: ldfld System.Int32 TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>::id
IL_00bd: box System.Int32
IL_00c2: call System.String System.String::Format(System.String,System.Object)
IL_00c7: stloc.s V_9
IL_00c9: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00ce: ldstr "({0}) {1} {2} ({3})"
IL_00d3: ldc.i4.4
IL_00d4: newarr System.Object
IL_00d9: dup
IL_00da: ldc.i4.0
IL_00db: ldloc.s V_8
IL_00dd: callvirt System.Single TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::get_Priority()
IL_00e2: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_00e7: conv.i4
IL_00e8: box System.Int32
IL_00ed: stelem.ref
IL_00ee: dup
IL_00ef: ldc.i4.1
IL_00f0: ldloc.s V_9
IL_00f2: stelem.ref
IL_00f3: dup
IL_00f4: ldc.i4.2
IL_00f5: ldloc.s V_8
IL_00f7: ldfld System.String TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>::title
IL_00fc: stelem.ref
IL_00fd: dup
IL_00fe: ldc.i4.3
IL_00ff: ldloc.s V_8
IL_0101: ldfld T TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>::item
IL_0106: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_010b: box TheForestOfLove.Narrative.QuestStatus
IL_0110: stelem.ref
IL_0111: call System.String System.String::Format(System.String,System.Object[])
IL_0116: ldloc.s V_7
IL_0118: ldc.i4.2
IL_0119: rem
IL_011a: brfalse.s IL_0120
IL_011c: ldloc.s V_4
IL_011e: br.s IL_0121
IL_0120: ldloc.3
IL_0121: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0126: ldloc.s V_7
IL_0128: ldc.i4.1
IL_0129: add
IL_012a: stloc.s V_7
IL_012c: ldloc.s V_7
IL_012e: ldloc.0
IL_012f: bge.s IL_013e
IL_0131: ldloc.s V_7
IL_0133: ldloc.2
IL_0134: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::get_Count()
IL_0139: blt IL_00a7
IL_013e: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::Find(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldc.i4.s 10
IL_000b: stloc.0
IL_000c: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Services.Persistence.DataService::GetQuests()
IL_0011: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0016: stloc.1
IL_0017: ldc.i4.m1
IL_0018: stloc.2
IL_0019: ldarg.0
IL_001a: callvirt System.String System.String::ToLower()
IL_001f: starg.s searchQuery
IL_0021: ldarg.0
IL_0022: ldc.i4.1
IL_0023: newarr System.Char
IL_0028: dup
IL_0029: ldc.i4.0
IL_002a: ldc.i4.s 32
IL_002c: stelem.i2
IL_002d: callvirt System.String[] System.String::Split(System.Char[])
IL_0032: stloc.3
IL_0033: ldloc.1
IL_0034: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::get_Count()
IL_0039: newobj System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::.ctor(System.Int32)
IL_003e: stloc.s V_5
IL_0040: ldloc.1
IL_0041: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::GetEnumerator()
IL_0046: stloc.s V_9
IL_0048: br IL_0101
IL_004d: ldloca.s V_9
IL_004f: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::get_Current()
IL_0054: stloc.s V_10
IL_0056: ldloc.2
IL_0057: ldc.i4.1
IL_0058: add
IL_0059: stloc.2
IL_005a: ldc.i4.0
IL_005b: stloc.s V_4
IL_005d: ldloc.s V_10
IL_005f: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0064: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0069: brtrue IL_0101
IL_006e: ldloc.s V_10
IL_0070: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0075: callvirt System.String System.String::ToLower()
IL_007a: stloc.s V_11
IL_007c: ldloc.3
IL_007d: stloc.s V_12
IL_007f: ldc.i4.0
IL_0080: stloc.s V_13
IL_0082: br.s IL_00e5
IL_0084: ldloc.s V_12
IL_0086: ldloc.s V_13
IL_0088: ldelem.ref
IL_0089: stloc.s V_14
IL_008b: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.DevConsoleCommands/QuestCommands::tokensToCountOnce
IL_0090: ldloc.s V_14
IL_0092: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_0097: brfalse.s IL_00af
IL_0099: ldloc.s V_4
IL_009b: ldloc.s V_11
IL_009d: ldloc.s V_14
IL_009f: callvirt System.Boolean System.String::Contains(System.String)
IL_00a4: brtrue.s IL_00a9
IL_00a6: ldc.i4.0
IL_00a7: br.s IL_00aa
IL_00a9: ldc.i4.1
IL_00aa: sub
IL_00ab: stloc.s V_4
IL_00ad: br.s IL_00df
IL_00af: ldloc.s V_11
IL_00b1: stloc.s V_15
IL_00b3: ldloc.s V_15
IL_00b5: callvirt System.Int32 System.String::get_Length()
IL_00ba: ldloc.s V_15
IL_00bc: ldloc.s V_14
IL_00be: ldsfld System.String System.String::Empty
IL_00c3: callvirt System.String System.String::Replace(System.String,System.String)
IL_00c8: callvirt System.Int32 System.String::get_Length()
IL_00cd: sub
IL_00ce: ldloc.s V_14
IL_00d0: callvirt System.Int32 System.String::get_Length()
IL_00d5: div
IL_00d6: stloc.s V_16
IL_00d8: ldloc.s V_4
IL_00da: ldloc.s V_16
IL_00dc: sub
IL_00dd: stloc.s V_4
IL_00df: ldloc.s V_13
IL_00e1: ldc.i4.1
IL_00e2: add
IL_00e3: stloc.s V_13
IL_00e5: ldloc.s V_13
IL_00e7: ldloc.s V_12
IL_00e9: ldlen
IL_00ea: conv.i4
IL_00eb: blt.s IL_0084
IL_00ed: ldloc.s V_5
IL_00ef: ldloc.s V_10
IL_00f1: ldloc.2
IL_00f2: ldloc.s V_11
IL_00f4: newobj System.Void TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>::.ctor(T,System.Int32,System.String)
IL_00f9: ldloc.s V_4
IL_00fb: conv.r4
IL_00fc: callvirt System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::Enqueue(T,System.Single)
IL_0101: ldloca.s V_9
IL_0103: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::MoveNext()
IL_0108: brtrue IL_004d
IL_010d: leave.s IL_011d
IL_010f: ldloca.s V_9
IL_0111: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>
IL_0117: callvirt System.Void System.IDisposable::Dispose()
IL_011c: endfinally
IL_011d: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0122: callvirt System.Void SickDev.DevConsole.DevConsole::ClearLog()
IL_0127: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_012c: ldsfld System.String System.String::Empty
IL_0131: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String)
IL_0136: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_013b: ldstr "top "
IL_0140: ldloca.s V_0
IL_0142: call System.String System.Int32::ToString()
IL_0147: ldstr " matching quests:"
IL_014c: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0151: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_0156: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::.ctor()
IL_015b: stloc.s V_6
IL_015d: br.s IL_016d
IL_015f: ldloc.s V_6
IL_0161: ldloc.s V_5
IL_0163: callvirt T TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::Dequeue()
IL_0168: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::Add(!0)
IL_016d: ldloc.s V_5
IL_016f: callvirt System.Int32 TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::get_Count()
IL_0174: ldc.i4.0
IL_0175: bgt.s IL_015f
IL_0177: ldloc.s V_6
IL_0179: ldsfld System.Comparison`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>> TheForestOfLove.DevConsoleCommands/QuestCommands/<>c::<>9__3_0
IL_017e: dup
IL_017f: brtrue.s IL_0198
IL_0181: pop
IL_0182: ldsfld TheForestOfLove.DevConsoleCommands/QuestCommands/<>c TheForestOfLove.DevConsoleCommands/QuestCommands/<>c::<>9
IL_0187: ldftn System.Int32 TheForestOfLove.DevConsoleCommands/QuestCommands/<>c::<Find>b__3_0(TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>,TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>)
IL_018d: newobj System.Void System.Comparison`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::.ctor(System.Object,System.IntPtr)
IL_0192: dup
IL_0193: stsfld System.Comparison`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>> TheForestOfLove.DevConsoleCommands/QuestCommands/<>c::<>9__3_0
IL_0198: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::Sort(System.Comparison`1<!0>)
IL_019d: ldloca.s V_7
IL_019f: initobj SickDev.DevConsole.EntryOptions
IL_01a5: ldloca.s V_8
IL_01a7: initobj SickDev.DevConsole.EntryOptions
IL_01ad: ldloca.s V_7
IL_01af: ldc.r4 0.2509804
IL_01b4: ldc.r4 0.5647059
IL_01b9: ldc.r4 0.2509804
IL_01be: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_01c3: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_01c8: ldloca.s V_8
IL_01ca: ldc.r4 0.2509804
IL_01cf: ldc.r4 0.76862746
IL_01d4: ldc.r4 0.2509804
IL_01d9: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_01de: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_01e3: ldc.i4.0
IL_01e4: stloc.s V_17
IL_01e6: br.s IL_025a
IL_01e8: ldloc.s V_6
IL_01ea: ldloc.s V_17
IL_01ec: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::get_Item(System.Int32)
IL_01f1: stloc.s V_18
IL_01f3: ldstr "{0,-5}"
IL_01f8: ldloc.s V_18
IL_01fa: ldfld System.Int32 TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>::id
IL_01ff: box System.Int32
IL_0204: call System.String System.String::Format(System.String,System.Object)
IL_0209: stloc.s V_19
IL_020b: ldloc.s V_18
IL_020d: callvirt System.Single TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::get_Priority()
IL_0212: ldc.r4 0
IL_0217: bge.s IL_0254
IL_0219: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_021e: ldstr "({0}) {1} {2}"
IL_0223: ldloc.s V_18
IL_0225: callvirt System.Single TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::get_Priority()
IL_022a: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_022f: conv.i4
IL_0230: box System.Int32
IL_0235: ldloc.s V_19
IL_0237: ldloc.s V_18
IL_0239: ldfld System.String TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>::title
IL_023e: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_0243: ldloc.s V_17
IL_0245: ldc.i4.2
IL_0246: rem
IL_0247: brfalse.s IL_024d
IL_0249: ldloc.s V_8
IL_024b: br.s IL_024f
IL_024d: ldloc.s V_7
IL_024f: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0254: ldloc.s V_17
IL_0256: ldc.i4.1
IL_0257: add
IL_0258: stloc.s V_17
IL_025a: ldloc.s V_17
IL_025c: ldloc.0
IL_025d: bge.s IL_026d
IL_025f: ldloc.s V_17
IL_0261: ldloc.s V_6
IL_0263: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/QuestCommands/QueueNode`1<TheForestOfLove.Narrative.Quest>>::get_Count()
IL_0268: blt IL_01e8
IL_026d: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::Info(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Quest TheForestOfLove.DevConsoleCommands/QuestCommands::GetQuestByMockId(System.Int32)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brtrue.s IL_0026
IL_000a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_000f: ldstr "could not find quest "
IL_0014: ldarga.s id
IL_0016: call System.String System.Int32::ToString()
IL_001b: call System.String System.String::Concat(System.String,System.String)
IL_0020: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0025: ret
IL_0026: ldloca.s V_1
IL_0028: initobj SickDev.DevConsole.EntryOptions
IL_002e: ldloca.s V_2
IL_0030: initobj SickDev.DevConsole.EntryOptions
IL_0036: ldloca.s V_1
IL_0038: ldc.r4 0.2509804
IL_003d: ldc.r4 0.5647059
IL_0042: ldc.r4 0.2509804
IL_0047: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_004c: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0051: ldloca.s V_2
IL_0053: ldc.r4 0.2509804
IL_0058: ldc.r4 0.76862746
IL_005d: ldc.r4 0.2509804
IL_0062: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0067: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_006c: ldc.i4.0
IL_006d: stloc.3
IL_006e: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0073: ldsfld System.String System.String::Empty
IL_0078: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String)
IL_007d: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0082: ldstr "info for quest "
IL_0087: ldarga.s id
IL_0089: call System.String System.Int32::ToString()
IL_008e: ldstr " - "
IL_0093: ldloc.0
IL_0094: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0099: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_009e: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_00a3: ldstr "    "
IL_00a8: stloc.s V_4
IL_00aa: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00af: ldstr "{0}{1}"
IL_00b4: ldloc.s V_4
IL_00b6: ldstr "status: {0}"
IL_00bb: ldloc.0
IL_00bc: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_00c1: box TheForestOfLove.Narrative.QuestStatus
IL_00c6: call System.String System.String::Format(System.String,System.Object)
IL_00cb: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_00d0: ldloc.3
IL_00d1: ldc.i4.2
IL_00d2: rem
IL_00d3: brfalse.s IL_00d8
IL_00d5: ldloc.2
IL_00d6: br.s IL_00d9
IL_00d8: ldloc.1
IL_00d9: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_00de: ldloc.3
IL_00df: ldc.i4.1
IL_00e0: add
IL_00e1: stloc.3
IL_00e2: ldc.i4.0
IL_00e3: stloc.s V_5
IL_00e5: ldloc.0
IL_00e6: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.Quest::dialogues
IL_00eb: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_00f0: stloc.s V_6
IL_00f2: br.s IL_011f
IL_00f4: ldloca.s V_6
IL_00f6: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_00fb: stloc.s V_7
IL_00fd: ldloc.s V_7
IL_00ff: callvirt TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0104: ldc.i4 200
IL_0109: beq.s IL_0119
IL_010b: ldloc.s V_7
IL_010d: callvirt TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0112: ldc.i4 300
IL_0117: bne.un.s IL_011f
IL_0119: ldloc.s V_5
IL_011b: ldc.i4.1
IL_011c: add
IL_011d: stloc.s V_5
IL_011f: ldloca.s V_6
IL_0121: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0126: brtrue.s IL_00f4
IL_0128: leave.s IL_0138
IL_012a: ldloca.s V_6
IL_012c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0132: callvirt System.Void System.IDisposable::Dispose()
IL_0137: endfinally
IL_0138: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_013d: ldstr "{0}{1}"
IL_0142: ldloc.s V_4
IL_0144: ldstr "steps completed: {0} of {1}"
IL_0149: ldloc.s V_5
IL_014b: box System.Int32
IL_0150: ldloc.0
IL_0151: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.Quest::dialogues
IL_0156: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::get_Count()
IL_015b: box System.Int32
IL_0160: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0165: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_016a: ldloc.3
IL_016b: ldc.i4.2
IL_016c: rem
IL_016d: brfalse.s IL_0172
IL_016f: ldloc.2
IL_0170: br.s IL_0173
IL_0172: ldloc.1
IL_0173: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0178: ldloc.3
IL_0179: ldc.i4.1
IL_017a: add
IL_017b: stloc.3
IL_017c: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::Complete(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Quest TheForestOfLove.DevConsoleCommands/QuestCommands::GetQuestByMockId(System.Int32)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brtrue.s IL_0026
IL_000a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_000f: ldstr "could not find quest "
IL_0014: ldarga.s id
IL_0016: call System.String System.Int32::ToString()
IL_001b: call System.String System.String::Concat(System.String,System.String)
IL_0020: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0025: ret
IL_0026: ldc.i4.1
IL_0027: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_002c: ldloc.0
IL_002d: callvirt System.Void TheForestOfLove.Narrative.Quest::SetStatusCompleted()
IL_0032: ldc.i4.0
IL_0033: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0038: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_003d: ldstr "completed quest with id "
IL_0042: ldarga.s id
IL_0044: call System.String System.Int32::ToString()
IL_0049: call System.String System.String::Concat(System.String,System.String)
IL_004e: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_0053: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::Reset(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Quest TheForestOfLove.DevConsoleCommands/QuestCommands::GetQuestByMockId(System.Int32)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brtrue.s IL_0026
IL_000a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_000f: ldstr "could not find quest "
IL_0014: ldarga.s id
IL_0016: call System.String System.Int32::ToString()
IL_001b: call System.String System.String::Concat(System.String,System.String)
IL_0020: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0025: ret
IL_0026: ldc.i4.1
IL_0027: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_002c: ldloc.0
IL_002d: callvirt System.Void TheForestOfLove.Narrative.Quest::SetStatusDefault()
IL_0032: ldc.i4.0
IL_0033: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0038: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_003d: ldstr "reset quest with id "
IL_0042: ldarga.s id
IL_0044: call System.String System.Int32::ToString()
IL_0049: call System.String System.String::Concat(System.String,System.String)
IL_004e: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_0053: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "quest"
IL_000b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0010: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.DevConsoleCommands/QuestCommands::tokensToCountOnce
IL_0015: ret
