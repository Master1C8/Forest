TYPE Tantawowa.TimelineEvents.TimelineEventBehaviour
METHOD System.Void Tantawowa.TimelineEvents.TimelineEventBehaviour::GetBehaviourAndMethod(System.Boolean,System.String,UnityEngine.Behaviour&,System.String&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_001d
IL_0003: ldarg.2
IL_0004: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0009: brtrue.s IL_001d
IL_000b: ldarg.2
IL_000c: callvirt System.String System.String::ToLower()
IL_0011: ldstr "none"
IL_0016: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_001b: brfalse.s IL_001e
IL_001d: ret
IL_001e: ldarg.2
IL_001f: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0024: brtrue IL_00f0
IL_0029: ldarg.2
IL_002a: ldc.i4.s 46
IL_002c: callvirt System.Int32 System.String::LastIndexOf(System.Char)
IL_0031: stloc.0
IL_0032: ldarg.2
IL_0033: ldc.i4.0
IL_0034: ldloc.0
IL_0035: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_003a: stloc.1
IL_003b: ldarg.s methodName
IL_003d: ldarg.2
IL_003e: ldloc.0
IL_003f: ldc.i4.1
IL_0040: add
IL_0041: ldarg.2
IL_0042: callvirt System.Int32 System.String::get_Length()
IL_0047: ldloc.0
IL_0048: ldc.i4.1
IL_0049: add
IL_004a: sub
IL_004b: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0050: stind.ref
IL_0051: ldloc.1
IL_0052: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0057: brtrue.s IL_0063
IL_0059: ldarg.s methodName
IL_005b: ldind.ref
IL_005c: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0061: brfalse.s IL_0074
IL_0063: ldstr "Unable to parse callback method: "
IL_0068: ldarg.2
IL_0069: call System.String System.String::Concat(System.String,System.String)
IL_006e: newobj System.Void System.Exception::.ctor(System.String)
IL_0073: throw
IL_0074: ldarg.3
IL_0075: ldnull
IL_0076: stind.ref
IL_0077: ldarg.0
IL_0078: ldfld UnityEngine.GameObject Tantawowa.TimelineEvents.TimelineEventBehaviour::TargetObject
IL_007d: ldnull
IL_007e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0083: brfalse.s IL_0096
IL_0085: ldstr "No target set for key "
IL_008a: ldarg.2
IL_008b: call System.String System.String::Concat(System.String,System.String)
IL_0090: newobj System.Void System.Exception::.ctor(System.String)
IL_0095: throw
IL_0096: ldarg.0
IL_0097: ldfld UnityEngine.GameObject Tantawowa.TimelineEvents.TimelineEventBehaviour::TargetObject
IL_009c: callvirt !!0[] UnityEngine.GameObject::GetComponents<UnityEngine.Behaviour>()
IL_00a1: stloc.2
IL_00a2: ldc.i4.0
IL_00a3: stloc.3
IL_00a4: br.s IL_00c9
IL_00a6: ldloc.2
IL_00a7: ldloc.3
IL_00a8: ldelem.ref
IL_00a9: stloc.s V_4
IL_00ab: ldloc.1
IL_00ac: ldloc.s V_4
IL_00ae: callvirt System.Type System.Object::GetType()
IL_00b3: callvirt System.String System.Object::ToString()
IL_00b8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00bd: brfalse.s IL_00c5
IL_00bf: ldarg.3
IL_00c0: ldloc.s V_4
IL_00c2: stind.ref
IL_00c3: br.s IL_00cf
IL_00c5: ldloc.3
IL_00c6: ldc.i4.1
IL_00c7: add
IL_00c8: stloc.3
IL_00c9: ldloc.3
IL_00ca: ldloc.2
IL_00cb: ldlen
IL_00cc: conv.i4
IL_00cd: blt.s IL_00a6
IL_00cf: ldarg.3
IL_00d0: ldind.ref
IL_00d1: ldnull
IL_00d2: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00d7: brfalse.s IL_00f0
IL_00d9: ldstr "Unable to find target behaviour: key "
IL_00de: ldarg.2
IL_00df: ldstr " typename "
IL_00e4: ldloc.1
IL_00e5: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00ea: newobj System.Void System.Exception::.ctor(System.String)
IL_00ef: throw
IL_00f0: ret
