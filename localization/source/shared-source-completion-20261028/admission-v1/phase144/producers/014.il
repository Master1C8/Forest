TYPE TheForestOfLove.BlendModeAlphaGroup
METHOD System.Void TheForestOfLove.BlendModeAlphaGroup::SnapToTargetValues() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld System.Single TheForestOfLove.BlendModeAlphaGroup::duration
IL_0007: stfld System.Single TheForestOfLove.BlendModeAlphaGroup::elapsedTime
IL_000c: ldarg.0
IL_000d: ldc.i4.1
IL_000e: stfld System.Boolean TheForestOfLove.BlendModeAlphaGroup::finished
IL_0013: ldarg.0
IL_0014: ldfld BlendModes.BlendModeEffect[] TheForestOfLove.BlendModeAlphaGroup::blendModeEffects
IL_0019: stloc.0
IL_001a: ldc.i4.0
IL_001b: stloc.1
IL_001c: br.s IL_007e
IL_001e: ldloc.0
IL_001f: ldloc.1
IL_0020: ldelem.ref
IL_0021: stloc.2
IL_0022: ldarg.0
IL_0023: ldfld System.Collections.Generic.Dictionary`2<BlendModes.BlendModeEffect,UnityEngine.Color> TheForestOfLove.BlendModeAlphaGroup::originalColors
IL_0028: ldloc.2
IL_0029: callvirt !1 System.Collections.Generic.Dictionary`2<BlendModes.BlendModeEffect,UnityEngine.Color>::get_Item(!0)
IL_002e: stloc.3
IL_002f: ldarg.0
IL_0030: ldfld System.Boolean TheForestOfLove.BlendModeAlphaGroup::transparent
IL_0035: brtrue.s IL_003f
IL_0037: ldloc.3
IL_0038: ldfld System.Single UnityEngine.Color::a
IL_003d: br.s IL_0044
IL_003f: ldc.r4 0
IL_0044: stloc.s V_4
IL_0046: ldarg.0
IL_0047: ldfld System.Collections.Generic.Dictionary`2<BlendModes.BlendModeEffect,UnityEngine.Renderer> TheForestOfLove.BlendModeAlphaGroup::renderers
IL_004c: ldloc.2
IL_004d: callvirt !1 System.Collections.Generic.Dictionary`2<BlendModes.BlendModeEffect,UnityEngine.Renderer>::get_Item(!0)
IL_0052: callvirt UnityEngine.Material UnityEngine.Renderer::get_sharedMaterial()
IL_0057: ldstr "_Color"
IL_005c: ldloc.3
IL_005d: ldfld System.Single UnityEngine.Color::r
IL_0062: ldloc.3
IL_0063: ldfld System.Single UnityEngine.Color::g
IL_0068: ldloc.3
IL_0069: ldfld System.Single UnityEngine.Color::b
IL_006e: ldloc.s V_4
IL_0070: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single,System.Single)
IL_0075: callvirt System.Void UnityEngine.Material::SetColor(System.String,UnityEngine.Color)
IL_007a: ldloc.1
IL_007b: ldc.i4.1
IL_007c: add
IL_007d: stloc.1
IL_007e: ldloc.1
IL_007f: ldloc.0
IL_0080: ldlen
IL_0081: conv.i4
IL_0082: blt.s IL_001e
IL_0084: ret
METHOD System.Void TheForestOfLove.BlendModeAlphaGroup::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.BlendModeAlphaGroup::prevTransparent
IL_0006: ldarg.0
IL_0007: ldfld System.Boolean TheForestOfLove.BlendModeAlphaGroup::transparent
IL_000c: beq.s IL_002c
IL_000e: ldarg.0
IL_000f: ldarg.0
IL_0010: ldfld System.Boolean TheForestOfLove.BlendModeAlphaGroup::transparent
IL_0015: stfld System.Boolean TheForestOfLove.BlendModeAlphaGroup::prevTransparent
IL_001a: ldarg.0
IL_001b: ldc.r4 0
IL_0020: stfld System.Single TheForestOfLove.BlendModeAlphaGroup::elapsedTime
IL_0025: ldarg.0
IL_0026: ldc.i4.0
IL_0027: stfld System.Boolean TheForestOfLove.BlendModeAlphaGroup::finished
IL_002c: ldarg.0
IL_002d: ldarg.0
IL_002e: ldfld System.Single TheForestOfLove.BlendModeAlphaGroup::elapsedTime
IL_0033: call System.Single UnityEngine.Time::get_deltaTime()
IL_0038: add
IL_0039: stfld System.Single TheForestOfLove.BlendModeAlphaGroup::elapsedTime
IL_003e: ldarg.0
IL_003f: ldfld System.Single TheForestOfLove.BlendModeAlphaGroup::elapsedTime
IL_0044: ldarg.0
IL_0045: ldfld System.Single TheForestOfLove.BlendModeAlphaGroup::duration
IL_004a: blt.un.s IL_005b
IL_004c: ldarg.0
IL_004d: ldfld System.Boolean TheForestOfLove.BlendModeAlphaGroup::finished
IL_0052: brtrue.s IL_005a
IL_0054: ldarg.0
IL_0055: call System.Void TheForestOfLove.BlendModeAlphaGroup::SnapToTargetValues()
IL_005a: ret
IL_005b: ldarg.0
IL_005c: ldfld BlendModes.BlendModeEffect[] TheForestOfLove.BlendModeAlphaGroup::blendModeEffects
IL_0061: stloc.0
IL_0062: ldc.i4.0
IL_0063: stloc.1
IL_0064: br IL_00fb
IL_0069: ldloc.0
IL_006a: ldloc.1
IL_006b: ldelem.ref
IL_006c: stloc.2
IL_006d: ldarg.0
IL_006e: ldfld System.Collections.Generic.Dictionary`2<BlendModes.BlendModeEffect,UnityEngine.Color> TheForestOfLove.BlendModeAlphaGroup::originalColors
IL_0073: ldloc.2
IL_0074: callvirt !1 System.Collections.Generic.Dictionary`2<BlendModes.BlendModeEffect,UnityEngine.Color>::get_Item(!0)
IL_0079: stloc.3
IL_007a: ldarg.0
IL_007b: ldfld System.Collections.Generic.Dictionary`2<BlendModes.BlendModeEffect,UnityEngine.Renderer> TheForestOfLove.BlendModeAlphaGroup::renderers
IL_0080: ldloc.2
IL_0081: callvirt !1 System.Collections.Generic.Dictionary`2<BlendModes.BlendModeEffect,UnityEngine.Renderer>::get_Item(!0)
IL_0086: callvirt UnityEngine.Material UnityEngine.Renderer::get_sharedMaterial()
IL_008b: ldstr "_Color"
IL_0090: callvirt UnityEngine.Color UnityEngine.Material::GetColor(System.String)
IL_0095: ldfld System.Single UnityEngine.Color::a
IL_009a: ldarg.0
IL_009b: ldfld System.Boolean TheForestOfLove.BlendModeAlphaGroup::transparent
IL_00a0: brtrue.s IL_00aa
IL_00a2: ldloc.3
IL_00a3: ldfld System.Single UnityEngine.Color::a
IL_00a8: br.s IL_00af
IL_00aa: ldc.r4 0
IL_00af: ldarg.0
IL_00b0: ldfld System.Single TheForestOfLove.BlendModeAlphaGroup::elapsedTime
IL_00b5: ldarg.0
IL_00b6: ldfld System.Single TheForestOfLove.BlendModeAlphaGroup::duration
IL_00bb: div
IL_00bc: call System.Single UnityEngine.Mathf::Lerp(System.Single,System.Single,System.Single)
IL_00c1: stloc.s V_4
IL_00c3: ldarg.0
IL_00c4: ldfld System.Collections.Generic.Dictionary`2<BlendModes.BlendModeEffect,UnityEngine.Renderer> TheForestOfLove.BlendModeAlphaGroup::renderers
IL_00c9: ldloc.2
IL_00ca: callvirt !1 System.Collections.Generic.Dictionary`2<BlendModes.BlendModeEffect,UnityEngine.Renderer>::get_Item(!0)
IL_00cf: callvirt UnityEngine.Material UnityEngine.Renderer::get_sharedMaterial()
IL_00d4: ldstr "_Color"
IL_00d9: ldloc.3
IL_00da: ldfld System.Single UnityEngine.Color::r
IL_00df: ldloc.3
IL_00e0: ldfld System.Single UnityEngine.Color::g
IL_00e5: ldloc.3
IL_00e6: ldfld System.Single UnityEngine.Color::b
IL_00eb: ldloc.s V_4
IL_00ed: newobj System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single,System.Single)
IL_00f2: callvirt System.Void UnityEngine.Material::SetColor(System.String,UnityEngine.Color)
IL_00f7: ldloc.1
IL_00f8: ldc.i4.1
IL_00f9: add
IL_00fa: stloc.1
IL_00fb: ldloc.1
IL_00fc: ldloc.0
IL_00fd: ldlen
IL_00fe: conv.i4
IL_00ff: blt IL_0069
IL_0104: ret
