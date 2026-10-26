TYPE TheForestOfLove.Narrative.Dialogue
METHOD System.Void TheForestOfLove.Narrative.Dialogue::FireArcTriggers(TheForestOfLove.Narrative.Arc,System.Int32,System.Int32)
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_001d
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::get_Current()
IL_0015: ldarg.1
IL_0016: ldarg.2
IL_0017: ldarg.3
IL_0018: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::CheckTrigger(TheForestOfLove.Narrative.Arc,System.Int32,System.Int32)
IL_001d: ldloca.s V_0
IL_001f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::MoveNext()
IL_0024: brtrue.s IL_000e
IL_0026: leave.s IL_0036
IL_0028: ldloca.s V_0
IL_002a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>
IL_0030: callvirt System.Void System.IDisposable::Dispose()
IL_0035: endfinally
IL_0036: ret
