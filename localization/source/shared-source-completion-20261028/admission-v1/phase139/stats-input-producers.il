TYPE TheForestOfLove.DevConsoleCommands/StatsCommands
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::All() | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldnull
IL_0001: ldnull
IL_0002: ldc.i4.0
IL_0003: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_GenerateStats(System.String,TheForestOfLove.Narrative.Actor,System.Int32)
IL_0008: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::All(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: ldc.i4.0
IL_0003: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_GenerateStats(System.String,TheForestOfLove.Narrative.Actor,System.Int32)
IL_0008: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::For(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::For(System.String,System.String)
IL_0007: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::For(System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Actor TheForestOfLove.DevConsoleCommands/StatsCommands::ParseActor(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0012
IL_000a: ldarg.1
IL_000b: ldloc.0
IL_000c: ldc.i4.0
IL_000d: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_GenerateStats(System.String,TheForestOfLove.Narrative.Actor,System.Int32)
IL_0012: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed() | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldsfld System.Int32 TheForestOfLove.DevConsoleCommands/StatsCommands::defaultLimit
IL_0005: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed(System.Int32)
IL_000a: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldnull
IL_0001: ldarg.0
IL_0002: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed(System.String,System.Int32)
IL_0007: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: ldsfld System.Int32 TheForestOfLove.DevConsoleCommands/StatsCommands::defaultLimit
IL_0006: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed(System.String,System.Int32)
IL_000b: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Unplayed(System.String,System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: ldarg.1
IL_0003: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_GenerateStats(System.String,TheForestOfLove.Narrative.Actor,System.Int32)
IL_0008: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: ldsfld System.Int32 TheForestOfLove.DevConsoleCommands/StatsCommands::defaultLimit
IL_0006: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String,System.Int32)
IL_000b: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String,System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: ldarg.1
IL_0003: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String,System.String,System.Int32)
IL_0008: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldsfld System.Int32 TheForestOfLove.DevConsoleCommands/StatsCommands::defaultLimit
IL_0007: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String,System.String,System.Int32)
IL_000c: ret
METHOD System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::UnplayedFor(System.String,System.String,System.Int32) | attributes=Public, Static, HideBySig | impl=IL
ATTRIBUTE Beebyte.Obfuscator.SkipAttribute
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Actor TheForestOfLove.DevConsoleCommands/StatsCommands::ParseActor(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0012
IL_000a: ldarg.1
IL_000b: ldloc.0
IL_000c: ldarg.2
IL_000d: call System.Void TheForestOfLove.DevConsoleCommands/StatsCommands::Stats_GenerateStats(System.String,TheForestOfLove.Narrative.Actor,System.Int32)
IL_0012: ret
