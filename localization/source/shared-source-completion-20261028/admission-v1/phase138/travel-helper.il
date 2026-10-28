TYPE TheForestOfLove.DevConsoleCommands/FastTravelCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::FollowDoorwayToScene(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.GameEvents::onEnteringDoorway
IL_0005: ldarg.0
IL_0006: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_000b: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0010: callvirt System.Void SickDev.DevConsole.DevConsole::Close()
IL_0015: ret
