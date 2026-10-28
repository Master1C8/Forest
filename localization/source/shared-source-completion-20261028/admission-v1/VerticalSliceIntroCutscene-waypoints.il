TYPE TheForestOfLove.VerticalSliceIntroCutscene
METHOD System.Void TheForestOfLove.VerticalSliceIntroCutscene::OnWaypointArrived(TheForestOfLove.Waypoint) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.String TheForestOfLove.Waypoint::title
IL_0006: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_000b: brfalse.s IL_000e
IL_000d: ret
IL_000e: ldarg.1
IL_000f: ldfld System.String TheForestOfLove.Waypoint::title
IL_0014: stloc.0
IL_0015: ldloc.0
IL_0016: brfalse.s IL_0038
IL_0018: ldloc.0
IL_0019: ldstr "bunny_wife"
IL_001e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0023: brtrue.s IL_004d
IL_0025: ldloc.0
IL_0026: ldstr "end_cinematic_mode"
IL_002b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0030: brfalse.s IL_0038
IL_0032: call System.Void TheForestOfLove.CutsceneManager::EndCinematicMode()
IL_0037: ret
IL_0038: ldstr "player arrived at "
IL_003d: ldarg.1
IL_003e: ldfld System.String TheForestOfLove.Waypoint::title
IL_0043: call System.String System.String::Concat(System.String,System.String)
IL_0048: call System.Void UnityEngine.Debug::Log(System.Object)
IL_004d: ret
METHOD System.Void TheForestOfLove.VerticalSliceIntroCutscene::OnWaypointWaitTimeElapsed(TheForestOfLove.Waypoint) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.String TheForestOfLove.Waypoint::title
IL_0006: pop
IL_0007: ldstr "finished waiting for "
IL_000c: ldarg.1
IL_000d: ldfld System.String TheForestOfLove.Waypoint::title
IL_0012: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0017: brtrue.s IL_0021
IL_0019: ldarg.1
IL_001a: ldfld System.String TheForestOfLove.Waypoint::title
IL_001f: br.s IL_0026
IL_0021: ldstr "unnamed waypoint"
IL_0026: call System.String System.String::Concat(System.String,System.String)
IL_002b: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0030: ret
