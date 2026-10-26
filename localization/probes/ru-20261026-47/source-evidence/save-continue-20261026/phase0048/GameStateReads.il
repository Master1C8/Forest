TYPE TheForestOfLove.Events.GameStateManager
METHOD System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_0005: ldc.i4.0
IL_0006: ldelem.u1
IL_0007: brtrue.s IL_0064
IL_0009: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_000e: ldc.i4.1
IL_000f: ldelem.u1
IL_0010: brtrue.s IL_0064
IL_0012: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_0017: ldc.i4.2
IL_0018: ldelem.u1
IL_0019: brtrue.s IL_0064
IL_001b: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_0020: ldc.i4.3
IL_0021: ldelem.u1
IL_0022: brtrue.s IL_0064
IL_0024: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_0029: ldc.i4.4
IL_002a: ldelem.u1
IL_002b: brtrue.s IL_0064
IL_002d: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_0032: ldc.i4.5
IL_0033: ldelem.u1
IL_0034: brtrue.s IL_0064
IL_0036: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_003b: ldc.i4.6
IL_003c: ldelem.u1
IL_003d: brtrue.s IL_0064
IL_003f: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_0044: ldc.i4.7
IL_0045: ldelem.u1
IL_0046: brtrue.s IL_0064
IL_0048: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_004d: ldc.i4.8
IL_004e: ldelem.u1
IL_004f: brtrue.s IL_0064
IL_0051: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_0056: ldc.i4.s 9
IL_0058: ldelem.u1
IL_0059: brtrue.s IL_0064
IL_005b: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_0060: ldc.i4.s 10
IL_0062: ldelem.u1
IL_0063: ret
IL_0064: ldc.i4.1
IL_0065: ret
