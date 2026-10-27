TYPE TheForestOfLove.Narrative.Dialogue
METHOD System.Void TheForestOfLove.Narrative.Dialogue::FireArcTriggers(TheForestOfLove.Narrative.Arc,System.Int32,System.Int32) | attributes=Public, HideBySig | impl=IL
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
METHOD System.Void TheForestOfLove.Narrative.Dialogue::ForceFireArcTriggers(TheForestOfLove.Narrative.Arc) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_0062
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::get_Current()
IL_0015: stloc.1
IL_0016: ldloc.1
IL_0017: callvirt System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_skipDuringDialogueSkip()
IL_001c: brfalse.s IL_0025
IL_001e: ldsfld System.Boolean Globals::isDialogueSkip
IL_0023: brtrue.s IL_0062
IL_0025: ldloc.1
IL_0026: callvirt System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_skipDuringChapterSelect()
IL_002b: brfalse.s IL_0034
IL_002d: ldsfld System.Boolean Globals::isChapterSelect
IL_0032: brtrue.s IL_0062
IL_0034: ldloc.1
IL_0035: callvirt System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_skipDuringCheatCode()
IL_003a: brfalse.s IL_0043
IL_003c: ldsfld System.Boolean Globals::isCheatCode
IL_0041: brtrue.s IL_0062
IL_0043: ldloc.1
IL_0044: ldfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_0049: ldarg.1
IL_004a: beq.s IL_005c
IL_004c: ldloc.1
IL_004d: ldfld TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::arc
IL_0052: brtrue.s IL_0062
IL_0054: ldloc.1
IL_0055: ldfld System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::allowNullArc
IL_005a: brfalse.s IL_0062
IL_005c: ldloc.1
IL_005d: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::ForceExecute()
IL_0062: ldloca.s V_0
IL_0064: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::MoveNext()
IL_0069: brtrue.s IL_000e
IL_006b: leave.s IL_007b
IL_006d: ldloca.s V_0
IL_006f: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>
IL_0075: callvirt System.Void System.IDisposable::Dispose()
IL_007a: endfinally
IL_007b: ret
