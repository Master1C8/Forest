TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldarg.1
IL_0002: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0007: bne.un.s IL_000b
IL_0009: ldarg.3
IL_000a: ret
IL_000b: ldnull
IL_000c: stloc.0
IL_000d: ldarg.1
IL_000e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_0013: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::GetEnumerator()
IL_0018: stloc.1
IL_0019: br.s IL_007f
IL_001b: ldloca.s V_1
IL_001d: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>::get_Current()
IL_0022: stloc.2
IL_0023: ldloc.2
IL_0024: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0029: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::GetEnumerator()
IL_002e: stloc.3
IL_002f: br.s IL_0061
IL_0031: ldloca.s V_3
IL_0033: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::get_Current()
IL_0038: stloc.s V_4
IL_003a: ldloc.s V_4
IL_003c: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_0041: ldarg.1
IL_0042: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0047: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_004c: bne.un.s IL_0061
IL_004e: ldloc.s V_4
IL_0050: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0055: ldarg.2
IL_0056: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_005b: bne.un.s IL_0061
IL_005d: ldloc.2
IL_005e: stloc.0
IL_005f: leave.s IL_007a
IL_0061: ldloca.s V_3
IL_0063: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::MoveNext()
IL_0068: brtrue.s IL_0031
IL_006a: leave.s IL_007a
IL_006c: ldloca.s V_3
IL_006e: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>
IL_0074: callvirt System.Void System.IDisposable::Dispose()
IL_0079: endfinally
IL_007a: ldloc.0
IL_007b: brfalse.s IL_007f
IL_007d: leave.s IL_0098
IL_007f: ldloca.s V_1
IL_0081: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>::MoveNext()
IL_0086: brtrue.s IL_001b
IL_0088: leave.s IL_0098
IL_008a: ldloca.s V_1
IL_008c: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.DialogueEntry>
IL_0092: callvirt System.Void System.IDisposable::Dispose()
IL_0097: endfinally
IL_0098: ldloc.0
IL_0099: brfalse.s IL_00a7
IL_009b: ldarg.0
IL_009c: ldarg.1
IL_009d: ldloc.0
IL_009e: ldarg.3
IL_009f: ldc.i4.1
IL_00a0: add
IL_00a1: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_00a6: ret
IL_00a7: ldstr "error finding parent dialogue entry in "
IL_00ac: ldarg.1
IL_00ad: ldfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.Arc::dialogue
IL_00b2: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00b7: ldstr "."
IL_00bc: ldarg.1
IL_00bd: ldfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_00c2: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00c7: newobj System.Void System.Exception::.ctor(System.String)
IL_00cc: throw
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers(TheForestOfLove.Narrative.DataManifest) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialogues
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_003e
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0015: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_001a: ldsfld System.Comparison`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__52_0
IL_001f: dup
IL_0020: brtrue.s IL_0039
IL_0022: pop
IL_0023: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_0028: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<PrioritizeArcTriggers>b__52_0(TheForestOfLove.Narrative.ArcTriggers.ArcTrigger,TheForestOfLove.Narrative.ArcTriggers.ArcTrigger)
IL_002e: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::.ctor(System.Object,System.IntPtr)
IL_0033: dup
IL_0034: stsfld System.Comparison`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__52_0
IL_0039: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Sort(System.Comparison`1<!0>)
IL_003e: ldloca.s V_0
IL_0040: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0045: brtrue.s IL_000e
IL_0047: leave.s IL_0057
IL_0049: ldloca.s V_0
IL_004b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0051: callvirt System.Void System.IDisposable::Dispose()
IL_0056: endfinally
IL_0057: ret
