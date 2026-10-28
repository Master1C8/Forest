TYPE TheForestOfLove.Narrative.NarrativeActions
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Services.Persistence.DataService::GetInventoryItemByItemType(TheForestOfLove.Inventory.InventoryItemType)
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItem)
IL_000b: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItem) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItem,System.Int32)
IL_0007: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Services.Persistence.DataService::GetInventoryItemByItemType(TheForestOfLove.Inventory.InventoryItemType)
IL_0006: ldarg.1
IL_0007: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItem,System.Int32)
IL_000c: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItem,System.Int32) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.Inventory.InventoryItem::quantity
IL_0006: pop
IL_0007: ldarg.1
IL_0008: call System.Int32 UnityEngine.Mathf::Abs(System.Int32)
IL_000d: stloc.0
IL_000e: ldloc.0
IL_000f: brtrue.s IL_0032
IL_0011: ldstr "adding zero items for type "
IL_0016: ldarg.0
IL_0017: ldflda TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_001c: constrained. TheForestOfLove.Inventory.InventoryItemType
IL_0022: callvirt System.String System.Object::ToString()
IL_0027: call System.String System.String::Concat(System.String,System.String)
IL_002c: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0031: ret
IL_0032: ldarg.0
IL_0033: ldc.i4.0
IL_0034: stfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isConsumed
IL_0039: ldarg.0
IL_003a: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isStackable
IL_003f: brfalse.s IL_005c
IL_0041: ldarg.0
IL_0042: ldarg.0
IL_0043: ldfld System.Int32 TheForestOfLove.Inventory.InventoryItem::quantity
IL_0048: ldloc.0
IL_0049: add
IL_004a: stfld System.Int32 TheForestOfLove.Inventory.InventoryItem::quantity
IL_004f: ldsfld TheForestOfLove.Events.InventoryEvent TheForestOfLove.Events.NarrativeEvents::onInventoryItemAdded
IL_0054: ldarg.0
IL_0055: ldloc.0
IL_0056: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::Invoke(!0,!1)
IL_005b: ret
IL_005c: ldarg.0
IL_005d: ldc.i4.1
IL_005e: stfld System.Int32 TheForestOfLove.Inventory.InventoryItem::quantity
IL_0063: ldsfld TheForestOfLove.Events.InventoryEvent TheForestOfLove.Events.NarrativeEvents::onInventoryItemAdded
IL_0068: ldarg.0
IL_0069: ldc.i4.1
IL_006a: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::Invoke(!0,!1)
IL_006f: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::PlayMovie(TheForestOfLove.Narrative.Movie) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.MovieRecord TheForestOfLove.Services.Persistence.DataService::GetMovieRecordByMovie(TheForestOfLove.Narrative.Movie)
IL_0006: call System.Void TheForestOfLove.Narrative.NarrativeActions::PlayMovie(TheForestOfLove.Narrative.MovieRecord)
IL_000b: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::PlayMovie(TheForestOfLove.Narrative.MovieRecord) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "played movie "
IL_0005: ldarg.0
IL_0006: ldfld System.String TheForestOfLove.Narrative.MovieRecord::dbName
IL_000b: call System.String System.String::Concat(System.String,System.String)
IL_0010: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_0015: ldarg.0
IL_0016: ldfld TheForestOfLove.Narrative.Movie TheForestOfLove.Narrative.MovieRecord::movie
IL_001b: call System.Void TheForestOfLove.MovieManager::PlayMovie(TheForestOfLove.Narrative.Movie)
IL_0020: ret
