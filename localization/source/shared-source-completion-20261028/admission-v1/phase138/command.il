TYPE SickDev.CommandSystem.Command
METHOD System.Boolean SickDev.CommandSystem.Command::get_useClassName() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean SickDev.CommandSystem.Command::<useClassName>k__BackingField
IL_0006: ret
METHOD System.String SickDev.CommandSystem.Command::get_alias() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.String SickDev.CommandSystem.Command::<alias>k__BackingField
IL_0006: ret
METHOD System.String SickDev.CommandSystem.Command::get_name() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldsfld System.String System.String::Empty
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: call System.Boolean SickDev.CommandSystem.Command::get_useClassName()
IL_000d: stloc.1
IL_000e: ldloc.1
IL_000f: brfalse.s IL_0022
IL_0011: ldarg.0
IL_0012: call System.String SickDev.CommandSystem.Command::get_className()
IL_0017: ldstr "."
IL_001c: call System.String System.String::Concat(System.String,System.String)
IL_0021: stloc.0
IL_0022: ldloc.0
IL_0023: ldarg.0
IL_0024: call System.String SickDev.CommandSystem.Command::get_alias()
IL_0029: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_002e: brtrue.s IL_0038
IL_0030: ldarg.0
IL_0031: call System.String SickDev.CommandSystem.Command::get_alias()
IL_0036: br.s IL_0043
IL_0038: ldarg.0
IL_0039: ldfld System.Reflection.MethodInfo SickDev.CommandSystem.Command::method
IL_003e: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0043: call System.String System.String::Concat(System.String,System.String)
IL_0048: stloc.0
IL_0049: ldloc.0
IL_004a: stloc.2
IL_004b: br.s IL_004d
IL_004d: ldloc.2
IL_004e: ret
METHOD System.String SickDev.CommandSystem.Command::get_className() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.String SickDev.CommandSystem.Command::_className
IL_0007: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000c: stloc.0
IL_000d: ldloc.0
IL_000e: brfalse.s IL_0023
IL_0010: ldarg.0
IL_0011: ldfld System.Reflection.MethodInfo SickDev.CommandSystem.Command::method
IL_0016: callvirt System.Type System.Reflection.MemberInfo::get_DeclaringType()
IL_001b: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0020: stloc.1
IL_0021: br.s IL_002c
IL_0023: ldarg.0
IL_0024: ldfld System.String SickDev.CommandSystem.Command::_className
IL_0029: stloc.1
IL_002a: br.s IL_002c
IL_002c: ldloc.1
IL_002d: ret
METHOD System.Void SickDev.CommandSystem.Command::set_className(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.String SickDev.CommandSystem.Command::_className
IL_0008: ldarg.0
IL_0009: ldc.i4.1
IL_000a: call System.Void SickDev.CommandSystem.Command::set_useClassName(System.Boolean)
IL_000f: nop
IL_0010: ret
METHOD System.Boolean SickDev.CommandSystem.Command::IsOverloadOf(SickDev.CommandSystem.ParsedCommand) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: callvirt System.String SickDev.CommandSystem.ParsedCommand::get_command()
IL_0008: call System.Boolean SickDev.CommandSystem.Command::IsOverloadOf(System.String)
IL_000d: stloc.0
IL_000e: br.s IL_0010
IL_0010: ldloc.0
IL_0011: ret
METHOD System.Boolean SickDev.CommandSystem.Command::IsOverloadOf(SickDev.CommandSystem.Command) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: callvirt System.String SickDev.CommandSystem.Command::get_name()
IL_0008: call System.Boolean SickDev.CommandSystem.Command::IsOverloadOf(System.String)
IL_000d: stloc.0
IL_000e: br.s IL_0010
IL_0010: ldloc.0
IL_0011: ret
METHOD System.Boolean SickDev.CommandSystem.Command::IsOverloadOf(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: call System.String SickDev.CommandSystem.Command::get_name()
IL_0007: ldarg.1
IL_0008: ldc.i4.5
IL_0009: call System.Boolean System.String::Equals(System.String,System.String,System.StringComparison)
IL_000e: stloc.0
IL_000f: br.s IL_0011
IL_0011: ldloc.0
IL_0012: ret
