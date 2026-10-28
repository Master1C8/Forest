TYPE TheForestOfLove.UI.AutomaticDepthSortUI
METHOD System.Void TheForestOfLove.UI.AutomaticDepthSortUI::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Canvas>()
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldnull
IL_0009: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000e: brfalse IL_00a8
IL_0013: ldloc.0
IL_0014: callvirt System.Boolean UnityEngine.Canvas::get_isRootCanvas()
IL_0019: brtrue.s IL_0022
IL_001b: ldloc.0
IL_001c: ldc.i4.1
IL_001d: callvirt System.Void UnityEngine.Canvas::set_overrideSorting(System.Boolean)
IL_0022: ldloc.0
IL_0023: ldarg.0
IL_0024: ldloc.0
IL_0025: callvirt System.Int32 UnityEngine.Canvas::get_sortingOrder()
IL_002a: call System.Int32 TheForestOfLove.UI.AutomaticDepthSortUI::GetSortingOrder(System.Int32)
IL_002f: ldarg.0
IL_0030: ldfld System.Int32 TheForestOfLove.UI.AutomaticDepthSortUI::additionalCustomOffset
IL_0035: add
IL_0036: callvirt System.Void UnityEngine.Canvas::set_sortingOrder(System.Int32)
IL_003b: ldarg.0
IL_003c: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Rendering.SortingGroup>()
IL_0041: stloc.s V_4
IL_0043: ldloc.s V_4
IL_0045: ldnull
IL_0046: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_004b: brfalse.s IL_0074
IL_004d: ldloc.s V_4
IL_004f: ldloc.0
IL_0050: callvirt System.Int32 UnityEngine.Canvas::get_sortingOrder()
IL_0055: callvirt System.Void UnityEngine.Rendering.SortingGroup::set_sortingOrder(System.Int32)
IL_005a: ldloc.0
IL_005b: ldloc.s V_4
IL_005d: callvirt System.Int32 UnityEngine.Rendering.SortingGroup::get_sortingLayerID()
IL_0062: callvirt System.Void UnityEngine.Canvas::set_sortingLayerID(System.Int32)
IL_0067: ldloc.0
IL_0068: ldloc.s V_4
IL_006a: callvirt System.String UnityEngine.Rendering.SortingGroup::get_sortingLayerName()
IL_006f: callvirt System.Void UnityEngine.Canvas::set_sortingLayerName(System.String)
IL_0074: ldloc.0
IL_0075: callvirt System.Boolean UnityEngine.Canvas::get_overrideSorting()
IL_007a: brfalse.s IL_00a8
IL_007c: ldloc.0
IL_007d: callvirt System.String UnityEngine.Canvas::get_sortingLayerName()
IL_0082: ldstr "<unknown layer>"
IL_0087: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_008c: brfalse.s IL_00a8
IL_008e: ldstr "Missing canvas sorting layer for object "
IL_0093: ldarg.0
IL_0094: call System.String UnityEngine.Object::get_name()
IL_0099: ldstr ", Unity broke this when upgrading editor versions. Assign a Sorting Group component or disable override sorting."
IL_009e: call System.String System.String::Concat(System.String,System.String,System.String)
IL_00a3: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00a8: ldarg.0
IL_00a9: call !!0 UnityEngine.Component::GetComponent<UnityEngine.ParticleSystemRenderer>()
IL_00ae: stloc.1
IL_00af: ldloc.1
IL_00b0: ldnull
IL_00b1: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00b6: brfalse.s IL_00d1
IL_00b8: ldloc.1
IL_00b9: ldarg.0
IL_00ba: ldloc.1
IL_00bb: callvirt System.Int32 UnityEngine.Renderer::get_sortingOrder()
IL_00c0: call System.Int32 TheForestOfLove.UI.AutomaticDepthSortUI::GetSortingOrder(System.Int32)
IL_00c5: ldarg.0
IL_00c6: ldfld System.Int32 TheForestOfLove.UI.AutomaticDepthSortUI::additionalCustomOffset
IL_00cb: add
IL_00cc: callvirt System.Void UnityEngine.Renderer::set_sortingOrder(System.Int32)
IL_00d1: ldarg.0
IL_00d2: call !!0 UnityEngine.Component::GetComponent<UnityEngine.SpriteRenderer>()
IL_00d7: stloc.2
IL_00d8: ldloc.2
IL_00d9: ldnull
IL_00da: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00df: brfalse.s IL_00fa
IL_00e1: ldloc.2
IL_00e2: ldarg.0
IL_00e3: ldloc.2
IL_00e4: callvirt System.Int32 UnityEngine.Renderer::get_sortingOrder()
IL_00e9: call System.Int32 TheForestOfLove.UI.AutomaticDepthSortUI::GetSortingOrder(System.Int32)
IL_00ee: ldarg.0
IL_00ef: ldfld System.Int32 TheForestOfLove.UI.AutomaticDepthSortUI::additionalCustomOffset
IL_00f4: add
IL_00f5: callvirt System.Void UnityEngine.Renderer::set_sortingOrder(System.Int32)
IL_00fa: ldarg.0
IL_00fb: call !!0 UnityEngine.Component::GetComponent<UnityEngine.MeshRenderer>()
IL_0100: stloc.3
IL_0101: ldloc.3
IL_0102: ldnull
IL_0103: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0108: brfalse.s IL_0123
IL_010a: ldloc.3
IL_010b: ldarg.0
IL_010c: ldloc.3
IL_010d: callvirt System.Int32 UnityEngine.Renderer::get_sortingOrder()
IL_0112: call System.Int32 TheForestOfLove.UI.AutomaticDepthSortUI::GetSortingOrder(System.Int32)
IL_0117: ldarg.0
IL_0118: ldfld System.Int32 TheForestOfLove.UI.AutomaticDepthSortUI::additionalCustomOffset
IL_011d: add
IL_011e: callvirt System.Void UnityEngine.Renderer::set_sortingOrder(System.Int32)
IL_0123: ret
