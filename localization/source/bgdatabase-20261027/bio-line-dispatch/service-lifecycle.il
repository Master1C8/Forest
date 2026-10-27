TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_000c: ldc.i4.1
IL_000d: stfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemTrigger::exclusive
IL_0012: ldarg.0
IL_0013: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_0018: ldc.i4.s 32
IL_001a: stfld PixelCrushers.DialogueSystem.DialogueSystemTriggerEvent PixelCrushers.DialogueSystem.DialogueSystemTrigger::trigger
IL_001f: ldarg.0
IL_0020: call System.Void TheForestOfLove.Narrative.DialogueService::Initialize()
IL_0025: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationStart(UnityEngine.Transform) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsDialoguePlaying(System.Boolean)
IL_0006: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueStart
IL_000b: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0010: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_0015: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueStart
IL_001a: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_001f: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationEnd(UnityEngine.Transform) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsDialoguePlaying(System.Boolean)
IL_0006: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueFinish
IL_000b: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0010: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_0015: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueEndFinishOrCancel
IL_001a: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_001f: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_0024: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_0029: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_002e: ldarg.0
IL_002f: call System.Void TheForestOfLove.Narrative.DialogueService::Initialize()
IL_0034: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationCancelled(UnityEngine.Transform) | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueCancel
IL_0005: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_000a: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_000f: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueEndFinishOrCancel
IL_0014: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0019: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_001e: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_0023: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0028: ldarg.0
IL_0029: call System.Void TheForestOfLove.Narrative.DialogueService::Initialize()
IL_002e: ret
