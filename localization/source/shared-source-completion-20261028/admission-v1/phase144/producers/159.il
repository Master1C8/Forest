TYPE viperOSK.OSK_Cursor
METHOD System.Void viperOSK.OSK_Cursor::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call !!0 UnityEngine.Component::GetComponentInParent<viperOSK.OSK_Receiver>()
IL_0007: stfld viperOSK.OSK_Receiver viperOSK.OSK_Cursor::input
IL_000c: ldarg.0
IL_000d: ldarg.0
IL_000e: call !!0 UnityEngine.Component::GetComponentInParent<TMPro.TMP_Text>()
IL_0013: stfld TMPro.TMP_Text viperOSK.OSK_Cursor::textComponent
IL_0018: ldarg.0
IL_0019: ldarg.0
IL_001a: call !!0 UnityEngine.Component::GetComponent<UnityEngine.SpriteRenderer>()
IL_001f: stfld UnityEngine.SpriteRenderer viperOSK.OSK_Cursor::cursorImg
IL_0024: ldarg.0
IL_0025: ldfld viperOSK.OSK_Receiver viperOSK.OSK_Cursor::input
IL_002a: ldnull
IL_002b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0030: brfalse.s IL_003c
IL_0032: ldstr "viperOSK OSK_Cursor object must be the child of a OSK_UI_InputReceiver object to work"
IL_0037: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_003c: ldarg.0
IL_003d: ldfld TMPro.TMP_Text viperOSK.OSK_Cursor::textComponent
IL_0042: ldnull
IL_0043: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0048: brfalse.s IL_0054
IL_004a: ldstr "viperOSK OSK_Cursor object must be the child of a TextMeshPro object to work"
IL_004f: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0054: ldarg.0
IL_0055: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Cursor::cursorImg
IL_005a: ldnull
IL_005b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0060: brfalse.s IL_006c
IL_0062: ldstr "viperOSK OSK_Cursor object must have a SpriteRenderer component to work"
IL_0067: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_006c: ldarg.0
IL_006d: ldarg.0
IL_006e: ldfld TMPro.TMP_Text viperOSK.OSK_Cursor::textComponent
IL_0073: callvirt UnityEngine.RectTransform TMPro.TMP_Text::get_rectTransform()
IL_0078: callvirt UnityEngine.Rect UnityEngine.RectTransform::get_rect()
IL_007d: stloc.0
IL_007e: ldloca.s V_0
IL_0080: call System.Single UnityEngine.Rect::get_xMin()
IL_0085: ldarg.0
IL_0086: ldfld UnityEngine.SpriteRenderer viperOSK.OSK_Cursor::cursorImg
IL_008b: callvirt UnityEngine.Bounds UnityEngine.Renderer::get_bounds()
IL_0090: stloc.1
IL_0091: ldloca.s V_1
IL_0093: call UnityEngine.Vector3 UnityEngine.Bounds::get_extents()
IL_0098: ldfld System.Single UnityEngine.Vector3::x
IL_009d: add
IL_009e: stfld System.Single viperOSK.OSK_Cursor::inputLeft
IL_00a3: ldarg.0
IL_00a4: ldstr "Blink"
IL_00a9: ldc.r4 0.5
IL_00ae: ldarg.0
IL_00af: ldfld System.Single viperOSK.OSK_Cursor::bps
IL_00b4: call System.Void UnityEngine.MonoBehaviour::InvokeRepeating(System.String,System.Single,System.Single)
IL_00b9: ret
