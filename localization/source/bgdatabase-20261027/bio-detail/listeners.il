TYPE TheForestOfLove.Narrative.ActorTrackingService
METHOD System.Void TheForestOfLove.Narrative.ActorTrackingService::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.GameplayBehavior::AddEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueStart
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.Narrative.ActorTrackingService::OnDialogueStart(TheForestOfLove.Narrative.Dialogue)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_001c: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.Narrative.ActorTrackingService::OnDialogueLineBegin(TheForestOfLove.Narrative.Actor,System.String)
IL_0028: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Narrative.Actor,System.String>::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0032: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueFinish
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.Narrative.ActorTrackingService::OnDialogueFinished(TheForestOfLove.Narrative.Dialogue)
IL_003e: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0048: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onActiveTagsChanged
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.Narrative.ActorTrackingService::OnActiveTagsChanged()
IL_0054: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_005e: ret
METHOD System.Void TheForestOfLove.Narrative.ActorTrackingService::RemoveEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.GameplayBehavior::RemoveEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueStart
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.Narrative.ActorTrackingService::OnDialogueStart(TheForestOfLove.Narrative.Dialogue)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_001c: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.Narrative.ActorTrackingService::OnDialogueLineBegin(TheForestOfLove.Narrative.Actor,System.String)
IL_0028: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Narrative.Actor,System.String>::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::RemoveListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0032: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueFinish
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.Narrative.ActorTrackingService::OnDialogueFinished(TheForestOfLove.Narrative.Dialogue)
IL_003e: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0048: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onActiveTagsChanged
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.Narrative.ActorTrackingService::OnActiveTagsChanged()
IL_0054: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_005e: ret
