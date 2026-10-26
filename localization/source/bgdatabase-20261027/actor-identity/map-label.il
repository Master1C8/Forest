TYPE TheForestOfLove.MapUI
METHOD System.Void TheForestOfLove.MapUI::SetSelectionLabelText(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.MapUI::selectionLabelContainer
IL_0006: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_000b: stloc.0
IL_000c: ldc.i4.0
IL_000d: stloc.1
IL_000e: br.s IL_001d
IL_0010: ldloc.0
IL_0011: ldloc.1
IL_0012: ldelem.ref
IL_0013: ldarg.1
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
IL_0023: ldarg.0
IL_0024: ldfld UnityEngine.GameObject TheForestOfLove.MapUI::selectionLabelContainer
IL_0029: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_002e: stloc.2
IL_002f: ldc.i4.0
IL_0030: stloc.1
IL_0031: br.s IL_0040
IL_0033: ldloc.2
IL_0034: ldloc.1
IL_0035: ldelem.ref
IL_0036: ldarg.1
IL_0037: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_003c: ldloc.1
IL_003d: ldc.i4.1
IL_003e: add
IL_003f: stloc.1
IL_0040: ldloc.1
IL_0041: ldloc.2
IL_0042: ldlen
IL_0043: conv.i4
IL_0044: blt.s IL_0033
IL_0046: ret
