TYPE viperOSK.OSK_Cursor_TFOL
METHOD System.Void viperOSK.OSK_Cursor_TFOL::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean viperOSK.OSK_Cursor_TFOL::debugSkipColorReassignment
IL_0006: brtrue.s IL_002c
IL_0008: ldarg.0
IL_0009: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Cursor_TFOL::cursorSpriteRenderer
IL_000e: ldc.r4 0.26953125
IL_0013: ldc.r4 0.26953125
IL_0018: ldc.r4 0.26953125
IL_001d: ldc.r4 1
IL_0022: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single,System.Single)
IL_0027: callvirt System.Void UnityEngine.SpriteRenderer::set_color(UnityEngine.Color)
IL_002c: ldarg.0
IL_002d: ldarg.0
IL_002e: call !!0 UnityEngine.Component::GetComponentInParent<viperOSK.OSK_Receiver>()
IL_0033: stfld viperOSK.OSK_Receiver viperOSK.OSK_Cursor_TFOL::input
IL_0038: ldarg.0
IL_0039: ldarg.0
IL_003a: call !!0 UnityEngine.Component::GetComponentInParent<TMPro.TMP_Text>()
IL_003f: stfld TMPro.TMP_Text viperOSK.OSK_Cursor_TFOL::textComponent
IL_0044: ldarg.0
IL_0045: ldarg.0
IL_0046: call !!0 UnityEngine.Component::GetComponent<UnityEngine.SpriteRenderer>()
IL_004b: stfld UnityEngine.SpriteRenderer viperOSK.OSK_Cursor_TFOL::cursorImg
IL_0050: ldarg.0
IL_0051: ldfld viperOSK.OSK_Receiver viperOSK.OSK_Cursor_TFOL::input
IL_0056: ldnull
IL_0057: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_005c: brfalse.s IL_0068
IL_005e: ldstr "viperOSK OSK_Cursor object must be the child of a OSK_UI_InputReceiver object to work"
IL_0063: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0068: ldarg.0
IL_0069: ldfld TMPro.TMP_InputField viperOSK.OSK_Cursor_TFOL::inputComponent
IL_006e: ldnull
IL_006f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0074: brfalse.s IL_008e
IL_0076: ldarg.0
IL_0077: ldfld TMPro.TMP_Text viperOSK.OSK_Cursor_TFOL::textComponent
IL_007c: ldnull
IL_007d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0082: brfalse.s IL_008e
IL_0084: ldstr "viperOSK OSK_Cursor object must be the child of a TextMeshPro object to work"
IL_0089: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_008e: ldarg.0
IL_008f: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Cursor_TFOL::cursorImg
IL_0094: ldnull
IL_0095: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_009a: brfalse.s IL_00a6
IL_009c: ldstr "viperOSK OSK_Cursor object must have a SpriteRenderer component to work"
IL_00a1: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00a6: ldarg.0
IL_00a7: ldfld TMPro.TMP_InputField viperOSK.OSK_Cursor_TFOL::inputComponent
IL_00ac: ldnull
IL_00ad: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00b2: brfalse.s IL_0103
IL_00b4: ldarg.0
IL_00b5: ldarg.0
IL_00b6: ldfld TMPro.TMP_Text viperOSK.OSK_Cursor_TFOL::textComponent
IL_00bb: callvirt UnityEngine.RectTransform TMPro.TMP_Text::get_rectTransform()
IL_00c0: callvirt UnityEngine.Rect UnityEngine.RectTransform::get_rect()
IL_00c5: stloc.0
IL_00c6: ldloca.s V_0
IL_00c8: call System.Single UnityEngine.Rect::get_xMin()
IL_00cd: ldarg.0
IL_00ce: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Cursor_TFOL::cursorImg
IL_00d3: callvirt UnityEngine.Bounds UnityEngine.Renderer::get_bounds()
IL_00d8: stloc.1
IL_00d9: ldloca.s V_1
IL_00db: call UnityEngine.Vector3 UnityEngine.Bounds::get_extents()
IL_00e0: ldfld System.Single UnityEngine.Vector3::x
IL_00e5: add
IL_00e6: stfld System.Single viperOSK.OSK_Cursor_TFOL::inputLeftX
IL_00eb: ldarg.0
IL_00ec: ldarg.0
IL_00ed: ldfld UnityEngine.RectTransform viperOSK.OSK_Cursor_TFOL::cursorRectTransform
IL_00f2: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_00f7: ldfld System.Single UnityEngine.Vector3::y
IL_00fc: stfld System.Single viperOSK.OSK_Cursor_TFOL::inputLeftY
IL_0101: br.s IL_014b
IL_0103: ldarg.0
IL_0104: ldarg.0
IL_0105: ldfld UnityEngine.RectTransform viperOSK.OSK_Cursor_TFOL::inputComponentRectTransform
IL_010a: callvirt UnityEngine.Rect UnityEngine.RectTransform::get_rect()
IL_010f: stloc.0
IL_0110: ldloca.s V_0
IL_0112: call System.Single UnityEngine.Rect::get_xMin()
IL_0117: ldarg.0
IL_0118: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Cursor_TFOL::cursorImg
IL_011d: callvirt UnityEngine.Bounds UnityEngine.Renderer::get_bounds()
IL_0122: stloc.1
IL_0123: ldloca.s V_1
IL_0125: call UnityEngine.Vector3 UnityEngine.Bounds::get_extents()
IL_012a: ldfld System.Single UnityEngine.Vector3::x
IL_012f: add
IL_0130: stfld System.Single viperOSK.OSK_Cursor_TFOL::inputLeftX
IL_0135: ldarg.0
IL_0136: ldarg.0
IL_0137: ldfld UnityEngine.RectTransform viperOSK.OSK_Cursor_TFOL::cursorRectTransform
IL_013c: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_0141: ldfld System.Single UnityEngine.Vector3::y
IL_0146: stfld System.Single viperOSK.OSK_Cursor_TFOL::inputLeftY
IL_014b: ldarg.0
IL_014c: ldstr "Blink"
IL_0151: ldc.r4 0.5
IL_0156: ldarg.0
IL_0157: ldfld System.Single viperOSK.OSK_Cursor_TFOL::bps
IL_015c: call System.Void UnityEngine.MonoBehaviour::InvokeRepeating(System.String,System.Single,System.Single)
IL_0161: ret
