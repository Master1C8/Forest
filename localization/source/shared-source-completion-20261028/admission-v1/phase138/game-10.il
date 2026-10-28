TYPE TheForestOfLove.DevTools.SimulateGameplayVariables
METHOD System.Void TheForestOfLove.DevTools.SimulateGameplayVariables::OnEnable() | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean TheForestOfLove.DevTools.SimulateGameplayVariables::alreadyInjected
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldc.i4.1
IL_0009: stsfld System.Boolean TheForestOfLove.DevTools.SimulateGameplayVariables::alreadyInjected
IL_000e: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0013: ldnull
IL_0014: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::BunnyHouse()
IL_001a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_001f: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0024: dup
IL_0025: ldstr "sim"
IL_002a: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_002f: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0034: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0039: ldnull
IL_003a: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::CentralForest()
IL_0040: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0045: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_004a: dup
IL_004b: ldstr "sim"
IL_0050: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0055: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_005a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_005f: ldnull
IL_0060: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::DeepWoods_Bayou()
IL_0066: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_006b: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0070: dup
IL_0071: ldstr "sim"
IL_0076: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_007b: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0080: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0085: ldnull
IL_0086: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::DeepWoods_Campfire()
IL_008c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0091: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0096: dup
IL_0097: ldstr "sim"
IL_009c: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_00a1: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_00a6: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00ab: ldnull
IL_00ac: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::DeepWoods_Entry()
IL_00b2: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00b7: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_00bc: dup
IL_00bd: ldstr "sim"
IL_00c2: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_00c7: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_00cc: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00d1: ldnull
IL_00d2: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::DeepWoods_FirstFork()
IL_00d8: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00dd: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_00e2: dup
IL_00e3: ldstr "sim"
IL_00e8: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_00ed: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_00f2: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00f7: ldnull
IL_00f8: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::DeepWoods_LongPath()
IL_00fe: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0103: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0108: dup
IL_0109: ldstr "sim"
IL_010e: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0113: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0118: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_011d: ldnull
IL_011e: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::DeepWoods_SecondFork()
IL_0124: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0129: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_012e: dup
IL_012f: ldstr "sim"
IL_0134: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0139: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_013e: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0143: ldnull
IL_0144: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::DeepWoods_TreeArch()
IL_014a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_014f: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0154: dup
IL_0155: ldstr "sim"
IL_015a: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_015f: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0164: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0169: ldnull
IL_016a: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::IntroForest()
IL_0170: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0175: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_017a: dup
IL_017b: ldstr "sim"
IL_0180: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0185: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_018a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_018f: ldnull
IL_0190: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::Lake()
IL_0196: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_019b: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_01a0: dup
IL_01a1: ldstr "sim"
IL_01a6: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_01ab: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_01b0: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_01b5: ldnull
IL_01b6: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::Lake_Ruins()
IL_01bc: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01c1: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_01c6: dup
IL_01c7: ldstr "sim"
IL_01cc: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_01d1: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_01d6: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_01db: ldnull
IL_01dc: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::Mountains()
IL_01e2: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01e7: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_01ec: dup
IL_01ed: ldstr "sim"
IL_01f2: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_01f7: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_01fc: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0201: ldnull
IL_0202: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::Ottershop()
IL_0208: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_020d: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0212: dup
IL_0213: ldstr "sim"
IL_0218: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_021d: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0222: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0227: ldnull
IL_0228: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::Plains_End()
IL_022e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0233: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0238: dup
IL_0239: ldstr "sim"
IL_023e: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0243: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0248: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_024d: ldnull
IL_024e: ldftn System.Void TheForestOfLove.DevTools.SimulateGameplayVariables/SimulationCommands::Plains_Field()
IL_0254: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0259: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_025e: dup
IL_025f: ldstr "sim"
IL_0264: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0269: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_026e: ret
METHOD System.Void TheForestOfLove.DevTools.SimulateGameplayVariables::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldstr "CentralForest"
IL_0005: stsfld System.String TheForestOfLove.DevTools.SimulateGameplayVariables::currentSimScene
IL_000a: ldstr "StartMenu"
IL_000f: stsfld System.String TheForestOfLove.DevTools.SimulateGameplayVariables::lastSimScene
IL_0014: ret
