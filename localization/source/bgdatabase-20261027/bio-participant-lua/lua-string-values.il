TYPE Language.Lua.LuaString
METHOD System.Void Language.Lua.LuaString::.ctor(System.String) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void Language.Lua.LuaValue::.ctor()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: call System.Void Language.Lua.LuaString::set_Text(System.String)
IL_000d: ret
METHOD System.String Language.Lua.LuaString::get_Text() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.String Language.Lua.LuaString::<Text>k__BackingField
IL_0006: ret
METHOD System.String Language.Lua.LuaString::ToString() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.String Language.Lua.LuaString::get_Text()
IL_0006: ret
