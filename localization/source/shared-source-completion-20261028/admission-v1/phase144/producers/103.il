TYPE TheForestOfLove.InventoryRedux
METHOD System.Void TheForestOfLove.InventoryRedux::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.InventoryRedux::debugGo
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.InventoryRedux::debugGo
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean TheForestOfLove.InventoryRedux::debugFillAll
IL_0016: brfalse.s IL_0053
IL_0018: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Services.Persistence.DataService::GetInventoryItems()
IL_001d: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Inventory.InventoryItem>::GetEnumerator()
IL_0022: stloc.0
IL_0023: br.s IL_003c
IL_0025: ldloc.0
IL_0026: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Inventory.InventoryItem>::get_Current()
IL_002b: ldc.i4.1
IL_002c: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_0031: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItem)
IL_0036: ldc.i4.0
IL_0037: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0042: brtrue.s IL_0025
IL_0044: leave IL_015c
IL_0049: ldloc.0
IL_004a: brfalse.s IL_0052
IL_004c: ldloc.0
IL_004d: callvirt System.Void System.IDisposable::Dispose()
IL_0052: endfinally
IL_0053: ldarg.0
IL_0054: ldfld System.Boolean TheForestOfLove.InventoryRedux::debugClearAll
IL_0059: brfalse.s IL_0096
IL_005b: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Services.Persistence.DataService::GetInventoryItems()
IL_0060: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Inventory.InventoryItem>::GetEnumerator()
IL_0065: stloc.0
IL_0066: br.s IL_007f
IL_0068: ldloc.0
IL_0069: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Inventory.InventoryItem>::get_Current()
IL_006e: ldc.i4.1
IL_006f: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_0074: call System.Void TheForestOfLove.Narrative.NarrativeActions::ClearInventoryItem(TheForestOfLove.Inventory.InventoryItem)
IL_0079: ldc.i4.0
IL_007a: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_007f: ldloc.0
IL_0080: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0085: brtrue.s IL_0068
IL_0087: leave IL_015c
IL_008c: ldloc.0
IL_008d: brfalse.s IL_0095
IL_008f: ldloc.0
IL_0090: callvirt System.Void System.IDisposable::Dispose()
IL_0095: endfinally
IL_0096: ldarg.0
IL_0097: ldfld System.Boolean TheForestOfLove.InventoryRedux::debugAdd
IL_009c: brfalse.s IL_00db
IL_009e: ldc.i4.1
IL_009f: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_00a4: ldarg.0
IL_00a5: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.InventoryRedux::debugItemType
IL_00aa: ldc.i4.1
IL_00ab: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_00b0: ldc.i4.0
IL_00b1: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_00b6: ldstr "added "
IL_00bb: ldarg.0
IL_00bc: ldflda TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.InventoryRedux::debugItemType
IL_00c1: constrained. TheForestOfLove.Inventory.InventoryItemType
IL_00c7: callvirt System.String System.Object::ToString()
IL_00cc: call System.String System.String::Concat(System.String,System.String)
IL_00d1: call System.Void UnityEngine.Debug::Log(System.Object)
IL_00d6: br IL_015c
IL_00db: ldarg.0
IL_00dc: ldfld System.Boolean TheForestOfLove.InventoryRedux::debugRemove
IL_00e1: brfalse.s IL_011d
IL_00e3: ldc.i4.1
IL_00e4: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_00e9: ldarg.0
IL_00ea: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.InventoryRedux::debugItemType
IL_00ef: ldc.i4.1
IL_00f0: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_00f5: ldc.i4.0
IL_00f6: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_00fb: ldstr "removed "
IL_0100: ldarg.0
IL_0101: ldflda TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.InventoryRedux::debugItemType
IL_0106: constrained. TheForestOfLove.Inventory.InventoryItemType
IL_010c: callvirt System.String System.Object::ToString()
IL_0111: call System.String System.String::Concat(System.String,System.String)
IL_0116: call System.Void UnityEngine.Debug::Log(System.Object)
IL_011b: br.s IL_015c
IL_011d: ldarg.0
IL_011e: ldfld System.Boolean TheForestOfLove.InventoryRedux::debugClear
IL_0123: brfalse.s IL_015c
IL_0125: ldc.i4.1
IL_0126: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_012b: ldarg.0
IL_012c: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.InventoryRedux::debugItemType
IL_0131: call System.Void TheForestOfLove.Narrative.NarrativeActions::ClearInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0136: ldc.i4.0
IL_0137: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_013c: ldstr "cleared "
IL_0141: ldarg.0
IL_0142: ldflda TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.InventoryRedux::debugItemType
IL_0147: constrained. TheForestOfLove.Inventory.InventoryItemType
IL_014d: callvirt System.String System.Object::ToString()
IL_0152: call System.String System.String::Concat(System.String,System.String)
IL_0157: call System.Void UnityEngine.Debug::Log(System.Object)
IL_015c: ldarg.0
IL_015d: ldc.i4.0
IL_015e: stfld System.Boolean TheForestOfLove.InventoryRedux::debugFillAll
IL_0163: ldarg.0
IL_0164: ldc.i4.0
IL_0165: stfld System.Boolean TheForestOfLove.InventoryRedux::debugClearAll
IL_016a: ldarg.0
IL_016b: ldc.i4.0
IL_016c: stfld System.Boolean TheForestOfLove.InventoryRedux::debugAdd
IL_0171: ldarg.0
IL_0172: ldc.i4.0
IL_0173: stfld System.Boolean TheForestOfLove.InventoryRedux::debugRemove
IL_0178: ldarg.0
IL_0179: ldc.i4.0
IL_017a: stfld System.Boolean TheForestOfLove.InventoryRedux::debugClear
IL_017f: ret
