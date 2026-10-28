TYPE SickDev.DevConsole.AutoComplete/Matcher
METHOD System.Void SickDev.DevConsole.AutoComplete/Matcher::BuildTitledCaseCommands() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete/Matcher::commands
IL_0007: ldlen
IL_0008: conv.i4
IL_0009: newarr System.String
IL_000e: stfld System.String[] SickDev.DevConsole.AutoComplete/Matcher::titledCaseCommands
IL_0013: ldc.i4.0
IL_0014: stloc.0
IL_0015: br.s IL_0035
IL_0017: ldarg.0
IL_0018: ldfld System.String[] SickDev.DevConsole.AutoComplete/Matcher::titledCaseCommands
IL_001d: ldloc.0
IL_001e: ldarg.0
IL_001f: ldfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete/Matcher::commands
IL_0024: ldloc.0
IL_0025: ldelem.ref
IL_0026: callvirt System.String SickDev.CommandSystem.Command::get_name()
IL_002b: call System.String SickDev.DevConsole.AutoComplete/Matcher::StringToFirstUpperCase(System.String)
IL_0030: stelem.ref
IL_0031: ldloc.0
IL_0032: ldc.i4.1
IL_0033: add
IL_0034: stloc.0
IL_0035: ldloc.0
IL_0036: ldarg.0
IL_0037: ldfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete/Matcher::commands
IL_003c: ldlen
IL_003d: conv.i4
IL_003e: blt.s IL_0017
IL_0040: ret
METHOD System.Void SickDev.DevConsole.AutoComplete/Matcher::CategorizeMatches(System.String,System.Text.RegularExpressions.Regex) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: br IL_009a
IL_0007: ldarg.0
IL_0008: ldfld System.Int32 SickDev.DevConsole.AutoComplete/Matcher::exactMatch
IL_000d: ldc.i4.m1
IL_000e: bne.un.s IL_0029
IL_0010: ldarg.0
IL_0011: ldfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete/Matcher::commands
IL_0016: ldloc.0
IL_0017: ldelem.ref
IL_0018: ldarg.1
IL_0019: callvirt System.Boolean SickDev.CommandSystem.Command::IsOverloadOf(System.String)
IL_001e: brfalse.s IL_0029
IL_0020: ldarg.0
IL_0021: ldloc.0
IL_0022: stfld System.Int32 SickDev.DevConsole.AutoComplete/Matcher::exactMatch
IL_0027: br.s IL_0096
IL_0029: ldarg.0
IL_002a: ldfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete/Matcher::commands
IL_002f: ldloc.0
IL_0030: ldelem.ref
IL_0031: callvirt System.String SickDev.CommandSystem.Command::get_name()
IL_0036: ldarg.1
IL_0037: ldc.i4.5
IL_0038: callvirt System.Boolean System.String::StartsWith(System.String,System.StringComparison)
IL_003d: brfalse.s IL_004d
IL_003f: ldarg.0
IL_0040: ldfld System.Collections.Generic.List`1<System.Int32> SickDev.DevConsole.AutoComplete/Matcher::startsWith
IL_0045: ldloc.0
IL_0046: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Add(!0)
IL_004b: br.s IL_0096
IL_004d: ldarg.2
IL_004e: ldarg.0
IL_004f: ldfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete/Matcher::commands
IL_0054: ldloc.0
IL_0055: ldelem.ref
IL_0056: callvirt System.String SickDev.CommandSystem.Command::get_name()
IL_005b: callvirt System.Text.RegularExpressions.Match System.Text.RegularExpressions.Regex::Match(System.String)
IL_0060: callvirt System.Boolean System.Text.RegularExpressions.Group::get_Success()
IL_0065: brfalse.s IL_0075
IL_0067: ldarg.0
IL_0068: ldfld System.Collections.Generic.List`1<System.Int32> SickDev.DevConsole.AutoComplete/Matcher::matchesRegex
IL_006d: ldloc.0
IL_006e: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Add(!0)
IL_0073: br.s IL_0096
IL_0075: ldarg.2
IL_0076: ldarg.0
IL_0077: ldfld System.String[] SickDev.DevConsole.AutoComplete/Matcher::titledCaseCommands
IL_007c: ldloc.0
IL_007d: ldelem.ref
IL_007e: callvirt System.Text.RegularExpressions.Match System.Text.RegularExpressions.Regex::Match(System.String)
IL_0083: callvirt System.Boolean System.Text.RegularExpressions.Group::get_Success()
IL_0088: brfalse.s IL_0096
IL_008a: ldarg.0
IL_008b: ldfld System.Collections.Generic.List`1<System.Int32> SickDev.DevConsole.AutoComplete/Matcher::matchesRegexTitledCase
IL_0090: ldloc.0
IL_0091: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Add(!0)
IL_0096: ldloc.0
IL_0097: ldc.i4.1
IL_0098: add
IL_0099: stloc.0
IL_009a: ldloc.0
IL_009b: ldarg.0
IL_009c: ldfld SickDev.CommandSystem.Command[] SickDev.DevConsole.AutoComplete/Matcher::commands
IL_00a1: ldlen
IL_00a2: conv.i4
IL_00a3: blt IL_0007
IL_00a8: ret
