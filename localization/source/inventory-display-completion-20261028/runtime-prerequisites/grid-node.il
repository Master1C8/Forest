TYPE TheForestOfLove.InventoryGridNode
METHOD TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::GetHighestPrioritySchema()
IL_0006: ret
METHOD System.Void TheForestOfLove.InventoryGridNode::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::.ctor()
IL_0006: stfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.InventoryGridNode::possibleSchemas
IL_000b: ldarg.0
IL_000c: newobj System.Void UnityEngine.Events.UnityEvent::.ctor()
IL_0011: stfld UnityEngine.Events.UnityEvent TheForestOfLove.InventoryGridNode::onItemAdded
IL_0016: ldarg.0
IL_0017: newobj System.Void UnityEngine.Events.UnityEvent::.ctor()
IL_001c: stfld UnityEngine.Events.UnityEvent TheForestOfLove.InventoryGridNode::onItemQuantityIncreased
IL_0021: ldarg.0
IL_0022: newobj System.Void UnityEngine.Events.UnityEvent::.ctor()
IL_0027: stfld UnityEngine.Events.UnityEvent TheForestOfLove.InventoryGridNode::onItemRemoved
IL_002c: ldarg.0
IL_002d: call System.Void System.Object::.ctor()
IL_0032: ret
