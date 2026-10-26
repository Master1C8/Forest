TYPE PixelCrushers.DialogueSystem.ConversationController
METHOD System.Void PixelCrushers.DialogueSystem.ConversationController::GotoState(PixelCrushers.DialogueSystem.ConversationState) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationController::m_state
IL_0007: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_000c: ldarg.1
IL_000d: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_currentConversationState(PixelCrushers.DialogueSystem.ConversationState)
IL_0012: ldarg.1
IL_0013: brfalse IL_00c6
IL_0018: ldarg.1
IL_0019: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_001e: brfalse.s IL_0031
IL_0020: ldarg.1
IL_0021: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0026: ldarg.0
IL_0027: call PixelCrushers.DialogueSystem.ActiveConversationRecord PixelCrushers.DialogueSystem.ConversationController::get_activeConversationRecord()
IL_002c: stfld PixelCrushers.DialogueSystem.ActiveConversationRecord PixelCrushers.DialogueSystem.Subtitle::activeConversationRecord
IL_0031: ldarg.0
IL_0032: ldfld PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ConversationController::m_model
IL_0037: ldarg.1
IL_0038: callvirt System.Int32 PixelCrushers.DialogueSystem.ConversationModel::GetConversationID(PixelCrushers.DialogueSystem.ConversationState)
IL_003d: stloc.0
IL_003e: ldloc.0
IL_003f: ldarg.0
IL_0040: ldfld System.Int32 PixelCrushers.DialogueSystem.ConversationController::m_currentConversationID
IL_0045: beq.s IL_0093
IL_0047: ldarg.0
IL_0048: ldloc.0
IL_0049: stfld System.Int32 PixelCrushers.DialogueSystem.ConversationController::m_currentConversationID
IL_004e: ldarg.0
IL_004f: ldfld PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ConversationController::m_model
IL_0054: ldstr "OnLinkedConversationStart"
IL_0059: ldc.i4.1
IL_005a: callvirt System.Void PixelCrushers.DialogueSystem.ConversationModel::InformParticipants(System.String,System.Boolean)
IL_005f: ldarg.0
IL_0060: ldfld PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ConversationController::m_model
IL_0065: ldloc.0
IL_0066: callvirt System.Void PixelCrushers.DialogueSystem.ConversationModel::UpdateParticipantsOnLinkedConversation(System.Int32)
IL_006b: ldarg.0
IL_006c: ldfld PixelCrushers.DialogueSystem.ConversationView PixelCrushers.DialogueSystem.ConversationController::m_view
IL_0071: ldarg.0
IL_0072: ldfld PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ConversationController::m_model
IL_0077: callvirt UnityEngine.Sprite PixelCrushers.DialogueSystem.ConversationModel::GetPCSprite()
IL_007c: ldarg.0
IL_007d: ldfld PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ConversationController::m_model
IL_0082: callvirt System.String PixelCrushers.DialogueSystem.ConversationModel::GetPCName()
IL_0087: callvirt System.Void PixelCrushers.DialogueSystem.ConversationView::SetPCPortrait(UnityEngine.Sprite,System.String)
IL_008c: ldarg.0
IL_008d: ldarg.1
IL_008e: call System.Void PixelCrushers.DialogueSystem.ConversationController::SetConversationOverride(PixelCrushers.DialogueSystem.ConversationState)
IL_0093: ldarg.1
IL_0094: callvirt System.Boolean PixelCrushers.DialogueSystem.ConversationState::get_isGroup()
IL_0099: brfalse.s IL_00a7
IL_009b: ldarg.0
IL_009c: ldfld PixelCrushers.DialogueSystem.ConversationView PixelCrushers.DialogueSystem.ConversationController::m_view
IL_00a1: callvirt System.Void PixelCrushers.DialogueSystem.ConversationView::ShowLastNPCSubtitle()
IL_00a6: ret
IL_00a7: ldarg.0
IL_00a8: ldarg.1
IL_00a9: ldloca.s V_1
IL_00ab: ldloca.s V_2
IL_00ad: call System.Void PixelCrushers.DialogueSystem.ConversationController::AnalyzePCResponses(PixelCrushers.DialogueSystem.ConversationState,System.Boolean&,System.Boolean&)
IL_00b2: ldarg.0
IL_00b3: ldfld PixelCrushers.DialogueSystem.ConversationView PixelCrushers.DialogueSystem.ConversationController::m_view
IL_00b8: ldarg.1
IL_00b9: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_00be: ldloc.1
IL_00bf: ldloc.2
IL_00c0: callvirt System.Void PixelCrushers.DialogueSystem.ConversationView::StartSubtitle(PixelCrushers.DialogueSystem.Subtitle,System.Boolean,System.Boolean)
IL_00c5: ret
IL_00c6: ldarg.0
IL_00c7: call System.Void PixelCrushers.DialogueSystem.ConversationController::Close()
IL_00cc: ret
METHOD System.Void PixelCrushers.DialogueSystem.ConversationController::OnSelectedResponse(System.Object,PixelCrushers.DialogueSystem.SelectedResponseEventArgs) | attributes=Public, HideBySig | impl=IL
IL_0000: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_0005: ldarg.0
IL_0006: call PixelCrushers.DialogueSystem.ActiveConversationRecord PixelCrushers.DialogueSystem.ConversationController::get_activeConversationRecord()
IL_000b: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_activeConversation(PixelCrushers.DialogueSystem.ActiveConversationRecord)
IL_0010: ldarg.0
IL_0011: ldarg.0
IL_0012: ldfld PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ConversationController::m_model
IL_0017: ldarg.2
IL_0018: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.SelectedResponseEventArgs::get_DestinationEntry()
IL_001d: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry)
IL_0022: call System.Void PixelCrushers.DialogueSystem.ConversationController::GotoState(PixelCrushers.DialogueSystem.ConversationState)
IL_0027: ret
