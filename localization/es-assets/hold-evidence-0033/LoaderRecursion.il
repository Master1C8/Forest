TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::RecursivelyPopulateDialogueEntries(PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry)
IL_0000: ldarg.2
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_0006: ldarg.3
IL_0007: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: ldarg.2
IL_0010: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_0015: ldarg.3
IL_0016: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Add(!0)
IL_001b: ldarg.3
IL_001c: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0021: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::GetEnumerator()
IL_0026: stloc.0
IL_0027: br.s IL_0050
IL_0029: ldloca.s V_0
IL_002b: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::get_Current()
IL_0030: stloc.1
IL_0031: ldloc.1
IL_0032: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_0037: ldarg.3
IL_0038: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_003d: bne.un.s IL_0050
IL_003f: ldarg.1
IL_0040: ldloc.1
IL_0041: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.DialogueDatabase::GetDialogueEntry(PixelCrushers.DialogueSystem.Link)
IL_0046: stloc.2
IL_0047: ldarg.0
IL_0048: ldarg.1
IL_0049: ldarg.2
IL_004a: ldloc.2
IL_004b: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::RecursivelyPopulateDialogueEntries(PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry)
IL_0050: ldloca.s V_0
IL_0052: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::MoveNext()
IL_0057: brtrue.s IL_0029
IL_0059: leave.s IL_0069
IL_005b: ldloca.s V_0
IL_005d: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>
IL_0063: callvirt System.Void System.IDisposable::Dispose()
IL_0068: endfinally
IL_0069: ret
