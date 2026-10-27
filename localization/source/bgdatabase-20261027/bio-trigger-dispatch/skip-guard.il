TYPE TheForestOfLove.QuestSkipController
METHOD System.Boolean TheForestOfLove.QuestSkipController::CanSkip(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.ConversationSkipHandler> TheForestOfLove.QuestSkipController::skipHandlers
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.ConversationSkipHandler>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_005b
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ConversationSkipHandler>::get_Current()
IL_0015: stloc.1
IL_0016: ldarg.1
IL_0017: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_001c: brfalse.s IL_0030
IL_001e: ldloc.1
IL_001f: ldarg.1
IL_0020: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0025: callvirt System.Boolean TheForestOfLove.ConversationSkipHandler::IsSkipAllowed(TheForestOfLove.Narrative.Quest)
IL_002a: brtrue.s IL_0030
IL_002c: ldc.i4.0
IL_002d: stloc.2
IL_002e: leave.s IL_0076
IL_0030: ldloc.1
IL_0031: ldarg.1
IL_0032: callvirt System.Boolean TheForestOfLove.ConversationSkipHandler::IsSkipAllowed(TheForestOfLove.Narrative.Dialogue)
IL_0037: brtrue.s IL_003d
IL_0039: ldc.i4.0
IL_003a: stloc.2
IL_003b: leave.s IL_0076
IL_003d: ldloc.1
IL_003e: ldarg.1
IL_003f: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0044: ldarg.2
IL_0045: brtrue.s IL_004a
IL_0047: ldnull
IL_0048: br.s IL_0050
IL_004a: ldarg.2
IL_004b: ldfld System.String TheForestOfLove.Narrative.Arc::customName
IL_0050: callvirt System.Boolean TheForestOfLove.ConversationSkipHandler::IsSkipAllowed(System.String,System.String)
IL_0055: brtrue.s IL_005b
IL_0057: ldc.i4.0
IL_0058: stloc.2
IL_0059: leave.s IL_0076
IL_005b: ldloca.s V_0
IL_005d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ConversationSkipHandler>::MoveNext()
IL_0062: brtrue.s IL_000e
IL_0064: leave.s IL_0074
IL_0066: ldloca.s V_0
IL_0068: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ConversationSkipHandler>
IL_006e: callvirt System.Void System.IDisposable::Dispose()
IL_0073: endfinally
IL_0074: ldc.i4.1
IL_0075: ret
IL_0076: ldloc.2
IL_0077: ret
