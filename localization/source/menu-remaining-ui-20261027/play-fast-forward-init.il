TYPE TheForestOfLove.PlayMenu
METHOD System.Void TheForestOfLove.PlayMenu::InitFastForwardDestinationUI() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.2
IL_0002: br.s IL_0026
IL_0004: ldarg.0
IL_0005: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_000a: ldloc.2
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinations
IL_0011: ldloc.2
IL_0012: ldelem.ref
IL_0013: stelem.ref
IL_0014: ldarg.0
IL_0015: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_001a: ldloc.2
IL_001b: ldelem.ref
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0022: ldloc.2
IL_0023: ldc.i4.1
IL_0024: add
IL_0025: stloc.2
IL_0026: ldloc.2
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinations
IL_002d: ldlen
IL_002e: conv.i4
IL_002f: blt.s IL_0004
IL_0031: ldarg.0
IL_0032: ldarg.0
IL_0033: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAbove
IL_0038: stfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAboveParallel
IL_003d: ldarg.0
IL_003e: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsAboveParallel
IL_0043: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0048: ldc.i4.1
IL_0049: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_004e: ldarg.0
IL_004f: ldarg.0
IL_0050: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelow
IL_0055: stfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelowParallel
IL_005a: ldarg.0
IL_005b: ldfld UnityEngine.CanvasGroup TheForestOfLove.PlayMenu::fastForwardDestinationMoreOptionsBelowParallel
IL_0060: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0065: ldc.i4.1
IL_0066: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_006b: ldarg.0
IL_006c: ldfld UnityEngine.GameObject TheForestOfLove.PlayMenu::fastForwardControls
IL_0071: ldc.i4.1
IL_0072: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0077: ldarg.0
IL_0078: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.PlayMenu>()
IL_007d: stloc.0
IL_007e: ldloc.0
IL_007f: ldfld UnityEngine.UI.Selectable TheForestOfLove.PlayMenu::startButton
IL_0084: callvirt UnityEngine.UI.Navigation UnityEngine.UI.Selectable::get_navigation()
IL_0089: stloc.1
IL_008a: ldloca.s V_1
IL_008c: ldloc.0
IL_008d: ldfld UnityEngine.GameObject TheForestOfLove.PlayMenu::fastForwardDestination
IL_0092: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.UI.Selectable>()
IL_0097: call System.Void UnityEngine.UI.Navigation::set_selectOnDown(UnityEngine.UI.Selectable)
IL_009c: ldloc.0
IL_009d: ldfld UnityEngine.UI.Selectable TheForestOfLove.PlayMenu::startButton
IL_00a2: ldloc.1
IL_00a3: callvirt System.Void UnityEngine.UI.Selectable::set_navigation(UnityEngine.UI.Navigation)
IL_00a8: ldloc.0
IL_00a9: ldfld UnityEngine.UI.Button TheForestOfLove.PlayMenu::backButton
IL_00ae: callvirt UnityEngine.UI.Navigation UnityEngine.UI.Selectable::get_navigation()
IL_00b3: stloc.1
IL_00b4: ldloca.s V_1
IL_00b6: ldloc.0
IL_00b7: ldfld UnityEngine.GameObject TheForestOfLove.PlayMenu::fastForwardDestination
IL_00bc: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.UI.Selectable>()
IL_00c1: call System.Void UnityEngine.UI.Navigation::set_selectOnUp(UnityEngine.UI.Selectable)
IL_00c6: ldloc.0
IL_00c7: ldfld UnityEngine.UI.Button TheForestOfLove.PlayMenu::backButton
IL_00cc: ldloc.1
IL_00cd: callvirt System.Void UnityEngine.UI.Selectable::set_navigation(UnityEngine.UI.Navigation)
IL_00d2: ret
