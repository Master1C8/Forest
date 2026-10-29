TYPE TheForestOfLove.SelectableUiControl
METHOD System.Void TheForestOfLove.SelectableUiControl::set_selected(System.Boolean) | attributes=Private, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean TheForestOfLove.SelectableUiControl::<selected>k__BackingField
IL_0007: ret
METHOD System.Void TheForestOfLove.SelectableUiControl::OnSelect(UnityEngine.EventSystems.BaseEventData) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.SelectableUiControl::set_selected(System.Boolean)
IL_0007: ldarg.0
IL_0008: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.SelectableUiControl::onSelected
IL_000d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0012: ret
METHOD System.Void TheForestOfLove.SelectableUiControl::OnDeselect(UnityEngine.EventSystems.BaseEventData) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.SelectableUiControl::Deselect()
IL_0006: ret
