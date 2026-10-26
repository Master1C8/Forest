TYPE TheForestOfLove.Narrative.Quest
METHOD System.Void TheForestOfLove.Narrative.Quest::SetStatusStarted() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_0006: brfalse.s IL_0027
IL_0008: call System.Boolean Globals::get_DevCommandActive()
IL_000d: brtrue.s IL_0027
IL_000f: ldsfld System.Boolean Globals::isChapterSelect
IL_0014: brtrue.s IL_0027
IL_0016: ldsfld System.Boolean Globals::isCheatCode
IL_001b: brtrue.s IL_0027
IL_001d: ldstr "A quest already in a terminal status is being set to an intermediate status! This should never happen!"
IL_0022: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0027: ldarg.0
IL_0028: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_002d: ldc.i4.s 100
IL_002f: bne.un.s IL_0047
IL_0031: call System.Boolean Globals::get_DevCommandActive()
IL_0036: brtrue.s IL_0047
IL_0038: ldsfld System.Boolean Globals::isChapterSelect
IL_003d: brtrue.s IL_0047
IL_003f: ldsfld System.Boolean Globals::isCheatCode
IL_0044: brtrue.s IL_0047
IL_0046: ret
IL_0047: ldarg.0
IL_0048: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_004d: stloc.0
IL_004e: ldarg.0
IL_004f: ldc.i4.s 100
IL_0051: call TheForestOfLove.Narrative.QuestStatusRecord TheForestOfLove.Services.Persistence.DataService::GetQuestStatusRecordByStatus(TheForestOfLove.Narrative.QuestStatus)
IL_0056: stfld TheForestOfLove.Narrative.QuestStatusRecord TheForestOfLove.Narrative.Quest::statusRecord
IL_005b: ldarg.0
IL_005c: call System.Single Globals::get_StoryClock()
IL_0061: stfld System.Single TheForestOfLove.Narrative.Quest::lastStatusUpdateGameplayTime
IL_0066: ldsfld TheForestOfLove.Events.QuestEvent TheForestOfLove.Events.NarrativeEvents::onQuestStatusStarted
IL_006b: ldarg.0
IL_006c: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Quest>::Invoke(!0)
IL_0071: ldsfld TheForestOfLove.Events.QuestStatusEvent TheForestOfLove.Events.NarrativeEvents::onQuestStatusUpdated
IL_0076: ldarg.0
IL_0077: ldloc.0
IL_0078: ldarg.0
IL_0079: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_007e: callvirt System.Void UnityEngine.Events.UnityEvent`3<TheForestOfLove.Narrative.Quest,TheForestOfLove.Narrative.QuestStatus,TheForestOfLove.Narrative.QuestStatus>::Invoke(!0,!1,!2)
IL_0083: ret
