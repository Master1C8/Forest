TYPE Rewired.ControllerMap
METHOD System.Int32 Rewired.ControllerMap::get_sourceMapId()
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.ControllerMap::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq.s IL_0040
IL_000d: ldc.i4 -591980442
IL_0012: ldc.i4 -591980441
IL_0017: xor
IL_0018: switch IL_003e,IL_002b,IL_000d
IL_0029: br.s IL_003e
IL_002b: ldarg.0
IL_002c: ldfld System.Int32 Rewired.ControllerMap::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_0031: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0036: pop
IL_0037: ldc.i4 -591980441
IL_003c: br.s IL_0012
IL_003e: ldc.i4.m1
IL_003f: ret
IL_0040: ldarg.0
IL_0041: ldfld System.Int32 Rewired.ControllerMap::_sourceMapId
IL_0046: ret
METHOD System.Int32 Rewired.ControllerMap::get_categoryId()
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.ControllerMap::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq.s IL_001b
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 Rewired.ControllerMap::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_0013: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0018: pop
IL_0019: ldc.i4.m1
IL_001a: ret
IL_001b: ldarg.0
IL_001c: ldfld System.Int32 Rewired.ControllerMap::_categoryId
IL_0021: ret
METHOD System.Int32 Rewired.ControllerMap::get_layoutId()
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.ControllerMap::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq.s IL_001b
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 Rewired.ControllerMap::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_0013: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0018: pop
IL_0019: ldc.i4.m1
IL_001a: ret
IL_001b: ldarg.0
IL_001c: ldfld System.Int32 Rewired.ControllerMap::_layoutId
IL_0021: ret
METHOD System.Boolean Rewired.ControllerMap::get_enabled()
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.ControllerMap::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq.s IL_001b
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 Rewired.ControllerMap::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_0013: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0018: pop
IL_0019: ldc.i4.0
IL_001a: ret
IL_001b: ldarg.0
IL_001c: ldfld System.Boolean Rewired.ControllerMap::_enabled
IL_0021: ret
METHOD System.Collections.Generic.IList`1<Rewired.ActionElementMap> Rewired.ControllerMap::get_AllMaps()
IL_0000: ldsfld System.Int32 Rewired.ReInput::_id
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 Rewired.ControllerMap::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_000b: beq.s IL_001f
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 Rewired.ControllerMap::UmlfknJGLCaKwkBKLxTOQfvOngpe
IL_0013: call System.Boolean Rewired.ReInput::CheckInitialized(System.Int32)
IL_0018: pop
IL_0019: call System.Collections.Generic.IList`1<T> Rewired.Utils.EmptyObjects`1<Rewired.ActionElementMap>::get_EmptyReadOnlyIListT()
IL_001e: ret
IL_001f: ldarg.0
IL_0020: ldfld System.Collections.ObjectModel.ReadOnlyCollection`1<Rewired.ActionElementMap> Rewired.ControllerMap::wLKrEXddOEiDHFMFPSuaMHhlWFSC
IL_0025: ret
