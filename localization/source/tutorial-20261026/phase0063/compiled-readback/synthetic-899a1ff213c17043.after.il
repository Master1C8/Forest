METHOD System.Void ForestProbe::OnDestroy() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldstr "destroy"
IL_0007: call System.Void ForestProbe::ObserveLifecycle(System.String)
IL_000c: nop
IL_000d: ldarg.0
IL_000e: ldftn System.Void ForestProbe::ObserveUnityQuitting()
IL_0014: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0019: call System.Void UnityEngine.Application::remove_quitting(System.Action)
IL_001e: nop
IL_001f: ldarg.0
IL_0020: ldftn System.Void ForestProbe::ObserveUnityFocusEvent(System.Boolean)
IL_0026: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_002b: call System.Void UnityEngine.Application::remove_focusChanged(System.Action`1<System.Boolean>)
IL_0030: nop
IL_0031: ldarg.0
IL_0032: ldfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_0037: ldnull
IL_0038: cgt.un
IL_003a: stloc.0
IL_003b: ldloc.0
IL_003c: brfalse.s IL_0056
IL_003e: ldarg.0
IL_003f: ldfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_0044: ldarg.0
IL_0045: ldftn System.Void ForestProbe::ObserveBucky212End(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32)
IL_004b: newobj System.Void UnityEngine.Events.UnityAction`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0050: callvirt System.Void UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::RemoveListener(UnityEngine.Events.UnityAction`4<!0,!1,!2,!3>)
IL_0055: nop
IL_0056: ldarg.0
IL_0057: call System.Void ForestProbe::RestoreInputPolicy()
IL_005c: nop
IL_005d: ret
