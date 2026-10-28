TYPE TheForestOfLove.QuestSkipController
METHOD System.Void TheForestOfLove.QuestSkipController::SkipConversation(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_0006: ldc.i4.1
IL_0007: stsfld System.Boolean Globals::isDialogueSkip
IL_000c: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0011: stloc.0
IL_0012: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_0017: stloc.1
IL_0018: ldarg.2
IL_0019: brfalse.s IL_0021
IL_001b: ldarg.2
IL_001c: callvirt System.Void TheForestOfLove.Narrative.Arc::SetStatusSkipped()
IL_0021: ldarg.0
IL_0022: ldfld System.Collections.Generic.List`1<TheForestOfLove.ConversationSkipHandler> TheForestOfLove.QuestSkipController::skipHandlers
IL_0027: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.ConversationSkipHandler>::GetEnumerator()
IL_002c: stloc.2
IL_002d: br.s IL_003d
IL_002f: ldloca.s V_2
IL_0031: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ConversationSkipHandler>::get_Current()
IL_0036: ldloc.0
IL_0037: ldloc.1
IL_0038: callvirt System.Void TheForestOfLove.ConversationSkipHandler::HandleSkip(System.String,System.String)
IL_003d: ldloca.s V_2
IL_003f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ConversationSkipHandler>::MoveNext()
IL_0044: brtrue.s IL_002f
IL_0046: leave.s IL_0056
IL_0048: ldloca.s V_2
IL_004a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ConversationSkipHandler>
IL_0050: callvirt System.Void System.IDisposable::Dispose()
IL_0055: endfinally
IL_0056: ldarg.0
IL_0057: ldfld System.Collections.Generic.List`1<TheForestOfLove.ConversationSkipHandler> TheForestOfLove.QuestSkipController::skipHandlers
IL_005c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.ConversationSkipHandler>::GetEnumerator()
IL_0061: stloc.2
IL_0062: br.s IL_0071
IL_0064: ldloca.s V_2
IL_0066: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ConversationSkipHandler>::get_Current()
IL_006b: ldarg.1
IL_006c: callvirt System.Void TheForestOfLove.ConversationSkipHandler::HandleSkip(TheForestOfLove.Narrative.Dialogue)
IL_0071: ldloca.s V_2
IL_0073: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ConversationSkipHandler>::MoveNext()
IL_0078: brtrue.s IL_0064
IL_007a: leave.s IL_008a
IL_007c: ldloca.s V_2
IL_007e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ConversationSkipHandler>
IL_0084: callvirt System.Void System.IDisposable::Dispose()
IL_0089: endfinally
IL_008a: ldarg.2
IL_008b: brfalse.s IL_0094
IL_008d: ldarg.1
IL_008e: ldarg.2
IL_008f: callvirt System.Void TheForestOfLove.Narrative.Dialogue::ForceFireArcTriggers(TheForestOfLove.Narrative.Arc)
IL_0094: call System.Void TheForestOfLove.Narrative.DialogueService::StopConversation()
IL_0099: call System.Void TheForestOfLove.CustomTypewriterEffect::StopTypewriterAndClearText()
IL_009e: call System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::StopTypewriterAndClearText()
IL_00a3: ldarg.1
IL_00a4: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::completeStepIfSkippingAnyArc
IL_00a9: brfalse.s IL_00bc
IL_00ab: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.StoryManager>()
IL_00b0: ldarg.1
IL_00b1: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00b6: ldnull
IL_00b7: callvirt System.Void TheForestOfLove.Narrative.StoryManager::MarkConversationsAsPlayed(System.String,System.String)
IL_00bc: ldc.i4.0
IL_00bd: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_00c2: ldc.i4.0
IL_00c3: stsfld System.Boolean Globals::isDialogueSkip
IL_00c8: ldstr "skipped dialogue "
IL_00cd: ldloc.0
IL_00ce: call System.String System.String::Concat(System.String,System.String)
IL_00d3: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_00d8: call System.Void TheForestOfLove.Services.Persistence.SaveManager::AutosaveIfItsBeenAwhile()
IL_00dd: ret
