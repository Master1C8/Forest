TYPE TheForestOfLove.CustomPortraitsUi
METHOD System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0006: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_000b: stloc.0
IL_000c: ldc.i4.0
IL_000d: stloc.1
IL_000e: br.s IL_001d
IL_0010: ldloc.0
IL_0011: ldloc.1
IL_0012: ldelem.ref
IL_0013: ldarg.2
IL_0014: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0019: ldloc.1
IL_001a: ldc.i4.1
IL_001b: add
IL_001c: stloc.1
IL_001d: ldloc.1
IL_001e: ldloc.0
IL_001f: ldlen
IL_0020: conv.i4
IL_0021: blt.s IL_0010
IL_0023: ret
