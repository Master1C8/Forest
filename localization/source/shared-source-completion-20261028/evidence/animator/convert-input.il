TYPE Febucci.UI.Core.TAnimCore
METHOD System.Void Febucci.UI.Core.TAnimCore::ConvertText(System.String,Febucci.UI.Core.TAnimCore/ShowTextMode) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_000a
IL_0003: ldsfld System.String System.String::Empty
IL_0008: starg.s textToParse
IL_000a: ldarg.0
IL_000b: call System.Void Febucci.UI.Core.TAnimCore::TryInitializing()
IL_0010: ldarg.0
IL_0011: ldc.i4.0
IL_0012: stfld System.Boolean Febucci.UI.Core.TAnimCore::requiresTagRefresh
IL_0017: ldarg.0
IL_0018: ldarg.1
IL_0019: stfld System.String Febucci.UI.Core.TAnimCore::_text
IL_001e: ldarg.0
IL_001f: call Febucci.UI.TextAnimatorSettings Febucci.UI.TextAnimatorSettings::get_Instance()
IL_0024: stfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_0029: ldarg.0
IL_002a: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_002f: call System.Boolean UnityEngine.Object::op_Implicit(UnityEngine.Object)
IL_0034: brtrue.s IL_0048
IL_0036: ldarg.0
IL_0037: ldc.i4.0
IL_0038: stfld System.Int32 Febucci.UI.Core.TAnimCore::charactersCount
IL_003d: ldstr "Text Animator Settings not found. Skipping setting the text to Text Animator."
IL_0042: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0047: ret
IL_0048: ldarg.0
IL_0049: ldfld System.Boolean Febucci.UI.Core.TAnimCore::useDefaultDatabases
IL_004e: brfalse.s IL_0092
IL_0050: ldarg.0
IL_0051: ldarg.0
IL_0052: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_0057: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase> Febucci.UI.TextAnimatorSettings::behaviors
IL_005c: ldfld T Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase>::defaultDatabase
IL_0061: stfld Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::databaseBehaviors
IL_0066: ldarg.0
IL_0067: ldarg.0
IL_0068: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_006d: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase> Febucci.UI.TextAnimatorSettings::appearances
IL_0072: ldfld T Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase>::defaultDatabase
IL_0077: stfld Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::databaseAppearances
IL_007c: ldarg.0
IL_007d: ldarg.0
IL_007e: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_0083: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Actions.ActionDatabase> Febucci.UI.TextAnimatorSettings::actions
IL_0088: ldfld T Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Actions.ActionDatabase>::defaultDatabase
IL_008d: stfld Febucci.UI.Actions.ActionDatabase Febucci.UI.Core.TAnimCore::databaseActions
IL_0092: ldarg.0
IL_0093: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_0098: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase> Febucci.UI.TextAnimatorSettings::behaviors
IL_009d: ldfld System.Char Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase>::openingSymbol
IL_00a2: ldc.i4.s 47
IL_00a4: ldarg.0
IL_00a5: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_00aa: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase> Febucci.UI.TextAnimatorSettings::behaviors
IL_00af: ldfld System.Char Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase>::closingSymbol
IL_00b4: ldc.i4.3
IL_00b5: ldarg.0
IL_00b6: ldfld Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::databaseBehaviors
IL_00bb: newobj System.Void Febucci.UI.Core.Parsing.AnimationParser`1<Febucci.UI.Effects.AnimationScriptableBase>::.ctor(System.Char,System.Char,System.Char,Febucci.UI.Core.Parsing.VisibilityMode,Febucci.UI.Core.Database`1<T>)
IL_00c0: stloc.0
IL_00c1: ldarg.0
IL_00c2: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_00c7: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase> Febucci.UI.TextAnimatorSettings::appearances
IL_00cc: ldfld System.Char Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase>::openingSymbol
IL_00d1: ldc.i4.s 47
IL_00d3: ldarg.0
IL_00d4: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_00d9: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase> Febucci.UI.TextAnimatorSettings::appearances
IL_00de: ldfld System.Char Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase>::closingSymbol
IL_00e3: ldc.i4.1
IL_00e4: ldarg.0
IL_00e5: ldfld Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::databaseAppearances
IL_00ea: newobj System.Void Febucci.UI.Core.Parsing.AnimationParser`1<Febucci.UI.Effects.AnimationScriptableBase>::.ctor(System.Char,System.Char,System.Char,Febucci.UI.Core.Parsing.VisibilityMode,Febucci.UI.Core.Database`1<T>)
IL_00ef: stloc.1
IL_00f0: ldarg.0
IL_00f1: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_00f6: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase> Febucci.UI.TextAnimatorSettings::appearances
IL_00fb: ldfld System.Char Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase>::openingSymbol
IL_0100: ldc.i4.s 47
IL_0102: ldc.i4.s 35
IL_0104: ldarg.0
IL_0105: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_010a: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase> Febucci.UI.TextAnimatorSettings::appearances
IL_010f: ldfld System.Char Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase>::closingSymbol
IL_0114: ldc.i4.2
IL_0115: ldarg.0
IL_0116: ldfld Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::databaseAppearances
IL_011b: newobj System.Void Febucci.UI.Core.Parsing.AnimationParser`1<Febucci.UI.Effects.AnimationScriptableBase>::.ctor(System.Char,System.Char,System.Char,System.Char,Febucci.UI.Core.Parsing.VisibilityMode,Febucci.UI.Core.Database`1<T>)
IL_0120: stloc.2
IL_0121: ldarg.0
IL_0122: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_0127: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Actions.ActionDatabase> Febucci.UI.TextAnimatorSettings::actions
IL_012c: ldfld System.Char Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Actions.ActionDatabase>::openingSymbol
IL_0131: ldc.i4.s 47
IL_0133: ldarg.0
IL_0134: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_0139: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Actions.ActionDatabase> Febucci.UI.TextAnimatorSettings::actions
IL_013e: ldfld System.Char Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Actions.ActionDatabase>::closingSymbol
IL_0143: ldarg.0
IL_0144: ldfld Febucci.UI.Actions.ActionDatabase Febucci.UI.Core.TAnimCore::databaseActions
IL_0149: newobj System.Void Febucci.UI.Core.Parsing.ActionParser::.ctor(System.Char,System.Char,System.Char,Febucci.UI.Actions.ActionDatabase)
IL_014e: stloc.3
IL_014f: ldc.i4.s 60
IL_0151: ldc.i4.s 47
IL_0153: ldc.i4.s 62
IL_0155: newobj System.Void Febucci.UI.Core.Parsing.EventParser::.ctor(System.Char,System.Char,System.Char)
IL_015a: stloc.s V_4
IL_015c: newobj System.Void System.Collections.Generic.List`1<Febucci.UI.Core.Parsing.TagParserBase>::.ctor()
IL_0161: dup
IL_0162: ldloc.0
IL_0163: callvirt System.Void System.Collections.Generic.List`1<Febucci.UI.Core.Parsing.TagParserBase>::Add(!0)
IL_0168: dup
IL_0169: ldloc.1
IL_016a: callvirt System.Void System.Collections.Generic.List`1<Febucci.UI.Core.Parsing.TagParserBase>::Add(!0)
IL_016f: dup
IL_0170: ldloc.2
IL_0171: callvirt System.Void System.Collections.Generic.List`1<Febucci.UI.Core.Parsing.TagParserBase>::Add(!0)
IL_0176: dup
IL_0177: ldloc.3
IL_0178: callvirt System.Void System.Collections.Generic.List`1<Febucci.UI.Core.Parsing.TagParserBase>::Add(!0)
IL_017d: dup
IL_017e: ldloc.s V_4
IL_0180: callvirt System.Void System.Collections.Generic.List`1<Febucci.UI.Core.Parsing.TagParserBase>::Add(!0)
IL_0185: stloc.s V_5
IL_0187: ldarg.0
IL_0188: callvirt Febucci.UI.Core.Parsing.TagParserBase[] Febucci.UI.Core.TAnimCore::GetExtraParsers()
IL_018d: stloc.s V_6
IL_018f: ldc.i4.0
IL_0190: stloc.s V_7
IL_0192: br.s IL_01aa
IL_0194: ldloc.s V_6
IL_0196: ldloc.s V_7
IL_0198: ldelem.ref
IL_0199: stloc.s V_8
IL_019b: ldloc.s V_5
IL_019d: ldloc.s V_8
IL_019f: callvirt System.Void System.Collections.Generic.List`1<Febucci.UI.Core.Parsing.TagParserBase>::Add(!0)
IL_01a4: ldloc.s V_7
IL_01a6: ldc.i4.1
IL_01a7: add
IL_01a8: stloc.s V_7
IL_01aa: ldloc.s V_7
IL_01ac: ldloc.s V_6
IL_01ae: ldlen
IL_01af: conv.i4
IL_01b0: blt.s IL_0194
IL_01b2: ldarg.0
IL_01b3: ldarg.0
IL_01b4: call Febucci.UI.Styles.StyleSheetScriptable Febucci.UI.Core.TAnimCore::get_StyleSheet()
IL_01b9: call System.Boolean UnityEngine.Object::op_Implicit(UnityEngine.Object)
IL_01be: brtrue.s IL_01c8
IL_01c0: ldarg.0
IL_01c1: ldfld System.String Febucci.UI.Core.TAnimCore::_text
IL_01c6: br.s IL_01ed
IL_01c8: ldarg.0
IL_01c9: ldfld System.String Febucci.UI.Core.TAnimCore::_text
IL_01ce: ldc.i4.1
IL_01cf: newarr Febucci.UI.Core.Parsing.TagParserBase
IL_01d4: dup
IL_01d5: ldc.i4.0
IL_01d6: ldc.i4.s 60
IL_01d8: ldc.i4.s 47
IL_01da: ldc.i4.s 62
IL_01dc: ldarg.0
IL_01dd: call Febucci.UI.Styles.StyleSheetScriptable Febucci.UI.Core.TAnimCore::get_StyleSheet()
IL_01e2: newobj System.Void Febucci.UI.Core.Parsing.StylesParser::.ctor(System.Char,System.Char,System.Char,Febucci.UI.Styles.StyleSheetScriptable)
IL_01e7: stelem.ref
IL_01e8: call System.String Febucci.UI.Core.Parsing.TextParser::ParseText(System.String,Febucci.UI.Core.Parsing.TagParserBase[])
IL_01ed: call System.Void Febucci.UI.Core.TAnimCore::set_textWithoutTextAnimTags(System.String)
IL_01f2: ldarg.0
IL_01f3: ldarg.0
IL_01f4: call System.String Febucci.UI.Core.TAnimCore::get_textWithoutTextAnimTags()
IL_01f9: ldloc.s V_5
IL_01fb: callvirt !0[] System.Collections.Generic.List`1<Febucci.UI.Core.Parsing.TagParserBase>::ToArray()
IL_0200: call System.String Febucci.UI.Core.Parsing.TextParser::ParseText(System.String,Febucci.UI.Core.Parsing.TagParserBase[])
IL_0205: call System.Void Febucci.UI.Core.TAnimCore::set_textWithoutTextAnimTags(System.String)
IL_020a: ldarg.0
IL_020b: ldarg.0
IL_020c: call System.String Febucci.UI.Core.TAnimCore::get_textWithoutTextAnimTags()
IL_0211: callvirt System.Void Febucci.UI.Core.TAnimCore::SetTextToSource(System.String)
IL_0216: ldarg.0
IL_0217: ldarg.0
IL_0218: callvirt System.String Febucci.UI.Core.TAnimCore::GetStrippedTextFromSource()
IL_021d: call System.Void Febucci.UI.Core.TAnimCore::set_textWithoutAnyTag(System.String)
IL_0222: ldarg.0
IL_0223: ldarg.0
IL_0224: callvirt System.Int32 Febucci.UI.Core.TAnimCore::GetCharactersCount()
IL_0229: stfld System.Int32 Febucci.UI.Core.TAnimCore::charactersCount
IL_022e: ldarg.0
IL_022f: ldloc.0
IL_0230: callvirt Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.Parsing.AnimationParser`1<Febucci.UI.Effects.AnimationScriptableBase>::get_results()
IL_0235: stfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::behaviors
IL_023a: ldarg.0
IL_023b: ldloc.1
IL_023c: callvirt Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.Parsing.AnimationParser`1<Febucci.UI.Effects.AnimationScriptableBase>::get_results()
IL_0241: stfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::appearances
IL_0246: ldarg.0
IL_0247: ldloc.2
IL_0248: callvirt Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.Parsing.AnimationParser`1<Febucci.UI.Effects.AnimationScriptableBase>::get_results()
IL_024d: stfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::disappearances
IL_0252: ldarg.0
IL_0253: ldloc.3
IL_0254: callvirt Febucci.UI.Core.Parsing.ActionMarker[] Febucci.UI.Core.Parsing.ActionParser::get_results()
IL_0259: stfld Febucci.UI.Core.Parsing.ActionMarker[] Febucci.UI.Core.TAnimCore::actions
IL_025e: ldarg.0
IL_025f: ldloc.s V_4
IL_0261: callvirt Febucci.UI.Core.Parsing.EventMarker[] Febucci.UI.Core.Parsing.EventParser::get_results()
IL_0266: stfld Febucci.UI.Core.Parsing.EventMarker[] Febucci.UI.Core.TAnimCore::events
IL_026b: ldarg.0
IL_026c: ldarg.0
IL_026d: ldflda Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::behaviors
IL_0272: ldc.i4.3
IL_0273: ldarg.0
IL_0274: ldfld Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::databaseBehaviors
IL_0279: ldarg.0
IL_027a: ldfld System.String[] Febucci.UI.Core.TAnimCore::defaultBehaviorsTags
IL_027f: call System.Void Febucci.UI.Core.TAnimCore::<ConvertText>g__AddFallbackEffectsFor|119_6<Febucci.UI.Effects.AnimationScriptableBase>(Febucci.UI.Core.Parsing.AnimationRegion[]&,Febucci.UI.Core.Parsing.VisibilityMode,Febucci.UI.Core.Database`1<T>,System.String[])
IL_0284: ldarg.0
IL_0285: ldarg.0
IL_0286: ldflda Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::appearances
IL_028b: ldc.i4.1
IL_028c: ldarg.0
IL_028d: ldfld Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::databaseAppearances
IL_0292: ldarg.0
IL_0293: ldfld System.String[] Febucci.UI.Core.TAnimCore::defaultAppearancesTags
IL_0298: call System.Void Febucci.UI.Core.TAnimCore::<ConvertText>g__AddFallbackEffectsFor|119_6<Febucci.UI.Effects.AnimationScriptableBase>(Febucci.UI.Core.Parsing.AnimationRegion[]&,Febucci.UI.Core.Parsing.VisibilityMode,Febucci.UI.Core.Database`1<T>,System.String[])
IL_029d: ldarg.0
IL_029e: ldarg.0
IL_029f: ldflda Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::disappearances
IL_02a4: ldc.i4.2
IL_02a5: ldarg.0
IL_02a6: ldfld Febucci.UI.Effects.AnimationsDatabase Febucci.UI.Core.TAnimCore::databaseAppearances
IL_02ab: ldarg.0
IL_02ac: ldfld System.String[] Febucci.UI.Core.TAnimCore::defaultDisappearancesTags
IL_02b1: call System.Void Febucci.UI.Core.TAnimCore::<ConvertText>g__AddFallbackEffectsFor|119_6<Febucci.UI.Effects.AnimationScriptableBase>(Febucci.UI.Core.Parsing.AnimationRegion[]&,Febucci.UI.Core.Parsing.VisibilityMode,Febucci.UI.Core.Database`1<T>,System.String[])
IL_02b6: ldarg.0
IL_02b7: ldfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::behaviors
IL_02bc: stloc.s V_9
IL_02be: ldc.i4.0
IL_02bf: stloc.s V_7
IL_02c1: br.s IL_02d8
IL_02c3: ldloc.s V_9
IL_02c5: ldloc.s V_7
IL_02c7: ldelem.ref
IL_02c8: ldfld Febucci.UI.Effects.AnimationScriptableBase Febucci.UI.Core.Parsing.AnimationRegion::animation
IL_02cd: callvirt System.Void Febucci.UI.Effects.AnimationScriptableBase::InitializeOnce()
IL_02d2: ldloc.s V_7
IL_02d4: ldc.i4.1
IL_02d5: add
IL_02d6: stloc.s V_7
IL_02d8: ldloc.s V_7
IL_02da: ldloc.s V_9
IL_02dc: ldlen
IL_02dd: conv.i4
IL_02de: blt.s IL_02c3
IL_02e0: ldarg.0
IL_02e1: ldfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::appearances
IL_02e6: stloc.s V_9
IL_02e8: ldc.i4.0
IL_02e9: stloc.s V_7
IL_02eb: br.s IL_0302
IL_02ed: ldloc.s V_9
IL_02ef: ldloc.s V_7
IL_02f1: ldelem.ref
IL_02f2: ldfld Febucci.UI.Effects.AnimationScriptableBase Febucci.UI.Core.Parsing.AnimationRegion::animation
IL_02f7: callvirt System.Void Febucci.UI.Effects.AnimationScriptableBase::InitializeOnce()
IL_02fc: ldloc.s V_7
IL_02fe: ldc.i4.1
IL_02ff: add
IL_0300: stloc.s V_7
IL_0302: ldloc.s V_7
IL_0304: ldloc.s V_9
IL_0306: ldlen
IL_0307: conv.i4
IL_0308: blt.s IL_02ed
IL_030a: ldarg.0
IL_030b: ldfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::disappearances
IL_0310: stloc.s V_9
IL_0312: ldc.i4.0
IL_0313: stloc.s V_7
IL_0315: br.s IL_032c
IL_0317: ldloc.s V_9
IL_0319: ldloc.s V_7
IL_031b: ldelem.ref
IL_031c: ldfld Febucci.UI.Effects.AnimationScriptableBase Febucci.UI.Core.Parsing.AnimationRegion::animation
IL_0321: callvirt System.Void Febucci.UI.Effects.AnimationScriptableBase::InitializeOnce()
IL_0326: ldloc.s V_7
IL_0328: ldc.i4.1
IL_0329: add
IL_032a: stloc.s V_7
IL_032c: ldloc.s V_7
IL_032e: ldloc.s V_9
IL_0330: ldlen
IL_0331: conv.i4
IL_0332: blt.s IL_0317
IL_0334: ldarg.0
IL_0335: ldarg.2
IL_0336: ldc.i4.3
IL_0337: ceq
IL_0339: ldc.i4.0
IL_033a: ceq
IL_033c: call System.Void Febucci.UI.Core.TAnimCore::<ConvertText>g__PopulateCharacters|119_0(System.Boolean)
IL_0341: ldarg.0
IL_0342: ldarg.0
IL_0343: ldflda Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_0348: callvirt System.Void Febucci.UI.Core.TAnimCore::CopyMeshFromSource(Febucci.UI.Core.CharacterData[]&)
IL_034d: ldarg.0
IL_034e: call System.Void Febucci.UI.Core.TAnimCore::<ConvertText>g__CalculateWords|119_1()
IL_0353: ldarg.2
IL_0354: switch IL_036b,IL_0373,IL_037b,IL_03b1
IL_0369: br.s IL_03b1
IL_036b: ldarg.0
IL_036c: call System.Void Febucci.UI.Core.TAnimCore::<ConvertText>g__HideAllCharactersTime|119_3()
IL_0371: br.s IL_03b1
IL_0373: ldarg.0
IL_0374: call System.Void Febucci.UI.Core.TAnimCore::<ConvertText>g__ShowCharacterTimes|119_4()
IL_0379: br.s IL_03b1
IL_037b: ldarg.0
IL_037c: call System.Void Febucci.UI.Core.TAnimCore::<ConvertText>g__ShowCharacterTimes|119_4()
IL_0381: ldarg.0
IL_0382: ldfld System.Int32 Febucci.UI.Core.TAnimCore::charactersCount
IL_0387: ldc.i4.1
IL_0388: ble.s IL_03b1
IL_038a: ldarg.0
IL_038b: ldarg.0
IL_038c: ldfld System.Int32 Febucci.UI.Core.TAnimCore::charactersCount
IL_0391: ldc.i4.1
IL_0392: sub
IL_0393: call System.Void Febucci.UI.Core.TAnimCore::<ConvertText>g__HideCharacterTime|119_2(System.Int32)
IL_0398: ldarg.0
IL_0399: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_039e: ldarg.0
IL_039f: ldfld System.Int32 Febucci.UI.Core.TAnimCore::charactersCount
IL_03a4: ldc.i4.1
IL_03a5: sub
IL_03a6: ldelema Febucci.UI.Core.CharacterData
IL_03ab: ldc.i4.1
IL_03ac: stfld System.Boolean Febucci.UI.Core.CharacterData::isVisible
IL_03b1: ldarg.0
IL_03b2: ldarg.0
IL_03b3: ldfld System.Int32 Febucci.UI.Core.TAnimCore::charactersCount
IL_03b8: stfld System.Int32 Febucci.UI.Core.TAnimCore::_maxVisibleCharacters
IL_03bd: ldarg.0
IL_03be: ldflda Febucci.UI.TimeData Febucci.UI.Core.TAnimCore::time
IL_03c3: ldarg.0
IL_03c4: ldfld Febucci.UI.TimeScale Febucci.UI.Core.TAnimCore::timeScale
IL_03c9: ldc.i4.1
IL_03ca: beq.s IL_03d3
IL_03cc: call System.Single UnityEngine.Time::get_deltaTime()
IL_03d1: br.s IL_03d8
IL_03d3: call System.Single UnityEngine.Time::get_unscaledDeltaTime()
IL_03d8: call System.Void Febucci.UI.TimeData::UpdateDeltaTime(System.Single)
IL_03dd: ldarg.0
IL_03de: ldfld System.Boolean Febucci.UI.Core.TAnimCore::isResettingTimeOnNewText
IL_03e3: brfalse.s IL_03f4
IL_03e5: ldarg.2
IL_03e6: ldc.i4.3
IL_03e7: beq.s IL_03f4
IL_03e9: ldarg.0
IL_03ea: ldflda Febucci.UI.TimeData Febucci.UI.Core.TAnimCore::time
IL_03ef: call System.Void Febucci.UI.TimeData::RestartTime()
IL_03f4: ret
