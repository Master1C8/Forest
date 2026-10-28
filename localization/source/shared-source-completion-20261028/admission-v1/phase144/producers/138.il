TYPE TheForestOfLove.QuestTriggerHandler
METHOD System.Void TheForestOfLove.QuestTriggerHandler::HandleTrigger(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldsfld UnityEngine.Events.UnityEvent`1<System.String> TheForestOfLove.QuestTriggerHandler::onNamedTrigger
IL_0005: ldarg.1
IL_0006: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_000b: ldsfld System.Boolean TheForestOfLove.QuestTriggerHandler::skipAutomaticHandlersForCurrentTrigger
IL_0010: ldc.i4.0
IL_0011: stsfld System.Boolean TheForestOfLove.QuestTriggerHandler::skipAutomaticHandlersForCurrentTrigger
IL_0016: brfalse.s IL_0019
IL_0018: ret
IL_0019: ldarg.0
IL_001a: callvirt System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.QuestTriggerHandler::get_triggerFilters()
IL_001f: ldstr "global-handler:_run-for-all-triggers"
IL_0024: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Contains(!0)
IL_0029: brfalse.s IL_0032
IL_002b: ldarg.0
IL_002c: ldarg.1
IL_002d: callvirt System.Void TheForestOfLove.QuestTriggerHandler::ExecuteTrigger(System.String)
IL_0032: ldarg.0
IL_0033: callvirt System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.QuestTriggerHandler::get_triggerFilters()
IL_0038: callvirt System.Collections.Generic.HashSet`1/Enumerator<!0> System.Collections.Generic.HashSet`1<System.String>::GetEnumerator()
IL_003d: stloc.0
IL_003e: br.s IL_0090
IL_0040: ldloca.s V_0
IL_0042: call !0 System.Collections.Generic.HashSet`1/Enumerator<System.String>::get_Current()
IL_0047: stloc.1
IL_0048: ldarg.1
IL_0049: ldloc.1
IL_004a: callvirt System.Boolean System.String::Contains(System.String)
IL_004f: brtrue.s IL_0087
IL_0051: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0056: brfalse.s IL_0065
IL_0058: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_005d: ldloc.1
IL_005e: callvirt System.Boolean System.String::Contains(System.String)
IL_0063: brtrue.s IL_0087
IL_0065: ldsfld System.Boolean Globals::isChapterSelect
IL_006a: brtrue.s IL_0073
IL_006c: ldsfld System.Boolean Globals::isCheatCode
IL_0071: brfalse.s IL_0090
IL_0073: ldsfld System.String Globals::chapterSelectCurrentDialogueDbName
IL_0078: brfalse.s IL_0090
IL_007a: ldsfld System.String Globals::chapterSelectCurrentDialogueDbName
IL_007f: ldloc.1
IL_0080: callvirt System.Boolean System.String::Contains(System.String)
IL_0085: brfalse.s IL_0090
IL_0087: ldarg.0
IL_0088: ldarg.1
IL_0089: callvirt System.Void TheForestOfLove.QuestTriggerHandler::ExecuteTrigger(System.String)
IL_008e: leave.s IL_00a9
IL_0090: ldloca.s V_0
IL_0092: call System.Boolean System.Collections.Generic.HashSet`1/Enumerator<System.String>::MoveNext()
IL_0097: brtrue.s IL_0040
IL_0099: leave.s IL_00a9
IL_009b: ldloca.s V_0
IL_009d: constrained. System.Collections.Generic.HashSet`1/Enumerator<System.String>
IL_00a3: callvirt System.Void System.IDisposable::Dispose()
IL_00a8: endfinally
IL_00a9: ret
