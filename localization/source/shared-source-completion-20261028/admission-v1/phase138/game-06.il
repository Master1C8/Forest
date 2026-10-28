TYPE TheForestOfLove.DevConsoleCommands/ChapterCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands/ChapterCommands::Search(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: callvirt System.String System.String::ToLower()
IL_000f: starg.s searchQuery
IL_0011: ldarg.0
IL_0012: ldc.i4.1
IL_0013: newarr System.Char
IL_0018: dup
IL_0019: ldc.i4.0
IL_001a: ldc.i4.s 32
IL_001c: stelem.i2
IL_001d: callvirt System.String[] System.String::Split(System.Char[])
IL_0022: stloc.0
IL_0023: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Services.Persistence.DataService::GetChapterRecords()
IL_0028: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_002d: dup
IL_002e: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::get_Count()
IL_0033: newobj System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode>::.ctor(System.Int32)
IL_0038: stloc.2
IL_0039: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_003e: stloc.s V_7
IL_0040: br IL_0107
IL_0045: ldloca.s V_7
IL_0047: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_004c: stloc.s V_8
IL_004e: ldc.i4.0
IL_004f: stloc.1
IL_0050: ldloc.s V_8
IL_0052: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::title
IL_0057: ldstr " "
IL_005c: ldloc.s V_8
IL_005e: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::description
IL_0063: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0068: stloc.s V_9
IL_006a: ldloc.s V_9
IL_006c: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0071: brtrue IL_0107
IL_0076: ldloc.s V_8
IL_0078: ldfld System.Boolean TheForestOfLove.Narrative.ChapterRecord::isHiddenInList
IL_007d: brtrue IL_0107
IL_0082: ldloc.s V_9
IL_0084: callvirt System.String System.String::ToLower()
IL_0089: stloc.s V_9
IL_008b: ldloc.0
IL_008c: stloc.s V_10
IL_008e: ldc.i4.0
IL_008f: stloc.s V_11
IL_0091: br.s IL_00f0
IL_0093: ldloc.s V_10
IL_0095: ldloc.s V_11
IL_0097: ldelem.ref
IL_0098: stloc.s V_12
IL_009a: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.DevConsoleCommands/ChapterCommands::tokensToCountOnce
IL_009f: ldloc.s V_12
IL_00a1: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_00a6: brfalse.s IL_00bc
IL_00a8: ldloc.1
IL_00a9: ldloc.s V_9
IL_00ab: ldloc.s V_12
IL_00ad: callvirt System.Boolean System.String::Contains(System.String)
IL_00b2: brtrue.s IL_00b7
IL_00b4: ldc.i4.0
IL_00b5: br.s IL_00b8
IL_00b7: ldc.i4.1
IL_00b8: sub
IL_00b9: stloc.1
IL_00ba: br.s IL_00ea
IL_00bc: ldloc.s V_9
IL_00be: stloc.s V_13
IL_00c0: ldloc.s V_13
IL_00c2: callvirt System.Int32 System.String::get_Length()
IL_00c7: ldloc.s V_13
IL_00c9: ldloc.s V_12
IL_00cb: ldsfld System.String System.String::Empty
IL_00d0: callvirt System.String System.String::Replace(System.String,System.String)
IL_00d5: callvirt System.Int32 System.String::get_Length()
IL_00da: sub
IL_00db: ldloc.s V_12
IL_00dd: callvirt System.Int32 System.String::get_Length()
IL_00e2: div
IL_00e3: stloc.s V_14
IL_00e5: ldloc.1
IL_00e6: ldloc.s V_14
IL_00e8: sub
IL_00e9: stloc.1
IL_00ea: ldloc.s V_11
IL_00ec: ldc.i4.1
IL_00ed: add
IL_00ee: stloc.s V_11
IL_00f0: ldloc.s V_11
IL_00f2: ldloc.s V_10
IL_00f4: ldlen
IL_00f5: conv.i4
IL_00f6: blt.s IL_0093
IL_00f8: ldloc.2
IL_00f9: ldloc.s V_8
IL_00fb: newobj System.Void TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode::.ctor(TheForestOfLove.Narrative.ChapterRecord)
IL_0100: ldloc.1
IL_0101: conv.r4
IL_0102: callvirt System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode>::Enqueue(T,System.Single)
IL_0107: ldloca.s V_7
IL_0109: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::MoveNext()
IL_010e: brtrue IL_0045
IL_0113: leave.s IL_0123
IL_0115: ldloca.s V_7
IL_0117: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>
IL_011d: callvirt System.Void System.IDisposable::Dispose()
IL_0122: endfinally
IL_0123: ldc.i4.s 10
IL_0125: stloc.3
IL_0126: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_012b: callvirt System.Void SickDev.DevConsole.DevConsole::ClearLog()
IL_0130: ldloca.s V_4
IL_0132: initobj SickDev.DevConsole.EntryOptions
IL_0138: ldloca.s V_5
IL_013a: initobj SickDev.DevConsole.EntryOptions
IL_0140: ldloca.s V_4
IL_0142: ldc.r4 0.2509804
IL_0147: ldc.r4 0.5647059
IL_014c: ldc.r4 0.2509804
IL_0151: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0156: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_015b: ldloca.s V_5
IL_015d: ldc.r4 0.2509804
IL_0162: ldc.r4 0.76862746
IL_0167: ldc.r4 0.2509804
IL_016c: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0171: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0176: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_017b: ldsfld System.String System.String::Empty
IL_0180: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String)
IL_0185: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_018a: ldstr "top "
IL_018f: ldloca.s V_3
IL_0191: call System.String System.Int32::ToString()
IL_0196: ldstr " matching chapters:"
IL_019b: call System.String System.String::Concat(System.String,System.String,System.String)
IL_01a0: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_01a5: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode>::.ctor()
IL_01aa: stloc.s V_6
IL_01ac: br.s IL_01bb
IL_01ae: ldloc.s V_6
IL_01b0: ldloc.2
IL_01b1: callvirt T TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode>::Dequeue()
IL_01b6: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode>::Add(!0)
IL_01bb: ldloc.2
IL_01bc: callvirt System.Int32 TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode>::get_Count()
IL_01c1: ldc.i4.0
IL_01c2: bgt.s IL_01ae
IL_01c4: ldloc.s V_6
IL_01c6: ldsfld System.Comparison`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode> TheForestOfLove.DevConsoleCommands/ChapterCommands/<>c::<>9__2_0
IL_01cb: dup
IL_01cc: brtrue.s IL_01e5
IL_01ce: pop
IL_01cf: ldsfld TheForestOfLove.DevConsoleCommands/ChapterCommands/<>c TheForestOfLove.DevConsoleCommands/ChapterCommands/<>c::<>9
IL_01d4: ldftn System.Int32 TheForestOfLove.DevConsoleCommands/ChapterCommands/<>c::<Search>b__2_0(TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode,TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode)
IL_01da: newobj System.Void System.Comparison`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode>::.ctor(System.Object,System.IntPtr)
IL_01df: dup
IL_01e0: stsfld System.Comparison`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode> TheForestOfLove.DevConsoleCommands/ChapterCommands/<>c::<>9__2_0
IL_01e5: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode>::Sort(System.Comparison`1<!0>)
IL_01ea: ldc.i4.0
IL_01eb: stloc.s V_15
IL_01ed: br.s IL_024a
IL_01ef: ldloc.s V_6
IL_01f1: ldloc.s V_15
IL_01f3: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode>::get_Item(System.Int32)
IL_01f8: stloc.s V_16
IL_01fa: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_01ff: ldstr "({0}) {1} | {2}"
IL_0204: ldloc.s V_16
IL_0206: callvirt System.Single TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::get_Priority()
IL_020b: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0210: conv.i4
IL_0211: box System.Int32
IL_0216: ldloc.s V_16
IL_0218: ldfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode::schema
IL_021d: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::title
IL_0222: ldloc.s V_16
IL_0224: ldfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode::schema
IL_0229: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::description
IL_022e: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_0233: ldloc.s V_15
IL_0235: ldc.i4.2
IL_0236: rem
IL_0237: brfalse.s IL_023d
IL_0239: ldloc.s V_5
IL_023b: br.s IL_023f
IL_023d: ldloc.s V_4
IL_023f: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0244: ldloc.s V_15
IL_0246: ldc.i4.1
IL_0247: add
IL_0248: stloc.s V_15
IL_024a: ldloc.s V_15
IL_024c: ldloc.3
IL_024d: bge.s IL_025a
IL_024f: ldloc.s V_15
IL_0251: ldloc.s V_6
IL_0253: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/ChapterCommands/QueueNode>::get_Count()
IL_0258: blt.s IL_01ef
IL_025a: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/ChapterCommands::Unlock(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Services.Persistence.DataService::GetChapterRecords()
IL_0007: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_000c: stloc.1
IL_000d: br.s IL_003d
IL_000f: ldloc.1
IL_0010: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_0015: stloc.2
IL_0016: ldarg.0
IL_0017: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_001c: brtrue.s IL_003d
IL_001e: ldloc.2
IL_001f: ldfld System.Boolean TheForestOfLove.Narrative.ChapterRecord::isHiddenInList
IL_0024: brtrue.s IL_003d
IL_0026: ldarg.0
IL_0027: callvirt System.String System.String::ToLower()
IL_002c: ldarg.0
IL_002d: callvirt System.String System.String::Trim()
IL_0032: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0037: brfalse.s IL_003d
IL_0039: ldloc.2
IL_003a: stloc.0
IL_003b: leave.s IL_0051
IL_003d: ldloc.1
IL_003e: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0043: brtrue.s IL_000f
IL_0045: leave.s IL_0051
IL_0047: ldloc.1
IL_0048: brfalse.s IL_0050
IL_004a: ldloc.1
IL_004b: callvirt System.Void System.IDisposable::Dispose()
IL_0050: endfinally
IL_0051: ldloc.0
IL_0052: brtrue.s IL_006a
IL_0054: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0059: ldstr "could not find chapter "
IL_005e: ldarg.0
IL_005f: call System.String System.String::Concat(System.String,System.String)
IL_0064: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0069: ret
IL_006a: ldc.i4.1
IL_006b: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0070: ldloc.0
IL_0071: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_0076: ldloc.0
IL_0077: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::respawnInScene
IL_007c: ldnull
IL_007d: ldloca.s V_3
IL_007f: initobj System.Nullable`1<TheForestOfLove.Direction>
IL_0085: ldloc.3
IL_0086: call System.Void TheForestOfLove.ChapterSelectUI::DoChapterSelect(TheForestOfLove.Narrative.Chapter,System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_008b: ldc.i4.0
IL_008c: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0091: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0096: callvirt System.Void SickDev.DevConsole.DevConsole::Close()
IL_009b: ret
