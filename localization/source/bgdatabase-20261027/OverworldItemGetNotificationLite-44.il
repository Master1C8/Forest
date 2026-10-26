TYPE TheForestOfLove.OverworldItemGetNotificationLite
METHOD System.Void TheForestOfLove.OverworldItemGetNotificationLite::ShowNotification(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean TheForestOfLove.PlankEE::playerFoundPlank
IL_0005: brfalse.s IL_0014
IL_0007: ldstr "Plank! <.<"
IL_000c: starg.s itemTitle
IL_000e: ldc.i4.0
IL_000f: stsfld System.Boolean TheForestOfLove.PlankEE::playerFoundPlank
IL_0014: ldarg.0
IL_0015: call !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_001a: stloc.0
IL_001b: ldc.i4.0
IL_001c: stloc.1
IL_001d: br.s IL_0036
IL_001f: ldloc.0
IL_0020: ldloc.1
IL_0021: ldelem.ref
IL_0022: ldstr "Item found: "
IL_0027: ldarg.1
IL_0028: call System.String System.String::Concat(System.String,System.String)
IL_002d: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0032: ldloc.1
IL_0033: ldc.i4.1
IL_0034: add
IL_0035: stloc.1
IL_0036: ldloc.1
IL_0037: ldloc.0
IL_0038: ldlen
IL_0039: conv.i4
IL_003a: blt.s IL_001f
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.Animator TheForestOfLove.OverworldItemGetNotificationLite::itemGetNotificationAnimator
IL_0042: ldstr "show"
IL_0047: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_004c: ldarg.0
IL_004d: ldc.i4.1
IL_004e: stfld System.Boolean TheForestOfLove.OverworldItemGetNotificationLite::showingNotification
IL_0053: ret
