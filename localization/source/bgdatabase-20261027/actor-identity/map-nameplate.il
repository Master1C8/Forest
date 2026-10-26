TYPE TheForestOfLove.MapUI
METHOD System.Void TheForestOfLove.MapUI::InitCritterLocations() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation> TheForestOfLove.MapUI::critterLocations
IL_0006: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation>::Clear()
IL_000b: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Services.Persistence.DataService::GetActors()
IL_0010: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Actor>::GetEnumerator()
IL_0015: stloc.1
IL_0016: br IL_00bb
IL_001b: ldloc.1
IL_001c: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Actor>::get_Current()
IL_0021: stloc.2
IL_0022: ldloc.2
IL_0023: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isExcludedFromCritterLog
IL_0028: brtrue IL_00bb
IL_002d: newobj System.Void TheForestOfLove.MapUI/CritterLocation::.ctor()
IL_0032: stloc.3
IL_0033: ldloc.3
IL_0034: ldloc.2
IL_0035: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_003a: stfld System.String TheForestOfLove.MapUI/CritterLocation::actorDbName
IL_003f: ldloc.3
IL_0040: ldloc.2
IL_0041: callvirt System.String TheForestOfLove.Narrative.Actor::get_NameplateName()
IL_0046: stfld System.String TheForestOfLove.MapUI/CritterLocation::displayName
IL_004b: ldloc.3
IL_004c: ldarg.0
IL_004d: ldloc.2
IL_004e: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0053: call UnityEngine.Vector2 TheForestOfLove.MapUI::GetActorLocation(System.String)
IL_0058: stfld UnityEngine.Vector2 TheForestOfLove.MapUI/CritterLocation::location
IL_005d: ldloc.3
IL_005e: ldloc.2
IL_005f: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_0064: stfld System.Boolean TheForestOfLove.MapUI/CritterLocation::isIntroduced
IL_0069: ldloc.3
IL_006a: ldarg.0
IL_006b: ldfld TheForestOfLove.MapUIMarker TheForestOfLove.MapUI::markerTemplate
IL_0070: ldarg.0
IL_0071: ldfld UnityEngine.GameObject TheForestOfLove.MapUI::markerContainer
IL_0076: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_007b: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.MapUIMarker>(!!0,UnityEngine.Transform)
IL_0080: stfld TheForestOfLove.MapUIMarker TheForestOfLove.MapUI/CritterLocation::marker
IL_0085: ldloc.3
IL_0086: ldfld TheForestOfLove.MapUIMarker TheForestOfLove.MapUI/CritterLocation::marker
IL_008b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0090: ldc.i4.1
IL_0091: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0096: ldarg.0
IL_0097: ldfld System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation> TheForestOfLove.MapUI::critterLocations
IL_009c: ldloc.3
IL_009d: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation>::Add(!0)
IL_00a2: ldloc.3
IL_00a3: callvirt System.Boolean TheForestOfLove.MapUI/CritterLocation::get_IsSelectable()
IL_00a8: brfalse.s IL_00bb
IL_00aa: ldloc.3
IL_00ab: ldfld TheForestOfLove.MapUIMarker TheForestOfLove.MapUI/CritterLocation::marker
IL_00b0: ldloc.3
IL_00b1: ldfld UnityEngine.Vector2 TheForestOfLove.MapUI/CritterLocation::location
IL_00b6: callvirt System.Void TheForestOfLove.MapUIMarker::ShowNormal(UnityEngine.Vector2)
IL_00bb: ldloc.1
IL_00bc: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_00c1: brtrue IL_001b
IL_00c6: leave.s IL_00d2
IL_00c8: ldloc.1
IL_00c9: brfalse.s IL_00d1
IL_00cb: ldloc.1
IL_00cc: callvirt System.Void System.IDisposable::Dispose()
IL_00d1: endfinally
IL_00d2: ldc.i4.m1
IL_00d3: stloc.0
IL_00d4: ldarg.0
IL_00d5: ldloc.0
IL_00d6: call System.Int32 TheForestOfLove.MapUI::GetRightPage(System.Int32)
IL_00db: stloc.0
IL_00dc: ldloc.0
IL_00dd: ldarg.0
IL_00de: ldfld System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation> TheForestOfLove.MapUI::critterLocations
IL_00e3: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation>::get_Count()
IL_00e8: ldc.i4.1
IL_00e9: sub
IL_00ea: bge.s IL_00ff
IL_00ec: ldarg.0
IL_00ed: ldfld System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation> TheForestOfLove.MapUI::critterLocations
IL_00f2: ldloc.0
IL_00f3: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.MapUI/CritterLocation>::get_Item(System.Int32)
IL_00f8: callvirt System.Boolean TheForestOfLove.MapUI/CritterLocation::get_IsSelectable()
IL_00fd: brfalse.s IL_00d4
IL_00ff: ldarg.0
IL_0100: ldloc.0
IL_0101: call System.Void TheForestOfLove.MapUI::UpdateSelectedIndex(System.Int32)
IL_0106: ret
