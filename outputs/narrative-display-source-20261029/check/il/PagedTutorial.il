TYPE TheForestOfLove.PagedTutorial
METHOD System.Void TheForestOfLove.PagedTutorial::Awake() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Int32 TheForestOfLove.PagedTutorial::currentPage
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.PagedTutorial::UpdatePageVisibility()
IL_000d: ldarg.0
IL_000e: ldc.i4.0
IL_000f: call System.Void TheForestOfLove.PagedTutorial::set_finishedTutorial(System.Boolean)
IL_0014: ldarg.0
IL_0015: ldc.i4.1
IL_0016: stfld System.Boolean TheForestOfLove.PagedTutorial::allowNavigation
IL_001b: ret
METHOD System.Void TheForestOfLove.PagedTutorial::FinishTutorial() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.PagedTutorial::set_finishedTutorial(System.Boolean)
IL_0007: ldarg.0
IL_0008: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PagedTutorial::onTutorialFinished
IL_000d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0012: ret
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
TYPE TheForestOfLove.PagedTutorial
METHOD System.Void TheForestOfLove.PagedTutorial::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.PagedTutorial::get_finishedTutorial()
IL_0006: brtrue.s IL_0010
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean TheForestOfLove.PagedTutorial::allowNavigation
IL_000e: brtrue.s IL_0011
IL_0010: ret
IL_0011: call System.Boolean TheForestOfLove.InputHelper::get_IsRightBumperDown()
IL_0016: brfalse.s IL_0033
IL_0018: ldc.i4.s 100
IL_001a: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_001f: ldarg.0
IL_0020: ldarg.0
IL_0021: ldarg.0
IL_0022: ldfld System.Int32 TheForestOfLove.PagedTutorial::currentPage
IL_0027: call System.Int32 TheForestOfLove.PagedTutorial::GetNextPage(System.Int32)
IL_002c: stfld System.Int32 TheForestOfLove.PagedTutorial::currentPage
IL_0031: br.s IL_0053
IL_0033: call System.Boolean TheForestOfLove.InputHelper::get_IsLeftBumperDown()
IL_0038: brfalse.s IL_0053
IL_003a: ldc.i4.s 100
IL_003c: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0041: ldarg.0
IL_0042: ldarg.0
IL_0043: ldarg.0
IL_0044: ldfld System.Int32 TheForestOfLove.PagedTutorial::currentPage
IL_0049: call System.Int32 TheForestOfLove.PagedTutorial::GetPreviousPage(System.Int32)
IL_004e: stfld System.Int32 TheForestOfLove.PagedTutorial::currentPage
IL_0053: call System.Boolean TheForestOfLove.InputHelper::get_IsSubmitButtonDown()
IL_0058: brfalse.s IL_00a2
IL_005a: ldarg.0
IL_005b: ldfld System.Int32 TheForestOfLove.PagedTutorial::currentPage
IL_0060: ldarg.0
IL_0061: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.PagedTutorial::pages
IL_0066: ldlen
IL_0067: conv.i4
IL_0068: ldc.i4.1
IL_0069: sub
IL_006a: bne.un.s IL_007e
IL_006c: ldc.i4 200
IL_0071: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0076: ldarg.0
IL_0077: call System.Void TheForestOfLove.PagedTutorial::FinishTutorial()
IL_007c: br.s IL_0097
IL_007e: ldc.i4.s 100
IL_0080: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0085: ldarg.0
IL_0086: ldarg.0
IL_0087: ldarg.0
IL_0088: ldfld System.Int32 TheForestOfLove.PagedTutorial::currentPage
IL_008d: call System.Int32 TheForestOfLove.PagedTutorial::GetNextPage(System.Int32)
IL_0092: stfld System.Int32 TheForestOfLove.PagedTutorial::currentPage
IL_0097: ldarg.0
IL_0098: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PagedTutorial::onSubmit
IL_009d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00a2: ldarg.0
IL_00a3: call System.Void TheForestOfLove.PagedTutorial::UpdatePageVisibility()
IL_00a8: ret
METHOD System.Int32 TheForestOfLove.PagedTutorial::GetNextPage(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldc.i4.1
IL_0002: add
IL_0003: ldarg.0
IL_0004: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.PagedTutorial::pages
IL_0009: ldlen
IL_000a: conv.i4
IL_000b: rem
IL_000c: ret
METHOD System.Int32 TheForestOfLove.PagedTutorial::GetPreviousPage(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldc.i4.0
IL_0002: bgt.s IL_000f
IL_0004: ldarg.0
IL_0005: ldfld UnityEngine.CanvasGroup[] TheForestOfLove.PagedTutorial::pages
IL_000a: ldlen
IL_000b: conv.i4
IL_000c: ldc.i4.1
IL_000d: sub
IL_000e: ret
IL_000f: ldarg.1
IL_0010: ldc.i4.1
IL_0011: sub
IL_0012: ret
