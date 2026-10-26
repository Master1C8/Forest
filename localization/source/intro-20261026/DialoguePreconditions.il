TYPE TheForestOfLove.Narrative.Dialogue
METHOD System.Boolean TheForestOfLove.Narrative.Dialogue::get_isPreconditionSatisfied()
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.Dialogue::CheckIfPreconditionSatisfied()
IL_0006: ret
METHOD System.Boolean TheForestOfLove.Narrative.Dialogue::CheckIfPreconditionSatisfied()
IL_0000: call System.Boolean Globals::get_DisablePreconditions()
IL_0005: brfalse.s IL_0009
IL_0007: ldc.i4.1
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_000f: ldc.i4 300
IL_0014: bne.un.s IL_0018
IL_0016: ldc.i4.0
IL_0017: ret
IL_0018: ldarg.0
IL_0019: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition> TheForestOfLove.Narrative.Dialogue::preconditions
IL_001e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::GetEnumerator()
IL_0023: stloc.0
IL_0024: br.s IL_0038
IL_0026: ldloca.s V_0
IL_0028: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::get_Current()
IL_002d: callvirt System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition::get_IsSatisfied()
IL_0032: brtrue.s IL_0038
IL_0034: ldc.i4.0
IL_0035: stloc.1
IL_0036: leave.s IL_0053
IL_0038: ldloca.s V_0
IL_003a: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::MoveNext()
IL_003f: brtrue.s IL_0026
IL_0041: leave.s IL_0051
IL_0043: ldloca.s V_0
IL_0045: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>
IL_004b: callvirt System.Void System.IDisposable::Dispose()
IL_0050: endfinally
IL_0051: ldc.i4.1
IL_0052: ret
IL_0053: ldloc.1
IL_0054: ret
