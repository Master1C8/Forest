METHOD System.Void ForestProbe::Bucky141Entry(System.Int32,System.String,System.String,System.Int32,System.Int32,System.String,System.Int32[]) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_masterDatabase()
IL_0006: ldc.i4 141
IL_000b: ldarg.1
IL_000c: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.DialogueDatabase::GetDialogueEntry(System.Int32,System.Int32)
IL_0011: stloc.0
IL_0012: ldloc.0
IL_0013: brfalse IL_0122
IL_0018: ldloc.0
IL_0019: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_001e: ldc.i4 141
IL_0023: bne.un IL_0122
IL_0028: ldloc.0
IL_0029: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_002e: ldarg.1
IL_002f: bne.un IL_0122
IL_0034: ldloc.0
IL_0035: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_003a: ldarg.2
IL_003b: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0040: brtrue IL_0122
IL_0045: ldloc.0
IL_0046: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_004b: ldarg.3
IL_004c: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0051: brtrue IL_0122
IL_0056: ldloc.0
IL_0057: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_005c: ldarg.s actor
IL_005e: bne.un IL_0122
IL_0063: ldloc.0
IL_0064: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ConversantID()
IL_0069: ldarg.s conversant
IL_006b: bne.un IL_0122
IL_0070: ldloc.0
IL_0071: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueEntry::isRoot
IL_0076: brtrue IL_0122
IL_007b: ldloc.0
IL_007c: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueEntry::isGroup
IL_0081: brtrue IL_0122
IL_0086: ldloc.0
IL_0087: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueEntry::delaySimStatus
IL_008c: brtrue IL_0122
IL_0091: ldloc.0
IL_0092: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::falseConditionAction
IL_0097: ldstr "Block"
IL_009c: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_00a1: brtrue.s IL_0122
IL_00a3: ldloc.0
IL_00a4: ldfld PixelCrushers.DialogueSystem.ConditionPriority PixelCrushers.DialogueSystem.DialogueEntry::conditionPriority
IL_00a9: ldc.i4.2
IL_00aa: bne.un.s IL_0122
IL_00ac: ldloc.0
IL_00ad: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::conditionsString
IL_00b2: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00b7: brfalse.s IL_0122
IL_00b9: ldloc.0
IL_00ba: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::userScript
IL_00bf: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00c4: brfalse.s IL_0122
IL_00c6: ldloc.0
IL_00c7: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_MenuText()
IL_00cc: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00d1: brfalse.s IL_0122
IL_00d3: ldloc.0
IL_00d4: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Sequence()
IL_00d9: ldarg.s sequence
IL_00db: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_00e0: brtrue.s IL_0122
IL_00e2: ldloc.0
IL_00e3: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_ResponseMenuSequence()
IL_00e8: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00ed: brfalse.s IL_0122
IL_00ef: ldloc.0
IL_00f0: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_00f5: brfalse.s IL_0104
IL_00f7: ldloc.0
IL_00f8: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_00fd: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_0102: brtrue.s IL_0122
IL_0104: ldloc.0
IL_0105: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_010a: brfalse.s IL_0122
IL_010c: ldloc.0
IL_010d: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0112: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_0117: ldarg.s destinations
IL_0119: ldlen
IL_011a: conv.i4
IL_011b: ceq
IL_011d: ldc.i4.0
IL_011e: ceq
IL_0120: br.s IL_0123
IL_0122: ldc.i4.1
IL_0123: stloc.1
IL_0124: ldloc.1
IL_0125: brfalse.s IL_013e
IL_0127: ldstr "Bucky141 exact source/actor/control differs: "
IL_012c: ldarga.s id
IL_012e: call System.String System.Int32::ToString()
IL_0133: call System.String System.String::Concat(System.String,System.String)
IL_0138: newobj System.Void System.Exception::.ctor(System.String)
IL_013d: throw
IL_013e: ldc.i4.0
IL_013f: stloc.2
IL_0140: br.s IL_01b8
IL_0142: nop
IL_0143: ldloc.0
IL_0144: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0149: ldloc.2
IL_014a: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_014f: stloc.3
IL_0150: ldloc.3
IL_0151: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::originConversationID
IL_0156: ldc.i4 141
IL_015b: bne.un.s IL_0195
IL_015d: ldloc.3
IL_015e: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::originDialogueID
IL_0163: ldarg.1
IL_0164: bne.un.s IL_0195
IL_0166: ldloc.3
IL_0167: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_016c: ldc.i4 141
IL_0171: bne.un.s IL_0195
IL_0173: ldloc.3
IL_0174: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0179: ldarg.s destinations
IL_017b: ldloc.2
IL_017c: ldelem.i4
IL_017d: bne.un.s IL_0195
IL_017f: ldloc.3
IL_0180: ldfld System.Boolean PixelCrushers.DialogueSystem.Link::isConnector
IL_0185: brtrue.s IL_0195
IL_0187: ldloc.3
IL_0188: ldfld PixelCrushers.DialogueSystem.ConditionPriority PixelCrushers.DialogueSystem.Link::priority
IL_018d: ldc.i4.2
IL_018e: ceq
IL_0190: ldc.i4.0
IL_0191: ceq
IL_0193: br.s IL_0196
IL_0195: ldc.i4.1
IL_0196: stloc.s V_4
IL_0198: ldloc.s V_4
IL_019a: brfalse.s IL_01b3
IL_019c: ldstr "Bucky141 exact source link differs: "
IL_01a1: ldarga.s id
IL_01a3: call System.String System.Int32::ToString()
IL_01a8: call System.String System.String::Concat(System.String,System.String)
IL_01ad: newobj System.Void System.Exception::.ctor(System.String)
IL_01b2: throw
IL_01b3: nop
IL_01b4: ldloc.2
IL_01b5: ldc.i4.1
IL_01b6: add
IL_01b7: stloc.2
IL_01b8: ldloc.2
IL_01b9: ldarg.s destinations
IL_01bb: ldlen
IL_01bc: conv.i4
IL_01bd: clt
IL_01bf: stloc.s V_5
IL_01c1: ldloc.s V_5
IL_01c3: brtrue IL_0142
IL_01c8: ret
