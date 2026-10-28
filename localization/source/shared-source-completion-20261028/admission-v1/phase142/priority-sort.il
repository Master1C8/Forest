TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers(TheForestOfLove.Narrative.DataManifest) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialogues
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_003e
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0015: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_001a: ldsfld System.Comparison`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__52_0
IL_001f: dup
IL_0020: brtrue.s IL_0039
IL_0022: pop
IL_0023: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_0028: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<PrioritizeArcTriggers>b__52_0(TheForestOfLove.Narrative.ArcTriggers.ArcTrigger,TheForestOfLove.Narrative.ArcTriggers.ArcTrigger)
IL_002e: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::.ctor(System.Object,System.IntPtr)
IL_0033: dup
IL_0034: stsfld System.Comparison`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__52_0
IL_0039: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::Sort(System.Comparison`1<!0>)
IL_003e: ldloca.s V_0
IL_0040: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0045: brtrue.s IL_000e
IL_0047: leave.s IL_0057
IL_0049: ldloca.s V_0
IL_004b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0051: callvirt System.Void System.IDisposable::Dispose()
IL_0056: endfinally
IL_0057: ret
