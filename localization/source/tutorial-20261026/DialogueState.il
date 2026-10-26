TYPE TheForestOfLove.Narrative.Dialogue
METHOD TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Narrative.Dialogue::statusRecord
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Narrative.Dialogue::statusRecord
IL_0010: ldfld TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.DialogueStatusRecord::status
IL_0015: ret
METHOD System.Boolean TheForestOfLove.Narrative.Dialogue::get_isStarted()
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0006: ldc.i4.s 100
IL_0008: ceq
IL_000a: ret
METHOD System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted()
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0006: ldc.i4 200
IL_000b: ceq
IL_000d: ret
METHOD System.Boolean TheForestOfLove.Narrative.Dialogue::get_firstPrimaryArcPlayed()
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_0007: call System.Boolean TheForestOfLove.Narrative.Dialogue::CheckIfFirstArcPlayed(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>)
IL_000c: ret
METHOD System.Boolean TheForestOfLove.Narrative.Dialogue::get_allPrimaryArcsPlayed()
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_0007: call System.Boolean TheForestOfLove.Narrative.Dialogue::CheckIfAllArcsPlayed(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>)
IL_000c: ret
