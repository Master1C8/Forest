TYPE TheForestOfLove.Narrative.StoryManager
METHOD System.Void TheForestOfLove.Narrative.StoryManager::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.GameplayBehavior::AddEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_000b: ldnull
IL_000c: ldftn System.Void TheForestOfLove.Narrative.StoryManager::Initialize()
IL_0012: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_001c: ldsfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> TheForestOfLove.Narrative.DialogueService::onDialogueLineArcTriggerCheck
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.Narrative.StoryManager::HandleArcTriggerCheck(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32)
IL_0028: newobj System.Void UnityEngine.Events.UnityAction`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::AddListener(UnityEngine.Events.UnityAction`4<!0,!1,!2,!3>)
IL_0032: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueStart
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.Narrative.StoryManager::HandleDialogueStart(TheForestOfLove.Narrative.Dialogue)
IL_003e: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0048: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueFinish
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.Narrative.StoryManager::HandleDialogueEndFinish(TheForestOfLove.Narrative.Dialogue)
IL_0054: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_005e: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueCancel
IL_0063: ldarg.0
IL_0064: ldftn System.Void TheForestOfLove.Narrative.StoryManager::HandleDialogueEndCancel(TheForestOfLove.Narrative.Dialogue)
IL_006a: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0074: ldsfld TheForestOfLove.Events.DialogueEvent TheForestOfLove.Events.NarrativeEvents::onDialogueStatusCompleted
IL_0079: ldarg.0
IL_007a: ldftn System.Void TheForestOfLove.Narrative.StoryManager::OnDialogueStatusCompleted(TheForestOfLove.Narrative.Dialogue)
IL_0080: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0085: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_008a: ldsfld TheForestOfLove.Events.DialogueEvent TheForestOfLove.Events.NarrativeEvents::onClearDialogueIdles
IL_008f: ldarg.0
IL_0090: ldftn System.Void TheForestOfLove.Narrative.StoryManager::ClearConversationIdle(TheForestOfLove.Narrative.Dialogue)
IL_0096: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_009b: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00a0: ret
METHOD System.Void TheForestOfLove.Narrative.StoryManager::RemoveEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.GameplayBehavior::RemoveEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_000b: ldnull
IL_000c: ldftn System.Void TheForestOfLove.Narrative.StoryManager::Initialize()
IL_0012: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_001c: ldsfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> TheForestOfLove.Narrative.DialogueService::onDialogueLineArcTriggerCheck
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.Narrative.StoryManager::HandleArcTriggerCheck(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32)
IL_0028: newobj System.Void UnityEngine.Events.UnityAction`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::RemoveListener(UnityEngine.Events.UnityAction`4<!0,!1,!2,!3>)
IL_0032: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueStart
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.Narrative.StoryManager::HandleDialogueStart(TheForestOfLove.Narrative.Dialogue)
IL_003e: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0048: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueFinish
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.Narrative.StoryManager::HandleDialogueEndFinish(TheForestOfLove.Narrative.Dialogue)
IL_0054: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_005e: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueCancel
IL_0063: ldarg.0
IL_0064: ldftn System.Void TheForestOfLove.Narrative.StoryManager::HandleDialogueEndCancel(TheForestOfLove.Narrative.Dialogue)
IL_006a: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0074: ldsfld TheForestOfLove.Events.DialogueEvent TheForestOfLove.Events.NarrativeEvents::onDialogueStatusCompleted
IL_0079: ldarg.0
IL_007a: ldftn System.Void TheForestOfLove.Narrative.StoryManager::OnDialogueStatusCompleted(TheForestOfLove.Narrative.Dialogue)
IL_0080: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0085: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_008a: ldsfld TheForestOfLove.Events.DialogueEvent TheForestOfLove.Events.NarrativeEvents::onClearDialogueIdles
IL_008f: ldarg.0
IL_0090: ldftn System.Void TheForestOfLove.Narrative.StoryManager::ClearConversationIdle(TheForestOfLove.Narrative.Dialogue)
IL_0096: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_009b: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00a0: ret
METHOD System.Void TheForestOfLove.Narrative.StoryManager::MarkConversationsAsPlayed(System.String,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: call PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueManager::get_databaseManager()
IL_0005: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_000a: pop
IL_000b: call System.Boolean Globals::get_DisableTriggeredEffects()
IL_0010: stloc.0
IL_0011: ldc.i4.1
IL_0012: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_0017: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetDialogues()
IL_001c: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0021: stloc.1
IL_0022: br.s IL_0040
IL_0024: ldloc.1
IL_0025: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_002a: stloc.2
IL_002b: ldloc.2
IL_002c: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0031: ldarg.1
IL_0032: callvirt System.Boolean System.String::Contains(System.String)
IL_0037: brfalse.s IL_0040
IL_0039: ldloc.2
IL_003a: ldarg.2
IL_003b: call System.Void TheForestOfLove.Narrative.StoryManager::MarkQuestStepAsPlayed(TheForestOfLove.Narrative.Dialogue,System.String)
IL_0040: ldloc.1
IL_0041: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0046: brtrue.s IL_0024
IL_0048: leave.s IL_0054
IL_004a: ldloc.1
IL_004b: brfalse.s IL_0053
IL_004d: ldloc.1
IL_004e: callvirt System.Void System.IDisposable::Dispose()
IL_0053: endfinally
IL_0054: ldloc.0
IL_0055: call System.Void Globals::set_DisableTriggeredEffects(System.Boolean)
IL_005a: ret
