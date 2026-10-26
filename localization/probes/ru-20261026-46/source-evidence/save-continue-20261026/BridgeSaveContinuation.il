TYPE ForestProbe
METHOD System.Void ForestProbe::DumpSaveContinuation() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: call TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData()
IL_0006: stloc.0
IL_0007: call TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Services.Persistence.DataService::GetGeneralData()
IL_000c: stloc.1
IL_000d: ldloc.0
IL_000e: brfalse.s IL_0016
IL_0010: ldloc.1
IL_0011: ldnull
IL_0012: ceq
IL_0014: br.s IL_0017
IL_0016: ldc.i4.1
IL_0017: stloc.s V_4
IL_0019: ldloc.s V_4
IL_001b: brfalse.s IL_0028
IL_001d: ldstr "Original save manifest not ready"
IL_0022: newobj System.Void System.Exception::.ctor(System.String)
IL_0027: throw
IL_0028: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_002d: stloc.2
IL_002e: newobj System.Void ForestProbe/SaveContinuationState::.ctor()
IL_0033: dup
IL_0034: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0039: stloc.s V_5
IL_003b: ldloca.s V_5
IL_003d: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0042: stfld System.String ForestProbe/SaveContinuationState::scene
IL_0047: dup
IL_0048: call System.String UnityEngine.Application::get_companyName()
IL_004d: stfld System.String ForestProbe/SaveContinuationState::company
IL_0052: dup
IL_0053: call System.String UnityEngine.Application::get_productName()
IL_0058: stfld System.String ForestProbe/SaveContinuationState::product
IL_005d: dup
IL_005e: call System.String UnityEngine.Application::get_dataPath()
IL_0063: stfld System.String ForestProbe/SaveContinuationState::dataPath
IL_0068: dup
IL_0069: call System.String UnityEngine.Application::get_persistentDataPath()
IL_006e: stfld System.String ForestProbe/SaveContinuationState::persistentDataPath
IL_0073: dup
IL_0074: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0079: stfld System.Int32 ForestProbe/SaveContinuationState::frame
IL_007e: dup
IL_007f: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0084: stfld System.Single ForestProbe/SaveContinuationState::realtime
IL_0089: dup
IL_008a: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_008f: stfld System.Boolean ForestProbe/SaveContinuationState::hasSavedPlaySession
IL_0094: dup
IL_0095: ldsfld System.Boolean Globals::isChapterSelect
IL_009a: stfld System.Boolean ForestProbe/SaveContinuationState::isChapterSelect
IL_009f: dup
IL_00a0: ldsfld System.Boolean Globals::isCheatCode
IL_00a5: stfld System.Boolean ForestProbe/SaveContinuationState::isCheatCode
IL_00aa: dup
IL_00ab: ldsfld System.Boolean Globals::isFinishingSoftReset
IL_00b0: stfld System.Boolean ForestProbe/SaveContinuationState::isFinishingSoftReset
IL_00b5: dup
IL_00b6: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_00bb: stfld System.Boolean ForestProbe/SaveContinuationState::gameplay
IL_00c0: dup
IL_00c1: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_00c6: stfld System.Boolean ForestProbe/SaveContinuationState::anyEvent
IL_00cb: dup
IL_00cc: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_IsConversationActive()
IL_00d1: stfld System.Boolean ForestProbe/SaveContinuationState::conversation
IL_00d6: dup
IL_00d7: ldloc.0
IL_00d8: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_00dd: stfld System.String ForestProbe/SaveContinuationState::currentArea
IL_00e2: dup
IL_00e3: ldloc.0
IL_00e4: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::lastAreaUnitySceneName
IL_00e9: stfld System.String ForestProbe/SaveContinuationState::lastArea
IL_00ee: dup
IL_00ef: ldloc.0
IL_00f0: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPosition
IL_00f5: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::lastPosition
IL_00fa: dup
IL_00fb: ldloc.0
IL_00fc: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastSpawnPosition
IL_0101: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::lastSpawnPosition
IL_0106: dup
IL_0107: ldloc.0
IL_0108: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPositionExact
IL_010d: stfld System.Boolean ForestProbe/SaveContinuationState::lastPositionExact
IL_0112: dup
IL_0113: ldloc.0
IL_0114: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isSwimming
IL_0119: stfld System.Boolean ForestProbe/SaveContinuationState::isSwimming
IL_011e: dup
IL_011f: ldloc.0
IL_0120: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isFastTraveling
IL_0125: stfld System.Boolean ForestProbe/SaveContinuationState::isFastTraveling
IL_012a: dup
IL_012b: ldloc.0
IL_012c: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::cameraSettingsObjectName
IL_0131: stfld System.String ForestProbe/SaveContinuationState::cameraSettingsObjectName
IL_0136: dup
IL_0137: ldloc.1
IL_0138: ldfld System.Single TheForestOfLove.Services.Persistence.GeneralData::storyClock
IL_013d: stfld System.Single ForestProbe/SaveContinuationState::storyClock
IL_0142: dup
IL_0143: ldloc.1
IL_0144: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedControlTutorial
IL_0149: stfld System.Boolean ForestProbe/SaveContinuationState::finishedControlTutorial
IL_014e: dup
IL_014f: ldloc.1
IL_0150: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedDialogueTutorial
IL_0155: stfld System.Boolean ForestProbe/SaveContinuationState::finishedDialogueTutorial
IL_015a: dup
IL_015b: ldloc.1
IL_015c: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedGossipTutorial
IL_0161: stfld System.Boolean ForestProbe/SaveContinuationState::finishedGossipTutorial
IL_0166: dup
IL_0167: ldloc.2
IL_0168: ldnull
IL_0169: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_016e: brfalse.s IL_017d
IL_0170: ldloc.2
IL_0171: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0176: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_017b: br.s IL_017e
IL_017d: ldc.i4.0
IL_017e: stfld System.Boolean ForestProbe/SaveContinuationState::playerPresent
IL_0183: dup
IL_0184: ldloc.2
IL_0185: ldnull
IL_0186: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_018b: brtrue.s IL_019a
IL_018d: ldloc.2
IL_018e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0193: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0198: br.s IL_019b
IL_019a: ldnull
IL_019b: stfld System.String ForestProbe/SaveContinuationState::playerPath
IL_01a0: dup
IL_01a1: ldloc.2
IL_01a2: ldnull
IL_01a3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01a8: brtrue.s IL_01b2
IL_01aa: ldloc.2
IL_01ab: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_01b0: br.s IL_01b3
IL_01b2: ldc.i4.0
IL_01b3: stfld System.Int32 ForestProbe/SaveContinuationState::playerInstance
IL_01b8: dup
IL_01b9: ldloc.2
IL_01ba: ldnull
IL_01bb: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01c0: brtrue.s IL_01cf
IL_01c2: ldloc.2
IL_01c3: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01c8: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_01cd: br.s IL_01d4
IL_01cf: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_01d4: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::playerPosition
IL_01d9: dup
IL_01da: ldarg.0
IL_01db: call System.String[] ForestProbe::TutorialRouteDiagnostics()
IL_01e0: stfld System.String[] ForestProbe/SaveContinuationState::diagnostics
IL_01e5: stloc.3
IL_01e6: ldarg.0
IL_01e7: ldfld System.String ForestProbe::root
IL_01ec: ldstr "save-continuation.json"
IL_01f1: call System.String System.IO.Path::Combine(System.String,System.String)
IL_01f6: ldloc.3
IL_01f7: ldc.i4.1
IL_01f8: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_01fd: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0202: nop
IL_0203: ret
