TYPE PixelCrushers.DialogueSystem.ConversationController
METHOD System.Void PixelCrushers.DialogueSystem.ConversationController::OnFinishedSubtitle(System.Object,System.EventArgs) | attributes=Public, HideBySig | impl=IL
IL_0000: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0005: ldarg.0
IL_0006: call PixelCrushers.DialogueSystem.ActiveConversationRecord PixelCrushers.DialogueSystem.ConversationController::get_activeConversationRecord()
IL_000b: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_activeConversation(PixelCrushers.DialogueSystem.ActiveConversationRecord)
IL_0010: ldarg.0
IL_0011: call System.Boolean PixelCrushers.DialogueSystem.ConversationController::get_randomizeNextEntry()
IL_0016: stloc.0
IL_0017: ldarg.0
IL_0018: ldc.i4.0
IL_0019: call System.Void PixelCrushers.DialogueSystem.ConversationController::set_randomizeNextEntry(System.Boolean)
IL_001e: ldarg.0
IL_001f: ldfld PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationController::m_state
IL_0024: callvirt System.Boolean PixelCrushers.DialogueSystem.ConversationState::get_hasNPCResponse()
IL_0029: brfalse.s IL_005d
IL_002b: ldarg.0
IL_002c: ldarg.0
IL_002d: ldfld PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ConversationController::m_model
IL_0032: ldloc.0
IL_0033: brtrue.s IL_0047
IL_0035: ldarg.0
IL_0036: ldfld PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationController::m_state
IL_003b: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.ConversationState::get_firstNPCResponse()
IL_0040: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0045: br.s IL_0052
IL_0047: ldarg.0
IL_0048: ldfld PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationController::m_state
IL_004d: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.ConversationState::GetRandomNPCEntry()
IL_0052: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry)
IL_0057: call System.Void PixelCrushers.DialogueSystem.ConversationController::GotoState(PixelCrushers.DialogueSystem.ConversationState)
IL_005c: ret
IL_005d: ldarg.0
IL_005e: ldfld PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationController::m_state
IL_0063: callvirt System.Boolean PixelCrushers.DialogueSystem.ConversationState::get_hasPCResponses()
IL_0068: brfalse.s IL_00c1
IL_006a: ldarg.0
IL_006b: ldarg.0
IL_006c: ldfld PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationController::m_state
IL_0071: ldloca.s V_1
IL_0073: ldloca.s V_2
IL_0075: call System.Void PixelCrushers.DialogueSystem.ConversationController::AnalyzePCResponses(PixelCrushers.DialogueSystem.ConversationState,System.Boolean&,System.Boolean&)
IL_007a: ldloc.2
IL_007b: brfalse.s IL_009f
IL_007d: ldarg.0
IL_007e: ldarg.0
IL_007f: ldfld PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ConversationController::m_model
IL_0084: ldarg.0
IL_0085: ldfld PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationController::m_state
IL_008a: callvirt PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.ConversationState::get_pcAutoResponse()
IL_008f: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0094: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry)
IL_0099: call System.Void PixelCrushers.DialogueSystem.ConversationController::GotoState(PixelCrushers.DialogueSystem.ConversationState)
IL_009e: ret
IL_009f: ldarg.0
IL_00a0: ldfld PixelCrushers.DialogueSystem.ConversationView PixelCrushers.DialogueSystem.ConversationController::m_view
IL_00a5: ldarg.0
IL_00a6: ldfld PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationController::m_state
IL_00ab: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_00b0: ldarg.0
IL_00b1: ldfld PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationController::m_state
IL_00b6: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_00bb: callvirt System.Void PixelCrushers.DialogueSystem.ConversationView::StartResponses(PixelCrushers.DialogueSystem.Subtitle,PixelCrushers.DialogueSystem.Response[])
IL_00c0: ret
IL_00c1: ldarg.0
IL_00c2: call System.Void PixelCrushers.DialogueSystem.ConversationController::Close()
IL_00c7: ret
