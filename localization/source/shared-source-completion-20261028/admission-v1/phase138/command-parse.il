TYPE SickDev.CommandSystem.ParsedCommand
METHOD System.Void SickDev.CommandSystem.ParsedCommand::.ctor(System.String) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: nop
IL_0008: ldarg.0
IL_0009: ldarg.1
IL_000a: call System.Void SickDev.CommandSystem.ParsedCommand::set_raw(System.String)
IL_000f: nop
IL_0010: ldarg.0
IL_0011: call System.Void SickDev.CommandSystem.ParsedCommand::GetCommand()
IL_0016: nop
IL_0017: ldarg.0
IL_0018: call System.Void SickDev.CommandSystem.ParsedCommand::GetArgs()
IL_001d: nop
IL_001e: ret
METHOD System.Void SickDev.CommandSystem.ParsedCommand::GetCommand() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: call System.String SickDev.CommandSystem.ParsedCommand::get_raw()
IL_0007: ldc.i4.1
IL_0008: newarr System.Char
IL_000d: dup
IL_000e: ldc.i4.0
IL_000f: ldc.i4.s 32
IL_0011: stelem.i2
IL_0012: callvirt System.String[] System.String::Split(System.Char[])
IL_0017: stloc.0
IL_0018: ldarg.0
IL_0019: ldloc.0
IL_001a: ldc.i4.0
IL_001b: ldelem.ref
IL_001c: call System.Void SickDev.CommandSystem.ParsedCommand::set_command(System.String)
IL_0021: nop
IL_0022: ret
