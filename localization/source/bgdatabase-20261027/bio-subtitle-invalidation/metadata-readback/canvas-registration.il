TYPE UnityEngine.UI.CanvasUpdateRegistry
METHOD System.Void UnityEngine.UI.CanvasUpdateRegistry::RegisterCanvasElementForGraphicRebuild(UnityEngine.UI.ICanvasElement) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call UnityEngine.UI.CanvasUpdateRegistry UnityEngine.UI.CanvasUpdateRegistry::get_instance()
IL_0005: ldarg.0
IL_0006: callvirt System.Boolean UnityEngine.UI.CanvasUpdateRegistry::InternalRegisterCanvasElementForGraphicRebuild(UnityEngine.UI.ICanvasElement)
IL_000b: pop
IL_000c: ret
METHOD System.Boolean UnityEngine.UI.CanvasUpdateRegistry::IsRebuildingGraphics() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call UnityEngine.UI.CanvasUpdateRegistry UnityEngine.UI.CanvasUpdateRegistry::get_instance()
IL_0005: ldfld System.Boolean UnityEngine.UI.CanvasUpdateRegistry::m_PerformingGraphicUpdate
IL_000a: ret
