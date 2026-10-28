TYPE SickDev.CommandSystem.CommandsManager
METHOD System.Void SickDev.CommandSystem.CommandsManager::Add(SickDev.CommandSystem.Command[]) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldc.i4.0
IL_0002: stloc.0
IL_0003: br.s IL_0013
IL_0005: ldarg.0
IL_0006: ldarg.1
IL_0007: ldloc.0
IL_0008: ldelem.ref
IL_0009: call System.Void SickDev.CommandSystem.CommandsManager::Add(SickDev.CommandSystem.Command)
IL_000e: nop
IL_000f: ldloc.0
IL_0010: ldc.i4.1
IL_0011: add
IL_0012: stloc.0
IL_0013: ldloc.0
IL_0014: ldarg.1
IL_0015: ldlen
IL_0016: conv.i4
IL_0017: clt
IL_0019: stloc.1
IL_001a: ldloc.1
IL_001b: brtrue.s IL_0005
IL_001d: ret
METHOD System.Void SickDev.CommandSystem.CommandsManager::Add(SickDev.CommandSystem.Command) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Object SickDev.CommandSystem.CommandsManager::block
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: call System.Void System.Threading.Monitor::Enter(System.Object)
IL_000e: nop
IL_000f: nop
IL_0010: ldarg.0
IL_0011: ldarg.1
IL_0012: call System.Boolean SickDev.CommandSystem.CommandsManager::IsCommandAdded(SickDev.CommandSystem.Command)
IL_0017: ldc.i4.0
IL_0018: ceq
IL_001a: stloc.1
IL_001b: ldloc.1
IL_001c: brfalse.s IL_0047
IL_001e: nop
IL_001f: ldarg.0
IL_0020: ldfld System.Collections.Generic.List`1<SickDev.CommandSystem.Command> SickDev.CommandSystem.CommandsManager::commands
IL_0025: ldarg.1
IL_0026: callvirt System.Void System.Collections.Generic.List`1<SickDev.CommandSystem.Command>::Add(!0)
IL_002b: nop
IL_002c: ldarg.0
IL_002d: ldfld SickDev.CommandSystem.CommandsManager/OnCommandModified SickDev.CommandSystem.CommandsManager::onCommandAdded
IL_0032: ldnull
IL_0033: cgt.un
IL_0035: stloc.2
IL_0036: ldloc.2
IL_0037: brfalse.s IL_0046
IL_0039: ldarg.0
IL_003a: ldfld SickDev.CommandSystem.CommandsManager/OnCommandModified SickDev.CommandSystem.CommandsManager::onCommandAdded
IL_003f: ldarg.1
IL_0040: callvirt System.Void SickDev.CommandSystem.CommandsManager/OnCommandModified::Invoke(SickDev.CommandSystem.Command)
IL_0045: nop
IL_0046: nop
IL_0047: nop
IL_0048: leave.s IL_0052
IL_004a: ldloc.0
IL_004b: call System.Void System.Threading.Monitor::Exit(System.Object)
IL_0050: nop
IL_0051: endfinally
IL_0052: ret
METHOD System.Object SickDev.CommandSystem.CommandsManager::Execute(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: call SickDev.CommandSystem.CommandExecuter SickDev.CommandSystem.CommandsManager::GetCommandExecuter(System.String)
IL_0008: callvirt System.Object SickDev.CommandSystem.CommandExecuter::Execute()
IL_000d: stloc.0
IL_000e: br.s IL_0010
IL_0010: ldloc.0
IL_0011: ret
METHOD SickDev.CommandSystem.CommandExecuter SickDev.CommandSystem.CommandsManager::GetCommandExecuter(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.1
IL_0002: newobj System.Void SickDev.CommandSystem.ParsedCommand::.ctor(System.String)
IL_0007: stloc.0
IL_0008: ldarg.0
IL_0009: ldloc.0
IL_000a: call SickDev.CommandSystem.CommandExecuter SickDev.CommandSystem.CommandsManager::GetCommandExecuter(SickDev.CommandSystem.ParsedCommand)
IL_000f: stloc.1
IL_0010: br.s IL_0012
IL_0012: ldloc.1
IL_0013: ret
METHOD SickDev.CommandSystem.CommandExecuter SickDev.CommandSystem.CommandsManager::GetCommandExecuter(SickDev.CommandSystem.ParsedCommand) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Collections.Generic.List`1<SickDev.CommandSystem.Command> SickDev.CommandSystem.CommandsManager::commands
IL_0007: ldarg.1
IL_0008: ldarg.0
IL_0009: ldfld SickDev.CommandSystem.ArgumentsParser SickDev.CommandSystem.CommandsManager::parser
IL_000e: newobj System.Void SickDev.CommandSystem.CommandExecuter::.ctor(System.Collections.Generic.List`1<SickDev.CommandSystem.Command>,SickDev.CommandSystem.ParsedCommand,SickDev.CommandSystem.ArgumentsParser)
IL_0013: stloc.0
IL_0014: br.s IL_0016
IL_0016: ldloc.0
IL_0017: ret
