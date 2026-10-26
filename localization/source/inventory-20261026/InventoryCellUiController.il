TYPE TheForestOfLove.InventoryCellUiController
METHOD System.Void TheForestOfLove.InventoryCellUiController::OnSelected()
IL_0000: ldarg.0
IL_0001: call System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call System.Void TheForestOfLove.InventoryCellUiController::ChooseCurrentTemplateType()
IL_000f: ldarg.0
IL_0010: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.InventoryCellUiController::onCellSelected
IL_0015: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_001a: ldsfld TheForestOfLove.InventoryCellUiEvent TheForestOfLove.InventoryEvents::onCellSelected
IL_001f: ldarg.0
IL_0020: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.InventoryCellUiController>::Invoke(!0)
IL_0025: ldarg.0
IL_0026: ldfld TheForestOfLove.InventoryUi TheForestOfLove.InventoryCellUiController::inventoryUi
IL_002b: callvirt System.Boolean TheForestOfLove.InventoryUi::get_allowSound()
IL_0030: brfalse.s IL_0039
IL_0032: ldc.i4.s 100
IL_0034: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0039: ret
