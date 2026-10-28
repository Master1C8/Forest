TYPE TheForestOfLove.FinleyShearingCutscene
METHOD System.Void TheForestOfLove.FinleyShearingCutscene::SetPlayerWaypoints() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Transform TheForestOfLove.FinleyShearingCutscene::waypoints
IL_0006: stloc.0
IL_0007: ldstr "Finley"
IL_000c: call TheForestOfLove.Gameplay.CritterActor TheForestOfLove.Gameplay.CritterActor::FindActorByName(System.String)
IL_0011: stloc.1
IL_0012: ldloc.1
IL_0013: ldnull
IL_0014: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0019: brfalse.s IL_006e
IL_001b: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0020: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0025: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_002a: ldfld System.Single UnityEngine.Vector3::x
IL_002f: ldloc.1
IL_0030: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0035: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_003a: ldfld System.Single UnityEngine.Vector3::x
IL_003f: ble.un.s IL_006e
IL_0041: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0046: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_004b: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0050: ldfld System.Single UnityEngine.Vector3::y
IL_0055: ldloc.1
IL_0056: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_005b: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0060: ldfld System.Single UnityEngine.Vector3::y
IL_0065: ble.un.s IL_006e
IL_0067: ldarg.0
IL_0068: ldfld UnityEngine.Transform TheForestOfLove.FinleyShearingCutscene::waypointsAlternate
IL_006d: stloc.0
IL_006e: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0073: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0078: ldloc.0
IL_0079: callvirt System.Void TheForestOfLove.WaypointController::SetWaypoints(UnityEngine.Transform)
IL_007e: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0083: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0088: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.WaypointController::onWaypointsFollowed
IL_008d: ldarg.0
IL_008e: ldftn System.Void TheForestOfLove.FinleyShearingCutscene::OnPlayerWaypointsFollowed()
IL_0094: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0099: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_009e: ret
METHOD System.Void TheForestOfLove.FinleyShearingCutscene::<OnConversationTriggerFired>b__24_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldstr "Finley"
IL_0005: ldarg.0
IL_0006: ldfld UnityEngine.Transform TheForestOfLove.FinleyShearingCutscene::ramOffscreenLocation
IL_000b: ldnull
IL_000c: call System.Void TheForestOfLove.CCTeleport::Teleport(System.String,UnityEngine.Transform,TheForestOfLove.TransformOffset)
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.GameObject TheForestOfLove.FinleyShearingCutscene::finleyStatic
IL_0017: ldc.i4.1
IL_0018: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_001d: ldstr "Player"
IL_0022: ldarg.0
IL_0023: ldfld UnityEngine.Transform TheForestOfLove.FinleyShearingCutscene::playerLocation0
IL_0028: ldnull
IL_0029: call System.Void TheForestOfLove.CCTeleport::Teleport(System.String,UnityEngine.Transform,TheForestOfLove.TransformOffset)
IL_002e: ldarg.0
IL_002f: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_0034: ldarg.0
IL_0035: ldfld System.Int32 TheForestOfLove.FinleyShearingCutscene::cameraSettingsId
IL_003a: ldarg.0
IL_003b: ldfld TheForestOfLove.Cameras.CameraSettings TheForestOfLove.FinleyShearingCutscene::shearingCameraSettings
IL_0040: ldc.i4.0
IL_0041: callvirt System.Int32 TheForestOfLove.Cameras.CameraController::PushOrReplaceSettingsAndLock(System.Int32,TheForestOfLove.Cameras.CameraSettings,System.Boolean)
IL_0046: stfld System.Int32 TheForestOfLove.FinleyShearingCutscene::cameraSettingsId
IL_004b: ldc.r4 0.1
IL_0050: ldarg.0
IL_0051: ldftn System.Void TheForestOfLove.FinleyShearingCutscene::DoShearingPart1()
IL_0057: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_005c: call System.Void TheForestOfLove.CutsceneManager::FadeFromBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0061: ret
METHOD System.Void TheForestOfLove.FinleyShearingCutscene::<DoFinishShearing>b__32_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldstr "Finley"
IL_0005: ldarg.0
IL_0006: ldfld UnityEngine.Transform TheForestOfLove.FinleyShearingCutscene::ramHomeLocation
IL_000b: ldnull
IL_000c: call System.Void TheForestOfLove.CCTeleport::Teleport(System.String,UnityEngine.Transform,TheForestOfLove.TransformOffset)
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.GameObject TheForestOfLove.FinleyShearingCutscene::finleyStatic
IL_0017: ldc.i4.0
IL_0018: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_001d: ldstr "Player"
IL_0022: ldarg.0
IL_0023: ldfld UnityEngine.Transform TheForestOfLove.FinleyShearingCutscene::playerLocation5
IL_0028: ldnull
IL_0029: call System.Void TheForestOfLove.CCTeleport::Teleport(System.String,UnityEngine.Transform,TheForestOfLove.TransformOffset)
IL_002e: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_0033: ldarg.0
IL_0034: ldfld System.Int32 TheForestOfLove.FinleyShearingCutscene::cameraSettingsId
IL_0039: callvirt System.Void TheForestOfLove.Cameras.CameraController::PopSettings(System.Int32)
IL_003e: ldc.r4 0.3
IL_0043: ldarg.0
IL_0044: ldftn System.Void TheForestOfLove.FinleyShearingCutscene::DoFinishShearingPart2()
IL_004a: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_004f: call System.Void TheForestOfLove.CutsceneManager::FadeFromBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0054: ret
