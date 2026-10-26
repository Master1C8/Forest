TYPE UnityEngine.Application
METHOD System.Boolean UnityEngine.Application::get_isFocused() | attributes=Public, Static, HideBySig, SpecialName | impl=InternalCall
ATTRIBUTE UnityEngine.Bindings.FreeFunctionAttribute
METHOD System.Void UnityEngine.Application::add_focusChanged(System.Action`1<System.Boolean>) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldsfld System.Action`1<System.Boolean> UnityEngine.Application::focusChanged
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: stloc.1
IL_0008: ldloc.1
IL_0009: ldarg.0
IL_000a: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_000f: castclass System.Action`1<System.Boolean>
IL_0014: stloc.2
IL_0015: ldsflda System.Action`1<System.Boolean> UnityEngine.Application::focusChanged
IL_001a: ldloc.2
IL_001b: ldloc.1
IL_001c: call !!0 System.Threading.Interlocked::CompareExchange<System.Action`1<System.Boolean>>(!!0&,!!0,!!0)
IL_0021: stloc.0
IL_0022: ldloc.0
IL_0023: ldloc.1
IL_0024: bne.un.s IL_0006
IL_0026: ret
METHOD System.Void UnityEngine.Application::remove_focusChanged(System.Action`1<System.Boolean>) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldsfld System.Action`1<System.Boolean> UnityEngine.Application::focusChanged
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: stloc.1
IL_0008: ldloc.1
IL_0009: ldarg.0
IL_000a: call System.Delegate System.Delegate::Remove(System.Delegate,System.Delegate)
IL_000f: castclass System.Action`1<System.Boolean>
IL_0014: stloc.2
IL_0015: ldsflda System.Action`1<System.Boolean> UnityEngine.Application::focusChanged
IL_001a: ldloc.2
IL_001b: ldloc.1
IL_001c: call !!0 System.Threading.Interlocked::CompareExchange<System.Action`1<System.Boolean>>(!!0&,!!0,!!0)
IL_0021: stloc.0
IL_0022: ldloc.0
IL_0023: ldloc.1
IL_0024: bne.un.s IL_0006
IL_0026: ret
METHOD System.Void UnityEngine.Application::InvokeFocusChanged(System.Boolean) | attributes=Assembly, Static, HideBySig | impl=IL
ATTRIBUTE UnityEngine.Scripting.RequiredByNativeCodeAttribute
IL_0000: nop
IL_0001: ldsfld System.Action`1<System.Boolean> UnityEngine.Application::focusChanged
IL_0006: ldnull
IL_0007: cgt.un
IL_0009: stloc.0
IL_000a: ldloc.0
IL_000b: brfalse.s IL_0019
IL_000d: ldsfld System.Action`1<System.Boolean> UnityEngine.Application::focusChanged
IL_0012: ldarg.0
IL_0013: callvirt System.Void System.Action`1<System.Boolean>::Invoke(!0)
IL_0018: nop
IL_0019: ret
