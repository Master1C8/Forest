TYPE SickDev.CommandSystem.Signature
METHOD System.String SickDev.CommandSystem.Signature::get_raw() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.String SickDev.CommandSystem.Signature::_raw
IL_0007: ldnull
IL_0008: ceq
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: brfalse.s IL_002f
IL_000e: ldarg.0
IL_000f: ldarg.0
IL_0010: ldfld SickDev.CommandSystem.Command SickDev.CommandSystem.Signature::command
IL_0015: ldfld System.Reflection.MethodInfo SickDev.CommandSystem.Command::method
IL_001a: ldarg.0
IL_001b: ldfld SickDev.CommandSystem.Command SickDev.CommandSystem.Signature::command
IL_0020: callvirt System.String SickDev.CommandSystem.Command::get_name()
IL_0025: call System.String SickDev.CommandSystem.SignatureBuilder::Build(System.Reflection.MethodInfo,System.String)
IL_002a: stfld System.String SickDev.CommandSystem.Signature::_raw
IL_002f: ldarg.0
IL_0030: ldfld System.String SickDev.CommandSystem.Signature::_raw
IL_0035: stloc.1
IL_0036: br.s IL_0038
IL_0038: ldloc.1
IL_0039: ret
METHOD System.Void SickDev.CommandSystem.Signature::.ctor(SickDev.CommandSystem.Command) | attributes=Assembly, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: nop
IL_0008: ldarg.0
IL_0009: ldarg.1
IL_000a: stfld SickDev.CommandSystem.Command SickDev.CommandSystem.Signature::command
IL_000f: ldarg.1
IL_0010: ldfld System.Reflection.MethodInfo SickDev.CommandSystem.Command::method
IL_0015: callvirt System.Reflection.ParameterInfo[] System.Reflection.MethodBase::GetParameters()
IL_001a: newobj System.Void System.Collections.Generic.List`1<System.Reflection.ParameterInfo>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_001f: stloc.0
IL_0020: ldloc.0
IL_0021: ldsfld System.Predicate`1<System.Reflection.ParameterInfo> SickDev.CommandSystem.Signature/<>c::<>9__8_0
IL_0026: dup
IL_0027: brtrue.s IL_0040
IL_0029: pop
IL_002a: ldsfld SickDev.CommandSystem.Signature/<>c SickDev.CommandSystem.Signature/<>c::<>9
IL_002f: ldftn System.Boolean SickDev.CommandSystem.Signature/<>c::<.ctor>b__8_0(System.Reflection.ParameterInfo)
IL_0035: newobj System.Void System.Predicate`1<System.Reflection.ParameterInfo>::.ctor(System.Object,System.IntPtr)
IL_003a: dup
IL_003b: stsfld System.Predicate`1<System.Reflection.ParameterInfo> SickDev.CommandSystem.Signature/<>c::<>9__8_0
IL_0040: callvirt System.Int32 System.Collections.Generic.List`1<System.Reflection.ParameterInfo>::RemoveAll(System.Predicate`1<!0>)
IL_0045: pop
IL_0046: ldarg.0
IL_0047: ldloc.0
IL_0048: callvirt !0[] System.Collections.Generic.List`1<System.Reflection.ParameterInfo>::ToArray()
IL_004d: call System.Void SickDev.CommandSystem.Signature::set_parameters(System.Reflection.ParameterInfo[])
IL_0052: nop
IL_0053: ret
