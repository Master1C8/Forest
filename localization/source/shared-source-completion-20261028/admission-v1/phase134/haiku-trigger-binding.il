TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationFireNamedTrigger(TheForestOfLove.Narrative.DataManifest,TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
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
IL_001e: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0023: ldstr "System_DynamicFastTravel"
IL_0028: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_002d: brfalse IL_0142
IL_0032: ldarg.0
IL_0033: ldarg.2
IL_0034: ldarg.3
IL_0035: ldloc.0
IL_0036: ldnull
IL_0037: ldc.i4.1
IL_0038: call TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationFireNamedTrigger_Single(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry,PixelCrushers.DialogueSystem.DialogueEntry,TheForestOfLove.Narrative.Arc,System.Boolean)
IL_003d: stloc.1
IL_003e: ldarg.1
IL_003f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByTriggerName
IL_0044: ldloc.1
IL_0045: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_004a: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::ContainsKey(!0)
IL_004f: brtrue.s IL_006c
IL_0051: ldstr "trigger "
IL_0056: ldloc.1
IL_0057: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_005c: ldstr " is used in the plugin db but not modeled in the db. for sanity, be sure to model all triggers in the db"
IL_0061: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0066: newobj System.Void System.Exception::.ctor(System.String)
IL_006b: throw
IL_006c: ldarg.2
IL_006d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringDialogueSkip
IL_0072: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::GetEnumerator()
IL_0077: stloc.2
IL_0078: br.s IL_009a
IL_007a: ldloca.s V_2
IL_007c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::get_Current()
IL_0081: ldfld System.String TheForestOfLove.Narrative.Trigger::name
IL_0086: ldloc.1
IL_0087: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_008c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0091: brfalse.s IL_009a
IL_0093: ldloc.1
IL_0094: ldc.i4.1
IL_0095: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_skipDuringDialogueSkip(System.Boolean)
IL_009a: ldloca.s V_2
IL_009c: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::MoveNext()
IL_00a1: brtrue.s IL_007a
IL_00a3: leave.s IL_00b3
IL_00a5: ldloca.s V_2
IL_00a7: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>
IL_00ad: callvirt System.Void System.IDisposable::Dispose()
IL_00b2: endfinally
IL_00b3: ldarg.2
IL_00b4: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringChapterSelect
IL_00b9: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::GetEnumerator()
IL_00be: stloc.2
IL_00bf: br.s IL_00e1
IL_00c1: ldloca.s V_2
IL_00c3: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::get_Current()
IL_00c8: ldfld System.String TheForestOfLove.Narrative.Trigger::name
IL_00cd: ldloc.1
IL_00ce: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_00d3: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00d8: brfalse.s IL_00e1
IL_00da: ldloc.1
IL_00db: ldc.i4.1
IL_00dc: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_skipDuringChapterSelect(System.Boolean)
IL_00e1: ldloca.s V_2
IL_00e3: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::MoveNext()
IL_00e8: brtrue.s IL_00c1
IL_00ea: leave.s IL_00fa
IL_00ec: ldloca.s V_2
IL_00ee: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>
IL_00f4: callvirt System.Void System.IDisposable::Dispose()
IL_00f9: endfinally
IL_00fa: ldarg.2
IL_00fb: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringCheatCode
IL_0100: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::GetEnumerator()
IL_0105: stloc.2
IL_0106: br.s IL_0128
IL_0108: ldloca.s V_2
IL_010a: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::get_Current()
IL_010f: ldfld System.String TheForestOfLove.Narrative.Trigger::name
IL_0114: ldloc.1
IL_0115: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_011a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_011f: brfalse.s IL_0128
IL_0121: ldloc.1
IL_0122: ldc.i4.1
IL_0123: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_skipDuringCheatCode(System.Boolean)
IL_0128: ldloca.s V_2
IL_012a: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::MoveNext()
IL_012f: brtrue.s IL_0108
IL_0131: leave.s IL_0141
IL_0133: ldloca.s V_2
IL_0135: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>
IL_013b: callvirt System.Void System.IDisposable::Dispose()
IL_0140: endfinally
IL_0141: ret
IL_0142: ldarg.2
IL_0143: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0148: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_014d: stloc.3
IL_014e: br IL_027e
IL_0153: ldloca.s V_3
IL_0155: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_015a: stloc.s V_4
IL_015c: ldloc.s V_4
IL_015e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry> TheForestOfLove.Narrative.Arc::pluginDbDialogueEntries
IL_0163: ldloc.0
IL_0164: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.DialogueEntry>::Contains(!0)
IL_0169: brfalse IL_027e
IL_016e: ldarg.0
IL_016f: ldarg.2
IL_0170: ldarg.3
IL_0171: ldloc.0
IL_0172: ldloc.s V_4
IL_0174: ldc.i4.0
IL_0175: call TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationFireNamedTrigger_Single(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry,PixelCrushers.DialogueSystem.DialogueEntry,TheForestOfLove.Narrative.Arc,System.Boolean)
IL_017a: stloc.1
IL_017b: ldarg.1
IL_017c: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByTriggerName
IL_0181: ldloc.1
IL_0182: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_0187: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::ContainsKey(!0)
IL_018c: brtrue.s IL_01a9
IL_018e: ldstr "trigger "
IL_0193: ldloc.1
IL_0194: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_0199: ldstr " is used in the plugin db but not modeled in the db. for sanity, be sure to model all triggers in the db"
IL_019e: call System.String System.String::Concat(System.String,System.String,System.String)
IL_01a3: newobj System.Void System.Exception::.ctor(System.String)
IL_01a8: throw
IL_01a9: ldarg.2
IL_01aa: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringDialogueSkip
IL_01af: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::GetEnumerator()
IL_01b4: stloc.2
IL_01b5: br.s IL_01d7
IL_01b7: ldloca.s V_2
IL_01b9: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::get_Current()
IL_01be: ldfld System.String TheForestOfLove.Narrative.Trigger::name
IL_01c3: ldloc.1
IL_01c4: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_01c9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01ce: brfalse.s IL_01d7
IL_01d0: ldloc.1
IL_01d1: ldc.i4.1
IL_01d2: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_skipDuringDialogueSkip(System.Boolean)
IL_01d7: ldloca.s V_2
IL_01d9: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::MoveNext()
IL_01de: brtrue.s IL_01b7
IL_01e0: leave.s IL_01f0
IL_01e2: ldloca.s V_2
IL_01e4: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>
IL_01ea: callvirt System.Void System.IDisposable::Dispose()
IL_01ef: endfinally
IL_01f0: ldarg.2
IL_01f1: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringChapterSelect
IL_01f6: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::GetEnumerator()
IL_01fb: stloc.2
IL_01fc: br.s IL_021e
IL_01fe: ldloca.s V_2
IL_0200: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::get_Current()
IL_0205: ldfld System.String TheForestOfLove.Narrative.Trigger::name
IL_020a: ldloc.1
IL_020b: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_0210: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0215: brfalse.s IL_021e
IL_0217: ldloc.1
IL_0218: ldc.i4.1
IL_0219: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_skipDuringChapterSelect(System.Boolean)
IL_021e: ldloca.s V_2
IL_0220: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::MoveNext()
IL_0225: brtrue.s IL_01fe
IL_0227: leave.s IL_0237
IL_0229: ldloca.s V_2
IL_022b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>
IL_0231: callvirt System.Void System.IDisposable::Dispose()
IL_0236: endfinally
IL_0237: ldarg.2
IL_0238: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringCheatCode
IL_023d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::GetEnumerator()
IL_0242: stloc.2
IL_0243: br.s IL_0265
IL_0245: ldloca.s V_2
IL_0247: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::get_Current()
IL_024c: ldfld System.String TheForestOfLove.Narrative.Trigger::name
IL_0251: ldloc.1
IL_0252: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_0257: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_025c: brfalse.s IL_0265
IL_025e: ldloc.1
IL_025f: ldc.i4.1
IL_0260: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::set_skipDuringCheatCode(System.Boolean)
IL_0265: ldloca.s V_2
IL_0267: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::MoveNext()
IL_026c: brtrue.s IL_0245
IL_026e: leave.s IL_027e
IL_0270: ldloca.s V_2
IL_0272: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>
IL_0278: callvirt System.Void System.IDisposable::Dispose()
IL_027d: endfinally
IL_027e: ldloca.s V_3
IL_0280: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0285: brtrue IL_0153
IL_028a: leave.s IL_029a
IL_028c: ldloca.s V_3
IL_028e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0294: callvirt System.Void System.IDisposable::Dispose()
IL_0299: endfinally
IL_029a: ret
