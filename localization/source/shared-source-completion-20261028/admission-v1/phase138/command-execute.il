TYPE SickDev.CommandSystem.CommandExecuter
METHOD System.Void SickDev.CommandSystem.CommandExecuter::FilterOverloads() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldc.i4.0
IL_0002: stloc.0
IL_0003: br.s IL_003c
IL_0005: ldarg.0
IL_0006: ldfld System.Collections.Generic.List`1<SickDev.CommandSystem.Command> SickDev.CommandSystem.CommandExecuter::commands
IL_000b: ldloc.0
IL_000c: callvirt !0 System.Collections.Generic.List`1<SickDev.CommandSystem.Command>::get_Item(System.Int32)
IL_0011: ldarg.0
IL_0012: ldfld SickDev.CommandSystem.ParsedCommand SickDev.CommandSystem.CommandExecuter::parsedCommand
IL_0017: callvirt System.Boolean SickDev.CommandSystem.Command::IsOverloadOf(SickDev.CommandSystem.ParsedCommand)
IL_001c: stloc.1
IL_001d: ldloc.1
IL_001e: brfalse.s IL_0038
IL_0020: ldarg.0
IL_0021: ldfld System.Collections.Generic.List`1<SickDev.CommandSystem.Command> SickDev.CommandSystem.CommandExecuter::overloads
IL_0026: ldarg.0
IL_0027: ldfld System.Collections.Generic.List`1<SickDev.CommandSystem.Command> SickDev.CommandSystem.CommandExecuter::commands
IL_002c: ldloc.0
IL_002d: callvirt !0 System.Collections.Generic.List`1<SickDev.CommandSystem.Command>::get_Item(System.Int32)
IL_0032: callvirt System.Void System.Collections.Generic.List`1<SickDev.CommandSystem.Command>::Add(!0)
IL_0037: nop
IL_0038: ldloc.0
IL_0039: ldc.i4.1
IL_003a: add
IL_003b: stloc.0
IL_003c: ldloc.0
IL_003d: ldarg.0
IL_003e: ldfld System.Collections.Generic.List`1<SickDev.CommandSystem.Command> SickDev.CommandSystem.CommandExecuter::commands
IL_0043: callvirt System.Int32 System.Collections.Generic.List`1<SickDev.CommandSystem.Command>::get_Count()
IL_0048: clt
IL_004a: stloc.2
IL_004b: ldloc.2
IL_004c: brtrue.s IL_0005
IL_004e: ret
METHOD System.Object SickDev.CommandSystem.CommandExecuter::Execute() | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: nop
IL_0002: ldarg.0
IL_0003: call SickDev.CommandSystem.CommandExecuter/Match SickDev.CommandSystem.CommandExecuter::GetMatch()
IL_0008: stloc.0
IL_0009: ldloc.0
IL_000a: ldfld SickDev.CommandSystem.Command SickDev.CommandSystem.CommandExecuter/Match::command
IL_000f: ldloc.0
IL_0010: ldfld System.Object[] SickDev.CommandSystem.CommandExecuter/Match::parameters
IL_0015: callvirt System.Object SickDev.CommandSystem.Command::Execute(System.Object[])
IL_001a: stloc.1
IL_001b: leave.s IL_002a
IL_001d: stloc.2
IL_001e: nop
IL_001f: ldloc.2
IL_0020: call System.Void SickDev.CommandSystem.CommandsManager::SendException(System.Exception)
IL_0025: nop
IL_0026: ldnull
IL_0027: stloc.1
IL_0028: leave.s IL_002a
IL_002a: ldloc.1
IL_002b: ret
