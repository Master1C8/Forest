TYPE TheForestOfLove.InventoryUi
METHOD System.Void TheForestOfLove.InventoryUi::Start()
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.InventoryRedux>()
IL_0007: stfld TheForestOfLove.InventoryRedux TheForestOfLove.InventoryUi::inventory
IL_000c: ldarg.0
IL_000d: ldfld TheForestOfLove.InventoryRedux TheForestOfLove.InventoryUi::inventory
IL_0012: ldflda UnityEngine.Vector2 TheForestOfLove.InventoryRedux::gridSize
IL_0017: ldfld System.Single UnityEngine.Vector2::x
IL_001c: call System.Int32 UnityEngine.Mathf::RoundToInt(System.Single)
IL_0021: stloc.0
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.InventoryRedux TheForestOfLove.InventoryUi::inventory
IL_0028: ldflda UnityEngine.Vector2 TheForestOfLove.InventoryRedux::gridSize
IL_002d: ldfld System.Single UnityEngine.Vector2::y
IL_0032: call System.Int32 UnityEngine.Mathf::RoundToInt(System.Single)
IL_0037: stloc.1
IL_0038: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.InventoryCellUiController>::.ctor()
IL_003d: stloc.2
IL_003e: ldarg.0
IL_003f: call TheForestOfLove.InventoryUiExtraItemsPanel TheForestOfLove.InventoryUi::InstantiateExtraItemsPanel()
IL_0044: stloc.3
IL_0045: ldarg.0
IL_0046: ldloc.2
IL_0047: ldloc.0
IL_0048: ldloc.1
IL_0049: call System.Void TheForestOfLove.InventoryUi::InstantiateItemGridPrefabs(System.Collections.Generic.List`1<TheForestOfLove.InventoryCellUiController>,System.Int32,System.Int32)
IL_004e: ldarg.0
IL_004f: ldloc.2
IL_0050: ldloc.3
IL_0051: ldloc.0
IL_0052: ldloc.1
IL_0053: call System.Void TheForestOfLove.InventoryUi::BuildItemGridNavigation(System.Collections.Generic.List`1<TheForestOfLove.InventoryCellUiController>,TheForestOfLove.InventoryUiExtraItemsPanel,System.Int32,System.Int32)
IL_0058: ldarg.0
IL_0059: ldc.i4.0
IL_005a: call System.Void TheForestOfLove.InventoryUi::set_visible(System.Boolean)
IL_005f: ldarg.0
IL_0060: ldarg.0
IL_0061: call !!0 UnityEngine.Component::GetComponent<UnityEngine.CanvasGroup>()
IL_0066: stfld UnityEngine.CanvasGroup TheForestOfLove.InventoryUi::canvasGroup
IL_006b: ldarg.0
IL_006c: ldfld UnityEngine.CanvasGroup TheForestOfLove.InventoryUi::canvasGroup
IL_0071: ldc.r4 0
IL_0076: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_007b: ret
METHOD System.Void TheForestOfLove.InventoryUi::Open()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.InventoryRedux TheForestOfLove.InventoryUi::inventory
IL_0006: callvirt System.Void TheForestOfLove.InventoryRedux::RefreshItems()
IL_000b: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.GameObject TheForestOfLove.InventoryUi::firstInventoryCell
IL_0016: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_001b: ldarg.0
IL_001c: ldfld UnityEngine.CanvasGroup TheForestOfLove.InventoryUi::canvasGroup
IL_0021: ldc.r4 1
IL_0026: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_002b: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InventoryEvents::onInventoryOpened
IL_0030: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0035: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowMasterLog
IL_003a: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_003f: ret
METHOD System.Void TheForestOfLove.InventoryUi::Close()
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: call System.Void TheForestOfLove.InventoryUi::set_allowSound(System.Boolean)
IL_0007: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_000c: ldnull
IL_000d: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0012: ldarg.0
IL_0013: ldfld UnityEngine.CanvasGroup TheForestOfLove.InventoryUi::canvasGroup
IL_0018: ldc.r4 0
IL_001d: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0022: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.InventoryEvents::onInventoryClosed
IL_0027: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_002c: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideMasterLog
IL_0031: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0036: ret
