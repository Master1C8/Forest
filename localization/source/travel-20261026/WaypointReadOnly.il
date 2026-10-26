TYPE TheForestOfLove.WaypointController
METHOD System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Queue`1<TheForestOfLove.WaypointController/InternalWaypoint> TheForestOfLove.WaypointController::waypoints
IL_0006: callvirt System.Int32 System.Collections.Generic.Queue`1<TheForestOfLove.WaypointController/InternalWaypoint>::get_Count()
IL_000b: ldc.i4.0
IL_000c: cgt
IL_000e: ret
