TYPE TheForestOfLove.DevConsoleCommands/InventoryCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands::Add(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.InventoryRedux>()
IL_0005: ldnull
IL_0006: stloc.0
IL_0007: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.InventoryRedux::activeSchemas
IL_000c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::GetEnumerator()
IL_0011: stloc.1
IL_0012: br.s IL_0047
IL_0014: ldloca.s V_1
IL_0016: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::get_Current()
IL_001b: stloc.2
IL_001c: ldloc.2
IL_001d: ldfld System.String TheForestOfLove.Inventory.InventoryItem::dbName
IL_0022: ldstr " "
IL_0027: ldsfld System.String System.String::Empty
IL_002c: callvirt System.String System.String::Replace(System.String,System.String)
IL_0031: callvirt System.String System.String::ToLower()
IL_0036: ldarg.0
IL_0037: callvirt System.String System.String::ToLower()
IL_003c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0041: brfalse.s IL_0047
IL_0043: ldloc.2
IL_0044: stloc.0
IL_0045: leave.s IL_0060
IL_0047: ldloca.s V_1
IL_0049: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::MoveNext()
IL_004e: brtrue.s IL_0014
IL_0050: leave.s IL_0060
IL_0052: ldloca.s V_1
IL_0054: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>
IL_005a: callvirt System.Void System.IDisposable::Dispose()
IL_005f: endfinally
IL_0060: ldloc.0
IL_0061: brfalse.s IL_007c
IL_0063: ldc.i4.1
IL_0064: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_0069: ldloc.0
IL_006a: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_006f: ldc.i4.1
IL_0070: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_0075: ldc.i4.0
IL_0076: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_007b: ret
IL_007c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0081: ldstr "unknown item type "
IL_0086: ldarg.0
IL_0087: call System.String System.String::Concat(System.String,System.String)
IL_008c: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0091: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands::PlayerHas(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.InventoryRedux>()
IL_0005: ldnull
IL_0006: stloc.0
IL_0007: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.InventoryRedux::activeSchemas
IL_000c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::GetEnumerator()
IL_0011: stloc.1
IL_0012: br.s IL_0047
IL_0014: ldloca.s V_1
IL_0016: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::get_Current()
IL_001b: stloc.2
IL_001c: ldloc.2
IL_001d: ldfld System.String TheForestOfLove.Inventory.InventoryItem::dbName
IL_0022: ldstr " "
IL_0027: ldsfld System.String System.String::Empty
IL_002c: callvirt System.String System.String::Replace(System.String,System.String)
IL_0031: callvirt System.String System.String::ToLower()
IL_0036: ldarg.0
IL_0037: callvirt System.String System.String::ToLower()
IL_003c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0041: brfalse.s IL_0047
IL_0043: ldloc.2
IL_0044: stloc.0
IL_0045: leave.s IL_0060
IL_0047: ldloca.s V_1
IL_0049: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::MoveNext()
IL_004e: brtrue.s IL_0014
IL_0050: leave.s IL_0060
IL_0052: ldloca.s V_1
IL_0054: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>
IL_005a: callvirt System.Void System.IDisposable::Dispose()
IL_005f: endfinally
IL_0060: ldloc.0
IL_0061: brfalse.s IL_009c
IL_0063: ldloc.0
IL_0064: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_0069: call System.Boolean TheForestOfLove.Narrative.NarrativeActions::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_006e: brfalse.s IL_0086
IL_0070: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0075: ldstr "player has item "
IL_007a: ldarg.0
IL_007b: call System.String System.String::Concat(System.String,System.String)
IL_0080: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0085: ret
IL_0086: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_008b: ldstr "player does not have item "
IL_0090: ldarg.0
IL_0091: call System.String System.String::Concat(System.String,System.String)
IL_0096: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_009b: ret
IL_009c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00a1: ldstr "unknown item type "
IL_00a6: ldarg.0
IL_00a7: call System.String System.String::Concat(System.String,System.String)
IL_00ac: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_00b1: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands::Remove(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.InventoryRedux>()
IL_0005: ldnull
IL_0006: stloc.0
IL_0007: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.InventoryRedux::activeSchemas
IL_000c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::GetEnumerator()
IL_0011: stloc.1
IL_0012: br.s IL_0047
IL_0014: ldloca.s V_1
IL_0016: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::get_Current()
IL_001b: stloc.2
IL_001c: ldloc.2
IL_001d: ldfld System.String TheForestOfLove.Inventory.InventoryItem::dbName
IL_0022: ldstr " "
IL_0027: ldsfld System.String System.String::Empty
IL_002c: callvirt System.String System.String::Replace(System.String,System.String)
IL_0031: callvirt System.String System.String::ToLower()
IL_0036: ldarg.0
IL_0037: callvirt System.String System.String::ToLower()
IL_003c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0041: brfalse.s IL_0047
IL_0043: ldloc.2
IL_0044: stloc.0
IL_0045: leave.s IL_0060
IL_0047: ldloca.s V_1
IL_0049: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::MoveNext()
IL_004e: brtrue.s IL_0014
IL_0050: leave.s IL_0060
IL_0052: ldloca.s V_1
IL_0054: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>
IL_005a: callvirt System.Void System.IDisposable::Dispose()
IL_005f: endfinally
IL_0060: ldloc.0
IL_0061: brfalse.s IL_007c
IL_0063: ldc.i4.1
IL_0064: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_0069: ldloc.0
IL_006a: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_006f: ldc.i4.1
IL_0070: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_0075: ldc.i4.0
IL_0076: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_007b: ret
IL_007c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0081: ldstr "unknown item type "
IL_0086: ldarg.0
IL_0087: call System.String System.String::Concat(System.String,System.String)
IL_008c: callvirt System.Void SickDev.DevConsole.DevConsole::LogError(System.String)
IL_0091: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands::Search(System.String) | attributes=Public, Static, HideBySig | impl=IL
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
IL_0023: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.InventoryRedux>()
IL_0028: dup
IL_0029: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.InventoryRedux::activeSchemas
IL_002e: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::get_Count()
IL_0033: newobj System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode>::.ctor(System.Int32)
IL_0038: stloc.2
IL_0039: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.InventoryRedux::activeSchemas
IL_003e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::GetEnumerator()
IL_0043: stloc.s V_7
IL_0045: br IL_010c
IL_004a: ldloca.s V_7
IL_004c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::get_Current()
IL_0051: stloc.s V_8
IL_0053: ldc.i4.0
IL_0054: stloc.1
IL_0055: ldloc.s V_8
IL_0057: ldfld System.String TheForestOfLove.Inventory.InventoryItem::dbName
IL_005c: ldstr " "
IL_0061: ldloc.s V_8
IL_0063: ldfld System.String TheForestOfLove.Inventory.InventoryItem::description
IL_0068: call System.String System.String::Concat(System.String,System.String,System.String)
IL_006d: stloc.s V_9
IL_006f: ldloc.s V_9
IL_0071: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0076: brtrue IL_010c
IL_007b: ldloc.s V_8
IL_007d: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isInactive
IL_0082: brtrue IL_010c
IL_0087: ldloc.s V_9
IL_0089: callvirt System.String System.String::ToLower()
IL_008e: stloc.s V_9
IL_0090: ldloc.0
IL_0091: stloc.s V_10
IL_0093: ldc.i4.0
IL_0094: stloc.s V_11
IL_0096: br.s IL_00f5
IL_0098: ldloc.s V_10
IL_009a: ldloc.s V_11
IL_009c: ldelem.ref
IL_009d: stloc.s V_12
IL_009f: ldsfld System.Collections.Generic.List`1<System.String> TheForestOfLove.DevConsoleCommands/InventoryCommands::tokensToCountOnce
IL_00a4: ldloc.s V_12
IL_00a6: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_00ab: brfalse.s IL_00c1
IL_00ad: ldloc.1
IL_00ae: ldloc.s V_9
IL_00b0: ldloc.s V_12
IL_00b2: callvirt System.Boolean System.String::Contains(System.String)
IL_00b7: brtrue.s IL_00bc
IL_00b9: ldc.i4.0
IL_00ba: br.s IL_00bd
IL_00bc: ldc.i4.1
IL_00bd: sub
IL_00be: stloc.1
IL_00bf: br.s IL_00ef
IL_00c1: ldloc.s V_9
IL_00c3: stloc.s V_13
IL_00c5: ldloc.s V_13
IL_00c7: callvirt System.Int32 System.String::get_Length()
IL_00cc: ldloc.s V_13
IL_00ce: ldloc.s V_12
IL_00d0: ldsfld System.String System.String::Empty
IL_00d5: callvirt System.String System.String::Replace(System.String,System.String)
IL_00da: callvirt System.Int32 System.String::get_Length()
IL_00df: sub
IL_00e0: ldloc.s V_12
IL_00e2: callvirt System.Int32 System.String::get_Length()
IL_00e7: div
IL_00e8: stloc.s V_14
IL_00ea: ldloc.1
IL_00eb: ldloc.s V_14
IL_00ed: sub
IL_00ee: stloc.1
IL_00ef: ldloc.s V_11
IL_00f1: ldc.i4.1
IL_00f2: add
IL_00f3: stloc.s V_11
IL_00f5: ldloc.s V_11
IL_00f7: ldloc.s V_10
IL_00f9: ldlen
IL_00fa: conv.i4
IL_00fb: blt.s IL_0098
IL_00fd: ldloc.2
IL_00fe: ldloc.s V_8
IL_0100: newobj System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode::.ctor(TheForestOfLove.Inventory.InventoryItem)
IL_0105: ldloc.1
IL_0106: conv.r4
IL_0107: callvirt System.Void TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode>::Enqueue(T,System.Single)
IL_010c: ldloca.s V_7
IL_010e: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::MoveNext()
IL_0113: brtrue IL_004a
IL_0118: leave.s IL_0128
IL_011a: ldloca.s V_7
IL_011c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>
IL_0122: callvirt System.Void System.IDisposable::Dispose()
IL_0127: endfinally
IL_0128: ldc.i4.s 10
IL_012a: stloc.3
IL_012b: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0130: callvirt System.Void SickDev.DevConsole.DevConsole::ClearLog()
IL_0135: ldloca.s V_4
IL_0137: initobj SickDev.DevConsole.EntryOptions
IL_013d: ldloca.s V_5
IL_013f: initobj SickDev.DevConsole.EntryOptions
IL_0145: ldloca.s V_4
IL_0147: ldc.r4 0.2509804
IL_014c: ldc.r4 0.5647059
IL_0151: ldc.r4 0.2509804
IL_0156: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_015b: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_0160: ldloca.s V_5
IL_0162: ldc.r4 0.2509804
IL_0167: ldc.r4 0.76862746
IL_016c: ldc.r4 0.2509804
IL_0171: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)
IL_0176: call System.Void SickDev.DevConsole.EntryOptions::set_color(UnityEngine.Color)
IL_017b: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0180: ldsfld System.String System.String::Empty
IL_0185: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String)
IL_018a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_018f: ldstr "top "
IL_0194: ldloca.s V_3
IL_0196: call System.String System.Int32::ToString()
IL_019b: ldstr " matching items:"
IL_01a0: call System.String System.String::Concat(System.String,System.String,System.String)
IL_01a5: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_01aa: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode>::.ctor()
IL_01af: stloc.s V_6
IL_01b1: br.s IL_01c0
IL_01b3: ldloc.s V_6
IL_01b5: ldloc.2
IL_01b6: callvirt T TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode>::Dequeue()
IL_01bb: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode>::Add(!0)
IL_01c0: ldloc.2
IL_01c1: callvirt System.Int32 TheForestOfLove.Core.DataStructures.FastPriorityQueue`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode>::get_Count()
IL_01c6: ldc.i4.0
IL_01c7: bgt.s IL_01b3
IL_01c9: ldloc.s V_6
IL_01cb: ldsfld System.Comparison`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode> TheForestOfLove.DevConsoleCommands/InventoryCommands/<>c::<>9__7_0
IL_01d0: dup
IL_01d1: brtrue.s IL_01ea
IL_01d3: pop
IL_01d4: ldsfld TheForestOfLove.DevConsoleCommands/InventoryCommands/<>c TheForestOfLove.DevConsoleCommands/InventoryCommands/<>c::<>9
IL_01d9: ldftn System.Int32 TheForestOfLove.DevConsoleCommands/InventoryCommands/<>c::<Search>b__7_0(TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode,TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode)
IL_01df: newobj System.Void System.Comparison`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode>::.ctor(System.Object,System.IntPtr)
IL_01e4: dup
IL_01e5: stsfld System.Comparison`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode> TheForestOfLove.DevConsoleCommands/InventoryCommands/<>c::<>9__7_0
IL_01ea: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode>::Sort(System.Comparison`1<!0>)
IL_01ef: ldc.i4.0
IL_01f0: stloc.s V_15
IL_01f2: br.s IL_0263
IL_01f4: ldloc.s V_6
IL_01f6: ldloc.s V_15
IL_01f8: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode>::get_Item(System.Int32)
IL_01fd: stloc.s V_16
IL_01ff: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0204: ldstr "({0}) {1} | {2}"
IL_0209: ldloc.s V_16
IL_020b: callvirt System.Single TheForestOfLove.Core.DataStructures.FastPriorityQueueNode::get_Priority()
IL_0210: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0215: conv.i4
IL_0216: box System.Int32
IL_021b: ldloc.s V_16
IL_021d: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode::schema
IL_0222: ldfld System.String TheForestOfLove.Inventory.InventoryItem::dbName
IL_0227: ldstr " "
IL_022c: ldsfld System.String System.String::Empty
IL_0231: callvirt System.String System.String::Replace(System.String,System.String)
IL_0236: callvirt System.String System.String::ToLower()
IL_023b: ldloc.s V_16
IL_023d: ldfld TheForestOfLove.Inventory.InventoryItem TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode::schema
IL_0242: ldfld System.String TheForestOfLove.Inventory.InventoryItem::description
IL_0247: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_024c: ldloc.s V_15
IL_024e: ldc.i4.2
IL_024f: rem
IL_0250: brfalse.s IL_0256
IL_0252: ldloc.s V_5
IL_0254: br.s IL_0258
IL_0256: ldloc.s V_4
IL_0258: callvirt System.Void SickDev.DevConsole.DevConsole::Log(System.String,SickDev.DevConsole.EntryOptions)
IL_025d: ldloc.s V_15
IL_025f: ldc.i4.1
IL_0260: add
IL_0261: stloc.s V_15
IL_0263: ldloc.s V_15
IL_0265: ldloc.3
IL_0266: bge.s IL_0273
IL_0268: ldloc.s V_15
IL_026a: ldloc.s V_6
IL_026c: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DevConsoleCommands/InventoryCommands/QueueNode>::get_Count()
IL_0271: blt.s IL_01f4
IL_0273: ret
