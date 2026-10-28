TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues_ExtractPrecedingDialogues(TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues::negateCondition
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.1
IL_000a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPrecedingDialogues::dialogues
IL_000f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0014: stloc.0
IL_0015: br.s IL_002f
IL_0017: ldloca.s V_0
IL_0019: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_001e: stloc.1
IL_001f: ldarg.2
IL_0020: ldloc.1
IL_0021: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Contains(!0)
IL_0026: brtrue.s IL_002f
IL_0028: ldarg.2
IL_0029: ldloc.1
IL_002a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_002f: ldloca.s V_0
IL_0031: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0036: brtrue.s IL_0017
IL_0038: leave.s IL_0048
IL_003a: ldloca.s V_0
IL_003c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0042: callvirt System.Void System.IDisposable::Dispose()
IL_0047: endfinally
IL_0048: ret
