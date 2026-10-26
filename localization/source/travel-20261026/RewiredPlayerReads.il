TYPE Rewired.Player
METHOD System.Int32 Rewired.Player::get_id()
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.Player::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq.s IL_001b
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 Rewired.Player::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_0013: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0018: pop
IL_0019: ldc.i4.m1
IL_001a: ret
IL_001b: ldarg.0
IL_001c: ldfld System.Int32 Rewired.Player::EPKCDchEYzXNdkVlXPBcLtJDQuC
IL_0021: ret
METHOD System.String Rewired.Player::get_name()
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.Player::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq.s IL_001f
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 Rewired.Player::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_0013: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0018: pop
IL_0019: ldsfld System.String System.String::Empty
IL_001e: ret
IL_001f: ldarg.0
IL_0020: ldfld System.String Rewired.Player::rxFXeRTtpDKAOGNDPEpHeMwItpAb
IL_0025: ret
