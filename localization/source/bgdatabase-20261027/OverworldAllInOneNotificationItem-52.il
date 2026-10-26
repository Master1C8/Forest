TYPE TheForestOfLove.OverworldAllInOneNotificationItem
METHOD System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureItemFoundNotification(UnityEngine.Sprite,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.OverworldAllInOneNotificationItem::itemNotificationRoot
IL_0006: ldc.i4.1
IL_0007: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.GameObject TheForestOfLove.OverworldAllInOneNotificationItem::gossipNotificationRoot
IL_0012: ldc.i4.0
IL_0013: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0018: ldarg.0
IL_0019: call !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.UI.Image>()
IL_001e: stloc.0
IL_001f: ldc.i4.0
IL_0020: stloc.1
IL_0021: br.s IL_0036
IL_0023: ldloc.0
IL_0024: ldloc.1
IL_0025: ldelem.ref
IL_0026: dup
IL_0027: ldarg.1
IL_0028: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_002d: callvirt System.Void UnityEngine.UI.Graphic::SetNativeSize()
IL_0032: ldloc.1
IL_0033: ldc.i4.1
IL_0034: add
IL_0035: stloc.1
IL_0036: ldloc.1
IL_0037: ldloc.0
IL_0038: ldlen
IL_0039: conv.i4
IL_003a: blt.s IL_0023
IL_003c: ldarg.0
IL_003d: call !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_0042: stloc.2
IL_0043: ldc.i4.0
IL_0044: stloc.1
IL_0045: br.s IL_005e
IL_0047: ldloc.2
IL_0048: ldloc.1
IL_0049: ldelem.ref
IL_004a: ldstr "Item found:
"
IL_004f: ldarg.2
IL_0050: call System.String System.String::Concat(System.String,System.String)
IL_0055: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_005a: ldloc.1
IL_005b: ldc.i4.1
IL_005c: add
IL_005d: stloc.1
IL_005e: ldloc.1
IL_005f: ldloc.2
IL_0060: ldlen
IL_0061: conv.i4
IL_0062: blt.s IL_0047
IL_0064: ret
METHOD System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureItemGetNotification(UnityEngine.Sprite,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.OverworldAllInOneNotificationItem::itemNotificationRoot
IL_0006: ldc.i4.1
IL_0007: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.GameObject TheForestOfLove.OverworldAllInOneNotificationItem::gossipNotificationRoot
IL_0012: ldc.i4.0
IL_0013: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0018: ldarg.0
IL_0019: call !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.UI.Image>()
IL_001e: stloc.0
IL_001f: ldc.i4.0
IL_0020: stloc.1
IL_0021: br.s IL_0036
IL_0023: ldloc.0
IL_0024: ldloc.1
IL_0025: ldelem.ref
IL_0026: dup
IL_0027: ldarg.1
IL_0028: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_002d: callvirt System.Void UnityEngine.UI.Graphic::SetNativeSize()
IL_0032: ldloc.1
IL_0033: ldc.i4.1
IL_0034: add
IL_0035: stloc.1
IL_0036: ldloc.1
IL_0037: ldloc.0
IL_0038: ldlen
IL_0039: conv.i4
IL_003a: blt.s IL_0023
IL_003c: ldarg.0
IL_003d: call !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_0042: stloc.2
IL_0043: ldc.i4.0
IL_0044: stloc.1
IL_0045: br.s IL_005e
IL_0047: ldloc.2
IL_0048: ldloc.1
IL_0049: ldelem.ref
IL_004a: ldstr "Item received:
"
IL_004f: ldarg.2
IL_0050: call System.String System.String::Concat(System.String,System.String)
IL_0055: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_005a: ldloc.1
IL_005b: ldc.i4.1
IL_005c: add
IL_005d: stloc.1
IL_005e: ldloc.1
IL_005f: ldloc.2
IL_0060: ldlen
IL_0061: conv.i4
IL_0062: blt.s IL_0047
IL_0064: ret
METHOD System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureItemLostNotification(UnityEngine.Sprite,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.OverworldAllInOneNotificationItem::itemNotificationRoot
IL_0006: ldc.i4.1
IL_0007: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.GameObject TheForestOfLove.OverworldAllInOneNotificationItem::gossipNotificationRoot
IL_0012: ldc.i4.0
IL_0013: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0018: ldarg.0
IL_0019: call !!0[] UnityEngine.Component::GetComponentsInChildren<UnityEngine.UI.Image>()
IL_001e: stloc.0
IL_001f: ldc.i4.0
IL_0020: stloc.1
IL_0021: br.s IL_0036
IL_0023: ldloc.0
IL_0024: ldloc.1
IL_0025: ldelem.ref
IL_0026: dup
IL_0027: ldarg.1
IL_0028: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_002d: callvirt System.Void UnityEngine.UI.Graphic::SetNativeSize()
IL_0032: ldloc.1
IL_0033: ldc.i4.1
IL_0034: add
IL_0035: stloc.1
IL_0036: ldloc.1
IL_0037: ldloc.0
IL_0038: ldlen
IL_0039: conv.i4
IL_003a: blt.s IL_0023
IL_003c: ldarg.0
IL_003d: call !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_0042: stloc.2
IL_0043: ldc.i4.0
IL_0044: stloc.1
IL_0045: br.s IL_005e
IL_0047: ldloc.2
IL_0048: ldloc.1
IL_0049: ldelem.ref
IL_004a: ldstr "Item delivered:
"
IL_004f: ldarg.2
IL_0050: call System.String System.String::Concat(System.String,System.String)
IL_0055: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_005a: ldloc.1
IL_005b: ldc.i4.1
IL_005c: add
IL_005d: stloc.1
IL_005e: ldloc.1
IL_005f: ldloc.2
IL_0060: ldlen
IL_0061: conv.i4
IL_0062: blt.s IL_0047
IL_0064: ret
