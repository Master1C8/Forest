TYPE Rewired.Keyboard
METHOD System.Boolean Rewired.Keyboard::GetKey(UnityEngine.KeyCode)
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.Controller::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq.s IL_001b
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 Rewired.Controller::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_0013: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0018: pop
IL_0019: ldc.i4.0
IL_001a: ret
IL_001b: ldarg.1
IL_001c: ldarg.0
IL_001d: ldfld System.Int32 Rewired.Keyboard::maxKeyValue
IL_0022: ble.un.s IL_0026
IL_0024: ldc.i4.0
IL_0025: ret
IL_0026: ldarg.0
IL_0027: ldfld System.Int32[] Rewired.Keyboard::keyCodeToKeyIndex
IL_002c: ldarg.1
IL_002d: ldelem.i4
IL_002e: stloc.0
IL_002f: ldloc.0
IL_0030: ldc.i4.0
IL_0031: bge.s IL_0035
IL_0033: ldc.i4.0
IL_0034: ret
IL_0035: ldarg.0
IL_0036: ldfld Rewired.Controller/Button[] Rewired.Controller::buttons
IL_003b: ldloc.0
IL_003c: ldelem.ref
IL_003d: callvirt System.Boolean Rewired.Controller/Button::get_value()
IL_0042: ret
METHOD System.Boolean Rewired.Keyboard::GetKey(Rewired.KeyboardKeyCode)
IL_0000: ldarg.1
IL_0001: ldarg.0
IL_0002: ldfld System.Int32 Rewired.Keyboard::maxKeyValue
IL_0007: ble.un.s IL_000b
IL_0009: ldc.i4.0
IL_000a: ret
IL_000b: ldarg.0
IL_000c: ldfld System.Int32[] Rewired.Keyboard::keyCodeToKeyIndex
IL_0011: ldarg.1
IL_0012: ldelem.i4
IL_0013: stloc.0
IL_0014: ldloc.0
IL_0015: ldc.i4.0
IL_0016: bge.s IL_001a
IL_0018: ldc.i4.0
IL_0019: ret
IL_001a: ldarg.0
IL_001b: ldfld Rewired.Controller/Button[] Rewired.Controller::buttons
IL_0020: ldloc.0
IL_0021: ldelem.ref
IL_0022: callvirt System.Boolean Rewired.Controller/Button::get_value()
IL_0027: ret
