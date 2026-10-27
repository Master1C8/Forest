TYPE PixelCrushers.DialogueSystem.Lua
METHOD PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::get_noResult() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::m_noResult
IL_0005: ret
METHOD PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::get_NoResult() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::m_noResult
IL_0005: ret
METHOD Language.Lua.LuaTable PixelCrushers.DialogueSystem.Lua::get_environment() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld Language.Lua.LuaTable PixelCrushers.DialogueSystem.Lua::m_environment
IL_0005: ret
METHOD Language.Lua.LuaTable PixelCrushers.DialogueSystem.Lua::get_Environment() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld Language.Lua.LuaTable PixelCrushers.DialogueSystem.Lua::m_environment
IL_0005: ret
METHOD System.Void PixelCrushers.DialogueSystem.Lua::InitStaticVariables() | attributes=Private, Static, HideBySig | impl=IL
ATTRIBUTE UnityEngine.RuntimeInitializeOnLoadMethodAttribute
IL_0000: call Language.Lua.LuaTable Language.Lua.LuaInterpreter::CreateGlobalEnviroment()
IL_0005: stsfld Language.Lua.LuaTable PixelCrushers.DialogueSystem.Lua::m_environment
IL_000a: ldnull
IL_000b: newobj System.Void PixelCrushers.DialogueSystem.Lua/Result::.ctor(Language.Lua.LuaValue)
IL_0010: stsfld PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::m_noResult
IL_0015: ret
METHOD System.Void PixelCrushers.DialogueSystem.Lua::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldnull
IL_0001: newobj System.Void PixelCrushers.DialogueSystem.Lua/Result::.ctor(Language.Lua.LuaValue)
IL_0006: stsfld PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::m_noResult
IL_000b: call Language.Lua.LuaTable Language.Lua.LuaInterpreter::CreateGlobalEnviroment()
IL_0010: stsfld Language.Lua.LuaTable PixelCrushers.DialogueSystem.Lua::m_environment
IL_0015: ret
