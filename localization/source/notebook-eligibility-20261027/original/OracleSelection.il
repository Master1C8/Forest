TYPE TheForestOfLove.Narrative.ActorDialogueOracle
METHOD System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsUnplayedPrimaryQuestDialogue(TheForestOfLove.Narrative.Dialogue) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0006: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_000b: brtrue.s IL_0052
IL_000d: ldarg.1
IL_000e: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_0013: callvirt System.Boolean TheForestOfLove.Narrative.Quest::IsAvailableWithTags()
IL_0018: brfalse.s IL_0052
IL_001a: ldarg.1
IL_001b: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted()
IL_0020: brtrue.s IL_0052
IL_0022: ldarg.1
IL_0023: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_isPreconditionSatisfied()
IL_0028: brfalse.s IL_0052
IL_002a: ldarg.1
IL_002b: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::hasPlayerInitiatedQuestion
IL_0030: brtrue.s IL_0052
IL_0032: ldarg.1
IL_0033: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_0038: ldarg.0
IL_0039: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorDialogueOracle::actor
IL_003e: bne.un.s IL_0052
IL_0040: ldarg.1
IL_0041: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_hasPrimaryArcs()
IL_0046: brfalse.s IL_0052
IL_0048: ldarg.1
IL_0049: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_allPrimaryArcsPlayed()
IL_004e: ldc.i4.0
IL_004f: ceq
IL_0051: ret
IL_0052: ldc.i4.0
IL_0053: ret
METHOD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetFirstEncounteredUnplayedPrimaryQuestDialogue() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorDialogueOracle::actor
IL_0006: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_000b: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetQuestDialoguesByPrimaryActor(System.String)
IL_0010: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0015: stloc.0
IL_0016: br.s IL_002c
IL_0018: ldloc.0
IL_0019: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_001e: stloc.1
IL_001f: ldarg.0
IL_0020: ldloc.1
IL_0021: call System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsUnplayedPrimaryQuestDialogue(TheForestOfLove.Narrative.Dialogue)
IL_0026: brfalse.s IL_002c
IL_0028: ldloc.1
IL_0029: stloc.2
IL_002a: leave.s IL_0042
IL_002c: ldloc.0
IL_002d: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0032: brtrue.s IL_0018
IL_0034: leave.s IL_0040
IL_0036: ldloc.0
IL_0037: brfalse.s IL_003f
IL_0039: ldloc.0
IL_003a: callvirt System.Void System.IDisposable::Dispose()
IL_003f: endfinally
IL_0040: ldnull
IL_0041: ret
IL_0042: ldloc.2
IL_0043: ret
