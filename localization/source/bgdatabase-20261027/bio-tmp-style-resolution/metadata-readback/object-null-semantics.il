TYPE UnityEngine.Object
METHOD System.Boolean UnityEngine.Object::CompareBaseObjects(UnityEngine.Object,UnityEngine.Object) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldnull
IL_0003: ceq
IL_0005: stloc.0
IL_0006: ldarg.1
IL_0007: ldnull
IL_0008: ceq
IL_000a: stloc.1
IL_000b: ldloc.1
IL_000c: ldloc.0
IL_000d: and
IL_000e: stloc.2
IL_000f: ldloc.2
IL_0010: brfalse.s IL_0016
IL_0012: ldc.i4.1
IL_0013: stloc.3
IL_0014: br.s IL_0043
IL_0016: ldloc.1
IL_0017: stloc.s V_4
IL_0019: ldloc.s V_4
IL_001b: brfalse.s IL_0029
IL_001d: ldarg.0
IL_001e: call System.Boolean UnityEngine.Object::IsNativeObjectAlive(UnityEngine.Object)
IL_0023: ldc.i4.0
IL_0024: ceq
IL_0026: stloc.3
IL_0027: br.s IL_0043
IL_0029: ldloc.0
IL_002a: stloc.s V_5
IL_002c: ldloc.s V_5
IL_002e: brfalse.s IL_003c
IL_0030: ldarg.1
IL_0031: call System.Boolean UnityEngine.Object::IsNativeObjectAlive(UnityEngine.Object)
IL_0036: ldc.i4.0
IL_0037: ceq
IL_0039: stloc.3
IL_003a: br.s IL_0043
IL_003c: ldarg.0
IL_003d: ldarg.1
IL_003e: ceq
IL_0040: stloc.3
IL_0041: br.s IL_0043
IL_0043: ldloc.3
IL_0044: ret
METHOD System.Boolean UnityEngine.Object::IsNativeObjectAlive(UnityEngine.Object) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: callvirt System.IntPtr UnityEngine.Object::GetCachedPtr()
IL_0007: ldsfld System.IntPtr System.IntPtr::Zero
IL_000c: call System.Boolean System.IntPtr::op_Inequality(System.IntPtr,System.IntPtr)
IL_0011: stloc.0
IL_0012: br.s IL_0014
IL_0014: ldloc.0
IL_0015: ret
METHOD System.IntPtr UnityEngine.Object::GetCachedPtr() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.IntPtr UnityEngine.Object::m_CachedPtr
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
