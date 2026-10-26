TYPE TheForestOfLove.SelectableUiControl
METHOD System.Void TheForestOfLove.SelectableUiControl::OnSelect(UnityEngine.EventSystems.BaseEventData)
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.SelectableUiControl::set_selected(System.Boolean)
IL_0007: ldarg.0
IL_0008: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.SelectableUiControl::onSelected
IL_000d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0012: ret
METHOD System.Void TheForestOfLove.SelectableUiControl::OnDeselect(UnityEngine.EventSystems.BaseEventData)
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.SelectableUiControl::Deselect()
IL_0006: ret
METHOD System.Void TheForestOfLove.SelectableUiControl::Update()
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.SelectableUiControl::suppressSoundsUntilNextUpdate
IL_0006: brfalse.s IL_001b
IL_0008: ldarg.0
IL_0009: ldc.i4.0
IL_000a: stfld System.Boolean TheForestOfLove.SelectableUiControl::suppressSoundsUntilNextUpdate
IL_000f: ldarg.0
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean TheForestOfLove.SelectableUiControl::suppressSoundsUntilNextUpdateSuppressSoundsOriginalValue
IL_0016: call System.Void TheForestOfLove.SelectableUiControl::set_suppressSounds(System.Boolean)
IL_001b: ret
