METHOD System.Void ForestProbe::OnDestroy() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldftn System.Void ForestProbe::ObserveUnityFocusEvent(System.Boolean)
IL_0008: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_000d: call System.Void UnityEngine.Application::remove_focusChanged(System.Action`1<System.Boolean>)
IL_0012: nop
IL_0013: ldarg.0
IL_0014: ldfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_0019: ldnull
IL_001a: cgt.un
IL_001c: stloc.0
IL_001d: ldloc.0
IL_001e: brfalse.s IL_0038
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_0026: ldarg.0
IL_0027: ldftn System.Void ForestProbe::ObserveBucky212End(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32)
IL_002d: newobj System.Void UnityEngine.Events.UnityAction`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0032: callvirt System.Void UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::RemoveListener(UnityEngine.Events.UnityAction`4<!0,!1,!2,!3>)
IL_0037: nop
IL_0038: ldarg.0
IL_0039: call System.Void ForestProbe::RestoreInputPolicy()
IL_003e: nop
IL_003f: ret
