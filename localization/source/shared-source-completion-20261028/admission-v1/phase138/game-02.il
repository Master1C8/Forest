TYPE TheForestOfLove.DevConsoleCommands/DateCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands/DateCommands::Find(System.String) | attributes=Public, Static, HideBySig | impl=IL
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
IL_0023: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_0028: stloc.2
IL_0029: ldc.i4.1
IL_002a: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_002f: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetDialogues()
IL_0034: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0039: stloc.s V_8
IL_003b: br.s IL_005c
IL_003d: ldloc.s V_8
IL_003f: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0044: stloc.s V_9
IL_0046: ldloc.s V_9
IL_0048: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_004d: ldc.i4 500
IL_0052: bne.un.s IL_005c
IL_0054: ldloc.2
IL_0055: ldloc.s V_9
IL_0057: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_005c: ldloc.s V_8
IL_005e: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0063: brtrue.s IL_003d
IL_0065: leave.s IL_0073
IL_0067: ldloc.s V_8
IL_0069: brfalse.s IL_0072
IL_006b: ldloc.s V_8
IL_006d: callvirt System.Void System.IDisposable::Dispose()
IL_0072: endfinally
IL_0073: ldc.i4.0
IL_0074: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0079: ldloc.2
IL_007a: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::get_Count()
IL_007f: newobj System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode>::.ctor(System.Int32)
IL_0084: stloc.3
IL_0085: ldloc.2
IL_0086: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_008b: stloc.s V_10
IL_008d: br IL_0133
IL_0092: ldloca.s V_10
IL_0094: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0099: stloc.s V_11
IL_009b: ldc.i4.0
IL_009c: stloc.1
IL_009d: ldloc.s V_11
IL_009f: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00a4: callvirt System.String System.String::ToLower()
IL_00a9: stloc.s V_12
IL_00ab: ldloc.0
IL_00ac: stloc.s V_13
IL_00ae: ldc.i4.0
IL_00af: stloc.s V_14
IL_00b1: br.s IL_0110
IL_00b3: ldloc.s V_13
IL_00b5: ldloc.s V_14
IL_00b7: ldelem.ref
IL_00b8: stloc.s V_15
IL_00ba: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.DevConsoleCommands/DateCommands::tokensToCountOnce
IL_00bf: ldloc.s V_15
IL_00c1: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_00c6: brfalse.s IL_00dc
IL_00c8: ldloc.1
IL_00c9: ldloc.s V_12
IL_00cb: ldloc.s V_15
IL_00cd: callvirt System.Boolean System.String::Contains(System.String)
IL_00d2: brtrue.s IL_00d7
IL_00d4: ldc.i4.0
IL_00d5: br.s IL_00d8
IL_00d7: ldc.i4.1
IL_00d8: sub
IL_00d9: stloc.1
IL_00da: br.s IL_010a
IL_00dc: ldloc.s V_12
IL_00de: stloc.s V_16
IL_00e0: ldloc.s V_16
IL_00e2: callvirt System.Int32 System.String::get_Length()
IL_00e7: ldloc.s V_16
IL_00e9: ldloc.s V_15
IL_00eb: ldsfld System.String System.String::Empty
IL_00f0: callvirt System.String System.String::Replace(System.String,System.String)
IL_00f5: callvirt System.Int32 System.String::get_Length()
IL_00fa: sub
IL_00fb: ldloc.s V_15
IL_00fd: callvirt System.Int32 System.String::get_Length()
IL_0102: div
IL_0103: stloc.s V_17
IL_0105: ldloc.1
IL_0106: ldloc.s V_17
IL_0108: sub
IL_0109: stloc.1
IL_010a: ldloc.s V_14
IL_010c: ldc.i4.1
IL_010d: add
IL_010e: stloc.s V_14
IL_0110: ldloc.s V_14
IL_0112: ldloc.s V_13
IL_0114: ldlen
IL_0115: conv.i4
IL_0116: blt.s IL_00b3
IL_0118: ldloc.3
IL_0119: ldloc.s V_11
IL_011b: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0120: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0125: ldloc.s V_12
IL_0127: newobj System.Void TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode::.ctor(System.Int32,System.String)
IL_012c: ldloc.1
IL_012d: conv.r4
IL_012e: callvirt System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode>::Enqueue(T,System.Single)
IL_0133: ldloca.s V_10
IL_0135: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_013a: brtrue IL_0092
IL_013f: leave.s IL_014f
IL_0141: ldloca.s V_10
IL_0143: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0149: callvirt System.Void System.IDisposable::Dispose()
IL_014e: endfinally
IL_014f: ldc.i4.s 10
IL_0151: stloc.s V_4
IL_0153: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0158: callvirt System.Void SickDev.DevConsole.DevConsole::ClearLog()
IL_015d: ldloca.s V_5
IL_015f: initobj SickDev.DevConsole.EntryOptions
IL_0165: ldloca.s V_6
IL_0167: initobj SickDev.DevConsole.EntryOptions
IL_016d: ldloca.s V_5
IL_016f: ldc.r4 0.2509804
IL_0174: ldc.r4 0.5647059
IL_0179: ldc.r4 0.2509804
IL_017e: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0183: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0188: ldloca.s V_6
IL_018a: ldc.r4 0.2509804
IL_018f: ldc.r4 0.76862746
IL_0194: ldc.r4 0.2509804
IL_0199: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_019e: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_01a3: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_01a8: ldsfld System.String System.String::Empty
IL_01ad: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String)
IL_01b2: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_01b7: ldstr "top "
IL_01bc: ldloca.s V_4
IL_01be: call System.String System.Int32::ToString()
IL_01c3: ldstr " matching dialogues:"
IL_01c8: call System.String System.String::Concat(System.String,System.String,System.String)
IL_01cd: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_01d2: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode>::.ctor()
IL_01d7: stloc.s V_7
IL_01d9: br.s IL_01e8
IL_01db: ldloc.s V_7
IL_01dd: ldloc.3
IL_01de: callvirt T TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode>::Dequeue()
IL_01e3: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode>::Add(!0)
IL_01e8: ldloc.3
IL_01e9: callvirt System.Int32 TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode>::get_Count()
IL_01ee: ldc.i4.0
IL_01ef: bgt.s IL_01db
IL_01f1: ldloc.s V_7
IL_01f3: ldsfld System.Comparison`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode> TheForestOfLove.DevConsoleCommands/DateCommands/<>c::<>9__2_0
IL_01f8: dup
IL_01f9: brtrue.s IL_0212
IL_01fb: pop
IL_01fc: ldsfld TheForestOfLove.DevConsoleCommands/DateCommands/<>c TheForestOfLove.DevConsoleCommands/DateCommands/<>c::<>9
IL_0201: ldftn System.Int32 TheForestOfLove.DevConsoleCommands/DateCommands/<>c::<Find>b__2_0(TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode,TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode)
IL_0207: newobj System.Void System.Comparison`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode>::.ctor(System.Object,System.IntPtr)
IL_020c: dup
IL_020d: stsfld System.Comparison`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode> TheForestOfLove.DevConsoleCommands/DateCommands/<>c::<>9__2_0
IL_0212: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode>::Sort(System.Comparison`1<!0>)
IL_0217: ldc.i4.0
IL_0218: stloc.s V_18
IL_021a: br.s IL_028e
IL_021c: ldloc.s V_7
IL_021e: ldloc.s V_18
IL_0220: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode>::get_Item(System.Int32)
IL_0225: stloc.s V_19
IL_0227: ldstr "{0,-5}"
IL_022c: ldloc.s V_19
IL_022e: ldfld System.Int32 TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode::conversationId
IL_0233: box System.Int32
IL_0238: call System.String System.String::Format(System.String,System.Object)
IL_023d: stloc.s V_20
IL_023f: ldloc.s V_19
IL_0241: callvirt System.Single TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::get_Priority()
IL_0246: ldc.r4 0
IL_024b: bge.s IL_0288
IL_024d: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0252: ldstr "({0}) {1} {2}"
IL_0257: ldloc.s V_19
IL_0259: callvirt System.Single TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::get_Priority()
IL_025e: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0263: conv.i4
IL_0264: box System.Int32
IL_0269: ldloc.s V_20
IL_026b: ldloc.s V_19
IL_026d: ldfld System.String TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode::conversationTitle
IL_0272: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_0277: ldloc.s V_18
IL_0279: ldc.i4.2
IL_027a: rem
IL_027b: brfalse.s IL_0281
IL_027d: ldloc.s V_6
IL_027f: br.s IL_0283
IL_0281: ldloc.s V_5
IL_0283: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0288: ldloc.s V_18
IL_028a: ldc.i4.1
IL_028b: add
IL_028c: stloc.s V_18
IL_028e: ldloc.s V_18
IL_0290: ldloc.s V_4
IL_0292: bge.s IL_02a2
IL_0294: ldloc.s V_18
IL_0296: ldloc.s V_7
IL_0298: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/DateCommands/QueueNode>::get_Count()
IL_029d: blt IL_021c
IL_02a2: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DateCommands::List() | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_0005: stloc.0
IL_0006: ldc.i4.1
IL_0007: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_000c: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetDialogues()
IL_0011: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0016: stloc.3
IL_0017: br.s IL_0037
IL_0019: ldloc.3
IL_001a: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_001f: stloc.s V_4
IL_0021: ldloc.s V_4
IL_0023: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0028: ldc.i4 500
IL_002d: bne.un.s IL_0037
IL_002f: ldloc.0
IL_0030: ldloc.s V_4
IL_0032: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_0037: ldloc.3
IL_0038: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_003d: brtrue.s IL_0019
IL_003f: leave.s IL_004b
IL_0041: ldloc.3
IL_0042: brfalse.s IL_004a
IL_0044: ldloc.3
IL_0045: callvirt System.Void System.IDisposable::Dispose()
IL_004a: endfinally
IL_004b: ldc.i4.0
IL_004c: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0051: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0056: callvirt System.Void SickDev.DevConsole.DevConsole::ClearLog()
IL_005b: ldloca.s V_1
IL_005d: initobj SickDev.DevConsole.EntryOptions
IL_0063: ldloca.s V_2
IL_0065: initobj SickDev.DevConsole.EntryOptions
IL_006b: ldloca.s V_1
IL_006d: ldc.r4 0.2509804
IL_0072: ldc.r4 0.5647059
IL_0077: ldc.r4 0.2509804
IL_007c: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0081: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0086: ldloca.s V_2
IL_0088: ldc.r4 0.2509804
IL_008d: ldc.r4 0.76862746
IL_0092: ldc.r4 0.2509804
IL_0097: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_009c: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_00a1: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00a6: ldsfld System.String System.String::Empty
IL_00ab: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String)
IL_00b0: ldloc.0
IL_00b1: ldsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.DevConsoleCommands/DateCommands/<>c::<>9__3_0
IL_00b6: dup
IL_00b7: brtrue.s IL_00d0
IL_00b9: pop
IL_00ba: ldsfld TheForestOfLove.DevConsoleCommands/DateCommands/<>c TheForestOfLove.DevConsoleCommands/DateCommands/<>c::<>9
IL_00bf: ldftn System.Int32 TheForestOfLove.DevConsoleCommands/DateCommands/<>c::<List>b__3_0(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Dialogue)
IL_00c5: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_00ca: dup
IL_00cb: stsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.DevConsoleCommands/DateCommands/<>c::<>9__3_0
IL_00d0: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Sort(System.Comparison`1<!0>)
IL_00d5: ldc.i4.0
IL_00d6: stloc.s V_5
IL_00d8: br.s IL_0137
IL_00da: ldloc.0
IL_00db: ldloc.s V_5
IL_00dd: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::get_Item(System.Int32)
IL_00e2: stloc.s V_6
IL_00e4: ldloc.s V_6
IL_00e6: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00eb: callvirt System.String System.String::ToLower()
IL_00f0: stloc.s V_7
IL_00f2: ldstr "{0,-5}"
IL_00f7: ldloc.s V_6
IL_00f9: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00fe: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0103: box System.Int32
IL_0108: call System.String System.String::Format(System.String,System.Object)
IL_010d: stloc.s V_8
IL_010f: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0114: ldstr "{0} {1}"
IL_0119: ldloc.s V_8
IL_011b: ldloc.s V_7
IL_011d: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0122: ldloc.s V_5
IL_0124: ldc.i4.2
IL_0125: rem
IL_0126: brfalse.s IL_012b
IL_0128: ldloc.2
IL_0129: br.s IL_012c
IL_012b: ldloc.1
IL_012c: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0131: ldloc.s V_5
IL_0133: ldc.i4.1
IL_0134: add
IL_0135: stloc.s V_5
IL_0137: ldloc.s V_5
IL_0139: ldloc.0
IL_013a: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::get_Count()
IL_013f: blt.s IL_00da
IL_0141: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DateCommands::ForceNext(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Reset(System.Int32)
IL_0006: ldc.i4.1
IL_0007: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_000c: ldarg.0
IL_000d: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByPluginDbId(System.Int32)
IL_0012: stloc.0
IL_0013: ldc.i4.0
IL_0014: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0019: ldloc.0
IL_001a: brtrue.s IL_0038
IL_001c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0021: ldstr "could not find dialogue "
IL_0026: ldarga.s id
IL_0028: call System.String System.Int32::ToString()
IL_002d: call System.String System.String::Concat(System.String,System.String)
IL_0032: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0037: ret
IL_0038: ldloc.0
IL_0039: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_003e: ldc.i4 500
IL_0043: beq.s IL_0066
IL_0045: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_004a: ldstr "dialogue "
IL_004f: ldarga.s id
IL_0051: call System.String System.Int32::ToString()
IL_0056: ldstr " is not a date dialogue"
IL_005b: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0060: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0065: ret
IL_0066: ldsfld TheForestOfLove.DevConsoleCommands TheForestOfLove.DevConsoleCommands::instance
IL_006b: ldnull
IL_006c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0071: brfalse.s IL_00a4
IL_0073: ldsfld TheForestOfLove.DevConsoleCommands TheForestOfLove.DevConsoleCommands::instance
IL_0078: ldfld UnityEngine.UI.Text TheForestOfLove.DevConsoleCommands::debugDateName
IL_007d: ldnull
IL_007e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0083: brfalse.s IL_00a4
IL_0085: ldsfld TheForestOfLove.DevConsoleCommands TheForestOfLove.DevConsoleCommands::instance
IL_008a: ldfld UnityEngine.UI.Text TheForestOfLove.DevConsoleCommands::debugDateName
IL_008f: ldstr "Debug Date: "
IL_0094: ldloc.0
IL_0095: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_009a: call System.String System.String::Concat(System.String,System.String)
IL_009f: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_00a4: ldloc.0
IL_00a5: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00aa: stsfld System.String Globals::Debug_ForceSpawnDate_DialogueDbName
IL_00af: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00b4: callvirt System.Void SickDev.DevConsole.DevConsole::Close()
IL_00b9: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DateCommands::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "quest"
IL_000b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0010: dup
IL_0011: ldstr "date"
IL_0016: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_001b: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.DevConsoleCommands/DateCommands::tokensToCountOnce
IL_0020: ret
