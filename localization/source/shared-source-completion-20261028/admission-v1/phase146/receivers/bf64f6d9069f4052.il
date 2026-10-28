TYPE TheForestOfLove.MapUIMarker
METHOD System.Void TheForestOfLove.MapUIMarker::HideAll() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.MapUIMarker::animator
IL_0006: ldarg.0
IL_0007: ldfld System.String TheForestOfLove.MapUIMarker::ANIMATOR_BOOL_SELECTED
IL_000c: ldc.i4.0
IL_000d: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0012: ldarg.0
IL_0013: ldfld UnityEngine.GameObject TheForestOfLove.MapUIMarker::normal
IL_0018: ldc.i4.0
IL_0019: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_001e: ldarg.0
IL_001f: ldfld UnityEngine.GameObject TheForestOfLove.MapUIMarker::selected
IL_0024: ldc.i4.0
IL_0025: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_002a: ret
METHOD System.Void TheForestOfLove.MapUIMarker::ShowSelected(UnityEngine.Vector2) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.MapUIMarker::HideAll()
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.GameObject TheForestOfLove.MapUIMarker::selected
IL_000c: ldc.i4.1
IL_000d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0012: ldarg.0
IL_0013: ldfld UnityEngine.RectTransform TheForestOfLove.MapUIMarker::rectTransform
IL_0018: ldarg.1
IL_0019: callvirt System.Void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)
IL_001e: ldarg.0
IL_001f: ldfld UnityEngine.Animator TheForestOfLove.MapUIMarker::animator
IL_0024: ldarg.0
IL_0025: ldfld System.String TheForestOfLove.MapUIMarker::ANIMATOR_BOOL_SELECTED
IL_002a: ldc.i4.1
IL_002b: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0030: ret
