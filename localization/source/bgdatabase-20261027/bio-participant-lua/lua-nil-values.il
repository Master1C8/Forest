TYPE Language.Lua.LuaNil
METHOD System.String Language.Lua.LuaNil::ToString() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldstr "nil"
IL_0005: ret
METHOD System.Void Language.Lua.LuaNil::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: newobj System.Void Language.Lua.LuaNil::.ctor()
IL_0005: stsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_000a: ret
