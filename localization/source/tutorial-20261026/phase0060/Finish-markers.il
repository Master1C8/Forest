TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredDialogueFinishTrigger(TheForestOfLove.Narrative.Dialogue,System.Collections.Generic.IEnumerable`1<PixelCrushers.DialogueSystem.DialogueEntry>) | attributes=Private, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: ldarg.2
IL_0003: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<PixelCrushers.DialogueSystem.DialogueEntry>::GetEnumerator()
IL_0008: stloc.2
IL_0009: br.s IL_003a
IL_000b: ldloc.2
IL_000c: callvirt !0 System.Collections.Generic.IEnumerator`1<PixelCrushers.DialogueSystem.DialogueEntry>::get_Current()
IL_0011: stloc.3
IL_0012: ldloc.3
IL_0013: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0018: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_001d: brtrue.s IL_003a
IL_001f: ldloc.0
IL_0020: brfalse.s IL_0038
IL_0022: ldstr "ambiguous dialogue completion trigger "
IL_0027: ldarg.1
IL_0028: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_002d: call System.String System.String::Concat(System.String,System.String)
IL_0032: newobj System.Void System.Exception::.ctor(System.String)
IL_0037: throw
IL_0038: ldloc.3
IL_0039: stloc.0
IL_003a: ldloc.2
IL_003b: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0040: brtrue.s IL_000b
IL_0042: leave.s IL_004e
IL_0044: ldloc.2
IL_0045: brfalse.s IL_004d
IL_0047: ldloc.2
IL_0048: callvirt System.Void System.IDisposable::Dispose()
IL_004d: endfinally
IL_004e: ldloc.0
IL_004f: stloc.1
IL_0050: ldarg.1
IL_0051: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0056: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_005b: stloc.s V_4
IL_005d: br.s IL_00b7
IL_005f: ldloca.s V_4
IL_0061: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0066: stloc.s V_5
IL_0068: ldloc.s V_5
IL_006a: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_006f: ldloc.1
IL_0070: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0075: brfalse.s IL_00b7
IL_0077: ldarg.1
IL_0078: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_007d: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0082: ldloc.1
IL_0083: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0088: ldarg.1
IL_0089: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFinishDialogue::.ctor(System.Int32,System.Int32,TheForestOfLove.Narrative.Dialogue)
IL_008e: stloc.s V_6
IL_0090: ldarg.1
IL_0091: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_0096: ldloc.s V_6
IL_0098: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_009d: ldloc.s V_6
IL_009f: ldloc.s V_5
IL_00a1: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_00a6: ldloc.s V_6
IL_00a8: ldarg.0
IL_00a9: ldloc.s V_5
IL_00ab: ldloc.1
IL_00ac: ldc.i4.0
IL_00ad: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_00b2: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_00b7: ldloca.s V_4
IL_00b9: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_00be: brtrue.s IL_005f
IL_00c0: leave.s IL_00d0
IL_00c2: ldloca.s V_4
IL_00c4: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_00ca: callvirt System.Void System.IDisposable::Dispose()
IL_00cf: endfinally
IL_00d0: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationFinishDialogueTrigger(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0006: ldarg.2
IL_0007: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_000c: ldc.i4.0
IL_000d: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0012: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0017: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_001c: stloc.0
IL_001d: ldarg.1
IL_001e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0023: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0028: stloc.1
IL_0029: br.s IL_007b
IL_002b: ldloca.s V_1
IL_002d: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0032: stloc.2
IL_0033: ldloc.2
IL_0034: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_0039: ldloc.0
IL_003a: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_003f: brfalse.s IL_007b
IL_0041: ldarg.1
IL_0042: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0047: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_004c: ldloc.0
IL_004d: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0052: ldarg.1
IL_0053: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFinishDialogue::.ctor(System.Int32,System.Int32,TheForestOfLove.Narrative.Dialogue)
IL_0058: stloc.3
IL_0059: ldarg.1
IL_005a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_005f: ldloc.3
IL_0060: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_0065: ldloc.3
IL_0066: ldloc.2
IL_0067: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_006c: ldloc.3
IL_006d: ldarg.0
IL_006e: ldloc.2
IL_006f: ldloc.0
IL_0070: ldc.i4.0
IL_0071: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_0076: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_007b: ldloca.s V_1
IL_007d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0082: brtrue.s IL_002b
IL_0084: leave.s IL_0094
IL_0086: ldloca.s V_1
IL_0088: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_008e: callvirt System.Void System.IDisposable::Dispose()
IL_0093: endfinally
IL_0094: ret
