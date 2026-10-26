TYPE TheForestOfLove.OverworldAllInOneNotificationItem
METHOD System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureGossipUnlockedNotification(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.OverworldAllInOneNotificationItem::itemNotificationRoot
IL_0006: ldc.i4.0
IL_0007: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.GameObject TheForestOfLove.OverworldAllInOneNotificationItem::gossipNotificationRoot
IL_0012: ldc.i4.1
IL_0013: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0018: ldarg.0
IL_0019: call !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_001e: stloc.0
IL_001f: ldc.i4.0
IL_0020: stloc.1
IL_0021: br.s IL_003a
IL_0023: ldloc.0
IL_0024: ldloc.1
IL_0025: ldelem.ref
IL_0026: ldstr "Gossip Unlocked
for "
IL_002b: ldarg.1
IL_002c: call System.String System.String::Concat(System.String,System.String)
IL_0031: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0036: ldloc.1
IL_0037: ldc.i4.1
IL_0038: add
IL_0039: stloc.1
IL_003a: ldloc.1
IL_003b: ldloc.0
IL_003c: ldlen
IL_003d: conv.i4
IL_003e: blt.s IL_0023
IL_0040: ret
METHOD System.Void TheForestOfLove.OverworldAllInOneNotificationItem::ConfigureBioUnlockedNotification(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.OverworldAllInOneNotificationItem::itemNotificationRoot
IL_0006: ldc.i4.0
IL_0007: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.GameObject TheForestOfLove.OverworldAllInOneNotificationItem::gossipNotificationRoot
IL_0012: ldc.i4.1
IL_0013: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0018: ldarg.0
IL_0019: call !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_001e: stloc.0
IL_001f: ldc.i4.0
IL_0020: stloc.1
IL_0021: br.s IL_003a
IL_0023: ldloc.0
IL_0024: ldloc.1
IL_0025: ldelem.ref
IL_0026: ldstr "Critter Log Unlocked
for "
IL_002b: ldarg.1
IL_002c: call System.String System.String::Concat(System.String,System.String)
IL_0031: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0036: ldloc.1
IL_0037: ldc.i4.1
IL_0038: add
IL_0039: stloc.1
IL_003a: ldloc.1
IL_003b: ldloc.0
IL_003c: ldlen
IL_003d: conv.i4
IL_003e: blt.s IL_0023
IL_0040: ret
