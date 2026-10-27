TYPE PixelCrushers.DialogueSystem.FormattedText
METHOD System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_hasVariableInputPrompt() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.String PixelCrushers.DialogueSystem.FormattedText::get_variableInputPrompt()
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: ldc.i4.0
IL_000c: ceq
IL_000e: ret
METHOD PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.FormattedText::Parse(System.String,PixelCrushers.DialogueSystem.EmphasisSetting[]) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_001c
IL_0003: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0008: ldnull
IL_0009: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000e: brfalse.s IL_001c
IL_0010: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_masterDatabase()
IL_0015: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.DialogueDatabase::emphasisSettings
IL_001a: starg.s emphasisSettings
IL_001c: ldarg.0
IL_001d: dup
IL_001e: brtrue.s IL_0026
IL_0020: pop
IL_0021: ldsfld System.String System.String::Empty
IL_0026: stloc.0
IL_0027: ldloca.s V_0
IL_0029: call System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceLuaTags(System.String&)
IL_002e: ldloca.s V_0
IL_0030: call System.String PixelCrushers.DialogueSystem.FormattedText::ExtractVariableInputPrompt(System.String&)
IL_0035: stloc.1
IL_0036: ldloca.s V_0
IL_0038: call System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceVarTags(System.String&)
IL_003d: ldloca.s V_0
IL_003f: call System.Void PixelCrushers.DialogueSystem.FormattedText::ReplaceAutocaseTags(System.String&)
IL_0044: ldloca.s V_0
IL_0046: call System.Void PixelCrushers.DialogueSystem.FormattedText::ReplacePipes(System.String&)
IL_004b: ldc.i4.0
IL_004c: stloc.2
IL_004d: ldc.i4.0
IL_004e: stloc.3
IL_004f: ldc.i4.0
IL_0050: stloc.s V_4
IL_0052: ldloc.0
IL_0053: ldstr "[pic"
IL_0058: callvirt System.Boolean System.String::Contains(System.String)
IL_005d: brfalse.s IL_0087
IL_005f: ldstr "\[pic=[0-9a-zA-z_]+\]"
IL_0064: ldloca.s V_0
IL_0066: call System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPicTag(System.String,System.String&)
IL_006b: stloc.2
IL_006c: ldstr "\[pica=[0-9a-zA-z_]+\]"
IL_0071: ldloca.s V_0
IL_0073: call System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPicTag(System.String,System.String&)
IL_0078: stloc.3
IL_0079: ldstr "\[picc=[0-9a-zA-z_]+\]"
IL_007e: ldloca.s V_0
IL_0080: call System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPicTag(System.String,System.String&)
IL_0085: stloc.s V_4
IL_0087: ldstr "[a]"
IL_008c: ldloca.s V_0
IL_008e: call System.Boolean PixelCrushers.DialogueSystem.FormattedText::ExtractTag(System.String,System.String&)
IL_0093: stloc.s V_5
IL_0095: ldstr "[f]"
IL_009a: ldloca.s V_0
IL_009c: call System.Boolean PixelCrushers.DialogueSystem.FormattedText::ExtractTag(System.String,System.String&)
IL_00a1: stloc.s V_6
IL_00a3: ldstr "[auto]"
IL_00a8: ldloca.s V_0
IL_00aa: call System.Boolean PixelCrushers.DialogueSystem.FormattedText::ExtractTag(System.String,System.String&)
IL_00af: stloc.s V_7
IL_00b1: ldstr "[nosubtitle]"
IL_00b6: ldloca.s V_0
IL_00b8: call System.Boolean PixelCrushers.DialogueSystem.FormattedText::ExtractTag(System.String,System.String&)
IL_00bd: stloc.s V_8
IL_00bf: ldloca.s V_0
IL_00c1: call System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPositionTag(System.String&)
IL_00c6: stloc.s V_9
IL_00c8: ldloca.s V_0
IL_00ca: call System.Int32 PixelCrushers.DialogueSystem.FormattedText::ExtractPanelNumberTag(System.String&)
IL_00cf: stloc.s V_10
IL_00d1: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_00d6: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_00db: ldfld PixelCrushers.DialogueSystem.DisplaySettings/SubtitleSettings PixelCrushers.DialogueSystem.DisplaySettings::subtitleSettings
IL_00e0: ldfld System.Boolean PixelCrushers.DialogueSystem.DisplaySettings/SubtitleSettings::richTextEmphases
IL_00e5: brtrue.s IL_00f1
IL_00e7: ldloca.s V_0
IL_00e9: ldarg.1
IL_00ea: call PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::ExtractEmphasisTags(System.String&,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_00ef: br.s IL_00f9
IL_00f1: ldloca.s V_0
IL_00f3: ldarg.1
IL_00f4: call PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::ReplaceEmphasisTagsWithRichText(System.String&,PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_00f9: stloc.s V_11
IL_00fb: ldloc.0
IL_00fc: ldloc.s V_11
IL_00fe: ldloc.s V_5
IL_0100: ldloc.s V_9
IL_0102: ldloc.s V_6
IL_0104: ldloc.s V_7
IL_0106: ldloc.2
IL_0107: ldloc.3
IL_0108: ldloc.s V_4
IL_010a: ldloc.1
IL_010b: ldloc.s V_10
IL_010d: ldloc.s V_8
IL_010f: newobj System.Void PixelCrushers.DialogueSystem.FormattedText::.ctor(System.String,PixelCrushers.DialogueSystem.Emphasis[],System.Boolean,System.Int32,System.Boolean,System.Boolean,System.Int32,System.Int32,System.Int32,System.String,System.Int32,System.Boolean)
IL_0114: ret
