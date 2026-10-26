TYPE TheForestOfLove.SpawnManager
METHOD System.Void TheForestOfLove.SpawnManager::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ret
METHOD System.Void TheForestOfLove.SpawnManager::OnActiveSceneChanged(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call System.Void TheForestOfLove.Core.BaseBehavior::OnActiveSceneChanged(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene)
IL_0008: ldarg.0
IL_0009: ldnull
IL_000a: stfld TheForestOfLove.Doorway TheForestOfLove.SpawnManager::lastDoorway
IL_000f: ret
METHOD System.Void TheForestOfLove.SpawnManager::FinishSpawningPlayer() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0005: stloc.0
IL_0006: call System.Boolean TheForestOfLove.SpawnManager::get_isFastTraveling()
IL_000b: call System.Void TheForestOfLove.SpawnManager::set_wasFastTravelingLastSceneLoad(System.Boolean)
IL_0010: call TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData()
IL_0015: stloc.1
IL_0016: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_LastSceneName()
IL_001b: ldstr "StartMenu"
IL_0020: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0025: brtrue.s IL_0035
IL_0027: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_LastSceneName()
IL_002c: brfalse.s IL_0035
IL_002e: call System.Boolean Globals::get_IgnoreOriginDoorwayDuringRespawn()
IL_0033: brfalse.s IL_0063
IL_0035: call System.Boolean TheForestOfLove.SpawnManager::get_wasFastTravelingLastSceneLoad()
IL_003a: brtrue.s IL_0063
IL_003c: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0041: ldloc.1
IL_0042: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_0047: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_004c: brfalse.s IL_0063
IL_004e: ldloc.1
IL_004f: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPositionExact
IL_0054: brfalse.s IL_0063
IL_0056: ldloc.1
IL_0057: call System.Void TheForestOfLove.SpawnManager::RespawnPlayerAtExactPosition(TheForestOfLove.Services.Persistence.PlayerRespawnData)
IL_005c: ldc.i4.0
IL_005d: call System.Void Globals::set_IgnoreOriginDoorwayDuringRespawn(System.Boolean)
IL_0062: ret
IL_0063: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0068: ldstr "StartMenu"
IL_006d: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0072: brfalse IL_02ac
IL_0077: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_007c: stloc.2
IL_007d: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_0082: stloc.3
IL_0083: call System.Boolean TheForestOfLove.SpawnManager::get_isFastTraveling()
IL_0088: brfalse.s IL_00d9
IL_008a: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_008f: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::FinishFastTravel()
IL_0094: call !!0[] UnityEngine.Object::FindObjectsOfType<TheForestOfLove.Doorway>()
IL_0099: stloc.s V_5
IL_009b: ldc.i4.0
IL_009c: stloc.s V_6
IL_009e: br.s IL_00d1
IL_00a0: ldloc.s V_5
IL_00a2: ldloc.s V_6
IL_00a4: ldelem.ref
IL_00a5: stloc.s V_7
IL_00a7: ldloc.s V_7
IL_00a9: ldfld System.String TheForestOfLove.Doorway::sceneName
IL_00ae: ldstr "fast_travel"
IL_00b3: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00b8: brfalse.s IL_00cb
IL_00ba: ldloca.s V_0
IL_00bc: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_00c1: ldloc.2
IL_00c2: ldloc.3
IL_00c3: ldloc.s V_7
IL_00c5: call System.Void TheForestOfLove.SpawnManager::RespawnPlayer(System.String,TheForestOfLove.Player,TheForestOfLove.Cameras.CameraController,TheForestOfLove.Doorway)
IL_00ca: ret
IL_00cb: ldloc.s V_6
IL_00cd: ldc.i4.1
IL_00ce: add
IL_00cf: stloc.s V_6
IL_00d1: ldloc.s V_6
IL_00d3: ldloc.s V_5
IL_00d5: ldlen
IL_00d6: conv.i4
IL_00d7: blt.s IL_00a0
IL_00d9: call System.Boolean TheForestOfLove.SpawnManager::get_donkeyFastTravel()
IL_00de: brfalse.s IL_0125
IL_00e0: call !!0[] UnityEngine.Object::FindObjectsOfType<TheForestOfLove.Doorway>()
IL_00e5: stloc.s V_5
IL_00e7: ldc.i4.0
IL_00e8: stloc.s V_6
IL_00ea: br.s IL_011d
IL_00ec: ldloc.s V_5
IL_00ee: ldloc.s V_6
IL_00f0: ldelem.ref
IL_00f1: stloc.s V_8
IL_00f3: ldloc.s V_8
IL_00f5: ldfld System.String TheForestOfLove.Doorway::sceneName
IL_00fa: ldstr "donkey_fast_travel_respawn"
IL_00ff: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0104: brfalse.s IL_0117
IL_0106: ldloca.s V_0
IL_0108: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_010d: ldloc.2
IL_010e: ldloc.3
IL_010f: ldloc.s V_8
IL_0111: call System.Void TheForestOfLove.SpawnManager::RespawnPlayer(System.String,TheForestOfLove.Player,TheForestOfLove.Cameras.CameraController,TheForestOfLove.Doorway)
IL_0116: ret
IL_0117: ldloc.s V_6
IL_0119: ldc.i4.1
IL_011a: add
IL_011b: stloc.s V_6
IL_011d: ldloc.s V_6
IL_011f: ldloc.s V_5
IL_0121: ldlen
IL_0122: conv.i4
IL_0123: blt.s IL_00ec
IL_0125: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.PlantQuestMinigameControllerRedux>()
IL_012a: stloc.s V_4
IL_012c: ldloc.s V_4
IL_012e: ldnull
IL_012f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0134: brfalse.s IL_018c
IL_0136: ldloc.s V_4
IL_0138: callvirt System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_respawningPlayer()
IL_013d: brfalse.s IL_018c
IL_013f: call !!0[] UnityEngine.Object::FindObjectsOfType<TheForestOfLove.Doorway>()
IL_0144: stloc.s V_5
IL_0146: ldc.i4.0
IL_0147: stloc.s V_6
IL_0149: br.s IL_0184
IL_014b: ldloc.s V_5
IL_014d: ldloc.s V_6
IL_014f: ldelem.ref
IL_0150: stloc.s V_9
IL_0152: ldloc.s V_9
IL_0154: ldfld System.String TheForestOfLove.Doorway::sceneName
IL_0159: ldstr "plant_quest_minigame_respawn"
IL_015e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0163: brfalse.s IL_017e
IL_0165: ldloc.s V_4
IL_0167: ldc.i4.0
IL_0168: callvirt System.Void TheForestOfLove.PlantQuestMinigameControllerRedux::set_respawningPlayer(System.Boolean)
IL_016d: ldloca.s V_0
IL_016f: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0174: ldloc.2
IL_0175: ldloc.3
IL_0176: ldloc.s V_9
IL_0178: call System.Void TheForestOfLove.SpawnManager::RespawnPlayer(System.String,TheForestOfLove.Player,TheForestOfLove.Cameras.CameraController,TheForestOfLove.Doorway)
IL_017d: ret
IL_017e: ldloc.s V_6
IL_0180: ldc.i4.1
IL_0181: add
IL_0182: stloc.s V_6
IL_0184: ldloc.s V_6
IL_0186: ldloc.s V_5
IL_0188: ldlen
IL_0189: conv.i4
IL_018a: blt.s IL_014b
IL_018c: call !!0[] UnityEngine.Object::FindObjectsOfType<TheForestOfLove.Doorway>()
IL_0191: stloc.s V_5
IL_0193: ldc.i4.0
IL_0194: stloc.s V_6
IL_0196: br.s IL_01ed
IL_0198: ldloc.s V_5
IL_019a: ldloc.s V_6
IL_019c: ldelem.ref
IL_019d: stloc.s V_10
IL_019f: ldloc.s V_10
IL_01a1: ldfld System.String TheForestOfLove.Doorway::sceneName
IL_01a6: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_LastSceneName()
IL_01ab: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01b0: brtrue.s IL_01d6
IL_01b2: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_LastSceneName()
IL_01b7: ldstr "DustinMinigame_Integrated"
IL_01bc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01c1: brfalse.s IL_01e7
IL_01c3: ldloc.s V_10
IL_01c5: ldfld System.String TheForestOfLove.Doorway::sceneName
IL_01ca: ldstr "dustin_minigame_spawn_point"
IL_01cf: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01d4: brfalse.s IL_01e7
IL_01d6: ldloca.s V_0
IL_01d8: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_01dd: ldloc.2
IL_01de: ldloc.3
IL_01df: ldloc.s V_10
IL_01e1: call System.Void TheForestOfLove.SpawnManager::RespawnPlayer(System.String,TheForestOfLove.Player,TheForestOfLove.Cameras.CameraController,TheForestOfLove.Doorway)
IL_01e6: ret
IL_01e7: ldloc.s V_6
IL_01e9: ldc.i4.1
IL_01ea: add
IL_01eb: stloc.s V_6
IL_01ed: ldloc.s V_6
IL_01ef: ldloc.s V_5
IL_01f1: ldlen
IL_01f2: conv.i4
IL_01f3: blt.s IL_0198
IL_01f5: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_01fa: ldloc.1
IL_01fb: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_0200: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0205: brfalse.s IL_0215
IL_0207: ldloc.1
IL_0208: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPositionExact
IL_020d: brfalse.s IL_0215
IL_020f: ldloc.1
IL_0210: call System.Void TheForestOfLove.SpawnManager::RespawnPlayerAtExactPosition(TheForestOfLove.Services.Persistence.PlayerRespawnData)
IL_0215: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inMountainsBearCave()
IL_021a: brfalse.s IL_0222
IL_021c: ldloc.2
IL_021d: callvirt System.Void TheForestOfLove.Player::ToggleSweaterWithoutTransition()
IL_0222: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0227: ldstr "DeepWoods_Campfire"
IL_022c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0231: brfalse.s IL_024b
IL_0233: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_LastSceneName()
IL_0238: ldstr "DeepWoods_FirstFork"
IL_023d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0242: brfalse.s IL_024b
IL_0244: call System.Void TheForestOfLove.Player::ToggleLanternWithoutTransitionAtSpawn()
IL_0249: br.s IL_028d
IL_024b: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0250: ldstr "DeepWoods_Campfire"
IL_0255: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_025a: brfalse.s IL_028d
IL_025c: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0261: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_0266: ldfld System.Single UnityEngine.Vector3::x
IL_026b: ldc.r4 2.5
IL_0270: bge.un.s IL_028d
IL_0272: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0277: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_027c: ldfld System.Single UnityEngine.Vector3::y
IL_0281: ldc.r4 1.5
IL_0286: bge.un.s IL_028d
IL_0288: call System.Void TheForestOfLove.Player::ToggleLanternWithoutTransitionAtSpawn()
IL_028d: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDeepWoods()
IL_0292: brfalse.s IL_02a1
IL_0294: ldloc.1
IL_0295: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isSwimming
IL_029a: brfalse.s IL_02a1
IL_029c: call System.Void TheForestOfLove.Player::ToggleLanternWithoutTransitionAtSpawn()
IL_02a1: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.GameEvents::onExitingDoorway
IL_02a6: ldnull
IL_02a7: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_02ac: ret
METHOD System.Void TheForestOfLove.SpawnManager::RespawnPlayerAtExactPosition(TheForestOfLove.Services.Persistence.PlayerRespawnData) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::respawnData
IL_000d: ldloc.0
IL_000e: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0013: stfld TheForestOfLove.Player TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::player
IL_0018: ldloc.0
IL_0019: ldfld TheForestOfLove.Player TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::player
IL_001e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0023: ldloc.0
IL_0024: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::respawnData
IL_0029: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPosition
IL_002e: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0033: ldloc.0
IL_0034: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::respawnData
IL_0039: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isSwimming
IL_003e: brfalse.s IL_0087
IL_0040: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inLake()
IL_0045: brfalse.s IL_0057
IL_0047: ldloc.0
IL_0048: ldfld TheForestOfLove.Player TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::player
IL_004d: callvirt System.Void TheForestOfLove.Player::Swim()
IL_0052: br IL_00d7
IL_0057: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inMountains()
IL_005c: brtrue.s IL_006c
IL_005e: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inMountainsBearCave()
IL_0063: brtrue.s IL_006c
IL_0065: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inPlainsEnd()
IL_006a: brfalse.s IL_0079
IL_006c: ldloc.0
IL_006d: ldfld TheForestOfLove.Player TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::player
IL_0072: callvirt System.Void TheForestOfLove.Player::ToggleSweaterWithoutTransition()
IL_0077: br.s IL_00d7
IL_0079: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDeepWoods()
IL_007e: brfalse.s IL_00d7
IL_0080: call System.Void TheForestOfLove.Player::ToggleLanternWithoutTransitionAtSpawn()
IL_0085: br.s IL_00d7
IL_0087: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_LastSceneName()
IL_008c: ldstr "DeepWoods_FirstFork"
IL_0091: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0096: brfalse.s IL_00b0
IL_0098: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_009d: ldstr "DeepWoods_Campfire"
IL_00a2: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00a7: brfalse.s IL_00b0
IL_00a9: call System.Void TheForestOfLove.Player::ToggleLanternWithoutTransitionAtSpawn()
IL_00ae: br.s IL_00d7
IL_00b0: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_LastSceneName()
IL_00b5: ldstr "DeepWoods_Campfire"
IL_00ba: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00bf: brfalse.s IL_00d7
IL_00c1: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_00c6: ldstr "DeepWoods_FirstFork"
IL_00cb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00d0: brfalse.s IL_00d7
IL_00d2: call System.Void TheForestOfLove.Player::ToggleLanternWithoutTransitionAtSpawn()
IL_00d7: ldloc.0
IL_00d8: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::respawnData
IL_00dd: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::hasPlayerDirection
IL_00e2: brfalse.s IL_00f5
IL_00e4: ldloc.0
IL_00e5: ldftn System.Void TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::<RespawnPlayerAtExactPosition>b__0()
IL_00eb: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00f0: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_00f5: ldnull
IL_00f6: stloc.1
IL_00f7: ldloc.0
IL_00f8: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::respawnData
IL_00fd: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::cameraSettingsObjectName
IL_0102: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0107: brtrue.s IL_011a
IL_0109: ldloc.0
IL_010a: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.SpawnManager/<>c__DisplayClass28_0::respawnData
IL_010f: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::cameraSettingsObjectName
IL_0114: call UnityEngine.GameObject UnityEngine.GameObject::Find(System.String)
IL_0119: stloc.1
IL_011a: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_011f: ldloc.1
IL_0120: ldnull
IL_0121: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0126: brtrue.s IL_012b
IL_0128: ldnull
IL_0129: br.s IL_0131
IL_012b: ldloc.1
IL_012c: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.Cameras.CameraSettings>()
IL_0131: ldnull
IL_0132: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0137: pop
IL_0138: callvirt System.Void TheForestOfLove.Cameras.CameraController::SnapToTargetPositionImmediate()
IL_013d: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.GameEvents::onExitingDoorway
IL_0142: ldnull
IL_0143: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_0148: ret
