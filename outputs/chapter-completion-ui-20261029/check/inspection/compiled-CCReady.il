TYPE ForestProbe
METHOD System.Void ForestProbe::CCReady(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.0
IL_0003: ldfld UnityEngine.Component ForestProbe::cgConsumer
IL_0008: ldnull
IL_0009: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000e: brfalse.s IL_001e
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.Behaviour ForestProbe::ccPaused
IL_0016: ldnull
IL_0017: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_001c: br.s IL_001f
IL_001e: ldc.i4.0
IL_001f: ldstr "restore-current-surface-first"
IL_0024: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_0029: nop
IL_002a: ldarg.0
IL_002b: ldarg.1
IL_002c: ldstr "oos"
IL_0031: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0036: brtrue.s IL_0045
IL_0038: ldarg.1
IL_0039: ldstr "description"
IL_003e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0043: br.s IL_0046
IL_0045: ldc.i4.1
IL_0046: ldstr "only-two-completion-surfaces"
IL_004b: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_0050: nop
IL_0051: ldarg.0
IL_0052: call System.Void ForestProbe::CGReadback()
IL_0057: nop
IL_0058: ldarg.0
IL_0059: ldarg.0
IL_005a: ldfld System.String ForestProbe::root
IL_005f: ldstr "cg-readback.tsv"
IL_0064: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0069: call System.String System.IO.File::ReadAllText(System.String)
IL_006e: stfld System.String ForestProbe::ccBeforeValues
IL_0073: ldarg.1
IL_0074: ldstr "oos"
IL_0079: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_007e: stloc.s V_5
IL_0080: ldloc.s V_5
IL_0082: brfalse.s IL_0096
IL_0084: nop
IL_0085: ldarg.0
IL_0086: call System.Void ForestProbe::CCFactory()
IL_008b: nop
IL_008c: ldarg.0
IL_008d: ldfld UnityEngine.Component ForestProbe::ccCreated
IL_0092: stloc.0
IL_0093: nop
IL_0094: br.s IL_00ef
IL_0096: nop
IL_0097: ldarg.0
IL_0098: ldstr "ChapterSelectUI"
IL_009d: ldstr "LevelSingletons/ChapterSelectUI/ChapterSelectUI"
IL_00a2: ldc.i4.1
IL_00a3: call UnityEngine.Component ForestProbe::CCExact(System.String,System.String,System.Boolean)
IL_00a8: stloc.0
IL_00a9: ldarg.0
IL_00aa: ldloc.0
IL_00ab: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00b0: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_00b5: ldstr "description-original-panel-inactive-route-required"
IL_00ba: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_00bf: nop
IL_00c0: ldarg.0
IL_00c1: ldloc.0
IL_00c2: callvirt System.Type System.Object::GetType()
IL_00c7: ldstr "visible"
IL_00cc: ldarg.0
IL_00cd: ldfld System.Reflection.BindingFlags ForestProbe::cgFlags
IL_00d2: callvirt System.Reflection.PropertyInfo System.Type::GetProperty(System.String,System.Reflection.BindingFlags)
IL_00d7: ldnull
IL_00d8: ldnull
IL_00d9: callvirt System.Object System.Reflection.PropertyInfo::GetValue(System.Object,System.Object[])
IL_00de: unbox.any System.Boolean
IL_00e3: ldstr "description-original-show-route-required"
IL_00e8: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_00ed: nop
IL_00ee: nop
IL_00ef: ldarg.0
IL_00f0: ldloc.0
IL_00f1: ldarg.1
IL_00f2: ldstr "oos"
IL_00f7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00fc: brtrue.s IL_0105
IL_00fe: ldstr "tooltipContainer"
IL_0103: br.s IL_010a
IL_0105: ldstr "chapterNameLabelRoot"
IL_010a: call System.Object ForestProbe::CGField(System.Object,System.String)
IL_010f: isinst UnityEngine.GameObject
IL_0114: stloc.1
IL_0115: ldarg.0
IL_0116: ldloc.1
IL_0117: ldnull
IL_0118: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_011d: brfalse.s IL_0127
IL_011f: ldloc.1
IL_0120: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0125: br.s IL_0128
IL_0127: ldc.i4.0
IL_0128: ldstr "original-text-root-inactive"
IL_012d: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_0132: nop
IL_0133: ldloc.1
IL_0134: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TMPro.TMP_Text>()
IL_0139: stloc.2
IL_013a: ldarg.0
IL_013b: ldloc.2
IL_013c: ldlen
IL_013d: conv.i4
IL_013e: ldc.i4.6
IL_013f: ceq
IL_0141: ldstr "source-six-label-membership"
IL_0146: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_014b: nop
IL_014c: ldc.i4.0
IL_014d: stloc.3
IL_014e: ldc.i4.0
IL_014f: stloc.s V_4
IL_0151: nop
IL_0152: ldloc.2
IL_0153: stloc.s V_6
IL_0155: ldc.i4.0
IL_0156: stloc.s V_7
IL_0158: br IL_02e2
IL_015d: ldloc.s V_6
IL_015f: ldloc.s V_7
IL_0161: ldelem.ref
IL_0162: stloc.s V_8
IL_0164: nop
IL_0165: ldarg.0
IL_0166: ldloc.s V_8
IL_0168: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_016d: call System.String ForestProbe::CGPath(UnityEngine.Transform)
IL_0172: ldstr "(Clone)"
IL_0177: ldstr ""
IL_017c: callvirt System.String System.String::Replace(System.String,System.String)
IL_0181: stloc.s V_9
IL_0183: ldc.i4.0
IL_0184: stloc.s V_10
IL_0186: nop
IL_0187: ldarg.0
IL_0188: ldfld System.String ForestProbe::root
IL_018d: ldstr "cc-selectors.tsv"
IL_0192: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0197: call System.String[] System.IO.File::ReadAllLines(System.String)
IL_019c: stloc.s V_11
IL_019e: ldc.i4.0
IL_019f: stloc.s V_12
IL_01a1: br.s IL_0208
IL_01a3: ldloc.s V_11
IL_01a5: ldloc.s V_12
IL_01a7: ldelem.ref
IL_01a8: stloc.s V_13
IL_01aa: nop
IL_01ab: ldloc.s V_13
IL_01ad: ldc.i4.1
IL_01ae: newarr System.Char
IL_01b3: dup
IL_01b4: ldc.i4.0
IL_01b5: ldc.i4.s 9
IL_01b7: stelem.i2
IL_01b8: callvirt System.String[] System.String::Split(System.Char[])
IL_01bd: stloc.s V_14
IL_01bf: ldloc.s V_14
IL_01c1: ldc.i4.0
IL_01c2: ldelem.ref
IL_01c3: ldarg.1
IL_01c4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01c9: brfalse.s IL_01f7
IL_01cb: ldloc.s V_9
IL_01cd: ldloc.s V_14
IL_01cf: ldc.i4.1
IL_01d0: ldelem.ref
IL_01d1: ldc.i4.4
IL_01d2: callvirt System.Boolean System.String::EndsWith(System.String,System.StringComparison)
IL_01d7: brfalse.s IL_01f7
IL_01d9: ldloc.s V_8
IL_01db: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_01e0: ldfld System.Single UnityEngine.Color::a
IL_01e5: ldloc.s V_14
IL_01e7: ldc.i4.2
IL_01e8: ldelem.ref
IL_01e9: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()
IL_01ee: call System.Single System.Single::Parse(System.String,System.IFormatProvider)
IL_01f3: ceq
IL_01f5: br.s IL_01f8
IL_01f7: ldc.i4.0
IL_01f8: stloc.s V_15
IL_01fa: ldloc.s V_15
IL_01fc: brfalse.s IL_0201
IL_01fe: ldc.i4.1
IL_01ff: stloc.s V_10
IL_0201: nop
IL_0202: ldloc.s V_12
IL_0204: ldc.i4.1
IL_0205: add
IL_0206: stloc.s V_12
IL_0208: ldloc.s V_12
IL_020a: ldloc.s V_11
IL_020c: ldlen
IL_020d: conv.i4
IL_020e: blt.s IL_01a3
IL_0210: ldarg.0
IL_0211: ldloc.s V_10
IL_0213: brfalse.s IL_022d
IL_0215: ldloc.s V_8
IL_0217: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_021c: brfalse.s IL_022d
IL_021e: ldloc.s V_8
IL_0220: callvirt TMPro.TMP_FontAsset TMPro.TMP_Text::get_font()
IL_0225: ldnull
IL_0226: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_022b: br.s IL_022e
IL_022d: ldc.i4.0
IL_022e: ldstr "native-selector-alpha-or-font-differs"
IL_0233: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_0238: nop
IL_0239: ldloc.s V_8
IL_023b: callvirt UnityEngine.Color UnityEngine.UI.Graphic::get_color()
IL_0240: ldfld System.Single UnityEngine.Color::a
IL_0245: ldc.r4 0
IL_024a: ceq
IL_024c: stloc.s V_16
IL_024e: ldloc.s V_16
IL_0250: brfalse.s IL_025b
IL_0252: ldloc.3
IL_0253: ldc.i4.1
IL_0254: add
IL_0255: stloc.3
IL_0256: br IL_02db
IL_025b: nop
IL_025c: ldloc.s V_4
IL_025e: ldc.i4.1
IL_025f: add
IL_0260: stloc.s V_4
IL_0262: ldloc.s V_8
IL_0264: callvirt UnityEngine.CanvasRenderer UnityEngine.UI.Graphic::get_canvasRenderer()
IL_0269: callvirt System.Single UnityEngine.CanvasRenderer::GetAlpha()
IL_026e: stloc.s V_17
IL_0270: ldloc.s V_8
IL_0272: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_0277: stloc.s V_18
IL_0279: br.s IL_02b4
IL_027b: nop
IL_027c: ldloc.s V_18
IL_027e: callvirt !!0[] UnityEngine.Component::GetComponents<UnityEngine.CanvasGroup>()
IL_0283: stloc.s V_19
IL_0285: ldc.i4.0
IL_0286: stloc.s V_20
IL_0288: br.s IL_02a3
IL_028a: ldloc.s V_19
IL_028c: ldloc.s V_20
IL_028e: ldelem.ref
IL_028f: stloc.s V_21
IL_0291: ldloc.s V_17
IL_0293: ldloc.s V_21
IL_0295: callvirt System.Single UnityEngine.CanvasGroup::get_alpha()
IL_029a: mul
IL_029b: stloc.s V_17
IL_029d: ldloc.s V_20
IL_029f: ldc.i4.1
IL_02a0: add
IL_02a1: stloc.s V_20
IL_02a3: ldloc.s V_20
IL_02a5: ldloc.s V_19
IL_02a7: ldlen
IL_02a8: conv.i4
IL_02a9: blt.s IL_028a
IL_02ab: ldloc.s V_18
IL_02ad: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_02b2: stloc.s V_18
IL_02b4: ldloc.s V_18
IL_02b6: ldnull
IL_02b7: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_02bc: stloc.s V_22
IL_02be: ldloc.s V_22
IL_02c0: brtrue.s IL_027b
IL_02c2: ldarg.0
IL_02c3: ldloc.s V_17
IL_02c5: ldc.r4 0.99
IL_02ca: clt.un
IL_02cc: ldc.i4.0
IL_02cd: ceq
IL_02cf: ldstr "source-visible-face-hidden-establish-original-route"
IL_02d4: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_02d9: nop
IL_02da: nop
IL_02db: nop
IL_02dc: ldloc.s V_7
IL_02de: ldc.i4.1
IL_02df: add
IL_02e0: stloc.s V_7
IL_02e2: ldloc.s V_7
IL_02e4: ldloc.s V_6
IL_02e6: ldlen
IL_02e7: conv.i4
IL_02e8: blt IL_015d
IL_02ed: ldarg.0
IL_02ee: ldloc.3
IL_02ef: ldc.i4.1
IL_02f0: bne.un.s IL_02f9
IL_02f2: ldloc.s V_4
IL_02f4: ldc.i4.5
IL_02f5: ceq
IL_02f7: br.s IL_02fa
IL_02f9: ldc.i4.0
IL_02fa: ldstr "one-height-provider-five-faces-required"
IL_02ff: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_0304: nop
IL_0305: ldarg.0
IL_0306: ldloc.0
IL_0307: isinst UnityEngine.Behaviour
IL_030c: stfld UnityEngine.Behaviour ForestProbe::ccPaused
IL_0311: ldarg.0
IL_0312: ldarg.0
IL_0313: ldfld UnityEngine.Behaviour ForestProbe::ccPaused
IL_0318: ldnull
IL_0319: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_031e: ldstr "consumer-not-behaviour"
IL_0323: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_0328: nop
IL_0329: ldarg.0
IL_032a: ldarg.0
IL_032b: ldfld UnityEngine.Behaviour ForestProbe::ccPaused
IL_0330: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0335: stfld System.Boolean ForestProbe::ccEnabled
IL_033a: ldarg.1
IL_033b: ldstr "description"
IL_0340: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0345: stloc.s V_23
IL_0347: ldloc.s V_23
IL_0349: brfalse IL_03d8
IL_034e: nop
IL_034f: ldarg.0
IL_0350: ldloc.0
IL_0351: callvirt System.Type System.Object::GetType()
IL_0356: ldstr "LockInteractions"
IL_035b: ldarg.0
IL_035c: ldfld System.Reflection.BindingFlags ForestProbe::cgFlags
IL_0361: callvirt System.Reflection.PropertyInfo System.Type::GetProperty(System.String,System.Reflection.BindingFlags)
IL_0366: stfld System.Reflection.PropertyInfo ForestProbe::ccDescriptionLock
IL_036b: ldarg.0
IL_036c: ldarg.0
IL_036d: ldfld System.Reflection.PropertyInfo ForestProbe::ccDescriptionLock
IL_0372: ldnull
IL_0373: call System.Boolean System.Reflection.PropertyInfo::op_Inequality(System.Reflection.PropertyInfo,System.Reflection.PropertyInfo)
IL_0378: ldstr "description-lock-schema"
IL_037d: call System.Void ForestProbe::CCRequire(System.Boolean,System.String)
IL_0382: nop
IL_0383: ldarg.0
IL_0384: ldarg.0
IL_0385: ldfld System.Reflection.PropertyInfo ForestProbe::ccDescriptionLock
IL_038a: ldloc.0
IL_038b: ldnull
IL_038c: callvirt System.Object System.Reflection.PropertyInfo::GetValue(System.Object,System.Object[])
IL_0391: unbox.any System.Boolean
IL_0396: stfld System.Boolean ForestProbe::ccDescriptionWasLocked
IL_039b: ldarg.0
IL_039c: ldfld System.Reflection.PropertyInfo ForestProbe::ccDescriptionLock
IL_03a1: ldloc.0
IL_03a2: ldc.i4.1
IL_03a3: box System.Boolean
IL_03a8: ldnull
IL_03a9: callvirt System.Void System.Reflection.PropertyInfo::SetValue(System.Object,System.Object,System.Object[])
IL_03ae: nop
IL_03af: ldarg.0
IL_03b0: ldarg.0
IL_03b1: ldloc.0
IL_03b2: ldstr "visibleContentContainerVerticalLayoutGroup"
IL_03b7: call System.Object ForestProbe::CGField(System.Object,System.String)
IL_03bc: castclass UnityEngine.UI.VerticalLayoutGroup
IL_03c1: stfld UnityEngine.UI.VerticalLayoutGroup ForestProbe::ccDescriptionLayout
IL_03c6: ldarg.0
IL_03c7: ldarg.0
IL_03c8: ldfld UnityEngine.UI.VerticalLayoutGroup ForestProbe::ccDescriptionLayout
IL_03cd: callvirt System.Single UnityEngine.UI.HorizontalOrVerticalLayoutGroup::get_spacing()
IL_03d2: stfld System.Single ForestProbe::ccDescriptionSpacing
IL_03d7: nop
IL_03d8: ldarg.0
IL_03d9: ldloc.0
IL_03da: stfld UnityEngine.Component ForestProbe::cgConsumer
IL_03df: ldarg.0
IL_03e0: ldloc.2
IL_03e1: stfld TMPro.TMP_Text[] ForestProbe::cgLabels
IL_03e6: ldarg.0
IL_03e7: ldarg.1
IL_03e8: stfld System.String ForestProbe::cgSurface
IL_03ed: nop
IL_03ee: ldloc.2
IL_03ef: stloc.s V_24
IL_03f1: ldc.i4.0
IL_03f2: stloc.s V_25
IL_03f4: br.s IL_0418
IL_03f6: ldloc.s V_24
IL_03f8: ldloc.s V_25
IL_03fa: ldelem.ref
IL_03fb: stloc.s V_26
IL_03fd: ldarg.0
IL_03fe: ldfld System.Collections.Generic.Dictionary`2<TMPro.TMP_Text,System.String> ForestProbe::cgSaved
IL_0403: ldloc.s V_26
IL_0405: ldloc.s V_26
IL_0407: callvirt System.String TMPro.TMP_Text::get_text()
IL_040c: callvirt System.Void System.Collections.Generic.Dictionary`2<TMPro.TMP_Text,System.String>::Add(!0,!1)
IL_0411: nop
IL_0412: ldloc.s V_25
IL_0414: ldc.i4.1
IL_0415: add
IL_0416: stloc.s V_25
IL_0418: ldloc.s V_25
IL_041a: ldloc.s V_24
IL_041c: ldlen
IL_041d: conv.i4
IL_041e: blt.s IL_03f6
IL_0420: ldarg.0
IL_0421: ldfld System.String ForestProbe::root
IL_0426: ldstr "cc-ready.txt"
IL_042b: call System.String System.IO.Path::Combine(System.String,System.String)
IL_0430: ldarg.1
IL_0431: ldstr "|"
IL_0436: ldarg.0
IL_0437: ldloc.1
IL_0438: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_043d: call System.String ForestProbe::CGPath(UnityEngine.Transform)
IL_0442: ldstr "|6|source-selected-role;no-progression-callbacks"
IL_0447: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_044c: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0451: nop
IL_0452: ret
