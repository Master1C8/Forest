TYPE TheForestOfLove.DevConsoleCommands/TriggersCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands/TriggersCommands::Set(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0006: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_000b: ldstr "set trigger "
IL_0010: ldarg.0
IL_0011: call System.String System.String::Concat(System.String,System.String)
IL_0016: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_001b: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/TriggersCommands::Reset(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0010
IL_000a: ldloc.0
IL_000b: callvirt System.Void TheForestOfLove.Narrative.Trigger::ResetTriggerDevtoolsOnly()
IL_0010: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0015: ldstr "reset trigger "
IL_001a: ldarg.0
IL_001b: call System.String System.String::Concat(System.String,System.String)
IL_0020: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_0025: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/TriggersCommands::Info(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0006: stloc.0
IL_0007: ldsfld System.String System.String::Empty
IL_000c: stloc.1
IL_000d: ldloc.0
IL_000e: brfalse.s IL_0025
IL_0010: ldloc.0
IL_0011: callvirt System.Boolean TheForestOfLove.Narrative.Trigger::get_IsActivated()
IL_0016: brtrue.s IL_001f
IL_0018: ldstr "not set"
IL_001d: br.s IL_0024
IL_001f: ldstr "set"
IL_0024: stloc.1
IL_0025: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_002a: ldstr "trigger "
IL_002f: ldarg.0
IL_0030: ldstr " is "
IL_0035: ldloc.1
IL_0036: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_003b: callvirt System.Void SickDev.DevConsole.DevConsole::LogWarning(System.String)
IL_0040: ret
