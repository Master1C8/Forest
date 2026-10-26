TYPE PixelCrushers.DialogueSystem.ConversationView
METHOD System.Void PixelCrushers.DialogueSystem.ConversationView::HandleContinueButtonClick() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0005: ldarg.0
IL_0006: ldfld System.Int32 PixelCrushers.DialogueSystem.ConversationView::initialFrameCount
IL_000b: bne.un.s IL_001b
IL_000d: ldarg.0
IL_000e: ldfld System.Int32 PixelCrushers.DialogueSystem.ConversationView::initialFrameCount
IL_0013: call System.Int32 PixelCrushers.DialogueSystem.ConversationController::get_frameLastConversationEnded()
IL_0018: bne.un.s IL_001b
IL_001a: ret
IL_001b: ldarg.0
IL_001c: ldc.i4.0
IL_001d: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::waitForContinue
IL_0022: ldarg.0
IL_0023: call System.Void PixelCrushers.DialogueSystem.ConversationView::FinishSubtitle()
IL_0028: ret
METHOD System.Void PixelCrushers.DialogueSystem.ConversationView::FinishSubtitle() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::waitForContinue
IL_0006: brtrue.s IL_006e
IL_0008: ldarg.0
IL_0009: ldfld PixelCrushers.DialogueSystem.Sequencer PixelCrushers.DialogueSystem.ConversationView::m_sequencer
IL_000e: ldnull
IL_000f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0014: brfalse.s IL_0021
IL_0016: ldarg.0
IL_0017: ldfld PixelCrushers.DialogueSystem.Sequencer PixelCrushers.DialogueSystem.ConversationView::m_sequencer
IL_001c: callvirt System.Void PixelCrushers.DialogueSystem.Sequencer::Stop()
IL_0021: ldarg.0
IL_0022: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.ConversationView::ui
IL_0027: ldarg.0
IL_0028: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::lastSubtitle
IL_002d: callvirt System.Void PixelCrushers.DialogueSystem.IDialogueUI::HideSubtitle(PixelCrushers.DialogueSystem.Subtitle)
IL_0032: ldarg.0
IL_0033: ldfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::notifyOnFinishSubtitle
IL_0038: brfalse.s IL_006e
IL_003a: ldarg.0
IL_003b: ldc.i4.0
IL_003c: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::notifyOnFinishSubtitle
IL_0041: ldarg.0
IL_0042: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::_subtitle
IL_0047: brfalse.s IL_0055
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::lastSubtitle
IL_0050: call System.Void PixelCrushers.DialogueSystem.ConversationView::NotifyParticipantsOnConversationLineEnd(PixelCrushers.DialogueSystem.Subtitle)
IL_0055: ldarg.0
IL_0056: ldfld System.EventHandler PixelCrushers.DialogueSystem.ConversationView::FinishedSubtitleHandler
IL_005b: brfalse.s IL_006e
IL_005d: ldarg.0
IL_005e: ldfld System.EventHandler PixelCrushers.DialogueSystem.ConversationView::FinishedSubtitleHandler
IL_0063: ldarg.0
IL_0064: ldsfld System.EventArgs System.EventArgs::Empty
IL_0069: callvirt System.Void System.EventHandler::Invoke(System.Object,System.EventArgs)
IL_006e: ret
METHOD System.Void PixelCrushers.DialogueSystem.ConversationView::OnFinishedSubtitle() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void PixelCrushers.DialogueSystem.ConversationView::FinishSubtitle()
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.ConversationView::StartResponses(PixelCrushers.DialogueSystem.Subtitle,PixelCrushers.DialogueSystem.Response[]) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::responseMenuSequence
IL_0007: call System.Void PixelCrushers.DialogueSystem.ConversationView::PlayResponseMenuSequence(System.String)
IL_000c: ldarg.0
IL_000d: call System.Boolean PixelCrushers.DialogueSystem.ConversationView::ShouldShowLastPCSubtitle()
IL_0012: brtrue.s IL_0027
IL_0014: ldarg.0
IL_0015: call System.Boolean PixelCrushers.DialogueSystem.ConversationView::ShouldShowLastNPCSubtitle()
IL_001a: brtrue.s IL_001f
IL_001c: ldnull
IL_001d: br.s IL_002d
IL_001f: ldarg.0
IL_0020: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::lastNPCSubtitle
IL_0025: br.s IL_002d
IL_0027: ldarg.0
IL_0028: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationView::lastPCSubtitle
IL_002d: stloc.0
IL_002e: ldarg.0
IL_002f: ldarg.2
IL_0030: call System.Void PixelCrushers.DialogueSystem.ConversationView::NotifyOnResponseMenu(PixelCrushers.DialogueSystem.Response[])
IL_0035: ldarg.0
IL_0036: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.ConversationView::ui
IL_003b: ldloc.0
IL_003c: ldarg.2
IL_003d: ldarg.0
IL_003e: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_0043: callvirt System.Single PixelCrushers.DialogueSystem.DisplaySettings::GetResponseTimeout()
IL_0048: callvirt System.Void PixelCrushers.DialogueSystem.IDialogueUI::ShowResponses(PixelCrushers.DialogueSystem.Subtitle,PixelCrushers.DialogueSystem.Response[],System.Single)
IL_004d: ldarg.0
IL_004e: ldarg.0
IL_004f: ldftn System.Boolean PixelCrushers.DialogueSystem.ConversationView::IsConversationCancelKeyDown()
IL_0055: newobj System.Void PixelCrushers.DialogueSystem.ConversationView/IsCancelKeyDownDelegate::.ctor(System.Object,System.IntPtr)
IL_005a: stfld PixelCrushers.DialogueSystem.ConversationView/IsCancelKeyDownDelegate PixelCrushers.DialogueSystem.ConversationView::IsCancelKeyDown
IL_005f: ldarg.0
IL_0060: ldarg.0
IL_0061: ldftn System.Void PixelCrushers.DialogueSystem.ConversationView::OnCancelResponseMenu()
IL_0067: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_006c: stfld System.Action PixelCrushers.DialogueSystem.ConversationView::CancelledHandler
IL_0071: ldarg.0
IL_0072: ldc.i4.1
IL_0073: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationView::_lastModeWasResponseMenu
IL_0078: ret
