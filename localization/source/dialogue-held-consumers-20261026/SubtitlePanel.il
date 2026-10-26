TYPE PixelCrushers.DialogueSystem.StandardUISubtitlePanel
METHOD System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::SetContent(PixelCrushers.DialogueSystem.Subtitle)
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0004
IL_0003: ret
IL_0004: ldarg.0
IL_0005: ldarg.1
IL_0006: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_currentSubtitle(PixelCrushers.DialogueSystem.Subtitle)
IL_000b: ldarg.0
IL_000c: ldarg.1
IL_000d: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::CheckSubtitleAnimator(PixelCrushers.DialogueSystem.Subtitle)
IL_0012: ldarg.0
IL_0013: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::onlyShowNPCPortraits
IL_0018: brfalse.s IL_002a
IL_001a: ldarg.1
IL_001b: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0020: callvirt System.Boolean PixelCrushers.DialogueSystem.CharacterInfo::get_isNPC()
IL_0025: brfalse IL_00ac
IL_002a: ldarg.0
IL_002b: ldfld UnityEngine.UI.Image PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitImage
IL_0030: ldnull
IL_0031: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0036: brfalse.s IL_005d
IL_0038: ldarg.1
IL_0039: callvirt UnityEngine.Sprite PixelCrushers.DialogueSystem.Subtitle::GetSpeakerPortrait()
IL_003e: stloc.2
IL_003f: ldarg.0
IL_0040: ldfld UnityEngine.UI.Image PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitImage
IL_0045: ldloc.2
IL_0046: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.UI.Image PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitImage
IL_0051: ldloc.2
IL_0052: ldnull
IL_0053: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0058: call System.Void PixelCrushers.DialogueSystem.Tools::SetGameObjectActive(UnityEngine.Component,System.Boolean)
IL_005d: ldarg.0
IL_005e: ldarg.1
IL_005f: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0064: ldfld System.String PixelCrushers.DialogueSystem.CharacterInfo::nameInDatabase
IL_0069: call System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_portraitActorName(System.String)
IL_006e: ldarg.0
IL_006f: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitName
IL_0074: callvirt System.String PixelCrushers.UITextField::get_text()
IL_0079: ldarg.1
IL_007a: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_007f: callvirt System.String PixelCrushers.DialogueSystem.CharacterInfo::get_Name()
IL_0084: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0089: brfalse.s IL_00ac
IL_008b: ldarg.0
IL_008c: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitName
IL_0091: ldarg.1
IL_0092: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0097: callvirt System.String PixelCrushers.DialogueSystem.CharacterInfo::get_Name()
IL_009c: callvirt System.Void PixelCrushers.UITextField::set_text(System.String)
IL_00a1: ldarg.0
IL_00a2: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitName
IL_00a7: call System.Void PixelCrushers.DialogueSystem.UITools::SendTextChangeMessage(PixelCrushers.UITextField)
IL_00ac: ldarg.0
IL_00ad: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_00b2: call System.Void PixelCrushers.DialogueSystem.TypewriterUtility::StopTyping(PixelCrushers.UITextField)
IL_00b7: ldarg.0
IL_00b8: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::accumulateText
IL_00bd: brtrue.s IL_00c6
IL_00bf: ldsfld System.String System.String::Empty
IL_00c4: br.s IL_00cc
IL_00c6: ldarg.0
IL_00c7: ldfld System.String PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_accumulatedText
IL_00cc: stloc.0
IL_00cd: ldarg.0
IL_00ce: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::accumulateText
IL_00d3: brtrue.s IL_00d8
IL_00d5: ldc.i4.0
IL_00d6: br.s IL_00ed
IL_00d8: ldloc.0
IL_00d9: call System.String PixelCrushers.DialogueSystem.Tools::StripRichTextCodes(System.String)
IL_00de: call System.String PixelCrushers.DialogueSystem.Tools::StripTextMeshProTags(System.String)
IL_00e3: call System.String PixelCrushers.DialogueSystem.UITools::StripRPGMakerCodes(System.String)
IL_00e8: callvirt System.Int32 System.String::get_Length()
IL_00ed: stloc.1
IL_00ee: ldarg.0
IL_00ef: ldarg.0
IL_00f0: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_00f5: ldloc.0
IL_00f6: ldarg.1
IL_00f7: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_00fc: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::SetFormattedText(PixelCrushers.UITextField,System.String,PixelCrushers.DialogueSystem.FormattedText)
IL_0101: ldarg.0
IL_0102: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::accumulateText
IL_0107: brfalse.s IL_0124
IL_0109: ldarg.0
IL_010a: ldarg.0
IL_010b: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_0110: callvirt System.String PixelCrushers.UITextField::get_text()
IL_0115: ldstr "
"
IL_011a: call System.String System.String::Concat(System.String,System.String)
IL_011f: stfld System.String PixelCrushers.DialogueSystem.StandardUISubtitlePanel::m_accumulatedText
IL_0124: ldarg.0
IL_0125: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::delayTypewriterUntilOpen
IL_012a: brfalse.s IL_0155
IL_012c: ldarg.0
IL_012d: call System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_hasFocus()
IL_0132: brtrue.s IL_0155
IL_0134: ldarg.0
IL_0135: ldarg.0
IL_0136: ldarg.0
IL_0137: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_013c: ldarg.0
IL_013d: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_0142: callvirt System.String PixelCrushers.UITextField::get_text()
IL_0147: ldloc.1
IL_0148: callvirt System.Collections.IEnumerator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::StartTypingWhenFocused(PixelCrushers.UITextField,System.String,System.Int32)
IL_014d: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0152: pop
IL_0153: br.s IL_016c
IL_0155: ldarg.0
IL_0156: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_015b: ldarg.0
IL_015c: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_0161: callvirt System.String PixelCrushers.UITextField::get_text()
IL_0166: ldloc.1
IL_0167: call System.Void PixelCrushers.DialogueSystem.TypewriterUtility::StartTyping(PixelCrushers.UITextField,System.String,System.Int32)
IL_016c: ldarg.0
IL_016d: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0172: stfld System.Int32 PixelCrushers.DialogueSystem.StandardUISubtitlePanel::frameLastSetContent
IL_0177: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::SetFormattedText(PixelCrushers.UITextField,System.String,PixelCrushers.DialogueSystem.FormattedText)
IL_0000: ldarg.1
IL_0001: ldarg.2
IL_0002: ldarg.3
IL_0003: call System.String PixelCrushers.DialogueSystem.UITools::GetUIFormattedText(PixelCrushers.DialogueSystem.FormattedText)
IL_0008: call System.String System.String::Concat(System.String,System.String)
IL_000d: callvirt System.Void PixelCrushers.UITextField::set_text(System.String)
IL_0012: ldarg.1
IL_0013: call System.Void PixelCrushers.DialogueSystem.UITools::SendTextChangeMessage(PixelCrushers.UITextField)
IL_0018: ldarg.0
IL_0019: call System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_haveSavedOriginalColor()
IL_001e: brtrue.s IL_0033
IL_0020: ldarg.0
IL_0021: ldarg.1
IL_0022: callvirt UnityEngine.Color PixelCrushers.UITextField::get_color()
IL_0027: call System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_originalColor(UnityEngine.Color)
IL_002c: ldarg.0
IL_002d: ldc.i4.1
IL_002e: call System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_haveSavedOriginalColor(System.Boolean)
IL_0033: ldarg.1
IL_0034: ldarg.3
IL_0035: callvirt PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::get_emphases()
IL_003a: brfalse.s IL_0045
IL_003c: ldarg.3
IL_003d: callvirt PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::get_emphases()
IL_0042: ldlen
IL_0043: brtrue.s IL_004d
IL_0045: ldarg.0
IL_0046: call UnityEngine.Color PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_originalColor()
IL_004b: br.s IL_005e
IL_004d: ldarg.3
IL_004e: callvirt PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::get_emphases()
IL_0053: ldc.i4.0
IL_0054: ldelema PixelCrushers.DialogueSystem.Emphasis
IL_0059: call UnityEngine.Color PixelCrushers.DialogueSystem.Emphasis::get_color()
IL_005e: callvirt System.Void PixelCrushers.UITextField::set_color(UnityEngine.Color)
IL_0063: ret
