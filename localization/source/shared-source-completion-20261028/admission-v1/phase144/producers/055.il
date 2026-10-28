TYPE TheForestOfLove.CustomPortraitsUi
METHOD System.Void TheForestOfLove.CustomPortraitsUi::OnShowResponseOptions(System.Collections.Generic.IEnumerable`1<System.String>) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::currentConversationActivatedRightPortrait
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.1
IL_000b: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::responseOptionsVisible
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::foregroundCanvasAnimator
IL_0016: ldstr "minimize"
IL_001b: ldc.i4.1
IL_001c: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0021: ldarg.0
IL_0022: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundCanvasAnimator
IL_0027: ldstr "minimize"
IL_002c: ldc.i4.1
IL_002d: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0032: ldarg.0
IL_0033: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::foregroundCanvasAnimator
IL_0038: ldstr "minimize_mirrored"
IL_003d: call System.Boolean TheForestOfLove.ResponseOptionsUI::get_LeftAlignPlayerPortraits()
IL_0042: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0047: ldarg.0
IL_0048: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundCanvasAnimator
IL_004d: ldstr "minimize_mirrored"
IL_0052: call System.Boolean TheForestOfLove.ResponseOptionsUI::get_LeftAlignPlayerPortraits()
IL_0057: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_005c: ldarg.0
IL_005d: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorLeft
IL_0062: ldstr "minimize"
IL_0067: ldc.i4.0
IL_0068: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_006d: ldarg.0
IL_006e: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorLeft
IL_0073: ldstr "minimize"
IL_0078: ldc.i4.0
IL_0079: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_007e: ldarg.0
IL_007f: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorRight
IL_0084: ldstr "minimize"
IL_0089: ldc.i4.0
IL_008a: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_008f: ldarg.0
IL_0090: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorRight
IL_0095: ldstr "minimize"
IL_009a: ldc.i4.0
IL_009b: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_00a0: ldarg.0
IL_00a1: call System.Void TheForestOfLove.CustomPortraitsUi::ResetNameplateAnimatorTriggers()
IL_00a6: ldarg.0
IL_00a7: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::nameplateCanvasAnimator
IL_00ac: ldstr "hide"
IL_00b1: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00b6: ret
METHOD System.Void TheForestOfLove.CustomPortraitsUi::MaximizePortraits() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::foregroundCanvasAnimator
IL_0006: ldstr "minimize"
IL_000b: ldc.i4.0
IL_000c: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundCanvasAnimator
IL_0017: ldstr "minimize"
IL_001c: ldc.i4.0
IL_001d: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0022: ldarg.0
IL_0023: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::foregroundCanvasAnimator
IL_0028: ldstr "minimize_mirrored"
IL_002d: call System.Boolean TheForestOfLove.ResponseOptionsUI::get_LeftAlignPlayerPortraits()
IL_0032: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0037: ldarg.0
IL_0038: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundCanvasAnimator
IL_003d: ldstr "minimize_mirrored"
IL_0042: call System.Boolean TheForestOfLove.ResponseOptionsUI::get_LeftAlignPlayerPortraits()
IL_0047: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_004c: ldarg.0
IL_004d: call System.Void TheForestOfLove.CustomPortraitsUi::ResetNameplateAnimatorTriggers()
IL_0052: ldarg.0
IL_0053: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::nameplateCanvasAnimator
IL_0058: ldstr "show"
IL_005d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0062: ret
METHOD System.Void TheForestOfLove.CustomPortraitsUi::OnConversationTriggerUpdatePortraits(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean Globals::get_DisableTriggeredEffects()
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldarg.1
IL_0009: brfalse.s IL_0076
IL_000b: ldarg.1
IL_000c: ldstr "everyone"
IL_0011: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0016: brtrue.s IL_004e
IL_0018: ldarg.1
IL_0019: ldstr "unison"
IL_001e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0023: brtrue.s IL_0056
IL_0025: ldarg.1
IL_0026: ldstr "clear_right"
IL_002b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0030: brtrue.s IL_005e
IL_0032: ldarg.1
IL_0033: ldstr "clear_left"
IL_0038: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_003d: brtrue.s IL_0066
IL_003f: ldarg.1
IL_0040: ldstr "ending_convo"
IL_0045: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_004a: brtrue.s IL_006e
IL_004c: br.s IL_0076
IL_004e: ldarg.0
IL_004f: ldc.i4.1
IL_0050: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_everyone
IL_0055: ret
IL_0056: ldarg.0
IL_0057: ldc.i4.1
IL_0058: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_unison
IL_005d: ret
IL_005e: ldarg.0
IL_005f: ldc.i4.1
IL_0060: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_clearright
IL_0065: ret
IL_0066: ldarg.0
IL_0067: ldc.i4.1
IL_0068: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_clearleft
IL_006d: ret
IL_006e: ldarg.0
IL_006f: ldc.i4.1
IL_0070: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_endingconvo
IL_0075: ret
IL_0076: ldarg.1
IL_0077: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_007c: brtrue IL_0289
IL_0081: ldarg.1
IL_0082: ldstr "rename"
IL_0087: callvirt System.Boolean System.String::Contains(System.String)
IL_008c: brfalse IL_019f
IL_0091: ldarg.1
IL_0092: ldstr ","
IL_0097: callvirt System.Boolean System.String::Contains(System.String)
IL_009c: brfalse IL_019f
IL_00a1: ldarg.1
IL_00a2: ldstr "["
IL_00a7: callvirt System.Boolean System.String::Contains(System.String)
IL_00ac: brfalse IL_019f
IL_00b1: ldarg.1
IL_00b2: ldstr "]"
IL_00b7: callvirt System.Boolean System.String::Contains(System.String)
IL_00bc: brfalse IL_019f
IL_00c1: ldarg.1
IL_00c2: ldc.i4.1
IL_00c3: newarr System.Char
IL_00c8: dup
IL_00c9: ldc.i4.0
IL_00ca: ldc.i4.s 91
IL_00cc: stelem.i2
IL_00cd: callvirt System.String[] System.String::Split(System.Char[])
IL_00d2: ldc.i4.1
IL_00d3: ldelem.ref
IL_00d4: ldstr "]"
IL_00d9: ldsfld System.String System.String::Empty
IL_00de: callvirt System.String System.String::Replace(System.String,System.String)
IL_00e3: ldc.i4.1
IL_00e4: newarr System.Char
IL_00e9: dup
IL_00ea: ldc.i4.0
IL_00eb: ldc.i4.s 44
IL_00ed: stelem.i2
IL_00ee: callvirt System.String[] System.String::Split(System.Char[])
IL_00f3: stloc.0
IL_00f4: ldloc.0
IL_00f5: ldlen
IL_00f6: conv.i4
IL_00f7: ldc.i4.3
IL_00f8: bne.un IL_0289
IL_00fd: ldloc.0
IL_00fe: ldc.i4.0
IL_00ff: ldelem.ref
IL_0100: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0105: brfalse.s IL_010a
IL_0107: ldnull
IL_0108: br.s IL_0112
IL_010a: ldloc.0
IL_010b: ldc.i4.0
IL_010c: ldelem.ref
IL_010d: callvirt System.String System.String::Trim()
IL_0112: stloc.1
IL_0113: ldloc.0
IL_0114: ldc.i4.1
IL_0115: ldelem.ref
IL_0116: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_011b: brfalse.s IL_0120
IL_011d: ldnull
IL_011e: br.s IL_0128
IL_0120: ldloc.0
IL_0121: ldc.i4.1
IL_0122: ldelem.ref
IL_0123: callvirt System.String System.String::Trim()
IL_0128: stloc.2
IL_0129: ldloc.0
IL_012a: ldc.i4.2
IL_012b: ldelem.ref
IL_012c: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0131: brfalse.s IL_0136
IL_0133: ldnull
IL_0134: br.s IL_013e
IL_0136: ldloc.0
IL_0137: ldc.i4.2
IL_0138: ldelem.ref
IL_0139: callvirt System.String System.String::Trim()
IL_013e: stloc.3
IL_013f: ldloc.1
IL_0140: brfalse IL_0289
IL_0145: ldloc.2
IL_0146: brfalse IL_0289
IL_014b: ldloc.3
IL_014c: brfalse IL_0289
IL_0151: ldarg.0
IL_0152: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.CustomPortraitsUi::replaceNames
IL_0157: ldloc.1
IL_0158: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.String>::ContainsKey(!0)
IL_015d: brfalse.s IL_017f
IL_015f: ldarg.0
IL_0160: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.CustomPortraitsUi::replaceNames
IL_0165: ldloc.1
IL_0166: ldloc.2
IL_0167: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.String>::set_Item(!0,!1)
IL_016c: ldarg.0
IL_016d: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Single> TheForestOfLove.CustomPortraitsUi::replacePitch
IL_0172: ldloc.1
IL_0173: ldloc.3
IL_0174: call System.Single System.Single::Parse(System.String)
IL_0179: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.Single>::set_Item(!0,!1)
IL_017e: ret
IL_017f: ldarg.0
IL_0180: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.CustomPortraitsUi::replaceNames
IL_0185: ldloc.1
IL_0186: ldloc.2
IL_0187: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.String>::Add(!0,!1)
IL_018c: ldarg.0
IL_018d: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Single> TheForestOfLove.CustomPortraitsUi::replacePitch
IL_0192: ldloc.1
IL_0193: ldloc.3
IL_0194: call System.Single System.Single::Parse(System.String)
IL_0199: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.Single>::Add(!0,!1)
IL_019e: ret
IL_019f: ldarg.1
IL_01a0: ldstr "force_next_left"
IL_01a5: callvirt System.Boolean System.String::Contains(System.String)
IL_01aa: brfalse.s IL_0216
IL_01ac: ldarg.1
IL_01ad: ldstr "["
IL_01b2: callvirt System.Boolean System.String::Contains(System.String)
IL_01b7: brfalse.s IL_0216
IL_01b9: ldarg.1
IL_01ba: ldstr "]"
IL_01bf: callvirt System.Boolean System.String::Contains(System.String)
IL_01c4: brfalse.s IL_0216
IL_01c6: ldarg.1
IL_01c7: ldc.i4.1
IL_01c8: newarr System.Char
IL_01cd: dup
IL_01ce: ldc.i4.0
IL_01cf: ldc.i4.s 91
IL_01d1: stelem.i2
IL_01d2: callvirt System.String[] System.String::Split(System.Char[])
IL_01d7: ldc.i4.1
IL_01d8: ldelem.ref
IL_01d9: ldstr "]"
IL_01de: ldsfld System.String System.String::Empty
IL_01e3: callvirt System.String System.String::Replace(System.String,System.String)
IL_01e8: stloc.s V_4
IL_01ea: ldloc.s V_4
IL_01ec: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_01f1: brfalse.s IL_01f6
IL_01f3: ldnull
IL_01f4: br.s IL_01fd
IL_01f6: ldloc.s V_4
IL_01f8: callvirt System.String System.String::Trim()
IL_01fd: stloc.s V_5
IL_01ff: ldloc.s V_5
IL_0201: brfalse IL_0289
IL_0206: ldarg.0
IL_0207: ldc.i4.1
IL_0208: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_forcenextleft
IL_020d: ldarg.0
IL_020e: ldloc.s V_5
IL_0210: stfld System.String TheForestOfLove.CustomPortraitsUi::forceNextLeft
IL_0215: ret
IL_0216: ldarg.1
IL_0217: ldstr "force_next_right"
IL_021c: callvirt System.Boolean System.String::Contains(System.String)
IL_0221: brfalse.s IL_0289
IL_0223: ldarg.1
IL_0224: ldstr "["
IL_0229: callvirt System.Boolean System.String::Contains(System.String)
IL_022e: brfalse.s IL_0289
IL_0230: ldarg.1
IL_0231: ldstr "]"
IL_0236: callvirt System.Boolean System.String::Contains(System.String)
IL_023b: brfalse.s IL_0289
IL_023d: ldarg.1
IL_023e: ldc.i4.1
IL_023f: newarr System.Char
IL_0244: dup
IL_0245: ldc.i4.0
IL_0246: ldc.i4.s 91
IL_0248: stelem.i2
IL_0249: callvirt System.String[] System.String::Split(System.Char[])
IL_024e: ldc.i4.1
IL_024f: ldelem.ref
IL_0250: ldstr "]"
IL_0255: ldsfld System.String System.String::Empty
IL_025a: callvirt System.String System.String::Replace(System.String,System.String)
IL_025f: stloc.s V_6
IL_0261: ldloc.s V_6
IL_0263: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0268: brfalse.s IL_026d
IL_026a: ldnull
IL_026b: br.s IL_0274
IL_026d: ldloc.s V_6
IL_026f: callvirt System.String System.String::Trim()
IL_0274: stloc.s V_7
IL_0276: ldloc.s V_7
IL_0278: brfalse.s IL_0289
IL_027a: ldarg.0
IL_027b: ldc.i4.1
IL_027c: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_forcenextright
IL_0281: ldarg.0
IL_0282: ldloc.s V_7
IL_0284: stfld System.String TheForestOfLove.CustomPortraitsUi::forceNextRight
IL_0289: ret
METHOD System.Void TheForestOfLove.CustomPortraitsUi::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
IL_0000: call PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueManager::get_dialogueUI()
IL_0005: castclass PixelCrushers.DialogueSystem.StandardDialogueUI
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: ldnull
IL_000d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0012: brtrue.s IL_001c
IL_0014: ldloc.0
IL_0015: callvirt System.Boolean PixelCrushers.DialogueSystem.AbstractDialogueUI::get_isOpen()
IL_001a: brtrue.s IL_001d
IL_001c: ret
IL_001d: ldarg.2
IL_001e: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0023: brfalse.s IL_003d
IL_0025: ldarg.2
IL_0026: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_002b: callvirt System.String System.String::ToLower()
IL_0030: ldstr "none"
IL_0035: callvirt System.Boolean System.String::Contains(System.String)
IL_003a: brfalse.s IL_003d
IL_003c: ret
IL_003d: ldarg.0
IL_003e: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::responseOptionsVisible
IL_0043: brfalse.s IL_004b
IL_0045: ldarg.0
IL_0046: call System.Void TheForestOfLove.CustomPortraitsUi::OnHideResponseOptions()
IL_004b: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsCurrentActorPlayer()
IL_0050: brfalse.s IL_0053
IL_0052: ret
IL_0053: ldarg.0
IL_0054: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::maximizePortraitsNextLineIfNotSuccessivePlayerResponses
IL_0059: brfalse.s IL_0068
IL_005b: ldarg.0
IL_005c: ldc.i4.0
IL_005d: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::maximizePortraitsNextLineIfNotSuccessivePlayerResponses
IL_0062: ldarg.0
IL_0063: call System.Void TheForestOfLove.CustomPortraitsUi::MaximizePortraits()
IL_0068: ldarg.2
IL_0069: callvirt UnityEngine.Sprite PixelCrushers.DialogueSystem.Subtitle::GetSpeakerPortrait()
IL_006e: stloc.1
IL_006f: ldnull
IL_0070: stloc.2
IL_0071: ldnull
IL_0072: stloc.3
IL_0073: ldarg.0
IL_0074: ldloc.1
IL_0075: ldloca.s V_2
IL_0077: ldloca.s V_3
IL_0079: call TheForestOfLove.Narrative.Portrait TheForestOfLove.CustomPortraitsUi::FindSchemaBySprite(UnityEngine.Sprite,UnityEngine.Sprite&,UnityEngine.Sprite&)
IL_007e: stloc.s V_4
IL_0080: ldloc.s V_4
IL_0082: brtrue.s IL_00ae
IL_0084: ldloc.1
IL_0085: ldnull
IL_0086: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_008b: brfalse.s IL_00ae
IL_008d: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsCurrentActorNarrator()
IL_0092: brtrue.s IL_00ae
IL_0094: ldstr "missing portrait schema for sprite "
IL_0099: ldloc.1
IL_009a: callvirt UnityEngine.Texture2D UnityEngine.Sprite::get_texture()
IL_009f: callvirt System.String UnityEngine.Object::get_name()
IL_00a4: call System.String System.String::Concat(System.String,System.String)
IL_00a9: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00ae: call System.Boolean TheForestOfLove.MovieManager::get_isPlayingMovie()
IL_00b3: brfalse IL_02e6
IL_00b8: call TheForestOfLove.Narrative.Movie TheForestOfLove.MovieManager::get_currentMovie()
IL_00bd: call TheForestOfLove.Narrative.MovieRecord TheForestOfLove.Services.Persistence.DataService::GetMovieRecordByMovie(TheForestOfLove.Narrative.Movie)
IL_00c2: ldfld System.Boolean TheForestOfLove.Narrative.MovieRecord::showDialogueNameplatesDuringMovie
IL_00c7: brfalse IL_02ec
IL_00cc: ldarg.0
IL_00cd: ldc.i4.1
IL_00ce: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::nameplatesVisible
IL_00d3: ldarg.0
IL_00d4: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateLeft
IL_00d9: ldc.r4 1
IL_00de: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00e3: ldarg.0
IL_00e4: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateRight
IL_00e9: ldc.r4 1
IL_00ee: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00f3: ldarg.0
IL_00f4: ldfld System.String TheForestOfLove.CustomPortraitsUi::forceNextLeft
IL_00f9: brtrue.s IL_0106
IL_00fb: ldarg.0
IL_00fc: ldfld System.String TheForestOfLove.CustomPortraitsUi::forceNextRight
IL_0101: brfalse IL_0195
IL_0106: ldarg.0
IL_0107: ldfld System.String TheForestOfLove.CustomPortraitsUi::forceNextLeft
IL_010c: brfalse.s IL_013f
IL_010e: ldarg.0
IL_010f: ldfld System.String TheForestOfLove.CustomPortraitsUi::forceNextRight
IL_0114: brtrue.s IL_0128
IL_0116: ldarg.0
IL_0117: ldarg.0
IL_0118: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateRight
IL_011d: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0122: ldnull
IL_0123: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_0128: ldarg.0
IL_0129: ldarg.0
IL_012a: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateLeft
IL_012f: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0134: ldarg.0
IL_0135: ldfld System.String TheForestOfLove.CustomPortraitsUi::forceNextLeft
IL_013a: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_013f: ldarg.0
IL_0140: ldfld System.String TheForestOfLove.CustomPortraitsUi::forceNextRight
IL_0145: brfalse.s IL_0178
IL_0147: ldarg.0
IL_0148: ldfld System.String TheForestOfLove.CustomPortraitsUi::forceNextLeft
IL_014d: brtrue.s IL_0161
IL_014f: ldarg.0
IL_0150: ldarg.0
IL_0151: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateLeft
IL_0156: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_015b: ldnull
IL_015c: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_0161: ldarg.0
IL_0162: ldarg.0
IL_0163: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateRight
IL_0168: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_016d: ldarg.0
IL_016e: ldfld System.String TheForestOfLove.CustomPortraitsUi::forceNextRight
IL_0173: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_0178: ldarg.0
IL_0179: ldc.i4.0
IL_017a: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_forcenextleft
IL_017f: ldarg.0
IL_0180: ldnull
IL_0181: stfld System.String TheForestOfLove.CustomPortraitsUi::forceNextLeft
IL_0186: ldarg.0
IL_0187: ldc.i4.0
IL_0188: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_forcenextright
IL_018d: ldarg.0
IL_018e: ldnull
IL_018f: stfld System.String TheForestOfLove.CustomPortraitsUi::forceNextRight
IL_0194: ret
IL_0195: ldarg.0
IL_0196: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait> TheForestOfLove.CustomPortraitsUi::rightAlignedSchemas
IL_019b: ldloc.s V_4
IL_019d: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait>::Contains(!0)
IL_01a2: brfalse IL_0233
IL_01a7: ldarg.0
IL_01a8: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.CustomPortraitsUi::replaceNames
IL_01ad: ldloc.s V_4
IL_01af: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_01b4: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_01b9: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.String>::ContainsKey(!0)
IL_01be: brfalse.s IL_01ff
IL_01c0: ldarg.0
IL_01c1: ldarg.0
IL_01c2: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateLeft
IL_01c7: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01cc: ldnull
IL_01cd: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_01d2: ldarg.0
IL_01d3: ldarg.0
IL_01d4: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateRight
IL_01d9: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01de: ldarg.0
IL_01df: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.CustomPortraitsUi::replaceNames
IL_01e4: ldloc.s V_4
IL_01e6: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_01eb: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_01f0: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.String>::get_Item(!0)
IL_01f5: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_01fa: br IL_02ec
IL_01ff: ldarg.0
IL_0200: ldarg.0
IL_0201: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateLeft
IL_0206: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_020b: ldnull
IL_020c: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_0211: ldarg.0
IL_0212: ldarg.0
IL_0213: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateRight
IL_0218: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_021d: ldloc.s V_4
IL_021f: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_0224: callvirt System.String TheForestOfLove.Narrative.Actor::get_NameplateName()
IL_0229: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_022e: br IL_02ec
IL_0233: ldloc.s V_4
IL_0235: brfalse IL_02c0
IL_023a: ldarg.0
IL_023b: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.CustomPortraitsUi::replaceNames
IL_0240: ldloc.s V_4
IL_0242: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_0247: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_024c: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.String>::ContainsKey(!0)
IL_0251: brfalse.s IL_028f
IL_0253: ldarg.0
IL_0254: ldarg.0
IL_0255: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateLeft
IL_025a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_025f: ldarg.0
IL_0260: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.CustomPortraitsUi::replaceNames
IL_0265: ldloc.s V_4
IL_0267: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_026c: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0271: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.String>::get_Item(!0)
IL_0276: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_027b: ldarg.0
IL_027c: ldarg.0
IL_027d: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateRight
IL_0282: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0287: ldnull
IL_0288: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_028d: br.s IL_02ec
IL_028f: ldarg.0
IL_0290: ldarg.0
IL_0291: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateLeft
IL_0296: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_029b: ldloc.s V_4
IL_029d: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_02a2: callvirt System.String TheForestOfLove.Narrative.Actor::get_NameplateName()
IL_02a7: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_02ac: ldarg.0
IL_02ad: ldarg.0
IL_02ae: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateRight
IL_02b3: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_02b8: ldnull
IL_02b9: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_02be: br.s IL_02ec
IL_02c0: ldarg.0
IL_02c1: ldarg.0
IL_02c2: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateLeft
IL_02c7: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_02cc: ldnull
IL_02cd: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_02d2: ldarg.0
IL_02d3: ldarg.0
IL_02d4: ldfld UnityEngine.CanvasGroup TheForestOfLove.CustomPortraitsUi::nameplateRight
IL_02d9: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_02de: ldnull
IL_02df: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)
IL_02e4: br.s IL_02ec
IL_02e6: ldarg.0
IL_02e7: call System.Void TheForestOfLove.CustomPortraitsUi::ResetNameplates()
IL_02ec: ldarg.0
IL_02ed: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.CustomPortraitsUi::replaceNames
IL_02f2: brfalse IL_0381
IL_02f7: ldloc.s V_4
IL_02f9: brfalse IL_0381
IL_02fe: ldloc.s V_4
IL_0300: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_0305: brfalse.s IL_0381
IL_0307: ldarg.0
IL_0308: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.CustomPortraitsUi::replaceNames
IL_030d: ldloc.s V_4
IL_030f: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_0314: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0319: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.String>::ContainsKey(!0)
IL_031e: brfalse.s IL_0381
IL_0320: ldarg.0
IL_0321: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Single> TheForestOfLove.CustomPortraitsUi::replacePitch
IL_0326: ldloc.s V_4
IL_0328: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_032d: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0332: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Single>::get_Item(!0)
IL_0337: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_033c: stsfld System.Single TheForestOfLove.Audio.SoundManager::defaultTypewriterPitch
IL_0341: ldarg.0
IL_0342: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Single> TheForestOfLove.CustomPortraitsUi::replacePitch
IL_0347: ldloc.s V_4
IL_0349: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Portrait::actor
IL_034e: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0353: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Single>::get_Item(!0)
IL_0358: ldc.r4 0
IL_035d: clt
IL_035f: stsfld System.Boolean TheForestOfLove.Audio.SoundManager::defaultTypewriterAlternateVoice
IL_0364: ldsfld System.Single TheForestOfLove.Audio.SoundManager::defaultTypewriterPitch
IL_0369: ldsfld System.Single TheForestOfLove.Audio.SoundManager::defaultTypewriterPitchOriginal
IL_036e: beq.s IL_0381
IL_0370: ldsfld System.Boolean TheForestOfLove.Audio.SoundManager::defaultTypewriterAlternateVoice
IL_0375: brtrue.s IL_0381
IL_0377: ldsfld System.Single TheForestOfLove.Audio.SoundManager::defaultTypewriterVolumeQuieter
IL_037c: stsfld System.Single TheForestOfLove.Audio.SoundManager::defaultTypewriterVolume
IL_0381: call System.Boolean TheForestOfLove.MovieManager::get_isPlayingMovie()
IL_0386: brfalse.s IL_0391
IL_0388: call TheForestOfLove.Narrative.Movie TheForestOfLove.MovieManager::get_currentMovie()
IL_038d: ldc.i4.2
IL_038e: beq.s IL_0391
IL_0390: ret
IL_0391: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inTestScene()
IL_0396: brfalse.s IL_03ac
IL_0398: ldloc.0
IL_0399: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_039e: callvirt !!0 UnityEngine.GameObject::GetComponentInParent<TheForestOfLove.MovieWrapper>()
IL_03a3: ldnull
IL_03a4: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_03a9: brfalse.s IL_03ac
IL_03ab: ret
IL_03ac: ldarg.0
IL_03ad: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait> TheForestOfLove.CustomPortraitsUi::rightAlignedSchemas
IL_03b2: ldloc.s V_4
IL_03b4: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Portrait>::Contains(!0)
IL_03b9: brfalse IL_044e
IL_03be: ldarg.0
IL_03bf: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::currentConversationActivatedRightPortrait
IL_03c4: brtrue.s IL_03e6
IL_03c6: ldarg.0
IL_03c7: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorRight
IL_03cc: ldstr "maximize_immediate"
IL_03d1: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_03d6: ldarg.0
IL_03d7: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorRight
IL_03dc: ldstr "maximize_immediate"
IL_03e1: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_03e6: ldarg.0
IL_03e7: ldc.i4.1
IL_03e8: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::currentConversationActivatedRightPortrait
IL_03ed: ldarg.0
IL_03ee: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_unison
IL_03f3: brtrue.s IL_0441
IL_03f5: ldarg.0
IL_03f6: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_everyone
IL_03fb: brtrue.s IL_0441
IL_03fd: ldarg.0
IL_03fe: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorLeft
IL_0403: ldstr "minimize"
IL_0408: ldc.i4.1
IL_0409: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_040e: ldarg.0
IL_040f: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorLeft
IL_0414: ldstr "minimize"
IL_0419: ldc.i4.1
IL_041a: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_041f: ldarg.0
IL_0420: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorRight
IL_0425: ldstr "minimize"
IL_042a: ldc.i4.0
IL_042b: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0430: ldarg.0
IL_0431: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorRight
IL_0436: ldstr "minimize"
IL_043b: ldc.i4.0
IL_043c: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0441: ldarg.0
IL_0442: ldarg.2
IL_0443: ldloc.2
IL_0444: ldloc.3
IL_0445: ldloc.s V_4
IL_0447: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateRightPortrait(PixelCrushers.DialogueSystem.Subtitle,UnityEngine.Sprite,UnityEngine.Sprite,TheForestOfLove.Narrative.Portrait)
IL_044c: br.s IL_04ad
IL_044e: ldarg.0
IL_044f: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_unison
IL_0454: brtrue.s IL_04a2
IL_0456: ldarg.0
IL_0457: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_everyone
IL_045c: brtrue.s IL_04a2
IL_045e: ldarg.0
IL_045f: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorLeft
IL_0464: ldstr "minimize"
IL_0469: ldc.i4.0
IL_046a: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_046f: ldarg.0
IL_0470: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorLeft
IL_0475: ldstr "minimize"
IL_047a: ldc.i4.0
IL_047b: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0480: ldarg.0
IL_0481: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorRight
IL_0486: ldstr "minimize"
IL_048b: ldc.i4.1
IL_048c: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0491: ldarg.0
IL_0492: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorRight
IL_0497: ldstr "minimize"
IL_049c: ldc.i4.1
IL_049d: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_04a2: ldarg.0
IL_04a3: ldarg.2
IL_04a4: ldloc.2
IL_04a5: ldloc.3
IL_04a6: ldloc.s V_4
IL_04a8: call System.Void TheForestOfLove.CustomPortraitsUi::UpdateLeftPortrait(PixelCrushers.DialogueSystem.Subtitle,UnityEngine.Sprite,UnityEngine.Sprite,TheForestOfLove.Narrative.Portrait)
IL_04ad: ldarg.0
IL_04ae: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_unison
IL_04b3: brfalse IL_0543
IL_04b8: ldarg.0
IL_04b9: ldc.i4.0
IL_04ba: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_unison
IL_04bf: ldarg.0
IL_04c0: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorLeft
IL_04c5: ldstr "minimize"
IL_04ca: ldc.i4.0
IL_04cb: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_04d0: ldarg.0
IL_04d1: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorLeft
IL_04d6: ldstr "minimize"
IL_04db: ldc.i4.0
IL_04dc: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_04e1: ldarg.0
IL_04e2: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorRight
IL_04e7: ldstr "minimize"
IL_04ec: ldc.i4.0
IL_04ed: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_04f2: ldarg.0
IL_04f3: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorRight
IL_04f8: ldstr "minimize"
IL_04fd: ldc.i4.0
IL_04fe: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0503: ldarg.0
IL_0504: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorLeft
IL_0509: ldstr "bounce"
IL_050e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0513: ldarg.0
IL_0514: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorLeft
IL_0519: ldstr "bounce"
IL_051e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0523: ldarg.0
IL_0524: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorRight
IL_0529: ldstr "bounce"
IL_052e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0533: ldarg.0
IL_0534: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorRight
IL_0539: ldstr "bounce"
IL_053e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0543: ldarg.0
IL_0544: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_everyone
IL_0549: brfalse IL_05d9
IL_054e: ldarg.0
IL_054f: ldc.i4.0
IL_0550: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_everyone
IL_0555: ldarg.0
IL_0556: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorLeft
IL_055b: ldstr "minimize"
IL_0560: ldc.i4.0
IL_0561: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0566: ldarg.0
IL_0567: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorLeft
IL_056c: ldstr "minimize"
IL_0571: ldc.i4.0
IL_0572: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0577: ldarg.0
IL_0578: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorRight
IL_057d: ldstr "minimize"
IL_0582: ldc.i4.0
IL_0583: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0588: ldarg.0
IL_0589: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorRight
IL_058e: ldstr "minimize"
IL_0593: ldc.i4.0
IL_0594: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0599: ldarg.0
IL_059a: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorLeft
IL_059f: ldstr "bounce"
IL_05a4: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_05a9: ldarg.0
IL_05aa: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorLeft
IL_05af: ldstr "bounce"
IL_05b4: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_05b9: ldarg.0
IL_05ba: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::portraitAnimatorRight
IL_05bf: ldstr "bounce"
IL_05c4: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_05c9: ldarg.0
IL_05ca: ldfld UnityEngine.Animator TheForestOfLove.CustomPortraitsUi::backgroundAnimatorRight
IL_05cf: ldstr "bounce"
IL_05d4: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_05d9: ldarg.0
IL_05da: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_clearleft
IL_05df: brfalse.s IL_05f4
IL_05e1: ldarg.0
IL_05e2: ldc.i4.0
IL_05e3: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_clearleft
IL_05e8: ldarg.0
IL_05e9: call System.Void TheForestOfLove.CustomPortraitsUi::ClearPortraitLeft()
IL_05ee: ldarg.0
IL_05ef: call System.Void TheForestOfLove.CustomPortraitsUi::ClearBackgroundLeft()
IL_05f4: ldarg.0
IL_05f5: ldfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_clearright
IL_05fa: brfalse.s IL_060f
IL_05fc: ldarg.0
IL_05fd: ldc.i4.0
IL_05fe: stfld System.Boolean TheForestOfLove.CustomPortraitsUi::trigger_clearright
IL_0603: ldarg.0
IL_0604: call System.Void TheForestOfLove.CustomPortraitsUi::ClearPortraitRight()
IL_0609: ldarg.0
IL_060a: call System.Void TheForestOfLove.CustomPortraitsUi::ClearBackgroundRight()
IL_060f: ret
