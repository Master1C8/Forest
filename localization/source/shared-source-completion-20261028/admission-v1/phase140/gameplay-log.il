TYPE TheForestOfLove.GameplayLogManager
METHOD System.Void TheForestOfLove.GameplayLogManager::RegisterServices() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RegisterServices()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.ServiceLocator::Register<TheForestOfLove.GameplayLogManager>(T)
IL_000c: ret
METHOD System.Void TheForestOfLove.GameplayLogManager::UnregisterServices() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::UnregisterServices()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.ServiceLocator::Unregister<TheForestOfLove.GameplayLogManager>(T)
IL_000c: ret
METHOD System.Void TheForestOfLove.GameplayLogManager::LogMessage(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Single Globals::get_StoryClock()
IL_0007: call System.Void TheForestOfLove.GameplayLogManager::AddLogHistory(System.String,System.Single)
IL_000c: ret
METHOD System.Void TheForestOfLove.GameplayLogManager::AddLogHistory(System.String,System.Single) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Queue`1<GameplayLogHistory> TheForestOfLove.GameplayLogManager::logHistoryPool
IL_0006: callvirt System.Int32 System.Collections.Generic.Queue`1<GameplayLogHistory>::get_Count()
IL_000b: ldc.i4.0
IL_000c: bgt.s IL_0015
IL_000e: newobj System.Void GameplayLogHistory::.ctor()
IL_0013: br.s IL_0020
IL_0015: ldarg.0
IL_0016: ldfld System.Collections.Generic.Queue`1<GameplayLogHistory> TheForestOfLove.GameplayLogManager::logHistoryPool
IL_001b: callvirt !0 System.Collections.Generic.Queue`1<GameplayLogHistory>::Dequeue()
IL_0020: stloc.0
IL_0021: ldloc.0
IL_0022: ldarg.2
IL_0023: stfld System.Single GameplayLogHistory::timeUnlocked
IL_0028: ldloc.0
IL_0029: ldarg.1
IL_002a: stfld System.String GameplayLogHistory::message
IL_002f: ldarg.0
IL_0030: ldfld System.Collections.Generic.Queue`1<GameplayLogHistory> TheForestOfLove.GameplayLogManager::logHistory
IL_0035: ldloc.0
IL_0036: callvirt System.Void System.Collections.Generic.Queue`1<GameplayLogHistory>::Enqueue(!0)
IL_003b: ldarg.0
IL_003c: call System.Void TheForestOfLove.GameplayLogManager::CleanupLogHistory()
IL_0041: ret
METHOD System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.GameplayLogManager>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldnull
IL_0008: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000d: brfalse.s IL_0016
IL_000f: ldloc.0
IL_0010: ldarg.0
IL_0011: callvirt System.Void TheForestOfLove.GameplayLogManager::LogMessage(System.String)
IL_0016: ret
