TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationTriggerUnlockBioFragment(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0006: ldarg.3
IL_0007: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_000c: ldc.i4.0
IL_000d: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0012: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_0017: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_001c: stloc.0
IL_001d: ldarg.2
IL_001e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0023: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0028: stloc.1
IL_0029: br IL_01be
IL_002e: ldloca.s V_1
IL_0030: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0035: stloc.2
IL_0036: ldloc.2
IL_0037: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_003c: ldloc.0
IL_003d: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0042: brfalse IL_01be
IL_0047: ldarg.3
IL_0048: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_004d: ldarg.3
IL_004e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0053: ldstr "("
IL_0058: callvirt System.Int32 System.String::IndexOf(System.String)
IL_005d: ldc.i4.1
IL_005e: add
IL_005f: ldarg.3
IL_0060: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0065: callvirt System.Int32 System.String::get_Length()
IL_006a: ldarg.3
IL_006b: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0070: ldstr "("
IL_0075: callvirt System.Int32 System.String::IndexOf(System.String)
IL_007a: sub
IL_007b: ldc.i4.2
IL_007c: sub
IL_007d: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0082: ldc.i4.1
IL_0083: newarr System.Char
IL_0088: dup
IL_0089: ldc.i4.0
IL_008a: ldc.i4.s 44
IL_008c: stelem.i2
IL_008d: callvirt System.String[] System.String::Split(System.Char[])
IL_0092: stloc.3
IL_0093: ldloc.3
IL_0094: ldlen
IL_0095: conv.i4
IL_0096: ldc.i4.2
IL_0097: bne.un.s IL_00af
IL_0099: ldloc.3
IL_009a: ldc.i4.0
IL_009b: ldelem.ref
IL_009c: callvirt System.String System.String::Trim()
IL_00a1: stloc.s V_4
IL_00a3: ldloc.3
IL_00a4: ldc.i4.1
IL_00a5: ldelem.ref
IL_00a6: callvirt System.String System.String::Trim()
IL_00ab: stloc.s V_5
IL_00ad: br.s IL_00c6
IL_00af: ldarg.2
IL_00b0: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_00b5: ldfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_00ba: stloc.s V_4
IL_00bc: ldloc.3
IL_00bd: ldc.i4.0
IL_00be: ldelem.ref
IL_00bf: callvirt System.String System.String::Trim()
IL_00c4: stloc.s V_5
IL_00c6: ldloc.s V_4
IL_00c8: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_00cd: brfalse.s IL_00da
IL_00cf: ldstr "unrecognized bio fragment actor name!"
IL_00d4: newobj System.Void System.Exception::.ctor(System.String)
IL_00d9: throw
IL_00da: ldloc.s V_5
IL_00dc: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_00e1: brfalse.s IL_00ee
IL_00e3: ldstr "unrecognized bio fragment key!"
IL_00e8: newobj System.Void System.Exception::.ctor(System.String)
IL_00ed: throw
IL_00ee: ldarg.1
IL_00ef: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_00f4: ldloc.s V_4
IL_00f6: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::ContainsKey(!0)
IL_00fb: brtrue.s IL_011a
IL_00fd: ldstr "unrecognized actor! "
IL_0102: ldloc.s V_4
IL_0104: ldstr " "
IL_0109: ldarg.2
IL_010a: ldfld System.String TheForestOfLove.Narrative.Dialogue::pluginDbName
IL_010f: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0114: newobj System.Void System.Exception::.ctor(System.String)
IL_0119: throw
IL_011a: ldarg.1
IL_011b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_0120: ldloc.s V_4
IL_0122: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_0127: stloc.s V_6
IL_0129: ldloc.s V_5
IL_012b: ldstr "note_"
IL_0130: ldsfld System.String System.String::Empty
IL_0135: callvirt System.String System.String::Replace(System.String,System.String)
IL_013a: ldstr "kink_"
IL_013f: ldsfld System.String System.String::Empty
IL_0144: callvirt System.String System.String::Replace(System.String,System.String)
IL_0149: stloc.s V_5
IL_014b: ldarg.2
IL_014c: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0151: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0156: ldloc.0
IL_0157: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_015c: ldloc.s V_6
IL_015e: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0163: ldloc.s V_5
IL_0165: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerUnlockBioFragment::.ctor(System.Int32,System.Int32,System.String,System.String)
IL_016a: stloc.s V_7
IL_016c: ldarg.2
IL_016d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_0172: ldloc.s V_7
IL_0174: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_0179: ldloc.s V_7
IL_017b: ldloc.2
IL_017c: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_0181: ldloc.s V_7
IL_0183: ldarg.0
IL_0184: ldloc.2
IL_0185: ldloc.0
IL_0186: ldc.i4.0
IL_0187: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_018c: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_0191: ldarg.1
IL_0192: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByPluginDbTriggerName
IL_0197: ldloc.s V_5
IL_0199: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::ContainsKey(!0)
IL_019e: brfalse.s IL_01be
IL_01a0: ldarg.1
IL_01a1: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByPluginDbTriggerName
IL_01a6: ldloc.s V_5
IL_01a8: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_01ad: ldfld System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Narrative.BioKeyword::unlockedByDialogueDbNames
IL_01b2: ldarg.2
IL_01b3: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_01b8: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_01bd: pop
IL_01be: ldloca.s V_1
IL_01c0: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_01c5: brtrue IL_002e
IL_01ca: leave.s IL_01da
IL_01cc: ldloca.s V_1
IL_01ce: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_01d4: callvirt System.Void System.IDisposable::Dispose()
IL_01d9: endfinally
IL_01da: ret
