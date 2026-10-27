TYPE PixelCrushers.DialogueSystem.DialogueLua
METHOD System.Void PixelCrushers.DialogueSystem.DialogueLua::InitStaticVariables() | attributes=Private, Static, HideBySig | impl=IL
ATTRIBUTE UnityEngine.RuntimeInitializeOnLoadMethodAttribute
IL_0000: ldc.i4.0
IL_0001: stsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::isRegistering
IL_0006: ldc.i4.0
IL_0007: stsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::hasCachedParticipants
IL_000c: ldc.i4.1
IL_000d: stsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::includeSimStatus
IL_0012: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.String>::.ctor()
IL_0017: stsfld System.Collections.Generic.Dictionary`2<System.String,System.String> PixelCrushers.DialogueSystem.DialogueLua::statusTable
IL_001c: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Single>::.ctor()
IL_0021: stsfld System.Collections.Generic.Dictionary`2<System.String,System.Single> PixelCrushers.DialogueSystem.DialogueLua::relationshipTable
IL_0026: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_002b: ldnull
IL_002c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0031: brfalse.s IL_0044
IL_0033: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0038: call System.Collections.IEnumerator PixelCrushers.DialogueSystem.DialogueLua::RegisterLuaFunctionsAfterFrame()
IL_003d: callvirt UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0042: pop
IL_0043: ret
IL_0044: call System.Void PixelCrushers.DialogueSystem.DialogueLua::RegisterLuaFunctions()
IL_0049: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueLua::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldc.i4.1
IL_0001: stsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::includeSimStatus
IL_0006: ldc.i4.1
IL_0007: stsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::replaceSlashWithUnderscore
IL_000c: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.String>::.ctor()
IL_0011: stsfld System.Collections.Generic.Dictionary`2<System.String,System.String> PixelCrushers.DialogueSystem.DialogueLua::statusTable
IL_0016: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.Single>::.ctor()
IL_001b: stsfld System.Collections.Generic.Dictionary`2<System.String,System.Single> PixelCrushers.DialogueSystem.DialogueLua::relationshipTable
IL_0020: ldc.i4.0
IL_0021: stsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::isRegistering
IL_0026: ldc.i4.0
IL_0027: stsfld System.Boolean PixelCrushers.DialogueSystem.DialogueLua::hasCachedParticipants
IL_002c: call System.Void PixelCrushers.DialogueSystem.DialogueLua::InitializeChatMapperVariables()
IL_0031: call System.Void PixelCrushers.DialogueSystem.DialogueLua::RegisterLuaFunctions()
IL_0036: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueLua::InitializeChatMapperVariables() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "Actor = {}; Item = {}; Quest = Item; Location = {}; Conversation = {}; Variable = {}; Variable["Alert"] = """
IL_0005: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_LogInfo()
IL_000a: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String,System.Boolean)
IL_000f: pop
IL_0010: ldstr "unassigned='unassigned'; active='active'; success='success'; failure='failure'; abandoned='abandoned'"
IL_0015: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_LogInfo()
IL_001a: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String,System.Boolean)
IL_001f: pop
IL_0020: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueLua::AddChatMapperVariables(PixelCrushers.DialogueSystem.DialogueDatabase,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_000a
IL_0009: ret
IL_000a: ldarg.1
IL_000b: brfalse.s IL_0018
IL_000d: ldarg.1
IL_000e: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::get_Count()
IL_0013: ldc.i4.0
IL_0014: ceq
IL_0016: br.s IL_0019
IL_0018: ldc.i4.1
IL_0019: stloc.0
IL_001a: ldstr "Actor"
IL_001f: ldarg.0
IL_0020: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_0025: ldarg.1
IL_0026: ldloc.0
IL_0027: call System.Void PixelCrushers.DialogueSystem.DialogueLua::AddToTable<PixelCrushers.DialogueSystem.Actor>(System.String,System.Collections.Generic.List`1<T>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>,System.Boolean)
IL_002c: ldstr "Item"
IL_0031: ldarg.0
IL_0032: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::items
IL_0037: ldarg.1
IL_0038: ldloc.0
IL_0039: call System.Void PixelCrushers.DialogueSystem.DialogueLua::AddToTable<PixelCrushers.DialogueSystem.Item>(System.String,System.Collections.Generic.List`1<T>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>,System.Boolean)
IL_003e: ldstr "Location"
IL_0043: ldarg.0
IL_0044: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locations
IL_0049: ldarg.1
IL_004a: ldloc.0
IL_004b: call System.Void PixelCrushers.DialogueSystem.DialogueLua::AddToTable<PixelCrushers.DialogueSystem.Location>(System.String,System.Collections.Generic.List`1<T>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>,System.Boolean)
IL_0050: ldarg.0
IL_0051: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variables
IL_0056: ldarg.1
IL_0057: ldloc.0
IL_0058: call System.Void PixelCrushers.DialogueSystem.DialogueLua::AddToVariableTable(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>,System.Boolean)
IL_005d: ldarg.0
IL_005e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversations
IL_0063: ldarg.1
IL_0064: ldloc.0
IL_0065: call System.Void PixelCrushers.DialogueSystem.DialogueLua::AddToConversationTable(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>,System.Boolean)
IL_006a: ldarg.0
IL_006b: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::globalUserScript
IL_0070: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0075: brtrue.s IL_0088
IL_0077: ldarg.0
IL_0078: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::globalUserScript
IL_007d: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_LogInfo()
IL_0082: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String,System.Boolean)
IL_0087: pop
IL_0088: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueLua::AddToTable(System.String,System.Collections.Generic.List`1<T>,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>,System.Boolean) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Void PixelCrushers.DialogueSystem.Lua::set_WasInvoked(System.Boolean)
IL_0006: call Language.Lua.LuaTable PixelCrushers.DialogueSystem.Lua::get_Environment()
IL_000b: ldarg.0
IL_000c: callvirt Language.Lua.LuaValue Language.Lua.LuaTable::GetValue(System.String)
IL_0011: isinst Language.Lua.LuaTable
IL_0016: stloc.0
IL_0017: ldloc.0
IL_0018: brtrue.s IL_001b
IL_001a: ret
IL_001b: ldarg.0
IL_001c: ldarg.2
IL_001d: call System.Collections.Generic.HashSet`1<System.String> PixelCrushers.DialogueSystem.DialogueLua::GetExistingAssetNames(System.String,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>)
IL_0022: stloc.1
IL_0023: ldc.i4.0
IL_0024: stloc.2
IL_0025: br IL_00cf
IL_002a: ldarg.1
IL_002b: ldloc.2
IL_002c: callvirt !0 System.Collections.Generic.List`1<T>::get_Item(System.Int32)
IL_0031: stloc.3
IL_0032: ldloc.3
IL_0033: box T
IL_0038: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_003d: stloc.s V_4
IL_003f: ldloc.1
IL_0040: brfalse.s IL_004c
IL_0042: ldloc.1
IL_0043: ldloc.s V_4
IL_0045: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Contains(!0)
IL_004a: brtrue.s IL_00cb
IL_004c: ldloc.s V_4
IL_004e: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String)
IL_0053: stloc.s V_5
IL_0055: newobj System.Void Language.Lua.LuaTable::.ctor()
IL_005a: stloc.s V_6
IL_005c: ldc.i4.0
IL_005d: stloc.s V_7
IL_005f: br.s IL_0099
IL_0061: ldloc.3
IL_0062: box T
IL_0067: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.Asset::fields
IL_006c: ldloc.s V_7
IL_006e: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>::get_Item(System.Int32)
IL_0073: stloc.s V_8
IL_0075: ldloc.s V_8
IL_0077: ldfld System.String PixelCrushers.DialogueSystem.Field::title
IL_007c: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String)
IL_0081: stloc.s V_9
IL_0083: ldloc.s V_6
IL_0085: ldloc.s V_9
IL_0087: ldloc.s V_8
IL_0089: call Language.Lua.LuaValue PixelCrushers.DialogueSystem.DialogueLua::GetFieldLuaValue(PixelCrushers.DialogueSystem.Field)
IL_008e: callvirt System.Void Language.Lua.LuaTable::AddRaw(System.String,Language.Lua.LuaValue)
IL_0093: ldloc.s V_7
IL_0095: ldc.i4.1
IL_0096: add
IL_0097: stloc.s V_7
IL_0099: ldloc.s V_7
IL_009b: ldloc.3
IL_009c: box T
IL_00a1: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.Asset::fields
IL_00a6: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>::get_Count()
IL_00ab: blt.s IL_0061
IL_00ad: ldarg.3
IL_00ae: brfalse.s IL_00bc
IL_00b0: ldloc.0
IL_00b1: ldloc.s V_5
IL_00b3: ldloc.s V_6
IL_00b5: callvirt System.Void Language.Lua.LuaTable::AddRaw(System.String,Language.Lua.LuaValue)
IL_00ba: br.s IL_00cb
IL_00bc: ldloc.0
IL_00bd: ldloc.s V_5
IL_00bf: newobj System.Void Language.Lua.LuaString::.ctor(System.String)
IL_00c4: ldloc.s V_6
IL_00c6: callvirt System.Void Language.Lua.LuaTable::SetKeyValue(Language.Lua.LuaValue,Language.Lua.LuaValue)
IL_00cb: ldloc.2
IL_00cc: ldc.i4.1
IL_00cd: add
IL_00ce: stloc.2
IL_00cf: ldloc.2
IL_00d0: ldarg.1
IL_00d1: callvirt System.Int32 System.Collections.Generic.List`1<T>::get_Count()
IL_00d6: blt IL_002a
IL_00db: ret
METHOD Language.Lua.LuaValue PixelCrushers.DialogueSystem.DialogueLua::GetFieldLuaValue(PixelCrushers.DialogueSystem.Field) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: brtrue.s IL_0009
IL_0003: ldsfld Language.Lua.LuaNil Language.Lua.LuaNil::Nil
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld PixelCrushers.DialogueSystem.FieldType PixelCrushers.DialogueSystem.Field::type
IL_000f: stloc.0
IL_0010: ldloc.0
IL_0011: ldc.i4.1
IL_0012: sub
IL_0013: switch IL_0036,IL_0048,IL_0061,IL_0061,IL_0036,IL_0036,IL_0036
IL_0034: br.s IL_0061
IL_0036: ldarg.0
IL_0037: ldfld System.String PixelCrushers.DialogueSystem.Field::value
IL_003c: call System.Single PixelCrushers.DialogueSystem.Tools::StringToFloat(System.String)
IL_0041: conv.r8
IL_0042: newobj System.Void Language.Lua.LuaNumber::.ctor(System.Double)
IL_0047: ret
IL_0048: ldarg.0
IL_0049: ldfld System.String PixelCrushers.DialogueSystem.Field::value
IL_004e: call System.Boolean PixelCrushers.DialogueSystem.Tools::StringToBool(System.String)
IL_0053: brtrue.s IL_005b
IL_0055: ldsfld Language.Lua.LuaBoolean Language.Lua.LuaBoolean::False
IL_005a: ret
IL_005b: ldsfld Language.Lua.LuaBoolean Language.Lua.LuaBoolean::True
IL_0060: ret
IL_0061: ldarg.0
IL_0062: ldfld System.String PixelCrushers.DialogueSystem.Field::value
IL_0067: newobj System.Void Language.Lua.LuaString::.ctor(System.String)
IL_006c: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueLua::SetFields(System.String,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldstr "{0} = {{ Status = "", "
IL_0005: ldc.i4.1
IL_0006: newarr System.Object
IL_000b: dup
IL_000c: ldc.i4.0
IL_000d: ldarg.0
IL_000e: stelem.ref
IL_000f: call System.String System.String::Format(System.String,System.Object[])
IL_0014: ldc.i4 1024
IL_0019: newobj System.Void System.Text.StringBuilder::.ctor(System.String,System.Int32)
IL_001e: stloc.0
IL_001f: ldc.i4.0
IL_0020: stloc.1
IL_0021: br.s IL_0065
IL_0023: ldarg.1
IL_0024: ldloc.1
IL_0025: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>::get_Item(System.Int32)
IL_002a: stloc.2
IL_002b: ldloc.2
IL_002c: ldfld System.String PixelCrushers.DialogueSystem.Field::title
IL_0031: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0036: brtrue.s IL_0061
IL_0038: ldloc.0
IL_0039: ldstr "{0} = {1}, "
IL_003e: ldc.i4.2
IL_003f: newarr System.Object
IL_0044: dup
IL_0045: ldc.i4.0
IL_0046: ldloc.2
IL_0047: ldfld System.String PixelCrushers.DialogueSystem.Field::title
IL_004c: call System.String PixelCrushers.DialogueSystem.DialogueLua::StringToTableIndex(System.String)
IL_0051: stelem.ref
IL_0052: dup
IL_0053: ldc.i4.1
IL_0054: ldloc.2
IL_0055: call System.String PixelCrushers.DialogueSystem.DialogueLua::FieldValueAsString(PixelCrushers.DialogueSystem.Field)
IL_005a: stelem.ref
IL_005b: callvirt System.Text.StringBuilder System.Text.StringBuilder::AppendFormat(System.String,System.Object[])
IL_0060: pop
IL_0061: ldloc.1
IL_0062: ldc.i4.1
IL_0063: add
IL_0064: stloc.1
IL_0065: ldloc.1
IL_0066: ldarg.1
IL_0067: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>::get_Count()
IL_006c: blt.s IL_0023
IL_006e: ldarg.2
IL_006f: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0074: brtrue.s IL_007e
IL_0076: ldloc.0
IL_0077: ldarg.2
IL_0078: callvirt System.Text.StringBuilder System.Text.StringBuilder::Append(System.String)
IL_007d: pop
IL_007e: ldloc.0
IL_007f: ldc.i4.s 125
IL_0081: callvirt System.Text.StringBuilder System.Text.StringBuilder::Append(System.Char)
IL_0086: pop
IL_0087: ldloc.0
IL_0088: callvirt System.String System.Object::ToString()
IL_008d: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_LogInfo()
IL_0092: call PixelCrushers.DialogueSystem.Lua/Result PixelCrushers.DialogueSystem.Lua::Run(System.String,System.Boolean)
IL_0097: pop
IL_0098: ret
