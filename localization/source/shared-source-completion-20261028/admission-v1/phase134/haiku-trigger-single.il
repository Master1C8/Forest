TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger TheForestOfLove.Narrative.DialogueSystemLoader::AddConversationFireNamedTrigger_Single(TheForestOfLove.Narrative.Dialogue,PixelCrushers.DialogueSystem.DialogueEntry,PixelCrushers.DialogueSystem.DialogueEntry,TheForestOfLove.Narrative.Arc,System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0006: ldarg.2
IL_0007: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_000c: ldstr "("
IL_0011: callvirt System.Int32 System.String::IndexOf(System.String)
IL_0016: ldc.i4.1
IL_0017: add
IL_0018: ldarg.2
IL_0019: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_001e: callvirt System.Int32 System.String::get_Length()
IL_0023: ldarg.2
IL_0024: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0029: ldstr "("
IL_002e: callvirt System.Int32 System.String::IndexOf(System.String)
IL_0033: sub
IL_0034: ldc.i4.2
IL_0035: sub
IL_0036: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_003b: stloc.0
IL_003c: ldloc.0
IL_003d: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0042: brfalse.s IL_004f
IL_0044: ldstr "unrecognized trigger name!"
IL_0049: newobj System.Void System.Exception::.ctor(System.String)
IL_004e: throw
IL_004f: ldarg.1
IL_0050: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0055: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_005a: ldarg.3
IL_005b: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0060: ldloc.0
IL_0061: newobj System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::.ctor(System.Int32,System.Int32,System.String)
IL_0066: stloc.1
IL_0067: ldarg.1
IL_0068: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_006d: ldloc.1
IL_006e: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Add(!0)
IL_0073: ldloc.1
IL_0074: ldarg.s arc
IL_0076: stfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_007b: ldloc.1
IL_007c: ldarg.s allowNullArc
IL_007e: stfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::allowNullArc
IL_0083: ldarg.1
IL_0084: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0089: ldstr "System_DynamicFastTravel"
IL_008e: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0093: brfalse.s IL_00a5
IL_0095: ldloc.1
IL_0096: ldarg.0
IL_0097: ldarg.s arc
IL_0099: ldarg.3
IL_009a: ldc.i4.0
IL_009b: call System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers_CountParentNodesRecursive(TheForestOfLove.Narrative.Arc,PixelCrushers.DialogueSystem.DialogueEntry,System.Int32)
IL_00a0: stfld System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::numberOfDialogueEntriesInArcBeforeTargetNode
IL_00a5: ldloc.1
IL_00a6: ret
