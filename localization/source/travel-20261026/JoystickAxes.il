TYPE Itelisoft.KOF.TheKingOfJoysticks
METHOD System.Void Itelisoft.KOF.TheKingOfJoysticks::TranslateCenter(UnityEngine.Vector2)
IL_0000: ldloca.s V_0
IL_0002: ldarg.1
IL_0003: ldfld System.Single UnityEngine.Vector2::x
IL_0008: ldarg.0
IL_0009: ldfld UnityEngine.UI.CanvasScaler Itelisoft.KOF.TheKingOfJoysticks::scaler
IL_000e: callvirt UnityEngine.Vector2 UnityEngine.UI.CanvasScaler::get_referenceResolution()
IL_0013: ldfld System.Single UnityEngine.Vector2::x
IL_0018: mul
IL_0019: call System.Int32 UnityEngine.Screen::get_width()
IL_001e: conv.r4
IL_001f: div
IL_0020: ldarg.0
IL_0021: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::startPosition
IL_0026: ldfld System.Single UnityEngine.Vector2::x
IL_002b: sub
IL_002c: ldarg.1
IL_002d: ldfld System.Single UnityEngine.Vector2::y
IL_0032: ldarg.0
IL_0033: ldfld UnityEngine.UI.CanvasScaler Itelisoft.KOF.TheKingOfJoysticks::scaler
IL_0038: callvirt UnityEngine.Vector2 UnityEngine.UI.CanvasScaler::get_referenceResolution()
IL_003d: ldfld System.Single UnityEngine.Vector2::y
IL_0042: mul
IL_0043: call System.Int32 UnityEngine.Screen::get_height()
IL_0048: conv.r4
IL_0049: div
IL_004a: ldarg.0
IL_004b: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::startPosition
IL_0050: ldfld System.Single UnityEngine.Vector2::y
IL_0055: sub
IL_0056: call System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_005b: ldloc.0
IL_005c: ldfld System.Single UnityEngine.Vector2::x
IL_0061: ldc.r4 2
IL_0066: call System.Single UnityEngine.Mathf::Pow(System.Single,System.Single)
IL_006b: ldloc.0
IL_006c: ldfld System.Single UnityEngine.Vector2::y
IL_0071: ldc.r4 2
IL_0076: call System.Single UnityEngine.Mathf::Pow(System.Single,System.Single)
IL_007b: add
IL_007c: call System.Single UnityEngine.Mathf::Sqrt(System.Single)
IL_0081: stloc.1
IL_0082: ldloca.s V_2
IL_0084: ldloc.0
IL_0085: ldfld System.Single UnityEngine.Vector2::x
IL_008a: ldloc.1
IL_008b: div
IL_008c: ldloc.0
IL_008d: ldfld System.Single UnityEngine.Vector2::y
IL_0092: ldloc.1
IL_0093: div
IL_0094: call System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_0099: ldarg.0
IL_009a: ldloc.2
IL_009b: call System.Single Itelisoft.KOF.JoystickCore::CalculateAngle(UnityEngine.Vector2)
IL_00a0: stloc.3
IL_00a1: ldarg.0
IL_00a2: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::D_padMode
IL_00a7: brfalse.s IL_00bf
IL_00a9: ldarg.0
IL_00aa: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::eightPositions
IL_00af: brfalse.s IL_00b9
IL_00b1: ldarg.0
IL_00b2: call System.Void Itelisoft.KOF.TheKingOfJoysticks::ChangeBorderBack8()
IL_00b7: br.s IL_00bf
IL_00b9: ldarg.0
IL_00ba: call System.Void Itelisoft.KOF.TheKingOfJoysticks::ChangeBorderBack4()
IL_00bf: ldarg.0
IL_00c0: ldloc.1
IL_00c1: stfld System.Single Itelisoft.KOF.TheKingOfJoysticks::mA
IL_00c6: ldarg.0
IL_00c7: ldloc.3
IL_00c8: stfld System.Single Itelisoft.KOF.TheKingOfJoysticks::angleDirection360
IL_00cd: ldarg.0
IL_00ce: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::distanceFromCenterPercentage
IL_00d3: ldc.r4 0.3
IL_00d8: bge.un.s IL_00f6
IL_00da: ldarg.0
IL_00db: ldarg.0
IL_00dc: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::angleDirection360
IL_00e1: ldc.i4.1
IL_00e2: call System.Void Itelisoft.KOF.JoystickCore::CalculateDirectionString8(System.Single,System.Boolean)
IL_00e7: ldarg.0
IL_00e8: ldarg.0
IL_00e9: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::angleDirection360
IL_00ee: ldc.i4.1
IL_00ef: call System.Void Itelisoft.KOF.JoystickCore::CalculateDirectionString4(System.Single,System.Boolean)
IL_00f4: br.s IL_0110
IL_00f6: ldarg.0
IL_00f7: ldarg.0
IL_00f8: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::angleDirection360
IL_00fd: ldc.i4.0
IL_00fe: call System.Void Itelisoft.KOF.JoystickCore::CalculateDirectionString8(System.Single,System.Boolean)
IL_0103: ldarg.0
IL_0104: ldarg.0
IL_0105: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::angleDirection360
IL_010a: ldc.i4.0
IL_010b: call System.Void Itelisoft.KOF.JoystickCore::CalculateDirectionString4(System.Single,System.Boolean)
IL_0110: ldarg.0
IL_0111: ldloc.2
IL_0112: stfld UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::vectorDirection360
IL_0117: ldarg.0
IL_0118: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::vectorDirection360
IL_011d: ldfld System.Single UnityEngine.Vector2::x
IL_0122: call System.Boolean System.Single::IsNaN(System.Single)
IL_0127: brtrue.s IL_013b
IL_0129: ldarg.0
IL_012a: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::vectorDirection360
IL_012f: ldfld System.Single UnityEngine.Vector2::y
IL_0134: call System.Boolean System.Single::IsNaN(System.Single)
IL_0139: brfalse.s IL_0146
IL_013b: ldarg.0
IL_013c: call UnityEngine.Vector2 UnityEngine.Vector2::get_zero()
IL_0141: stfld UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::vectorDirection360
IL_0146: ldarg.0
IL_0147: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::mA
IL_014c: stloc.s V_4
IL_014e: ldloc.s V_4
IL_0150: ldarg.0
IL_0151: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::distanceToCenter
IL_0156: ble.un.s IL_0166
IL_0158: ldloc.s V_4
IL_015a: ldloc.s V_4
IL_015c: ldarg.0
IL_015d: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::distanceToCenter
IL_0162: sub
IL_0163: sub
IL_0164: stloc.s V_4
IL_0166: ldarg.0
IL_0167: ldc.r4 1
IL_016c: ldarg.0
IL_016d: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::distanceToCenter
IL_0172: div
IL_0173: ldloc.s V_4
IL_0175: mul
IL_0176: stfld System.Single Itelisoft.KOF.TheKingOfJoysticks::distanceFromCenterPercentage
IL_017b: ldarg.0
IL_017c: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::mA
IL_0181: ldarg.0
IL_0182: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::distanceToCenter
IL_0187: ble.un.s IL_01ea
IL_0189: ldarg.0
IL_018a: ldfld UnityEngine.UI.Image Itelisoft.KOF.TheKingOfJoysticks::centerImage
IL_018f: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.RectTransform>()
IL_0194: ldloc.2
IL_0195: ldfld System.Single UnityEngine.Vector2::x
IL_019a: ldarg.0
IL_019b: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::distanceToCenter
IL_01a0: mul
IL_01a1: ldarg.0
IL_01a2: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::startPosition
IL_01a7: ldfld System.Single UnityEngine.Vector2::x
IL_01ac: add
IL_01ad: ldarg.0
IL_01ae: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::centerSize
IL_01b3: ldfld System.Single UnityEngine.Vector2::x
IL_01b8: sub
IL_01b9: ldloc.2
IL_01ba: ldfld System.Single UnityEngine.Vector2::y
IL_01bf: ldarg.0
IL_01c0: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::distanceToCenter
IL_01c5: mul
IL_01c6: ldarg.0
IL_01c7: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::startPosition
IL_01cc: ldfld System.Single UnityEngine.Vector2::y
IL_01d1: add
IL_01d2: ldarg.0
IL_01d3: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::centerSize
IL_01d8: ldfld System.Single UnityEngine.Vector2::y
IL_01dd: sub
IL_01de: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_01e3: callvirt System.Void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)
IL_01e8: br.s IL_023b
IL_01ea: ldarg.0
IL_01eb: ldfld UnityEngine.UI.Image Itelisoft.KOF.TheKingOfJoysticks::centerImage
IL_01f0: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.RectTransform>()
IL_01f5: ldloc.0
IL_01f6: ldfld System.Single UnityEngine.Vector2::x
IL_01fb: ldarg.0
IL_01fc: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::startPosition
IL_0201: ldfld System.Single UnityEngine.Vector2::x
IL_0206: add
IL_0207: ldarg.0
IL_0208: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::centerSize
IL_020d: ldfld System.Single UnityEngine.Vector2::x
IL_0212: sub
IL_0213: ldloc.0
IL_0214: ldfld System.Single UnityEngine.Vector2::y
IL_0219: ldarg.0
IL_021a: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::startPosition
IL_021f: ldfld System.Single UnityEngine.Vector2::y
IL_0224: add
IL_0225: ldarg.0
IL_0226: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::centerSize
IL_022b: ldfld System.Single UnityEngine.Vector2::y
IL_0230: sub
IL_0231: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_0236: callvirt System.Void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)
IL_023b: ldarg.0
IL_023c: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::distanceFromCenterPercentage
IL_0241: ldarg.0
IL_0242: ldfld System.Single Itelisoft.KOF.TheKingOfJoysticks::deadZonePercentage
IL_0247: bgt.un.s IL_0260
IL_0249: ldarg.0
IL_024a: call System.Void Itelisoft.KOF.TheKingOfJoysticks::ClearDirections()
IL_024f: ldarg.0
IL_0250: ldfld UnityEngine.UI.Image Itelisoft.KOF.TheKingOfJoysticks::borderImage
IL_0255: ldarg.0
IL_0256: ldfld UnityEngine.Sprite Itelisoft.KOF.TheKingOfJoysticks::idleSp
IL_025b: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_0260: ret
METHOD System.Boolean Itelisoft.KOF.TheKingOfJoysticks::IsPositionOutOfBounds(UnityEngine.Vector3)
IL_0000: ldloca.s V_0
IL_0002: ldarg.1
IL_0003: ldfld System.Single UnityEngine.Vector3::x
IL_0008: ldarg.0
IL_0009: ldfld UnityEngine.UI.CanvasScaler Itelisoft.KOF.TheKingOfJoysticks::scaler
IL_000e: callvirt UnityEngine.Vector2 UnityEngine.UI.CanvasScaler::get_referenceResolution()
IL_0013: ldfld System.Single UnityEngine.Vector2::x
IL_0018: mul
IL_0019: call System.Int32 UnityEngine.Screen::get_width()
IL_001e: conv.r4
IL_001f: div
IL_0020: ldarg.0
IL_0021: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::startPosition
IL_0026: ldfld System.Single UnityEngine.Vector2::x
IL_002b: sub
IL_002c: ldarg.1
IL_002d: ldfld System.Single UnityEngine.Vector3::y
IL_0032: ldarg.0
IL_0033: ldfld UnityEngine.UI.CanvasScaler Itelisoft.KOF.TheKingOfJoysticks::scaler
IL_0038: callvirt UnityEngine.Vector2 UnityEngine.UI.CanvasScaler::get_referenceResolution()
IL_003d: ldfld System.Single UnityEngine.Vector2::y
IL_0042: mul
IL_0043: call System.Int32 UnityEngine.Screen::get_height()
IL_0048: conv.r4
IL_0049: div
IL_004a: ldarg.0
IL_004b: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::startPosition
IL_0050: ldfld System.Single UnityEngine.Vector2::y
IL_0055: sub
IL_0056: call System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_005b: ldloc.0
IL_005c: ldfld System.Single UnityEngine.Vector2::x
IL_0061: ldc.r4 2
IL_0066: call System.Single UnityEngine.Mathf::Pow(System.Single,System.Single)
IL_006b: ldloc.0
IL_006c: ldfld System.Single UnityEngine.Vector2::y
IL_0071: ldc.r4 2
IL_0076: call System.Single UnityEngine.Mathf::Pow(System.Single,System.Single)
IL_007b: add
IL_007c: call System.Single UnityEngine.Mathf::Sqrt(System.Single)
IL_0081: ldc.r4 190
IL_0086: ble.un.s IL_008a
IL_0088: ldc.i4.1
IL_0089: ret
IL_008a: ldc.i4.4
IL_008b: newarr UnityEngine.Vector3
IL_0090: stloc.1
IL_0091: ldarg.0
IL_0092: ldfld UnityEngine.RectTransform Itelisoft.KOF.TheKingOfJoysticks::area
IL_0097: ldloc.1
IL_0098: callvirt System.Void UnityEngine.RectTransform::GetWorldCorners(UnityEngine.Vector3[])
IL_009d: ldarg.1
IL_009e: ldfld System.Single UnityEngine.Vector3::x
IL_00a3: ldloc.1
IL_00a4: ldc.i4.3
IL_00a5: ldelema UnityEngine.Vector3
IL_00aa: ldfld System.Single UnityEngine.Vector3::x
IL_00af: cgt
IL_00b1: ret
METHOD System.Single Itelisoft.KOF.TheKingOfJoysticks::GetAxisX()
IL_0000: ldarg.0
IL_0001: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::vectorDirection360
IL_0006: ldfld System.Single UnityEngine.Vector2::x
IL_000b: ret
METHOD System.Single Itelisoft.KOF.TheKingOfJoysticks::GetAxisY()
IL_0000: ldarg.0
IL_0001: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::vectorDirection360
IL_0006: ldfld System.Single UnityEngine.Vector2::y
IL_000b: ret
