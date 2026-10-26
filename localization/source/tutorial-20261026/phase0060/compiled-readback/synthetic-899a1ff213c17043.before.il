METHOD System.Void ForestProbe::OnDestroy() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldftn System.Void ForestProbe::ObserveUnityFocusEvent(System.Boolean)
IL_0008: newobj System.Void System.Action`1<System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_000d: call System.Void UnityEngine.Application::remove_focusChanged(System.Action`1<System.Boolean>)
IL_0012: nop
IL_0013: ldarg.0
IL_0014: call System.Void ForestProbe::RestoreInputPolicy()
IL_0019: nop
IL_001a: ret
