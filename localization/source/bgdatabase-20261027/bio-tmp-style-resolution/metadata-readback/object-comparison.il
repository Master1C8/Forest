TYPE UnityEngine.Object
METHOD System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: call System.Boolean UnityEngine.Object::CompareBaseObjects(UnityEngine.Object,UnityEngine.Object)
IL_0008: stloc.0
IL_0009: br.s IL_000b
IL_000b: ldloc.0
IL_000c: ret
METHOD System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: call System.Boolean UnityEngine.Object::CompareBaseObjects(UnityEngine.Object,UnityEngine.Object)
IL_0008: ldc.i4.0
IL_0009: ceq
IL_000b: stloc.0
IL_000c: br.s IL_000e
IL_000e: ldloc.0
IL_000f: ret
