TYPE TheForestOfLove.GossipUI
METHOD System.Void TheForestOfLove.GossipUI::UpdateTooltipText(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.GossipUI::tooltipContainer
IL_0006: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_000b: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_0010: stloc.0
IL_0011: ldc.i4.0
IL_0012: stloc.1
IL_0013: br.s IL_0022
IL_0015: ldloc.0
IL_0016: ldloc.1
IL_0017: ldelem.ref
IL_0018: ldarg.1
IL_0019: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_001e: ldloc.1
IL_001f: ldc.i4.1
IL_0020: add
IL_0021: stloc.1
IL_0022: ldloc.1
IL_0023: ldloc.0
IL_0024: ldlen
IL_0025: conv.i4
IL_0026: blt.s IL_0015
IL_0028: ret
