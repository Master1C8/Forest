TYPE TheForestOfLove.InventoryGridNode
METHOD TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::GetHighestPrioritySchema() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.InventoryGridNode::possibleSchemas
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::get_Count()
IL_000b: ldc.i4.0
IL_000c: bgt.s IL_0010
IL_000e: ldnull
IL_000f: ret
IL_0010: ldnull
IL_0011: stloc.0
IL_0012: ldarg.0
IL_0013: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.InventoryGridNode::possibleSchemas
IL_0018: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::GetEnumerator()
IL_001d: stloc.1
IL_001e: br.s IL_008d
IL_0020: ldloca.s V_1
IL_0022: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::get_Current()
IL_0027: stloc.2
IL_0028: ldloc.2
IL_0029: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_002e: ldc.i4 405
IL_0033: bne.un.s IL_0047
IL_0035: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_003a: brfalse.s IL_0047
IL_003c: call System.Boolean TheForestOfLove.Narrative.InstancedStoryController::GetInventoryAdventureItemPlaceholderEnabled()
IL_0041: brfalse.s IL_0047
IL_0043: ldloc.2
IL_0044: stloc.3
IL_0045: leave.s IL_00a8
IL_0047: ldloc.2
IL_0048: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_004d: ldc.i4 410
IL_0052: bne.un.s IL_005b
IL_0054: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_0059: brtrue.s IL_008d
IL_005b: ldloc.2
IL_005c: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isInactive
IL_0061: brtrue.s IL_0078
IL_0063: ldloc.2
IL_0064: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isConsumed
IL_0069: brtrue.s IL_0078
IL_006b: ldloc.2
IL_006c: ldfld System.Int32 TheForestOfLove.Inventory.InventoryItem::quantity
IL_0071: ldc.i4.0
IL_0072: ble.s IL_0078
IL_0074: ldloc.2
IL_0075: stloc.3
IL_0076: leave.s IL_00a8
IL_0078: ldloc.2
IL_0079: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isInactive
IL_007e: brtrue.s IL_008d
IL_0080: ldloc.2
IL_0081: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isConsumed
IL_0086: brfalse.s IL_008d
IL_0088: ldloc.0
IL_0089: brtrue.s IL_008d
IL_008b: ldloc.2
IL_008c: stloc.0
IL_008d: ldloca.s V_1
IL_008f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::MoveNext()
IL_0094: brtrue.s IL_0020
IL_0096: leave.s IL_00a6
IL_0098: ldloca.s V_1
IL_009a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>
IL_00a0: callvirt System.Void System.IDisposable::Dispose()
IL_00a5: endfinally
IL_00a6: ldloc.0
IL_00a7: ret
IL_00a8: ldloc.3
IL_00a9: ret
