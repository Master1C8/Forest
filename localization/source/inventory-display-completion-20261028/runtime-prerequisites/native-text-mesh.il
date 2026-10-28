TYPE UnityEngine.UI.Text
METHOD System.Void UnityEngine.UI.Text::OnPopulateMesh(UnityEngine.UI.VertexHelper) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: ldarg.0
IL_0010: ldc.i4.1
IL_0011: stfld System.Boolean UnityEngine.UI.Text::m_DisableFontTextureRebuiltCallback
IL_0016: ldarg.0
IL_0017: call UnityEngine.RectTransform UnityEngine.UI.Graphic::get_rectTransform()
IL_001c: callvirt UnityEngine.Rect UnityEngine.RectTransform::get_rect()
IL_0021: stloc.s V_6
IL_0023: ldloca.s V_6
IL_0025: call UnityEngine.Vector2 UnityEngine.Rect::get_size()
IL_002a: stloc.0
IL_002b: ldarg.0
IL_002c: ldloc.0
IL_002d: call UnityEngine.TextGenerationSettings UnityEngine.UI.Text::GetGenerationSettings(UnityEngine.Vector2)
IL_0032: stloc.1
IL_0033: ldarg.0
IL_0034: call UnityEngine.TextGenerator UnityEngine.UI.Text::get_cachedTextGenerator()
IL_0039: ldarg.0
IL_003a: callvirt System.String UnityEngine.UI.Text::get_text()
IL_003f: ldloc.1
IL_0040: ldarg.0
IL_0041: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0046: callvirt System.Boolean UnityEngine.TextGenerator::PopulateWithErrors(System.String,UnityEngine.TextGenerationSettings,UnityEngine.GameObject)
IL_004b: pop
IL_004c: ldarg.0
IL_004d: call UnityEngine.TextGenerator UnityEngine.UI.Text::get_cachedTextGenerator()
IL_0052: callvirt System.Collections.Generic.IList`1<UnityEngine.UIVertex> UnityEngine.TextGenerator::get_verts()
IL_0057: stloc.2
IL_0058: ldc.r4 1
IL_005d: ldarg.0
IL_005e: call System.Single UnityEngine.UI.Text::get_pixelsPerUnit()
IL_0063: div
IL_0064: stloc.3
IL_0065: ldloc.2
IL_0066: callvirt System.Int32 System.Collections.Generic.ICollection`1<UnityEngine.UIVertex>::get_Count()
IL_006b: stloc.s V_4
IL_006d: ldloc.s V_4
IL_006f: ldc.i4.0
IL_0070: bgt.s IL_0079
IL_0072: ldarg.1
IL_0073: callvirt System.Void UnityEngine.UI.VertexHelper::Clear()
IL_0078: ret
IL_0079: ldloc.2
IL_007a: ldc.i4.0
IL_007b: callvirt !0 System.Collections.Generic.IList`1<UnityEngine.UIVertex>::get_Item(System.Int32)
IL_0080: ldfld UnityEngine.Vector3 UnityEngine.UIVertex::position
IL_0085: ldfld System.Single UnityEngine.Vector3::x
IL_008a: ldloc.2
IL_008b: ldc.i4.0
IL_008c: callvirt !0 System.Collections.Generic.IList`1<UnityEngine.UIVertex>::get_Item(System.Int32)
IL_0091: ldfld UnityEngine.Vector3 UnityEngine.UIVertex::position
IL_0096: ldfld System.Single UnityEngine.Vector3::y
IL_009b: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_00a0: ldloc.3
IL_00a1: call UnityEngine.Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,System.Single)
IL_00a6: stloc.s V_5
IL_00a8: ldarg.0
IL_00a9: ldloc.s V_5
IL_00ab: call UnityEngine.Vector2 UnityEngine.UI.Graphic::PixelAdjustPoint(UnityEngine.Vector2)
IL_00b0: ldloc.s V_5
IL_00b2: call UnityEngine.Vector2 UnityEngine.Vector2::op_Subtraction(UnityEngine.Vector2,UnityEngine.Vector2)
IL_00b7: stloc.s V_5
IL_00b9: ldarg.1
IL_00ba: callvirt System.Void UnityEngine.UI.VertexHelper::Clear()
IL_00bf: ldloc.s V_5
IL_00c1: call UnityEngine.Vector2 UnityEngine.Vector2::get_zero()
IL_00c6: call System.Boolean UnityEngine.Vector2::op_Inequality(UnityEngine.Vector2,UnityEngine.Vector2)
IL_00cb: brfalse IL_017c
IL_00d0: ldc.i4.0
IL_00d1: stloc.s V_7
IL_00d3: br IL_0171
IL_00d8: ldloc.s V_7
IL_00da: ldc.i4.3
IL_00db: and
IL_00dc: stloc.s V_8
IL_00de: ldarg.0
IL_00df: ldfld UnityEngine.UIVertex[] UnityEngine.UI.Text::m_TempVerts
IL_00e4: ldloc.s V_8
IL_00e6: ldloc.2
IL_00e7: ldloc.s V_7
IL_00e9: callvirt !0 System.Collections.Generic.IList`1<UnityEngine.UIVertex>::get_Item(System.Int32)
IL_00ee: stelem.any UnityEngine.UIVertex
IL_00f3: ldarg.0
IL_00f4: ldfld UnityEngine.UIVertex[] UnityEngine.UI.Text::m_TempVerts
IL_00f9: ldloc.s V_8
IL_00fb: ldelema UnityEngine.UIVertex
IL_0100: ldflda UnityEngine.Vector3 UnityEngine.UIVertex::position
IL_0105: dup
IL_0106: ldobj UnityEngine.Vector3
IL_010b: ldloc.3
IL_010c: call UnityEngine.Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,System.Single)
IL_0111: stobj UnityEngine.Vector3
IL_0116: ldarg.0
IL_0117: ldfld UnityEngine.UIVertex[] UnityEngine.UI.Text::m_TempVerts
IL_011c: ldloc.s V_8
IL_011e: ldelema UnityEngine.UIVertex
IL_0123: ldflda UnityEngine.Vector3 UnityEngine.UIVertex::position
IL_0128: ldflda System.Single UnityEngine.Vector3::x
IL_012d: dup
IL_012e: ldind.r4
IL_012f: ldloc.s V_5
IL_0131: ldfld System.Single UnityEngine.Vector2::x
IL_0136: add
IL_0137: stind.r4
IL_0138: ldarg.0
IL_0139: ldfld UnityEngine.UIVertex[] UnityEngine.UI.Text::m_TempVerts
IL_013e: ldloc.s V_8
IL_0140: ldelema UnityEngine.UIVertex
IL_0145: ldflda UnityEngine.Vector3 UnityEngine.UIVertex::position
IL_014a: ldflda System.Single UnityEngine.Vector3::y
IL_014f: dup
IL_0150: ldind.r4
IL_0151: ldloc.s V_5
IL_0153: ldfld System.Single UnityEngine.Vector2::y
IL_0158: add
IL_0159: stind.r4
IL_015a: ldloc.s V_8
IL_015c: ldc.i4.3
IL_015d: bne.un.s IL_016b
IL_015f: ldarg.1
IL_0160: ldarg.0
IL_0161: ldfld UnityEngine.UIVertex[] UnityEngine.UI.Text::m_TempVerts
IL_0166: callvirt System.Void UnityEngine.UI.VertexHelper::AddUIVertexQuad(UnityEngine.UIVertex[])
IL_016b: ldloc.s V_7
IL_016d: ldc.i4.1
IL_016e: add
IL_016f: stloc.s V_7
IL_0171: ldloc.s V_7
IL_0173: ldloc.s V_4
IL_0175: blt IL_00d8
IL_017a: br.s IL_01dc
IL_017c: ldc.i4.0
IL_017d: stloc.s V_9
IL_017f: br.s IL_01d6
IL_0181: ldloc.s V_9
IL_0183: ldc.i4.3
IL_0184: and
IL_0185: stloc.s V_10
IL_0187: ldarg.0
IL_0188: ldfld UnityEngine.UIVertex[] UnityEngine.UI.Text::m_TempVerts
IL_018d: ldloc.s V_10
IL_018f: ldloc.2
IL_0190: ldloc.s V_9
IL_0192: callvirt !0 System.Collections.Generic.IList`1<UnityEngine.UIVertex>::get_Item(System.Int32)
IL_0197: stelem.any UnityEngine.UIVertex
IL_019c: ldarg.0
IL_019d: ldfld UnityEngine.UIVertex[] UnityEngine.UI.Text::m_TempVerts
IL_01a2: ldloc.s V_10
IL_01a4: ldelema UnityEngine.UIVertex
IL_01a9: ldflda UnityEngine.Vector3 UnityEngine.UIVertex::position
IL_01ae: dup
IL_01af: ldobj UnityEngine.Vector3
IL_01b4: ldloc.3
IL_01b5: call UnityEngine.Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,System.Single)
IL_01ba: stobj UnityEngine.Vector3
IL_01bf: ldloc.s V_10
IL_01c1: ldc.i4.3
IL_01c2: bne.un.s IL_01d0
IL_01c4: ldarg.1
IL_01c5: ldarg.0
IL_01c6: ldfld UnityEngine.UIVertex[] UnityEngine.UI.Text::m_TempVerts
IL_01cb: callvirt System.Void UnityEngine.UI.VertexHelper::AddUIVertexQuad(UnityEngine.UIVertex[])
IL_01d0: ldloc.s V_9
IL_01d2: ldc.i4.1
IL_01d3: add
IL_01d4: stloc.s V_9
IL_01d6: ldloc.s V_9
IL_01d8: ldloc.s V_4
IL_01da: blt.s IL_0181
IL_01dc: ldarg.0
IL_01dd: ldc.i4.0
IL_01de: stfld System.Boolean UnityEngine.UI.Text::m_DisableFontTextureRebuiltCallback
IL_01e3: ret
