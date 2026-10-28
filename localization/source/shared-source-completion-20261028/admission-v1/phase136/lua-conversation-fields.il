TYPE PixelCrushers.DialogueSystem.DialogueLua
METHOD System.Void PixelCrushers.DialogueSystem.DialogueLua::AddToConversationTable(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>,System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Void PixelCrushers.DialogueSystem.Lua::set_WasInvoked(System.Boolean)
IL_0006: call Language.Lua.LuaTable PixelCrushers.DialogueSystem.Lua::get_Environment()
IL_000b: ldstr "Conversation"
IL_0010: callvirt Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String)
IL_0015: isinst Language.Lua.LuaTable
IL_001a: stloc.0
IL_001b: ldloc.0
IL_001c: brtrue.s IL_001f
IL_001e: ret
IL_001f: ldc.i4.0
IL_0020: stloc.1
IL_0021: br.s IL_0038
IL_0023: ldarg.0
IL_0024: ldloc.1
IL_0025: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation>::get_Item(System.Int32)
IL_002a: stloc.2
IL_002b: ldloc.0
IL_002c: ldloc.2
IL_002d: ldarg.2
IL_002e: call Language.Lua.LuaTable PixelCrushers.DialogueSystem.DialogueLua::AddToConversationTable(Language.Lua.LuaTable,PixelCrushers.DialogueSystem.Conversation,System.Boolean)
IL_0033: pop
IL_0034: ldloc.1
IL_0035: ldc.i4.1
IL_0036: add
IL_0037: stloc.1
IL_0038: ldloc.1
IL_0039: ldarg.0
IL_003a: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation>::get_Count()
IL_003f: blt.s IL_0023
IL_0041: ret
METHOD Language.Lua.LuaTable PixelCrushers.DialogueSystem.DialogueLua::AddToConversationTable(Language.Lua.LuaTable,PixelCrushers.DialogueSystem.Conversation,System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: newobj System.Void Language.Lua.LuaTable::.ctor()
IL_0007: stloc.1
IL_0008: ldc.i4.0
IL_0009: stloc.2
IL_000a: br.s IL_0038
IL_000c: ldarg.1
IL_000d: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.Asset::fields
IL_0012: ldloc.2
IL_0013: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>::get_Item(System.Int32)
IL_0018: stloc.3
IL_0019: ldloc.3
IL_001a: ldfld System.String PixelCrushers.DialogueSystem.Field::title
IL_001f: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String)
IL_0024: stloc.s V_4
IL_0026: ldloc.1
IL_0027: ldloc.s V_4
IL_0029: ldloc.3
IL_002a: call Language.Lua.LuaValue PixelCrushers.DialogueSystem.DialogueLua::GetFieldLuaValue(PixelCrushers.DialogueSystem.Field)
IL_002f: callvirt System.Void Language.Lua.LuaTable::AddRaw(System.String,Language.Lua.LuaValue)
IL_0034: ldloc.2
IL_0035: ldc.i4.1
IL_0036: add
IL_0037: stloc.2
IL_0038: ldloc.2
IL_0039: ldarg.1
IL_003a: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.Asset::fields
IL_003f: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>::get_Count()
IL_0044: blt.s IL_000c
IL_0046: ldsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::includeSimStatus
IL_004b: brfalse.s IL_0055
IL_004d: ldloc.1
IL_004e: ldarg.1
IL_004f: call Language.Lua.LuaTable PixelCrushers.DialogueSystem.DialogueLua::AddNewDialogTableToConversationFields(Language.Lua.LuaTable,PixelCrushers.DialogueSystem.Conversation)
IL_0054: stloc.0
IL_0055: ldarg.2
IL_0056: brfalse.s IL_0067
IL_0058: ldarg.0
IL_0059: ldarg.1
IL_005a: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_005f: ldloc.1
IL_0060: callvirt System.Void Language.Lua.LuaTable::AddRaw(System.Int32,Language.Lua.LuaValue)
IL_0065: br.s IL_007a
IL_0067: ldarg.0
IL_0068: ldarg.1
IL_0069: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_006e: conv.r8
IL_006f: newobj System.Void Language.Lua.LuaNumber::.ctor(System.Double)
IL_0074: ldloc.1
IL_0075: callvirt System.Void Language.Lua.LuaTable::SetKeyValue(Language.Lua.LuaValue,Language.Lua.LuaValue)
IL_007a: ldloc.0
IL_007b: ret
METHOD PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.DialogueLua::GetConversationField(System.Int32,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "return Conversation[{0}].{1}"
IL_0005: ldc.i4.2
IL_0006: newarr System.Object
IL_000b: dup
IL_000c: ldc.i4.0
IL_000d: ldarg.0
IL_000e: box System.Int32
IL_0013: stelem.ref
IL_0014: dup
IL_0015: ldc.i4.1
IL_0016: ldarg.1
IL_0017: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String)
IL_001c: stelem.ref
IL_001d: call System.String System.String::Format(System.String,System.Object[])
IL_0022: ldc.i4.0
IL_0023: ldc.i4.1
IL_0024: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String,System.Boolean,System.Boolean)
IL_0029: ret
