TYPE TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems
METHOD System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::OnExecute() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: br.s IL_0019
IL_0004: ldarg.0
IL_0005: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToConsume
IL_000a: ldloc.0
IL_000b: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::get_Item(System.Int32)
IL_0010: call System.Void TheForestOfLove.Narrative.NarrativeActions::ConsumeInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0015: ldloc.0
IL_0016: ldc.i4.1
IL_0017: add
IL_0018: stloc.0
IL_0019: ldloc.0
IL_001a: ldarg.0
IL_001b: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToConsume
IL_0020: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::get_Count()
IL_0025: blt.s IL_0004
IL_0027: ldc.i4.0
IL_0028: stloc.1
IL_0029: br.s IL_004c
IL_002b: ldarg.0
IL_002c: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToRemove
IL_0031: ldloc.1
IL_0032: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::get_Item(System.Int32)
IL_0037: ldarg.0
IL_0038: ldfld System.Collections.Generic.List`1<System.Int32> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToRemoveQuantity
IL_003d: ldloc.1
IL_003e: callvirt !0 System.Collections.Generic.List`1<System.Int32>::get_Item(System.Int32)
IL_0043: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_0048: ldloc.1
IL_0049: ldc.i4.1
IL_004a: add
IL_004b: stloc.1
IL_004c: ldloc.1
IL_004d: ldarg.0
IL_004e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToRemove
IL_0053: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::get_Count()
IL_0058: blt.s IL_002b
IL_005a: ldc.i4.0
IL_005b: stloc.2
IL_005c: br.s IL_007f
IL_005e: ldarg.0
IL_005f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToAdd
IL_0064: ldloc.2
IL_0065: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::get_Item(System.Int32)
IL_006a: ldarg.0
IL_006b: ldfld System.Collections.Generic.List`1<System.Int32> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToAddQuantity
IL_0070: ldloc.2
IL_0071: callvirt !0 System.Collections.Generic.List`1<System.Int32>::get_Item(System.Int32)
IL_0076: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_007b: ldloc.2
IL_007c: ldc.i4.1
IL_007d: add
IL_007e: stloc.2
IL_007f: ldloc.2
IL_0080: ldarg.0
IL_0081: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToAdd
IL_0086: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::get_Count()
IL_008b: blt.s IL_005e
IL_008d: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::.ctor()
IL_0006: stfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToAdd
IL_000b: ldarg.0
IL_000c: newobj System.Void System.Collections.Generic.List`1<System.Int32>::.ctor()
IL_0011: stfld System.Collections.Generic.List`1<System.Int32> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToAddQuantity
IL_0016: ldarg.0
IL_0017: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::.ctor()
IL_001c: stfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToRemove
IL_0021: ldarg.0
IL_0022: newobj System.Void System.Collections.Generic.List`1<System.Int32>::.ctor()
IL_0027: stfld System.Collections.Generic.List`1<System.Int32> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToRemoveQuantity
IL_002c: ldarg.0
IL_002d: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType>::.ctor()
IL_0032: stfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItemType> TheForestOfLove.Narrative.DialogueTriggers.DialogueTriggerManageInventoryItems::itemsToConsume
IL_0037: ldarg.0
IL_0038: call System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger::.ctor()
IL_003d: ret
