TYPE PixelCrushers.DialogueSystem.Lua/Result
METHOD System.Void PixelCrushers.DialogueSystem.Lua/Result::.ctor(Language.Lua.LuaValue) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld Language.Lua.LuaValue PixelCrushers.DialogueSystem.Lua/Result::luaValue
IL_0007: ldarg.0
IL_0008: ldnull
IL_0009: stfld PixelCrushers.DialogueSystem.LuaTableWrapper PixelCrushers.DialogueSystem.Lua/Result::luaTableWrapper
IL_000e: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.Lua/Result::get_hasReturnValue() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld Language.Lua.LuaValue PixelCrushers.DialogueSystem.Lua/Result::luaValue
IL_0006: ldnull
IL_0007: cgt.un
IL_0009: ret
METHOD System.String PixelCrushers.DialogueSystem.Lua/Result::get_asString() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean PixelCrushers.DialogueSystem.Lua/Result::get_hasReturnValue()
IL_0006: brtrue.s IL_000e
IL_0008: ldsfld System.String System.String::Empty
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld Language.Lua.LuaValue PixelCrushers.DialogueSystem.Lua/Result::luaValue
IL_0014: callvirt System.String System.Object::ToString()
IL_0019: ret
