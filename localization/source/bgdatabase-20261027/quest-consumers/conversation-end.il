TYPE TheForestOfLove.QuestConversationHelper
METHOD System.Void TheForestOfLove.QuestConversationHelper::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldarg.0
IL_0007: call TheForestOfLove.Gameplay.SwapCameraSettingsDuringConversation TheForestOfLove.QuestConversationHelper::get_conversationCameraSettingsSwapper()
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.Gameplay.SwapCameraSettingsDuringConversation::onCameraSettingsUnswapped
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.QuestConversationHelper::OnConversationCameraSettingsUnswapped()
IL_0018: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0022: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueEndFinishOrCancel
IL_0027: ldarg.0
IL_0028: ldftn System.Void TheForestOfLove.QuestConversationHelper::OnConversationEnd_Handler(TheForestOfLove.Narrative.Dialogue)
IL_002e: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0033: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0038: ret
METHOD System.Void TheForestOfLove.QuestConversationHelper::RemoveEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners()
IL_0006: ldarg.0
IL_0007: call TheForestOfLove.Gameplay.SwapCameraSettingsDuringConversation TheForestOfLove.QuestConversationHelper::get_conversationCameraSettingsSwapper()
IL_000c: ldnull
IL_000d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0012: brfalse.s IL_0030
IL_0014: ldarg.0
IL_0015: call TheForestOfLove.Gameplay.SwapCameraSettingsDuringConversation TheForestOfLove.QuestConversationHelper::get_conversationCameraSettingsSwapper()
IL_001a: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.Gameplay.SwapCameraSettingsDuringConversation::onCameraSettingsUnswapped
IL_001f: ldarg.0
IL_0020: ldftn System.Void TheForestOfLove.QuestConversationHelper::OnConversationCameraSettingsUnswapped()
IL_0026: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_002b: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_0030: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueEndFinishOrCancel
IL_0035: ldarg.0
IL_0036: ldftn System.Void TheForestOfLove.QuestConversationHelper::OnConversationEnd_Handler(TheForestOfLove.Narrative.Dialogue)
IL_003c: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0041: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::RemoveListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0046: ret
METHOD System.Void TheForestOfLove.QuestConversationHelper::OnConversationCameraSettingsUnswapped() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Gameplay.SwapCameraSettingsDuringConversation TheForestOfLove.QuestConversationHelper::get_conversationCameraSettingsSwapper()
IL_0006: ldnull
IL_0007: callvirt System.Void TheForestOfLove.Gameplay.SwapCameraSettingsDuringConversation::set_targetCameraSettings(TheForestOfLove.Cameras.CameraSettings)
IL_000c: ret
METHOD System.Void TheForestOfLove.QuestConversationHelper::OnConversationEnd_Handler(TheForestOfLove.Narrative.Dialogue) | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_0005: ldarg.0
IL_0006: call System.Void TheForestOfLove.QuestConversationHelper::ResetInputs()
IL_000b: ldarg.0
IL_000c: call System.Void TheForestOfLove.QuestConversationHelper::UpdateDynamicTags()
IL_0011: dup
IL_0012: brtrue.s IL_0016
IL_0014: pop
IL_0015: ret
IL_0016: callvirt System.Void System.Action::Invoke()
IL_001b: ret
