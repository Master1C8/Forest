TYPE TheForestOfLove.Narrative.Arc
METHOD TheForestOfLove.Narrative.ArcStatus TheForestOfLove.Narrative.Arc::get_status()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.ArcStatusRecord TheForestOfLove.Narrative.Arc::statusRecord
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.ArcStatusRecord TheForestOfLove.Narrative.Arc::statusRecord
IL_0010: ldfld TheForestOfLove.Narrative.ArcStatus TheForestOfLove.Narrative.ArcStatusRecord::status
IL_0015: ret
METHOD System.Boolean TheForestOfLove.Narrative.Arc::get_isPlayed()
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.ArcStatus TheForestOfLove.Narrative.Arc::get_status()
IL_0006: ldc.i4.s 100
IL_0008: ceq
IL_000a: ret
METHOD System.Boolean TheForestOfLove.Narrative.Arc::get_isSkipped()
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.ArcStatus TheForestOfLove.Narrative.Arc::get_status()
IL_0006: ldc.i4 200
IL_000b: ceq
IL_000d: ret
