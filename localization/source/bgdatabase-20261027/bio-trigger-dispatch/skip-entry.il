TYPE TheForestOfLove.QuestSkipController
METHOD System.Void TheForestOfLove.QuestSkipController::TrySkipConversation() | attributes=Private, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0005: stloc.0
IL_0006: call TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.DialogueService::get_CurrentArc()
IL_000b: stloc.1
IL_000c: ldarg.0
IL_000d: ldloc.0
IL_000e: ldloc.1
IL_000f: call System.Boolean TheForestOfLove.QuestSkipController::CanSkip(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc)
IL_0014: brtrue.s IL_0017
IL_0016: ret
IL_0017: ldarg.0
IL_0018: ldloc.0
IL_0019: ldloc.1
IL_001a: call System.Void TheForestOfLove.QuestSkipController::SkipConversation(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc)
IL_001f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueSkipSuccessful
IL_0024: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0029: ret
