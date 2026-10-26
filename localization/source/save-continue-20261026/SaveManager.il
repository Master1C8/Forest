TYPE TheForestOfLove.Services.Persistence.SaveManager
METHOD System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SaveManager::_savestate
IL_0005: brfalse.s IL_000d
IL_0007: ldsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::_hasSavestateOnDisk
IL_000c: ret
IL_000d: ldc.i4.0
IL_000e: ret
METHOD System.Void TheForestOfLove.Services.Persistence.SaveManager::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Void TheForestOfLove.Services.Persistence.SaveManager::ReadDataFromDisk()
IL_0005: ldarg.0
IL_0006: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_000b: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_0010: brfalse.s IL_0017
IL_0012: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SetupDefaultTags()
IL_0017: ret
METHOD System.Void TheForestOfLove.Services.Persistence.SaveManager::ReadDataFromDisk() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::get_savingEnabled()
IL_0005: brtrue.s IL_0022
IL_0007: newobj System.Void TheForestOfLove.Services.Persistence.GlobalSavestate::.ctor()
IL_000c: call System.Void TheForestOfLove.Services.Persistence.SaveManager::set_GlobalSavestate(TheForestOfLove.Services.Persistence.GlobalSavestate)
IL_0011: newobj System.Void TheForestOfLove.Services.Persistence.Savestate::.ctor()
IL_0016: call System.Void TheForestOfLove.Services.Persistence.SaveManager::set_Savestate(TheForestOfLove.Services.Persistence.Savestate)
IL_001b: ldc.i4.0
IL_001c: stsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::_hasSavestateOnDisk
IL_0021: ret
IL_0022: call TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::ReadGlobalData()
IL_0027: dup
IL_0028: brtrue.s IL_0030
IL_002a: pop
IL_002b: newobj System.Void TheForestOfLove.Services.Persistence.GlobalSavestate::.ctor()
IL_0030: call System.Void TheForestOfLove.Services.Persistence.SaveManager::set_GlobalSavestate(TheForestOfLove.Services.Persistence.GlobalSavestate)
IL_0035: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SavegameFileHelper::ReadSavegameData()
IL_003a: call System.Void TheForestOfLove.Services.Persistence.SaveManager::set_Savestate(TheForestOfLove.Services.Persistence.Savestate)
IL_003f: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SaveManager::get_Savestate()
IL_0044: ldnull
IL_0045: cgt.un
IL_0047: stsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::_hasSavestateOnDisk
IL_004c: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SaveManager::get_Savestate()
IL_0051: dup
IL_0052: brtrue.s IL_005a
IL_0054: pop
IL_0055: newobj System.Void TheForestOfLove.Services.Persistence.Savestate::.ctor()
IL_005a: call System.Void TheForestOfLove.Services.Persistence.SaveManager::set_Savestate(TheForestOfLove.Services.Persistence.Savestate)
IL_005f: ret
METHOD System.Void TheForestOfLove.Services.Persistence.SaveManager::WriteDataToDisk() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::get_savingEnabled()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::isSilentSave
IL_000d: brtrue.s IL_002c
IL_000f: ldsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::isAutosave
IL_0014: brfalse.s IL_0022
IL_0016: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Services.Persistence.SaveManager::onAutosaveStarted
IL_001b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0020: br.s IL_002c
IL_0022: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Services.Persistence.SaveManager::onManualSaveStarted
IL_0027: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_002c: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_saveGlobalDataOnly()
IL_0031: brtrue.s IL_0043
IL_0033: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SaveManager::get_Savestate()
IL_0038: call System.Void TheForestOfLove.Services.Persistence.SavegameFileHelper::WriteSavegameData(TheForestOfLove.Services.Persistence.Savestate)
IL_003d: ldc.i4.1
IL_003e: stsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::_hasSavestateOnDisk
IL_0043: call TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.SaveManager::get_GlobalSavestate()
IL_0048: call System.Void TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::WriteGlobalData(TheForestOfLove.Services.Persistence.GlobalSavestate)
IL_004d: ldsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::isSilentSave
IL_0052: brtrue.s IL_0070
IL_0054: ldsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::isAutosave
IL_0059: brfalse.s IL_0066
IL_005b: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Services.Persistence.SaveManager::onAutosaveEnded
IL_0060: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0065: ret
IL_0066: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Services.Persistence.SaveManager::onManualSaveEnded
IL_006b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0070: ret
METHOD System.Void TheForestOfLove.Services.Persistence.SaveManager::Save(System.Boolean,System.Boolean,System.Boolean) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: stsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::isAutosave
IL_0006: ldarg.1
IL_0007: stsfld System.Boolean TheForestOfLove.Services.Persistence.SaveManager::isSilentSave
IL_000c: ldarg.2
IL_000d: call System.Void TheForestOfLove.Services.Persistence.SaveManager::set_saveGlobalDataOnly(System.Boolean)
IL_0012: call System.Void TheForestOfLove.Core.BaseBehavior::InvokeSave()
IL_0017: ret
