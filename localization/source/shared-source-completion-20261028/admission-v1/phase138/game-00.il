TYPE TheForestOfLove.DevConsoleCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands::OnEnable() | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean TheForestOfLove.DevConsoleCommands::alreadyInjected
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldc.i4.1
IL_0009: stsfld System.Boolean TheForestOfLove.DevConsoleCommands::alreadyInjected
IL_000e: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0013: ldnull
IL_0014: ldftn System.Void TheForestOfLove.DevConsoleCommands/TopLevelCommands::Clear()
IL_001a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_001f: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0024: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0029: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_002e: ldnull
IL_002f: ldftn System.Void TheForestOfLove.DevConsoleCommands/TopLevelCommands::Close()
IL_0035: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_003a: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_003f: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0044: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0049: ldnull
IL_004a: ldftn System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Find(System.String)
IL_0050: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0055: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_005a: dup
IL_005b: ldstr "dialogue"
IL_0060: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0065: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_006a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_006f: ldnull
IL_0070: ldftn System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Info(System.Int32)
IL_0076: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_007b: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.Int32>::.ctor(System.Action`1<!0>)
IL_0080: dup
IL_0081: ldstr "dialogue"
IL_0086: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_008b: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0090: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0095: ldnull
IL_0096: ldftn System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Play(System.Int32)
IL_009c: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_00a1: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.Int32>::.ctor(System.Action`1<!0>)
IL_00a6: dup
IL_00a7: ldstr "dialogue"
IL_00ac: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_00b1: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_00b6: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00bb: ldnull
IL_00bc: ldftn System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Play(System.Int32,System.String)
IL_00c2: newobj System.Void System.Action`2<System.Int32,System.String>::.ctor(System.Object,System.IntPtr)
IL_00c7: newobj System.Void SickDev.CommandSystem.ActionCommand`2<System.Int32,System.String>::.ctor(System.Action`2<!0,!1>)
IL_00cc: dup
IL_00cd: ldstr "dialogue"
IL_00d2: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_00d7: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_00dc: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_00e1: ldnull
IL_00e2: ldftn System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Complete(System.Int32)
IL_00e8: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_00ed: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.Int32>::.ctor(System.Action`1<!0>)
IL_00f2: dup
IL_00f3: ldstr "dialogue"
IL_00f8: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_00fd: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0102: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0107: ldnull
IL_0108: ldftn System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Reset(System.Int32)
IL_010e: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0113: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.Int32>::.ctor(System.Action`1<!0>)
IL_0118: dup
IL_0119: ldstr "dialogue"
IL_011e: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0123: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0128: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_012d: ldnull
IL_012e: ldftn System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Test()
IL_0134: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0139: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_013e: dup
IL_013f: ldstr "dialogue"
IL_0144: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0149: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_014e: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0153: ldnull
IL_0154: ldftn System.Void TheForestOfLove.DevConsoleCommands/DialogueCommands::Test(System.String)
IL_015a: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_015f: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0164: dup
IL_0165: ldstr "dialogue"
IL_016a: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_016f: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0174: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0179: ldnull
IL_017a: ldftn System.Void TheForestOfLove.DevConsoleCommands/DateCommands::List()
IL_0180: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0185: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_018a: dup
IL_018b: ldstr "dates"
IL_0190: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0195: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_019a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_019f: ldnull
IL_01a0: ldftn System.Void TheForestOfLove.DevConsoleCommands/DateCommands::Find(System.String)
IL_01a6: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_01ab: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_01b0: dup
IL_01b1: ldstr "dates"
IL_01b6: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_01bb: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_01c0: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_01c5: ldnull
IL_01c6: ldftn System.Void TheForestOfLove.DevConsoleCommands/DateCommands::ForceNext(System.Int32)
IL_01cc: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_01d1: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.Int32>::.ctor(System.Action`1<!0>)
IL_01d6: dup
IL_01d7: ldstr "dates"
IL_01dc: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_01e1: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_01e6: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_01eb: ldnull
IL_01ec: ldftn System.Void TheForestOfLove.DevConsoleCommands/DateCommands::ClearNext()
IL_01f2: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01f7: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_01fc: dup
IL_01fd: ldstr "dates"
IL_0202: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0207: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_020c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0211: ldnull
IL_0212: ldftn System.Void TheForestOfLove.DevConsoleCommands/DateCommands::Disable()
IL_0218: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_021d: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0222: dup
IL_0223: ldstr "dates"
IL_0228: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_022d: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0232: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0237: ldnull
IL_0238: ldftn System.Void TheForestOfLove.DevConsoleCommands/DateCommands::Enable()
IL_023e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0243: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0248: dup
IL_0249: ldstr "dates"
IL_024e: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0253: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0258: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_025d: ldnull
IL_025e: ldftn System.Void TheForestOfLove.DevConsoleCommands/GiftCommands::Disable()
IL_0264: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0269: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_026e: dup
IL_026f: ldstr "gifts"
IL_0274: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0279: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_027e: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0283: ldnull
IL_0284: ldftn System.Void TheForestOfLove.DevConsoleCommands/GiftCommands::Enable()
IL_028a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_028f: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0294: dup
IL_0295: ldstr "gifts"
IL_029a: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_029f: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_02a4: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_02a9: ldnull
IL_02aa: ldftn System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::List()
IL_02b0: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_02b5: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_02ba: dup
IL_02bb: ldstr "quest"
IL_02c0: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_02c5: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_02ca: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_02cf: ldnull
IL_02d0: ldftn System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::Find(System.String)
IL_02d6: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_02db: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_02e0: dup
IL_02e1: ldstr "quest"
IL_02e6: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_02eb: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_02f0: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_02f5: ldnull
IL_02f6: ldftn System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::Info(System.Int32)
IL_02fc: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0301: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.Int32>::.ctor(System.Action`1<!0>)
IL_0306: dup
IL_0307: ldstr "quest"
IL_030c: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0311: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0316: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_031b: ldnull
IL_031c: ldftn System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::Complete(System.Int32)
IL_0322: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0327: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.Int32>::.ctor(System.Action`1<!0>)
IL_032c: dup
IL_032d: ldstr "quest"
IL_0332: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0337: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_033c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0341: ldnull
IL_0342: ldftn System.Void TheForestOfLove.DevConsoleCommands/QuestCommands::Reset(System.Int32)
IL_0348: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_034d: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.Int32>::.ctor(System.Action`1<!0>)
IL_0352: dup
IL_0353: ldstr "quest"
IL_0358: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_035d: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0362: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0367: ldnull
IL_0368: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::BunnyHouse()
IL_036e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0373: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0378: dup
IL_0379: ldstr "scene"
IL_037e: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0383: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0388: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_038d: ldnull
IL_038e: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::BeaverHouse()
IL_0394: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0399: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_039e: dup
IL_039f: ldstr "scene"
IL_03a4: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_03a9: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_03ae: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_03b3: ldnull
IL_03b4: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::CentralForest()
IL_03ba: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_03bf: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_03c4: dup
IL_03c5: ldstr "scene"
IL_03ca: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_03cf: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_03d4: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_03d9: ldnull
IL_03da: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::DeepWoods_Bayou()
IL_03e0: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_03e5: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_03ea: dup
IL_03eb: ldstr "scene"
IL_03f0: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_03f5: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_03fa: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_03ff: ldnull
IL_0400: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::DeepWoods_Campfire()
IL_0406: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_040b: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0410: dup
IL_0411: ldstr "scene"
IL_0416: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_041b: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0420: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0425: ldnull
IL_0426: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::DeepWoods_Entry()
IL_042c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0431: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0436: dup
IL_0437: ldstr "scene"
IL_043c: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0441: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0446: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_044b: ldnull
IL_044c: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::DeepWoods_FirstFork()
IL_0452: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0457: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_045c: dup
IL_045d: ldstr "scene"
IL_0462: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0467: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_046c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0471: ldnull
IL_0472: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::DeepWoods_LongPath()
IL_0478: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_047d: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0482: dup
IL_0483: ldstr "scene"
IL_0488: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_048d: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0492: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0497: ldnull
IL_0498: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::DeepWoods_SecondFork()
IL_049e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_04a3: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_04a8: dup
IL_04a9: ldstr "scene"
IL_04ae: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_04b3: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_04b8: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_04bd: ldnull
IL_04be: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::DeepWoods_TreeArch()
IL_04c4: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_04c9: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_04ce: dup
IL_04cf: ldstr "scene"
IL_04d4: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_04d9: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_04de: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_04e3: ldnull
IL_04e4: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::IntroForest()
IL_04ea: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_04ef: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_04f4: dup
IL_04f5: ldstr "scene"
IL_04fa: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_04ff: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0504: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0509: ldnull
IL_050a: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::Lake()
IL_0510: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0515: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_051a: dup
IL_051b: ldstr "scene"
IL_0520: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0525: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_052a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_052f: ldnull
IL_0530: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::Lake_Ruins()
IL_0536: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_053b: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0540: dup
IL_0541: ldstr "scene"
IL_0546: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_054b: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0550: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0555: ldnull
IL_0556: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::Mountains()
IL_055c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0561: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0566: dup
IL_0567: ldstr "scene"
IL_056c: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0571: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0576: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_057b: ldnull
IL_057c: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::Cave()
IL_0582: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0587: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_058c: dup
IL_058d: ldstr "scene"
IL_0592: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0597: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_059c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_05a1: ldnull
IL_05a2: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::Ottershop()
IL_05a8: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_05ad: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_05b2: dup
IL_05b3: ldstr "scene"
IL_05b8: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_05bd: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_05c2: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_05c7: ldnull
IL_05c8: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::Ottershop_Backroom()
IL_05ce: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_05d3: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_05d8: dup
IL_05d9: ldstr "scene"
IL_05de: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_05e3: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_05e8: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_05ed: ldnull
IL_05ee: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::Plains_End()
IL_05f4: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_05f9: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_05fe: dup
IL_05ff: ldstr "scene"
IL_0604: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0609: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_060e: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0613: ldnull
IL_0614: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::Plains_Field()
IL_061a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_061f: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0624: dup
IL_0625: ldstr "scene"
IL_062a: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_062f: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0634: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0639: ldnull
IL_063a: ldftn System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::StartMenu()
IL_0640: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0645: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_064a: dup
IL_064b: ldstr "scene"
IL_0650: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0655: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_065a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_065f: ldnull
IL_0660: ldftn System.Void TheForestOfLove.DevConsoleCommands/UnlockCommands::AllChapters()
IL_0666: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_066b: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0670: dup
IL_0671: ldstr "unlock"
IL_0676: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_067b: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0680: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0685: ldnull
IL_0686: ldftn System.Void TheForestOfLove.DevConsoleCommands/UnlockCommands::Dashroll()
IL_068c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0691: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0696: dup
IL_0697: ldstr "unlock"
IL_069c: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_06a1: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_06a6: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_06ab: ldnull
IL_06ac: ldftn System.Void TheForestOfLove.DevConsoleCommands/UnlockCommands::Act1()
IL_06b2: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_06b7: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_06bc: dup
IL_06bd: ldstr "unlock"
IL_06c2: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_06c7: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_06cc: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_06d1: ldnull
IL_06d2: ldftn System.Void TheForestOfLove.DevConsoleCommands/ChapterCommands::Search(System.String)
IL_06d8: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_06dd: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_06e2: dup
IL_06e3: ldstr "chapter"
IL_06e8: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_06ed: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_06f2: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_06f7: ldnull
IL_06f8: ldftn System.Void TheForestOfLove.DevConsoleCommands/ChapterCommands::Unlock(System.String)
IL_06fe: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0703: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0708: dup
IL_0709: ldstr "chapter"
IL_070e: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0713: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0718: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_071d: ldnull
IL_071e: ldftn System.Void TheForestOfLove.DevConsoleCommands/TutorialCommands::Control()
IL_0724: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0729: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_072e: dup
IL_072f: ldstr "tutorial"
IL_0734: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0739: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_073e: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0743: ldnull
IL_0744: ldftn System.Void TheForestOfLove.DevConsoleCommands/TutorialCommands::Dialogue()
IL_074a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_074f: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0754: dup
IL_0755: ldstr "tutorial"
IL_075a: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_075f: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0764: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0769: ldnull
IL_076a: ldftn System.Void TheForestOfLove.DevConsoleCommands/TutorialCommands::Gallery()
IL_0770: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0775: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_077a: dup
IL_077b: ldstr "tutorial"
IL_0780: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0785: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_078a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_078f: ldnull
IL_0790: ldftn System.Void TheForestOfLove.DevConsoleCommands/TutorialCommands::FebruaryThankYou()
IL_0796: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_079b: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_07a0: dup
IL_07a1: ldstr "tutorial"
IL_07a6: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_07ab: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_07b0: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_07b5: ldnull
IL_07b6: ldftn System.Void TheForestOfLove.DevConsoleCommands/TutorialCommands::Act1ThankYou()
IL_07bc: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_07c1: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_07c6: dup
IL_07c7: ldstr "tutorial"
IL_07cc: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_07d1: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_07d6: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_07db: ldnull
IL_07dc: ldftn System.Void TheForestOfLove.DevConsoleCommands/TutorialCommands::Act2Capstone()
IL_07e2: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_07e7: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_07ec: dup
IL_07ed: ldstr "tutorial"
IL_07f2: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_07f7: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_07fc: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0801: ldnull
IL_0802: ldftn System.Void TheForestOfLove.DevConsoleCommands/TutorialCommands::BunnyCuck()
IL_0808: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_080d: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0812: dup
IL_0813: ldstr "tutorial"
IL_0818: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_081d: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0822: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0827: ldnull
IL_0828: ldftn System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands::PlayerHas(System.String)
IL_082e: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0833: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0838: dup
IL_0839: ldstr "inventory"
IL_083e: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0843: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0848: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_084d: ldnull
IL_084e: ldftn System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands::Add(System.String)
IL_0854: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0859: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_085e: dup
IL_085f: ldstr "inventory"
IL_0864: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0869: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_086e: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0873: ldnull
IL_0874: ldftn System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands::Remove(System.String)
IL_087a: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_087f: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0884: dup
IL_0885: ldstr "inventory"
IL_088a: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_088f: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0894: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0899: ldnull
IL_089a: ldftn System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands::Fill()
IL_08a0: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_08a5: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_08aa: dup
IL_08ab: ldstr "inventory"
IL_08b0: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_08b5: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_08ba: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_08bf: ldnull
IL_08c0: ldftn System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands::Clear()
IL_08c6: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_08cb: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_08d0: dup
IL_08d1: ldstr "inventory"
IL_08d6: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_08db: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_08e0: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_08e5: ldnull
IL_08e6: ldftn System.Void TheForestOfLove.DevConsoleCommands/InventoryCommands::Search(System.String)
IL_08ec: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_08f1: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_08f6: dup
IL_08f7: ldstr "inventory"
IL_08fc: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0901: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0906: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_090b: ldnull
IL_090c: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::HideLetterboxing()
IL_0912: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0917: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_091c: dup
IL_091d: ldstr "misc"
IL_0922: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0927: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_092c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0931: ldnull
IL_0932: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::EnterCinematicMode()
IL_0938: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_093d: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0942: dup
IL_0943: ldstr "misc"
IL_0948: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_094d: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0952: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0957: ldnull
IL_0958: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::ExitCinematicMode()
IL_095e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0963: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0968: dup
IL_0969: ldstr "misc"
IL_096e: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0973: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0978: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_097d: ldnull
IL_097e: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::EndCutscene()
IL_0984: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0989: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_098e: dup
IL_098f: ldstr "misc"
IL_0994: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0999: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_099e: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_09a3: ldnull
IL_09a4: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::InputStatus()
IL_09aa: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_09af: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_09b4: dup
IL_09b5: ldstr "misc"
IL_09ba: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_09bf: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_09c4: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_09c9: ldnull
IL_09ca: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::RestartGame()
IL_09d0: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_09d5: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_09da: dup
IL_09db: ldstr "misc"
IL_09e0: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_09e5: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_09ea: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_09ef: ldnull
IL_09f0: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::EnableTimeScale()
IL_09f6: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_09fb: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0a00: dup
IL_0a01: ldstr "misc"
IL_0a06: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0a0b: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0a10: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0a15: ldnull
IL_0a16: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::EnableQuicksave()
IL_0a1c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0a21: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0a26: dup
IL_0a27: ldstr "misc"
IL_0a2c: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0a31: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0a36: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0a3b: ldnull
IL_0a3c: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::EnableAutosave()
IL_0a42: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0a47: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0a4c: dup
IL_0a4d: ldstr "misc"
IL_0a52: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0a57: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0a5c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0a61: ldnull
IL_0a62: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::DisableAutosave()
IL_0a68: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0a6d: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0a72: dup
IL_0a73: ldstr "misc"
IL_0a78: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0a7d: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0a82: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0a87: ldnull
IL_0a88: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::SaveState()
IL_0a8e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0a93: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0a98: dup
IL_0a99: ldstr "misc"
IL_0a9e: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0aa3: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0aa8: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0aad: ldnull
IL_0aae: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::LoadState()
IL_0ab4: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0ab9: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0abe: dup
IL_0abf: ldstr "misc"
IL_0ac4: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0ac9: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0ace: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0ad3: ldnull
IL_0ad4: ldftn System.Void TheForestOfLove.DevConsoleCommands/MiscCommands::Quit()
IL_0ada: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0adf: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0ae4: dup
IL_0ae5: ldstr "misc"
IL_0aea: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0aef: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0af4: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0af9: ldnull
IL_0afa: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::All()
IL_0b00: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0b05: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0b0a: dup
IL_0b0b: ldstr "stats"
IL_0b10: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0b15: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0b1a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0b1f: ldnull
IL_0b20: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::All(System.String)
IL_0b26: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0b2b: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0b30: dup
IL_0b31: ldstr "stats"
IL_0b36: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0b3b: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0b40: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0b45: ldnull
IL_0b46: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::For(System.String)
IL_0b4c: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0b51: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0b56: dup
IL_0b57: ldstr "stats"
IL_0b5c: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0b61: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0b66: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0b6b: ldnull
IL_0b6c: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::For(System.String,System.String)
IL_0b72: newobj System.Void System.Action`2<System.String,System.String>::.ctor(System.Object,System.IntPtr)
IL_0b77: newobj System.Void SickDev.CommandSystem.ActionCommand`2<System.String,System.String>::.ctor(System.Action`2<!0,!1>)
IL_0b7c: dup
IL_0b7d: ldstr "stats"
IL_0b82: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0b87: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0b8c: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0b91: ldnull
IL_0b92: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed()
IL_0b98: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0b9d: newobj System.Void SickDev.CommandSystem.ActionCommand::.ctor(System.Action)
IL_0ba2: dup
IL_0ba3: ldstr "stats"
IL_0ba8: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0bad: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0bb2: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0bb7: ldnull
IL_0bb8: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed(System.Int32)
IL_0bbe: newobj System.Void System.Action`1<System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0bc3: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.Int32>::.ctor(System.Action`1<!0>)
IL_0bc8: dup
IL_0bc9: ldstr "stats"
IL_0bce: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0bd3: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0bd8: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0bdd: ldnull
IL_0bde: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed(System.String)
IL_0be4: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0be9: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0bee: dup
IL_0bef: ldstr "stats"
IL_0bf4: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0bf9: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0bfe: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0c03: ldnull
IL_0c04: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed(System.String,System.Int32)
IL_0c0a: newobj System.Void System.Action`2<System.String,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0c0f: newobj System.Void SickDev.CommandSystem.ActionCommand`2<System.String,System.Int32>::.ctor(System.Action`2<!0,!1>)
IL_0c14: dup
IL_0c15: ldstr "stats"
IL_0c1a: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0c1f: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0c24: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0c29: ldnull
IL_0c2a: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String)
IL_0c30: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0c35: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0c3a: dup
IL_0c3b: ldstr "stats"
IL_0c40: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0c45: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0c4a: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0c4f: ldnull
IL_0c50: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String,System.Int32)
IL_0c56: newobj System.Void System.Action`2<System.String,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0c5b: newobj System.Void SickDev.CommandSystem.ActionCommand`2<System.String,System.Int32>::.ctor(System.Action`2<!0,!1>)
IL_0c60: dup
IL_0c61: ldstr "stats"
IL_0c66: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0c6b: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0c70: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0c75: ldnull
IL_0c76: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String,System.String)
IL_0c7c: newobj System.Void System.Action`2<System.String,System.String>::.ctor(System.Object,System.IntPtr)
IL_0c81: newobj System.Void SickDev.CommandSystem.ActionCommand`2<System.String,System.String>::.ctor(System.Action`2<!0,!1>)
IL_0c86: dup
IL_0c87: ldstr "stats"
IL_0c8c: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0c91: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0c96: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0c9b: ldnull
IL_0c9c: ldftn System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String,System.String,System.Int32)
IL_0ca2: newobj System.Void System.Action`3<System.String,System.String,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0ca7: newobj System.Void SickDev.CommandSystem.ActionCommand`3<System.String,System.String,System.Int32>::.ctor(System.Action`3<!0,!1,!2>)
IL_0cac: dup
IL_0cad: ldstr "stats"
IL_0cb2: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0cb7: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0cbc: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0cc1: ldnull
IL_0cc2: ldftn System.Void TheForestOfLove.DevConsoleCommands/TriggersCommands::Set(System.String)
IL_0cc8: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0ccd: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0cd2: dup
IL_0cd3: ldstr "triggers"
IL_0cd8: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0cdd: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0ce2: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0ce7: ldnull
IL_0ce8: ldftn System.Void TheForestOfLove.DevConsoleCommands/TriggersCommands::Reset(System.String)
IL_0cee: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0cf3: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0cf8: dup
IL_0cf9: ldstr "triggers"
IL_0cfe: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0d03: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0d08: call SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()
IL_0d0d: ldnull
IL_0d0e: ldftn System.Void TheForestOfLove.DevConsoleCommands/TriggersCommands::Info(System.String)
IL_0d14: newobj System.Void System.Action`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0d19: newobj System.Void SickDev.CommandSystem.ActionCommand`1<System.String>::.ctor(System.Action`1<!0>)
IL_0d1e: dup
IL_0d1f: ldstr "triggers"
IL_0d24: callvirt System.Void SickDev.CommandSystem.Command::set_className(System.String)
IL_0d29: callvirt System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)
IL_0d2e: ret
