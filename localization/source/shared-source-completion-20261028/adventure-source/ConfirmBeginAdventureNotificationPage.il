TYPE TheForestOfLove.ConfirmBeginAdventureNotificationPage
METHOD System.Void TheForestOfLove.ConfirmBeginAdventureNotificationPage::SetTitle(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void TheForestOfLove.ConfirmBeginAdventureNotificationPage::set_Title(System.String)
IL_0007: ldarg.0
IL_0008: ldfld UnityEngine.Transform TheForestOfLove.ConfirmBeginAdventureNotificationPage::titleRootContainer
IL_000d: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TMP_Text>()
IL_0012: stloc.0
IL_0013: ldc.i4.0
IL_0014: stloc.1
IL_0015: br.s IL_0024
IL_0017: ldloc.0
IL_0018: ldloc.1
IL_0019: ldelem.ref
IL_001a: ldarg.1
IL_001b: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0020: ldloc.1
IL_0021: ldc.i4.1
IL_0022: add
IL_0023: stloc.1
IL_0024: ldloc.1
IL_0025: ldloc.0
IL_0026: ldlen
IL_0027: conv.i4
IL_0028: blt.s IL_0017
IL_002a: ret
METHOD System.Void TheForestOfLove.ConfirmBeginAdventureNotificationPage::SetBody(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void TheForestOfLove.ConfirmBeginAdventureNotificationPage::set_Body(System.String)
IL_0007: ldarg.0
IL_0008: ldfld UnityEngine.Transform TheForestOfLove.ConfirmBeginAdventureNotificationPage::bodyRootContainer
IL_000d: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TMP_Text>()
IL_0012: stloc.0
IL_0013: ldc.i4.0
IL_0014: stloc.1
IL_0015: br.s IL_0024
IL_0017: ldloc.0
IL_0018: ldloc.1
IL_0019: ldelem.ref
IL_001a: ldarg.1
IL_001b: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0020: ldloc.1
IL_0021: ldc.i4.1
IL_0022: add
IL_0023: stloc.1
IL_0024: ldloc.1
IL_0025: ldloc.0
IL_0026: ldlen
IL_0027: conv.i4
IL_0028: blt.s IL_0017
IL_002a: ret
