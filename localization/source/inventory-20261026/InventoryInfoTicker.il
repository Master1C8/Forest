TYPE TheForestOfLove.InventoryInfoTicker
METHOD System.Void TheForestOfLove.InventoryInfoTicker::Start()
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld UnityEngine.UI.Text TheForestOfLove.InventoryInfoTicker::tickerText
IL_0007: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.RectTransform>()
IL_000c: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_anchoredPosition()
IL_0011: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0016: stfld UnityEngine.Vector3 TheForestOfLove.InventoryInfoTicker::startingPosition
IL_001b: ldsfld TheForestOfLove.InventoryCellUiEvent TheForestOfLove.InventoryEvents::onCellSelected
IL_0020: ldarg.0
IL_0021: ldftn System.Void TheForestOfLove.InventoryInfoTicker::OnCellSelected(TheForestOfLove.InventoryCellUiController)
IL_0027: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.InventoryCellUiController>::.ctor(System.Object,System.IntPtr)
IL_002c: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.InventoryCellUiController>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0031: ret
METHOD System.Void TheForestOfLove.InventoryInfoTicker::Update()
IL_0000: ret
METHOD System.Void TheForestOfLove.InventoryInfoTicker::OnCellSelected(TheForestOfLove.InventoryCellUiController)
IL_0000: ldarg.1
IL_0001: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0006: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_000b: stloc.0
IL_000c: ldarg.1
IL_000d: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0012: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_0017: brfalse.s IL_007a
IL_0019: ldarg.1
IL_001a: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_001f: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_0024: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_0029: ldc.i4 400
IL_002e: bne.un.s IL_007a
IL_0030: ldarg.0
IL_0031: ldsfld System.String System.String::Empty
IL_0036: ldsfld System.String System.String::Empty
IL_003b: call System.Void TheForestOfLove.InventoryInfoTicker::UpdateItemInfoText(System.String,System.String)
IL_0040: ldarg.0
IL_0041: ldfld UnityEngine.GameObject TheForestOfLove.InventoryInfoTicker::glitchItemInfoTicker
IL_0046: ldc.i4.1
IL_0047: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_004c: ldarg.0
IL_004d: ldarg.0
IL_004e: ldfld DigitalGlitches.TMProGlitch TheForestOfLove.InventoryInfoTicker::glitchEffect
IL_0053: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0058: callvirt !!0 UnityEngine.GameObject::AddComponent<DigitalGlitches.TMProGlitch>()
IL_005d: stfld DigitalGlitches.TMProGlitch TheForestOfLove.InventoryInfoTicker::_currentGlitchEffect
IL_0062: ldarg.0
IL_0063: ldfld DigitalGlitches.TMProGlitch TheForestOfLove.InventoryInfoTicker::glitchEffect
IL_0068: ldarg.0
IL_0069: ldfld DigitalGlitches.TMProGlitch TheForestOfLove.InventoryInfoTicker::_currentGlitchEffect
IL_006e: call System.Void TheForestOfLove.GeneralExtensions::CopyTo(DigitalGlitches.GlitchEffect,DigitalGlitches.GlitchEffect)
IL_0073: ldarg.0
IL_0074: call System.Void TheForestOfLove.InventoryInfoTicker::RandomizeGlitchItemInfoTickerText()
IL_0079: ret
IL_007a: ldarg.0
IL_007b: ldfld DigitalGlitches.TMProGlitch TheForestOfLove.InventoryInfoTicker::_currentGlitchEffect
IL_0080: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0085: ldarg.0
IL_0086: ldfld UnityEngine.GameObject TheForestOfLove.InventoryInfoTicker::glitchItemInfoTicker
IL_008b: ldc.i4.0
IL_008c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0091: ldarg.1
IL_0092: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_0097: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_009c: brfalse.s IL_00d6
IL_009e: ldarg.1
IL_009f: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_00a4: callvirt TheForestOfLove.Inventory.InventoryItem TheForestOfLove.InventoryGridNode::get_schema()
IL_00a9: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.Inventory.InventoryItem::itemType
IL_00ae: ldc.i4 405
IL_00b3: bne.un.s IL_00d6
IL_00b5: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00ba: brfalse.s IL_00d6
IL_00bc: call System.Boolean TheForestOfLove.Narrative.InstancedStoryController::GetInventoryAdventureItemPlaceholderEnabled()
IL_00c1: brfalse.s IL_00d6
IL_00c3: ldarg.0
IL_00c4: ldloc.0
IL_00c5: ldfld System.String TheForestOfLove.Inventory.InventoryItem::title
IL_00ca: ldloc.0
IL_00cb: ldfld System.String TheForestOfLove.Inventory.InventoryItem::description
IL_00d0: call System.Void TheForestOfLove.InventoryInfoTicker::UpdateItemInfoText(System.String,System.String)
IL_00d5: ret
IL_00d6: ldloc.0
IL_00d7: brfalse.s IL_00ea
IL_00d9: ldloc.0
IL_00da: ldfld System.Boolean TheForestOfLove.Inventory.InventoryItem::isConsumed
IL_00df: brtrue.s IL_012d
IL_00e1: ldloc.0
IL_00e2: ldfld System.Int32 TheForestOfLove.Inventory.InventoryItem::quantity
IL_00e7: ldc.i4.0
IL_00e8: bgt.s IL_012d
IL_00ea: ldarg.1
IL_00eb: ldfld TheForestOfLove.InventoryGridNode TheForestOfLove.InventoryCellUiController::node
IL_00f0: ldfld UnityEngine.Vector2 TheForestOfLove.InventoryGridNode::gridLocation
IL_00f5: ldc.r4 4
IL_00fa: ldc.r4 3
IL_00ff: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_0104: call System.Boolean UnityEngine.Vector2::op_Equality(UnityEngine.Vector2,UnityEngine.Vector2)
IL_0109: brfalse.s IL_011c
IL_010b: ldarg.0
IL_010c: ldstr "SOMETHING?"
IL_0111: ldstr "Nope, more nothing."
IL_0116: call System.Void TheForestOfLove.InventoryInfoTicker::UpdateItemInfoText(System.String,System.String)
IL_011b: ret
IL_011c: ldarg.0
IL_011d: ldstr "Nothin’"
IL_0122: ldstr "You’ve got a whole lot of it."
IL_0127: call System.Void TheForestOfLove.InventoryInfoTicker::UpdateItemInfoText(System.String,System.String)
IL_012c: ret
IL_012d: ldarg.0
IL_012e: ldloc.0
IL_012f: ldfld System.String TheForestOfLove.Inventory.InventoryItem::title
IL_0134: ldloc.0
IL_0135: ldfld System.String TheForestOfLove.Inventory.InventoryItem::description
IL_013a: call System.Void TheForestOfLove.InventoryInfoTicker::UpdateItemInfoText(System.String,System.String)
IL_013f: ret
METHOD System.Void TheForestOfLove.InventoryInfoTicker::UpdateItemInfoText(System.String,System.String)
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Text TheForestOfLove.InventoryInfoTicker::itemTitleText
IL_0006: ldarg.1
IL_0007: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.UI.Text TheForestOfLove.InventoryInfoTicker::tickerText
IL_0012: ldarg.2
IL_0013: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0018: ret
METHOD System.Void TheForestOfLove.InventoryInfoTicker::StartScrolling()
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld TheForestOfLove.InventoryInfoTicker/TickerState TheForestOfLove.InventoryInfoTicker::currentState
IL_0007: ret
METHOD System.Void TheForestOfLove.InventoryInfoTicker::Scroll()
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.RectTransform TheForestOfLove.InventoryInfoTicker::viewport
IL_0006: callvirt UnityEngine.Rect UnityEngine.RectTransform::get_rect()
IL_000b: stloc.1
IL_000c: ldloca.s V_1
IL_000e: call System.Single UnityEngine.Rect::get_width()
IL_0013: ldarg.0
IL_0014: ldfld UnityEngine.UI.Text TheForestOfLove.InventoryInfoTicker::tickerText
IL_0019: callvirt UnityEngine.RectTransform UnityEngine.UI.Graphic::get_rectTransform()
IL_001e: callvirt UnityEngine.Rect UnityEngine.RectTransform::get_rect()
IL_0023: stloc.1
IL_0024: ldloca.s V_1
IL_0026: call System.Single UnityEngine.Rect::get_width()
IL_002b: stloc.0
IL_002c: ldarg.0
IL_002d: ldflda UnityEngine.Vector3 TheForestOfLove.InventoryInfoTicker::currentOffset
IL_0032: ldfld System.Single UnityEngine.Vector3::x
IL_0037: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_003c: add
IL_003d: ldloc.0
IL_003e: ldarg.0
IL_003f: ldfld System.Single TheForestOfLove.InventoryInfoTicker::endPositionPaddingX
IL_0044: add
IL_0045: blt.un.s IL_0060
IL_0047: ldarg.0
IL_0048: ldc.i4.2
IL_0049: stfld TheForestOfLove.InventoryInfoTicker/TickerState TheForestOfLove.InventoryInfoTicker::currentState
IL_004e: ldarg.0
IL_004f: ldstr "ResetScrolling"
IL_0054: ldarg.0
IL_0055: ldfld System.Single TheForestOfLove.InventoryInfoTicker::scrollEndDelaySeconds
IL_005a: call System.Void UnityEngine.MonoBehaviour::Invoke(System.String,System.Single)
IL_005f: ret
IL_0060: ldarg.0
IL_0061: ldflda UnityEngine.Vector3 TheForestOfLove.InventoryInfoTicker::currentOffset
IL_0066: ldflda System.Single UnityEngine.Vector3::x
IL_006b: dup
IL_006c: ldind.r4
IL_006d: ldarg.0
IL_006e: ldfld System.Single TheForestOfLove.InventoryInfoTicker::scrollSpeed
IL_0073: call System.Single UnityEngine.Time::get_deltaTime()
IL_0078: mul
IL_0079: sub
IL_007a: stind.r4
IL_007b: ldarg.0
IL_007c: ldfld UnityEngine.UI.Text TheForestOfLove.InventoryInfoTicker::tickerText
IL_0081: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.RectTransform>()
IL_0086: ldarg.0
IL_0087: ldfld UnityEngine.Vector3 TheForestOfLove.InventoryInfoTicker::startingPosition
IL_008c: ldarg.0
IL_008d: ldfld UnityEngine.Vector3 TheForestOfLove.InventoryInfoTicker::currentOffset
IL_0092: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0097: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_009c: callvirt System.Void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)
IL_00a1: ret
METHOD System.Void TheForestOfLove.InventoryInfoTicker::ResetScrolling()
IL_0000: ldarg.0
IL_0001: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_0006: stfld UnityEngine.Vector3 TheForestOfLove.InventoryInfoTicker::currentOffset
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.UI.Text TheForestOfLove.InventoryInfoTicker::tickerText
IL_0011: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.RectTransform>()
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Vector3 TheForestOfLove.InventoryInfoTicker::startingPosition
IL_001c: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_0021: callvirt System.Void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)
IL_0026: ldarg.0
IL_0027: ldc.i4.0
IL_0028: stfld TheForestOfLove.InventoryInfoTicker/TickerState TheForestOfLove.InventoryInfoTicker::currentState
IL_002d: ldarg.0
IL_002e: ldstr "StartScrolling"
IL_0033: call System.Void UnityEngine.MonoBehaviour::CancelInvoke(System.String)
IL_0038: ldarg.0
IL_0039: ldstr "ResetScrolling"
IL_003e: call System.Void UnityEngine.MonoBehaviour::CancelInvoke(System.String)
IL_0043: ldarg.0
IL_0044: ldstr "StartScrolling"
IL_0049: ldarg.0
IL_004a: ldfld System.Single TheForestOfLove.InventoryInfoTicker::scrollStartDelaySeconds
IL_004f: call System.Void UnityEngine.MonoBehaviour::Invoke(System.String,System.Single)
IL_0054: ret
