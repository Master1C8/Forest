TYPE TheForestOfLove.Narrative.Quest
METHOD System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_0006: ldc.i4 200
IL_000b: ceq
IL_000d: ret
METHOD System.Boolean TheForestOfLove.Narrative.Quest::IsAvailableWithTags() | attributes=Public, HideBySig | impl=IL
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
METHOD System.Void TheForestOfLove.Narrative.Quest::SetStatusCompleted() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_0006: brfalse.s IL_0027
IL_0008: call System.Boolean Globals::get_DevCommandActive()
IL_000d: brtrue.s IL_0027
IL_000f: ldsfld System.Boolean Globals::isChapterSelect
IL_0014: brtrue.s IL_0027
IL_0016: ldsfld System.Boolean Globals::isCheatCode
IL_001b: brtrue.s IL_0027
IL_001d: ldstr "An already-completed quest just got completed again! This should never happen!"
IL_0022: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0027: ldarg.0
IL_0028: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_002d: ldc.i4 200
IL_0032: bne.un.s IL_004a
IL_0034: call System.Boolean Globals::get_DevCommandActive()
IL_0039: brtrue.s IL_004a
IL_003b: ldsfld System.Boolean Globals::isChapterSelect
IL_0040: brtrue.s IL_004a
IL_0042: ldsfld System.Boolean Globals::isCheatCode
IL_0047: brtrue.s IL_004a
IL_0049: ret
IL_004a: ldarg.0
IL_004b: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_0050: stloc.0
IL_0051: ldarg.0
IL_0052: ldc.i4 200
IL_0057: call TheForestOfLove.Narrative.QuestStatusRecord TheForestOfLove.Services.Persistence.DataService::GetQuestStatusRecordByStatus(TheForestOfLove.Narrative.QuestStatus)
IL_005c: stfld TheForestOfLove.Narrative.QuestStatusRecord TheForestOfLove.Narrative.Quest::statusRecord
IL_0061: ldarg.0
IL_0062: call System.Single Globals::get_StoryClock()
IL_0067: stfld System.Single TheForestOfLove.Narrative.Quest::lastStatusUpdateGameplayTime
IL_006c: ldsfld TheForestOfLove.Events.QuestEvent TheForestOfLove.Events.NarrativeEvents::onQuestStatusCompleted
IL_0071: ldarg.0
IL_0072: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Quest>::Invoke(!0)
IL_0077: ldsfld TheForestOfLove.Events.QuestStatusEvent TheForestOfLove.Events.NarrativeEvents::onQuestStatusUpdated
IL_007c: ldarg.0
IL_007d: ldloc.0
IL_007e: ldarg.0
IL_007f: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_0084: callvirt System.Void UnityEngine.Events.UnityEvent`3<TheForestOfLove.Narrative.Quest,TheForestOfLove.Narrative.QuestStatus,TheForestOfLove.Narrative.QuestStatus>::Invoke(!0,!1,!2)
IL_0089: ret
