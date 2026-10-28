TYPE TheForestOfLove.DialogueNameplateController
METHOD System.Void TheForestOfLove.DialogueNameplateController::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueStart
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.DialogueNameplateController::OnConversationStart_Handler()
IL_0012: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_001c: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.DialogueNameplateController::OnConversationEnd_Handler()
IL_0028: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0032: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginDetailed
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.DialogueNameplateController::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle)
IL_003e: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0048: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onArcTriggerUpdatePortraits
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.DialogueNameplateController::OnConversationTriggerUpdatePortraits(System.String)
IL_0054: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_005e: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onChangeFont
IL_0063: ldarg.0
IL_0064: ldftn System.Void TheForestOfLove.DialogueNameplateController::OnChangeFont(System.String)
IL_006a: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0074: ret
METHOD System.Void TheForestOfLove.DialogueNameplateController::RemoveEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueStart
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.DialogueNameplateController::OnConversationStart_Handler()
IL_0012: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_001c: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.DialogueNameplateController::OnConversationEnd_Handler()
IL_0028: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_0032: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginDetailed
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.DialogueNameplateController::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle)
IL_003e: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::RemoveListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0048: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onArcTriggerUpdatePortraits
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.DialogueNameplateController::OnConversationTriggerUpdatePortraits(System.String)
IL_0054: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_005e: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.NarrativeEvents::onChangeFont
IL_0063: ldarg.0
IL_0064: ldftn System.Void TheForestOfLove.DialogueNameplateController::OnChangeFont(System.String)
IL_006a: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0074: ret
