TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationTriggerAddItemToInventory(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
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
IL_0029: br IL_00f0
IL_002e: ldloca.s V_1
IL_0030: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0035: stloc.2
IL_0036: ldloc.2
IL_0037: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0042: brfalse IL_00f0
IL_0047: ldarg.2
IL_0048: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_004d: ldarg.2
IL_004e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0053: ldstr "("
IL_0058: callvirt System.Int32 System.String::IndexOf(System.String)
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: ldarg.2
IL_0060: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0065: callvirt System.Int32 System.String::get_Length()
IL_006a: ldarg.2
IL_006b: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0070: ldstr "("
IL_0075: callvirt System.Int32 System.String::IndexOf(System.String)
IL_007a: sub
IL_007b: ldc.i4.2
IL_007c: sub
IL_007d: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0082: stloc.3
IL_0083: ldarg.0
IL_0084: ldloc.3
IL_0085: call System.String TheForestOfLove.Narrative.DialogueSystemLoader::ConvertToPascalCase(System.String)
IL_008a: stloc.3
IL_008b: ldtoken TheForestOfLove.Inventory.InventoryItemType
IL_0090: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0095: ldloc.3
IL_0096: call System.Object System.Enum::Parse(System.Type,System.String)
IL_009b: unbox.any TheForestOfLove.Inventory.InventoryItemType
IL_00a0: stloc.s V_4
IL_00a2: ldloc.s V_4
IL_00a4: brtrue.s IL_00b1
IL_00a6: ldstr "unrecognized item type!"
IL_00ab: newobj System.Void System.Exception::.ctor(System.String)
IL_00b0: throw
IL_00b1: ldarg.1
IL_00b2: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00b7: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00bc: ldloc.0
IL_00bd: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00c2: ldloc.s V_4
IL_00c4: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerAddItemToInventory::.ctor(System.Int32,System.Int32,TheForestOfLove.Inventory.InventoryItemType)
IL_00c9: stloc.s V_5
IL_00cb: ldarg.1
IL_00cc: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_00d1: ldloc.s V_5
IL_00d3: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_00d8: ldloc.s V_5
IL_00da: ldloc.2
IL_00db: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_00e0: ldloc.s V_5
IL_00e2: ldarg.0
IL_00e3: ldloc.2
IL_00e4: ldloc.0
IL_00e5: ldc.i4.0
IL_00e6: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_00eb: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_00f0: ldloca.s V_1
IL_00f2: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_00f7: brtrue IL_002e
IL_00fc: leave.s IL_010c
IL_00fe: ldloca.s V_1
IL_0100: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0106: callvirt System.Void System.IDisposable::Dispose()
IL_010b: endfinally
IL_010c: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationTriggerRemoveItemFromInventory(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean) | attributes=Private, HideBySig | impl=IL
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
IL_0029: br IL_00f1
IL_002e: ldloca.s V_1
IL_0030: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0035: stloc.2
IL_0036: ldloc.2
IL_0037: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0042: brfalse IL_00f1
IL_0047: ldarg.2
IL_0048: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_004d: ldarg.2
IL_004e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0053: ldstr "("
IL_0058: callvirt System.Int32 System.String::IndexOf(System.String)
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: ldarg.2
IL_0060: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0065: callvirt System.Int32 System.String::get_Length()
IL_006a: ldarg.2
IL_006b: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0070: ldstr "("
IL_0075: callvirt System.Int32 System.String::IndexOf(System.String)
IL_007a: sub
IL_007b: ldc.i4.2
IL_007c: sub
IL_007d: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0082: stloc.3
IL_0083: ldarg.0
IL_0084: ldloc.3
IL_0085: call System.String TheForestOfLove.Narrative.DialogueSystemLoader::ConvertToPascalCase(System.String)
IL_008a: stloc.3
IL_008b: ldtoken TheForestOfLove.Inventory.InventoryItemType
IL_0090: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0095: ldloc.3
IL_0096: call System.Object System.Enum::Parse(System.Type,System.String)
IL_009b: unbox.any TheForestOfLove.Inventory.InventoryItemType
IL_00a0: stloc.s V_4
IL_00a2: ldloc.s V_4
IL_00a4: brtrue.s IL_00b1
IL_00a6: ldstr "unrecognized item type!"
IL_00ab: newobj System.Void System.Exception::.ctor(System.String)
IL_00b0: throw
IL_00b1: ldarg.1
IL_00b2: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00b7: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00bc: ldloc.0
IL_00bd: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00c2: ldloc.s V_4
IL_00c4: ldarg.3
IL_00c5: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerRemoveItemFromInventory::.ctor(System.Int32,System.Int32,TheForestOfLove.Inventory.InventoryItemType,System.Boolean)
IL_00ca: stloc.s V_5
IL_00cc: ldarg.1
IL_00cd: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_00d2: ldloc.s V_5
IL_00d4: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_00d9: ldloc.s V_5
IL_00db: ldloc.2
IL_00dc: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_00e1: ldloc.s V_5
IL_00e3: ldarg.0
IL_00e4: ldloc.2
IL_00e5: ldloc.0
IL_00e6: ldc.i4.0
IL_00e7: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_00ec: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_00f1: ldloca.s V_1
IL_00f3: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_00f8: brtrue IL_002e
IL_00fd: leave.s IL_010d
IL_00ff: ldloca.s V_1
IL_0101: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0107: callvirt System.Void System.IDisposable::Dispose()
IL_010c: endfinally
IL_010d: ret
