TYPE TheForestOfLove.MasterLog
METHOD System.Void TheForestOfLove.MasterLog::Update()
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.UIPanel TheForestOfLove.MasterLog::masterLogUi
IL_0006: callvirt System.Boolean PixelCrushers.UIPanel::get_isOpen()
IL_000b: brtrue IL_00a9
IL_0010: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0015: brtrue IL_00a9
IL_001a: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_001f: brfalse IL_00a9
IL_0024: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_0029: brtrue.s IL_00a9
IL_002b: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_0030: brtrue.s IL_00a9
IL_0032: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedNotebook()
IL_0037: brfalse.s IL_00a9
IL_0039: call System.Boolean TheForestOfLove.InputHelper::get_IsInventoryFromGamepadButtonDown()
IL_003e: brfalse.s IL_0048
IL_0040: ldarg.0
IL_0041: ldc.i4.0
IL_0042: call System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_0047: ret
IL_0048: call System.Boolean TheForestOfLove.InputHelper::get_IsInventoryButtonDown()
IL_004d: brfalse.s IL_0058
IL_004f: ldarg.0
IL_0050: ldc.i4.3
IL_0051: ldc.i4.0
IL_0052: call System.Void TheForestOfLove.MasterLog::ToggleVisible(TheForestOfLove.MasterLogPage,System.Boolean)
IL_0057: ret
IL_0058: call System.Boolean TheForestOfLove.InputHelper::get_IsCritterLogButtonDown()
IL_005d: brfalse.s IL_0068
IL_005f: ldarg.0
IL_0060: ldc.i4.0
IL_0061: ldc.i4.0
IL_0062: call System.Void TheForestOfLove.MasterLog::ToggleVisible(TheForestOfLove.MasterLogPage,System.Boolean)
IL_0067: ret
IL_0068: call System.Boolean TheForestOfLove.InputHelper::get_IsQuestLogButtonDown()
IL_006d: brfalse.s IL_0078
IL_006f: ldarg.0
IL_0070: ldc.i4.1
IL_0071: ldc.i4.0
IL_0072: call System.Void TheForestOfLove.MasterLog::ToggleVisible(TheForestOfLove.MasterLogPage,System.Boolean)
IL_0077: ret
IL_0078: call System.Boolean TheForestOfLove.InputHelper::get_IsMapButtonDown()
IL_007d: brfalse IL_017b
IL_0082: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedMap()
IL_0087: brfalse IL_017b
IL_008c: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0091: ldstr "DeepWoods_Campfire"
IL_0096: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_009b: brfalse IL_017b
IL_00a0: ldarg.0
IL_00a1: ldc.i4.2
IL_00a2: ldc.i4.0
IL_00a3: call System.Void TheForestOfLove.MasterLog::ToggleVisible(TheForestOfLove.MasterLogPage,System.Boolean)
IL_00a8: ret
IL_00a9: ldarg.0
IL_00aa: ldfld PixelCrushers.UIPanel TheForestOfLove.MasterLog::masterLogUi
IL_00af: callvirt System.Boolean PixelCrushers.UIPanel::get_isOpen()
IL_00b4: brfalse IL_017b
IL_00b9: call System.Boolean TheForestOfLove.InputHelper::get_IsInventoryFromGamepadButtonDown()
IL_00be: brfalse.s IL_00c8
IL_00c0: ldarg.0
IL_00c1: ldc.i4.0
IL_00c2: call System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_00c7: ret
IL_00c8: call System.Boolean TheForestOfLove.InputHelper::get_IsInventoryButtonDown()
IL_00cd: brfalse.s IL_00e8
IL_00cf: ldarg.0
IL_00d0: call TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::get_currentPage()
IL_00d5: ldc.i4.3
IL_00d6: beq.s IL_00e0
IL_00d8: ldarg.0
IL_00d9: ldc.i4.3
IL_00da: call System.Void TheForestOfLove.MasterLog::JumpToPage(TheForestOfLove.MasterLogPage)
IL_00df: ret
IL_00e0: ldarg.0
IL_00e1: ldc.i4.0
IL_00e2: call System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_00e7: ret
IL_00e8: call System.Boolean TheForestOfLove.InputHelper::get_IsCritterLogButtonDown()
IL_00ed: brfalse.s IL_0107
IL_00ef: ldarg.0
IL_00f0: call TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::get_currentPage()
IL_00f5: brfalse.s IL_00ff
IL_00f7: ldarg.0
IL_00f8: ldc.i4.0
IL_00f9: call System.Void TheForestOfLove.MasterLog::JumpToPage(TheForestOfLove.MasterLogPage)
IL_00fe: ret
IL_00ff: ldarg.0
IL_0100: ldc.i4.0
IL_0101: call System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_0106: ret
IL_0107: call System.Boolean TheForestOfLove.InputHelper::get_IsQuestLogButtonDown()
IL_010c: brfalse.s IL_0127
IL_010e: ldarg.0
IL_010f: call TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::get_currentPage()
IL_0114: ldc.i4.1
IL_0115: beq.s IL_011f
IL_0117: ldarg.0
IL_0118: ldc.i4.1
IL_0119: call System.Void TheForestOfLove.MasterLog::JumpToPage(TheForestOfLove.MasterLogPage)
IL_011e: ret
IL_011f: ldarg.0
IL_0120: ldc.i4.0
IL_0121: call System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_0126: ret
IL_0127: call System.Boolean TheForestOfLove.InputHelper::get_IsMapButtonDown()
IL_012c: brfalse.s IL_015f
IL_012e: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedMap()
IL_0133: brfalse.s IL_015f
IL_0135: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_013a: ldstr "DeepWoods_Campfire"
IL_013f: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0144: brfalse.s IL_015f
IL_0146: ldarg.0
IL_0147: call TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::get_currentPage()
IL_014c: ldc.i4.2
IL_014d: beq.s IL_0157
IL_014f: ldarg.0
IL_0150: ldc.i4.2
IL_0151: call System.Void TheForestOfLove.MasterLog::JumpToPage(TheForestOfLove.MasterLogPage)
IL_0156: ret
IL_0157: ldarg.0
IL_0158: ldc.i4.0
IL_0159: call System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_015e: ret
IL_015f: call System.Boolean TheForestOfLove.InputHelper::get_IsPauseButtonDown()
IL_0164: brtrue.s IL_016d
IL_0166: call System.Boolean TheForestOfLove.InputHelper::get_IsBackButtonDown()
IL_016b: brfalse.s IL_0175
IL_016d: ldarg.0
IL_016e: ldc.i4.0
IL_016f: call System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_0174: ret
IL_0175: ldarg.0
IL_0176: call System.Void TheForestOfLove.MasterLog::NavigatePages()
IL_017b: ret
METHOD System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::get_currentPage()
IL_0007: ldarg.1
IL_0008: call System.Void TheForestOfLove.MasterLog::ToggleVisible(TheForestOfLove.MasterLogPage,System.Boolean)
IL_000d: ret
METHOD System.Void TheForestOfLove.MasterLog::ToggleVisible_Inventory(System.Boolean)
IL_0000: ldarg.0
IL_0001: ldc.i4.3
IL_0002: ldarg.1
IL_0003: call System.Void TheForestOfLove.MasterLog::ToggleVisible(TheForestOfLove.MasterLogPage,System.Boolean)
IL_0008: ret
METHOD System.Void TheForestOfLove.MasterLog::ToggleVisible(TheForestOfLove.MasterLogPage,System.Boolean)
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call System.Boolean TheForestOfLove.MasterLog::get_visible()
IL_0007: ldc.i4.0
IL_0008: ceq
IL_000a: call System.Void TheForestOfLove.MasterLog::set_visible(System.Boolean)
IL_000f: ldarg.0
IL_0010: call System.Boolean TheForestOfLove.MasterLog::get_visible()
IL_0015: brfalse.s IL_004c
IL_0017: ldarg.0
IL_0018: ldfld PixelCrushers.UIPanel TheForestOfLove.MasterLog::masterLogUi
IL_001d: callvirt System.Void PixelCrushers.UIPanel::Open()
IL_0022: ldarg.0
IL_0023: ldarg.0
IL_0024: ldarg.1
IL_0025: dup
IL_0026: stloc.0
IL_0027: stfld TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::currentDisplayedPage
IL_002c: ldloc.0
IL_002d: call System.Void TheForestOfLove.MasterLog::set_currentPage(TheForestOfLove.MasterLogPage)
IL_0032: ldarg.0
IL_0033: call System.Void TheForestOfLove.MasterLog::ResetStuff()
IL_0038: ldarg.0
IL_0039: call System.Void TheForestOfLove.MasterLog::UpdateVisiblePageLabel()
IL_003e: ldarg.0
IL_003f: ldarg.0
IL_0040: call TheForestOfLove.MasterLogPage TheForestOfLove.MasterLog::get_currentPage()
IL_0045: call System.Void TheForestOfLove.MasterLog::UpdatePlaceholderContents(TheForestOfLove.MasterLogPage)
IL_004a: br.s IL_006a
IL_004c: ldarg.0
IL_004d: call System.Void TheForestOfLove.MasterLog::ResetStuff()
IL_0052: ldarg.0
IL_0053: ldfld PixelCrushers.UIPanel TheForestOfLove.MasterLog::masterLogUi
IL_0058: callvirt System.Void PixelCrushers.UIPanel::Close()
IL_005d: ldarg.2
IL_005e: brtrue.s IL_006a
IL_0060: ldc.i4 300
IL_0065: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_006a: ldarg.0
IL_006b: ldfld TheForestOfLove.CritterLog TheForestOfLove.MasterLog::critterLog
IL_0070: callvirt System.Void TheForestOfLove.CritterLog::ToggleVisible()
IL_0075: ldarg.0
IL_0076: ldfld TheForestOfLove.QuestLog TheForestOfLove.MasterLog::questLog
IL_007b: callvirt System.Void TheForestOfLove.QuestLog::ToggleVisible()
IL_0080: ldarg.0
IL_0081: ldfld TheForestOfLove.InventoryUi TheForestOfLove.MasterLog::inventoryUi
IL_0086: callvirt System.Void TheForestOfLove.InventoryUi::ToggleVisible()
IL_008b: ldarg.0
IL_008c: ldfld TheForestOfLove.MapUI TheForestOfLove.MasterLog::mapUi
IL_0091: callvirt System.Void TheForestOfLove.MapUI::ToggleVisible()
IL_0096: ret
