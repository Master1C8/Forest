TYPE TheForestOfLove.Player
METHOD System.Void TheForestOfLove.Player::Update()
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDeepWoods()
IL_0006: brfalse.s IL_000f
IL_0008: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inTestScene()
IL_000d: brfalse.s IL_0017
IL_000f: ldarg.0
IL_0010: ldfld UnityEngine.Vector2 TheForestOfLove.Player::speed
IL_0015: br.s IL_001d
IL_0017: ldarg.0
IL_0018: ldfld UnityEngine.Vector2 TheForestOfLove.Player::speedDeepWoods
IL_001d: stfld UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0022: ldarg.0
IL_0023: ldarg.0
IL_0024: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0029: ldc.i4.4
IL_002a: beq.s IL_0034
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0032: br.s IL_003a
IL_0034: ldarg.0
IL_0035: ldfld UnityEngine.Vector2 TheForestOfLove.Player::speedSwimming
IL_003a: stfld UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_003f: ldarg.0
IL_0040: ldarg.0
IL_0041: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0046: ldc.i4.5
IL_0047: beq.s IL_0051
IL_0049: ldarg.0
IL_004a: ldfld UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_004f: br.s IL_0057
IL_0051: ldarg.0
IL_0052: ldfld UnityEngine.Vector2 TheForestOfLove.Player::speedDashing
IL_0057: stfld UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_005c: ldarg.0
IL_005d: call System.Void TheForestOfLove.Player::CheckAllowNewConversations()
IL_0062: ldarg.0
IL_0063: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0068: ldc.i4.1
IL_0069: beq.s IL_0074
IL_006b: ldarg.0
IL_006c: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0071: ldc.i4.3
IL_0072: bne.un.s IL_0090
IL_0074: ldarg.0
IL_0075: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_007a: ldarg.0
IL_007b: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0080: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0085: ldc.i4.2
IL_0086: call UnityEngine.Vector3 TheForestOfLove.GeneralExtensions::PixelPerfect(UnityEngine.Vector3,System.Int32)
IL_008b: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0090: ret
METHOD System.Void TheForestOfLove.Player::FixedUpdate()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Player::CheckInput()
IL_0006: ret
METHOD System.Void TheForestOfLove.Player::CheckInput()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.PlayerSwimTransition TheForestOfLove.Player::playerSwimTransition
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_001c
IL_000e: ldarg.0
IL_000f: ldfld TheForestOfLove.PlayerSwimTransition TheForestOfLove.Player::playerSwimTransition
IL_0014: callvirt System.Boolean TheForestOfLove.PlayerSwimTransition::get_isTransitioning()
IL_0019: brfalse.s IL_001c
IL_001b: ret
IL_001c: ldarg.0
IL_001d: call System.Boolean TheForestOfLove.Player::get_lanternTransitioning()
IL_0022: brfalse.s IL_0025
IL_0024: ret
IL_0025: ldarg.0
IL_0026: call System.Boolean TheForestOfLove.Player::get_sweaterTransitioning()
IL_002b: brfalse.s IL_002e
IL_002d: ret
IL_002e: call UnityEngine.Vector3 TheForestOfLove.InputHelper::get_FullAxis()
IL_0033: stloc.0
IL_0034: ldarg.0
IL_0035: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_003a: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_003f: brfalse.s IL_0047
IL_0041: ldarg.0
IL_0042: call System.Void TheForestOfLove.Player::DisableWindPhysics()
IL_0047: ldarg.0
IL_0048: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_004d: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_0052: brfalse.s IL_0075
IL_0054: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0059: brtrue.s IL_0075
IL_005b: ldarg.0
IL_005c: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0061: callvirt UnityEngine.Vector3 TheForestOfLove.WaypointController::CalculateInputFromWaypoints()
IL_0066: stloc.0
IL_0067: ldarg.0
IL_0068: ldarg.0
IL_0069: ldfld System.Single TheForestOfLove.Player::nudgeFactorWaypoints
IL_006e: stfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_0073: br.s IL_0098
IL_0075: ldarg.0
IL_0076: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_007b: ldc.i4.4
IL_007c: bne.un.s IL_008c
IL_007e: ldarg.0
IL_007f: ldarg.0
IL_0080: ldfld System.Single TheForestOfLove.Player::nudgeFactorSwimming
IL_0085: stfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_008a: br.s IL_0098
IL_008c: ldarg.0
IL_008d: ldarg.0
IL_008e: ldfld System.Single TheForestOfLove.Player::nudgeFactorWalking
IL_0093: stfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_0098: ldarg.0
IL_0099: ldfld System.Boolean TheForestOfLove.Player::enableMovement
IL_009e: brtrue.s IL_00b5
IL_00a0: ldarg.0
IL_00a1: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_00a6: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_00ab: brtrue.s IL_00b5
IL_00ad: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_00b2: stloc.0
IL_00b3: br.s IL_00cf
IL_00b5: ldarg.0
IL_00b6: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_00bb: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_00c0: brfalse.s IL_00cf
IL_00c2: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_00c7: brfalse.s IL_00cf
IL_00c9: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_00ce: stloc.0
IL_00cf: ldarg.0
IL_00d0: ldfld System.Single TheForestOfLove.Player::dashCooldownTimeRemaining
IL_00d5: ldc.r4 0
IL_00da: ble.un IL_0161
IL_00df: call System.Boolean TheForestOfLove.InputHelper::get_IsSecondaryActionButtonDown()
IL_00e4: brfalse.s IL_0129
IL_00e6: ldarg.0
IL_00e7: ldfld System.Int32 TheForestOfLove.Player::currentUsedDashes
IL_00ec: ldarg.0
IL_00ed: ldfld System.Int32 TheForestOfLove.Player::maxConsecutiveDashes
IL_00f2: bge.s IL_0114
IL_00f4: ldarg.0
IL_00f5: ldfld System.Boolean TheForestOfLove.Player::multiDashCurrentlyWithinTimingThreshold
IL_00fa: brfalse.s IL_0114
IL_00fc: ldarg.0
IL_00fd: ldfld System.Boolean TheForestOfLove.Player::isEligibleForMultiDash
IL_0102: brfalse.s IL_0114
IL_0104: ldarg.0
IL_0105: ldc.i4.1
IL_0106: stfld System.Boolean TheForestOfLove.Player::multiDashIsQueued
IL_010b: ldarg.0
IL_010c: ldc.i4.0
IL_010d: stfld System.Boolean TheForestOfLove.Player::isEligibleForMultiDash
IL_0112: br.s IL_0145
IL_0114: ldarg.0
IL_0115: ldarg.0
IL_0116: ldfld System.Int32 TheForestOfLove.Player::maxConsecutiveDashes
IL_011b: stfld System.Int32 TheForestOfLove.Player::currentUsedDashes
IL_0120: ldarg.0
IL_0121: ldc.i4.0
IL_0122: stfld System.Boolean TheForestOfLove.Player::isEligibleForMultiDash
IL_0127: br.s IL_0145
IL_0129: call System.Boolean TheForestOfLove.InputHelper::get_IsSecondaryActionButtonHeld()
IL_012e: brtrue.s IL_0145
IL_0130: ldarg.0
IL_0131: ldfld System.Int32 TheForestOfLove.Player::currentUsedDashes
IL_0136: ldarg.0
IL_0137: ldfld System.Int32 TheForestOfLove.Player::maxConsecutiveDashes
IL_013c: bge.s IL_0145
IL_013e: ldarg.0
IL_013f: ldc.i4.1
IL_0140: stfld System.Boolean TheForestOfLove.Player::isEligibleForMultiDash
IL_0145: ldarg.0
IL_0146: ldarg.0
IL_0147: ldfld System.Single TheForestOfLove.Player::dashCooldownTimeRemaining
IL_014c: call System.Single UnityEngine.Time::get_deltaTime()
IL_0151: sub
IL_0152: ldc.r4 0
IL_0157: call System.Single UnityEngine.Mathf::Max(System.Single,System.Single)
IL_015c: stfld System.Single TheForestOfLove.Player::dashCooldownTimeRemaining
IL_0161: ldarg.0
IL_0162: ldfld System.Single TheForestOfLove.Player::dashCooldownTimeRemaining
IL_0167: ldc.r4 0
IL_016c: bne.un.s IL_0175
IL_016e: ldarg.0
IL_016f: ldc.i4.0
IL_0170: stfld System.Int32 TheForestOfLove.Player::currentUsedDashes
IL_0175: ldarg.0
IL_0176: ldarg.0
IL_0177: ldfld System.Boolean TheForestOfLove.Player::isSlashUnlockedDebug
IL_017c: call System.Void TheForestOfLove.Player::set_isSlashUnlocked(System.Boolean)
IL_0181: ldarg.0
IL_0182: ldfld System.Single TheForestOfLove.Player::slashCooldownTimeRemaining
IL_0187: ldc.r4 0
IL_018c: ble.un IL_023c
IL_0191: ldc.i4 306
IL_0196: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_019b: brtrue.s IL_01a9
IL_019d: ldc.i4 305
IL_01a2: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_01a7: brfalse.s IL_01f3
IL_01a9: ldarg.0
IL_01aa: ldfld System.Int32 TheForestOfLove.Player::currentUsedSlashes
IL_01af: ldarg.0
IL_01b0: ldfld System.Int32 TheForestOfLove.Player::maxConsecutiveSlashes
IL_01b5: bge.s IL_01de
IL_01b7: ldarg.0
IL_01b8: ldfld System.Boolean TheForestOfLove.Player::multiSlashCurrentlyWithinTimingThreshold
IL_01bd: brfalse.s IL_01de
IL_01bf: ldarg.0
IL_01c0: ldfld System.Boolean TheForestOfLove.Player::isEligibleForMultiSlash
IL_01c5: brfalse.s IL_01de
IL_01c7: ldarg.0
IL_01c8: ldc.i4.1
IL_01c9: call System.Void TheForestOfLove.Player::SlashUseBonusSwipe_UpdateAnimators(System.Boolean)
IL_01ce: ldarg.0
IL_01cf: ldc.i4.1
IL_01d0: stfld System.Boolean TheForestOfLove.Player::multiSlashIsQueued
IL_01d5: ldarg.0
IL_01d6: ldc.i4.0
IL_01d7: stfld System.Boolean TheForestOfLove.Player::isEligibleForMultiSlash
IL_01dc: br.s IL_0220
IL_01de: ldarg.0
IL_01df: ldarg.0
IL_01e0: ldfld System.Int32 TheForestOfLove.Player::maxConsecutiveSlashes
IL_01e5: stfld System.Int32 TheForestOfLove.Player::currentUsedSlashes
IL_01ea: ldarg.0
IL_01eb: ldc.i4.0
IL_01ec: stfld System.Boolean TheForestOfLove.Player::isEligibleForMultiSlash
IL_01f1: br.s IL_0220
IL_01f3: ldc.i4 306
IL_01f8: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_01fd: brtrue.s IL_0220
IL_01ff: ldc.i4 305
IL_0204: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_0209: brtrue.s IL_0220
IL_020b: ldarg.0
IL_020c: ldfld System.Int32 TheForestOfLove.Player::currentUsedSlashes
IL_0211: ldarg.0
IL_0212: ldfld System.Int32 TheForestOfLove.Player::maxConsecutiveSlashes
IL_0217: bge.s IL_0220
IL_0219: ldarg.0
IL_021a: ldc.i4.1
IL_021b: stfld System.Boolean TheForestOfLove.Player::isEligibleForMultiSlash
IL_0220: ldarg.0
IL_0221: ldarg.0
IL_0222: ldfld System.Single TheForestOfLove.Player::slashCooldownTimeRemaining
IL_0227: call System.Single UnityEngine.Time::get_deltaTime()
IL_022c: sub
IL_022d: ldc.r4 0
IL_0232: call System.Single UnityEngine.Mathf::Max(System.Single,System.Single)
IL_0237: stfld System.Single TheForestOfLove.Player::slashCooldownTimeRemaining
IL_023c: ldarg.0
IL_023d: ldfld System.Single TheForestOfLove.Player::slashCooldownTimeRemaining
IL_0242: ldc.r4 0
IL_0247: bne.un.s IL_0250
IL_0249: ldarg.0
IL_024a: ldc.i4.0
IL_024b: stfld System.Int32 TheForestOfLove.Player::currentUsedSlashes
IL_0250: ldarg.0
IL_0251: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0256: ldc.i4.5
IL_0257: bne.un.s IL_0282
IL_0259: ldarg.0
IL_025a: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_025f: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_0264: brfalse.s IL_026e
IL_0266: ldarg.0
IL_0267: ldfld System.Boolean TheForestOfLove.Player::enteringDoorway
IL_026c: brfalse.s IL_0282
IL_026e: ldarg.0
IL_026f: ldarg.0
IL_0270: ldfld UnityEngine.Vector3 TheForestOfLove.Player::dashingInput
IL_0275: call System.Void TheForestOfLove.Player::Dash(UnityEngine.Vector3)
IL_027a: ldarg.0
IL_027b: ldc.i4.1
IL_027c: stfld System.Boolean TheForestOfLove.Player::dashingEnding
IL_0281: ret
IL_0282: ldarg.0
IL_0283: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0288: ldc.i4.7
IL_0289: bne.un.s IL_0291
IL_028b: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_0290: stloc.0
IL_0291: ldarg.0
IL_0292: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0297: ldc.i4.7
IL_0298: bne.un.s IL_02c3
IL_029a: ldarg.0
IL_029b: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_02a0: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_02a5: brfalse.s IL_02af
IL_02a7: ldarg.0
IL_02a8: ldfld System.Boolean TheForestOfLove.Player::enteringDoorway
IL_02ad: brfalse.s IL_02c3
IL_02af: ldarg.0
IL_02b0: ldarg.0
IL_02b1: ldfld UnityEngine.Vector3 TheForestOfLove.Player::slashingInput
IL_02b6: call System.Void TheForestOfLove.Player::Slash(UnityEngine.Vector3)
IL_02bb: ldarg.0
IL_02bc: ldc.i4.1
IL_02bd: stfld System.Boolean TheForestOfLove.Player::slashingEnding
IL_02c2: ret
IL_02c3: ldarg.0
IL_02c4: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_02c9: ldc.i4.4
IL_02ca: bne.un IL_0593
IL_02cf: call System.Boolean TheForestOfLove.InputHelper::get_IsSecondaryActionButtonHeld()
IL_02d4: brfalse.s IL_032d
IL_02d6: ldarg.0
IL_02d7: ldfld System.Int32 TheForestOfLove.Player::currentUsedSuperStrokes
IL_02dc: ldarg.0
IL_02dd: ldfld System.Int32 TheForestOfLove.Player::maxConsecutiveSuperStrokes
IL_02e2: bge.s IL_032d
IL_02e4: ldarg.0
IL_02e5: ldfld System.Boolean TheForestOfLove.Player::swimmingSuperStroke
IL_02ea: brtrue.s IL_032d
IL_02ec: ldarg.0
IL_02ed: ldfld System.Boolean TheForestOfLove.Player::swimmingSuperStrokeAllowQueuing
IL_02f2: brfalse.s IL_032d
IL_02f4: ldarg.0
IL_02f5: ldfld System.Boolean TheForestOfLove.Player::swimmingSynchronizeFreshInput
IL_02fa: brtrue.s IL_032d
IL_02fc: ldloca.s V_0
IL_02fe: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0303: ldc.r4 0
IL_0308: ble.un.s IL_032d
IL_030a: ldarg.0
IL_030b: ldarg.0
IL_030c: ldfld System.Int32 TheForestOfLove.Player::currentUsedSuperStrokes
IL_0311: ldc.i4.1
IL_0312: add
IL_0313: stfld System.Int32 TheForestOfLove.Player::currentUsedSuperStrokes
IL_0318: ldarg.0
IL_0319: ldc.i4.1
IL_031a: stfld System.Boolean TheForestOfLove.Player::swimmingSuperStroke
IL_031f: ldarg.0
IL_0320: ldarg.0
IL_0321: ldfld System.Single TheForestOfLove.Player::superStrokeCooldownTime
IL_0326: stfld System.Single TheForestOfLove.Player::superStrokeCooldownTimeRemaining
IL_032b: br.s IL_037f
IL_032d: ldarg.0
IL_032e: ldarg.0
IL_032f: ldfld System.Single TheForestOfLove.Player::superStrokeCooldownTimeRemaining
IL_0334: call System.Single UnityEngine.Time::get_deltaTime()
IL_0339: sub
IL_033a: ldc.r4 0
IL_033f: call System.Single UnityEngine.Mathf::Max(System.Single,System.Single)
IL_0344: stfld System.Single TheForestOfLove.Player::superStrokeCooldownTimeRemaining
IL_0349: ldarg.0
IL_034a: ldfld System.Single TheForestOfLove.Player::superStrokeCooldownTimeRemaining
IL_034f: ldc.r4 0
IL_0354: bne.un.s IL_037f
IL_0356: ldarg.0
IL_0357: ldarg.0
IL_0358: ldfld System.Int32 TheForestOfLove.Player::currentUsedSuperStrokes
IL_035d: ldc.i4.1
IL_035e: sub
IL_035f: ldc.i4.0
IL_0360: call System.Int32 UnityEngine.Mathf::Max(System.Int32,System.Int32)
IL_0365: stfld System.Int32 TheForestOfLove.Player::currentUsedSuperStrokes
IL_036a: ldarg.0
IL_036b: ldfld System.Int32 TheForestOfLove.Player::currentUsedSuperStrokes
IL_0370: ldc.i4.0
IL_0371: ble.s IL_037f
IL_0373: ldarg.0
IL_0374: ldarg.0
IL_0375: ldfld System.Single TheForestOfLove.Player::superStrokeCooldownTime
IL_037a: stfld System.Single TheForestOfLove.Player::superStrokeCooldownTimeRemaining
IL_037f: ldarg.0
IL_0380: ldfld System.Boolean TheForestOfLove.Player::swimmingSuperStroke
IL_0385: brfalse.s IL_03b3
IL_0387: ldarg.0
IL_0388: ldfld UnityEngine.Transform TheForestOfLove.Player::swimmingMotionTransform
IL_038d: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_0392: stloc.1
IL_0393: ldloca.s V_1
IL_0395: call System.Single UnityEngine.Vector3::get_magnitude()
IL_039a: ldarg.0
IL_039b: ldfld System.Single TheForestOfLove.Player::swimmingSuperStrokeCommitThreshold
IL_03a0: ble.un.s IL_03b3
IL_03a2: ldarg.0
IL_03a3: ldarg.0
IL_03a4: ldfld UnityEngine.Vector3 TheForestOfLove.Player::swimmingSuperStrokeSpeed
IL_03a9: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_03ae: stfld UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_03b3: ldarg.0
IL_03b4: ldfld UnityEngine.Transform TheForestOfLove.Player::swimmingMotionTransform
IL_03b9: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_03be: stloc.1
IL_03bf: ldloca.s V_1
IL_03c1: call System.Single UnityEngine.Vector3::get_magnitude()
IL_03c6: conv.r8
IL_03c7: ldc.r8 0.5
IL_03d0: ble.un.s IL_0415
IL_03d2: ldarg.0
IL_03d3: ldflda UnityEngine.Vector3 TheForestOfLove.Player::swimmingInput
IL_03d8: call System.Single UnityEngine.Vector3::get_magnitude()
IL_03dd: ldc.r4 0
IL_03e2: ble.un.s IL_0415
IL_03e4: ldarg.0
IL_03e5: ldfld System.Boolean TheForestOfLove.Player::swimmingSynchronizeFreshInput
IL_03ea: brtrue.s IL_0415
IL_03ec: ldarg.0
IL_03ed: ldfld System.Boolean TheForestOfLove.Player::swimmingReadyForNewStrokeSound
IL_03f2: brfalse.s IL_0401
IL_03f4: ldarg.0
IL_03f5: ldc.i4.0
IL_03f6: stfld System.Boolean TheForestOfLove.Player::swimmingReadyForNewStrokeSound
IL_03fb: ldc.i4.4
IL_03fc: call System.Void TheForestOfLove.Audio.SoundManager::PlayFootstepSound(TheForestOfLove.TerrainType)
IL_0401: ldarg.0
IL_0402: ldarg.0
IL_0403: ldfld UnityEngine.Vector3 TheForestOfLove.Player::swimmingInput
IL_0408: call System.Void TheForestOfLove.Player::Swim(UnityEngine.Vector3)
IL_040d: ldarg.0
IL_040e: ldc.i4.1
IL_040f: stfld System.Boolean TheForestOfLove.Player::swimmingEnding
IL_0414: ret
IL_0415: ldloca.s V_0
IL_0417: call System.Single UnityEngine.Vector3::get_magnitude()
IL_041c: ldc.r4 0
IL_0421: bne.un IL_0593
IL_0426: ldarg.0
IL_0427: ldflda UnityEngine.Vector3 TheForestOfLove.Player::swimmingInput
IL_042c: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0431: ldc.r4 0
IL_0436: bne.un IL_0593
IL_043b: ldarg.0
IL_043c: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0441: callvirt TheForestOfLove.Direction TheForestOfLove.Gameplay.DirectionController::get_direction()
IL_0446: call UnityEngine.Vector3 TheForestOfLove.GeneralExtensions::ToUnitVector(TheForestOfLove.Direction)
IL_044b: stloc.2
IL_044c: ldarg.0
IL_044d: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0452: ldstr "x"
IL_0457: ldloc.2
IL_0458: ldfld System.Single UnityEngine.Vector3::x
IL_045d: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0462: ldarg.0
IL_0463: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0468: ldstr "y"
IL_046d: ldloc.2
IL_046e: ldfld System.Single UnityEngine.Vector3::y
IL_0473: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0478: ldarg.0
IL_0479: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_047e: ldstr "x"
IL_0483: ldloc.2
IL_0484: ldfld System.Single UnityEngine.Vector3::x
IL_0489: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_048e: ldarg.0
IL_048f: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0494: ldstr "y"
IL_0499: ldloc.2
IL_049a: ldfld System.Single UnityEngine.Vector3::y
IL_049f: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_04a4: ldarg.0
IL_04a5: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_04aa: ldnull
IL_04ab: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_04b0: brfalse.s IL_04de
IL_04b2: ldarg.0
IL_04b3: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_04b8: ldstr "x"
IL_04bd: ldloc.2
IL_04be: ldfld System.Single UnityEngine.Vector3::x
IL_04c3: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_04c8: ldarg.0
IL_04c9: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_04ce: ldstr "y"
IL_04d3: ldloc.2
IL_04d4: ldfld System.Single UnityEngine.Vector3::y
IL_04d9: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_04de: ldarg.0
IL_04df: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_04e4: ldnull
IL_04e5: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_04ea: brfalse.s IL_0518
IL_04ec: ldarg.0
IL_04ed: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_04f2: ldstr "x"
IL_04f7: ldloc.2
IL_04f8: ldfld System.Single UnityEngine.Vector3::x
IL_04fd: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0502: ldarg.0
IL_0503: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0508: ldstr "y"
IL_050d: ldloc.2
IL_050e: ldfld System.Single UnityEngine.Vector3::y
IL_0513: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0518: ldarg.0
IL_0519: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_051e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0523: stloc.3
IL_0524: br.s IL_054e
IL_0526: ldloca.s V_3
IL_0528: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_052d: dup
IL_052e: ldstr "x"
IL_0533: ldloc.2
IL_0534: ldfld System.Single UnityEngine.Vector3::x
IL_0539: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_053e: ldstr "y"
IL_0543: ldloc.2
IL_0544: ldfld System.Single UnityEngine.Vector3::y
IL_0549: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_054e: ldloca.s V_3
IL_0550: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_0555: brtrue.s IL_0526
IL_0557: leave.s IL_0567
IL_0559: ldloca.s V_3
IL_055b: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_0561: callvirt System.Void System.IDisposable::Dispose()
IL_0566: endfinally
IL_0567: ldarg.0
IL_0568: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_056d: ldstr "x"
IL_0572: ldloc.2
IL_0573: ldfld System.Single UnityEngine.Vector3::x
IL_0578: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_057d: ldarg.0
IL_057e: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_0583: ldstr "y"
IL_0588: ldloc.2
IL_0589: ldfld System.Single UnityEngine.Vector3::y
IL_058e: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0593: ldarg.0
IL_0594: ldloc.0
IL_0595: call System.Void TheForestOfLove.Player::UpdateLastFullAxis(UnityEngine.Vector3)
IL_059a: ldarg.0
IL_059b: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_05a0: ldc.i4.7
IL_05a1: beq IL_0652
IL_05a6: ldarg.0
IL_05a7: call System.Boolean TheForestOfLove.Player::get_isSlashUnlocked()
IL_05ac: brfalse IL_0652
IL_05b1: ldarg.0
IL_05b2: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_05b7: brtrue IL_0652
IL_05bc: ldc.i4 306
IL_05c1: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_05c6: brtrue.s IL_05d4
IL_05c8: ldc.i4 305
IL_05cd: call System.Boolean UnityEngine.Input::GetKey(UnityEngine.KeyCode)
IL_05d2: brfalse.s IL_05e1
IL_05d4: ldarg.0
IL_05d5: ldfld System.Single TheForestOfLove.Player::slashCooldownTimeRemaining
IL_05da: ldc.r4 0
IL_05df: beq.s IL_05e9
IL_05e1: ldarg.0
IL_05e2: ldfld System.Boolean TheForestOfLove.Player::multiSlashIsQueued
IL_05e7: brfalse.s IL_0652
IL_05e9: ldarg.0
IL_05ea: ldfld System.Int32 TheForestOfLove.Player::currentUsedSlashes
IL_05ef: ldarg.0
IL_05f0: ldfld System.Int32 TheForestOfLove.Player::maxConsecutiveSlashes
IL_05f5: bge.s IL_0652
IL_05f7: ldarg.0
IL_05f8: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_05fd: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_0602: brtrue.s IL_0652
IL_0604: call System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_minigameActive()
IL_0609: brtrue.s IL_0652
IL_060b: ldarg.0
IL_060c: ldarg.0
IL_060d: ldfld System.Int32 TheForestOfLove.Player::currentUsedSlashes
IL_0612: ldc.i4.1
IL_0613: add
IL_0614: stfld System.Int32 TheForestOfLove.Player::currentUsedSlashes
IL_0619: ldarg.0
IL_061a: ldc.i4.0
IL_061b: stfld System.Boolean TheForestOfLove.Player::multiSlashIsQueued
IL_0620: ldarg.0
IL_0621: ldc.i4.0
IL_0622: stfld System.Boolean TheForestOfLove.Player::multiSlashCurrentlyWithinTimingThreshold
IL_0627: ldarg.0
IL_0628: ldarg.0
IL_0629: ldfld System.Single TheForestOfLove.Player::slashCooldownTime
IL_062e: stfld System.Single TheForestOfLove.Player::slashCooldownTimeRemaining
IL_0633: ldarg.0
IL_0634: ldc.i4.0
IL_0635: stfld System.Boolean TheForestOfLove.Player::isEligibleForMultiSlash
IL_063a: ldarg.0
IL_063b: ldloca.s V_0
IL_063d: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_0642: call System.Void TheForestOfLove.Player::Slash(UnityEngine.Vector3)
IL_0647: ldc.i4 1000
IL_064c: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0651: ret
IL_0652: ldloca.s V_0
IL_0654: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0659: ldc.r4 0
IL_065e: bgt.s IL_0677
IL_0660: ldarg.0
IL_0661: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0666: ldc.i4.4
IL_0667: bne.un IL_07d7
IL_066c: ldarg.0
IL_066d: ldfld System.Boolean TheForestOfLove.Player::swimFinishStroke
IL_0672: brfalse IL_07d7
IL_0677: ldarg.0
IL_0678: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_067d: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_0682: brtrue.s IL_068a
IL_0684: ldarg.0
IL_0685: call System.Void TheForestOfLove.Player::EnableWindPhysics()
IL_068a: ldarg.0
IL_068b: ldfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0690: brfalse.s IL_06b2
IL_0692: call System.Boolean TheForestOfLove.InputHelper::get_AnyKey()
IL_0697: brfalse.s IL_06a8
IL_0699: ldloca.s V_0
IL_069b: call System.Single UnityEngine.Vector3::get_magnitude()
IL_06a0: ldarg.0
IL_06a1: ldfld System.Single TheForestOfLove.Player::singleStepThreshold
IL_06a6: bgt.s IL_06b2
IL_06a8: call System.Boolean TheForestOfLove.InputHelper::get_AnyKey()
IL_06ad: brtrue IL_07c0
IL_06b2: ldarg.0
IL_06b3: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_06b8: ldc.i4.4
IL_06b9: bne.un.s IL_070f
IL_06bb: ldarg.0
IL_06bc: ldloca.s V_0
IL_06be: call System.Single UnityEngine.Vector3::get_magnitude()
IL_06c3: ldc.r4 0
IL_06c8: bgt.s IL_06d2
IL_06ca: ldarg.0
IL_06cb: ldfld UnityEngine.Vector3 TheForestOfLove.Player::swimmingInput
IL_06d0: br.s IL_06d3
IL_06d2: ldloc.0
IL_06d3: stfld UnityEngine.Vector3 TheForestOfLove.Player::swimmingInput
IL_06d8: ldarg.0
IL_06d9: ldarg.0
IL_06da: ldflda UnityEngine.Vector3 TheForestOfLove.Player::swimmingInput
IL_06df: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_06e4: call System.Void TheForestOfLove.Player::Swim(UnityEngine.Vector3)
IL_06e9: ldloca.s V_0
IL_06eb: call System.Single UnityEngine.Vector3::get_magnitude()
IL_06f0: ldc.r4 0
IL_06f5: ble.un.s IL_06fe
IL_06f7: ldarg.0
IL_06f8: ldc.i4.1
IL_06f9: stfld System.Boolean TheForestOfLove.Player::swimFinishStroke
IL_06fe: ldarg.0
IL_06ff: ldarg.0
IL_0700: ldfld System.Single TheForestOfLove.Player::swimmingNoInputCooldownTime
IL_0705: stfld System.Single TheForestOfLove.Player::swimmingNoInputCooldownTimeRemaining
IL_070a: br IL_07c0
IL_070f: ldarg.0
IL_0710: call System.Boolean TheForestOfLove.Player::get_isDashrollUnlocked()
IL_0715: brfalse IL_07ab
IL_071a: ldarg.0
IL_071b: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0720: brtrue IL_07ab
IL_0725: call System.Boolean TheForestOfLove.InputHelper::get_IsSecondaryActionButtonHeld()
IL_072a: brfalse.s IL_0739
IL_072c: ldarg.0
IL_072d: ldfld System.Single TheForestOfLove.Player::dashCooldownTimeRemaining
IL_0732: ldc.r4 0
IL_0737: beq.s IL_0741
IL_0739: ldarg.0
IL_073a: ldfld System.Boolean TheForestOfLove.Player::multiDashIsQueued
IL_073f: brfalse.s IL_07ab
IL_0741: ldarg.0
IL_0742: ldfld System.Int32 TheForestOfLove.Player::currentUsedDashes
IL_0747: ldarg.0
IL_0748: ldfld System.Int32 TheForestOfLove.Player::maxConsecutiveDashes
IL_074d: bge.s IL_07ab
IL_074f: ldarg.0
IL_0750: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0755: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_075a: brtrue.s IL_07ab
IL_075c: call System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_minigameActive()
IL_0761: brtrue.s IL_07ab
IL_0763: ldarg.0
IL_0764: ldarg.0
IL_0765: ldfld System.Int32 TheForestOfLove.Player::currentUsedDashes
IL_076a: ldc.i4.1
IL_076b: add
IL_076c: stfld System.Int32 TheForestOfLove.Player::currentUsedDashes
IL_0771: ldarg.0
IL_0772: ldc.i4.0
IL_0773: stfld System.Boolean TheForestOfLove.Player::multiDashIsQueued
IL_0778: ldarg.0
IL_0779: ldc.i4.0
IL_077a: stfld System.Boolean TheForestOfLove.Player::multiDashCurrentlyWithinTimingThreshold
IL_077f: ldarg.0
IL_0780: ldarg.0
IL_0781: ldfld System.Single TheForestOfLove.Player::dashCooldownTime
IL_0786: stfld System.Single TheForestOfLove.Player::dashCooldownTimeRemaining
IL_078b: ldarg.0
IL_078c: ldc.i4.0
IL_078d: stfld System.Boolean TheForestOfLove.Player::isEligibleForMultiDash
IL_0792: ldarg.0
IL_0793: ldloca.s V_0
IL_0795: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_079a: call System.Void TheForestOfLove.Player::Dash(UnityEngine.Vector3)
IL_079f: ldc.i4 1000
IL_07a4: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_07a9: br.s IL_07c0
IL_07ab: ldarg.0
IL_07ac: call System.Boolean TheForestOfLove.Player::get_lanternTransitioning()
IL_07b1: brtrue.s IL_07c0
IL_07b3: ldarg.0
IL_07b4: ldloca.s V_0
IL_07b6: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_07bb: call System.Void TheForestOfLove.Player::Walk(UnityEngine.Vector3)
IL_07c0: ldarg.0
IL_07c1: ldc.r4 0
IL_07c6: stfld System.Single TheForestOfLove.Player::idleTime
IL_07cb: ldarg.0
IL_07cc: ldc.r4 0
IL_07d1: stfld System.Single TheForestOfLove.Player::swimIdleTime
IL_07d6: ret
IL_07d7: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_07dc: brfalse.s IL_07e6
IL_07de: ldarg.0
IL_07df: call System.Void TheForestOfLove.Player::DisableWindPhysics()
IL_07e4: br.s IL_07ec
IL_07e6: ldarg.0
IL_07e7: call System.Void TheForestOfLove.Player::EnableWindPhysics()
IL_07ec: ldarg.0
IL_07ed: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_07f2: ldc.i4.4
IL_07f3: bne.un IL_08f0
IL_07f8: ldarg.0
IL_07f9: ldc.i4.0
IL_07fa: stfld System.Boolean TheForestOfLove.Player::swimFinishStroke
IL_07ff: ldarg.0
IL_0800: ldc.i4.1
IL_0801: stfld System.Boolean TheForestOfLove.Player::swimmingSynchronizeFreshInput
IL_0806: ldarg.0
IL_0807: ldarg.0
IL_0808: ldfld System.Single TheForestOfLove.Player::swimmingNoInputCooldownTimeRemaining
IL_080d: call System.Single UnityEngine.Time::get_deltaTime()
IL_0812: sub
IL_0813: stfld System.Single TheForestOfLove.Player::swimmingNoInputCooldownTimeRemaining
IL_0818: ldarg.0
IL_0819: ldfld System.Single TheForestOfLove.Player::swimmingNoInputCooldownTimeRemaining
IL_081e: ldarg.0
IL_081f: ldfld System.Single TheForestOfLove.Player::swimmingNoInputCooldownTime
IL_0824: div
IL_0825: ldc.r4 0
IL_082a: ldc.r4 1
IL_082f: call System.Single UnityEngine.Mathf::Clamp(System.Single,System.Single,System.Single)
IL_0834: stloc.s V_4
IL_0836: ldarg.0
IL_0837: ldfld UnityEngine.Transform TheForestOfLove.Player::swimmingMotionTransform
IL_083c: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_0841: stloc.s V_5
IL_0843: ldloca.s V_6
IL_0845: ldarg.0
IL_0846: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_084b: ldfld System.Single UnityEngine.Vector2::x
IL_0850: ldarg.0
IL_0851: ldflda UnityEngine.Vector3 TheForestOfLove.Player::swimmingInput
IL_0856: ldfld System.Single UnityEngine.Vector3::x
IL_085b: mul
IL_085c: ldloca.s V_5
IL_085e: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0863: mul
IL_0864: ldloc.s V_4
IL_0866: mul
IL_0867: ldarg.0
IL_0868: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_086d: ldfld System.Single UnityEngine.Vector2::y
IL_0872: ldarg.0
IL_0873: ldflda UnityEngine.Vector3 TheForestOfLove.Player::swimmingInput
IL_0878: ldfld System.Single UnityEngine.Vector3::y
IL_087d: mul
IL_087e: ldloca.s V_5
IL_0880: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0885: mul
IL_0886: ldloc.s V_4
IL_0888: mul
IL_0889: ldc.r4 0
IL_088e: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0893: ldarg.0
IL_0894: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_0899: ldloc.s V_6
IL_089b: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_08a0: callvirt System.Void UnityEngine.Rigidbody2D::set_velocity(UnityEngine.Vector2)
IL_08a5: ldarg.0
IL_08a6: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_08ab: ldc.r4 0
IL_08b0: callvirt System.Void UnityEngine.Rigidbody2D::set_angularVelocity(System.Single)
IL_08b5: ldarg.0
IL_08b6: ldarg.0
IL_08b7: ldfld System.Single TheForestOfLove.Player::swimIdleTime
IL_08bc: call System.Single UnityEngine.Time::get_deltaTime()
IL_08c1: add
IL_08c2: stfld System.Single TheForestOfLove.Player::swimIdleTime
IL_08c7: ldarg.0
IL_08c8: ldfld System.Single TheForestOfLove.Player::swimIdleTime
IL_08cd: ldarg.0
IL_08ce: ldfld System.Single TheForestOfLove.Player::swimIdleThresholdMs
IL_08d3: blt.un IL_09d1
IL_08d8: ldloca.s V_0
IL_08da: call System.Single UnityEngine.Vector3::get_magnitude()
IL_08df: ldc.r4 1E-05
IL_08e4: bge.un IL_09d1
IL_08e9: ldarg.0
IL_08ea: call System.Void TheForestOfLove.Player::SwimIdle()
IL_08ef: ret
IL_08f0: ldarg.0
IL_08f1: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_08f6: brfalse IL_09a9
IL_08fb: ldarg.0
IL_08fc: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_0901: call UnityEngine.Vector2 UnityEngine.Vector2::get_zero()
IL_0906: callvirt System.Void UnityEngine.Rigidbody2D::set_velocity(UnityEngine.Vector2)
IL_090b: ldarg.0
IL_090c: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_0911: ldc.r4 0
IL_0916: callvirt System.Void UnityEngine.Rigidbody2D::set_angularVelocity(System.Single)
IL_091b: ldarg.0
IL_091c: ldarg.0
IL_091d: ldfld System.Single TheForestOfLove.Player::idleTime
IL_0922: call System.Single UnityEngine.Time::get_deltaTime()
IL_0927: add
IL_0928: stfld System.Single TheForestOfLove.Player::idleTime
IL_092d: ldarg.0
IL_092e: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0933: ldc.i4.4
IL_0934: beq IL_09d1
IL_0939: ldarg.0
IL_093a: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_093f: ldc.i4.5
IL_0940: beq IL_09d1
IL_0945: ldarg.0
IL_0946: ldfld UnityEngine.Transform TheForestOfLove.Player::windSensor
IL_094b: ldnull
IL_094c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0951: brfalse.s IL_0985
IL_0953: call System.Boolean TheForestOfLove.StormQuestWindSystemController::get_IsGusting()
IL_0958: brtrue.s IL_0962
IL_095a: ldarg.0
IL_095b: ldfld System.Boolean TheForestOfLove.Player::manualToggleIdleBrace
IL_0960: brfalse.s IL_0985
IL_0962: ldarg.0
IL_0963: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0968: ldc.i4.6
IL_0969: beq.s IL_09d1
IL_096b: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0970: brtrue.s IL_09d1
IL_0972: ldarg.0
IL_0973: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0978: ldc.i4.3
IL_0979: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_097e: ldarg.0
IL_097f: call System.Void TheForestOfLove.Player::IdleBrace()
IL_0984: ret
IL_0985: ldarg.0
IL_0986: call System.Boolean TheForestOfLove.Player::get_lanternTransitioning()
IL_098b: brtrue.s IL_09d1
IL_098d: ldarg.0
IL_098e: ldfld System.Single TheForestOfLove.Player::idleTime
IL_0993: ldarg.0
IL_0994: ldfld System.Single TheForestOfLove.Player::idleThresholdMs
IL_0999: bge.un.s IL_09a2
IL_099b: ldarg.0
IL_099c: call System.Void TheForestOfLove.Player::Rest()
IL_09a1: ret
IL_09a2: ldarg.0
IL_09a3: call System.Void TheForestOfLove.Player::Idle()
IL_09a8: ret
IL_09a9: ldarg.0
IL_09aa: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_09af: brtrue.s IL_09d1
IL_09b1: ldarg.0
IL_09b2: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_09b7: call UnityEngine.Vector2 UnityEngine.Vector2::get_zero()
IL_09bc: callvirt System.Void UnityEngine.Rigidbody2D::set_velocity(UnityEngine.Vector2)
IL_09c1: ldarg.0
IL_09c2: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_09c7: ldc.r4 0
IL_09cc: callvirt System.Void UnityEngine.Rigidbody2D::set_angularVelocity(System.Single)
IL_09d1: ret
METHOD System.Void TheForestOfLove.Player::Walk(UnityEngine.Vector3)
IL_0000: ldarga.s input
IL_0002: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0007: ldc.r4 0
IL_000c: bne.un.s IL_000f
IL_000e: ret
IL_000f: ldarg.0
IL_0010: ldc.i4.1
IL_0011: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0016: ldarg.0
IL_0017: ldc.i4.2
IL_0018: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_001d: ldarga.s input
IL_001f: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_0024: stloc.0
IL_0025: ldloc.0
IL_0026: ldfld System.Single UnityEngine.Vector3::x
IL_002b: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0030: ldc.r4 0
IL_0035: ble.un.s IL_004b
IL_0037: ldloc.0
IL_0038: ldfld System.Single UnityEngine.Vector3::y
IL_003d: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0042: ldc.r4 0
IL_0047: cgt
IL_0049: br.s IL_004c
IL_004b: ldc.i4.0
IL_004c: brfalse IL_00ef
IL_0051: ldarg.0
IL_0052: ldflda UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
IL_0057: ldfld System.Single UnityEngine.Vector2::x
IL_005c: ldc.r4 1
IL_0061: bne.un.s IL_00aa
IL_0063: ldloca.s V_0
IL_0065: ldc.r4 0
IL_006a: stfld System.Single UnityEngine.Vector3::y
IL_006f: ldarg.1
IL_0070: ldfld System.Single UnityEngine.Vector3::x
IL_0075: ldarg.1
IL_0076: ldfld System.Single UnityEngine.Vector3::x
IL_007b: call System.Single UnityEngine.Mathf::Sign(System.Single)
IL_0080: ldarg.1
IL_0081: ldfld System.Single UnityEngine.Vector3::y
IL_0086: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_008b: mul
IL_008c: ldarg.0
IL_008d: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_0092: mul
IL_0093: add
IL_0094: ldarg.1
IL_0095: ldfld System.Single UnityEngine.Vector3::y
IL_009a: ldarg.0
IL_009b: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_00a0: mul
IL_00a1: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_00a6: starg.s input
IL_00a8: br.s IL_00ef
IL_00aa: ldloca.s V_0
IL_00ac: ldc.r4 0
IL_00b1: stfld System.Single UnityEngine.Vector3::x
IL_00b6: ldarg.1
IL_00b7: ldfld System.Single UnityEngine.Vector3::x
IL_00bc: ldarg.0
IL_00bd: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_00c2: mul
IL_00c3: ldarg.1
IL_00c4: ldfld System.Single UnityEngine.Vector3::y
IL_00c9: ldarg.1
IL_00ca: ldfld System.Single UnityEngine.Vector3::y
IL_00cf: call System.Single UnityEngine.Mathf::Sign(System.Single)
IL_00d4: ldarg.1
IL_00d5: ldfld System.Single UnityEngine.Vector3::x
IL_00da: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_00df: mul
IL_00e0: ldarg.0
IL_00e1: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_00e6: mul
IL_00e7: add
IL_00e8: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_00ed: starg.s input
IL_00ef: ldarga.s input
IL_00f1: call System.Void UnityEngine.Vector3::Normalize()
IL_00f6: ldarg.0
IL_00f7: ldfld System.Boolean TheForestOfLove.Player::flipAnimatorVectorY
IL_00fc: brfalse.s IL_010c
IL_00fe: ldloca.s V_0
IL_0100: ldloc.0
IL_0101: ldfld System.Single UnityEngine.Vector3::y
IL_0106: neg
IL_0107: stfld System.Single UnityEngine.Vector3::y
IL_010c: ldarg.0
IL_010d: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_0112: ldstr "trigger_walk"
IL_0117: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_011c: brfalse IL_01d0
IL_0121: ldarg.0
IL_0122: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0127: ldstr "trigger_walk"
IL_012c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0131: ldarg.0
IL_0132: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0137: ldstr "trigger_walk"
IL_013c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0141: ldarg.0
IL_0142: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0147: ldnull
IL_0148: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_014d: brfalse.s IL_015f
IL_014f: ldarg.0
IL_0150: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0155: ldstr "trigger_walk"
IL_015a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_015f: ldarg.0
IL_0160: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0165: ldnull
IL_0166: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_016b: brfalse.s IL_017d
IL_016d: ldarg.0
IL_016e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0173: ldstr "trigger_walk"
IL_0178: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_017d: ldarg.0
IL_017e: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_0183: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0188: stloc.3
IL_0189: br.s IL_019c
IL_018b: ldloca.s V_3
IL_018d: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_0192: ldstr "trigger_walk"
IL_0197: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_019c: ldloca.s V_3
IL_019e: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_01a3: brtrue.s IL_018b
IL_01a5: leave.s IL_01b5
IL_01a7: ldloca.s V_3
IL_01a9: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_01af: callvirt System.Void System.IDisposable::Dispose()
IL_01b4: endfinally
IL_01b5: ldarg.0
IL_01b6: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_01bb: ldstr "trigger_walk"
IL_01c0: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_01c5: ldarg.0
IL_01c6: ldstr "trigger_walk"
IL_01cb: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_01d0: ldarg.0
IL_01d1: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01d6: ldstr "x"
IL_01db: ldloc.0
IL_01dc: ldfld System.Single UnityEngine.Vector3::x
IL_01e1: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01e6: ldarg.0
IL_01e7: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01ec: ldstr "y"
IL_01f1: ldloc.0
IL_01f2: ldfld System.Single UnityEngine.Vector3::y
IL_01f7: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01fc: ldarg.0
IL_01fd: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0202: ldstr "x"
IL_0207: ldloc.0
IL_0208: ldfld System.Single UnityEngine.Vector3::x
IL_020d: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0212: ldarg.0
IL_0213: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0218: ldstr "y"
IL_021d: ldloc.0
IL_021e: ldfld System.Single UnityEngine.Vector3::y
IL_0223: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0228: ldarg.0
IL_0229: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_022e: ldnull
IL_022f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0234: brfalse.s IL_0262
IL_0236: ldarg.0
IL_0237: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_023c: ldstr "x"
IL_0241: ldloc.0
IL_0242: ldfld System.Single UnityEngine.Vector3::x
IL_0247: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_024c: ldarg.0
IL_024d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0252: ldstr "y"
IL_0257: ldloc.0
IL_0258: ldfld System.Single UnityEngine.Vector3::y
IL_025d: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0262: ldarg.0
IL_0263: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0268: ldnull
IL_0269: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_026e: brfalse.s IL_029c
IL_0270: ldarg.0
IL_0271: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0276: ldstr "x"
IL_027b: ldloc.0
IL_027c: ldfld System.Single UnityEngine.Vector3::x
IL_0281: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0286: ldarg.0
IL_0287: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_028c: ldstr "y"
IL_0291: ldloc.0
IL_0292: ldfld System.Single UnityEngine.Vector3::y
IL_0297: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_029c: ldarg.0
IL_029d: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_02a2: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_02a7: stloc.3
IL_02a8: br.s IL_02d2
IL_02aa: ldloca.s V_3
IL_02ac: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_02b1: dup
IL_02b2: ldstr "x"
IL_02b7: ldloc.0
IL_02b8: ldfld System.Single UnityEngine.Vector3::x
IL_02bd: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02c2: ldstr "y"
IL_02c7: ldloc.0
IL_02c8: ldfld System.Single UnityEngine.Vector3::y
IL_02cd: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02d2: ldloca.s V_3
IL_02d4: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_02d9: brtrue.s IL_02aa
IL_02db: leave.s IL_02eb
IL_02dd: ldloca.s V_3
IL_02df: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_02e5: callvirt System.Void System.IDisposable::Dispose()
IL_02ea: endfinally
IL_02eb: ldarg.0
IL_02ec: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_02f1: ldstr "x"
IL_02f6: ldloc.0
IL_02f7: ldfld System.Single UnityEngine.Vector3::x
IL_02fc: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0301: ldarg.0
IL_0302: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_0307: ldstr "y"
IL_030c: ldloc.0
IL_030d: ldfld System.Single UnityEngine.Vector3::y
IL_0312: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0317: ldloc.0
IL_0318: ldfld System.Single UnityEngine.Vector3::x
IL_031d: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0322: ldloc.0
IL_0323: ldfld System.Single UnityEngine.Vector3::y
IL_0328: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_032d: ble.un.s IL_0348
IL_032f: ldarg.0
IL_0330: ldloc.0
IL_0331: ldfld System.Single UnityEngine.Vector3::x
IL_0336: ldc.r4 0
IL_033b: bge.s IL_0340
IL_033d: ldc.i4.3
IL_033e: br.s IL_0341
IL_0340: ldc.i4.1
IL_0341: stfld TheForestOfLove.Direction TheForestOfLove.Player::animatorDirection
IL_0346: br.s IL_035f
IL_0348: ldarg.0
IL_0349: ldloc.0
IL_034a: ldfld System.Single UnityEngine.Vector3::y
IL_034f: ldc.r4 0
IL_0354: bge.s IL_0359
IL_0356: ldc.i4.0
IL_0357: br.s IL_035a
IL_0359: ldc.i4.2
IL_035a: stfld TheForestOfLove.Direction TheForestOfLove.Player::animatorDirection
IL_035f: ldloca.s V_1
IL_0361: ldarg.0
IL_0362: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0367: ldfld System.Single UnityEngine.Vector2::x
IL_036c: ldarg.1
IL_036d: ldfld System.Single UnityEngine.Vector3::x
IL_0372: mul
IL_0373: ldarg.0
IL_0374: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0379: ldfld System.Single UnityEngine.Vector2::y
IL_037e: ldarg.1
IL_037f: ldfld System.Single UnityEngine.Vector3::y
IL_0384: mul
IL_0385: ldc.r4 0
IL_038a: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_038f: ldc.i4.0
IL_0390: stloc.2
IL_0391: ldarg.0
IL_0392: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0397: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_039c: brfalse IL_051f
IL_03a1: ldarg.0
IL_03a2: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_03a7: callvirt UnityEngine.Vector3 TheForestOfLove.WaypointController::get_currentWaypointPosition()
IL_03ac: ldarg.0
IL_03ad: call UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_03b2: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_03b7: stloc.s V_4
IL_03b9: ldloc.s V_4
IL_03bb: ldfld System.Single UnityEngine.Vector3::x
IL_03c0: ldc.r4 1E-45
IL_03c5: ble.un IL_0467
IL_03ca: ldloc.s V_4
IL_03cc: ldfld System.Single UnityEngine.Vector3::x
IL_03d1: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_03d6: ldarg.0
IL_03d7: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_03dc: ldfld System.Single UnityEngine.Vector2::x
IL_03e1: call System.Single UnityEngine.Time::get_deltaTime()
IL_03e6: mul
IL_03e7: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_03ec: bge.un.s IL_0467
IL_03ee: ldloca.s V_1
IL_03f0: ldc.r4 0
IL_03f5: stfld System.Single UnityEngine.Vector3::x
IL_03fa: ldarg.0
IL_03fb: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0400: ldarg.0
IL_0401: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0406: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_040b: ldfld System.Single UnityEngine.Vector3::x
IL_0410: ldloc.s V_4
IL_0412: ldfld System.Single UnityEngine.Vector3::x
IL_0417: add
IL_0418: ldarg.0
IL_0419: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_041e: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0423: ldfld System.Single UnityEngine.Vector3::y
IL_0428: ldarg.0
IL_0429: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_042e: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0433: ldfld System.Single UnityEngine.Vector3::z
IL_0438: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_043d: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0442: ldc.i4.1
IL_0443: brfalse.s IL_0467
IL_0445: ldarg.1
IL_0446: ldfld System.Single UnityEngine.Vector3::x
IL_044b: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0450: ldc.r4 0
IL_0455: ble.un.s IL_0467
IL_0457: ldarga.s input
IL_0459: ldloc.s V_4
IL_045b: ldfld System.Single UnityEngine.Vector3::x
IL_0460: stfld System.Single UnityEngine.Vector3::x
IL_0465: ldc.i4.1
IL_0466: stloc.2
IL_0467: ldloc.s V_4
IL_0469: ldfld System.Single UnityEngine.Vector3::y
IL_046e: ldc.r4 1E-45
IL_0473: ble.un IL_0515
IL_0478: ldloc.s V_4
IL_047a: ldfld System.Single UnityEngine.Vector3::y
IL_047f: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0484: ldarg.0
IL_0485: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_048a: ldfld System.Single UnityEngine.Vector2::y
IL_048f: call System.Single UnityEngine.Time::get_deltaTime()
IL_0494: mul
IL_0495: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_049a: bge.un.s IL_0515
IL_049c: ldloca.s V_1
IL_049e: ldc.r4 0
IL_04a3: stfld System.Single UnityEngine.Vector3::y
IL_04a8: ldarg.0
IL_04a9: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04ae: ldarg.0
IL_04af: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04b4: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_04b9: ldfld System.Single UnityEngine.Vector3::x
IL_04be: ldarg.0
IL_04bf: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04c4: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_04c9: ldfld System.Single UnityEngine.Vector3::y
IL_04ce: ldloc.s V_4
IL_04d0: ldfld System.Single UnityEngine.Vector3::y
IL_04d5: add
IL_04d6: ldarg.0
IL_04d7: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04dc: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_04e1: ldfld System.Single UnityEngine.Vector3::z
IL_04e6: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_04eb: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_04f0: ldc.i4.1
IL_04f1: brfalse.s IL_0515
IL_04f3: ldarg.1
IL_04f4: ldfld System.Single UnityEngine.Vector3::y
IL_04f9: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_04fe: ldc.r4 0
IL_0503: ble.un.s IL_0515
IL_0505: ldarga.s input
IL_0507: ldloc.s V_4
IL_0509: ldfld System.Single UnityEngine.Vector3::y
IL_050e: stfld System.Single UnityEngine.Vector3::y
IL_0513: ldc.i4.1
IL_0514: stloc.2
IL_0515: ldloc.2
IL_0516: brfalse.s IL_051f
IL_0518: ldarga.s input
IL_051a: call System.Void UnityEngine.Vector3::Normalize()
IL_051f: ldarg.0
IL_0520: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_0525: ldloc.1
IL_0526: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_052b: callvirt System.Void UnityEngine.Rigidbody2D::set_velocity(UnityEngine.Vector2)
IL_0530: ldarg.0
IL_0531: ldflda UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
IL_0536: ldfld System.Single UnityEngine.Vector2::y
IL_053b: ldc.r4 1
IL_0540: beq.s IL_054e
IL_0542: ldarg.0
IL_0543: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0548: ldarg.1
IL_0549: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(UnityEngine.Vector3)
IL_054e: ldarg.1
IL_054f: ldfld System.Single UnityEngine.Vector3::x
IL_0554: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0559: ldc.r4 0
IL_055e: ble.un.s IL_0571
IL_0560: ldarg.0
IL_0561: ldflda UnityEngine.Vector3 TheForestOfLove.Player::lastNonzeroXAxisInput
IL_0566: ldarg.1
IL_0567: ldfld System.Single UnityEngine.Vector3::x
IL_056c: stfld System.Single UnityEngine.Vector3::x
IL_0571: ldloca.s V_1
IL_0573: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0578: ldc.r4 0
IL_057d: ble.un IL_0605
IL_0582: ldarg.0
IL_0583: ldfld System.Single TheForestOfLove.Player::timeSinceLastStepSound
IL_0588: ldarg.0
IL_0589: ldfld System.Single TheForestOfLove.Player::timeBetweenStepSoundsWalking
IL_058e: ldarg.0
IL_058f: ldfld System.Single TheForestOfLove.Player::stepSoundTimerStartPhase
IL_0594: add
IL_0595: ble.un.s IL_05b0
IL_0597: ldarg.0
IL_0598: ldarg.0
IL_0599: ldfld System.Single TheForestOfLove.Player::stepSoundTimerStartPhase
IL_059e: stfld System.Single TheForestOfLove.Player::timeSinceLastStepSound
IL_05a3: ldarg.0
IL_05a4: call TheForestOfLove.TerrainType TheForestOfLove.Player::get_currentTerrainType()
IL_05a9: call System.Void TheForestOfLove.Audio.SoundManager::PlayFootstepSound(TheForestOfLove.TerrainType)
IL_05ae: br.s IL_05c2
IL_05b0: ldarg.0
IL_05b1: ldarg.0
IL_05b2: ldfld System.Single TheForestOfLove.Player::timeSinceLastStepSound
IL_05b7: call System.Single UnityEngine.Time::get_deltaTime()
IL_05bc: add
IL_05bd: stfld System.Single TheForestOfLove.Player::timeSinceLastStepSound
IL_05c2: ldarg.0
IL_05c3: ldfld System.Single TheForestOfLove.Player::timeSinceLastSnowTrack
IL_05c8: ldarg.0
IL_05c9: ldfld System.Single TheForestOfLove.Player::timeBetweenSnowTracksWalking
IL_05ce: ldarg.0
IL_05cf: ldfld System.Single TheForestOfLove.Player::snowTrackTimerStartPhase
IL_05d4: add
IL_05d5: ble.un.s IL_05f3
IL_05d7: ldarg.0
IL_05d8: ldarg.0
IL_05d9: ldfld System.Single TheForestOfLove.Player::snowTrackTimerStartPhase
IL_05de: stfld System.Single TheForestOfLove.Player::timeSinceLastSnowTrack
IL_05e3: ldarg.0
IL_05e4: call TheForestOfLove.TerrainType TheForestOfLove.Player::get_currentTerrainType()
IL_05e9: ldc.i4.3
IL_05ea: bne.un.s IL_0605
IL_05ec: ldarg.0
IL_05ed: call System.Void TheForestOfLove.Player::TryEmitSnowTrackParticle()
IL_05f2: ret
IL_05f3: ldarg.0
IL_05f4: ldarg.0
IL_05f5: ldfld System.Single TheForestOfLove.Player::timeSinceLastSnowTrack
IL_05fa: call System.Single UnityEngine.Time::get_deltaTime()
IL_05ff: add
IL_0600: stfld System.Single TheForestOfLove.Player::timeSinceLastSnowTrack
IL_0605: ret
