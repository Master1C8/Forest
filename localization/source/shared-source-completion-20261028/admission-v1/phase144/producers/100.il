TYPE TheForestOfLove.InteractionUiStatusIcon
METHOD System.Void TheForestOfLove.InteractionUiStatusIcon::Hide() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: call System.Void TheForestOfLove.InteractionUiStatusIcon::Hide(System.Boolean)
IL_0007: ret
METHOD System.Void TheForestOfLove.InteractionUiStatusIcon::Hide(System.Boolean) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.InteractionUiStatusIcon::get_isVisible()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: call System.Void TheForestOfLove.InteractionUiStatusIcon::set_isVisible(System.Boolean)
IL_0010: ldarg.0
IL_0011: call System.Void TheForestOfLove.InteractionUiStatusIcon::ResetTriggers()
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.InteractionUiStatusIcon::iconAnimator
IL_001c: ldarg.1
IL_001d: brtrue.s IL_0026
IL_001f: ldstr "hide"
IL_0024: br.s IL_002b
IL_0026: ldstr "hide_immediate"
IL_002b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0030: ldarg.0
IL_0031: ldfld UnityEngine.Animator TheForestOfLove.InteractionUiStatusIcon::iconFxAnimator
IL_0036: ldarg.1
IL_0037: brtrue.s IL_0040
IL_0039: ldstr "hide"
IL_003e: br.s IL_0045
IL_0040: ldstr "hide_immediate"
IL_0045: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_004a: ldarg.0
IL_004b: ldc.i4.0
IL_004c: stfld System.Boolean TheForestOfLove.InteractionUiStatusIcon::isPlayerClose
IL_0051: ret
