TYPE TheForestOfLove.DevConsoleCommands/DialogueCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Find(System.String) | attributes=Public, Static, HideBySig | impl=IL
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
IL_0023: call PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueManager::get_databaseManager()
IL_0028: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_002d: dup
IL_002e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversations
IL_0033: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation>::get_Count()
IL_0038: newobj System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode>::.ctor(System.Int32)
IL_003d: stloc.2
IL_003e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversations
IL_0043: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation>::GetEnumerator()
IL_0048: stloc.s V_7
IL_004a: br IL_011d
IL_004f: ldloca.s V_7
IL_0051: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Conversation>::get_Current()
IL_0056: stloc.s V_8
IL_0058: ldc.i4.0
IL_0059: stloc.1
IL_005a: ldloc.s V_8
IL_005c: callvirt System.String PixelCrushers.DialogueSystem.Conversation::get_Title()
IL_0061: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0066: brtrue IL_011d
IL_006b: ldc.i4.1
IL_006c: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0071: ldloc.s V_8
IL_0073: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0078: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByPluginDbId(System.Int32)
IL_007d: stloc.s V_9
IL_007f: ldc.i4.0
IL_0080: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0085: ldloc.s V_9
IL_0087: brfalse IL_011d
IL_008c: ldloc.s V_9
IL_008e: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0093: callvirt System.String System.String::ToLower()
IL_0098: stloc.s V_10
IL_009a: ldloc.0
IL_009b: stloc.s V_11
IL_009d: ldc.i4.0
IL_009e: stloc.s V_12
IL_00a0: br.s IL_00ff
IL_00a2: ldloc.s V_11
IL_00a4: ldloc.s V_12
IL_00a6: ldelem.ref
IL_00a7: stloc.s V_13
IL_00a9: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.DevConsoleCommands/DialogueCommands::tokensToCountOnce
IL_00ae: ldloc.s V_13
IL_00b0: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_00b5: brfalse.s IL_00cb
IL_00b7: ldloc.1
IL_00b8: ldloc.s V_10
IL_00ba: ldloc.s V_13
IL_00bc: callvirt System.Boolean System.String::Contains(System.String)
IL_00c1: brtrue.s IL_00c6
IL_00c3: ldc.i4.0
IL_00c4: br.s IL_00c7
IL_00c6: ldc.i4.1
IL_00c7: sub
IL_00c8: stloc.1
IL_00c9: br.s IL_00f9
IL_00cb: ldloc.s V_10
IL_00cd: stloc.s V_14
IL_00cf: ldloc.s V_14
IL_00d1: callvirt System.Int32 System.String::get_Length()
IL_00d6: ldloc.s V_14
IL_00d8: ldloc.s V_13
IL_00da: ldsfld System.String System.String::Empty
IL_00df: callvirt System.String System.String::Replace(System.String,System.String)
IL_00e4: callvirt System.Int32 System.String::get_Length()
IL_00e9: sub
IL_00ea: ldloc.s V_13
IL_00ec: callvirt System.Int32 System.String::get_Length()
IL_00f1: div
IL_00f2: stloc.s V_15
IL_00f4: ldloc.1
IL_00f5: ldloc.s V_15
IL_00f7: sub
IL_00f8: stloc.1
IL_00f9: ldloc.s V_12
IL_00fb: ldc.i4.1
IL_00fc: add
IL_00fd: stloc.s V_12
IL_00ff: ldloc.s V_12
IL_0101: ldloc.s V_11
IL_0103: ldlen
IL_0104: conv.i4
IL_0105: blt.s IL_00a2
IL_0107: ldloc.2
IL_0108: ldloc.s V_8
IL_010a: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_010f: ldloc.s V_10
IL_0111: newobj System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode::.ctor(System.Int32,System.String)
IL_0116: ldloc.1
IL_0117: conv.r4
IL_0118: callvirt System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode>::Enqueue(T,System.Single)
IL_011d: ldloca.s V_7
IL_011f: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Conversation>::MoveNext()
IL_0124: brtrue IL_004f
IL_0129: leave.s IL_0139
IL_012b: ldloca.s V_7
IL_012d: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Conversation>
IL_0133: callvirt System.Void System.IDisposable::Dispose()
IL_0138: endfinally
IL_0139: ldc.i4.s 10
IL_013b: stloc.3
IL_013c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0141: callvirt System.Void SickDev.DevConsole.DevConsole::ClearLog()
IL_0146: ldloca.s V_4
IL_0148: initobj SickDev.DevConsole.EntryOptions
IL_014e: ldloca.s V_5
IL_0150: initobj SickDev.DevConsole.EntryOptions
IL_0156: ldloca.s V_4
IL_0158: ldc.r4 0.2509804
IL_015d: ldc.r4 0.5647059
IL_0162: ldc.r4 0.2509804
IL_0167: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_016c: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0171: ldloca.s V_5
IL_0173: ldc.r4 0.2509804
IL_0178: ldc.r4 0.76862746
IL_017d: ldc.r4 0.2509804
IL_0182: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0187: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_018c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0191: ldsfld System.String System.String::Empty
IL_0196: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String)
IL_019b: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_01a0: ldstr "top "
IL_01a5: ldloca.s V_3
IL_01a7: call System.String System.Int32::ToString()
IL_01ac: ldstr " matching dialogues:"
IL_01b1: call System.String System.String::Concat(System.String,System.String,System.String)
IL_01b6: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_01bb: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode>::.ctor()
IL_01c0: stloc.s V_6
IL_01c2: br.s IL_01d1
IL_01c4: ldloc.s V_6
IL_01c6: ldloc.2
IL_01c7: callvirt T TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode>::Dequeue()
IL_01cc: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode>::Add(!0)
IL_01d1: ldloc.2
IL_01d2: callvirt System.Int32 TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode>::get_Count()
IL_01d7: ldc.i4.0
IL_01d8: bgt.s IL_01c4
IL_01da: ldloc.s V_6
IL_01dc: ldsfld System.Comparison`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode> TheForestOfLove.DevConsoleCommands/DialogueCommands/<>c::<>9__2_0
IL_01e1: dup
IL_01e2: brtrue.s IL_01fb
IL_01e4: pop
IL_01e5: ldsfld TheForestOfLove.DevConsoleCommands/DialogueCommands/<>c TheForestOfLove.DevConsoleCommands/DialogueCommands/<>c::<>9
IL_01ea: ldftn System.Int32 TheForestOfLove.DevConsoleCommands/DialogueCommands/<>c::<Find>b__2_0(TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode,TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode)
IL_01f0: newobj System.Void System.Comparison`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode>::.ctor(System.Object,System.IntPtr)
IL_01f5: dup
IL_01f6: stsfld System.Comparison`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode> TheForestOfLove.DevConsoleCommands/DialogueCommands/<>c::<>9__2_0
IL_01fb: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode>::Sort(System.Comparison`1<!0>)
IL_0200: ldc.i4.0
IL_0201: stloc.s V_16
IL_0203: br.s IL_0277
IL_0205: ldloc.s V_6
IL_0207: ldloc.s V_16
IL_0209: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode>::get_Item(System.Int32)
IL_020e: stloc.s V_17
IL_0210: ldstr "{0,-5}"
IL_0215: ldloc.s V_17
IL_0217: ldfld System.Int32 TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode::conversationId
IL_021c: box System.Int32
IL_0221: call System.String System.String::Format(System.String,System.Object)
IL_0226: stloc.s V_18
IL_0228: ldloc.s V_17
IL_022a: callvirt System.Single TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::get_Priority()
IL_022f: ldc.r4 0
IL_0234: bge.s IL_0271
IL_0236: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_023b: ldstr "({0}) {1} {2}"
IL_0240: ldloc.s V_17
IL_0242: callvirt System.Single TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::get_Priority()
IL_0247: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_024c: conv.i4
IL_024d: box System.Int32
IL_0252: ldloc.s V_18
IL_0254: ldloc.s V_17
IL_0256: ldfld System.String TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode::conversationTitle
IL_025b: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_0260: ldloc.s V_16
IL_0262: ldc.i4.2
IL_0263: rem
IL_0264: brfalse.s IL_026a
IL_0266: ldloc.s V_5
IL_0268: br.s IL_026c
IL_026a: ldloc.s V_4
IL_026c: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0271: ldloc.s V_16
IL_0273: ldc.i4.1
IL_0274: add
IL_0275: stloc.s V_16
IL_0277: ldloc.s V_16
IL_0279: ldloc.3
IL_027a: bge.s IL_028a
IL_027c: ldloc.s V_16
IL_027e: ldloc.s V_6
IL_0280: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/DialogueCommands/QueueNode>::get_Count()
IL_0285: blt IL_0205
IL_028a: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Info(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldc.i4.1
IL_0001: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0006: ldarg.0
IL_0007: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByPluginDbId(System.Int32)
IL_000c: stloc.0
IL_000d: ldc.i4.0
IL_000e: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0013: ldloc.0
IL_0014: brtrue.s IL_0032
IL_0016: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_001b: ldstr "could not find dialogue "
IL_0020: ldarga.s id
IL_0022: call System.String System.Int32::ToString()
IL_0027: call System.String System.String::Concat(System.String,System.String)
IL_002c: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0031: ret
IL_0032: ldloca.s V_1
IL_0034: initobj SickDev.DevConsole.EntryOptions
IL_003a: ldloca.s V_2
IL_003c: initobj SickDev.DevConsole.EntryOptions
IL_0042: ldloca.s V_1
IL_0044: ldc.r4 0.2509804
IL_0049: ldc.r4 0.5647059
IL_004e: ldc.r4 0.2509804
IL_0053: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0058: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_005d: ldloca.s V_2
IL_005f: ldc.r4 0.2509804
IL_0064: ldc.r4 0.76862746
IL_0069: ldc.r4 0.2509804
IL_006e: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0073: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0078: ldc.i4.0
IL_0079: stloc.3
IL_007a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_007f: ldsfld System.String System.String::Empty
IL_0084: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String)
IL_0089: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_008e: ldstr "info for dialogue "
IL_0093: ldarga.s id
IL_0095: call System.String System.Int32::ToString()
IL_009a: ldstr " - "
IL_009f: ldloc.0
IL_00a0: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00a5: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00aa: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_00af: ldstr "    "
IL_00b4: stloc.s V_4
IL_00b6: ldloc.0
IL_00b7: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_00bc: ldc.i4 200
IL_00c1: bne.un.s IL_0118
IL_00c3: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00c8: ldstr "{0}{1}"
IL_00cd: ldloc.s V_4
IL_00cf: ldstr "type: {0} ({1}, {2})"
IL_00d4: ldloc.0
IL_00d5: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_00da: box TheForestOfLove.Narrative.DialogueType
IL_00df: ldloc.0
IL_00e0: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_00e5: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_00ea: ldloc.0
IL_00eb: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_00f0: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_00f5: box TheForestOfLove.Narrative.QuestStatus
IL_00fa: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_00ff: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0104: ldloc.3
IL_0105: ldc.i4.2
IL_0106: rem
IL_0107: brfalse.s IL_010c
IL_0109: ldloc.2
IL_010a: br.s IL_010d
IL_010c: ldloc.1
IL_010d: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0112: ldloc.3
IL_0113: ldc.i4.1
IL_0114: add
IL_0115: stloc.3
IL_0116: br.s IL_0150
IL_0118: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_011d: ldstr "{0}{1}"
IL_0122: ldloc.s V_4
IL_0124: ldstr "type: {0}"
IL_0129: ldloc.0
IL_012a: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_012f: box TheForestOfLove.Narrative.DialogueType
IL_0134: call System.String System.String::Format(System.String,System.Object)
IL_0139: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_013e: ldloc.3
IL_013f: ldc.i4.2
IL_0140: rem
IL_0141: brfalse.s IL_0146
IL_0143: ldloc.2
IL_0144: br.s IL_0147
IL_0146: ldloc.1
IL_0147: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_014c: ldloc.3
IL_014d: ldc.i4.1
IL_014e: add
IL_014f: stloc.3
IL_0150: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0155: ldstr "{0}{1}"
IL_015a: ldloc.s V_4
IL_015c: ldstr "status: {0}"
IL_0161: ldloc.0
IL_0162: callvirt TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0167: box TheForestOfLove.Narrative.DialogueStatus
IL_016c: call System.String System.String::Format(System.String,System.Object)
IL_0171: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0176: ldloc.3
IL_0177: ldc.i4.2
IL_0178: rem
IL_0179: brfalse.s IL_017e
IL_017b: ldloc.2
IL_017c: br.s IL_017f
IL_017e: ldloc.1
IL_017f: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0184: ldloc.3
IL_0185: ldc.i4.1
IL_0186: add
IL_0187: stloc.3
IL_0188: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_018d: ldstr "{0}{1}"
IL_0192: ldloc.s V_4
IL_0194: ldstr "primary actor: {0}"
IL_0199: ldloc.0
IL_019a: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_019f: call System.String System.String::Format(System.String,System.Object)
IL_01a4: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_01a9: ldloc.3
IL_01aa: ldc.i4.2
IL_01ab: rem
IL_01ac: brfalse.s IL_01b1
IL_01ae: ldloc.2
IL_01af: br.s IL_01b2
IL_01b1: ldloc.1
IL_01b2: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_01b7: ldloc.3
IL_01b8: ldc.i4.1
IL_01b9: add
IL_01ba: stloc.3
IL_01bb: ldloc.0
IL_01bc: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::initialActor
IL_01c1: ldloc.0
IL_01c2: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_01c7: beq.s IL_01fc
IL_01c9: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_01ce: ldstr "{0}{1}"
IL_01d3: ldloc.s V_4
IL_01d5: ldstr "initial actor: {0}"
IL_01da: ldloc.0
IL_01db: ldfld System.String TheForestOfLove.Narrative.Dialogue::initialActorDbName
IL_01e0: call System.String System.String::Format(System.String,System.Object)
IL_01e5: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_01ea: ldloc.3
IL_01eb: ldc.i4.2
IL_01ec: rem
IL_01ed: brfalse.s IL_01f2
IL_01ef: ldloc.2
IL_01f0: br.s IL_01f3
IL_01f2: ldloc.1
IL_01f3: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_01f8: ldloc.3
IL_01f9: ldc.i4.1
IL_01fa: add
IL_01fb: stloc.3
IL_01fc: ldloc.0
IL_01fd: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_0202: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::get_Count()
IL_0207: ldc.i4.0
IL_0208: ble IL_0297
IL_020d: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0212: ldstr "{0}{1}"
IL_0217: ldloc.s V_4
IL_0219: ldstr "named arcs:"
IL_021e: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0223: ldloc.3
IL_0224: ldc.i4.2
IL_0225: rem
IL_0226: brfalse.s IL_022b
IL_0228: ldloc.2
IL_0229: br.s IL_022c
IL_022b: ldloc.1
IL_022c: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0231: ldloc.3
IL_0232: ldc.i4.1
IL_0233: add
IL_0234: stloc.3
IL_0235: ldloc.0
IL_0236: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_023b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0240: stloc.s V_6
IL_0242: br.s IL_027e
IL_0244: ldloca.s V_6
IL_0246: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_024b: stloc.s V_7
IL_024d: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0252: ldstr "{0}{1}"
IL_0257: ldloc.s V_4
IL_0259: ldloc.s V_4
IL_025b: call System.String System.String::Concat(System.String,System.String)
IL_0260: ldloc.s V_7
IL_0262: ldfld System.String TheForestOfLove.Narrative.Arc::customName
IL_0267: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_026c: ldloc.3
IL_026d: ldc.i4.2
IL_026e: rem
IL_026f: brfalse.s IL_0274
IL_0271: ldloc.2
IL_0272: br.s IL_0275
IL_0274: ldloc.1
IL_0275: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_027a: ldloc.3
IL_027b: ldc.i4.1
IL_027c: add
IL_027d: stloc.3
IL_027e: ldloca.s V_6
IL_0280: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0285: brtrue.s IL_0244
IL_0287: leave.s IL_0297
IL_0289: ldloca.s V_6
IL_028b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0291: callvirt System.Void System.IDisposable::Dispose()
IL_0296: endfinally
IL_0297: ldc.i4.0
IL_0298: stloc.s V_5
IL_029a: ldloc.0
IL_029b: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_02a0: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::GetEnumerator()
IL_02a5: stloc.s V_8
IL_02a7: br IL_034b
IL_02ac: ldloca.s V_8
IL_02ae: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::get_Current()
IL_02b3: stloc.s V_9
IL_02b5: ldloc.s V_9
IL_02b7: callvirt System.Type System.Object::GetType()
IL_02bc: ldtoken TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger
IL_02c1: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_02c6: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_02cb: brfalse.s IL_034b
IL_02cd: ldloc.s V_5
IL_02cf: brtrue.s IL_02fc
IL_02d1: ldc.i4.1
IL_02d2: stloc.s V_5
IL_02d4: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_02d9: ldstr "{0}{1}"
IL_02de: ldloc.s V_4
IL_02e0: ldstr "named triggers:"
IL_02e5: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_02ea: ldloc.3
IL_02eb: ldc.i4.2
IL_02ec: rem
IL_02ed: brfalse.s IL_02f2
IL_02ef: ldloc.2
IL_02f0: br.s IL_02f3
IL_02f2: ldloc.1
IL_02f3: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_02f8: ldloc.3
IL_02f9: ldc.i4.1
IL_02fa: add
IL_02fb: stloc.3
IL_02fc: ldloc.s V_9
IL_02fe: castclass TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger
IL_0303: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_0308: stloc.s V_10
IL_030a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_030f: ldstr "{0}{1} ({2})"
IL_0314: ldloc.s V_4
IL_0316: ldloc.s V_4
IL_0318: call System.String System.String::Concat(System.String,System.String)
IL_031d: ldloc.s V_10
IL_031f: ldloc.s V_10
IL_0321: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_0326: brtrue.s IL_032f
IL_0328: ldstr "ready"
IL_032d: br.s IL_0334
IL_032f: ldstr "fired"
IL_0334: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_0339: ldloc.3
IL_033a: ldc.i4.2
IL_033b: rem
IL_033c: brfalse.s IL_0341
IL_033e: ldloc.2
IL_033f: br.s IL_0342
IL_0341: ldloc.1
IL_0342: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_0347: ldloc.3
IL_0348: ldc.i4.1
IL_0349: add
IL_034a: stloc.3
IL_034b: ldloca.s V_8
IL_034d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::MoveNext()
IL_0352: brtrue IL_02ac
IL_0357: leave.s IL_0367
IL_0359: ldloca.s V_8
IL_035b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>
IL_0361: callvirt System.Void System.IDisposable::Dispose()
IL_0366: endfinally
IL_0367: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Raw(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Raw(System.Int32,System.String)
IL_0007: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Raw(System.Int32,System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldc.i4.1
IL_0001: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0006: ldarg.0
IL_0007: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByPluginDbId(System.Int32)
IL_000c: stloc.0
IL_000d: ldc.i4.0
IL_000e: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0013: ldloc.0
IL_0014: brtrue.s IL_0032
IL_0016: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_001b: ldstr "could not play dialogue "
IL_0020: ldarga.s id
IL_0022: call System.String System.Int32::ToString()
IL_0027: call System.String System.String::Concat(System.String,System.String)
IL_002c: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0031: ret
IL_0032: ldc.i4.1
IL_0033: call System.Void Globals::set_DisablePreconditions(System.Boolean)
IL_0038: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.DialogueService>()
IL_003d: ldloc.0
IL_003e: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0043: ldarg.1
IL_0044: callvirt System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String,System.String)
IL_0049: ldc.i4.0
IL_004a: call System.Void Globals::set_DisablePreconditions(System.Boolean)
IL_004f: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0054: callvirt System.Void SickDev.DevConsole.DevConsole::Close()
IL_0059: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Play(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Play(System.Int32,System.String)
IL_0007: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Play(System.Int32,System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldc.i4.1
IL_0001: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0006: ldarg.0
IL_0007: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByPluginDbId(System.Int32)
IL_000c: stloc.0
IL_000d: ldc.i4.0
IL_000e: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0013: ldloc.0
IL_0014: brtrue.s IL_0032
IL_0016: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_001b: ldstr "could not play dialogue "
IL_0020: ldarga.s id
IL_0022: call System.String System.Int32::ToString()
IL_0027: call System.String System.String::Concat(System.String,System.String)
IL_002c: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0031: ret
IL_0032: ldc.i4.1
IL_0033: call System.Void Globals::set_DisablePreconditions(System.Boolean)
IL_0038: ldloc.0
IL_0039: ldarg.1
IL_003a: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_003f: brtrue.s IL_0049
IL_0041: ldarg.1
IL_0042: callvirt System.String System.String::Trim()
IL_0047: br.s IL_004a
IL_0049: ldnull
IL_004a: call System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.Dialogue,System.String)
IL_004f: pop
IL_0050: ldc.i4.0
IL_0051: call System.Void Globals::set_DisablePreconditions(System.Boolean)
IL_0056: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_005b: callvirt System.Void SickDev.DevConsole.DevConsole::Close()
IL_0060: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Complete(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldc.i4.1
IL_0001: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0006: ldarg.0
IL_0007: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByPluginDbId(System.Int32)
IL_000c: stloc.0
IL_000d: ldc.i4.0
IL_000e: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0013: ldloc.0
IL_0014: brtrue.s IL_0032
IL_0016: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_001b: ldstr "could not find dialogue "
IL_0020: ldarga.s id
IL_0022: call System.String System.Int32::ToString()
IL_0027: call System.String System.String::Concat(System.String,System.String)
IL_002c: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0031: ret
IL_0032: ldc.i4.1
IL_0033: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0038: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.StoryManager>()
IL_003d: ldloc.0
IL_003e: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0043: ldnull
IL_0044: callvirt System.Void TheForestOfLove.Narrative.StoryManager::MarkConversationsAsPlayed(System.String,System.String)
IL_0049: ldc.i4.0
IL_004a: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_004f: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0054: ldstr "completed dialogue with id "
IL_0059: ldarga.s id
IL_005b: call System.String System.Int32::ToString()
IL_0060: call System.String System.String::Concat(System.String,System.String)
IL_0065: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_006a: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Reset(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.StoryManager>()
IL_0005: ldc.i4.1
IL_0006: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_000b: ldarg.0
IL_000c: callvirt System.Boolean TheForestOfLove.Narrative.StoryManager::ResetConversation(System.Int32)
IL_0011: brfalse.s IL_0030
IL_0013: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0018: ldstr "reset dialogue with id "
IL_001d: ldarga.s id
IL_001f: call System.String System.Int32::ToString()
IL_0024: call System.String System.String::Concat(System.String,System.String)
IL_0029: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_002e: br.s IL_004b
IL_0030: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0035: ldstr "could not reset dialogue with id "
IL_003a: ldarga.s id
IL_003c: call System.String System.Int32::ToString()
IL_0041: call System.String System.String::Concat(System.String,System.String)
IL_0046: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_004b: ldc.i4.0
IL_004c: call System.Void Globals::set_DevCommandActive(System.Boolean)
IL_0051: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Test() | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldnull
IL_0001: call System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Test(System.String)
IL_0006: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Test(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: call PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueManager::get_databaseManager()
IL_0005: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_000a: ldstr "system/testconvo"
IL_000f: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_0014: stloc.0
IL_0015: ldloc.0
IL_0016: brtrue.s IL_0028
IL_0018: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_001d: ldstr "could not play test conversation"
IL_0022: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0027: ret
IL_0028: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.DialogueService>()
IL_002d: ldloc.0
IL_002e: callvirt System.String PixelCrushers.DialogueSystem.Conversation::get_Title()
IL_0033: ldarg.0
IL_0034: callvirt System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String,System.String)
IL_0039: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_003e: callvirt System.Void SickDev.DevConsole.DevConsole::Close()
IL_0043: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "quest"
IL_000b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0010: stsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.DevConsoleCommands/DialogueCommands::tokensToCountOnce
IL_0015: ret
