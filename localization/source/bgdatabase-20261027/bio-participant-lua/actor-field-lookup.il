TYPE PixelCrushers.DialogueSystem.DialogueLua
METHOD System.String PixelCrushers.DialogueSystem.DialogueLua::DoubleQuotesToSingle(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brtrue.s IL_0037
IL_0008: ldarg.0
IL_0009: ldstr """
IL_000e: ldstr "\""
IL_0013: callvirt System.String System.String::Replace(System.String,System.String)
IL_0018: ldstr "
"
IL_001d: ldstr "\n"
IL_0022: callvirt System.String System.String::Replace(System.String,System.String)
IL_0027: ldstr ""
IL_002c: ldsfld System.String System.String::Empty
IL_0031: callvirt System.String System.String::Replace(System.String,System.String)
IL_0036: ret
IL_0037: ldsfld System.String System.String::Empty
IL_003c: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueLua::SpacesToUnderscores(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0006: brtrue.s IL_0013
IL_0008: ldarg.0
IL_0009: ldc.i4.s 32
IL_000b: ldc.i4.s 95
IL_000d: callvirt System.String System.String::Replace(System.Char,System.Char)
IL_0012: ret
IL_0013: ldsfld System.String System.String::Empty
IL_0018: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::replaceSlashWithUnderscore
IL_0005: brfalse.s IL_0054
IL_0007: ldarg.0
IL_0008: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000d: brtrue.s IL_004e
IL_000f: ldarg.0
IL_0010: ldc.i4.s 34
IL_0012: ldc.i4.s 95
IL_0014: callvirt System.String System.String::Replace(System.Char,System.Char)
IL_0019: call System.String PixelCrushers.DialogueSystem.DialogueLua::DoubleQuotesToSingle(System.String)
IL_001e: call System.String PixelCrushers.DialogueSystem.DialogueLua::SpacesToUnderscores(System.String)
IL_0023: ldc.i4.s 45
IL_0025: ldc.i4.s 95
IL_0027: callvirt System.String System.String::Replace(System.Char,System.Char)
IL_002c: ldc.i4.s 40
IL_002e: ldc.i4.s 95
IL_0030: callvirt System.String System.String::Replace(System.Char,System.Char)
IL_0035: ldc.i4.s 41
IL_0037: ldc.i4.s 95
IL_0039: callvirt System.String System.String::Replace(System.Char,System.Char)
IL_003e: ldstr "/"
IL_0043: ldstr "_"
IL_0048: callvirt System.String System.String::Replace(System.String,System.String)
IL_004d: ret
IL_004e: ldsfld System.String System.String::Empty
IL_0053: ret
IL_0054: ldarg.0
IL_0055: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_005a: brtrue.s IL_008c
IL_005c: ldarg.0
IL_005d: ldc.i4.s 34
IL_005f: ldc.i4.s 95
IL_0061: callvirt System.String System.String::Replace(System.Char,System.Char)
IL_0066: call System.String PixelCrushers.DialogueSystem.DialogueLua::DoubleQuotesToSingle(System.String)
IL_006b: call System.String PixelCrushers.DialogueSystem.DialogueLua::SpacesToUnderscores(System.String)
IL_0070: ldc.i4.s 45
IL_0072: ldc.i4.s 95
IL_0074: callvirt System.String System.String::Replace(System.Char,System.Char)
IL_0079: ldc.i4.s 40
IL_007b: ldc.i4.s 95
IL_007d: callvirt System.String System.String::Replace(System.Char,System.Char)
IL_0082: ldc.i4.s 41
IL_0084: ldc.i4.s 95
IL_0086: callvirt System.String System.String::Replace(System.Char,System.Char)
IL_008b: ret
IL_008c: ldsfld System.String System.String::Empty
IL_0091: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueLua::StringToLocalizedTableIndex(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean PixelCrushers.DialogueSystem.Localization::get_IsDefaultLanguage()
IL_0005: brtrue.s IL_000f
IL_0007: ldarg.0
IL_0008: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000d: brfalse.s IL_0016
IL_000f: ldarg.0
IL_0010: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String)
IL_0015: ret
IL_0016: ldarg.0
IL_0017: ldstr "_"
IL_001c: call System.String PixelCrushers.DialogueSystem.Localization::get_Language()
IL_0021: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0026: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String)
IL_002b: ret
METHOD PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetTableField(System.String,System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call Language.Lua.LuaTable PixelCrushers.DialogueSystem.Lua::get_Environment()
IL_0005: ldarg.0
IL_0006: callvirt Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String)
IL_000b: isinst Language.Lua.LuaTable
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: brtrue.s IL_001a
IL_0014: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::get_NoResult()
IL_0019: ret
IL_001a: ldloc.0
IL_001b: ldarg.1
IL_001c: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String)
IL_0021: callvirt Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String)
IL_0026: isinst Language.Lua.LuaTable
IL_002b: stloc.1
IL_002c: ldloc.1
IL_002d: brtrue.s IL_0035
IL_002f: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::get_NoResult()
IL_0034: ret
IL_0035: ldloc.1
IL_0036: ldarg.2
IL_0037: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String)
IL_003c: callvirt Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String)
IL_0041: stloc.2
IL_0042: ldloc.2
IL_0043: brfalse.s IL_004d
IL_0045: ldloc.2
IL_0046: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_004b: bne.un.s IL_0053
IL_004d: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::get_NoResult()
IL_0052: ret
IL_0053: ldloc.2
IL_0054: newobj System.Void PixelCrushers.DialogueSystem.Lua/Result::.ctor(Language.Lua.LuaValue)
IL_0059: ret
METHOD PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetActorField(System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "Actor"
IL_0005: ldarg.0
IL_0006: ldarg.1
IL_0007: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetTableField(System.String,System.String,System.String)
IL_000c: ret
METHOD PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetLocalizedTableField(System.String,System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToLocalizedTableIndex(System.String)
IL_0008: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetTableField(System.String,System.String,System.String)
IL_000d: stloc.0
IL_000e: call System.Boolean PixelCrushers.DialogueSystem.Localization::get_UseDefaultIfUndefined()
IL_0013: brfalse.s IL_0057
IL_0015: ldloc.0
IL_0016: ldfld Language.Lua.LuaValue PixelCrushers.DialogueSystem.Lua/Result::luaValue
IL_001b: brfalse.s IL_004e
IL_001d: ldloc.0
IL_001e: ldfld Language.Lua.LuaValue PixelCrushers.DialogueSystem.Lua/Result::luaValue
IL_0023: isinst Language.Lua.LuaNil
IL_0028: brtrue.s IL_004e
IL_002a: ldloc.0
IL_002b: ldfld Language.Lua.LuaValue PixelCrushers.DialogueSystem.Lua/Result::luaValue
IL_0030: isinst Language.Lua.LuaString
IL_0035: brfalse.s IL_0057
IL_0037: ldloc.0
IL_0038: ldfld Language.Lua.LuaValue PixelCrushers.DialogueSystem.Lua/Result::luaValue
IL_003d: isinst Language.Lua.LuaString
IL_0042: callvirt System.String Language.Lua.LuaString::get_Text()
IL_0047: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_004c: brfalse.s IL_0057
IL_004e: ldarg.0
IL_004f: ldarg.1
IL_0050: ldarg.2
IL_0051: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetTableField(System.String,System.String,System.String)
IL_0056: ret
IL_0057: ldloc.0
IL_0058: ret
METHOD PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetLocalizedActorField(System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "Actor"
IL_0005: ldarg.0
IL_0006: ldarg.1
IL_0007: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetLocalizedTableField(System.String,System.String,System.String)
IL_000c: ret
