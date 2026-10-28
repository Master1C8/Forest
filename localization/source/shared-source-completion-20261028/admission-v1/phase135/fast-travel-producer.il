TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::BuildFastTravelConversation(System.Collections.Generic.List`1<System.String>,System.String) | attributes=Public, HideBySig | impl=IL
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
IL_0027: ldstr "system/fastTravel"
IL_002c: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_0031: stloc.2
IL_0032: ldloc.2
IL_0033: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetFirstDialogueEntry()
IL_0038: stloc.3
IL_0039: ldloc.2
IL_003a: ldstr "FASTTRAVELCANCEL"
IL_003f: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_0044: stloc.s V_4
IL_0046: ldloc.2
IL_0047: ldstr "FT_DYNAMIC_ROOT"
IL_004c: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_0051: stloc.s V_5
IL_0053: ldloc.s V_5
IL_0055: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_005a: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Clear()
IL_005f: ldarg.2
IL_0060: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0065: brtrue.s IL_00a9
IL_0067: ldloc.2
IL_0068: ldstr "FT_CUSTOM_GREETING"
IL_006d: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_0072: stloc.s V_6
IL_0074: ldloc.s V_6
IL_0076: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_007b: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_0080: ldc.i4.0
IL_0081: ble.s IL_00a9
IL_0083: ldloc.2
IL_0084: ldloc.s V_6
IL_0086: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_008b: ldc.i4.0
IL_008c: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0091: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0096: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_009b: stloc.s V_7
IL_009d: ldloc.s V_7
IL_009f: brfalse.s IL_00a9
IL_00a1: ldloc.s V_7
IL_00a3: ldarg.2
IL_00a4: callvirt System.Void PixelCrushers.DialogueSystem.DialogueEntry::set_DialogueText(System.String)
IL_00a9: ldarg.1
IL_00aa: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_00af: stloc.s V_8
IL_00b1: br.s IL_0128
IL_00b3: ldloca.s V_8
IL_00b5: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_00ba: stloc.s V_9
IL_00bc: ldloc.2
IL_00bd: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> PixelCrushers.DialogueSystem.Conversation::dialogueEntries
IL_00c2: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::GetEnumerator()
IL_00c7: stloc.s V_10
IL_00c9: br.s IL_010f
IL_00cb: ldloca.s V_10
IL_00cd: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>::get_Current()
IL_00d2: stloc.s V_11
IL_00d4: ldloc.s V_11
IL_00d6: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_00db: ldloc.s V_9
IL_00dd: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00e2: brfalse.s IL_010f
IL_00e4: ldloc.s V_5
IL_00e6: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00eb: ldloc.2
IL_00ec: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00f1: ldloc.s V_5
IL_00f3: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00f8: ldloc.2
IL_00f9: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00fe: ldloc.s V_11
IL_0100: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0105: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_010a: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_010f: ldloca.s V_10
IL_0111: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>::MoveNext()
IL_0116: brtrue.s IL_00cb
IL_0118: leave.s IL_0128
IL_011a: ldloca.s V_10
IL_011c: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>
IL_0122: callvirt System.Void System.IDisposable::Dispose()
IL_0127: endfinally
IL_0128: ldloca.s V_8
IL_012a: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_012f: brtrue.s IL_00b3
IL_0131: leave.s IL_0141
IL_0133: ldloca.s V_8
IL_0135: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_013b: callvirt System.Void System.IDisposable::Dispose()
IL_0140: endfinally
IL_0141: ldloc.s V_5
IL_0143: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0148: ldloc.2
IL_0149: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_014e: ldloc.s V_5
IL_0150: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0155: ldloc.2
IL_0156: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_015b: ldloc.s V_4
IL_015d: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0162: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0167: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_016c: ldloc.1
IL_016d: callvirt PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ActiveConversationRecord::get_conversationModel()
IL_0172: ldloc.3
IL_0173: callvirt System.Void PixelCrushers.DialogueSystem.ConversationModel::ForceNextStateToLinkToEntry(PixelCrushers.DialogueSystem.DialogueEntry)
IL_0178: ret
