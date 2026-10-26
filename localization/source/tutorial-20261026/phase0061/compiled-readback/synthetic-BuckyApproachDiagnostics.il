METHOD System.String[] ForestProbe::BuckyApproachDiagnostics() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: call System.String[] ForestProbe::BuckyInteractionDiagnostics()
IL_0007: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_000c: stloc.0
IL_000d: ldloc.0
IL_000e: ldarg.0
IL_000f: call System.String[] ForestProbe::TutorialRouteDiagnostics()
IL_0014: callvirt System.Void System.Collections.Generic.List`1<System.String>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_0019: nop
IL_001a: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_001f: stloc.1
IL_0020: ldloc.1
IL_0021: ldnull
IL_0022: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0027: stloc.2
IL_0028: ldloc.2
IL_0029: brfalse.s IL_0036
IL_002b: ldstr "Bucky motion Player missing"
IL_0030: newobj System.Void System.Exception::.ctor(System.String)
IL_0035: throw
IL_0036: ldloc.0
IL_0037: ldc.i4.s 14
IL_0039: newarr System.String
IL_003e: dup
IL_003f: ldc.i4.0
IL_0040: ldstr "buckyMotion | movement="
IL_0045: stelem.ref
IL_0046: dup
IL_0047: ldc.i4.1
IL_0048: ldloc.1
IL_0049: ldstr "enableMovement"
IL_004e: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0053: dup
IL_0054: brtrue.s IL_005a
IL_0056: pop
IL_0057: ldnull
IL_0058: br.s IL_005f
IL_005a: callvirt System.String System.Object::ToString()
IL_005f: stelem.ref
IL_0060: dup
IL_0061: ldc.i4.2
IL_0062: ldstr " | lanternTransition="
IL_0067: stelem.ref
IL_0068: dup
IL_0069: ldc.i4.3
IL_006a: ldloc.1
IL_006b: callvirt System.Boolean TheForestOfLove.Player::get_lanternTransitioning()
IL_0070: stloc.3
IL_0071: ldloca.s V_3
IL_0073: call System.String System.Boolean::ToString()
IL_0078: stelem.ref
IL_0079: dup
IL_007a: ldc.i4.4
IL_007b: ldstr " | sweaterTransition="
IL_0080: stelem.ref
IL_0081: dup
IL_0082: ldc.i4.5
IL_0083: ldloc.1
IL_0084: callvirt System.Boolean TheForestOfLove.Player::get_sweaterTransitioning()
IL_0089: stloc.3
IL_008a: ldloca.s V_3
IL_008c: call System.String System.Boolean::ToString()
IL_0091: stelem.ref
IL_0092: dup
IL_0093: ldc.i4.6
IL_0094: ldstr " | swim="
IL_0099: stelem.ref
IL_009a: dup
IL_009b: ldc.i4.7
IL_009c: ldloc.1
IL_009d: ldstr "playerSwimTransition"
IL_00a2: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_00a7: call System.String ForestProbe::ObjectAddress(System.Object)
IL_00ac: stelem.ref
IL_00ad: dup
IL_00ae: ldc.i4.8
IL_00af: ldstr " | waypoints="
IL_00b4: stelem.ref
IL_00b5: dup
IL_00b6: ldc.i4.s 9
IL_00b8: ldloc.1
IL_00b9: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_00be: ldnull
IL_00bf: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00c4: brtrue.s IL_00db
IL_00c6: ldloc.1
IL_00c7: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_00cc: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_00d1: stloc.3
IL_00d2: ldloca.s V_3
IL_00d4: call System.String System.Boolean::ToString()
IL_00d9: br.s IL_00e0
IL_00db: ldstr "absent"
IL_00e0: stelem.ref
IL_00e1: dup
IL_00e2: ldc.i4.s 10
IL_00e4: ldstr " | speed="
IL_00e9: stelem.ref
IL_00ea: dup
IL_00eb: ldc.i4.s 11
IL_00ed: ldloc.1
IL_00ee: ldstr "speed"
IL_00f3: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_00f8: unbox.any UnityEngine.Vector2
IL_00fd: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0102: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_0107: stelem.ref
IL_0108: dup
IL_0109: ldc.i4.s 12
IL_010b: ldstr " | currentSpeed="
IL_0110: stelem.ref
IL_0111: dup
IL_0112: ldc.i4.s 13
IL_0114: ldloc.1
IL_0115: ldstr "currentSpeed"
IL_011a: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_011f: unbox.any UnityEngine.Vector2
IL_0124: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0129: call System.String ForestProbe::Vector(UnityEngine.Vector3)
IL_012e: stelem.ref
IL_012f: call System.String System.String::Concat(System.String[])
IL_0134: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0139: nop
IL_013a: ldloc.0
IL_013b: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0140: stloc.s V_4
IL_0142: br.s IL_0144
IL_0144: ldloc.s V_4
IL_0146: ret
