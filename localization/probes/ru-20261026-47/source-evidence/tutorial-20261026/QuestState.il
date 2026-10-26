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
METHOD System.Boolean TheForestOfLove.Narrative.Quest::get_isStarted()
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_0006: ldc.i4.s 100
IL_0008: ceq
IL_000a: ret
METHOD System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_0006: ldc.i4 200
IL_000b: ceq
IL_000d: ret
METHOD System.Boolean TheForestOfLove.Narrative.Quest::IsAvailableWithTags()
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Quest::disableWithTags
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_000b: stloc.1
IL_000c: br.s IL_0025
IL_000e: ldloca.s V_1
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_0015: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_001a: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_001f: brfalse.s IL_0025
IL_0021: ldc.i4.0
IL_0022: stloc.2
IL_0023: leave.s IL_0085
IL_0025: ldloca.s V_1
IL_0027: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_002c: brtrue.s IL_000e
IL_002e: leave.s IL_003e
IL_0030: ldloca.s V_1
IL_0032: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_0038: callvirt System.Void System.IDisposable::Dispose()
IL_003d: endfinally
IL_003e: ldc.i4.0
IL_003f: stloc.0
IL_0040: ldarg.0
IL_0041: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Quest::enableWithTags
IL_0046: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_004b: stloc.1
IL_004c: br.s IL_0065
IL_004e: ldloca.s V_1
IL_0050: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_0055: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_005a: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_005f: brfalse.s IL_0065
IL_0061: ldc.i4.1
IL_0062: stloc.0
IL_0063: leave.s IL_007e
IL_0065: ldloca.s V_1
IL_0067: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_006c: brtrue.s IL_004e
IL_006e: leave.s IL_007e
IL_0070: ldloca.s V_1
IL_0072: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_0078: callvirt System.Void System.IDisposable::Dispose()
IL_007d: endfinally
IL_007e: ldloc.0
IL_007f: brtrue.s IL_0083
IL_0081: ldc.i4.0
IL_0082: ret
IL_0083: ldc.i4.1
IL_0084: ret
IL_0085: ldloc.2
IL_0086: ret
