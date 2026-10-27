TYPE PixelCrushers.DialogueSystem.ConversationController
METHOD System.Void PixelCrushers.DialogueSystem.ConversationController::Initialize(PixelCrushers.DialogueSystem.ConversationModel,PixelCrushers.DialogueSystem.ConversationView,System.Boolean,PixelCrushers.DialogueSystem.ConversationController/EndConversationDelegate) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void PixelCrushers.DialogueSystem.ConversationController::set_isActive(System.Boolean)
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: stfld PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ConversationController::m_model
IL_000e: ldarg.0
IL_000f: ldarg.2
IL_0010: stfld PixelCrushers.DialogueSystem.ConversationView PixelCrushers.DialogueSystem.ConversationController::m_view
IL_0015: ldarg.0
IL_0016: ldarg.s endConversationHandler
IL_0018: stfld PixelCrushers.DialogueSystem.ConversationController/EndConversationDelegate PixelCrushers.DialogueSystem.ConversationController::m_endConversationHandler
IL_001d: ldarg.0
IL_001e: ldc.i4.0
IL_001f: call System.Void PixelCrushers.DialogueSystem.ConversationController::set_randomizeNextEntry(System.Boolean)
IL_0024: ldarg.1
IL_0025: ldstr "OnConversationStart"
IL_002a: ldc.i4.0
IL_002b: callvirt System.Void PixelCrushers.DialogueSystem.ConversationModel::InformParticipants(System.String,System.Boolean)
IL_0030: ldarg.2
IL_0031: ldarg.0
IL_0032: ldftn System.Void PixelCrushers.DialogueSystem.ConversationController::OnFinishedSubtitle(System.Object,System.EventArgs)
IL_0038: newobj System.Void System.EventHandler::.ctor(System.Object,System.IntPtr)
IL_003d: callvirt System.Void PixelCrushers.DialogueSystem.ConversationView::add_FinishedSubtitleHandler(System.EventHandler)
IL_0042: ldarg.2
IL_0043: ldarg.0
IL_0044: ldftn System.Void PixelCrushers.DialogueSystem.ConversationController::OnSelectedResponse(System.Object,PixelCrushers.DialogueSystem.SelectedResponseEventArgs)
IL_004a: newobj System.Void System.EventHandler`1<PixelCrushers.DialogueSystem.SelectedResponseEventArgs>::.ctor(System.Object,System.IntPtr)
IL_004f: callvirt System.Void PixelCrushers.DialogueSystem.ConversationView::add_SelectedResponseHandler(System.EventHandler`1<PixelCrushers.DialogueSystem.SelectedResponseEventArgs>)
IL_0054: ldarg.0
IL_0055: ldarg.1
IL_0056: ldarg.1
IL_0057: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_005c: callvirt System.Int32 PixelCrushers.DialogueSystem.ConversationModel::GetConversationID(PixelCrushers.DialogueSystem.ConversationState)
IL_0061: stfld System.Int32 PixelCrushers.DialogueSystem.ConversationController::m_currentConversationID
IL_0066: ldarg.0
IL_0067: ldarg.1
IL_0068: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_006d: call System.Void PixelCrushers.DialogueSystem.ConversationController::SetConversationOverride(PixelCrushers.DialogueSystem.ConversationState)
IL_0072: ldarg.0
IL_0073: ldarg.1
IL_0074: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_0079: call System.Void PixelCrushers.DialogueSystem.ConversationController::GotoState(PixelCrushers.DialogueSystem.ConversationState)
IL_007e: ret
