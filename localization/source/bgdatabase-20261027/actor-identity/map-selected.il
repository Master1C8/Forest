TYPE TheForestOfLove.MapUI
METHOD System.Void TheForestOfLove.MapUI::UpdateSelectedIndex(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation> TheForestOfLove.MapUI::critterLocations
IL_0006: ldarg.0
IL_0007: ldfld System.Int32 TheForestOfLove.MapUI::selectedIndex
IL_000c: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation>::get_Item(System.Int32)
IL_0011: stloc.0
IL_0012: ldloc.0
IL_0013: ldfld TheForestOfLove.MapUIMarker TheForestOfLove.MapUI/CritterLocation::marker
IL_0018: ldloc.0
IL_0019: ldfld UnityEngine.Vector2 TheForestOfLove.MapUI/CritterLocation::location
IL_001e: callvirt System.Void TheForestOfLove.MapUIMarker::ShowNormal(UnityEngine.Vector2)
IL_0023: ldarg.0
IL_0024: ldarg.1
IL_0025: stfld System.Int32 TheForestOfLove.MapUI::selectedIndex
IL_002a: ldarg.0
IL_002b: ldfld System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation> TheForestOfLove.MapUI::critterLocations
IL_0030: ldarg.0
IL_0031: ldfld System.Int32 TheForestOfLove.MapUI::selectedIndex
IL_0036: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation>::get_Item(System.Int32)
IL_003b: stloc.1
IL_003c: ldarg.0
IL_003d: ldloc.1
IL_003e: ldfld System.String TheForestOfLove.MapUI/CritterLocation::displayName
IL_0043: call System.Void TheForestOfLove.MapUI::SetSelectionLabelText(System.String)
IL_0048: ldloc.1
IL_0049: ldfld TheForestOfLove.MapUIMarker TheForestOfLove.MapUI/CritterLocation::marker
IL_004e: ldloc.1
IL_004f: ldfld UnityEngine.Vector2 TheForestOfLove.MapUI/CritterLocation::location
IL_0054: callvirt System.Void TheForestOfLove.MapUIMarker::ShowSelected(UnityEngine.Vector2)
IL_0059: ldloc.1
IL_005a: ldfld TheForestOfLove.MapUIMarker TheForestOfLove.MapUI/CritterLocation::marker
IL_005f: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0064: ldarg.0
IL_0065: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_006a: ldc.i4.1
IL_006b: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_0070: ldloc.1
IL_0071: ldfld TheForestOfLove.MapUIMarker TheForestOfLove.MapUI/CritterLocation::marker
IL_0076: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_007b: ldarg.0
IL_007c: ldfld UnityEngine.GameObject TheForestOfLove.MapUI::markerContainer
IL_0081: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0086: ldc.i4.1
IL_0087: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_008c: ret
