TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnLinkedConversationStart(UnityEngine.Transform) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsPlayerQuestionDialoguePlaying()
IL_0005: brfalse IL_014d
IL_000a: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.DialogueSystemController>()
IL_000f: stloc.0
IL_0010: ldloc.0
IL_0011: callvirt System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord> PixelCrushers.DialogueSystem.DialogueSystemController::get_activeConversations()
IL_0016: ldc.i4.0
IL_0017: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord>::get_Item(System.Int32)
IL_001c: callvirt PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ActiveConversationRecord::get_ConversationModel()
IL_0021: ldloc.0
IL_0022: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueSystemController::get_CurrentConversationState()
IL_0027: callvirt System.Int32 PixelCrushers.DialogueSystem.ConversationModel::GetConversationID(PixelCrushers.DialogueSystem.ConversationState)
IL_002c: stloc.1
IL_002d: call PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueManager::get_databaseManager()
IL_0032: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_0037: ldloc.1
IL_0038: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.Int32)
IL_003d: callvirt System.String PixelCrushers.DialogueSystem.Conversation::get_Title()
IL_0042: stloc.2
IL_0043: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0048: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_004d: ldc.i4 700
IL_0052: bne.un.s IL_0074
IL_0054: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0059: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_005e: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0063: ldloc.1
IL_0064: beq.s IL_0073
IL_0066: ldloc.2
IL_0067: ldstr "system/dynamicConversation"
IL_006c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0071: brfalse.s IL_0074
IL_0073: ret
IL_0074: ldc.i4.0
IL_0075: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsPlayerQuestionDialoguePlaying(System.Boolean)
IL_007a: ldarg.0
IL_007b: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::arcListCache
IL_0080: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::get_Values()
IL_0085: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_008a: stloc.3
IL_008b: br IL_0117
IL_0090: ldloca.s V_3
IL_0092: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0097: stloc.s V_4
IL_0099: ldloc.s V_4
IL_009b: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00a0: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00a5: ldloc.1
IL_00a6: bne.un.s IL_0117
IL_00a8: ldloc.s V_4
IL_00aa: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00af: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogueDbName(System.String)
IL_00b4: ldloc.s V_4
IL_00b6: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogue(TheForestOfLove.Narrative.Dialogue)
IL_00bb: ldloc.s V_4
IL_00bd: ldfld System.String TheForestOfLove.Narrative.Dialogue::pluginDbName
IL_00c2: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialoguePluginDbName(System.String)
IL_00c7: ldloc.s V_4
IL_00c9: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetFirstPrimaryArc()
IL_00ce: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArc(TheForestOfLove.Narrative.Arc)
IL_00d3: call TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.DialogueService::get_CurrentArc()
IL_00d8: ldfld System.String TheForestOfLove.Narrative.Arc::customName
IL_00dd: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArcName(System.String)
IL_00e2: ldloc.s V_4
IL_00e4: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_00e9: call System.Void TheForestOfLove.Narrative.DialogueService::set_PrimaryActor(TheForestOfLove.Narrative.Actor)
IL_00ee: ldloc.s V_4
IL_00f0: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::initialActor
IL_00f5: call System.Void TheForestOfLove.Narrative.DialogueService::set_InitialActor(TheForestOfLove.Narrative.Actor)
IL_00fa: ldloc.s V_4
IL_00fc: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::initialActor
IL_0101: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentActor(TheForestOfLove.Narrative.Actor)
IL_0106: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onLinkedDialogueStart
IL_010b: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0110: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_0115: leave.s IL_014d
IL_0117: ldloca.s V_3
IL_0119: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_011e: brtrue IL_0090
IL_0123: leave.s IL_0133
IL_0125: ldloca.s V_3
IL_0127: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>
IL_012d: callvirt System.Void System.IDisposable::Dispose()
IL_0132: endfinally
IL_0133: ldstr "player selected an untracked question "
IL_0138: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_013d: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0142: call System.String System.String::Concat(System.String,System.String)
IL_0147: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_014c: ret
IL_014d: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::HandleDialogueLineActor(PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0006: brtrue.s IL_000f
IL_0008: ldsfld System.String System.String::Empty
IL_000d: br.s IL_001a
IL_000f: ldarg.1
IL_0010: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0015: callvirt System.String System.String::ToLower()
IL_001a: stloc.0
IL_001b: ldloc.0
IL_001c: ldstr "none"
IL_0021: callvirt System.Boolean System.String::Contains(System.String)
IL_0026: brtrue.s IL_0042
IL_0028: ldloc.0
IL_0029: ldstr "delay"
IL_002e: callvirt System.Boolean System.String::Contains(System.String)
IL_0033: brtrue.s IL_0042
IL_0035: ldloc.0
IL_0036: ldstr "continue"
IL_003b: callvirt System.Boolean System.String::Contains(System.String)
IL_0040: brfalse.s IL_0043
IL_0042: ret
IL_0043: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0048: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_004d: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0052: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_0057: stloc.1
IL_0058: ldloc.1
IL_0059: ldc.i4.0
IL_005a: bgt.s IL_0063
IL_005c: ldarg.0
IL_005d: call System.Int32 TheForestOfLove.Narrative.DialogueService::GetActorPluginIdTheSlowWay()
IL_0062: stloc.1
IL_0063: ldloc.1
IL_0064: ldc.i4.0
IL_0065: bgt.s IL_0068
IL_0067: ret
IL_0068: ldloc.1
IL_0069: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByPluginDbId(System.Int32)
IL_006e: stloc.2
IL_006f: ldloc.2
IL_0070: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentActor(TheForestOfLove.Narrative.Actor)
IL_0075: ldloc.2
IL_0076: brtrue.s IL_0092
IL_0078: ldstr "dialogue {0} could not find actor {1}"
IL_007d: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0082: ldloc.1
IL_0083: box System.Int32
IL_0088: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_008d: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0092: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginDetailed
IL_0097: ldloc.2
IL_0098: ldarg.1
IL_0099: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::Invoke(!0,!1)
IL_009e: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin
IL_00a3: ldloc.2
IL_00a4: ldarg.1
IL_00a5: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_00aa: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_00af: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::Invoke(!0,!1)
IL_00b4: ldarg.0
IL_00b5: ldarg.1
IL_00b6: call System.Void TheForestOfLove.Narrative.DialogueService::OnConversationLine_Handler(PixelCrushers.DialogueSystem.Subtitle)
IL_00bb: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsCurrentActorNarrator()
IL_00c0: brfalse.s IL_00da
IL_00c2: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginNarrator
IL_00c7: ldloc.2
IL_00c8: ldarg.1
IL_00c9: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_00ce: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_00d3: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::Invoke(!0,!1)
IL_00d8: br.s IL_0116
IL_00da: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsCurrentActorPlayer()
IL_00df: brfalse.s IL_00f9
IL_00e1: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginPlayer
IL_00e6: ldloc.2
IL_00e7: ldarg.1
IL_00e8: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_00ed: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_00f2: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::Invoke(!0,!1)
IL_00f7: br.s IL_0116
IL_00f9: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsCurrentActorNpc()
IL_00fe: brfalse.s IL_0116
IL_0100: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginNpc
IL_0105: ldloc.2
IL_0106: ldarg.1
IL_0107: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_010c: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0111: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::Invoke(!0,!1)
IL_0116: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueLine
IL_011b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0120: ret
