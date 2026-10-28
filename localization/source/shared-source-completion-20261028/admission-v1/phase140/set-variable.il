TYPE PixelCrushers.DialogueSystem.DialogueLua
METHOD System.Void PixelCrushers.DialogueSystem.DialogueLua::SetVariable(System.String,System.Object) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Void PixelCrushers.DialogueSystem.Lua::set_WasInvoked(System.Boolean)
IL_0006: call Language.Lua.LuaTable PixelCrushers.DialogueSystem.Lua::get_Environment()
IL_000b: ldstr "Variable"
IL_0010: callvirt Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String)
IL_0015: isinst Language.Lua.LuaTable
IL_001a: stloc.0
IL_001b: ldloc.0
IL_001c: brtrue.s IL_001f
IL_001e: ret
IL_001f: ldloc.0
IL_0020: ldarg.0
IL_0021: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String)
IL_0026: ldarg.1
IL_0027: call Language.Lua.LuaValue Language.Lua.LuaInterpreterExtensions::ObjectToLuaValue(System.Object)
IL_002c: callvirt System.Void Language.Lua.LuaTable::SetNameValue(System.String,Language.Lua.LuaValue)
IL_0031: ret
