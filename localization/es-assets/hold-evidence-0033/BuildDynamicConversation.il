TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::BuildDynamicConversation(System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>,System.Boolean,System.String,System.Boolean)
IL_0000: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.DialogueSystemController>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: callvirt System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::get_IsConversationActive()
IL_000c: brtrue.s IL_000f
IL_000e: ret
IL_000f: ldloc.0
IL_0010: callvirt System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord> PixelCrushers.DialogueSystem.DialogueSystemController::get_activeConversations()
IL_0015: ldc.i4.0
IL_0016: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord>::get_Item(System.Int32)
IL_001b: stloc.1
IL_001c: ldloc.0
IL_001d: callvirt PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::get_databaseManager()
IL_0022: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_0027: stloc.2
IL_0028: ldloc.2
IL_0029: ldstr "system/dynamicConversation"
IL_002e: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_0033: stloc.3
IL_0034: ldloc.3
IL_0035: ldstr "PASSTHROUGH"
IL_003a: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_003f: stloc.s V_4
IL_0041: ldloc.3
IL_0042: ldstr "DYNAMICROOT"
IL_0047: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_004c: stloc.s V_5
IL_004e: ldloc.3
IL_004f: ldstr "DYNAMICQUESTIONS"
IL_0054: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_0059: stloc.s V_6
IL_005b: ldloc.3
IL_005c: ldstr "GENERICFAREWELL"
IL_0061: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_0066: stloc.s V_7
IL_0068: ldloc.s V_6
IL_006a: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_006f: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Clear()
IL_0074: ldloc.s V_5
IL_0076: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_007b: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Clear()
IL_0080: ldarg.2
IL_0081: brfalse IL_016c
IL_0086: ldarg.3
IL_0087: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_008c: stloc.s V_8
IL_008e: ldloc.2
IL_008f: ldstr "system/dynamicQuestions/{0}"
IL_0094: ldloc.s V_8
IL_0096: ldfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_009b: call System.String System.String::Format(System.String,System.Object)
IL_00a0: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_00a5: stloc.s V_9
IL_00a7: ldloc.s V_9
IL_00a9: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetFirstDialogueEntry()
IL_00ae: stloc.s V_10
IL_00b0: ldloc.s V_5
IL_00b2: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00b7: ldloc.3
IL_00b8: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00bd: ldloc.s V_5
IL_00bf: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00c4: ldloc.s V_9
IL_00c6: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00cb: ldloc.s V_10
IL_00cd: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00d2: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_00d7: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_00dc: ldarg.1
IL_00dd: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_00e2: stloc.s V_11
IL_00e4: br.s IL_0125
IL_00e6: ldloc.s V_11
IL_00e8: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Arc>::get_Current()
IL_00ed: stloc.s V_12
IL_00ef: ldloc.s V_6
IL_00f1: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00f6: ldloc.3
IL_00f7: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00fc: ldloc.s V_6
IL_00fe: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0103: ldloc.s V_12
IL_0105: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_010a: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_010f: ldloc.s V_12
IL_0111: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0116: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_011b: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0120: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_0125: ldloc.s V_11
IL_0127: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_012c: brtrue.s IL_00e6
IL_012e: leave.s IL_013c
IL_0130: ldloc.s V_11
IL_0132: brfalse.s IL_013b
IL_0134: ldloc.s V_11
IL_0136: callvirt System.Void System.IDisposable::Dispose()
IL_013b: endfinally
IL_013c: ldloc.s V_6
IL_013e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0143: ldloc.3
IL_0144: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0149: ldloc.s V_6
IL_014b: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0150: ldloc.3
IL_0151: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0156: ldloc.s V_7
IL_0158: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_015d: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0162: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_0167: br IL_0290
IL_016c: ldarg.1
IL_016d: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0172: stloc.s V_11
IL_0174: br IL_0276
IL_0179: ldloc.s V_11
IL_017b: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0180: stloc.s V_13
IL_0182: ldloc.s V_13
IL_0184: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0189: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_018e: stloc.s V_14
IL_0190: ldarg.s skipPlayerQuestion
IL_0192: brfalse IL_024a
IL_0197: ldloc.2
IL_0198: ldloc.s V_13
IL_019a: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_019f: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_01a4: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.Int32)
IL_01a9: stloc.s V_15
IL_01ab: ldloc.s V_15
IL_01ad: ldloc.s V_13
IL_01af: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01b4: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_01b9: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_01be: stloc.s V_16
IL_01c0: ldloc.s V_13
IL_01c2: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_01c7: brfalse.s IL_01d2
IL_01c9: ldloc.s V_13
IL_01cb: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_01d0: stloc.s V_16
IL_01d2: ldloc.s V_13
IL_01d4: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01d9: ldloc.s V_13
IL_01db: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_01e0: beq.s IL_020c
IL_01e2: ldarg.0
IL_01e3: ldloc.s V_13
IL_01e5: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01ea: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_01ef: ldloc.s V_13
IL_01f1: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01f6: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_01fb: ldloc.s V_13
IL_01fd: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0202: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_subtitleText()
IL_0207: call System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineEnd(System.Int32,System.Int32,System.String)
IL_020c: ldloc.2
IL_020d: ldloc.s V_16
IL_020f: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_0214: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_0219: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_021e: ldstr "player"
IL_0223: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0228: brfalse.s IL_024a
IL_022a: ldloc.s V_15
IL_022c: ldloc.s V_16
IL_022e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0233: ldc.i4.0
IL_0234: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0239: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_023e: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_0243: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0248: stloc.s V_14
IL_024a: ldloc.s V_5
IL_024c: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0251: ldloc.3
IL_0252: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0257: ldloc.s V_5
IL_0259: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_025e: ldloc.s V_13
IL_0260: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0265: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_026a: ldloc.s V_14
IL_026c: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0271: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_0276: ldloc.s V_11
IL_0278: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_027d: brtrue IL_0179
IL_0282: leave.s IL_0290
IL_0284: ldloc.s V_11
IL_0286: brfalse.s IL_028f
IL_0288: ldloc.s V_11
IL_028a: callvirt System.Void System.IDisposable::Dispose()
IL_028f: endfinally
IL_0290: ldloc.1
IL_0291: callvirt PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ActiveConversationRecord::get_conversationModel()
IL_0296: ldloc.s V_4
IL_0298: callvirt System.Void PixelCrushers.DialogueSystem.ConversationModel::ForceNextStateToLinkToEntry(PixelCrushers.DialogueSystem.DialogueEntry)
IL_029d: ret
