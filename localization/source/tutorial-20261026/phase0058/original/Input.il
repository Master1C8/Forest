TYPE TheForestOfLove.InputHelper
METHOD System.Void TheForestOfLove.InputHelper::CheckInputsRewired() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0006: callvirt System.Boolean Rewired.Player::GetAnyButton()
IL_000b: brtrue.s IL_001a
IL_000d: ldarg.0
IL_000e: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0013: callvirt System.Boolean Rewired.Player::GetAnyNegativeButton()
IL_0018: br.s IL_001b
IL_001a: ldc.i4.1
IL_001b: call System.Void TheForestOfLove.InputHelper::set_AnyKey(System.Boolean)
IL_0020: ldarg.0
IL_0021: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0026: callvirt System.Boolean Rewired.Player::GetAnyButtonDown()
IL_002b: brtrue.s IL_003a
IL_002d: ldarg.0
IL_002e: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0033: callvirt System.Boolean Rewired.Player::GetAnyNegativeButtonDown()
IL_0038: br.s IL_003b
IL_003a: ldc.i4.1
IL_003b: call System.Void TheForestOfLove.InputHelper::set_AnyKeyDown(System.Boolean)
IL_0040: ldc.i4.0
IL_0041: ldarg.0
IL_0042: call System.Boolean TheForestOfLove.InputHelper::UpdateAxisInputFromJoystick()
IL_0047: or
IL_0048: ldarg.0
IL_0049: call System.Boolean TheForestOfLove.InputHelper::UpdateAxisInputFromDpad()
IL_004e: or
IL_004f: ldarg.0
IL_0050: call System.Boolean TheForestOfLove.InputHelper::UpdateAxisInputFromKeyboard()
IL_0055: or
IL_0056: brtrue.s IL_0062
IL_0058: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_005d: call System.Void TheForestOfLove.InputHelper::UpdateAxisInput(UnityEngine.Vector3)
IL_0062: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inNonGameplayScene()
IL_0067: brtrue.s IL_0077
IL_0069: ldarg.0
IL_006a: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_006f: ldc.i4.3
IL_0070: callvirt System.Boolean Rewired.Player::GetButton(System.Int32)
IL_0075: br.s IL_0078
IL_0077: ldc.i4.0
IL_0078: call System.Void TheForestOfLove.InputHelper::set_IsSecondaryActionButtonHeld(System.Boolean)
IL_007d: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inNonGameplayScene()
IL_0082: brtrue.s IL_0092
IL_0084: ldarg.0
IL_0085: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_008a: ldc.i4.2
IL_008b: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_0090: br.s IL_009f
IL_0092: ldarg.0
IL_0093: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0098: ldc.i4.s 18
IL_009a: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_009f: call System.Void TheForestOfLove.InputHelper::set_IsSubmitButtonDown(System.Boolean)
IL_00a4: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inNonGameplayScene()
IL_00a9: brtrue.s IL_00b9
IL_00ab: ldarg.0
IL_00ac: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_00b1: ldc.i4.3
IL_00b2: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_00b7: br.s IL_00ba
IL_00b9: ldc.i4.0
IL_00ba: call System.Void TheForestOfLove.InputHelper::set_IsSecondaryActionButtonDown(System.Boolean)
IL_00bf: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inNonGameplayScene()
IL_00c4: brtrue.s IL_00d4
IL_00c6: ldarg.0
IL_00c7: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_00cc: ldc.i4.4
IL_00cd: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_00d2: br.s IL_00e1
IL_00d4: ldarg.0
IL_00d5: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_00da: ldc.i4.s 19
IL_00dc: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_00e1: call System.Void TheForestOfLove.InputHelper::set_IsBackButtonDown(System.Boolean)
IL_00e6: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inNonGameplayScene()
IL_00eb: brtrue.s IL_00fb
IL_00ed: ldarg.0
IL_00ee: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_00f3: ldc.i4.4
IL_00f4: callvirt System.Boolean Rewired.Player::GetButton(System.Int32)
IL_00f9: br.s IL_0108
IL_00fb: ldarg.0
IL_00fc: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0101: ldc.i4.s 19
IL_0103: callvirt System.Boolean Rewired.Player::GetButton(System.Int32)
IL_0108: call System.Void TheForestOfLove.InputHelper::set_IsBackButtonHeld(System.Boolean)
IL_010d: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inNonGameplayScene()
IL_0112: brtrue.s IL_0122
IL_0114: ldarg.0
IL_0115: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_011a: ldc.i4.5
IL_011b: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_0120: br.s IL_0123
IL_0122: ldc.i4.0
IL_0123: call System.Void TheForestOfLove.InputHelper::set_IsInventoryButtonDown(System.Boolean)
IL_0128: ldarg.0
IL_0129: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_012e: ldc.i4.s 22
IL_0130: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_0135: call System.Void TheForestOfLove.InputHelper::set_IsInventoryFromGamepadButtonDown(System.Boolean)
IL_013a: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inNonGameplayScene()
IL_013f: brtrue.s IL_0150
IL_0141: ldarg.0
IL_0142: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0147: ldc.i4.s 23
IL_0149: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_014e: br.s IL_0151
IL_0150: ldc.i4.0
IL_0151: call System.Void TheForestOfLove.InputHelper::set_IsMapButtonDown(System.Boolean)
IL_0156: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inNonGameplayScene()
IL_015b: brtrue.s IL_016b
IL_015d: ldarg.0
IL_015e: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0163: ldc.i4.6
IL_0164: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_0169: br.s IL_016c
IL_016b: ldc.i4.0
IL_016c: call System.Void TheForestOfLove.InputHelper::set_IsCritterLogButtonDown(System.Boolean)
IL_0171: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inNonGameplayScene()
IL_0176: brtrue.s IL_0186
IL_0178: ldarg.0
IL_0179: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_017e: ldc.i4.7
IL_017f: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_0184: br.s IL_0187
IL_0186: ldc.i4.0
IL_0187: call System.Void TheForestOfLove.InputHelper::set_IsQuestLogButtonDown(System.Boolean)
IL_018c: ldarg.0
IL_018d: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0192: ldc.i4.s 9
IL_0194: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_0199: call System.Void TheForestOfLove.InputHelper::set_IsLeftBumperDown(System.Boolean)
IL_019e: ldarg.0
IL_019f: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_01a4: ldc.i4.s 10
IL_01a6: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_01ab: call System.Void TheForestOfLove.InputHelper::set_IsRightBumperDown(System.Boolean)
IL_01b0: ldarg.0
IL_01b1: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_01b6: ldc.i4.s 24
IL_01b8: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_01bd: call System.Void TheForestOfLove.InputHelper::set_IsLeftTriggerDown(System.Boolean)
IL_01c2: ldarg.0
IL_01c3: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_01c8: ldc.i4.s 24
IL_01ca: callvirt System.Boolean Rewired.Player::GetButton(System.Int32)
IL_01cf: call System.Void TheForestOfLove.InputHelper::set_IsLeftTriggerHeld(System.Boolean)
IL_01d4: ldarg.0
IL_01d5: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_01da: ldc.i4.s 25
IL_01dc: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_01e1: call System.Void TheForestOfLove.InputHelper::set_IsRightTriggerDown(System.Boolean)
IL_01e6: ldarg.0
IL_01e7: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_01ec: ldc.i4.s 25
IL_01ee: callvirt System.Boolean Rewired.Player::GetButton(System.Int32)
IL_01f3: call System.Void TheForestOfLove.InputHelper::set_IsRightTriggerHeld(System.Boolean)
IL_01f8: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inNonGameplayScene()
IL_01fd: brtrue.s IL_020e
IL_01ff: ldarg.0
IL_0200: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0205: ldc.i4.s 20
IL_0207: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_020c: br.s IL_020f
IL_020e: ldc.i4.0
IL_020f: call System.Void TheForestOfLove.InputHelper::set_IsPlantMinigameActionButtonDown(System.Boolean)
IL_0214: ldarg.0
IL_0215: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_021a: ldc.i4.8
IL_021b: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_0220: call System.Void TheForestOfLove.InputHelper::set_IsPauseButtonDown(System.Boolean)
IL_0225: ldarg.0
IL_0226: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_022b: ldc.i4.s 21
IL_022d: callvirt System.Boolean Rewired.Player::GetButtonDown(System.Int32)
IL_0232: call System.Void TheForestOfLove.InputHelper::set_IsJoystickSecondaryConvoAdvanceButtonDown(System.Boolean)
IL_0237: ldarg.0
IL_0238: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_023d: ldc.i4.s 21
IL_023f: callvirt System.Boolean Rewired.Player::GetButton(System.Int32)
IL_0244: call System.Void TheForestOfLove.InputHelper::set_IsJoystickSecondaryConvoAdvanceButtonHeld(System.Boolean)
IL_0249: ldarg.0
IL_024a: call System.Void TheForestOfLove.InputHelper::CheckHorizontalAxisAsButton_Left()
IL_024f: ldarg.0
IL_0250: call System.Void TheForestOfLove.InputHelper::CheckHorizontalAxisAsButton_Right()
IL_0255: ldarg.0
IL_0256: call System.Void TheForestOfLove.InputHelper::CheckVerticalAxisAsButton_Up()
IL_025b: ldarg.0
IL_025c: call System.Void TheForestOfLove.InputHelper::CheckVerticalAxisAsButton_Down()
IL_0261: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0266: brfalse.s IL_028c
IL_0268: ldarg.0
IL_0269: ldfld System.Boolean TheForestOfLove.InputHelper::uiInputsDisabled
IL_026e: brtrue.s IL_028c
IL_0270: call System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_minigameActive()
IL_0275: brfalse.s IL_028c
IL_0277: ldsfld System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::playingMouseConvo
IL_027c: brfalse.s IL_028c
IL_027e: ldarg.0
IL_027f: ldc.i4.1
IL_0280: stfld System.Boolean TheForestOfLove.InputHelper::uiInputsDisabled
IL_0285: ldarg.0
IL_0286: call System.Void TheForestOfLove.InputHelper::UpdateRewiredInputMaps()
IL_028b: ret
IL_028c: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0291: brtrue.s IL_02a8
IL_0293: ldarg.0
IL_0294: ldfld System.Boolean TheForestOfLove.InputHelper::uiInputsDisabled
IL_0299: brfalse.s IL_02a8
IL_029b: ldarg.0
IL_029c: ldc.i4.0
IL_029d: stfld System.Boolean TheForestOfLove.InputHelper::uiInputsDisabled
IL_02a2: ldarg.0
IL_02a3: call System.Void TheForestOfLove.InputHelper::UpdateRewiredInputMaps()
IL_02a8: ret
METHOD System.Boolean TheForestOfLove.InputHelper::UpdateAxisInputFromKeyboard() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0006: ldc.i4.0
IL_0007: ldc.i4.1
IL_0008: callvirt UnityEngine.Vector2 Rewired.Player::GetAxis2D(System.Int32,System.Int32)
IL_000d: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0012: call System.Boolean TheForestOfLove.InputHelper::TryUpdateAxisInput(UnityEngine.Vector3)
IL_0017: ret
