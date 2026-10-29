TYPE PixelCrushers.UIPanel
METHOD System.Boolean PixelCrushers.UIPanel::get_isOpen() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.UIPanel/PanelState PixelCrushers.UIPanel::get_panelState()
IL_0006: ldc.i4.1
IL_0007: beq.s IL_0028
IL_0009: ldarg.0
IL_000a: call PixelCrushers.UIPanel/PanelState PixelCrushers.UIPanel::get_panelState()
IL_000f: ldc.i4.2
IL_0010: beq.s IL_0028
IL_0012: ldarg.0
IL_0013: call PixelCrushers.UIPanel/PanelState PixelCrushers.UIPanel::get_panelState()
IL_0018: brtrue.s IL_0026
IL_001a: ldarg.0
IL_001b: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0020: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0025: ret
IL_0026: ldc.i4.0
IL_0027: ret
IL_0028: ldc.i4.1
IL_0029: ret
METHOD System.Void PixelCrushers.UIPanel::Open() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.UIPanel/PanelState PixelCrushers.UIPanel::get_panelState()
IL_0006: ldc.i4.2
IL_0007: beq.s IL_0012
IL_0009: ldarg.0
IL_000a: call PixelCrushers.UIPanel/PanelState PixelCrushers.UIPanel::get_panelState()
IL_000f: ldc.i4.1
IL_0010: bne.un.s IL_0013
IL_0012: ret
IL_0013: ldarg.0
IL_0014: ldc.i4.1
IL_0015: call System.Void PixelCrushers.UIPanel::set_panelState(PixelCrushers.UIPanel/PanelState)
IL_001a: ldarg.0
IL_001b: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0020: ldc.i4.1
IL_0021: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0026: ldarg.0
IL_0027: ldfld UnityEngine.Events.UnityEvent PixelCrushers.UIPanel::onOpen
IL_002c: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0031: ldarg.0
IL_0032: call PixelCrushers.UIAnimatorMonitor PixelCrushers.UIPanel::get_animatorMonitor()
IL_0037: ldarg.0
IL_0038: ldfld System.String PixelCrushers.UIPanel::showAnimationTrigger
IL_003d: ldarg.0
IL_003e: dup
IL_003f: ldvirtftn System.Void PixelCrushers.UIPanel::OnVisible()
IL_0045: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_004a: ldarg.0
IL_004b: callvirt System.Boolean PixelCrushers.UIPanel::get_waitForShowAnimation()
IL_0050: callvirt System.Void PixelCrushers.UIAnimatorMonitor::SetTrigger(System.String,System.Action,System.Boolean)
IL_0055: ldarg.0
IL_0056: call System.Void PixelCrushers.UIPanel::PushToPanelStack()
IL_005b: ret
