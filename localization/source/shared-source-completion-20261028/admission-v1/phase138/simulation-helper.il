TYPE TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands
METHOD System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::UpdateSimulatedScene(System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.DevTools.SimulateGameplayVariables::ChangeSimulatedScene(System.String)
IL_0006: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_000b: callvirt System.Void SickDev.DevConsole.DevConsole::Close()
IL_0010: ret
