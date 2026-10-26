TYPE PixelCrushers.DialogueSystem.ConversationView
METHOD System.Void PixelCrushers.DialogueSystem.ConversationView::StartSubtitle(PixelCrushers.DialogueSystem.Subtitle,System.Boolean,System.Boolean) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::notifyOnFinishSubtitle
IL_0007: ldarg.1
IL_0008: brfalse IL_0192
IL_000d: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_0012: brfalse.s IL_0052
IL_0014: ldstr "{0}: {1} says '{2}'"
IL_0019: ldc.i4.3
IL_001a: newarr System.Object
IL_001f: dup
IL_0020: ldc.i4.0
IL_0021: ldstr "Dialogue System"
IL_0026: stelem.ref
IL_0027: dup
IL_0028: ldc.i4.1
IL_0029: ldarg.1
IL_002a: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_002f: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0034: call System.String PixelCrushers.DialogueSystem.Tools::GetGameObjectName(UnityEngine.Component)
IL_0039: stelem.ref
IL_003a: dup
IL_003b: ldc.i4.2
IL_003c: ldarg.1
IL_003d: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0042: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0047: stelem.ref
IL_0048: call System.String System.String::Format(System.String,System.Object[])
IL_004d: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0052: ldarg.0
IL_0053: ldarg.1
IL_0054: call System.Void PixelCrushers.DialogueSystem.ConversationView::NotifyParticipantsOnConversationLine(PixelCrushers.DialogueSystem.Subtitle)
IL_0059: ldarg.0
IL_005a: ldarg.1
IL_005b: call System.Boolean PixelCrushers.DialogueSystem.ConversationView::ShouldShowSubtitle(PixelCrushers.DialogueSystem.Subtitle)
IL_0060: brfalse.s IL_008e
IL_0062: ldarg.0
IL_0063: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.ConversationView::ui
IL_0068: ldarg.1
IL_0069: callvirt System.Void PixelCrushers.DialogueSystem.IDialogueUI::ShowSubtitle(PixelCrushers.DialogueSystem.Subtitle)
IL_006e: ldarg.0
IL_006f: ldarg.1
IL_0070: stfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::_subtitle
IL_0075: ldarg.0
IL_0076: ldarg.2
IL_0077: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::_isPCResponseMenuNext
IL_007c: ldarg.0
IL_007d: ldarg.3
IL_007e: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::_isPCAutoResponseNext
IL_0083: ldarg.0
IL_0084: ldarg.1
IL_0085: ldarg.2
IL_0086: ldarg.3
IL_0087: call System.Void PixelCrushers.DialogueSystem.ConversationView::SetupContinueButton(PixelCrushers.DialogueSystem.Subtitle,System.Boolean,System.Boolean)
IL_008c: br.s IL_0095
IL_008e: ldarg.0
IL_008f: ldc.i4.0
IL_0090: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::waitForContinue
IL_0095: ldarg.0
IL_0096: ldfld PixelCrushers.DialogueSystem.Sequencer PixelCrushers.DialogueSystem.ConversationView::m_sequencer
IL_009b: ldarg.1
IL_009c: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_00a1: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_00a6: ldarg.1
IL_00a7: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::listenerInfo
IL_00ac: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_00b1: callvirt System.Void PixelCrushers.DialogueSystem.Sequencer::SetParticipants(UnityEngine.Transform,UnityEngine.Transform)
IL_00b6: ldarg.0
IL_00b7: ldfld PixelCrushers.DialogueSystem.Sequencer PixelCrushers.DialogueSystem.ConversationView::m_sequencer
IL_00bc: ldarg.1
IL_00bd: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::entrytag
IL_00c2: callvirt System.Void PixelCrushers.DialogueSystem.Sequencer::set_entrytag(System.String)
IL_00c7: ldarg.0
IL_00c8: ldfld PixelCrushers.DialogueSystem.Sequencer PixelCrushers.DialogueSystem.ConversationView::m_sequencer
IL_00cd: ldarg.0
IL_00ce: ldarg.1
IL_00cf: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_00d4: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_00d9: call System.Single PixelCrushers.DialogueSystem.ConversationView::GetDefaultSubtitleDuration(System.String)
IL_00de: callvirt System.Void PixelCrushers.DialogueSystem.Sequencer::set_subtitleEndTime(System.Single)
IL_00e3: ldarg.1
IL_00e4: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_00e9: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00ee: brtrue.s IL_011f
IL_00f0: ldarg.1
IL_00f1: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_00f6: ldstr "{{default}}"
IL_00fb: callvirt System.Boolean System.String::Contains(System.String)
IL_0100: brfalse.s IL_011f
IL_0102: ldarg.1
IL_0103: ldarg.1
IL_0104: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0109: ldstr "{{default}}"
IL_010e: ldarg.0
IL_010f: ldarg.1
IL_0110: call System.String PixelCrushers.DialogueSystem.ConversationView::GetDefaultSequence(PixelCrushers.DialogueSystem.Subtitle)
IL_0115: callvirt System.String System.String::Replace(System.String,System.String)
IL_011a: stfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_011f: ldarg.1
IL_0120: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0125: callvirt System.Boolean PixelCrushers.DialogueSystem.CharacterInfo::get_isNPC()
IL_012a: brfalse.s IL_0135
IL_012c: ldarg.0
IL_012d: ldarg.1
IL_012e: stfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::lastNPCSubtitle
IL_0133: br.s IL_013c
IL_0135: ldarg.0
IL_0136: ldarg.1
IL_0137: stfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::lastPCSubtitle
IL_013c: ldarg.0
IL_013d: ldarg.1
IL_013e: stfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::lastSubtitle
IL_0143: ldarg.0
IL_0144: ldfld PixelCrushers.DialogueSystem.DialogueEntrySpokenDelegate PixelCrushers.DialogueSystem.ConversationView::dialogueEntrySpokenHandler
IL_0149: brfalse.s IL_0157
IL_014b: ldarg.0
IL_014c: ldfld PixelCrushers.DialogueSystem.DialogueEntrySpokenDelegate PixelCrushers.DialogueSystem.ConversationView::dialogueEntrySpokenHandler
IL_0151: ldarg.1
IL_0152: callvirt System.Void PixelCrushers.DialogueSystem.DialogueEntrySpokenDelegate::Invoke(PixelCrushers.DialogueSystem.Subtitle)
IL_0157: ldarg.0
IL_0158: ldfld PixelCrushers.DialogueSystem.Sequencer PixelCrushers.DialogueSystem.ConversationView::m_sequencer
IL_015d: ldarg.1
IL_015e: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0163: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0168: brtrue.s IL_0173
IL_016a: ldarg.0
IL_016b: ldarg.1
IL_016c: call System.String PixelCrushers.DialogueSystem.ConversationView::PreprocessSequence(PixelCrushers.DialogueSystem.Subtitle)
IL_0171: br.s IL_017a
IL_0173: ldarg.0
IL_0174: ldarg.1
IL_0175: call System.String PixelCrushers.DialogueSystem.ConversationView::GetDefaultSequence(PixelCrushers.DialogueSystem.Subtitle)
IL_017a: ldarg.0
IL_017b: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_0180: ldfld PixelCrushers.DialogueSystem.DisplaySettings/SubtitleSettings PixelCrushers.DialogueSystem.DisplaySettings::subtitleSettings
IL_0185: ldfld System.Boolean PixelCrushers.DialogueSystem.DisplaySettings/SubtitleSettings::informSequenceStartAndEnd
IL_018a: ldc.i4.0
IL_018b: callvirt System.Void PixelCrushers.DialogueSystem.Sequencer::PlaySequence(System.String,System.Boolean,System.Boolean)
IL_0190: br.s IL_0198
IL_0192: ldarg.0
IL_0193: call System.Void PixelCrushers.DialogueSystem.ConversationView::FinishSubtitle()
IL_0198: ldarg.0
IL_0199: ldarg.0
IL_019a: ldftn System.Boolean PixelCrushers.DialogueSystem.ConversationView::IsSubtitleCancelKeyDown()
IL_01a0: newobj System.Void PixelCrushers.DialogueSystem.ConversationView/IsCancelKeyDownDelegate::.ctor(System.Object,System.IntPtr)
IL_01a5: stfld PixelCrushers.DialogueSystem.ConversationView/IsCancelKeyDownDelegate PixelCrushers.DialogueSystem.ConversationView::IsCancelKeyDown
IL_01aa: ldarg.0
IL_01ab: ldarg.0
IL_01ac: ldftn System.Void PixelCrushers.DialogueSystem.ConversationView::OnCancelSubtitle()
IL_01b2: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01b7: stfld System.Action PixelCrushers.DialogueSystem.ConversationView::CancelledHandler
IL_01bc: ldarg.1
IL_01bd: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_01c2: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_01c7: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_01cc: brtrue.s IL_01d5
IL_01ce: ldarg.0
IL_01cf: ldc.i4.0
IL_01d0: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::_lastModeWasResponseMenu
IL_01d5: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.ConversationView::ShouldShowSubtitle(PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse IL_00c8
IL_0006: ldarg.0
IL_0007: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_000c: brfalse IL_00c8
IL_0011: ldarg.0
IL_0012: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_0017: ldfld PixelCrushers.DialogueSystem.DisplaySettings/SubtitleSettings PixelCrushers.DialogueSystem.DisplaySettings::subtitleSettings
IL_001c: brfalse IL_00c8
IL_0021: ldarg.1
IL_0022: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0027: callvirt System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_noSubtitle()
IL_002c: brtrue.s IL_0076
IL_002e: ldarg.1
IL_002f: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0034: ldstr "None()"
IL_0039: call System.Boolean System.String::Equals(System.String,System.String)
IL_003e: brtrue.s IL_0076
IL_0040: ldarg.1
IL_0041: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0046: ldstr "None();"
IL_004b: call System.Boolean System.String::Equals(System.String,System.String)
IL_0050: brtrue.s IL_0076
IL_0052: ldarg.1
IL_0053: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0058: ldstr "Continue()"
IL_005d: call System.Boolean System.String::Equals(System.String,System.String)
IL_0062: brtrue.s IL_0076
IL_0064: ldarg.1
IL_0065: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_006a: ldstr "Continue();"
IL_006f: call System.Boolean System.String::Equals(System.String,System.String)
IL_0074: brfalse.s IL_0078
IL_0076: ldc.i4.0
IL_0077: ret
IL_0078: ldarg.1
IL_0079: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_007e: ldfld PixelCrushers.DialogueSystem.CharacterType PixelCrushers.DialogueSystem.CharacterInfo::characterType
IL_0083: ldc.i4.1
IL_0084: bne.un.s IL_0095
IL_0086: ldarg.0
IL_0087: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_008c: callvirt System.Boolean PixelCrushers.DialogueSystem.DisplaySettings::GetShowNPCSubtitlesDuringLine()
IL_0091: brfalse.s IL_0095
IL_0093: ldc.i4.1
IL_0094: ret
IL_0095: ldarg.1
IL_0096: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_009b: ldfld PixelCrushers.DialogueSystem.CharacterType PixelCrushers.DialogueSystem.CharacterInfo::characterType
IL_00a0: brtrue.s IL_00c8
IL_00a2: ldarg.0
IL_00a3: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_00a8: callvirt System.Boolean PixelCrushers.DialogueSystem.DisplaySettings::GetShowPCSubtitlesDuringLine()
IL_00ad: brfalse.s IL_00c8
IL_00af: ldarg.0
IL_00b0: ldfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::_lastModeWasResponseMenu
IL_00b5: brfalse.s IL_00c6
IL_00b7: ldarg.0
IL_00b8: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_00bd: callvirt System.Boolean PixelCrushers.DialogueSystem.DisplaySettings::GetSkipPCSubtitleAfterResponseMenu()
IL_00c2: ldc.i4.0
IL_00c3: ceq
IL_00c5: ret
IL_00c6: ldc.i4.1
IL_00c7: ret
IL_00c8: ldc.i4.0
IL_00c9: ret
METHOD System.Void PixelCrushers.DialogueSystem.ConversationView::SelectResponse(PixelCrushers.DialogueSystem.SelectedResponseEventArgs) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void PixelCrushers.DialogueSystem.ConversationView::StopResponseMenuSequence()
IL_0006: ldarg.0
IL_0007: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.ConversationView::ui
IL_000c: callvirt System.Void PixelCrushers.DialogueSystem.IDialogueUI::HideResponses()
IL_0011: ldarg.0
IL_0012: ldfld System.EventHandler`1<PixelCrushers.DialogueSystem.SelectedResponseEventArgs> PixelCrushers.DialogueSystem.ConversationView::SelectedResponseHandler
IL_0017: brfalse.s IL_0026
IL_0019: ldarg.0
IL_001a: ldfld System.EventHandler`1<PixelCrushers.DialogueSystem.SelectedResponseEventArgs> PixelCrushers.DialogueSystem.ConversationView::SelectedResponseHandler
IL_001f: ldarg.0
IL_0020: ldarg.1
IL_0021: callvirt System.Void System.EventHandler`1<PixelCrushers.DialogueSystem.SelectedResponseEventArgs>::Invoke(System.Object,!0)
IL_0026: ret
