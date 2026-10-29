TYPE TheForestOfLove.Events.GameStateManager
METHOD System.Void TheForestOfLove.Events.GameStateManager::HandleEvent(TheForestOfLove.Events.GameStateManager/GameEvent,System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean[] TheForestOfLove.Events.GameStateManager::isEventActive
IL_0005: ldarg.1
IL_0006: ldarg.2
IL_0007: stelem.i1
IL_0008: ldsfld TheForestOfLove.Events.GameStateManager/PlayerControlState TheForestOfLove.Events.GameStateManager::playerControlState
IL_000d: ldc.i4.1
IL_000e: bne.un.s IL_002e
IL_0010: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0015: brtrue.s IL_002e
IL_0017: ldc.i4.0
IL_0018: stsfld TheForestOfLove.Events.GameStateManager/PlayerControlState TheForestOfLove.Events.GameStateManager::playerControlState
IL_001d: ldsfld TheForestOfLove.Events.BoolPrimitiveEvent TheForestOfLove.Events.GameStateManager::onPlayerControlStateChanged
IL_0022: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isPlayerControlLocked()
IL_0027: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Boolean>::Invoke(!0)
IL_002c: br.s IL_004f
IL_002e: ldsfld TheForestOfLove.Events.GameStateManager/PlayerControlState TheForestOfLove.Events.GameStateManager::playerControlState
IL_0033: ldc.i4.0
IL_0034: ceq
IL_0036: ldarg.2
IL_0037: and
IL_0038: brfalse.s IL_004f
IL_003a: ldc.i4.1
IL_003b: stsfld TheForestOfLove.Events.GameStateManager/PlayerControlState TheForestOfLove.Events.GameStateManager::playerControlState
IL_0040: ldsfld TheForestOfLove.Events.BoolPrimitiveEvent TheForestOfLove.Events.GameStateManager::onPlayerControlStateChanged
IL_0045: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isPlayerControlLocked()
IL_004a: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Boolean>::Invoke(!0)
IL_004f: ldarg.1
IL_0050: ldc.i4.1
IL_0051: beq.s IL_0062
IL_0053: ldarg.1
IL_0054: ldc.i4.3
IL_0055: bne.un.s IL_005a
IL_0057: ldarg.2
IL_0058: brfalse.s IL_0062
IL_005a: ldarg.1
IL_005b: ldc.i4.s 10
IL_005d: bne.un.s IL_0068
IL_005f: ldarg.2
IL_0060: brtrue.s IL_0068
IL_0062: ldarg.0
IL_0063: call System.Void TheForestOfLove.Events.GameStateManager::WaitOneFrameToClearInput()
IL_0068: ret
