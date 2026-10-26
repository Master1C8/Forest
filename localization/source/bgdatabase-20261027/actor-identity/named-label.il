TYPE TheForestOfLove.CritterLog/NamedResident
METHOD System.Void TheForestOfLove.CritterLog/NamedResident::SetText(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiSelected
IL_0006: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_000b: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_0010: stloc.0
IL_0011: ldc.i4.0
IL_0012: stloc.1
IL_0013: br.s IL_0022
IL_0015: ldloc.0
IL_0016: ldloc.1
IL_0017: ldelem.ref
IL_0018: ldarg.1
IL_0019: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_001e: ldloc.1
IL_001f: ldc.i4.1
IL_0020: add
IL_0021: stloc.1
IL_0022: ldloc.1
IL_0023: ldloc.0
IL_0024: ldlen
IL_0025: conv.i4
IL_0026: blt.s IL_0015
IL_0028: ldarg.0
IL_0029: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiEnabled
IL_002e: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_0033: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_0038: stloc.0
IL_0039: ldc.i4.0
IL_003a: stloc.1
IL_003b: br.s IL_004a
IL_003d: ldloc.0
IL_003e: ldloc.1
IL_003f: ldelem.ref
IL_0040: ldarg.1
IL_0041: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0046: ldloc.1
IL_0047: ldc.i4.1
IL_0048: add
IL_0049: stloc.1
IL_004a: ldloc.1
IL_004b: ldloc.0
IL_004c: ldlen
IL_004d: conv.i4
IL_004e: blt.s IL_003d
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiDisabled
IL_0056: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_005b: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_0060: stloc.0
IL_0061: ldc.i4.0
IL_0062: stloc.1
IL_0063: br.s IL_0072
IL_0065: ldloc.0
IL_0066: ldloc.1
IL_0067: ldelem.ref
IL_0068: ldarg.1
IL_0069: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_006e: ldloc.1
IL_006f: ldc.i4.1
IL_0070: add
IL_0071: stloc.1
IL_0072: ldloc.1
IL_0073: ldloc.0
IL_0074: ldlen
IL_0075: conv.i4
IL_0076: blt.s IL_0065
IL_0078: ldarg.0
IL_0079: ldarg.1
IL_007a: call System.Void TheForestOfLove.CritterLog/NamedResident::set_text(System.String)
IL_007f: ret
