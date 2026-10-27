TYPE TheForestOfLove.Narrative.StoryManager
METHOD System.Void TheForestOfLove.Narrative.StoryManager::HandleArcTriggerCheck(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.2
IL_0002: ldarg.3
IL_0003: ldarg.s pluginDbDialogueEntryId
IL_0005: callvirt System.Void TheForestOfLove.Narrative.Dialogue::FireArcTriggers(TheForestOfLove.Narrative.Arc,System.Int32,System.Int32)
IL_000a: ret
METHOD System.Void TheForestOfLove.Narrative.StoryManager::MarkQuestStepAsPlayed(TheForestOfLove.Narrative.Dialogue,System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_006f
IL_0003: ldarg.0
IL_0004: callvirt System.Void TheForestOfLove.Narrative.Dialogue::SetStatusCompleted()
IL_0009: ldarg.0
IL_000a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_000f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0014: stloc.0
IL_0015: br.s IL_0023
IL_0017: ldloca.s V_0
IL_0019: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_001e: callvirt System.Void TheForestOfLove.Narrative.Arc::SetStatusPlayed()
IL_0023: ldloca.s V_0
IL_0025: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_002a: brtrue.s IL_0017
IL_002c: leave.s IL_003c
IL_002e: ldloca.s V_0
IL_0030: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0036: callvirt System.Void System.IDisposable::Dispose()
IL_003b: endfinally
IL_003c: ldarg.0
IL_003d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_0042: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::GetEnumerator()
IL_0047: stloc.1
IL_0048: br.s IL_0056
IL_004a: ldloca.s V_1
IL_004c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::get_Current()
IL_0051: callvirt System.Void TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::ForceExecute()
IL_0056: ldloca.s V_1
IL_0058: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::MoveNext()
IL_005d: brtrue.s IL_004a
IL_005f: leave.s IL_00bf
IL_0061: ldloca.s V_1
IL_0063: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>
IL_0069: callvirt System.Void System.IDisposable::Dispose()
IL_006e: endfinally
IL_006f: ldarg.0
IL_0070: callvirt System.Void TheForestOfLove.Narrative.Dialogue::SetStatusCompleted()
IL_0075: ldarg.0
IL_0076: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_007b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0080: stloc.0
IL_0081: br.s IL_00a6
IL_0083: ldloca.s V_0
IL_0085: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_008a: stloc.2
IL_008b: ldloc.2
IL_008c: ldfld System.String TheForestOfLove.Narrative.Arc::customName
IL_0091: ldarg.1
IL_0092: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0097: brfalse.s IL_00a6
IL_0099: ldloc.2
IL_009a: callvirt System.Void TheForestOfLove.Narrative.Arc::SetStatusPlayed()
IL_009f: ldarg.0
IL_00a0: ldloc.2
IL_00a1: callvirt System.Void TheForestOfLove.Narrative.Dialogue::ForceFireArcTriggers(TheForestOfLove.Narrative.Arc)
IL_00a6: ldloca.s V_0
IL_00a8: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_00ad: brtrue.s IL_0083
IL_00af: leave.s IL_00bf
IL_00b1: ldloca.s V_0
IL_00b3: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_00b9: callvirt System.Void System.IDisposable::Dispose()
IL_00be: endfinally
IL_00bf: ret
