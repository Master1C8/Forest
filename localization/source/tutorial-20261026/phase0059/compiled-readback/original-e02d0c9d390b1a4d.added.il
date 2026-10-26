METHOD System.Object ForestProbe::ReadField(System.Type,System.Object,System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.2
IL_0003: ldc.i4.s 54
IL_0005: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: ldnull
IL_000d: call System.Boolean System.Reflection.FieldInfo::op_Equality(System.Reflection.FieldInfo,System.Reflection.FieldInfo)
IL_0012: stloc.1
IL_0013: ldloc.1
IL_0014: brfalse.s IL_0032
IL_0016: ldstr "Unknown declared diagnostic field: "
IL_001b: ldarg.0
IL_001c: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0021: ldstr "."
IL_0026: ldarg.2
IL_0027: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_002c: newobj System.Void System.Exception::.ctor(System.String)
IL_0031: throw
IL_0032: ldloc.0
IL_0033: ldarg.1
IL_0034: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0039: stloc.2
IL_003a: br.s IL_003c
IL_003c: ldloc.2
IL_003d: ret
