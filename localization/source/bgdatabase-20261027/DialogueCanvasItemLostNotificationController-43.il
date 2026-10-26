TYPE TheForestOfLove.DialogueCanvasItemLostNotificationController
METHOD System.Void TheForestOfLove.DialogueCanvasItemLostNotificationController::TakeItem(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call !!0[] UnityEngine.Component::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_0006: stloc.0
IL_0007: ldc.i4.0
IL_0008: stloc.1
IL_0009: br.s IL_0022
IL_000b: ldloc.0
IL_000c: ldloc.1
IL_000d: ldelem.ref
IL_000e: ldstr "Item delivered: "
IL_0013: ldarg.1
IL_0014: call System.String System.String::Concat(System.String,System.String)
IL_0019: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_001e: ldloc.1
IL_001f: ldc.i4.1
IL_0020: add
IL_0021: stloc.1
IL_0022: ldloc.1
IL_0023: ldloc.0
IL_0024: ldlen
IL_0025: conv.i4
IL_0026: blt.s IL_000b
IL_0028: ldarg.0
IL_0029: ldfld UnityEngine.Animator TheForestOfLove.DialogueCanvasItemLostNotificationController::itemLostNotificationAnimator
IL_002e: ldstr "show"
IL_0033: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0038: ldarg.0
IL_0039: ldc.i4.1
IL_003a: stfld System.Boolean TheForestOfLove.DialogueCanvasItemLostNotificationController::showingItemLostNotification
IL_003f: ret
