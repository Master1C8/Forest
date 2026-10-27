TYPE PixelCrushers.DialogueSystem.StandardUISubtitleControls
METHOD System.Void PixelCrushers.DialogueSystem.StandardUISubtitleControls::ShowSubtitle(PixelCrushers.DialogueSystem.Subtitle) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0004
IL_0003: ret
IL_0004: ldarg.0
IL_0005: ldarg.1
IL_0006: ldloca.s V_0
IL_0008: callvirt PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::GetPanel(PixelCrushers.DialogueSystem.Subtitle,PixelCrushers.DialogueSystem.DialogueActor&)
IL_000d: stloc.1
IL_000e: ldarg.0
IL_000f: ldarg.1
IL_0010: call System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitleControls::SubtitleUsesBarkUI(PixelCrushers.DialogueSystem.Subtitle)
IL_0015: brfalse.s IL_0044
IL_0017: ldarg.1
IL_0018: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_001d: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0022: ldarg.1
IL_0023: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0028: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_002d: ldarg.1
IL_002e: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::listenerInfo
IL_0033: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0038: ldarg.1
IL_0039: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_003e: call System.Void PixelCrushers.DialogueSystem.DialogueManager::BarkString(System.String,UnityEngine.Transform,UnityEngine.Transform,System.String)
IL_0043: ret
IL_0044: ldloc.1
IL_0045: ldnull
IL_0046: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_004b: brfalse.s IL_0073
IL_004d: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_0052: brfalse IL_0186
IL_0057: ldstr "Dialogue System: Can't find subtitle panel for "
IL_005c: ldarg.0
IL_005d: ldarg.1
IL_005e: call System.String PixelCrushers.DialogueSystem.StandardUISubtitleControls::GetSubtitleTextSummary(PixelCrushers.DialogueSystem.Subtitle)
IL_0063: ldstr "."
IL_0068: call System.String System.String::Concat(System.String,System.String,System.String)
IL_006d: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0072: ret
IL_0073: ldarg.1
IL_0074: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0079: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_007e: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0083: brfalse.s IL_008d
IL_0085: ldarg.0
IL_0086: ldarg.1
IL_0087: call System.Void PixelCrushers.DialogueSystem.StandardUISubtitleControls::HideSubtitle(PixelCrushers.DialogueSystem.Subtitle)
IL_008c: ret
IL_008d: ldarg.1
IL_008e: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0093: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_0098: stloc.2
IL_0099: ldarg.0
IL_009a: ldfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_lastPanelUsedByActor
IL_009f: ldloc.2
IL_00a0: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::ContainsKey(!0)
IL_00a5: brfalse.s IL_0101
IL_00a7: ldarg.0
IL_00a8: ldfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_lastPanelUsedByActor
IL_00ad: ldloc.2
IL_00ae: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Item(!0)
IL_00b3: ldloc.1
IL_00b4: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00b9: brfalse.s IL_0101
IL_00bb: ldarg.0
IL_00bc: ldfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_lastPanelUsedByActor
IL_00c1: ldloc.2
IL_00c2: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Item(!0)
IL_00c7: stloc.3
IL_00c8: ldarg.0
IL_00c9: ldfld System.Collections.Generic.Dictionary`2<PixelCrushers.DialogueSystem.StandardUISubtitlePanel,System.Int32> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_lastActorToUsePanel
IL_00ce: ldloc.3
IL_00cf: callvirt System.Boolean System.Collections.Generic.Dictionary`2<PixelCrushers.DialogueSystem.StandardUISubtitlePanel,System.Int32>::ContainsKey(!0)
IL_00d4: brfalse.s IL_0101
IL_00d6: ldarg.0
IL_00d7: ldfld System.Collections.Generic.Dictionary`2<PixelCrushers.DialogueSystem.StandardUISubtitlePanel,System.Int32> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_lastActorToUsePanel
IL_00dc: ldloc.3
IL_00dd: callvirt !1 System.Collections.Generic.Dictionary`2<PixelCrushers.DialogueSystem.StandardUISubtitlePanel,System.Int32>::get_Item(!0)
IL_00e2: ldloc.2
IL_00e3: bne.un.s IL_0101
IL_00e5: ldloc.3
IL_00e6: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_hasFocus()
IL_00eb: brfalse.s IL_00f3
IL_00ed: ldloc.3
IL_00ee: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::Unfocus()
IL_00f3: ldloc.3
IL_00f4: callvirt System.Boolean PixelCrushers.UIPanel::get_isOpen()
IL_00f9: brfalse.s IL_0101
IL_00fb: ldloc.3
IL_00fc: callvirt System.Void PixelCrushers.UIPanel::Close()
IL_0101: ldarg.0
IL_0102: ldloc.1
IL_0103: ldloc.2
IL_0104: call System.Void PixelCrushers.DialogueSystem.StandardUISubtitleControls::SetLastActorToUsePanel(PixelCrushers.DialogueSystem.StandardUISubtitlePanel,System.Int32)
IL_0109: ldarg.0
IL_010a: ldloc.1
IL_010b: stfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_focusedPanel
IL_0110: ldloc.1
IL_0111: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::addSpeakerName
IL_0116: brfalse.s IL_0150
IL_0118: ldarg.1
IL_0119: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_011e: ldloc.1
IL_011f: ldfld System.String PixelCrushers.DialogueSystem.StandardUISubtitlePanel::addSpeakerNameFormat
IL_0124: ldc.i4.2
IL_0125: newarr System.Object
IL_012a: dup
IL_012b: ldc.i4.0
IL_012c: ldarg.1
IL_012d: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0132: callvirt System.String PixelCrushers.DialogueSystem.CharacterInfo::get_Name()
IL_0137: stelem.ref
IL_0138: dup
IL_0139: ldc.i4.1
IL_013a: ldarg.1
IL_013b: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0140: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0145: stelem.ref
IL_0146: call System.String System.String::Format(System.String,System.Object[])
IL_014b: callvirt System.Void PixelCrushers.DialogueSystem.FormattedText::set_text(System.String)
IL_0150: ldloc.0
IL_0151: ldnull
IL_0152: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0157: brfalse.s IL_0178
IL_0159: ldloc.0
IL_015a: ldfld PixelCrushers.DialogueSystem.DialogueActor/StandardDialogueUISettings PixelCrushers.DialogueSystem.DialogueActor::standardDialogueUISettings
IL_015f: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueActor/StandardDialogueUISettings::setSubtitleColor
IL_0164: brfalse.s IL_0178
IL_0166: ldarg.1
IL_0167: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_016c: ldloc.0
IL_016d: ldarg.1
IL_016e: callvirt System.String PixelCrushers.DialogueSystem.DialogueActor::AdjustSubtitleColor(PixelCrushers.DialogueSystem.Subtitle)
IL_0173: callvirt System.Void PixelCrushers.DialogueSystem.FormattedText::set_text(System.String)
IL_0178: ldloc.1
IL_0179: ldarg.1
IL_017a: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::ShowSubtitle(PixelCrushers.DialogueSystem.Subtitle)
IL_017f: ldarg.0
IL_0180: ldloc.1
IL_0181: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitleControls::SupercedeOtherPanels(PixelCrushers.DialogueSystem.StandardUISubtitlePanel)
IL_0186: ret
