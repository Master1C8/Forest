TYPE SickDev.CommandSystem.SignatureBuilder
METHOD System.String SickDev.CommandSystem.SignatureBuilder::Build(System.Reflection.MethodInfo,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void System.Text.StringBuilder::.ctor()
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: callvirt System.Type System.Reflection.MethodInfo::get_ReturnType()
IL_000d: ldtoken System.Void
IL_0012: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0017: ceq
IL_0019: ldc.i4.0
IL_001a: ceq
IL_001c: stloc.2
IL_001d: ldloc.2
IL_001e: brfalse.s IL_0042
IL_0020: nop
IL_0021: ldarg.0
IL_0022: callvirt System.Type System.Reflection.MethodInfo::get_ReturnType()
IL_0027: call System.String SickDev.CommandSystem.SignatureBuilder::TypeToString(System.Type)
IL_002c: stloc.3
IL_002d: ldloc.0
IL_002e: ldloc.3
IL_002f: callvirt System.Text.StringBuilder System.Text.StringBuilder::Append(System.String)
IL_0034: pop
IL_0035: ldloc.0
IL_0036: ldstr " "
IL_003b: callvirt System.Text.StringBuilder System.Text.StringBuilder::Append(System.String)
IL_0040: pop
IL_0041: nop
IL_0042: ldloc.0
IL_0043: ldarg.1
IL_0044: callvirt System.Text.StringBuilder System.Text.StringBuilder::Append(System.String)
IL_0049: pop
IL_004a: ldarg.0
IL_004b: callvirt System.Reflection.ParameterInfo[] System.Reflection.MethodBase::GetParameters()
IL_0050: newobj System.Void System.Collections.Generic.List`1<System.Reflection.ParameterInfo>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0055: stloc.1
IL_0056: ldloc.1
IL_0057: ldsfld System.Predicate`1<System.Reflection.ParameterInfo> SickDev.CommandSystem.SignatureBuilder/<>c::<>9__1_0
IL_005c: dup
IL_005d: brtrue.s IL_0076
IL_005f: pop
IL_0060: ldsfld SickDev.CommandSystem.SignatureBuilder/<>c SickDev.CommandSystem.SignatureBuilder/<>c::<>9
IL_0065: ldftn System.Boolean SickDev.CommandSystem.SignatureBuilder/<>c::<Build>b__1_0(System.Reflection.ParameterInfo)
IL_006b: newobj System.Void System.Predicate`1<System.Reflection.ParameterInfo>::.ctor(System.Object,System.IntPtr)
IL_0070: dup
IL_0071: stsfld System.Predicate`1<System.Reflection.ParameterInfo> SickDev.CommandSystem.SignatureBuilder/<>c::<>9__1_0
IL_0076: callvirt System.Int32 System.Collections.Generic.List`1<System.Reflection.ParameterInfo>::RemoveAll(System.Predicate`1<!0>)
IL_007b: pop
IL_007c: ldloc.1
IL_007d: callvirt System.Int32 System.Collections.Generic.List`1<System.Reflection.ParameterInfo>::get_Count()
IL_0082: ldc.i4.0
IL_0083: cgt
IL_0085: stloc.s V_4
IL_0087: ldloc.s V_4
IL_0089: brfalse.s IL_0098
IL_008b: ldloc.0
IL_008c: ldloc.1
IL_008d: callvirt !0[] System.Collections.Generic.List`1<System.Reflection.ParameterInfo>::ToArray()
IL_0092: call System.Void SickDev.CommandSystem.SignatureBuilder::AddParameters(System.Text.StringBuilder,System.Reflection.ParameterInfo[])
IL_0097: nop
IL_0098: ldloc.0
IL_0099: callvirt System.String System.Object::ToString()
IL_009e: stloc.s V_5
IL_00a0: br.s IL_00a2
IL_00a2: ldloc.s V_5
IL_00a4: ret
