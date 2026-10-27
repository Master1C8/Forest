TYPE PixelCrushers.DialogueSystem.ConversationView
METHOD System.Void PixelCrushers.DialogueSystem.ConversationView::Initialize(PixelCrushers.DialogueSystem.IDialogueUI,PixelCrushers.DialogueSystem.Sequencer,PixelCrushers.DialogueSystem.DisplaySettings,PixelCrushers.DialogueSystem.DialogueEntrySpokenDelegate) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.ConversationView::ui
IL_0007: ldarg.0
IL_0008: ldarg.2
IL_0009: stfld PixelCrushers.DialogueSystem.Sequencer PixelCrushers.DialogueSystem.ConversationView::m_sequencer
IL_000e: ldarg.0
IL_000f: ldarg.3
IL_0010: stfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::settings
IL_0015: ldarg.0
IL_0016: ldarg.s dialogueEntrySpokenHandler
IL_0018: stfld PixelCrushers.DialogueSystem.DialogueEntrySpokenDelegate PixelCrushers.DialogueSystem.ConversationView::dialogueEntrySpokenHandler
IL_001d: ldarg.0
IL_001e: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0023: stfld System.Int32 PixelCrushers.DialogueSystem.ConversationView::initialFrameCount
IL_0028: ldarg.1
IL_0029: callvirt System.Void PixelCrushers.DialogueSystem.IDialogueUI::Open()
IL_002e: ldarg.2
IL_002f: callvirt System.Void PixelCrushers.DialogueSystem.Sequencer::Open()
IL_0034: ldarg.1
IL_0035: ldarg.0
IL_0036: ldftn System.Void PixelCrushers.DialogueSystem.ConversationView::OnSelectedResponse(System.Object,PixelCrushers.DialogueSystem.SelectedResponseEventArgs)
IL_003c: newobj System.Void System.EventHandler`1<PixelCrushers.DialogueSystem.SelectedResponseEventArgs>::.ctor(System.Object,System.IntPtr)
IL_0041: callvirt System.Void PixelCrushers.DialogueSystem.IDialogueUI::add_SelectedResponseHandler(System.EventHandler`1<PixelCrushers.DialogueSystem.SelectedResponseEventArgs>)
IL_0046: ldarg.2
IL_0047: ldarg.0
IL_0048: ldftn System.Void PixelCrushers.DialogueSystem.ConversationView::OnFinishedSubtitle()
IL_004e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0053: callvirt System.Void PixelCrushers.DialogueSystem.Sequencer::add_FinishedSequenceHandler(System.Action)
IL_0058: ret
