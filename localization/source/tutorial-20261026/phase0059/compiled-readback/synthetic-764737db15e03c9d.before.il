METHOD System.Void ForestProbe::Dump() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void System.Collections.Generic.List`1<ForestProbe/TextRow>::.ctor()
IL_0006: stloc.0
IL_0007: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_000c: stloc.1
IL_000d: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0012: stloc.2
IL_0013: ldarg.0
IL_0014: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_0019: stloc.3
IL_001a: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TMPro.TMP_Text>()
IL_001f: stloc.s V_4
IL_0021: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0026: stloc.s V_5
IL_0028: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_002d: stloc.s V_6
IL_002f: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0034: stloc.s V_7
IL_0036: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_003b: stloc.s V_8
IL_003d: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0042: stloc.s V_9
IL_0044: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0049: stloc.s V_10
IL_004b: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0050: stloc.s V_11
IL_0052: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.UI.WindowController>()
IL_0057: stloc.s V_12
IL_0059: ldloc.s V_12
IL_005b: ldnull
IL_005c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0061: stloc.s V_15
IL_0063: ldloc.s V_15
IL_0065: brfalse IL_0182
IL_006a: nop
IL_006b: ldc.i4.s 52
IL_006d: stloc.s V_16
IL_006f: ldloc.s V_12
IL_0071: callvirt System.Type System.Object::GetType()
IL_0076: ldstr "windowSizeSettings"
IL_007b: ldloc.s V_16
IL_007d: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0082: ldloc.s V_12
IL_0084: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0089: castclass System.Collections.IEnumerable
IL_008e: stloc.s V_17
IL_0090: ldc.i4.0
IL_0091: stloc.s V_18
IL_0093: nop
IL_0094: ldloc.s V_17
IL_0096: callvirt System.Collections.IEnumerator System.Collections.IEnumerable::GetEnumerator()
IL_009b: stloc.s V_19
IL_009d: br IL_015d
IL_00a2: ldloc.s V_19
IL_00a4: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_00a9: stloc.s V_20
IL_00ab: nop
IL_00ac: ldloc.s V_20
IL_00ae: callvirt System.Type System.Object::GetType()
IL_00b3: stloc.s V_21
IL_00b5: ldloc.s V_10
IL_00b7: ldc.i4.7
IL_00b8: newarr System.String
IL_00bd: dup
IL_00be: ldc.i4.0
IL_00bf: ldloca.s V_18
IL_00c1: call System.String System.Int32::ToString()
IL_00c6: stelem.ref
IL_00c7: dup
IL_00c8: ldc.i4.1
IL_00c9: ldstr " | width="
IL_00ce: stelem.ref
IL_00cf: dup
IL_00d0: ldc.i4.2
IL_00d1: ldloc.s V_21
IL_00d3: ldstr "targetWidth"
IL_00d8: ldloc.s V_16
IL_00da: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_00df: ldloc.s V_20
IL_00e1: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_00e6: dup
IL_00e7: brtrue.s IL_00ed
IL_00e9: pop
IL_00ea: ldnull
IL_00eb: br.s IL_00f2
IL_00ed: callvirt System.String System.Object::ToString()
IL_00f2: stelem.ref
IL_00f3: dup
IL_00f4: ldc.i4.3
IL_00f5: ldstr " | height="
IL_00fa: stelem.ref
IL_00fb: dup
IL_00fc: ldc.i4.4
IL_00fd: ldloc.s V_21
IL_00ff: ldstr "targetHeight"
IL_0104: ldloc.s V_16
IL_0106: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_010b: ldloc.s V_20
IL_010d: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0112: dup
IL_0113: brtrue.s IL_0119
IL_0115: pop
IL_0116: ldnull
IL_0117: br.s IL_011e
IL_0119: callvirt System.String System.Object::ToString()
IL_011e: stelem.ref
IL_011f: dup
IL_0120: ldc.i4.5
IL_0121: ldstr " | eligible="
IL_0126: stelem.ref
IL_0127: dup
IL_0128: ldc.i4.6
IL_0129: ldloc.s V_21
IL_012b: ldstr "eligible"
IL_0130: ldloc.s V_16
IL_0132: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0137: ldloc.s V_20
IL_0139: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_013e: dup
IL_013f: brtrue.s IL_0145
IL_0141: pop
IL_0142: ldnull
IL_0143: br.s IL_014a
IL_0145: callvirt System.String System.Object::ToString()
IL_014a: stelem.ref
IL_014b: call System.String System.String::Concat(System.String[])
IL_0150: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0155: nop
IL_0156: ldloc.s V_18
IL_0158: ldc.i4.1
IL_0159: add
IL_015a: stloc.s V_18
IL_015c: nop
IL_015d: ldloc.s V_19
IL_015f: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0164: brtrue IL_00a2
IL_0169: leave.s IL_0181
IL_016b: ldloc.s V_19
IL_016d: isinst System.IDisposable
IL_0172: stloc.s V_22
IL_0174: ldloc.s V_22
IL_0176: brfalse.s IL_0180
IL_0178: ldloc.s V_22
IL_017a: callvirt System.Void System.IDisposable::Dispose()
IL_017f: nop
IL_0180: endfinally
IL_0181: nop
IL_0182: nop
IL_0183: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.CanvasGroup>()
IL_0188: stloc.s V_23
IL_018a: ldc.i4.0
IL_018b: stloc.s V_24
IL_018d: br IL_0248
IL_0192: ldloc.s V_23
IL_0194: ldloc.s V_24
IL_0196: ldelem.ref
IL_0197: stloc.s V_25
IL_0199: ldloc.s V_25
IL_019b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01a0: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_01a5: stloc.s V_27
IL_01a7: ldloca.s V_27
IL_01a9: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_01ae: brfalse.s IL_01c8
IL_01b0: ldloc.s V_25
IL_01b2: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01b7: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_01bc: ldstr "Canvas/OptionsMenu/Controls/ScaleFactor"
IL_01c1: callvirt System.Boolean System.String::StartsWith(System.String)
IL_01c6: br.s IL_01c9
IL_01c8: ldc.i4.0
IL_01c9: stloc.s V_26
IL_01cb: ldloc.s V_26
IL_01cd: brfalse.s IL_0242
IL_01cf: ldloc.s V_11
IL_01d1: ldc.i4.7
IL_01d2: newarr System.String
IL_01d7: dup
IL_01d8: ldc.i4.0
IL_01d9: ldloc.s V_25
IL_01db: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01e0: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_01e5: stelem.ref
IL_01e6: dup
IL_01e7: ldc.i4.1
IL_01e8: ldstr " | alpha="
IL_01ed: stelem.ref
IL_01ee: dup
IL_01ef: ldc.i4.2
IL_01f0: ldloc.s V_25
IL_01f2: callvirt System.Single UnityEngine.CanvasGroup::get_alpha()
IL_01f7: stloc.s V_28
IL_01f9: ldloca.s V_28
IL_01fb: call System.String System.Single::ToString()
IL_0200: stelem.ref
IL_0201: dup
IL_0202: ldc.i4.3
IL_0203: ldstr " | interactable="
IL_0208: stelem.ref
IL_0209: dup
IL_020a: ldc.i4.4
IL_020b: ldloc.s V_25
IL_020d: callvirt System.Boolean UnityEngine.CanvasGroup::get_interactable()
IL_0212: stloc.s V_29
IL_0214: ldloca.s V_29
IL_0216: call System.String System.Boolean::ToString()
IL_021b: stelem.ref
IL_021c: dup
IL_021d: ldc.i4.5
IL_021e: ldstr " | blocksRaycasts="
IL_0223: stelem.ref
IL_0224: dup
IL_0225: ldc.i4.6
IL_0226: ldloc.s V_25
IL_0228: callvirt System.Boolean UnityEngine.CanvasGroup::get_blocksRaycasts()
IL_022d: stloc.s V_29
IL_022f: ldloca.s V_29
IL_0231: call System.String System.Boolean::ToString()
IL_0236: stelem.ref
IL_0237: call System.String System.String::Concat(System.String[])
IL_023c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0241: nop
IL_0242: ldloc.s V_24
IL_0244: ldc.i4.1
IL_0245: add
IL_0246: stloc.s V_24
IL_0248: ldloc.s V_24
IL_024a: ldloc.s V_23
IL_024c: ldlen
IL_024d: conv.i4
IL_024e: blt IL_0192
IL_0253: nop
IL_0254: ldloc.s V_4
IL_0256: stloc.s V_30
IL_0258: ldc.i4.0
IL_0259: stloc.s V_31
IL_025b: br IL_0763
IL_0260: ldloc.s V_30
IL_0262: ldloc.s V_31
IL_0264: ldelem.ref
IL_0265: stloc.s V_32
IL_0267: ldloc.s V_32
IL_0269: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_026e: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0273: stloc.s V_33
IL_0275: ldloc.s V_33
IL_0277: brfalse IL_075d
IL_027c: nop
IL_027d: ldloc.s V_32
IL_027f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0284: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0289: stloc.s V_27
IL_028b: ldloca.s V_27
IL_028d: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0292: brfalse.s IL_02ac
IL_0294: ldloc.s V_32
IL_0296: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_029b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_02a0: ldstr "Canvas/OptionsMenu/"
IL_02a5: callvirt System.Boolean System.String::StartsWith(System.String)
IL_02aa: br.s IL_02ad
IL_02ac: ldc.i4.0
IL_02ad: stloc.s V_34
IL_02af: ldloc.s V_34
IL_02b1: stloc.s V_35
IL_02b3: ldloc.s V_35
IL_02b5: brfalse IL_03c6
IL_02ba: nop
IL_02bb: ldloc.s V_32
IL_02bd: callvirt UnityEngine.RectTransform TMPro.TMP_Text::get_rectTransform()
IL_02c2: stloc.s V_36
IL_02c4: ldloc.s V_36
IL_02c6: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_02cb: stloc.s V_37
IL_02cd: ldloc.s V_36
IL_02cf: callvirt UnityEngine.Rect UnityEngine.RectTransform::get_rect()
IL_02d4: stloc.s V_38
IL_02d6: ldloc.s V_8
IL_02d8: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL_02dd: ldstr "{0} | text={1} | fontSize={2:R} | alignment={3} | color={4} | world=({5:R},{6:R}) | rect=({7:R},{8:R}) | anchorY=({9:R},{10:R}) | sizeDeltaY={11:R} | preferredHeight={12:R}"
IL_02e2: ldc.i4.s 13
IL_02e4: newarr System.Object
IL_02e9: dup
IL_02ea: ldc.i4.0
IL_02eb: ldloc.s V_32
IL_02ed: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_02f2: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_02f7: stelem.ref
IL_02f8: dup
IL_02f9: ldc.i4.1
IL_02fa: ldloc.s V_32
IL_02fc: callvirt System.String TMPro.TMP_Text::get_text()
IL_0301: stelem.ref
IL_0302: dup
IL_0303: ldc.i4.2
IL_0304: ldloc.s V_32
IL_0306: callvirt System.Single TMPro.TMP_Text::get_fontSize()
IL_030b: box System.Single
IL_0310: stelem.ref
IL_0311: dup
IL_0312: ldc.i4.3
IL_0313: ldloc.s V_32
IL_0315: callvirt TMPro.TextAlignmentOptions TMPro.TMP_Text::get_alignment()
IL_031a: box TMPro.TextAlignmentOptions
IL_031f: stelem.ref
IL_0320: dup
IL_0321: ldc.i4.4
IL_0322: ldloc.s V_32
IL_0324: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_0329: box UnityEngine.Color
IL_032e: stelem.ref
IL_032f: dup
IL_0330: ldc.i4.5
IL_0331: ldloc.s V_37
IL_0333: ldfld System.Single UnityEngine.Vector3::x
IL_0338: box System.Single
IL_033d: stelem.ref
IL_033e: dup
IL_033f: ldc.i4.6
IL_0340: ldloc.s V_37
IL_0342: ldfld System.Single UnityEngine.Vector3::y
IL_0347: box System.Single
IL_034c: stelem.ref
IL_034d: dup
IL_034e: ldc.i4.7
IL_034f: ldloca.s V_38
IL_0351: call System.Single UnityEngine.Rect::get_width()
IL_0356: box System.Single
IL_035b: stelem.ref
IL_035c: dup
IL_035d: ldc.i4.8
IL_035e: ldloca.s V_38
IL_0360: call System.Single UnityEngine.Rect::get_height()
IL_0365: box System.Single
IL_036a: stelem.ref
IL_036b: dup
IL_036c: ldc.i4.s 9
IL_036e: ldloc.s V_36
IL_0370: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_anchorMin()
IL_0375: ldfld System.Single UnityEngine.Vector2::y
IL_037a: box System.Single
IL_037f: stelem.ref
IL_0380: dup
IL_0381: ldc.i4.s 10
IL_0383: ldloc.s V_36
IL_0385: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_anchorMax()
IL_038a: ldfld System.Single UnityEngine.Vector2::y
IL_038f: box System.Single
IL_0394: stelem.ref
IL_0395: dup
IL_0396: ldc.i4.s 11
IL_0398: ldloc.s V_36
IL_039a: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_sizeDelta()
IL_039f: ldfld System.Single UnityEngine.Vector2::y
IL_03a4: box System.Single
IL_03a9: stelem.ref
IL_03aa: dup
IL_03ab: ldc.i4.s 12
IL_03ad: ldloc.s V_32
IL_03af: callvirt System.Single TMPro.TMP_Text::get_preferredHeight()
IL_03b4: box System.Single
IL_03b9: stelem.ref
IL_03ba: call System.String System.String::Format(System.IFormatProvider,System.String,System.Object[])
IL_03bf: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_03c4: nop
IL_03c5: nop
IL_03c6: ldloc.s V_32
IL_03c8: callvirt System.String UnityEngine.Object::get_name()
IL_03cd: ldstr "Subtitle Text"
IL_03d2: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03d7: brtrue.s IL_0409
IL_03d9: ldloc.s V_34
IL_03db: brfalse.s IL_0406
IL_03dd: ldloc.s V_32
IL_03df: callvirt System.String TMPro.TMP_Text::get_text()
IL_03e4: ldstr "Off"
IL_03e9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03ee: brtrue.s IL_0403
IL_03f0: ldloc.s V_32
IL_03f2: callvirt System.String TMPro.TMP_Text::get_text()
IL_03f7: ldstr "On"
IL_03fc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0401: br.s IL_0404
IL_0403: ldc.i4.1
IL_0404: br.s IL_0407
IL_0406: ldc.i4.0
IL_0407: br.s IL_040a
IL_0409: ldc.i4.1
IL_040a: stloc.s V_39
IL_040c: ldloc.s V_39
IL_040e: brfalse IL_065b
IL_0413: nop
IL_0414: ldloc.s V_32
IL_0416: callvirt TMPro.TMP_TextInfo TMPro.TMP_Text::get_textInfo()
IL_041b: stloc.s V_40
IL_041d: ldc.i4.0
IL_041e: stloc.s V_41
IL_0420: br IL_0646
IL_0425: nop
IL_0426: ldloc.s V_40
IL_0428: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_042d: ldloc.s V_41
IL_042f: ldelem.any TMPro.TMP_CharacterInfo
IL_0434: stloc.s V_42
IL_0436: ldloc.s V_42
IL_0438: ldfld TMPro.TMP_TextElement TMPro.TMP_CharacterInfo::textElement
IL_043d: ldnull
IL_043e: ceq
IL_0440: stloc.s V_46
IL_0442: ldloc.s V_46
IL_0444: brfalse.s IL_044b
IL_0446: br IL_0640
IL_044b: ldloc.s V_42
IL_044d: ldfld TMPro.TMP_TextElement TMPro.TMP_CharacterInfo::textElement
IL_0452: callvirt UnityEngine.TextCore.Glyph TMPro.TMP_TextElement::get_glyph()
IL_0457: stloc.s V_43
IL_0459: ldloc.s V_43
IL_045b: callvirt UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.Glyph::get_metrics()
IL_0460: stloc.s V_44
IL_0462: ldloc.s V_32
IL_0464: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_0469: ldloc.s V_42
IL_046b: ldfld System.Single TMPro.TMP_CharacterInfo::origin
IL_0470: ldloc.s V_42
IL_0472: ldfld System.Single TMPro.TMP_CharacterInfo::baseLine
IL_0477: ldc.r4 0
IL_047c: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0481: callvirt UnityEngine.Vector3 UnityEngine.Transform::TransformPoint(UnityEngine.Vector3)
IL_0486: stloc.s V_45
IL_0488: ldloc.s V_34
IL_048a: brtrue.s IL_0490
IL_048c: ldloc.s V_6
IL_048e: br.s IL_0492
IL_0490: ldloc.s V_7
IL_0492: ldloc.s V_32
IL_0494: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_0499: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_049e: ldstr " | "
IL_04a3: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL_04a8: ldstr "{0} | U+{1:X4} | glyph={2} | font={3} | face={4} | origin={5:R} | advance={6:R} | baseline={7:R} | scale={8:R} | bearing=({9:R},{10:R}) | size=({11:R},{12:R}) | glyphAdvance={13:R} | topLeft=({14:R},{15:R}) | bottomRight=({16:R},{17:R}) | worldOriginBaseline=({18:R},{19:R})"
IL_04ad: ldc.i4.s 20
IL_04af: newarr System.Object
IL_04b4: dup
IL_04b5: ldc.i4.0
IL_04b6: ldloc.s V_41
IL_04b8: box System.Int32
IL_04bd: stelem.ref
IL_04be: dup
IL_04bf: ldc.i4.1
IL_04c0: ldloc.s V_42
IL_04c2: ldfld System.Char TMPro.TMP_CharacterInfo::character
IL_04c7: box System.Int32
IL_04cc: stelem.ref
IL_04cd: dup
IL_04ce: ldc.i4.2
IL_04cf: ldloc.s V_43
IL_04d1: callvirt System.UInt32 UnityEngine.TextCore.Glyph::get_index()
IL_04d6: box System.UInt32
IL_04db: stelem.ref
IL_04dc: dup
IL_04dd: ldc.i4.3
IL_04de: ldloc.s V_42
IL_04e0: ldfld TMPro.TMP_FontAsset TMPro.TMP_CharacterInfo::fontAsset
IL_04e5: ldnull
IL_04e6: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_04eb: brtrue.s IL_04fb
IL_04ed: ldloc.s V_42
IL_04ef: ldfld TMPro.TMP_FontAsset TMPro.TMP_CharacterInfo::fontAsset
IL_04f4: callvirt System.String UnityEngine.Object::get_name()
IL_04f9: br.s IL_0500
IL_04fb: ldstr ""
IL_0500: stelem.ref
IL_0501: dup
IL_0502: ldc.i4.4
IL_0503: ldloc.s V_42
IL_0505: ldfld TMPro.TMP_FontAsset TMPro.TMP_CharacterInfo::fontAsset
IL_050a: ldnull
IL_050b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0510: brtrue.s IL_0529
IL_0512: ldloc.s V_42
IL_0514: ldfld TMPro.TMP_FontAsset TMPro.TMP_CharacterInfo::fontAsset
IL_0519: callvirt UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::get_faceInfo()
IL_051e: stloc.s V_47
IL_0520: ldloca.s V_47
IL_0522: call System.String UnityEngine.TextCore.FaceInfo::get_familyName()
IL_0527: br.s IL_052e
IL_0529: ldstr ""
IL_052e: stelem.ref
IL_052f: dup
IL_0530: ldc.i4.5
IL_0531: ldloc.s V_42
IL_0533: ldfld System.Single TMPro.TMP_CharacterInfo::origin
IL_0538: box System.Single
IL_053d: stelem.ref
IL_053e: dup
IL_053f: ldc.i4.6
IL_0540: ldloc.s V_42
IL_0542: ldfld System.Single TMPro.TMP_CharacterInfo::xAdvance
IL_0547: box System.Single
IL_054c: stelem.ref
IL_054d: dup
IL_054e: ldc.i4.7
IL_054f: ldloc.s V_42
IL_0551: ldfld System.Single TMPro.TMP_CharacterInfo::baseLine
IL_0556: box System.Single
IL_055b: stelem.ref
IL_055c: dup
IL_055d: ldc.i4.8
IL_055e: ldloc.s V_42
IL_0560: ldfld System.Single TMPro.TMP_CharacterInfo::scale
IL_0565: box System.Single
IL_056a: stelem.ref
IL_056b: dup
IL_056c: ldc.i4.s 9
IL_056e: ldloca.s V_44
IL_0570: call System.Single UnityEngine.TextCore.GlyphMetrics::get_horizontalBearingX()
IL_0575: box System.Single
IL_057a: stelem.ref
IL_057b: dup
IL_057c: ldc.i4.s 10
IL_057e: ldloca.s V_44
IL_0580: call System.Single UnityEngine.TextCore.GlyphMetrics::get_horizontalBearingY()
IL_0585: box System.Single
IL_058a: stelem.ref
IL_058b: dup
IL_058c: ldc.i4.s 11
IL_058e: ldloca.s V_44
IL_0590: call System.Single UnityEngine.TextCore.GlyphMetrics::get_width()
IL_0595: box System.Single
IL_059a: stelem.ref
IL_059b: dup
IL_059c: ldc.i4.s 12
IL_059e: ldloca.s V_44
IL_05a0: call System.Single UnityEngine.TextCore.GlyphMetrics::get_height()
IL_05a5: box System.Single
IL_05aa: stelem.ref
IL_05ab: dup
IL_05ac: ldc.i4.s 13
IL_05ae: ldloca.s V_44
IL_05b0: call System.Single UnityEngine.TextCore.GlyphMetrics::get_horizontalAdvance()
IL_05b5: box System.Single
IL_05ba: stelem.ref
IL_05bb: dup
IL_05bc: ldc.i4.s 14
IL_05be: ldloc.s V_42
IL_05c0: ldfld UnityEngine.Vector3 TMPro.TMP_CharacterInfo::topLeft
IL_05c5: ldfld System.Single UnityEngine.Vector3::x
IL_05ca: box System.Single
IL_05cf: stelem.ref
IL_05d0: dup
IL_05d1: ldc.i4.s 15
IL_05d3: ldloc.s V_42
IL_05d5: ldfld UnityEngine.Vector3 TMPro.TMP_CharacterInfo::topLeft
IL_05da: ldfld System.Single UnityEngine.Vector3::y
IL_05df: box System.Single
IL_05e4: stelem.ref
IL_05e5: dup
IL_05e6: ldc.i4.s 16
IL_05e8: ldloc.s V_42
IL_05ea: ldfld UnityEngine.Vector3 TMPro.TMP_CharacterInfo::bottomRight
IL_05ef: ldfld System.Single UnityEngine.Vector3::x
IL_05f4: box System.Single
IL_05f9: stelem.ref
IL_05fa: dup
IL_05fb: ldc.i4.s 17
IL_05fd: ldloc.s V_42
IL_05ff: ldfld UnityEngine.Vector3 TMPro.TMP_CharacterInfo::bottomRight
IL_0604: ldfld System.Single UnityEngine.Vector3::y
IL_0609: box System.Single
IL_060e: stelem.ref
IL_060f: dup
IL_0610: ldc.i4.s 18
IL_0612: ldloc.s V_45
IL_0614: ldfld System.Single UnityEngine.Vector3::x
IL_0619: box System.Single
IL_061e: stelem.ref
IL_061f: dup
IL_0620: ldc.i4.s 19
IL_0622: ldloc.s V_45
IL_0624: ldfld System.Single UnityEngine.Vector3::y
IL_0629: box System.Single
IL_062e: stelem.ref
IL_062f: call System.String System.String::Format(System.IFormatProvider,System.String,System.Object[])
IL_0634: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0639: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_063e: nop
IL_063f: nop
IL_0640: ldloc.s V_41
IL_0642: ldc.i4.1
IL_0643: add
IL_0644: stloc.s V_41
IL_0646: ldloc.s V_41
IL_0648: ldloc.s V_40
IL_064a: ldfld System.Int32 TMPro.TMP_TextInfo::characterCount
IL_064f: clt
IL_0651: stloc.s V_48
IL_0653: ldloc.s V_48
IL_0655: brtrue IL_0425
IL_065a: nop
IL_065b: ldloc.0
IL_065c: newobj System.Void ForestProbe/TextRow::.ctor()
IL_0661: dup
IL_0662: ldloc.s V_32
IL_0664: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_0669: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_066e: stfld System.String ForestProbe/TextRow::path
IL_0673: dup
IL_0674: ldloc.s V_32
IL_0676: callvirt System.String TMPro.TMP_Text::get_text()
IL_067b: stfld System.String ForestProbe/TextRow::text
IL_0680: dup
IL_0681: ldloc.s V_32
IL_0683: callvirt TMPro.TMP_FontAsset TMPro.TMP_Text::get_font()
IL_0688: ldnull
IL_0689: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_068e: brtrue.s IL_069e
IL_0690: ldloc.s V_32
IL_0692: callvirt TMPro.TMP_FontAsset TMPro.TMP_Text::get_font()
IL_0697: callvirt System.String UnityEngine.Object::get_name()
IL_069c: br.s IL_06a3
IL_069e: ldstr ""
IL_06a3: stfld System.String ForestProbe/TextRow::font
IL_06a8: dup
IL_06a9: ldloc.s V_32
IL_06ab: callvirt System.Single TMPro.TMP_Text::get_fontSize()
IL_06b0: stfld System.Single ForestProbe/TextRow::size
IL_06b5: dup
IL_06b6: ldloc.s V_32
IL_06b8: callvirt System.Boolean TMPro.TMP_Text::get_isTextOverflowing()
IL_06bd: stfld System.Boolean ForestProbe/TextRow::overflow
IL_06c2: callvirt System.Void System.Collections.Generic.List`1<ForestProbe/TextRow>::Add(!0)
IL_06c7: nop
IL_06c8: ldloc.s V_5
IL_06ca: ldc.i4.s 9
IL_06cc: newarr System.String
IL_06d1: dup
IL_06d2: ldc.i4.0
IL_06d3: ldloc.s V_32
IL_06d5: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_06da: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_06df: stelem.ref
IL_06e0: dup
IL_06e1: ldc.i4.1
IL_06e2: ldstr " | "
IL_06e7: stelem.ref
IL_06e8: dup
IL_06e9: ldc.i4.2
IL_06ea: ldloc.s V_32
IL_06ec: callvirt System.Type System.Object::GetType()
IL_06f1: callvirt System.String System.Type::get_FullName()
IL_06f6: stelem.ref
IL_06f7: dup
IL_06f8: ldc.i4.3
IL_06f9: ldstr " | "
IL_06fe: stelem.ref
IL_06ff: dup
IL_0700: ldc.i4.4
IL_0701: ldloc.s V_32
IL_0703: callvirt System.String TMPro.TMP_Text::get_text()
IL_0708: stelem.ref
IL_0709: dup
IL_070a: ldc.i4.5
IL_070b: ldstr " | font="
IL_0710: stelem.ref
IL_0711: dup
IL_0712: ldc.i4.6
IL_0713: ldloc.s V_32
IL_0715: callvirt TMPro.TMP_FontAsset TMPro.TMP_Text::get_font()
IL_071a: ldnull
IL_071b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0720: brtrue.s IL_0730
IL_0722: ldloc.s V_32
IL_0724: callvirt TMPro.TMP_FontAsset TMPro.TMP_Text::get_font()
IL_0729: callvirt System.String UnityEngine.Object::get_name()
IL_072e: br.s IL_0735
IL_0730: ldstr "null"
IL_0735: stelem.ref
IL_0736: dup
IL_0737: ldc.i4.7
IL_0738: ldstr " | overflow="
IL_073d: stelem.ref
IL_073e: dup
IL_073f: ldc.i4.8
IL_0740: ldloc.s V_32
IL_0742: callvirt System.Boolean TMPro.TMP_Text::get_isTextOverflowing()
IL_0747: stloc.s V_29
IL_0749: ldloca.s V_29
IL_074b: call System.String System.Boolean::ToString()
IL_0750: stelem.ref
IL_0751: call System.String System.String::Concat(System.String[])
IL_0756: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_075b: nop
IL_075c: nop
IL_075d: ldloc.s V_31
IL_075f: ldc.i4.1
IL_0760: add
IL_0761: stloc.s V_31
IL_0763: ldloc.s V_31
IL_0765: ldloc.s V_30
IL_0767: ldlen
IL_0768: conv.i4
IL_0769: blt IL_0260
IL_076e: nop
IL_076f: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Text>()
IL_0774: stloc.s V_49
IL_0776: ldc.i4.0
IL_0777: stloc.s V_50
IL_0779: br IL_0a57
IL_077e: ldloc.s V_49
IL_0780: ldloc.s V_50
IL_0782: ldelem.ref
IL_0783: stloc.s V_51
IL_0785: ldloc.s V_51
IL_0787: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_078c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0791: stloc.s V_52
IL_0793: ldloc.s V_52
IL_0795: brfalse IL_0a51
IL_079a: ldloc.s V_5
IL_079c: ldc.i4.s 27
IL_079e: newarr System.String
IL_07a3: dup
IL_07a4: ldc.i4.0
IL_07a5: ldloc.s V_51
IL_07a7: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_07ac: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_07b1: stelem.ref
IL_07b2: dup
IL_07b3: ldc.i4.1
IL_07b4: ldstr " | UnityEngine.UI.Text | "
IL_07b9: stelem.ref
IL_07ba: dup
IL_07bb: ldc.i4.2
IL_07bc: ldloc.s V_51
IL_07be: callvirt System.String UnityEngine.UI.Text::get_text()
IL_07c3: stelem.ref
IL_07c4: dup
IL_07c5: ldc.i4.3
IL_07c6: ldstr " | font="
IL_07cb: stelem.ref
IL_07cc: dup
IL_07cd: ldc.i4.4
IL_07ce: ldloc.s V_51
IL_07d0: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_07d5: ldnull
IL_07d6: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_07db: brtrue.s IL_07eb
IL_07dd: ldloc.s V_51
IL_07df: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_07e4: callvirt System.String UnityEngine.Object::get_name()
IL_07e9: br.s IL_07f0
IL_07eb: ldstr "null"
IL_07f0: stelem.ref
IL_07f1: dup
IL_07f2: ldc.i4.5
IL_07f3: ldstr " | size="
IL_07f8: stelem.ref
IL_07f9: dup
IL_07fa: ldc.i4.6
IL_07fb: ldloc.s V_51
IL_07fd: callvirt System.Int32 UnityEngine.UI.Text::get_fontSize()
IL_0802: stloc.s V_53
IL_0804: ldloca.s V_53
IL_0806: call System.String System.Int32::ToString()
IL_080b: stelem.ref
IL_080c: dup
IL_080d: ldc.i4.7
IL_080e: ldstr " | style="
IL_0813: stelem.ref
IL_0814: dup
IL_0815: ldc.i4.8
IL_0816: ldloc.s V_51
IL_0818: callvirt UnityEngine.FontStyle UnityEngine.UI.Text::get_fontStyle()
IL_081d: stloc.s V_54
IL_081f: ldloca.s V_54
IL_0821: constrained. UnityEngine.FontStyle
IL_0827: callvirt System.String System.Object::ToString()
IL_082c: stelem.ref
IL_082d: dup
IL_082e: ldc.i4.s 9
IL_0830: ldstr " | fontNames="
IL_0835: stelem.ref
IL_0836: dup
IL_0837: ldc.i4.s 10
IL_0839: ldloc.s V_51
IL_083b: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0840: ldnull
IL_0841: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0846: brtrue.s IL_0860
IL_0848: ldstr ","
IL_084d: ldloc.s V_51
IL_084f: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0854: callvirt System.String[] UnityEngine.Font::get_fontNames()
IL_0859: call System.String System.String::Join(System.String,System.String[])
IL_085e: br.s IL_0865
IL_0860: ldstr "null"
IL_0865: stelem.ref
IL_0866: dup
IL_0867: ldc.i4.s 11
IL_0869: ldstr " | dynamic="
IL_086e: stelem.ref
IL_086f: dup
IL_0870: ldc.i4.s 12
IL_0872: ldloc.s V_51
IL_0874: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0879: ldnull
IL_087a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_087f: brfalse.s IL_088f
IL_0881: ldloc.s V_51
IL_0883: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0888: callvirt System.Boolean UnityEngine.Font::get_dynamic()
IL_088d: br.s IL_0890
IL_088f: ldc.i4.0
IL_0890: stloc.s V_29
IL_0892: ldloca.s V_29
IL_0894: call System.String System.Boolean::ToString()
IL_0899: stelem.ref
IL_089a: dup
IL_089b: ldc.i4.s 13
IL_089d: ldstr " | hasCyrillicAndDigits="
IL_08a2: stelem.ref
IL_08a3: dup
IL_08a4: ldc.i4.s 14
IL_08a6: ldloc.s V_51
IL_08a8: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_08ad: ldnull
IL_08ae: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_08b3: brfalse.s IL_08eb
IL_08b5: ldloc.s V_51
IL_08b7: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_08bc: ldc.i4 1025
IL_08c1: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_08c6: brfalse.s IL_08eb
IL_08c8: ldloc.s V_51
IL_08ca: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_08cf: ldc.i4 1049
IL_08d4: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_08d9: brfalse.s IL_08eb
IL_08db: ldloc.s V_51
IL_08dd: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_08e2: ldc.i4.s 49
IL_08e4: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_08e9: br.s IL_08ec
IL_08eb: ldc.i4.0
IL_08ec: stloc.s V_29
IL_08ee: ldloca.s V_29
IL_08f0: call System.String System.Boolean::ToString()
IL_08f5: stelem.ref
IL_08f6: dup
IL_08f7: ldc.i4.s 15
IL_08f9: ldstr " | hasYo="
IL_08fe: stelem.ref
IL_08ff: dup
IL_0900: ldc.i4.s 16
IL_0902: ldloc.s V_51
IL_0904: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0909: ldnull
IL_090a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_090f: brfalse.s IL_0924
IL_0911: ldloc.s V_51
IL_0913: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0918: ldc.i4 1025
IL_091d: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_0922: br.s IL_0925
IL_0924: ldc.i4.0
IL_0925: stloc.s V_29
IL_0927: ldloca.s V_29
IL_0929: call System.String System.Boolean::ToString()
IL_092e: stelem.ref
IL_092f: dup
IL_0930: ldc.i4.s 17
IL_0932: ldstr " | hasShortI="
IL_0937: stelem.ref
IL_0938: dup
IL_0939: ldc.i4.s 18
IL_093b: ldloc.s V_51
IL_093d: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0942: ldnull
IL_0943: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0948: brfalse.s IL_095d
IL_094a: ldloc.s V_51
IL_094c: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0951: ldc.i4 1049
IL_0956: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_095b: br.s IL_095e
IL_095d: ldc.i4.0
IL_095e: stloc.s V_29
IL_0960: ldloca.s V_29
IL_0962: call System.String System.Boolean::ToString()
IL_0967: stelem.ref
IL_0968: dup
IL_0969: ldc.i4.s 19
IL_096b: ldstr " | hasDigit1="
IL_0970: stelem.ref
IL_0971: dup
IL_0972: ldc.i4.s 20
IL_0974: ldloc.s V_51
IL_0976: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_097b: ldnull
IL_097c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0981: brfalse.s IL_0993
IL_0983: ldloc.s V_51
IL_0985: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_098a: ldc.i4.s 49
IL_098c: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_0991: br.s IL_0994
IL_0993: ldc.i4.0
IL_0994: stloc.s V_29
IL_0996: ldloca.s V_29
IL_0998: call System.String System.Boolean::ToString()
IL_099d: stelem.ref
IL_099e: dup
IL_099f: ldc.i4.s 21
IL_09a1: ldstr " | hasSpace="
IL_09a6: stelem.ref
IL_09a7: dup
IL_09a8: ldc.i4.s 22
IL_09aa: ldloc.s V_51
IL_09ac: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_09b1: ldnull
IL_09b2: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_09b7: brfalse.s IL_09c9
IL_09b9: ldloc.s V_51
IL_09bb: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_09c0: ldc.i4.s 32
IL_09c2: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_09c7: br.s IL_09ca
IL_09c9: ldc.i4.0
IL_09ca: stloc.s V_29
IL_09cc: ldloca.s V_29
IL_09ce: call System.String System.Boolean::ToString()
IL_09d3: stelem.ref
IL_09d4: dup
IL_09d5: ldc.i4.s 23
IL_09d7: ldstr " | hasDiaeresis="
IL_09dc: stelem.ref
IL_09dd: dup
IL_09de: ldc.i4.s 24
IL_09e0: ldloc.s V_51
IL_09e2: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_09e7: ldnull
IL_09e8: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_09ed: brfalse.s IL_0a02
IL_09ef: ldloc.s V_51
IL_09f1: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_09f6: ldc.i4 776
IL_09fb: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_0a00: br.s IL_0a03
IL_0a02: ldc.i4.0
IL_0a03: stloc.s V_29
IL_0a05: ldloca.s V_29
IL_0a07: call System.String System.Boolean::ToString()
IL_0a0c: stelem.ref
IL_0a0d: dup
IL_0a0e: ldc.i4.s 25
IL_0a10: ldstr " | hasBreve="
IL_0a15: stelem.ref
IL_0a16: dup
IL_0a17: ldc.i4.s 26
IL_0a19: ldloc.s V_51
IL_0a1b: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0a20: ldnull
IL_0a21: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0a26: brfalse.s IL_0a3b
IL_0a28: ldloc.s V_51
IL_0a2a: callvirt UnityEngine.Font UnityEngine.UI.Text::get_font()
IL_0a2f: ldc.i4 774
IL_0a34: callvirt System.Boolean UnityEngine.Font::HasCharacter(System.Char)
IL_0a39: br.s IL_0a3c
IL_0a3b: ldc.i4.0
IL_0a3c: stloc.s V_29
IL_0a3e: ldloca.s V_29
IL_0a40: call System.String System.Boolean::ToString()
IL_0a45: stelem.ref
IL_0a46: call System.String System.String::Concat(System.String[])
IL_0a4b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0a50: nop
IL_0a51: ldloc.s V_50
IL_0a53: ldc.i4.1
IL_0a54: add
IL_0a55: stloc.s V_50
IL_0a57: ldloc.s V_50
IL_0a59: ldloc.s V_49
IL_0a5b: ldlen
IL_0a5c: conv.i4
IL_0a5d: blt IL_077e
IL_0a62: nop
IL_0a63: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Button>()
IL_0a68: stloc.s V_55
IL_0a6a: ldc.i4.0
IL_0a6b: stloc.s V_56
IL_0a6d: br.s IL_0ac4
IL_0a6f: ldloc.s V_55
IL_0a71: ldloc.s V_56
IL_0a73: ldelem.ref
IL_0a74: stloc.s V_57
IL_0a76: ldloc.s V_57
IL_0a78: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0a7d: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0a82: brfalse.s IL_0aa4
IL_0a84: ldloc.s V_57
IL_0a86: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0a8b: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0a90: stloc.s V_27
IL_0a92: ldloca.s V_27
IL_0a94: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0a99: brfalse.s IL_0aa4
IL_0a9b: ldloc.s V_57
IL_0a9d: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0aa2: br.s IL_0aa5
IL_0aa4: ldc.i4.0
IL_0aa5: stloc.s V_58
IL_0aa7: ldloc.s V_58
IL_0aa9: brfalse.s IL_0abe
IL_0aab: ldloc.1
IL_0aac: ldloc.s V_57
IL_0aae: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0ab3: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0ab8: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0abd: nop
IL_0abe: ldloc.s V_56
IL_0ac0: ldc.i4.1
IL_0ac1: add
IL_0ac2: stloc.s V_56
IL_0ac4: ldloc.s V_56
IL_0ac6: ldloc.s V_55
IL_0ac8: ldlen
IL_0ac9: conv.i4
IL_0aca: blt.s IL_0a6f
IL_0acc: nop
IL_0acd: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.MonoBehaviour>()
IL_0ad2: stloc.s V_59
IL_0ad4: ldc.i4.0
IL_0ad5: stloc.s V_60
IL_0ad7: br IL_0b60
IL_0adc: ldloc.s V_59
IL_0ade: ldloc.s V_60
IL_0ae0: ldelem.ref
IL_0ae1: stloc.s V_61
IL_0ae3: ldloc.s V_61
IL_0ae5: ldnull
IL_0ae6: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0aeb: brfalse.s IL_0b2a
IL_0aed: ldloc.s V_61
IL_0aef: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0af4: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0af9: brfalse.s IL_0b2a
IL_0afb: ldloc.s V_61
IL_0afd: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0b02: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0b07: stloc.s V_27
IL_0b09: ldloca.s V_27
IL_0b0b: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0b10: brfalse.s IL_0b2a
IL_0b12: ldloc.s V_61
IL_0b14: callvirt System.Type System.Object::GetType()
IL_0b19: callvirt System.String System.Type::get_Namespace()
IL_0b1e: ldstr "TheForestOfLove"
IL_0b23: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0b28: br.s IL_0b2b
IL_0b2a: ldc.i4.0
IL_0b2b: stloc.s V_62
IL_0b2d: ldloc.s V_62
IL_0b2f: brfalse.s IL_0b5a
IL_0b31: ldloc.2
IL_0b32: ldloc.s V_61
IL_0b34: callvirt System.Type System.Object::GetType()
IL_0b39: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0b3e: ldstr " "
IL_0b43: ldloc.s V_61
IL_0b45: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0b4a: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0b4f: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0b54: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0b59: nop
IL_0b5a: ldloc.s V_60
IL_0b5c: ldc.i4.1
IL_0b5d: add
IL_0b5e: stloc.s V_60
IL_0b60: ldloc.s V_60
IL_0b62: ldloc.s V_59
IL_0b64: ldlen
IL_0b65: conv.i4
IL_0b66: blt IL_0adc
IL_0b6b: nop
IL_0b6c: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<UnityEngine.UI.Image>()
IL_0b71: stloc.s V_63
IL_0b73: ldc.i4.0
IL_0b74: stloc.s V_64
IL_0b76: br IL_0d76
IL_0b7b: ldloc.s V_63
IL_0b7d: ldloc.s V_64
IL_0b7f: ldelem.ref
IL_0b80: stloc.s V_65
IL_0b82: ldloc.s V_65
IL_0b84: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0b89: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0b8e: stloc.s V_27
IL_0b90: ldloca.s V_27
IL_0b92: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_0b97: brfalse.s IL_0bb1
IL_0b99: ldloc.s V_65
IL_0b9b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0ba0: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0ba5: ldstr "Canvas/OptionsMenu/"
IL_0baa: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0baf: br.s IL_0bb2
IL_0bb1: ldc.i4.0
IL_0bb2: stloc.s V_66
IL_0bb4: ldloc.s V_66
IL_0bb6: brfalse IL_0d70
IL_0bbb: nop
IL_0bbc: ldc.i4.4
IL_0bbd: newarr UnityEngine.Vector3
IL_0bc2: stloc.s V_67
IL_0bc4: ldloc.s V_65
IL_0bc6: callvirt UnityEngine.RectTransform UnityEngine.UI.Graphic::get_rectTransform()
IL_0bcb: ldloc.s V_67
IL_0bcd: callvirt System.Void UnityEngine.RectTransform::GetWorldCorners(UnityEngine.Vector3[])
IL_0bd2: nop
IL_0bd3: ldloc.s V_9
IL_0bd5: ldc.i4.s 23
IL_0bd7: newarr System.String
IL_0bdc: dup
IL_0bdd: ldc.i4.0
IL_0bde: ldloc.s V_65
IL_0be0: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0be5: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0bea: stelem.ref
IL_0beb: dup
IL_0bec: ldc.i4.1
IL_0bed: ldstr " | activeSelf="
IL_0bf2: stelem.ref
IL_0bf3: dup
IL_0bf4: ldc.i4.2
IL_0bf5: ldloc.s V_65
IL_0bf7: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0bfc: callvirt System.Boolean UnityEngine.GameObject::get_activeSelf()
IL_0c01: stloc.s V_29
IL_0c03: ldloca.s V_29
IL_0c05: call System.String System.Boolean::ToString()
IL_0c0a: stelem.ref
IL_0c0b: dup
IL_0c0c: ldc.i4.3
IL_0c0d: ldstr " | activeInHierarchy="
IL_0c12: stelem.ref
IL_0c13: dup
IL_0c14: ldc.i4.4
IL_0c15: ldloc.s V_65
IL_0c17: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0c1c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0c21: stloc.s V_29
IL_0c23: ldloca.s V_29
IL_0c25: call System.String System.Boolean::ToString()
IL_0c2a: stelem.ref
IL_0c2b: dup
IL_0c2c: ldc.i4.5
IL_0c2d: ldstr " | sprite="
IL_0c32: stelem.ref
IL_0c33: dup
IL_0c34: ldc.i4.6
IL_0c35: ldloc.s V_65
IL_0c37: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0c3c: ldnull
IL_0c3d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0c42: brtrue.s IL_0c52
IL_0c44: ldloc.s V_65
IL_0c46: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0c4b: callvirt System.String UnityEngine.Object::get_name()
IL_0c50: br.s IL_0c57
IL_0c52: ldstr "null"
IL_0c57: stelem.ref
IL_0c58: dup
IL_0c59: ldc.i4.7
IL_0c5a: ldstr " | enabled="
IL_0c5f: stelem.ref
IL_0c60: dup
IL_0c61: ldc.i4.8
IL_0c62: ldloc.s V_65
IL_0c64: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0c69: stloc.s V_29
IL_0c6b: ldloca.s V_29
IL_0c6d: call System.String System.Boolean::ToString()
IL_0c72: stelem.ref
IL_0c73: dup
IL_0c74: ldc.i4.s 9
IL_0c76: ldstr " | instance="
IL_0c7b: stelem.ref
IL_0c7c: dup
IL_0c7d: ldc.i4.s 10
IL_0c7f: ldloc.s V_65
IL_0c81: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0c86: stloc.s V_53
IL_0c88: ldloca.s V_53
IL_0c8a: call System.String System.Int32::ToString()
IL_0c8f: stelem.ref
IL_0c90: dup
IL_0c91: ldc.i4.s 11
IL_0c93: ldstr " | color="
IL_0c98: stelem.ref
IL_0c99: dup
IL_0c9a: ldc.i4.s 12
IL_0c9c: ldloc.s V_65
IL_0c9e: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_0ca3: stloc.s V_68
IL_0ca5: ldloca.s V_68
IL_0ca7: constrained. UnityEngine.Color
IL_0cad: callvirt System.String System.Object::ToString()
IL_0cb2: stelem.ref
IL_0cb3: dup
IL_0cb4: ldc.i4.s 13
IL_0cb6: ldstr " | canvasAlpha="
IL_0cbb: stelem.ref
IL_0cbc: dup
IL_0cbd: ldc.i4.s 14
IL_0cbf: ldloc.s V_65
IL_0cc1: callvirt UnityEngine.CanvasRenderer UnityEngine.UI.Graphic::get_canvasRenderer()
IL_0cc6: callvirt System.Single UnityEngine.CanvasRenderer::GetAlpha()
IL_0ccb: stloc.s V_28
IL_0ccd: ldloca.s V_28
IL_0ccf: call System.String System.Single::ToString()
IL_0cd4: stelem.ref
IL_0cd5: dup
IL_0cd6: ldc.i4.s 15
IL_0cd8: ldstr " | culled="
IL_0cdd: stelem.ref
IL_0cde: dup
IL_0cdf: ldc.i4.s 16
IL_0ce1: ldloc.s V_65
IL_0ce3: callvirt UnityEngine.CanvasRenderer UnityEngine.UI.Graphic::get_canvasRenderer()
IL_0ce8: callvirt System.Boolean UnityEngine.CanvasRenderer::get_cull()
IL_0ced: stloc.s V_29
IL_0cef: ldloca.s V_29
IL_0cf1: call System.String System.Boolean::ToString()
IL_0cf6: stelem.ref
IL_0cf7: dup
IL_0cf8: ldc.i4.s 17
IL_0cfa: ldstr " | material="
IL_0cff: stelem.ref
IL_0d00: dup
IL_0d01: ldc.i4.s 18
IL_0d03: ldloc.s V_65
IL_0d05: callvirt UnityEngine.Material UnityEngine.UI.Graphic::get_materialForRendering()
IL_0d0a: ldnull
IL_0d0b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0d10: brtrue.s IL_0d20
IL_0d12: ldloc.s V_65
IL_0d14: callvirt UnityEngine.Material UnityEngine.UI.Graphic::get_materialForRendering()
IL_0d19: callvirt System.String UnityEngine.Object::get_name()
IL_0d1e: br.s IL_0d25
IL_0d20: ldstr "null"
IL_0d25: stelem.ref
IL_0d26: dup
IL_0d27: ldc.i4.s 19
IL_0d29: ldstr " | worldBottomLeft="
IL_0d2e: stelem.ref
IL_0d2f: dup
IL_0d30: ldc.i4.s 20
IL_0d32: ldloc.s V_67
IL_0d34: ldc.i4.0
IL_0d35: ldelema UnityEngine.Vector3
IL_0d3a: ldstr "R"
IL_0d3f: call System.String UnityEngine.Vector3::ToString(System.String)
IL_0d44: stelem.ref
IL_0d45: dup
IL_0d46: ldc.i4.s 21
IL_0d48: ldstr " | worldTopRight="
IL_0d4d: stelem.ref
IL_0d4e: dup
IL_0d4f: ldc.i4.s 22
IL_0d51: ldloc.s V_67
IL_0d53: ldc.i4.2
IL_0d54: ldelema UnityEngine.Vector3
IL_0d59: ldstr "R"
IL_0d5e: call System.String UnityEngine.Vector3::ToString(System.String)
IL_0d63: stelem.ref
IL_0d64: call System.String System.String::Concat(System.String[])
IL_0d69: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0d6e: nop
IL_0d6f: nop
IL_0d70: ldloc.s V_64
IL_0d72: ldc.i4.1
IL_0d73: add
IL_0d74: stloc.s V_64
IL_0d76: ldloc.s V_64
IL_0d78: ldloc.s V_63
IL_0d7a: ldlen
IL_0d7b: conv.i4
IL_0d7c: blt IL_0b7b
IL_0d81: newobj System.Void ForestProbe/State::.ctor()
IL_0d86: dup
IL_0d87: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0d8c: stloc.s V_27
IL_0d8e: ldloca.s V_27
IL_0d90: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0d95: stfld System.String ForestProbe/State::scene
IL_0d9a: dup
IL_0d9b: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0da0: stfld System.Int32 ForestProbe/State::frame
IL_0da5: dup
IL_0da6: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0dab: stfld System.Single ForestProbe/State::realtime
IL_0db0: dup
IL_0db1: call System.Single UnityEngine.Time::get_time()
IL_0db6: stfld System.Single ForestProbe/State::scaledTime
IL_0dbb: dup
IL_0dbc: call System.Single UnityEngine.Time::get_timeScale()
IL_0dc1: stfld System.Single ForestProbe/State::timeScale
IL_0dc6: dup
IL_0dc7: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0dcc: stfld System.String ForestProbe/State::narrativeDbName
IL_0dd1: dup
IL_0dd2: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_0dd7: stfld System.String ForestProbe/State::narrativeArcName
IL_0ddc: dup
IL_0ddd: call System.String UnityEngine.Application::get_dataPath()
IL_0de2: stfld System.String ForestProbe/State::dataPath
IL_0de7: dup
IL_0de8: call System.String UnityEngine.Application::get_persistentDataPath()
IL_0ded: stfld System.String ForestProbe/State::persistentDataPath
IL_0df2: dup
IL_0df3: call System.String UnityEngine.Application::get_companyName()
IL_0df8: stfld System.String ForestProbe/State::company
IL_0dfd: dup
IL_0dfe: call System.String UnityEngine.Application::get_productName()
IL_0e03: stfld System.String ForestProbe/State::product
IL_0e08: dup
IL_0e09: call System.Int32 UnityEngine.Screen::get_width()
IL_0e0e: stfld System.Int32 ForestProbe/State::width
IL_0e13: dup
IL_0e14: call System.Int32 UnityEngine.Screen::get_height()
IL_0e19: stfld System.Int32 ForestProbe/State::height
IL_0e1e: dup
IL_0e1f: ldloc.0
IL_0e20: callvirt !0[] System.Collections.Generic.List`1<ForestProbe/TextRow>::ToArray()
IL_0e25: stfld ForestProbe/TextRow[] ForestProbe/State::texts
IL_0e2a: dup
IL_0e2b: ldloc.1
IL_0e2c: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e31: stfld System.String[] ForestProbe/State::buttons
IL_0e36: dup
IL_0e37: ldloc.2
IL_0e38: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e3d: stfld System.String[] ForestProbe/State::components
IL_0e42: dup
IL_0e43: ldloc.s V_4
IL_0e45: ldlen
IL_0e46: conv.i4
IL_0e47: stfld System.Int32 ForestProbe/State::tmpObjectCount
IL_0e4c: dup
IL_0e4d: ldloc.s V_5
IL_0e4f: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e54: stfld System.String[] ForestProbe/State::rendererDiagnostics
IL_0e59: dup
IL_0e5a: ldloc.s V_6
IL_0e5c: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e61: stfld System.String[] ForestProbe/State::subtitleGlyphDiagnostics
IL_0e66: dup
IL_0e67: ldloc.s V_7
IL_0e69: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e6e: stfld System.String[] ForestProbe/State::settingsGlyphDiagnostics
IL_0e73: dup
IL_0e74: ldloc.s V_8
IL_0e76: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e7b: stfld System.String[] ForestProbe/State::settingsLayoutDiagnostics
IL_0e80: dup
IL_0e81: ldloc.s V_9
IL_0e83: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0e88: stfld System.String[] ForestProbe/State::settingsControlDiagnostics
IL_0e8d: dup
IL_0e8e: call System.Boolean TheForestOfLove.UI.WindowController::get_IsFullscreen()
IL_0e93: stfld System.Boolean ForestProbe/State::fullscreen
IL_0e98: dup
IL_0e99: call System.Boolean TheForestOfLove.UI.WindowController::get_EnableFullscreenStretch()
IL_0e9e: stfld System.Boolean ForestProbe/State::stretch
IL_0ea3: dup
IL_0ea4: call System.Int32 TheForestOfLove.UI.WindowController::get_WindowScalingIndex()
IL_0ea9: stfld System.Int32 ForestProbe/State::scaleIndex
IL_0eae: dup
IL_0eaf: call UnityEngine.Resolution UnityEngine.Screen::get_currentResolution()
IL_0eb4: stloc.s V_69
IL_0eb6: ldloca.s V_69
IL_0eb8: call System.Int32 UnityEngine.Resolution::get_width()
IL_0ebd: stfld System.Int32 ForestProbe/State::displayWidth
IL_0ec2: dup
IL_0ec3: call UnityEngine.Resolution UnityEngine.Screen::get_currentResolution()
IL_0ec8: stloc.s V_69
IL_0eca: ldloca.s V_69
IL_0ecc: call System.Int32 UnityEngine.Resolution::get_height()
IL_0ed1: stfld System.Int32 ForestProbe/State::displayHeight
IL_0ed6: dup
IL_0ed7: call System.Boolean TheForestOfLove.UI.WindowController::CanScaleUp()
IL_0edc: stfld System.Boolean ForestProbe/State::canScaleUp
IL_0ee1: dup
IL_0ee2: call System.Boolean TheForestOfLove.UI.WindowController::CanScaleDown()
IL_0ee7: stfld System.Boolean ForestProbe/State::canScaleDown
IL_0eec: dup
IL_0eed: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0ef2: ldnull
IL_0ef3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0ef8: brtrue.s IL_0f22
IL_0efa: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0eff: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0f04: ldnull
IL_0f05: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0f0a: brtrue.s IL_0f22
IL_0f0c: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0f11: callvirt UnityEngine.GameObject UnityEngine.EventSystems.EventSystem::get_currentSelectedGameObject()
IL_0f16: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0f1b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0f20: br.s IL_0f27
IL_0f22: ldstr ""
IL_0f27: stfld System.String ForestProbe/State::selectedControl
IL_0f2c: dup
IL_0f2d: ldloc.s V_10
IL_0f2f: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0f34: stfld System.String[] ForestProbe/State::scaleEligibility
IL_0f39: dup
IL_0f3a: ldloc.s V_11
IL_0f3c: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0f41: stfld System.String[] ForestProbe/State::scaleControlState
IL_0f46: dup
IL_0f47: ldloc.3
IL_0f48: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_0f4d: stfld System.Int32 ForestProbe/State::responseCount
IL_0f52: dup
IL_0f53: ldloc.3
IL_0f54: ldsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__64_0
IL_0f59: dup
IL_0f5a: brtrue.s IL_0f73
IL_0f5c: pop
IL_0f5d: ldsfld ForestProbe/<>c ForestProbe/<>c::<>9
IL_0f62: ldftn System.String ForestProbe/<>c::<Dump>b__64_0(ForestProbe/ResponseRow)
IL_0f68: newobj System.Void System.Converter`2<ForestProbe/ResponseRow,System.String>::.ctor(System.Object,System.IntPtr)
IL_0f6d: dup
IL_0f6e: stsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__64_0
IL_0f73: callvirt System.Collections.Generic.List`1<!!0> System.Collections.Generic.List`1<ForestProbe/ResponseRow>::ConvertAll<System.String>(System.Converter`2<!0,!!0>)
IL_0f78: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0f7d: stfld System.String[] ForestProbe/State::responseRecords
IL_0f82: dup
IL_0f83: call System.Boolean TheForestOfLove.CustomTypewriterEffectTextMeshPro::IsTyping()
IL_0f88: stfld System.Boolean ForestProbe/State::typing
IL_0f8d: stloc.s V_13
IL_0f8f: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.CustomTypewriterEffectTextMeshPro>()
IL_0f94: stloc.s V_14
IL_0f96: ldloc.s V_13
IL_0f98: ldloc.s V_14
IL_0f9a: ldnull
IL_0f9b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0fa0: brtrue.s IL_0fab
IL_0fa2: ldloc.s V_14
IL_0fa4: callvirt System.String TheForestOfLove.CustomTypewriterEffectTextMeshPro::get_CurrentVisibleText()
IL_0fa9: br.s IL_0fb0
IL_0fab: ldstr ""
IL_0fb0: stfld System.String ForestProbe/State::visibleTypewriterText
IL_0fb5: ldarg.0
IL_0fb6: ldloc.s V_13
IL_0fb8: call System.Void ForestProbe::ReadConversation(ForestProbe/State)
IL_0fbd: nop
IL_0fbe: ldarg.0
IL_0fbf: ldloc.s V_13
IL_0fc1: call System.Void ForestProbe::ReadTutorialCompletionRecord(ForestProbe/State)
IL_0fc6: nop
IL_0fc7: ldarg.0
IL_0fc8: ldfld System.String ForestProbe::root
IL_0fcd: ldstr "state.json"
IL_0fd2: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0fd7: ldloc.s V_13
IL_0fd9: ldc.i4.1
IL_0fda: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0fdf: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0fe4: nop
IL_0fe5: ret
