TYPE TMPro.TextMeshProUGUI
METHOD System.Int32 TMPro.TextMeshProUGUI::SetArraySizes(TMPro.TMP_Text/UnicodeChar[]) | attributes=Assembly, Virtual, HideBySig, CheckAccessOnOverride | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldarg.0
IL_0003: ldc.i4.0
IL_0004: stfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TMPro.TMP_Text::m_isUsingBold
IL_0010: ldarg.0
IL_0011: ldc.i4.0
IL_0012: stfld System.Boolean TMPro.TMP_Text::m_isParsingText
IL_0017: ldarg.0
IL_0018: ldc.i4.0
IL_0019: stfld System.Boolean TMPro.TMP_Text::tag_NoParsing
IL_001e: ldarg.0
IL_001f: ldarg.0
IL_0020: ldfld TMPro.FontStyles TMPro.TMP_Text::m_fontStyle
IL_0025: stfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_002a: ldarg.0
IL_002b: ldflda TMPro.TMP_FontStyleStack TMPro.TMP_Text::m_fontStyleStack
IL_0030: call System.Void TMPro.TMP_FontStyleStack::Clear()
IL_0035: ldarg.0
IL_0036: ldarg.0
IL_0037: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_003c: ldc.i4.1
IL_003d: and
IL_003e: ldc.i4.1
IL_003f: beq.s IL_0049
IL_0041: ldarg.0
IL_0042: ldfld TMPro.FontWeight TMPro.TMP_Text::m_fontWeight
IL_0047: br.s IL_004e
IL_0049: ldc.i4 700
IL_004e: stfld TMPro.FontWeight TMPro.TMP_Text::m_FontWeightInternal
IL_0053: ldarg.0
IL_0054: ldflda TMPro.TMP_TextProcessingStack`1<TMPro.FontWeight> TMPro.TMP_Text::m_FontWeightStack
IL_0059: ldarg.0
IL_005a: ldfld TMPro.FontWeight TMPro.TMP_Text::m_FontWeightInternal
IL_005f: call System.Void TMPro.TMP_TextProcessingStack`1<TMPro.FontWeight>::SetDefault(T)
IL_0064: ldarg.0
IL_0065: ldarg.0
IL_0066: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset
IL_006b: stfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0070: ldarg.0
IL_0071: ldarg.0
IL_0072: ldfld UnityEngine.Material TMPro.TMP_Text::m_sharedMaterial
IL_0077: stfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_007c: ldarg.0
IL_007d: ldc.i4.0
IL_007e: stfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0083: ldsflda TMPro.TMP_TextProcessingStack`1<TMPro.MaterialReference> TMPro.TMP_Text::m_materialReferenceStack
IL_0088: ldarg.0
IL_0089: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_008e: ldarg.0
IL_008f: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0094: ldnull
IL_0095: ldarg.0
IL_0096: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_009b: ldarg.0
IL_009c: ldfld System.Single TMPro.TMP_Text::m_padding
IL_00a1: newobj System.Void TMPro.MaterialReference::.ctor(System.Int32,TMPro.TMP_FontAsset,TMPro.TMP_SpriteAsset,UnityEngine.Material,System.Single)
IL_00a6: call System.Void TMPro.TMP_TextProcessingStack`1<TMPro.MaterialReference>::SetDefault(T)
IL_00ab: ldsfld System.Collections.Generic.Dictionary`2<System.Int32,System.Int32> TMPro.TMP_Text::m_materialReferenceIndexLookup
IL_00b0: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,System.Int32>::Clear()
IL_00b5: ldarg.0
IL_00b6: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_00bb: ldarg.0
IL_00bc: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_00c1: ldsflda TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_00c6: ldsfld System.Collections.Generic.Dictionary`2<System.Int32,System.Int32> TMPro.TMP_Text::m_materialReferenceIndexLookup
IL_00cb: call System.Int32 TMPro.MaterialReference::AddMaterialReference(UnityEngine.Material,TMPro.TMP_FontAsset,TMPro.MaterialReference[]&,System.Collections.Generic.Dictionary`2<System.Int32,System.Int32>)
IL_00d0: pop
IL_00d1: ldarg.0
IL_00d2: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_00d7: brtrue.s IL_00ec
IL_00d9: ldarg.0
IL_00da: ldarg.0
IL_00db: ldfld System.Int32 TMPro.TMP_Text::m_InternalTextProcessingArraySize
IL_00e0: newobj System.Void TMPro.TMP_TextInfo::.ctor(System.Int32)
IL_00e5: stfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_00ea: br.s IL_0118
IL_00ec: ldarg.0
IL_00ed: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_00f2: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_00f7: ldlen
IL_00f8: conv.i4
IL_00f9: ldarg.0
IL_00fa: ldfld System.Int32 TMPro.TMP_Text::m_InternalTextProcessingArraySize
IL_00ff: bge.s IL_0118
IL_0101: ldarg.0
IL_0102: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0107: ldflda TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_010c: ldarg.0
IL_010d: ldfld System.Int32 TMPro.TMP_Text::m_InternalTextProcessingArraySize
IL_0112: ldc.i4.0
IL_0113: call System.Void TMPro.TMP_TextInfo::Resize<TMPro.TMP_CharacterInfo>(T[]&,System.Int32,System.Boolean)
IL_0118: ldarg.0
IL_0119: ldc.i4.0
IL_011a: stfld TMPro.TMP_TextElementType TMPro.TMP_Text::m_textElementType
IL_011f: ldarg.0
IL_0120: ldfld TMPro.TextOverflowModes TMPro.TMP_Text::m_overflowMode
IL_0125: ldc.i4.1
IL_0126: bne.un IL_024e
IL_012b: ldarg.0
IL_012c: ldarg.0
IL_012d: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0132: call System.Void TMPro.TMP_Text::GetEllipsisSpecialCharacter(TMPro.TMP_FontAsset)
IL_0137: ldarg.0
IL_0138: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_013d: ldfld TMPro.TMP_Character TMPro.TMP_Text/SpecialCharacter::character
IL_0142: brfalse IL_0220
IL_0147: ldarg.0
IL_0148: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_014d: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text/SpecialCharacter::fontAsset
IL_0152: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0157: ldarg.0
IL_0158: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_015d: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0162: beq IL_024e
IL_0167: call System.Boolean TMPro.TMP_Settings::get_matchMaterialPreset()
IL_016c: brfalse.s IL_01b8
IL_016e: ldarg.0
IL_016f: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_0174: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0179: ldarg.0
IL_017a: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_017f: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text/SpecialCharacter::fontAsset
IL_0184: ldfld UnityEngine.Material TMPro.TMP_Asset::material
IL_0189: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_018e: beq.s IL_01b8
IL_0190: ldarg.0
IL_0191: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_0196: ldarg.0
IL_0197: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_019c: ldarg.0
IL_019d: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_01a2: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text/SpecialCharacter::fontAsset
IL_01a7: ldfld UnityEngine.Material TMPro.TMP_Asset::material
IL_01ac: call UnityEngine.Material TMPro.TMP_MaterialManager::GetFallbackMaterial(UnityEngine.Material,UnityEngine.Material)
IL_01b1: stfld UnityEngine.Material TMPro.TMP_Text/SpecialCharacter::material
IL_01b6: br.s IL_01d3
IL_01b8: ldarg.0
IL_01b9: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_01be: ldarg.0
IL_01bf: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_01c4: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text/SpecialCharacter::fontAsset
IL_01c9: ldfld UnityEngine.Material TMPro.TMP_Asset::material
IL_01ce: stfld UnityEngine.Material TMPro.TMP_Text/SpecialCharacter::material
IL_01d3: ldarg.0
IL_01d4: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_01d9: ldarg.0
IL_01da: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_01df: ldfld UnityEngine.Material TMPro.TMP_Text/SpecialCharacter::material
IL_01e4: ldarg.0
IL_01e5: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_01ea: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text/SpecialCharacter::fontAsset
IL_01ef: ldsflda TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_01f4: ldsfld System.Collections.Generic.Dictionary`2<System.Int32,System.Int32> TMPro.TMP_Text::m_materialReferenceIndexLookup
IL_01f9: call System.Int32 TMPro.MaterialReference::AddMaterialReference(UnityEngine.Material,TMPro.TMP_FontAsset,TMPro.MaterialReference[]&,System.Collections.Generic.Dictionary`2<System.Int32,System.Int32>)
IL_01fe: stfld System.Int32 TMPro.TMP_Text/SpecialCharacter::materialIndex
IL_0203: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0208: ldarg.0
IL_0209: ldflda TMPro.TMP_Text/SpecialCharacter TMPro.TMP_Text::m_Ellipsis
IL_020e: ldfld System.Int32 TMPro.TMP_Text/SpecialCharacter::materialIndex
IL_0213: ldelema TMPro.MaterialReference
IL_0218: ldc.i4.0
IL_0219: stfld System.Int32 TMPro.MaterialReference::referenceCount
IL_021e: br.s IL_024e
IL_0220: ldarg.0
IL_0221: ldc.i4.3
IL_0222: stfld TMPro.TextOverflowModes TMPro.TMP_Text::m_overflowMode
IL_0227: call System.Boolean TMPro.TMP_Settings::get_warningsDisabled()
IL_022c: brtrue.s IL_024e
IL_022e: ldstr "The character used for Ellipsis is not available in font asset ["
IL_0233: ldarg.0
IL_0234: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0239: callvirt System.String UnityEngine.Object::get_name()
IL_023e: ldstr "] or any potential fallbacks. Switching Text Overflow mode to Truncate."
IL_0243: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0248: ldarg.0
IL_0249: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_024e: ldarg.0
IL_024f: ldfld TMPro.TextOverflowModes TMPro.TMP_Text::m_overflowMode
IL_0254: ldc.i4.6
IL_0255: bne.un.s IL_02a2
IL_0257: ldarg.0
IL_0258: ldfld TMPro.TMP_Text TMPro.TMP_Text::m_linkedTextComponent
IL_025d: ldnull
IL_025e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0263: brfalse.s IL_02a2
IL_0265: ldarg.0
IL_0266: ldfld System.Boolean TMPro.TMP_Text::m_isCalculatingPreferredValues
IL_026b: brtrue.s IL_02a2
IL_026d: ldarg.0
IL_026e: ldfld TMPro.TMP_Text TMPro.TMP_Text::m_linkedTextComponent
IL_0273: stloc.2
IL_0274: br.s IL_0299
IL_0276: ldloc.2
IL_0277: ldsfld System.String System.String::Empty
IL_027c: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0281: ldloc.2
IL_0282: callvirt System.Void TMPro.TMP_Text::ClearMesh()
IL_0287: ldloc.2
IL_0288: callvirt TMPro.TMP_TextInfo TMPro.TMP_Text::get_textInfo()
IL_028d: callvirt System.Void TMPro.TMP_TextInfo::Clear()
IL_0292: ldloc.2
IL_0293: callvirt TMPro.TMP_Text TMPro.TMP_Text::get_linkedTextComponent()
IL_0298: stloc.2
IL_0299: ldloc.2
IL_029a: ldnull
IL_029b: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_02a0: brtrue.s IL_0276
IL_02a2: ldc.i4.0
IL_02a3: stloc.3
IL_02a4: br IL_0b47
IL_02a9: ldarg.0
IL_02aa: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_02af: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_02b4: brfalse.s IL_02cb
IL_02b6: ldarg.0
IL_02b7: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_02bc: ldarg.0
IL_02bd: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_02c2: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_02c7: ldlen
IL_02c8: conv.i4
IL_02c9: blt.s IL_02e4
IL_02cb: ldarg.0
IL_02cc: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_02d1: ldflda TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_02d6: ldarg.0
IL_02d7: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_02dc: ldc.i4.1
IL_02dd: add
IL_02de: ldc.i4.1
IL_02df: call System.Void TMPro.TMP_TextInfo::Resize<TMPro.TMP_CharacterInfo>(T[]&,System.Int32,System.Boolean)
IL_02e4: ldarg.1
IL_02e5: ldloc.3
IL_02e6: ldelema TMPro.TMP_Text/UnicodeChar
IL_02eb: ldfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_02f0: stloc.s V_4
IL_02f2: ldarg.0
IL_02f3: ldfld System.Boolean TMPro.TMP_Text::m_isRichText
IL_02f8: brfalse IL_04d5
IL_02fd: ldloc.s V_4
IL_02ff: ldc.i4.s 60
IL_0301: bne.un IL_04d5
IL_0306: ldarg.0
IL_0307: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_030c: stloc.s V_11
IL_030e: ldarg.0
IL_030f: ldarg.1
IL_0310: ldloc.3
IL_0311: ldc.i4.1
IL_0312: add
IL_0313: ldloca.s V_12
IL_0315: call System.Boolean TMPro.TMP_Text::ValidateHtmlTag(TMPro.TMP_Text/UnicodeChar[],System.Int32,System.Int32&)
IL_031a: brfalse IL_04d5
IL_031f: ldarg.1
IL_0320: ldloc.3
IL_0321: ldelema TMPro.TMP_Text/UnicodeChar
IL_0326: ldfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_032b: stloc.s V_13
IL_032d: ldloc.s V_12
IL_032f: stloc.3
IL_0330: ldarg.0
IL_0331: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_0336: ldc.i4.1
IL_0337: and
IL_0338: ldc.i4.1
IL_0339: bne.un.s IL_0342
IL_033b: ldarg.0
IL_033c: ldc.i4.1
IL_033d: stfld System.Boolean TMPro.TMP_Text::m_isUsingBold
IL_0342: ldarg.0
IL_0343: ldfld TMPro.TMP_TextElementType TMPro.TMP_Text::m_textElementType
IL_0348: ldc.i4.1
IL_0349: bne.un IL_0b43
IL_034e: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0353: ldarg.0
IL_0354: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0359: ldelema TMPro.MaterialReference
IL_035e: ldflda System.Int32 TMPro.MaterialReference::referenceCount
IL_0363: dup
IL_0364: ldind.i4
IL_0365: ldc.i4.1
IL_0366: add
IL_0367: stind.i4
IL_0368: ldarg.0
IL_0369: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_036e: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_0373: ldarg.0
IL_0374: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0379: ldelema TMPro.TMP_CharacterInfo
IL_037e: ldc.i4 57344
IL_0383: ldarg.0
IL_0384: ldfld System.Int32 TMPro.TMP_Text::m_spriteIndex
IL_0389: add
IL_038a: conv.u2
IL_038b: stfld System.Char TMPro.TMP_CharacterInfo::character
IL_0390: ldarg.0
IL_0391: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0396: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_039b: ldarg.0
IL_039c: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_03a1: ldelema TMPro.TMP_CharacterInfo
IL_03a6: ldarg.0
IL_03a7: ldfld System.Int32 TMPro.TMP_Text::m_spriteIndex
IL_03ac: stfld System.Int32 TMPro.TMP_CharacterInfo::spriteIndex
IL_03b1: ldarg.0
IL_03b2: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_03b7: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_03bc: ldarg.0
IL_03bd: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_03c2: ldelema TMPro.TMP_CharacterInfo
IL_03c7: ldarg.0
IL_03c8: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_03cd: stfld TMPro.TMP_FontAsset TMPro.TMP_CharacterInfo::fontAsset
IL_03d2: ldarg.0
IL_03d3: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_03d8: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_03dd: ldarg.0
IL_03de: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_03e3: ldelema TMPro.TMP_CharacterInfo
IL_03e8: ldarg.0
IL_03e9: ldfld TMPro.TMP_SpriteAsset TMPro.TMP_Text::m_currentSpriteAsset
IL_03ee: stfld TMPro.TMP_SpriteAsset TMPro.TMP_CharacterInfo::spriteAsset
IL_03f3: ldarg.0
IL_03f4: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_03f9: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_03fe: ldarg.0
IL_03ff: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0404: ldelema TMPro.TMP_CharacterInfo
IL_0409: ldarg.0
IL_040a: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_040f: stfld System.Int32 TMPro.TMP_CharacterInfo::materialReferenceIndex
IL_0414: ldarg.0
IL_0415: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_041a: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_041f: ldarg.0
IL_0420: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0425: ldelema TMPro.TMP_CharacterInfo
IL_042a: ldarg.0
IL_042b: ldfld TMPro.TMP_SpriteAsset TMPro.TMP_Text::m_currentSpriteAsset
IL_0430: callvirt System.Collections.Generic.List`1<TMPro.TMP_SpriteCharacter> TMPro.TMP_SpriteAsset::get_spriteCharacterTable()
IL_0435: ldarg.0
IL_0436: ldfld System.Int32 TMPro.TMP_Text::m_spriteIndex
IL_043b: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_SpriteCharacter>::get_Item(System.Int32)
IL_0440: stfld TMPro.TMP_TextElement TMPro.TMP_CharacterInfo::textElement
IL_0445: ldarg.0
IL_0446: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_044b: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_0450: ldarg.0
IL_0451: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0456: ldelema TMPro.TMP_CharacterInfo
IL_045b: ldarg.0
IL_045c: ldfld TMPro.TMP_TextElementType TMPro.TMP_Text::m_textElementType
IL_0461: stfld TMPro.TMP_TextElementType TMPro.TMP_CharacterInfo::elementType
IL_0466: ldarg.0
IL_0467: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_046c: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_0471: ldarg.0
IL_0472: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0477: ldelema TMPro.TMP_CharacterInfo
IL_047c: ldloc.s V_13
IL_047e: stfld System.Int32 TMPro.TMP_CharacterInfo::index
IL_0483: ldarg.0
IL_0484: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0489: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_048e: ldarg.0
IL_048f: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0494: ldelema TMPro.TMP_CharacterInfo
IL_0499: ldarg.1
IL_049a: ldloc.3
IL_049b: ldelema TMPro.TMP_Text/UnicodeChar
IL_04a0: ldfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_04a5: ldloc.s V_13
IL_04a7: sub
IL_04a8: ldc.i4.1
IL_04a9: add
IL_04aa: stfld System.Int32 TMPro.TMP_CharacterInfo::stringLength
IL_04af: ldarg.0
IL_04b0: ldc.i4.0
IL_04b1: stfld TMPro.TMP_TextElementType TMPro.TMP_Text::m_textElementType
IL_04b6: ldarg.0
IL_04b7: ldloc.s V_11
IL_04b9: stfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_04be: ldloc.0
IL_04bf: ldc.i4.1
IL_04c0: add
IL_04c1: stloc.0
IL_04c2: ldarg.0
IL_04c3: ldarg.0
IL_04c4: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_04c9: ldc.i4.1
IL_04ca: add
IL_04cb: stfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_04d0: br IL_0b43
IL_04d5: ldc.i4.0
IL_04d6: stloc.s V_5
IL_04d8: ldc.i4.0
IL_04d9: stloc.s V_6
IL_04db: ldarg.0
IL_04dc: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_04e1: stloc.s V_7
IL_04e3: ldarg.0
IL_04e4: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_04e9: stloc.s V_8
IL_04eb: ldarg.0
IL_04ec: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_04f1: stloc.s V_9
IL_04f3: ldarg.0
IL_04f4: ldfld TMPro.TMP_TextElementType TMPro.TMP_Text::m_textElementType
IL_04f9: brtrue.s IL_0560
IL_04fb: ldarg.0
IL_04fc: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_0501: ldc.i4.s 16
IL_0503: and
IL_0504: ldc.i4.s 16
IL_0506: bne.un.s IL_051e
IL_0508: ldloc.s V_4
IL_050a: conv.u2
IL_050b: call System.Boolean System.Char::IsLower(System.Char)
IL_0510: brfalse.s IL_0560
IL_0512: ldloc.s V_4
IL_0514: conv.u2
IL_0515: call System.Char System.Char::ToUpper(System.Char)
IL_051a: stloc.s V_4
IL_051c: br.s IL_0560
IL_051e: ldarg.0
IL_051f: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_0524: ldc.i4.8
IL_0525: and
IL_0526: ldc.i4.8
IL_0527: bne.un.s IL_053f
IL_0529: ldloc.s V_4
IL_052b: conv.u2
IL_052c: call System.Boolean System.Char::IsUpper(System.Char)
IL_0531: brfalse.s IL_0560
IL_0533: ldloc.s V_4
IL_0535: conv.u2
IL_0536: call System.Char System.Char::ToLower(System.Char)
IL_053b: stloc.s V_4
IL_053d: br.s IL_0560
IL_053f: ldarg.0
IL_0540: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_0545: ldc.i4.s 32
IL_0547: and
IL_0548: ldc.i4.s 32
IL_054a: bne.un.s IL_0560
IL_054c: ldloc.s V_4
IL_054e: conv.u2
IL_054f: call System.Boolean System.Char::IsLower(System.Char)
IL_0554: brfalse.s IL_0560
IL_0556: ldloc.s V_4
IL_0558: conv.u2
IL_0559: call System.Char System.Char::ToUpper(System.Char)
IL_055e: stloc.s V_4
IL_0560: ldarg.0
IL_0561: ldloc.s V_4
IL_0563: ldarg.0
IL_0564: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0569: ldarg.0
IL_056a: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_056f: ldarg.0
IL_0570: ldfld TMPro.FontWeight TMPro.TMP_Text::m_FontWeightInternal
IL_0575: ldloca.s V_5
IL_0577: call TMPro.TMP_TextElement TMPro.TMP_Text::GetTextElement(System.UInt32,TMPro.TMP_FontAsset,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_057c: stloc.s V_10
IL_057e: ldloc.s V_10
IL_0580: brtrue IL_073e
IL_0585: ldloc.s V_4
IL_0587: stloc.s V_14
IL_0589: ldarg.1
IL_058a: ldloc.3
IL_058b: ldelema TMPro.TMP_Text/UnicodeChar
IL_0590: call System.Int32 TMPro.TMP_Settings::get_missingGlyphCharacter()
IL_0595: brfalse.s IL_059e
IL_0597: call System.Int32 TMPro.TMP_Settings::get_missingGlyphCharacter()
IL_059c: br.s IL_05a3
IL_059e: ldc.i4 9633
IL_05a3: dup
IL_05a4: stloc.s V_15
IL_05a6: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_05ab: ldloc.s V_15
IL_05ad: stloc.s V_4
IL_05af: ldloc.s V_4
IL_05b1: ldarg.0
IL_05b2: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_05b7: ldc.i4.1
IL_05b8: ldarg.0
IL_05b9: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_05be: ldarg.0
IL_05bf: ldfld TMPro.FontWeight TMPro.TMP_Text::m_FontWeightInternal
IL_05c4: ldloca.s V_5
IL_05c6: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_05cb: stloc.s V_10
IL_05cd: ldloc.s V_10
IL_05cf: brtrue.s IL_0608
IL_05d1: call System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_Settings::get_fallbackFontAssets()
IL_05d6: brfalse.s IL_0608
IL_05d8: call System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_Settings::get_fallbackFontAssets()
IL_05dd: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()
IL_05e2: ldc.i4.0
IL_05e3: ble.s IL_0608
IL_05e5: ldloc.s V_4
IL_05e7: ldarg.0
IL_05e8: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_05ed: call System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_Settings::get_fallbackFontAssets()
IL_05f2: ldc.i4.1
IL_05f3: ldarg.0
IL_05f4: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_05f9: ldarg.0
IL_05fa: ldfld TMPro.FontWeight TMPro.TMP_Text::m_FontWeightInternal
IL_05ff: ldloca.s V_5
IL_0601: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAssets(System.UInt32,TMPro.TMP_FontAsset,System.Collections.Generic.List`1<TMPro.TMP_FontAsset>,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_0606: stloc.s V_10
IL_0608: ldloc.s V_10
IL_060a: brtrue.s IL_0636
IL_060c: call TMPro.TMP_FontAsset TMPro.TMP_Settings::get_defaultFontAsset()
IL_0611: ldnull
IL_0612: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0617: brfalse.s IL_0636
IL_0619: ldloc.s V_4
IL_061b: call TMPro.TMP_FontAsset TMPro.TMP_Settings::get_defaultFontAsset()
IL_0620: ldc.i4.1
IL_0621: ldarg.0
IL_0622: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_0627: ldarg.0
IL_0628: ldfld TMPro.FontWeight TMPro.TMP_Text::m_FontWeightInternal
IL_062d: ldloca.s V_5
IL_062f: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_0634: stloc.s V_10
IL_0636: ldloc.s V_10
IL_0638: brtrue.s IL_066d
IL_063a: ldarg.1
IL_063b: ldloc.3
IL_063c: ldelema TMPro.TMP_Text/UnicodeChar
IL_0641: ldc.i4.s 32
IL_0643: dup
IL_0644: stloc.s V_15
IL_0646: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_064b: ldloc.s V_15
IL_064d: stloc.s V_4
IL_064f: ldloc.s V_4
IL_0651: ldarg.0
IL_0652: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0657: ldc.i4.1
IL_0658: ldarg.0
IL_0659: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_065e: ldarg.0
IL_065f: ldfld TMPro.FontWeight TMPro.TMP_Text::m_FontWeightInternal
IL_0664: ldloca.s V_5
IL_0666: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_066b: stloc.s V_10
IL_066d: ldloc.s V_10
IL_066f: brtrue.s IL_06a3
IL_0671: ldarg.1
IL_0672: ldloc.3
IL_0673: ldelema TMPro.TMP_Text/UnicodeChar
IL_0678: ldc.i4.3
IL_0679: dup
IL_067a: stloc.s V_15
IL_067c: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0681: ldloc.s V_15
IL_0683: stloc.s V_4
IL_0685: ldloc.s V_4
IL_0687: ldarg.0
IL_0688: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_068d: ldc.i4.1
IL_068e: ldarg.0
IL_068f: ldfld TMPro.FontStyles TMPro.TMP_Text::m_FontStyleInternal
IL_0694: ldarg.0
IL_0695: ldfld TMPro.FontWeight TMPro.TMP_Text::m_FontWeightInternal
IL_069a: ldloca.s V_5
IL_069c: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_06a1: stloc.s V_10
IL_06a3: call System.Boolean TMPro.TMP_Settings::get_warningsDisabled()
IL_06a8: brtrue IL_073e
IL_06ad: ldloc.s V_14
IL_06af: ldc.i4 65535
IL_06b4: bgt.s IL_06f8
IL_06b6: ldstr "The character with Unicode value \u{0:X4} was not found in the [{1}] font asset or any potential fallbacks. It was replaced by Unicode character \u{2:X4} in text object [{3}]."
IL_06bb: ldc.i4.4
IL_06bc: newarr System.Object
IL_06c1: dup
IL_06c2: ldc.i4.0
IL_06c3: ldloc.s V_14
IL_06c5: box System.Int32
IL_06ca: stelem.ref
IL_06cb: dup
IL_06cc: ldc.i4.1
IL_06cd: ldarg.0
IL_06ce: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset
IL_06d3: callvirt System.String UnityEngine.Object::get_name()
IL_06d8: stelem.ref
IL_06d9: dup
IL_06da: ldc.i4.2
IL_06db: ldloc.s V_10
IL_06dd: callvirt System.UInt32 TMPro.TMP_TextElement::get_unicode()
IL_06e2: box System.UInt32
IL_06e7: stelem.ref
IL_06e8: dup
IL_06e9: ldc.i4.3
IL_06ea: ldarg.0
IL_06eb: call System.String UnityEngine.Object::get_name()
IL_06f0: stelem.ref
IL_06f1: call System.String System.String::Format(System.String,System.Object[])
IL_06f6: br.s IL_0738
IL_06f8: ldstr "The character with Unicode value \U{0:X8} was not found in the [{1}] font asset or any potential fallbacks. It was replaced by Unicode character \u{2:X4} in text object [{3}]."
IL_06fd: ldc.i4.4
IL_06fe: newarr System.Object
IL_0703: dup
IL_0704: ldc.i4.0
IL_0705: ldloc.s V_14
IL_0707: box System.Int32
IL_070c: stelem.ref
IL_070d: dup
IL_070e: ldc.i4.1
IL_070f: ldarg.0
IL_0710: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset
IL_0715: callvirt System.String UnityEngine.Object::get_name()
IL_071a: stelem.ref
IL_071b: dup
IL_071c: ldc.i4.2
IL_071d: ldloc.s V_10
IL_071f: callvirt System.UInt32 TMPro.TMP_TextElement::get_unicode()
IL_0724: box System.UInt32
IL_0729: stelem.ref
IL_072a: dup
IL_072b: ldc.i4.3
IL_072c: ldarg.0
IL_072d: call System.String UnityEngine.Object::get_name()
IL_0732: stelem.ref
IL_0733: call System.String System.String::Format(System.String,System.Object[])
IL_0738: ldarg.0
IL_0739: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_073e: ldloc.s V_10
IL_0740: callvirt TMPro.TextElementType TMPro.TMP_TextElement::get_elementType()
IL_0745: ldc.i4.1
IL_0746: bne.un.s IL_0776
IL_0748: ldloc.s V_10
IL_074a: callvirt TMPro.TMP_Asset TMPro.TMP_TextElement::get_textAsset()
IL_074f: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()
IL_0754: ldarg.0
IL_0755: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_075a: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()
IL_075f: beq.s IL_0776
IL_0761: ldc.i4.1
IL_0762: stloc.s V_6
IL_0764: ldarg.0
IL_0765: ldloc.s V_10
IL_0767: callvirt TMPro.TMP_Asset TMPro.TMP_TextElement::get_textAsset()
IL_076c: isinst TMPro.TMP_FontAsset
IL_0771: stfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0776: ldarg.0
IL_0777: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_077c: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_0781: ldarg.0
IL_0782: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0787: ldelema TMPro.TMP_CharacterInfo
IL_078c: ldc.i4.0
IL_078d: stfld TMPro.TMP_TextElementType TMPro.TMP_CharacterInfo::elementType
IL_0792: ldarg.0
IL_0793: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0798: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_079d: ldarg.0
IL_079e: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_07a3: ldelema TMPro.TMP_CharacterInfo
IL_07a8: ldloc.s V_10
IL_07aa: stfld TMPro.TMP_TextElement TMPro.TMP_CharacterInfo::textElement
IL_07af: ldarg.0
IL_07b0: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_07b5: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_07ba: ldarg.0
IL_07bb: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_07c0: ldelema TMPro.TMP_CharacterInfo
IL_07c5: ldloc.s V_5
IL_07c7: stfld System.Boolean TMPro.TMP_CharacterInfo::isUsingAlternateTypeface
IL_07cc: ldarg.0
IL_07cd: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_07d2: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_07d7: ldarg.0
IL_07d8: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_07dd: ldelema TMPro.TMP_CharacterInfo
IL_07e2: ldloc.s V_4
IL_07e4: conv.u2
IL_07e5: stfld System.Char TMPro.TMP_CharacterInfo::character
IL_07ea: ldarg.0
IL_07eb: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_07f0: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_07f5: ldarg.0
IL_07f6: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_07fb: ldelema TMPro.TMP_CharacterInfo
IL_0800: ldarg.1
IL_0801: ldloc.3
IL_0802: ldelema TMPro.TMP_Text/UnicodeChar
IL_0807: ldfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex
IL_080c: stfld System.Int32 TMPro.TMP_CharacterInfo::index
IL_0811: ldarg.0
IL_0812: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0817: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_081c: ldarg.0
IL_081d: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0822: ldelema TMPro.TMP_CharacterInfo
IL_0827: ldarg.1
IL_0828: ldloc.3
IL_0829: ldelema TMPro.TMP_Text/UnicodeChar
IL_082e: ldfld System.Int32 TMPro.TMP_Text/UnicodeChar::length
IL_0833: stfld System.Int32 TMPro.TMP_CharacterInfo::stringLength
IL_0838: ldarg.0
IL_0839: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_083e: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_0843: ldarg.0
IL_0844: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0849: ldelema TMPro.TMP_CharacterInfo
IL_084e: ldarg.0
IL_084f: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0854: stfld TMPro.TMP_FontAsset TMPro.TMP_CharacterInfo::fontAsset
IL_0859: ldloc.s V_10
IL_085b: callvirt TMPro.TextElementType TMPro.TMP_TextElement::get_elementType()
IL_0860: ldc.i4.2
IL_0861: bne.un IL_094e
IL_0866: ldloc.s V_10
IL_0868: callvirt TMPro.TMP_Asset TMPro.TMP_TextElement::get_textAsset()
IL_086d: isinst TMPro.TMP_SpriteAsset
IL_0872: stloc.s V_16
IL_0874: ldarg.0
IL_0875: ldloc.s V_16
IL_0877: ldfld UnityEngine.Material TMPro.TMP_Asset::material
IL_087c: ldloc.s V_16
IL_087e: ldsflda TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0883: ldsfld System.Collections.Generic.Dictionary`2<System.Int32,System.Int32> TMPro.TMP_Text::m_materialReferenceIndexLookup
IL_0888: call System.Int32 TMPro.MaterialReference::AddMaterialReference(UnityEngine.Material,TMPro.TMP_SpriteAsset,TMPro.MaterialReference[]&,System.Collections.Generic.Dictionary`2<System.Int32,System.Int32>)
IL_088d: stfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0892: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0897: ldarg.0
IL_0898: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_089d: ldelema TMPro.MaterialReference
IL_08a2: ldflda System.Int32 TMPro.MaterialReference::referenceCount
IL_08a7: dup
IL_08a8: ldind.i4
IL_08a9: ldc.i4.1
IL_08aa: add
IL_08ab: stind.i4
IL_08ac: ldarg.0
IL_08ad: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_08b2: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_08b7: ldarg.0
IL_08b8: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_08bd: ldelema TMPro.TMP_CharacterInfo
IL_08c2: ldc.i4.1
IL_08c3: stfld TMPro.TMP_TextElementType TMPro.TMP_CharacterInfo::elementType
IL_08c8: ldarg.0
IL_08c9: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_08ce: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_08d3: ldarg.0
IL_08d4: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_08d9: ldelema TMPro.TMP_CharacterInfo
IL_08de: ldarg.0
IL_08df: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_08e4: stfld System.Int32 TMPro.TMP_CharacterInfo::materialReferenceIndex
IL_08e9: ldarg.0
IL_08ea: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_08ef: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_08f4: ldarg.0
IL_08f5: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_08fa: ldelema TMPro.TMP_CharacterInfo
IL_08ff: ldloc.s V_16
IL_0901: stfld TMPro.TMP_SpriteAsset TMPro.TMP_CharacterInfo::spriteAsset
IL_0906: ldarg.0
IL_0907: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_090c: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_0911: ldarg.0
IL_0912: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0917: ldelema TMPro.TMP_CharacterInfo
IL_091c: ldloc.s V_10
IL_091e: callvirt System.UInt32 TMPro.TMP_TextElement::get_glyphIndex()
IL_0923: stfld System.Int32 TMPro.TMP_CharacterInfo::spriteIndex
IL_0928: ldarg.0
IL_0929: ldc.i4.0
IL_092a: stfld TMPro.TMP_TextElementType TMPro.TMP_Text::m_textElementType
IL_092f: ldarg.0
IL_0930: ldloc.s V_9
IL_0932: stfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0937: ldloc.0
IL_0938: ldc.i4.1
IL_0939: add
IL_093a: stloc.0
IL_093b: ldarg.0
IL_093c: ldarg.0
IL_093d: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0942: ldc.i4.1
IL_0943: add
IL_0944: stfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0949: br IL_0b43
IL_094e: ldloc.s V_6
IL_0950: brfalse.s IL_09c1
IL_0952: ldarg.0
IL_0953: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0958: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()
IL_095d: ldarg.0
IL_095e: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset
IL_0963: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()
IL_0968: beq.s IL_09c1
IL_096a: call System.Boolean TMPro.TMP_Settings::get_matchMaterialPreset()
IL_096f: brfalse.s IL_098f
IL_0971: ldarg.0
IL_0972: ldarg.0
IL_0973: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_0978: ldarg.0
IL_0979: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_097e: ldfld UnityEngine.Material TMPro.TMP_Asset::material
IL_0983: call UnityEngine.Material TMPro.TMP_MaterialManager::GetFallbackMaterial(UnityEngine.Material,UnityEngine.Material)
IL_0988: stfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_098d: br.s IL_09a0
IL_098f: ldarg.0
IL_0990: ldarg.0
IL_0991: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0996: ldfld UnityEngine.Material TMPro.TMP_Asset::material
IL_099b: stfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_09a0: ldarg.0
IL_09a1: ldarg.0
IL_09a2: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_09a7: ldarg.0
IL_09a8: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_09ad: ldsflda TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_09b2: ldsfld System.Collections.Generic.Dictionary`2<System.Int32,System.Int32> TMPro.TMP_Text::m_materialReferenceIndexLookup
IL_09b7: call System.Int32 TMPro.MaterialReference::AddMaterialReference(UnityEngine.Material,TMPro.TMP_FontAsset,TMPro.MaterialReference[]&,System.Collections.Generic.Dictionary`2<System.Int32,System.Int32>)
IL_09bc: stfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_09c1: ldloc.s V_10
IL_09c3: brfalse.s IL_0a1b
IL_09c5: ldloc.s V_10
IL_09c7: callvirt UnityEngine.TextCore.Glyph TMPro.TMP_TextElement::get_glyph()
IL_09cc: callvirt System.Int32 UnityEngine.TextCore.Glyph::get_atlasIndex()
IL_09d1: ldc.i4.0
IL_09d2: ble.s IL_0a1b
IL_09d4: ldarg.0
IL_09d5: ldarg.0
IL_09d6: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_09db: ldarg.0
IL_09dc: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_09e1: ldloc.s V_10
IL_09e3: callvirt UnityEngine.TextCore.Glyph TMPro.TMP_TextElement::get_glyph()
IL_09e8: callvirt System.Int32 UnityEngine.TextCore.Glyph::get_atlasIndex()
IL_09ed: call UnityEngine.Material TMPro.TMP_MaterialManager::GetFallbackMaterial(TMPro.TMP_FontAsset,UnityEngine.Material,System.Int32)
IL_09f2: stfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_09f7: ldarg.0
IL_09f8: ldarg.0
IL_09f9: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_09fe: ldarg.0
IL_09ff: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0a04: ldsflda TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0a09: ldsfld System.Collections.Generic.Dictionary`2<System.Int32,System.Int32> TMPro.TMP_Text::m_materialReferenceIndexLookup
IL_0a0e: call System.Int32 TMPro.MaterialReference::AddMaterialReference(UnityEngine.Material,TMPro.TMP_FontAsset,TMPro.MaterialReference[]&,System.Collections.Generic.Dictionary`2<System.Int32,System.Int32>)
IL_0a13: stfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0a18: ldc.i4.1
IL_0a19: stloc.s V_6
IL_0a1b: ldloc.s V_4
IL_0a1d: conv.u2
IL_0a1e: call System.Boolean System.Char::IsWhiteSpace(System.Char)
IL_0a23: brtrue IL_0aa9
IL_0a28: ldloc.s V_4
IL_0a2a: ldc.i4 8203
IL_0a2f: beq.s IL_0aa9
IL_0a31: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0a36: ldarg.0
IL_0a37: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0a3c: ldelema TMPro.MaterialReference
IL_0a41: ldfld System.Int32 TMPro.MaterialReference::referenceCount
IL_0a46: ldc.i4 16383
IL_0a4b: bge.s IL_0a69
IL_0a4d: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0a52: ldarg.0
IL_0a53: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0a58: ldelema TMPro.MaterialReference
IL_0a5d: ldflda System.Int32 TMPro.MaterialReference::referenceCount
IL_0a62: dup
IL_0a63: ldind.i4
IL_0a64: ldc.i4.1
IL_0a65: add
IL_0a66: stind.i4
IL_0a67: br.s IL_0aa9
IL_0a69: ldarg.0
IL_0a6a: ldarg.0
IL_0a6b: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_0a70: newobj System.Void UnityEngine.Material::.ctor(UnityEngine.Material)
IL_0a75: ldarg.0
IL_0a76: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0a7b: ldsflda TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0a80: ldsfld System.Collections.Generic.Dictionary`2<System.Int32,System.Int32> TMPro.TMP_Text::m_materialReferenceIndexLookup
IL_0a85: call System.Int32 TMPro.MaterialReference::AddMaterialReference(UnityEngine.Material,TMPro.TMP_FontAsset,TMPro.MaterialReference[]&,System.Collections.Generic.Dictionary`2<System.Int32,System.Int32>)
IL_0a8a: stfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0a8f: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0a94: ldarg.0
IL_0a95: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0a9a: ldelema TMPro.MaterialReference
IL_0a9f: ldflda System.Int32 TMPro.MaterialReference::referenceCount
IL_0aa4: dup
IL_0aa5: ldind.i4
IL_0aa6: ldc.i4.1
IL_0aa7: add
IL_0aa8: stind.i4
IL_0aa9: ldarg.0
IL_0aaa: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0aaf: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_0ab4: ldarg.0
IL_0ab5: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0aba: ldelema TMPro.TMP_CharacterInfo
IL_0abf: ldarg.0
IL_0ac0: ldfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_0ac5: stfld UnityEngine.Material TMPro.TMP_CharacterInfo::material
IL_0aca: ldarg.0
IL_0acb: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0ad0: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_0ad5: ldarg.0
IL_0ad6: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0adb: ldelema TMPro.TMP_CharacterInfo
IL_0ae0: ldarg.0
IL_0ae1: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0ae6: stfld System.Int32 TMPro.TMP_CharacterInfo::materialReferenceIndex
IL_0aeb: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0af0: ldarg.0
IL_0af1: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0af6: ldelema TMPro.MaterialReference
IL_0afb: ldloc.s V_6
IL_0afd: stfld System.Boolean TMPro.MaterialReference::isFallbackMaterial
IL_0b02: ldloc.s V_6
IL_0b04: brfalse.s IL_0b35
IL_0b06: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0b0b: ldarg.0
IL_0b0c: ldfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0b11: ldelema TMPro.MaterialReference
IL_0b16: ldloc.s V_8
IL_0b18: stfld UnityEngine.Material TMPro.MaterialReference::fallbackMaterial
IL_0b1d: ldarg.0
IL_0b1e: ldloc.s V_7
IL_0b20: stfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_currentFontAsset
IL_0b25: ldarg.0
IL_0b26: ldloc.s V_8
IL_0b28: stfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_0b2d: ldarg.0
IL_0b2e: ldloc.s V_9
IL_0b30: stfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0b35: ldarg.0
IL_0b36: ldarg.0
IL_0b37: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0b3c: ldc.i4.1
IL_0b3d: add
IL_0b3e: stfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0b43: ldloc.3
IL_0b44: ldc.i4.1
IL_0b45: add
IL_0b46: stloc.3
IL_0b47: ldloc.3
IL_0b48: ldarg.1
IL_0b49: ldlen
IL_0b4a: conv.i4
IL_0b4b: bge.s IL_0b5e
IL_0b4d: ldarg.1
IL_0b4e: ldloc.3
IL_0b4f: ldelema TMPro.TMP_Text/UnicodeChar
IL_0b54: ldfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode
IL_0b59: brtrue IL_02a9
IL_0b5e: ldarg.0
IL_0b5f: ldfld System.Boolean TMPro.TMP_Text::m_isCalculatingPreferredValues
IL_0b64: brfalse.s IL_0b74
IL_0b66: ldarg.0
IL_0b67: ldc.i4.0
IL_0b68: stfld System.Boolean TMPro.TMP_Text::m_isCalculatingPreferredValues
IL_0b6d: ldarg.0
IL_0b6e: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0b73: ret
IL_0b74: ldarg.0
IL_0b75: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0b7a: ldloc.0
IL_0b7b: stfld System.Int32 TMPro.TMP_TextInfo::spriteCount
IL_0b80: ldarg.0
IL_0b81: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0b86: ldsfld System.Collections.Generic.Dictionary`2<System.Int32,System.Int32> TMPro.TMP_Text::m_materialReferenceIndexLookup
IL_0b8b: callvirt System.Int32 System.Collections.Generic.Dictionary`2<System.Int32,System.Int32>::get_Count()
IL_0b90: dup
IL_0b91: stloc.s V_15
IL_0b93: stfld System.Int32 TMPro.TMP_TextInfo::materialCount
IL_0b98: ldloc.s V_15
IL_0b9a: stloc.1
IL_0b9b: ldloc.1
IL_0b9c: ldarg.0
IL_0b9d: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0ba2: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0ba7: ldlen
IL_0ba8: conv.i4
IL_0ba9: ble.s IL_0bbd
IL_0bab: ldarg.0
IL_0bac: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0bb1: ldflda TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0bb6: ldloc.1
IL_0bb7: ldc.i4.0
IL_0bb8: call System.Void TMPro.TMP_TextInfo::Resize<TMPro.TMP_MeshInfo>(T[]&,System.Int32,System.Boolean)
IL_0bbd: ldloc.1
IL_0bbe: ldarg.0
IL_0bbf: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0bc4: ldlen
IL_0bc5: conv.i4
IL_0bc6: ble.s IL_0bdb
IL_0bc8: ldarg.0
IL_0bc9: ldflda TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0bce: ldloc.1
IL_0bcf: ldc.i4.1
IL_0bd0: add
IL_0bd1: call System.Int32 UnityEngine.Mathf::NextPowerOfTwo(System.Int32)
IL_0bd6: call System.Void TMPro.TMP_TextInfo::Resize<TMPro.TMP_SubMeshUI>(T[]&,System.Int32)
IL_0bdb: ldarg.0
IL_0bdc: ldfld System.Boolean TMPro.TMP_Text::m_VertexBufferAutoSizeReduction
IL_0be1: brfalse.s IL_0c21
IL_0be3: ldarg.0
IL_0be4: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0be9: ldfld TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_0bee: ldlen
IL_0bef: conv.i4
IL_0bf0: ldarg.0
IL_0bf1: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0bf6: sub
IL_0bf7: ldc.i4 256
IL_0bfc: ble.s IL_0c21
IL_0bfe: ldarg.0
IL_0bff: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0c04: ldflda TMPro.TMP_CharacterInfo[] TMPro.TMP_TextInfo::characterInfo
IL_0c09: ldarg.0
IL_0c0a: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0c0f: ldc.i4.1
IL_0c10: add
IL_0c11: ldc.i4 256
IL_0c16: call System.Int32 UnityEngine.Mathf::Max(System.Int32,System.Int32)
IL_0c1b: ldc.i4.1
IL_0c1c: call System.Void TMPro.TMP_TextInfo::Resize<TMPro.TMP_CharacterInfo>(T[]&,System.Int32,System.Boolean)
IL_0c21: ldc.i4.0
IL_0c22: stloc.s V_17
IL_0c24: br IL_0f2e
IL_0c29: ldloc.s V_17
IL_0c2b: ldc.i4.0
IL_0c2c: ble IL_0da7
IL_0c31: ldarg.0
IL_0c32: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0c37: ldloc.s V_17
IL_0c39: ldelem.ref
IL_0c3a: ldnull
IL_0c3b: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0c40: brfalse.s IL_0c75
IL_0c42: ldarg.0
IL_0c43: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0c48: ldloc.s V_17
IL_0c4a: ldarg.0
IL_0c4b: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0c50: ldloc.s V_17
IL_0c52: ldelem.any TMPro.MaterialReference
IL_0c57: call TMPro.TMP_SubMeshUI TMPro.TMP_SubMeshUI::AddSubTextObject(TMPro.TextMeshProUGUI,TMPro.MaterialReference)
IL_0c5c: stelem.ref
IL_0c5d: ldarg.0
IL_0c5e: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0c63: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0c68: ldloc.s V_17
IL_0c6a: ldelema TMPro.TMP_MeshInfo
IL_0c6f: ldnull
IL_0c70: stfld UnityEngine.Vector3[] TMPro.TMP_MeshInfo::vertices
IL_0c75: ldarg.0
IL_0c76: ldfld UnityEngine.RectTransform TMPro.TMP_Text::m_rectTransform
IL_0c7b: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_pivot()
IL_0c80: ldarg.0
IL_0c81: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0c86: ldloc.s V_17
IL_0c88: ldelem.ref
IL_0c89: callvirt UnityEngine.RectTransform UnityEngine.UI.Graphic::get_rectTransform()
IL_0c8e: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_pivot()
IL_0c93: call System.Boolean UnityEngine.Vector2::op_Inequality(UnityEngine.Vector2,UnityEngine.Vector2)
IL_0c98: brfalse.s IL_0cb8
IL_0c9a: ldarg.0
IL_0c9b: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0ca0: ldloc.s V_17
IL_0ca2: ldelem.ref
IL_0ca3: callvirt UnityEngine.RectTransform UnityEngine.UI.Graphic::get_rectTransform()
IL_0ca8: ldarg.0
IL_0ca9: ldfld UnityEngine.RectTransform TMPro.TMP_Text::m_rectTransform
IL_0cae: callvirt UnityEngine.Vector2 UnityEngine.RectTransform::get_pivot()
IL_0cb3: callvirt System.Void UnityEngine.RectTransform::set_pivot(UnityEngine.Vector2)
IL_0cb8: ldarg.0
IL_0cb9: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0cbe: ldloc.s V_17
IL_0cc0: ldelem.ref
IL_0cc1: callvirt UnityEngine.Material TMPro.TMP_SubMeshUI::get_sharedMaterial()
IL_0cc6: ldnull
IL_0cc7: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0ccc: brtrue.s IL_0cf9
IL_0cce: ldarg.0
IL_0ccf: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0cd4: ldloc.s V_17
IL_0cd6: ldelem.ref
IL_0cd7: callvirt UnityEngine.Material TMPro.TMP_SubMeshUI::get_sharedMaterial()
IL_0cdc: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0ce1: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0ce6: ldloc.s V_17
IL_0ce8: ldelema TMPro.MaterialReference
IL_0ced: ldfld UnityEngine.Material TMPro.MaterialReference::material
IL_0cf2: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0cf7: beq.s IL_0d56
IL_0cf9: ldarg.0
IL_0cfa: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0cff: ldloc.s V_17
IL_0d01: ldelem.ref
IL_0d02: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0d07: ldloc.s V_17
IL_0d09: ldelema TMPro.MaterialReference
IL_0d0e: ldfld UnityEngine.Material TMPro.MaterialReference::material
IL_0d13: callvirt System.Void TMPro.TMP_SubMeshUI::set_sharedMaterial(UnityEngine.Material)
IL_0d18: ldarg.0
IL_0d19: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0d1e: ldloc.s V_17
IL_0d20: ldelem.ref
IL_0d21: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0d26: ldloc.s V_17
IL_0d28: ldelema TMPro.MaterialReference
IL_0d2d: ldfld TMPro.TMP_FontAsset TMPro.MaterialReference::fontAsset
IL_0d32: callvirt System.Void TMPro.TMP_SubMeshUI::set_fontAsset(TMPro.TMP_FontAsset)
IL_0d37: ldarg.0
IL_0d38: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0d3d: ldloc.s V_17
IL_0d3f: ldelem.ref
IL_0d40: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0d45: ldloc.s V_17
IL_0d47: ldelema TMPro.MaterialReference
IL_0d4c: ldfld TMPro.TMP_SpriteAsset TMPro.MaterialReference::spriteAsset
IL_0d51: callvirt System.Void TMPro.TMP_SubMeshUI::set_spriteAsset(TMPro.TMP_SpriteAsset)
IL_0d56: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0d5b: ldloc.s V_17
IL_0d5d: ldelema TMPro.MaterialReference
IL_0d62: ldfld System.Boolean TMPro.MaterialReference::isFallbackMaterial
IL_0d67: brfalse.s IL_0da7
IL_0d69: ldarg.0
IL_0d6a: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0d6f: ldloc.s V_17
IL_0d71: ldelem.ref
IL_0d72: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0d77: ldloc.s V_17
IL_0d79: ldelema TMPro.MaterialReference
IL_0d7e: ldfld UnityEngine.Material TMPro.MaterialReference::material
IL_0d83: callvirt System.Void TMPro.TMP_SubMeshUI::set_fallbackMaterial(UnityEngine.Material)
IL_0d88: ldarg.0
IL_0d89: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0d8e: ldloc.s V_17
IL_0d90: ldelem.ref
IL_0d91: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0d96: ldloc.s V_17
IL_0d98: ldelema TMPro.MaterialReference
IL_0d9d: ldfld UnityEngine.Material TMPro.MaterialReference::fallbackMaterial
IL_0da2: callvirt System.Void TMPro.TMP_SubMeshUI::set_fallbackSourceMaterial(UnityEngine.Material)
IL_0da7: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0dac: ldloc.s V_17
IL_0dae: ldelema TMPro.MaterialReference
IL_0db3: ldfld System.Int32 TMPro.MaterialReference::referenceCount
IL_0db8: stloc.s V_18
IL_0dba: ldarg.0
IL_0dbb: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0dc0: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0dc5: ldloc.s V_17
IL_0dc7: ldelema TMPro.TMP_MeshInfo
IL_0dcc: ldfld UnityEngine.Vector3[] TMPro.TMP_MeshInfo::vertices
IL_0dd1: brfalse.s IL_0df5
IL_0dd3: ldarg.0
IL_0dd4: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0dd9: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0dde: ldloc.s V_17
IL_0de0: ldelema TMPro.TMP_MeshInfo
IL_0de5: ldfld UnityEngine.Vector3[] TMPro.TMP_MeshInfo::vertices
IL_0dea: ldlen
IL_0deb: conv.i4
IL_0dec: ldloc.s V_18
IL_0dee: ldc.i4.4
IL_0def: mul
IL_0df0: bge IL_0e9b
IL_0df5: ldarg.0
IL_0df6: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0dfb: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0e00: ldloc.s V_17
IL_0e02: ldelema TMPro.TMP_MeshInfo
IL_0e07: ldfld UnityEngine.Vector3[] TMPro.TMP_MeshInfo::vertices
IL_0e0c: brtrue.s IL_0e66
IL_0e0e: ldloc.s V_17
IL_0e10: brtrue.s IL_0e38
IL_0e12: ldarg.0
IL_0e13: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0e18: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0e1d: ldloc.s V_17
IL_0e1f: ldarg.0
IL_0e20: ldfld UnityEngine.Mesh TMPro.TMP_Text::m_mesh
IL_0e25: ldloc.s V_18
IL_0e27: ldc.i4.1
IL_0e28: add
IL_0e29: newobj System.Void TMPro.TMP_MeshInfo::.ctor(UnityEngine.Mesh,System.Int32)
IL_0e2e: stelem.any TMPro.TMP_MeshInfo
IL_0e33: br IL_0f00
IL_0e38: ldarg.0
IL_0e39: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0e3e: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0e43: ldloc.s V_17
IL_0e45: ldarg.0
IL_0e46: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0e4b: ldloc.s V_17
IL_0e4d: ldelem.ref
IL_0e4e: callvirt UnityEngine.Mesh TMPro.TMP_SubMeshUI::get_mesh()
IL_0e53: ldloc.s V_18
IL_0e55: ldc.i4.1
IL_0e56: add
IL_0e57: newobj System.Void TMPro.TMP_MeshInfo::.ctor(UnityEngine.Mesh,System.Int32)
IL_0e5c: stelem.any TMPro.TMP_MeshInfo
IL_0e61: br IL_0f00
IL_0e66: ldarg.0
IL_0e67: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0e6c: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0e71: ldloc.s V_17
IL_0e73: ldelema TMPro.TMP_MeshInfo
IL_0e78: ldloc.s V_18
IL_0e7a: ldc.i4 1024
IL_0e7f: bgt.s IL_0e8c
IL_0e81: ldloc.s V_18
IL_0e83: ldc.i4.1
IL_0e84: add
IL_0e85: call System.Int32 UnityEngine.Mathf::NextPowerOfTwo(System.Int32)
IL_0e8a: br.s IL_0e94
IL_0e8c: ldloc.s V_18
IL_0e8e: ldc.i4 256
IL_0e93: add
IL_0e94: call System.Void TMPro.TMP_MeshInfo::ResizeMeshInfo(System.Int32)
IL_0e99: br.s IL_0f00
IL_0e9b: ldarg.0
IL_0e9c: ldfld System.Boolean TMPro.TMP_Text::m_VertexBufferAutoSizeReduction
IL_0ea1: brfalse.s IL_0f00
IL_0ea3: ldloc.s V_18
IL_0ea5: ldc.i4.0
IL_0ea6: ble.s IL_0f00
IL_0ea8: ldarg.0
IL_0ea9: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0eae: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0eb3: ldloc.s V_17
IL_0eb5: ldelema TMPro.TMP_MeshInfo
IL_0eba: ldfld UnityEngine.Vector3[] TMPro.TMP_MeshInfo::vertices
IL_0ebf: ldlen
IL_0ec0: conv.i4
IL_0ec1: ldc.i4.4
IL_0ec2: div
IL_0ec3: ldloc.s V_18
IL_0ec5: sub
IL_0ec6: ldc.i4 256
IL_0ecb: ble.s IL_0f00
IL_0ecd: ldarg.0
IL_0ece: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0ed3: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0ed8: ldloc.s V_17
IL_0eda: ldelema TMPro.TMP_MeshInfo
IL_0edf: ldloc.s V_18
IL_0ee1: ldc.i4 1024
IL_0ee6: bgt.s IL_0ef3
IL_0ee8: ldloc.s V_18
IL_0eea: ldc.i4.1
IL_0eeb: add
IL_0eec: call System.Int32 UnityEngine.Mathf::NextPowerOfTwo(System.Int32)
IL_0ef1: br.s IL_0efb
IL_0ef3: ldloc.s V_18
IL_0ef5: ldc.i4 256
IL_0efa: add
IL_0efb: call System.Void TMPro.TMP_MeshInfo::ResizeMeshInfo(System.Int32)
IL_0f00: ldarg.0
IL_0f01: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0f06: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0f0b: ldloc.s V_17
IL_0f0d: ldelema TMPro.TMP_MeshInfo
IL_0f12: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0f17: ldloc.s V_17
IL_0f19: ldelema TMPro.MaterialReference
IL_0f1e: ldfld UnityEngine.Material TMPro.MaterialReference::material
IL_0f23: stfld UnityEngine.Material TMPro.TMP_MeshInfo::material
IL_0f28: ldloc.s V_17
IL_0f2a: ldc.i4.1
IL_0f2b: add
IL_0f2c: stloc.s V_17
IL_0f2e: ldloc.s V_17
IL_0f30: ldloc.1
IL_0f31: blt IL_0c29
IL_0f36: ldloc.1
IL_0f37: stloc.s V_19
IL_0f39: br.s IL_0f66
IL_0f3b: ldloc.s V_19
IL_0f3d: ldarg.0
IL_0f3e: ldfld TMPro.TMP_TextInfo TMPro.TMP_Text::m_textInfo
IL_0f43: ldfld TMPro.TMP_MeshInfo[] TMPro.TMP_TextInfo::meshInfo
IL_0f48: ldlen
IL_0f49: conv.i4
IL_0f4a: bge.s IL_0f60
IL_0f4c: ldarg.0
IL_0f4d: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0f52: ldloc.s V_19
IL_0f54: ldelem.ref
IL_0f55: callvirt UnityEngine.CanvasRenderer UnityEngine.UI.Graphic::get_canvasRenderer()
IL_0f5a: ldnull
IL_0f5b: callvirt System.Void UnityEngine.CanvasRenderer::SetMesh(UnityEngine.Mesh)
IL_0f60: ldloc.s V_19
IL_0f62: ldc.i4.1
IL_0f63: add
IL_0f64: stloc.s V_19
IL_0f66: ldloc.s V_19
IL_0f68: ldarg.0
IL_0f69: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0f6e: ldlen
IL_0f6f: conv.i4
IL_0f70: bge.s IL_0f83
IL_0f72: ldarg.0
IL_0f73: ldfld TMPro.TMP_SubMeshUI[] TMPro.TextMeshProUGUI::m_subTextObjects
IL_0f78: ldloc.s V_19
IL_0f7a: ldelem.ref
IL_0f7b: ldnull
IL_0f7c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0f81: brtrue.s IL_0f3b
IL_0f83: ldarg.0
IL_0f84: ldfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount
IL_0f89: ret
