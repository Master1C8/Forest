TYPE TheForestOfLove.CritterLog/NamedResident
METHOD System.Void TheForestOfLove.CritterLog/NamedResident::SetStatus(TheForestOfLove.CritterLog/NamedResidentStatus) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiSelected
IL_0006: ldc.i4.0
IL_0007: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiEnabled
IL_0012: ldc.i4.0
IL_0013: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiDisabled
IL_001e: ldc.i4.0
IL_001f: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0024: ldarg.1
IL_0025: switch IL_003b,IL_0096,IL_00d1
IL_0036: br IL_010a
IL_003b: ldarg.0
IL_003c: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiSelected
IL_0041: ldc.i4.1
IL_0042: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0047: ldarg.0
IL_0048: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiSelected
IL_004d: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_0052: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_0057: stloc.0
IL_0058: ldc.i4.0
IL_0059: stloc.1
IL_005a: br.s IL_006e
IL_005c: ldloc.0
IL_005d: ldloc.1
IL_005e: ldelem.ref
IL_005f: ldarg.0
IL_0060: call System.String TheForestOfLove.CritterLog/NamedResident::get_text()
IL_0065: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_006a: ldloc.1
IL_006b: ldc.i4.1
IL_006c: add
IL_006d: stloc.1
IL_006e: ldloc.1
IL_006f: ldloc.0
IL_0070: ldlen
IL_0071: conv.i4
IL_0072: blt.s IL_005c
IL_0074: ldarg.0
IL_0075: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiSelected
IL_007a: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_007f: dup
IL_0080: ldstr "select"
IL_0085: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_008a: ldstr "select"
IL_008f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0094: br.s IL_010a
IL_0096: ldarg.0
IL_0097: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiEnabled
IL_009c: ldc.i4.1
IL_009d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00a2: ldarg.0
IL_00a3: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiEnabled
IL_00a8: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_00ad: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_00b2: stloc.0
IL_00b3: ldc.i4.0
IL_00b4: stloc.1
IL_00b5: br.s IL_00c9
IL_00b7: ldloc.0
IL_00b8: ldloc.1
IL_00b9: ldelem.ref
IL_00ba: ldarg.0
IL_00bb: call System.String TheForestOfLove.CritterLog/NamedResident::get_text()
IL_00c0: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_00c5: ldloc.1
IL_00c6: ldc.i4.1
IL_00c7: add
IL_00c8: stloc.1
IL_00c9: ldloc.1
IL_00ca: ldloc.0
IL_00cb: ldlen
IL_00cc: conv.i4
IL_00cd: blt.s IL_00b7
IL_00cf: br.s IL_010a
IL_00d1: ldarg.0
IL_00d2: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiDisabled
IL_00d7: ldc.i4.1
IL_00d8: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00dd: ldarg.0
IL_00de: ldfld UnityEngine.GameObject TheForestOfLove.CritterLog/NamedResident::uiDisabled
IL_00e3: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_00e8: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<UnityEngine.UI.Text>()
IL_00ed: stloc.0
IL_00ee: ldc.i4.0
IL_00ef: stloc.1
IL_00f0: br.s IL_0104
IL_00f2: ldloc.0
IL_00f3: ldloc.1
IL_00f4: ldelem.ref
IL_00f5: ldarg.0
IL_00f6: call System.String TheForestOfLove.CritterLog/NamedResident::get_text()
IL_00fb: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0100: ldloc.1
IL_0101: ldc.i4.1
IL_0102: add
IL_0103: stloc.1
IL_0104: ldloc.1
IL_0105: ldloc.0
IL_0106: ldlen
IL_0107: conv.i4
IL_0108: blt.s IL_00f2
IL_010a: ldarg.0
IL_010b: ldarg.1
IL_010c: call System.Void TheForestOfLove.CritterLog/NamedResident::set_status(TheForestOfLove.CritterLog/NamedResidentStatus)
IL_0111: ret
