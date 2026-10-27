TYPE UnityEngine.UI.CanvasUpdateRegistry
METHOD System.Boolean UnityEngine.UI.CanvasUpdateRegistry::TryRegisterCanvasElementForLayoutRebuild(UnityEngine.UI.ICanvasElement) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call UnityEngine.UI.CanvasUpdateRegistry UnityEngine.UI.CanvasUpdateRegistry::get_instance()
IL_0005: ldarg.0
IL_0006: callvirt System.Boolean UnityEngine.UI.CanvasUpdateRegistry::InternalRegisterCanvasElementForLayoutRebuild(UnityEngine.UI.ICanvasElement)
IL_000b: ret
