TYPE PixelCrushers.DialogueSystem.DatabaseManager
METHOD PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::<defaultDatabase>k__BackingField
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.DatabaseManager::set_defaultDatabase(PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::<defaultDatabase>k__BackingField
IL_0007: ret
METHOD PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_masterDatabase() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::GetMasterDatabase()
IL_0006: ret
METHOD PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_DefaultDatabase() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.DatabaseManager::set_DefaultDatabase(PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void PixelCrushers.DialogueSystem.DatabaseManager::set_defaultDatabase(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0007: ret
METHOD PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_MasterDatabase() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_masterDatabase()
IL_0006: ret
METHOD PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::GetMasterDatabase() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase> PixelCrushers.DialogueSystem.DatabaseManager::m_loadedDatabases
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::get_Count()
IL_000b: brtrue.s IL_0019
IL_000d: ldarg.0
IL_000e: ldarg.0
IL_000f: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_0014: call System.Void PixelCrushers.DialogueSystem.DatabaseManager::Add(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0019: ldarg.0
IL_001a: ldfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::m_masterDatabase
IL_001f: ret
METHOD System.Void PixelCrushers.DialogueSystem.DatabaseManager::Reset(PixelCrushers.DialogueSystem.DatabaseResetOptions) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_000e
IL_0003: ldarg.1
IL_0004: ldc.i4.1
IL_0005: bne.un.s IL_0014
IL_0007: ldarg.0
IL_0008: call System.Void PixelCrushers.DialogueSystem.DatabaseManager::ResetToDefaultDatabase()
IL_000d: ret
IL_000e: ldarg.0
IL_000f: call System.Void PixelCrushers.DialogueSystem.DatabaseManager::ResetToLoadedDatabases()
IL_0014: ret
METHOD System.Void PixelCrushers.DialogueSystem.DatabaseManager::ResetToDefaultDatabase() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void PixelCrushers.DialogueSystem.DatabaseManager::Clear()
IL_0006: ldarg.0
IL_0007: ldarg.0
IL_0008: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_000d: call System.Void PixelCrushers.DialogueSystem.DatabaseManager::Add(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0012: ret
METHOD System.Void PixelCrushers.DialogueSystem.DatabaseManager::ResetToLoadedDatabases() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase> PixelCrushers.DialogueSystem.DatabaseManager::m_loadedDatabases
IL_0006: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_000b: ldarg.0
IL_000c: call System.Void PixelCrushers.DialogueSystem.DatabaseManager::Clear()
IL_0011: ldarg.0
IL_0012: ldarg.0
IL_0013: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_0018: call System.Void PixelCrushers.DialogueSystem.DatabaseManager::Add(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_001d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueDatabase>::GetEnumerator()
IL_0022: stloc.0
IL_0023: br.s IL_0042
IL_0025: ldloca.s V_0
IL_0027: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>::get_Current()
IL_002c: stloc.1
IL_002d: ldloc.1
IL_002e: ldarg.0
IL_002f: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_0034: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0039: brfalse.s IL_0042
IL_003b: ldarg.0
IL_003c: ldloc.1
IL_003d: call System.Void PixelCrushers.DialogueSystem.DatabaseManager::Add(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0042: ldloca.s V_0
IL_0044: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>::MoveNext()
IL_0049: brtrue.s IL_0025
IL_004b: leave.s IL_005b
IL_004d: ldloca.s V_0
IL_004f: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueDatabase>
IL_0055: callvirt System.Void System.IDisposable::Dispose()
IL_005a: endfinally
IL_005b: ret
