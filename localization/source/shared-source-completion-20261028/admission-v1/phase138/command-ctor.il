TYPE SickDev.CommandSystem.Command
METHOD System.Void SickDev.CommandSystem.Command::.ctor(System.Delegate) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: nop
IL_0008: ldarg.0
IL_0009: ldarg.1
IL_000a: stfld System.Delegate SickDev.CommandSystem.Command::deleg
IL_000f: ldarg.0
IL_0010: ldarg.0
IL_0011: ldfld System.Delegate SickDev.CommandSystem.Command::deleg
IL_0016: callvirt System.Reflection.MethodInfo System.Delegate::get_Method()
IL_001b: stfld System.Reflection.MethodInfo SickDev.CommandSystem.Command::method
IL_0020: ldarg.0
IL_0021: ldarg.0
IL_0022: ldfld System.Reflection.MethodInfo SickDev.CommandSystem.Command::method
IL_0027: ldtoken System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_002c: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0031: ldc.i4.0
IL_0032: callvirt System.Object[] System.Reflection.MemberInfo::GetCustomAttributes(System.Type,System.Boolean)
IL_0037: ldlen
IL_0038: ldc.i4.0
IL_0039: cgt.un
IL_003b: stfld System.Boolean SickDev.CommandSystem.Command::isAnonymous
IL_0040: ldarg.0
IL_0041: ldarg.0
IL_0042: newobj System.Void SickDev.CommandSystem.Signature::.ctor(SickDev.CommandSystem.Command)
IL_0047: stfld SickDev.CommandSystem.Signature SickDev.CommandSystem.Command::signature
IL_004c: ldarg.0
IL_004d: ldsfld System.String System.String::Empty
IL_0052: call System.Void SickDev.CommandSystem.Command::set_description(System.String)
IL_0057: nop
IL_0058: ret
