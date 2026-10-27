TYPE PixelCrushers.DialogueSystem.DatabaseManager
METHOD System.Void PixelCrushers.DialogueSystem.DatabaseManager::.ctor(PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::.ctor()
IL_0006: stfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase> PixelCrushers.DialogueSystem.DatabaseManager::m_loadedDatabases
IL_000b: ldarg.0
IL_000c: call System.Void System.Object::.ctor()
IL_0011: ldarg.0
IL_0012: ldc.i4.0
IL_0013: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseUtility::CreateDialogueDatabaseInstance(System.Boolean)
IL_0018: stfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::m_masterDatabase
IL_001d: ldarg.0
IL_001e: ldarg.1
IL_001f: call System.Void PixelCrushers.DialogueSystem.DatabaseManager::set_defaultDatabase(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0024: ret
METHOD System.Void PixelCrushers.DialogueSystem.DatabaseManager::Add(PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_0052
IL_0009: ldarg.0
IL_000a: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase> PixelCrushers.DialogueSystem.DatabaseManager::m_loadedDatabases
IL_000f: ldarg.1
IL_0010: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::Contains(!0)
IL_0015: brtrue.s IL_0052
IL_0017: ldarg.0
IL_0018: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase> PixelCrushers.DialogueSystem.DatabaseManager::m_loadedDatabases
IL_001d: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::get_Count()
IL_0022: brtrue.s IL_0029
IL_0024: call System.Void PixelCrushers.DialogueSystem.DialogueLua::InitializeChatMapperVariables()
IL_0029: ldarg.0
IL_002a: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::m_masterDatabase
IL_002f: ldarg.1
IL_0030: callvirt System.Void PixelCrushers.DialogueSystem.DialogueDatabase::Add(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0035: ldarg.0
IL_0036: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::m_masterDatabase
IL_003b: ldarg.0
IL_003c: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase> PixelCrushers.DialogueSystem.DatabaseManager::m_loadedDatabases
IL_0041: call System.Void PixelCrushers.DialogueSystem.DialogueLua::AddChatMapperVariables(PixelCrushers.DialogueSystem.DialogueDatabase,System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>)
IL_0046: ldarg.0
IL_0047: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase> PixelCrushers.DialogueSystem.DatabaseManager::m_loadedDatabases
IL_004c: ldarg.1
IL_004d: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::Add(!0)
IL_0052: ret
METHOD System.Void PixelCrushers.DialogueSystem.DatabaseManager::Clear() | attributes=Public, HideBySig | impl=IL
IL_0000: call System.Void PixelCrushers.DialogueSystem.DialogueLua::InitializeChatMapperVariables()
IL_0005: ldarg.0
IL_0006: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::m_masterDatabase
IL_000b: callvirt System.Void PixelCrushers.DialogueSystem.DialogueDatabase::Clear()
IL_0010: ldarg.0
IL_0011: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase> PixelCrushers.DialogueSystem.DatabaseManager::m_loadedDatabases
IL_0016: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::Clear()
IL_001b: ret
