TYPE TheForestOfLove.Narrative.ActorDialogueOracle
METHOD System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsUnplayedPrimaryQuestDialogue(TheForestOfLove.Narrative.Dialogue)
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
METHOD System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableGossip(TheForestOfLove.Narrative.Dialogue)
IL_0000: ldarg.1
IL_0001: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_isPreconditionSatisfied()
IL_0006: brfalse.s IL_0017
IL_0008: ldarg.1
IL_0009: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_hasPrimaryArcs()
IL_000e: brfalse.s IL_0017
IL_0010: ldarg.1
IL_0011: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::hasPlayerInitiatedQuestion
IL_0016: ret
IL_0017: ldc.i4.0
IL_0018: ret
METHOD System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableUnplayedGossip(TheForestOfLove.Narrative.Dialogue)
IL_0000: ldarg.1
IL_0001: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted()
IL_0006: brtrue.s IL_001b
IL_0008: ldarg.0
IL_0009: ldarg.1
IL_000a: call System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableGossip(TheForestOfLove.Narrative.Dialogue)
IL_000f: brfalse.s IL_001b
IL_0011: ldarg.1
IL_0012: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_firstPrimaryArcPlayed()
IL_0017: ldc.i4.0
IL_0018: ceq
IL_001a: ret
IL_001b: ldc.i4.0
IL_001c: ret
METHOD System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableGossip(System.String)
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorDialogueOracle::actor
IL_0006: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_000b: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetGossipDialoguesByPrimaryActor(System.String)
IL_0010: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0015: stloc.0
IL_0016: br.s IL_003a
IL_0018: ldloc.0
IL_0019: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_001e: stloc.1
IL_001f: ldarg.0
IL_0020: ldloc.1
IL_0021: call System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableGossip(TheForestOfLove.Narrative.Dialogue)
IL_0026: brfalse.s IL_003a
IL_0028: ldloc.1
IL_0029: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_002e: ldarg.1
IL_002f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0034: brfalse.s IL_003a
IL_0036: ldc.i4.1
IL_0037: stloc.2
IL_0038: leave.s IL_0050
IL_003a: ldloc.0
IL_003b: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0040: brtrue.s IL_0018
IL_0042: leave.s IL_004e
IL_0044: ldloc.0
IL_0045: brfalse.s IL_004d
IL_0047: ldloc.0
IL_0048: callvirt System.Void System.IDisposable::Dispose()
IL_004d: endfinally
IL_004e: ldc.i4.0
IL_004f: ret
IL_0050: ldloc.2
IL_0051: ret
METHOD System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableSingleDialogue(TheForestOfLove.Narrative.Dialogue,System.String,System.String)
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldarg.3
IL_0003: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0008: stloc.1
IL_0009: ldloc.1
IL_000a: brtrue.s IL_004b
IL_000c: ldarg.1
IL_000d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0012: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0017: stloc.2
IL_0018: br.s IL_0032
IL_001a: ldloca.s V_2
IL_001c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0021: ldfld System.String TheForestOfLove.Narrative.Arc::customName
IL_0026: ldarg.3
IL_0027: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_002c: brfalse.s IL_0032
IL_002e: ldc.i4.1
IL_002f: stloc.0
IL_0030: leave.s IL_004b
IL_0032: ldloca.s V_2
IL_0034: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0039: brtrue.s IL_001a
IL_003b: leave.s IL_004b
IL_003d: ldloca.s V_2
IL_003f: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0045: callvirt System.Void System.IDisposable::Dispose()
IL_004a: endfinally
IL_004b: ldarg.1
IL_004c: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0051: ldarg.2
IL_0052: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0057: brfalse.s IL_0088
IL_0059: ldloc.1
IL_005a: ldloc.0
IL_005b: or
IL_005c: brfalse.s IL_0088
IL_005e: ldarg.1
IL_005f: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_isPreconditionSatisfied()
IL_0064: brtrue.s IL_0086
IL_0066: ldarg.1
IL_0067: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_006c: ldc.i4 500
IL_0071: bne.un.s IL_0084
IL_0073: ldarg.1
IL_0074: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0079: ldsfld System.String Globals::Debug_ForceSpawnDate_DialogueDbName
IL_007e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0083: ret
IL_0084: ldc.i4.0
IL_0085: ret
IL_0086: ldc.i4.1
IL_0087: ret
IL_0088: ldc.i4.0
IL_0089: ret
METHOD System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableSingleDialogue(System.String,System.String)
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetSingleDialogue(System.String,System.String)
IL_0008: ldnull
IL_0009: cgt.un
IL_000b: ret
METHOD System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableSingleDialogueWithUnplayedPrimaryArcs(System.String,System.String)
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetSingleDialogue(System.String,System.String)
IL_0008: stloc.0
IL_0009: ldloc.0
IL_000a: brfalse.s IL_0016
IL_000c: ldloc.0
IL_000d: callvirt System.Boolean TheForestOfLove.Narrative.Dialogue::get_allPrimaryArcsPlayed()
IL_0012: ldc.i4.0
IL_0013: ceq
IL_0015: ret
IL_0016: ldc.i4.0
IL_0017: ret
METHOD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.ActorDialogueOracle::GetSingleDialogue(System.String,System.String)
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorDialogueOracle::actor
IL_0006: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_000b: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetDialoguesByPrimaryActor(System.String)
IL_0010: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0015: stloc.0
IL_0016: br.s IL_002e
IL_0018: ldloc.0
IL_0019: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_001e: stloc.1
IL_001f: ldarg.0
IL_0020: ldloc.1
IL_0021: ldarg.1
IL_0022: ldarg.2
IL_0023: call System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableSingleDialogue(TheForestOfLove.Narrative.Dialogue,System.String,System.String)
IL_0028: brfalse.s IL_002e
IL_002a: ldloc.1
IL_002b: stloc.2
IL_002c: leave.s IL_0044
IL_002e: ldloc.0
IL_002f: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0034: brtrue.s IL_0018
IL_0036: leave.s IL_0042
IL_0038: ldloc.0
IL_0039: brfalse.s IL_0041
IL_003b: ldloc.0
IL_003c: callvirt System.Void System.IDisposable::Dispose()
IL_0041: endfinally
IL_0042: ldnull
IL_0043: ret
IL_0044: ldloc.2
IL_0045: ret
