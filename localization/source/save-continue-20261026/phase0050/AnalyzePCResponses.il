TYPE PixelCrushers.DialogueSystem.ConversationController
METHOD System.Void PixelCrushers.DialogueSystem.ConversationController::AnalyzePCResponses(PixelCrushers.DialogueSystem.ConversationState,System.Boolean&,System.Boolean&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.ConversationView PixelCrushers.DialogueSystem.ConversationController::m_view
IL_0006: callvirt PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ConversationView::get_displaySettings()
IL_000b: callvirt System.Boolean PixelCrushers.DialogueSystem.DisplaySettings::GetAlwaysForceResponseMenu()
IL_0010: stloc.0
IL_0011: ldc.i4.0
IL_0012: stloc.1
IL_0013: ldc.i4.0
IL_0014: stloc.2
IL_0015: ldarg.1
IL_0016: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_001b: brtrue.s IL_0020
IL_001d: ldc.i4.0
IL_001e: br.s IL_0028
IL_0020: ldarg.1
IL_0021: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_0026: ldlen
IL_0027: conv.i4
IL_0028: stloc.3
IL_0029: ldc.i4.0
IL_002a: stloc.s V_4
IL_002c: br.s IL_0064
IL_002e: ldarg.1
IL_002f: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_0034: ldloc.s V_4
IL_0036: ldelem.ref
IL_0037: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_003c: callvirt System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_forceMenu()
IL_0041: brfalse.s IL_0045
IL_0043: ldc.i4.1
IL_0044: stloc.1
IL_0045: ldarg.1
IL_0046: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_004b: ldloc.s V_4
IL_004d: ldelem.ref
IL_004e: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_0053: callvirt System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_forceAuto()
IL_0058: brfalse.s IL_005e
IL_005a: ldc.i4.1
IL_005b: stloc.2
IL_005c: br.s IL_0069
IL_005e: ldloc.s V_4
IL_0060: ldc.i4.1
IL_0061: add
IL_0062: stloc.s V_4
IL_0064: ldloc.s V_4
IL_0066: ldloc.3
IL_0067: blt.s IL_002e
IL_0069: ldarg.2
IL_006a: ldarg.1
IL_006b: callvirt System.Boolean PixelCrushers.DialogueSystem.ConversationState::get_hasNPCResponse()
IL_0070: brtrue.s IL_0088
IL_0072: ldloc.2
IL_0073: brtrue.s IL_0088
IL_0075: ldloc.3
IL_0076: ldc.i4.1
IL_0077: cgt
IL_0079: ldloc.1
IL_007a: or
IL_007b: brtrue.s IL_0085
IL_007d: ldloc.3
IL_007e: ldc.i4.1
IL_007f: ceq
IL_0081: ldloc.0
IL_0082: and
IL_0083: br.s IL_0089
IL_0085: ldc.i4.1
IL_0086: br.s IL_0089
IL_0088: ldc.i4.0
IL_0089: stind.i1
IL_008a: ldarg.3
IL_008b: ldarg.1
IL_008c: callvirt System.Boolean PixelCrushers.DialogueSystem.ConversationState::get_hasNPCResponse()
IL_0091: ldc.i4.0
IL_0092: ceq
IL_0094: ldloc.2
IL_0095: and
IL_0096: brtrue.s IL_00bc
IL_0098: ldloc.3
IL_0099: ldc.i4.1
IL_009a: bne.un.s IL_00b9
IL_009c: ldloc.1
IL_009d: brtrue.s IL_00b9
IL_009f: ldloc.0
IL_00a0: brfalse.s IL_00b6
IL_00a2: ldarg.1
IL_00a3: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_00a8: ldc.i4.0
IL_00a9: ldelem.ref
IL_00aa: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_00af: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueEntry::isGroup
IL_00b4: br.s IL_00bd
IL_00b6: ldc.i4.1
IL_00b7: br.s IL_00bd
IL_00b9: ldc.i4.0
IL_00ba: br.s IL_00bd
IL_00bc: ldc.i4.1
IL_00bd: stind.i1
IL_00be: ret
