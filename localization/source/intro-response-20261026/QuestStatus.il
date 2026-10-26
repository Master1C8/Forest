TYPE TheForestOfLove.Narrative.Quest
METHOD TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.QuestStatusRecord TheForestOfLove.Narrative.Quest::statusRecord
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.Narrative.QuestStatusRecord TheForestOfLove.Narrative.Quest::statusRecord
IL_0010: ldfld TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.QuestStatusRecord::status
IL_0015: ret
METHOD System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_0006: ldc.i4 200
IL_000b: ceq
IL_000d: ret
