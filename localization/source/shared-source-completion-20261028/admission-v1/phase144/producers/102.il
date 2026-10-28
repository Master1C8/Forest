TYPE TheForestOfLove.InventoryCellUiTemplate_Selected
METHOD System.Void TheForestOfLove.InventoryCellUiTemplate_Selected::Show() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.InventoryCellUiTemplate::Show()
IL_0006: ldarg.0
IL_0007: ldfld System.Boolean TheForestOfLove.InventoryCellUiTemplate_Selected::selected
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: ldarg.0
IL_0010: ldc.i4.1
IL_0011: stfld System.Boolean TheForestOfLove.InventoryCellUiTemplate_Selected::selected
IL_0016: ldarg.0
IL_0017: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_001c: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0021: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_0026: brfalse.s IL_005c
IL_0028: ldarg.0
IL_0029: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_002e: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0033: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_0038: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isConsumed
IL_003d: brtrue.s IL_0059
IL_003f: ldarg.0
IL_0040: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0045: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_004a: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_004f: ldfld System.Int32 TheForestOfLove.Inventory.InventoryItem::quantity
IL_0054: ldc.i4.0
IL_0055: cgt
IL_0057: br.s IL_005d
IL_0059: ldc.i4.1
IL_005a: br.s IL_005d
IL_005c: ldc.i4.0
IL_005d: stloc.0
IL_005e: ldloc.0
IL_005f: ldarg.0
IL_0060: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0065: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_006a: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_006f: brfalse.s IL_009b
IL_0071: ldarg.0
IL_0072: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0077: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_007c: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_0081: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_0086: ldc.i4 405
IL_008b: bne.un.s IL_009b
IL_008d: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_0092: brfalse.s IL_009b
IL_0094: call System.Boolean TheForestOfLove.Narrative.InstancedStoryController::GetInventoryAdventureItemPlaceholderEnabled()
IL_0099: br.s IL_009c
IL_009b: ldc.i4.0
IL_009c: or
IL_009d: stloc.0
IL_009e: ldloc.0
IL_009f: brtrue.s IL_00a4
IL_00a1: ldc.i4.0
IL_00a2: br.s IL_00b9
IL_00a4: ldarg.0
IL_00a5: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_00aa: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_00af: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_00b4: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isConsumed
IL_00b9: stloc.1
IL_00ba: ldarg.0
IL_00bb: ldfld UnityEngine.CanvasGroup TheForestOfLove.InventoryCellUiTemplate_Selected::itemSpriteCanvasGroup
IL_00c0: ldloc.0
IL_00c1: brtrue.s IL_00ca
IL_00c3: ldc.r4 0
IL_00c8: br.s IL_00d9
IL_00ca: ldloc.1
IL_00cb: brtrue.s IL_00d4
IL_00cd: ldc.r4 1
IL_00d2: br.s IL_00d9
IL_00d4: ldc.r4 0.35
IL_00d9: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00de: ldarg.0
IL_00df: ldfld UnityEngine.Animator TheForestOfLove.InventoryCellUiTemplate_Selected::itemSpriteFXAnimator
IL_00e4: ldarg.0
IL_00e5: ldfld UnityEngine.Animator TheForestOfLove.InventoryCellUiTemplate::itemSpriteAnimator
IL_00ea: callvirt UnityEngine.RuntimeAnimatorController UnityEngine.Animator::get_runtimeAnimatorController()
IL_00ef: callvirt System.Void UnityEngine.Animator::set_runtimeAnimatorController(UnityEngine.RuntimeAnimatorController)
IL_00f4: ldarg.0
IL_00f5: ldfld UnityEngine.UI.Image TheForestOfLove.InventoryCellUiTemplate_Selected::itemSpriteFXImage
IL_00fa: ldarg.0
IL_00fb: ldfld UnityEngine.UI.Image TheForestOfLove.InventoryCellUiTemplate::itemSprite
IL_0100: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0105: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_010a: ldarg.0
IL_010b: ldfld UnityEngine.Animator TheForestOfLove.InventoryCellUiTemplate_Selected::itemSpriteFlashbarMaskAnimator
IL_0110: ldarg.0
IL_0111: ldfld UnityEngine.Animator TheForestOfLove.InventoryCellUiTemplate::itemSpriteAnimator
IL_0116: callvirt UnityEngine.RuntimeAnimatorController UnityEngine.Animator::get_runtimeAnimatorController()
IL_011b: callvirt System.Void UnityEngine.Animator::set_runtimeAnimatorController(UnityEngine.RuntimeAnimatorController)
IL_0120: ldarg.0
IL_0121: ldfld UnityEngine.UI.Image TheForestOfLove.InventoryCellUiTemplate_Selected::itemSpriteFlashbarMaskImage
IL_0126: ldarg.0
IL_0127: ldfld UnityEngine.UI.Image TheForestOfLove.InventoryCellUiTemplate::itemSprite
IL_012c: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0131: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_0136: ldloc.0
IL_0137: brfalse IL_025c
IL_013c: ldarg.0
IL_013d: ldfld UnityEngine.UI.Image TheForestOfLove.InventoryCellUiTemplate_Selected::itemSpriteFXImage
IL_0142: callvirt System.Void UnityEngine.UI.Graphic::SetNativeSize()
IL_0147: ldarg.0
IL_0148: ldfld UnityEngine.UI.Image TheForestOfLove.InventoryCellUiTemplate_Selected::itemSpriteFlashbarMaskImage
IL_014d: callvirt System.Void UnityEngine.UI.Graphic::SetNativeSize()
IL_0152: ldarg.0
IL_0153: ldfld UnityEngine.UI.Image TheForestOfLove.InventoryCellUiTemplate_Selected::itemSpriteFXImage
IL_0158: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.RectTransform>()
IL_015d: stloc.2
IL_015e: ldarg.0
IL_015f: ldfld UnityEngine.UI.Image TheForestOfLove.InventoryCellUiTemplate_Selected::itemSpriteFlashbarMaskImage
IL_0164: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.RectTransform>()
IL_0169: stloc.3
IL_016a: ldarg.0
IL_016b: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0170: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0175: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_017a: ldfld UnityEngine.Vector2 TheForestOfLove.Inventory.InventoryItem::spriteOffset
IL_017f: call UnityEngine.Vector2 UnityEngine.Vector2::get_zero()
IL_0184: call System.Boolean UnityEngine.Vector2::op_Inequality(UnityEngine.Vector2,UnityEngine.Vector2)
IL_0189: brfalse.s IL_01cd
IL_018b: ldloc.2
IL_018c: ldarg.0
IL_018d: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0192: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0197: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_019c: ldfld UnityEngine.Vector2 TheForestOfLove.Inventory.InventoryItem::spriteOffset
IL_01a1: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_01a6: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_01ab: ldloc.3
IL_01ac: ldarg.0
IL_01ad: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_01b2: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_01b7: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_01bc: ldfld UnityEngine.Vector2 TheForestOfLove.Inventory.InventoryItem::spriteOffset
IL_01c1: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_01c6: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_01cb: br.s IL_01e3
IL_01cd: ldloc.2
IL_01ce: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_01d3: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_01d8: ldloc.3
IL_01d9: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_01de: callvirt System.Void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)
IL_01e3: ldarg.0
IL_01e4: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_01e9: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_01ee: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_01f3: ldfld UnityEngine.Vector2 TheForestOfLove.Inventory.InventoryItem::spriteScale
IL_01f8: call UnityEngine.Vector2 UnityEngine.Vector2::get_zero()
IL_01fd: call System.Boolean UnityEngine.Vector2::op_Inequality(UnityEngine.Vector2,UnityEngine.Vector2)
IL_0202: brfalse.s IL_0246
IL_0204: ldloc.2
IL_0205: ldarg.0
IL_0206: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_020b: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0210: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_0215: ldfld UnityEngine.Vector2 TheForestOfLove.Inventory.InventoryItem::spriteScale
IL_021a: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_021f: callvirt System.Void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)
IL_0224: ldloc.3
IL_0225: ldarg.0
IL_0226: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_022b: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0230: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_0235: ldfld UnityEngine.Vector2 TheForestOfLove.Inventory.InventoryItem::spriteScale
IL_023a: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_023f: callvirt System.Void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)
IL_0244: br.s IL_025c
IL_0246: ldloc.2
IL_0247: call UnityEngine.Vector3 UnityEngine.Vector3::get_one()
IL_024c: callvirt System.Void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)
IL_0251: ldloc.3
IL_0252: call UnityEngine.Vector3 UnityEngine.Vector3::get_one()
IL_0257: callvirt System.Void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)
IL_025c: ldloc.1
IL_025d: brtrue.s IL_026f
IL_025f: ldarg.0
IL_0260: ldfld UnityEngine.Animator TheForestOfLove.InventoryCellUiTemplate_Selected::cellAnimator
IL_0265: ldstr "start"
IL_026a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_026f: ldarg.0
IL_0270: ldfld UnityEngine.Animator TheForestOfLove.InventoryCellUiTemplate_Selected::cellAnimator
IL_0275: ldstr "has_item"
IL_027a: ldloc.0
IL_027b: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0280: ldarg.0
IL_0281: ldfld UnityEngine.Animator TheForestOfLove.InventoryCellUiTemplate_Selected::itemSpriteFXContainerAnimator
IL_0286: ldloc.0
IL_0287: brfalse.s IL_028c
IL_0289: ldloc.1
IL_028a: brfalse.s IL_0293
IL_028c: ldstr "hide"
IL_0291: br.s IL_0298
IL_0293: ldstr "show"
IL_0298: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_029d: ret
METHOD System.Void TheForestOfLove.InventoryCellUiTemplate_Selected::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.InventoryUi TheForestOfLove.InventoryCellUiTemplate::inventoryUi
IL_0006: callvirt System.Boolean TheForestOfLove.InventoryUi::get_visible()
IL_000b: brtrue.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Boolean TheForestOfLove.InventoryCellUiTemplate_Selected::selected
IL_0014: brfalse.s IL_002f
IL_0016: call System.Boolean TheForestOfLove.InputHelper::get_IsSubmitButtonDown()
IL_001b: brfalse.s IL_002f
IL_001d: ldarg.0
IL_001e: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0023: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0028: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_002d: brtrue.s IL_0030
IL_002f: ret
IL_0030: ldarg.0
IL_0031: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0036: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_003b: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_0040: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_0045: ldc.i4 230
IL_004a: bne.un.s IL_006f
IL_004c: ldarg.0
IL_004d: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0052: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0057: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_005c: callvirt System.Boolean TheForestOfLove.Inventory.InventoryItem::get_PlayerHasItem()
IL_0061: brfalse.s IL_006f
IL_0063: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MasterLog>()
IL_0068: ldc.i4.2
IL_0069: callvirt System.Void TheForestOfLove.MasterLog::JumpToPage(TheForestOfLove.MasterLogPage)
IL_006e: ret
IL_006f: ldarg.0
IL_0070: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0075: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_007a: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_007f: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_0084: ldc.i4 470
IL_0089: bne.un.s IL_00bf
IL_008b: ldarg.0
IL_008c: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0091: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0096: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_009b: callvirt System.Boolean TheForestOfLove.Inventory.InventoryItem::get_PlayerHasItem()
IL_00a0: brfalse.s IL_00bf
IL_00a2: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MasterLog>()
IL_00a7: ldc.i4.1
IL_00a8: callvirt System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_00ad: ldarg.0
IL_00ae: ldftn System.Void TheForestOfLove.InventoryCellUiTemplate_Selected::<Update>b__10_0()
IL_00b4: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00b9: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_00be: ret
IL_00bf: ldarg.0
IL_00c0: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_00c5: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_00ca: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_00cf: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_00d4: ldc.i4 390
IL_00d9: bne.un.s IL_010f
IL_00db: ldarg.0
IL_00dc: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_00e1: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_00e6: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_00eb: callvirt System.Boolean TheForestOfLove.Inventory.InventoryItem::get_PlayerHasItem()
IL_00f0: brfalse.s IL_010f
IL_00f2: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.MasterLog>()
IL_00f7: ldc.i4.1
IL_00f8: callvirt System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_00fd: ldarg.0
IL_00fe: ldftn System.Void TheForestOfLove.InventoryCellUiTemplate_Selected::<Update>b__10_1()
IL_0104: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0109: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_010e: ret
IL_010f: ldarg.0
IL_0110: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0115: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_011a: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_011f: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_0124: ldc.i4 400
IL_0129: bne.un.s IL_018d
IL_012b: ldstr "Glitch Rascal"
IL_0130: call System.Void TheForestOfLove.Audio.SoundManager::PlayTypewriterSound(System.String)
IL_0135: ldc.r4 0
IL_013a: ldc.r4 1
IL_013f: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_0144: call System.Void TheForestOfLove.Audio.MusicManager::FadeToVolume(System.Single,System.Nullable`1<System.Single>)
IL_0149: call System.Void TheForestOfLove.UICameraGlitchController::DoHardGlitch()
IL_014e: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.MasterLog>()
IL_0153: ldc.i4.1
IL_0154: callvirt System.Void TheForestOfLove.MasterLog::ToggleVisible(System.Boolean)
IL_0159: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_015e: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0163: ldc.r4 1
IL_0168: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.InventoryCellUiTemplate_Selected/<>c::<>9__10_2
IL_016d: dup
IL_016e: brtrue.s IL_0187
IL_0170: pop
IL_0171: ldsfld TheForestOfLove.InventoryCellUiTemplate_Selected/<>c TheForestOfLove.InventoryCellUiTemplate_Selected/<>c::<>9
IL_0176: ldftn System.Void TheForestOfLove.InventoryCellUiTemplate_Selected/<>c::<Update>b__10_2()
IL_017c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0181: dup
IL_0182: stsfld UnityEngine.Events.UnityAction TheForestOfLove.InventoryCellUiTemplate_Selected/<>c::<>9__10_2
IL_0187: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_018c: ret
IL_018d: ldarg.0
IL_018e: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_0193: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0198: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_019d: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_01a2: ldc.i4.s 120
IL_01a4: bne.un.s IL_01ef
IL_01a6: ldc.i4 410
IL_01ab: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_01b0: brfalse.s IL_01ef
IL_01b2: ldstr "LightQuest_LeavingOtterShop"
IL_01b7: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01bc: brfalse.s IL_01ef
IL_01be: ldc.i4 430
IL_01c3: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_01c8: brtrue.s IL_01ef
IL_01ca: ldc.i4 435
IL_01cf: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_01d4: brtrue.s IL_01ef
IL_01d6: ldc.i4 440
IL_01db: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_01e0: brtrue.s IL_01ef
IL_01e2: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_01e7: brtrue.s IL_01ef
IL_01e9: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnActivateFireflyJarEasterEgg()
IL_01ee: ret
IL_01ef: ldarg.0
IL_01f0: ldfld TheForestOfLove.InventoryCellUiController TheForestOfLove.InventoryCellUiTemplate::parentCell
IL_01f5: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_01fa: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_01ff: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_0204: ldc.i4 450
IL_0209: bne.un.s IL_0267
IL_020b: call System.Boolean TheForestOfLove.QuestTriggerHelper::InBusyStoryMoment()
IL_0210: brtrue.s IL_0267
IL_0212: call System.String TheForestOfLove.GossipUI::get_targetActorDbName()
IL_0217: ldstr "Mabel"
IL_021c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0221: brfalse.s IL_0267
IL_0223: ldstr "Mabel"
IL_0228: call TheForestOfLove.Gameplay.CritterActor TheForestOfLove.Gameplay.CritterActor::FindActorByName(System.String)
IL_022d: stloc.0
IL_022e: ldloc.0
IL_022f: ldnull
IL_0230: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0235: brtrue.s IL_0260
IL_0237: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_023c: ldnull
IL_023d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0242: brtrue.s IL_0260
IL_0244: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0249: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_024e: ldloc.0
IL_024f: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_0254: call System.Single UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0259: ldc.r4 1
IL_025e: ble.un.s IL_0261
IL_0260: ret
IL_0261: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnActivateFireflyJarEasterEgg()
IL_0266: ret
IL_0267: ret
