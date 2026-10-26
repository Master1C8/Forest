TYPE TheForestOfLove.Narrative.Dialogue
METHOD TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Narrative.Dialogue::statusRecord
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Narrative.Dialogue::statusRecord
IL_0010: ldfld TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.DialogueStatusRecord::status
IL_0015: ret
METHOD System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0006: ldc.i4 200
IL_000b: ceq
IL_000d: ret
