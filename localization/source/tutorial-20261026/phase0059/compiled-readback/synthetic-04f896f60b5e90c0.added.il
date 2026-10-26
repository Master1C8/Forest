METHOD System.String ForestProbe::BuckyCallback(System.Delegate) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldnull
IL_0003: ceq
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: brfalse.s IL_0011
IL_0009: ldstr "null"
IL_000e: stloc.1
IL_000f: br.s IL_005e
IL_0011: ldc.i4.5
IL_0012: newarr System.String
IL_0017: dup
IL_0018: ldc.i4.0
IL_0019: ldarg.0
IL_001a: callvirt System.Object System.Delegate::get_Target()
IL_001f: call System.String ForestProbe::ObjectAddress(System.Object)
IL_0024: stelem.ref
IL_0025: dup
IL_0026: ldc.i4.1
IL_0027: ldstr "::"
IL_002c: stelem.ref
IL_002d: dup
IL_002e: ldc.i4.2
IL_002f: ldarg.0
IL_0030: callvirt System.Reflection.MethodInfo System.Delegate::get_Method()
IL_0035: callvirt System.Type System.Reflection.MemberInfo::get_DeclaringType()
IL_003a: callvirt System.String System.Type::get_FullName()
IL_003f: stelem.ref
IL_0040: dup
IL_0041: ldc.i4.3
IL_0042: ldstr "::"
IL_0047: stelem.ref
IL_0048: dup
IL_0049: ldc.i4.4
IL_004a: ldarg.0
IL_004b: callvirt System.Reflection.MethodInfo System.Delegate::get_Method()
IL_0050: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0055: stelem.ref
IL_0056: call System.String System.String::Concat(System.String[])
IL_005b: stloc.1
IL_005c: br.s IL_005e
IL_005e: ldloc.1
IL_005f: ret
