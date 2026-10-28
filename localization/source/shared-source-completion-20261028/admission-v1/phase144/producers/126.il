TYPE TheForestOfLove.PagedTutorial
METHOD System.Void TheForestOfLove.PagedTutorial::UpdatePageVisibility() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: br.s IL_003d
IL_0004: ldarg.0
IL_0005: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.PagedTutorial::pages
IL_000a: ldloc.0
IL_000b: ldelem.ref
IL_000c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0011: ldc.i4.1
IL_0012: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0017: ldarg.0
IL_0018: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.PagedTutorial::pages
IL_001d: ldloc.0
IL_001e: ldelem.ref
IL_001f: ldarg.0
IL_0020: ldfld System.Int32 TheForestOfLove.PagedTutorial::currentPage
IL_0025: ldloc.0
IL_0026: beq.s IL_002f
IL_0028: ldc.r4 0
IL_002d: br.s IL_0034
IL_002f: ldc.r4 1
IL_0034: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0039: ldloc.0
IL_003a: ldc.i4.1
IL_003b: add
IL_003c: stloc.0
IL_003d: ldloc.0
IL_003e: ldarg.0
IL_003f: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.PagedTutorial::pages
IL_0044: ldlen
IL_0045: conv.i4
IL_0046: blt.s IL_0004
IL_0048: ldc.i4.0
IL_0049: stloc.1
IL_004a: br.s IL_006f
IL_004c: ldarg.0
IL_004d: ldfld UnityEngine.Animator[] TheForestOfLove.PagedTutorial::nav
IL_0052: ldloc.1
IL_0053: ldelem.ref
IL_0054: ldstr "selected"
IL_0059: ldarg.0
IL_005a: ldfld System.Int32 TheForestOfLove.PagedTutorial::currentPage
IL_005f: ldloc.1
IL_0060: beq.s IL_0065
IL_0062: ldc.i4.0
IL_0063: br.s IL_0066
IL_0065: ldc.i4.1
IL_0066: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_006b: ldloc.1
IL_006c: ldc.i4.1
IL_006d: add
IL_006e: stloc.1
IL_006f: ldloc.1
IL_0070: ldarg.0
IL_0071: ldfld UnityEngine.Animator[] TheForestOfLove.PagedTutorial::nav
IL_0076: ldlen
IL_0077: conv.i4
IL_0078: blt.s IL_004c
IL_007a: ret
