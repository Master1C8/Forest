TYPE TheForestOfLove.Player
METHOD System.Void TheForestOfLove.Player::Save() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Save()
IL_0006: ldsfld System.Boolean Globals::isChapterSelect
IL_000b: brtrue.s IL_0014
IL_000d: ldsfld System.Boolean Globals::isCheatCode
IL_0012: brfalse.s IL_0015
IL_0014: ret
IL_0015: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_001a: brfalse.s IL_001d
IL_001c: ret
IL_001d: ldnull
IL_001e: stloc.0
IL_001f: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_0024: ldnull
IL_0025: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_002a: brfalse.s IL_006a
IL_002c: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_0031: callvirt TheForestOfLove.Cameras.CameraSettings TheForestOfLove.Cameras.CameraController::get_currentSettings()
IL_0036: ldnull
IL_0037: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_003c: brfalse.s IL_006a
IL_003e: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_0043: callvirt TheForestOfLove.Cameras.CameraSettings TheForestOfLove.Cameras.CameraController::get_currentSettings()
IL_0048: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_004d: ldnull
IL_004e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0053: brfalse.s IL_006a
IL_0055: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_005a: callvirt TheForestOfLove.Cameras.CameraSettings TheForestOfLove.Cameras.CameraController::get_currentSettings()
IL_005f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0064: callvirt System.String UnityEngine.Object::get_name()
IL_0069: stloc.0
IL_006a: call TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData()
IL_006f: dup
IL_0070: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentGameplaySceneName()
IL_0075: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_007a: dup
IL_007b: ldloc.0
IL_007c: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::cameraSettingsObjectName
IL_0081: dup
IL_0082: ldarg.0
IL_0083: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0088: ldc.i4.4
IL_0089: beq.s IL_009b
IL_008b: ldarg.0
IL_008c: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_0091: brtrue.s IL_009b
IL_0093: ldarg.0
IL_0094: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0099: br.s IL_009c
IL_009b: ldc.i4.1
IL_009c: stfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isSwimming
IL_00a1: dup
IL_00a2: ldarg.0
IL_00a3: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00a8: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_00ad: stfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPosition
IL_00b2: dup
IL_00b3: ldc.i4.1
IL_00b4: stfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPositionExact
IL_00b9: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_LastGameplaySceneName()
IL_00be: stfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::lastAreaUnitySceneName
IL_00c3: ret
