TYPE TheForestOfLove.InteractionUiController
METHOD System.Boolean TheForestOfLove.InteractionUiController::get_isAuthority()
IL_0000: ldarg.0
IL_0001: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_0010
IL_000e: ldc.i4.0
IL_000f: ret
IL_0010: ldsfld System.Int32 TheForestOfLove.InteractionUiController::authorityId
IL_0015: ldarg.0
IL_0016: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001b: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0020: ceq
IL_0022: ret
METHOD System.Boolean TheForestOfLove.InteractionUiController::get_isVisible()
IL_0000: ldsfld System.Boolean TheForestOfLove.InteractionUiController::<isVisible>k__BackingField
IL_0005: ret
METHOD System.Boolean TheForestOfLove.InteractionUiController::CanShow()
IL_0000: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0005: ldc.i4.0
IL_0006: ceq
IL_0008: ret
METHOD System.Void TheForestOfLove.InteractionUiController::OnInterationOptionSelected(TheForestOfLove.InteractionUiOption)
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.InteractionUiController::get_isAuthority()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.1
IL_000a: switch IL_001f,IL_0043,IL_0052,IL_0061
IL_001f: ldc.i4.0
IL_0020: stloc.0
IL_0021: ldarg.0
IL_0022: ldfld System.Boolean TheForestOfLove.InteractionUiController::injectFastTravelReinitiationConversation
IL_0027: brfalse.s IL_0036
IL_0029: ldarg.0
IL_002a: call TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::get_DynamicConversationTrigger()
IL_002f: callvirt System.Void TheForestOfLove.Interaction.InteractionTrigger::DisableTriggerActivation()
IL_0034: br.s IL_006e
IL_0036: ldarg.0
IL_0037: call TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::get_DynamicConversationTrigger()
IL_003c: callvirt System.Void TheForestOfLove.Interaction.InteractionTrigger::EnableTriggerActivation()
IL_0041: br.s IL_006e
IL_0043: ldc.i4.1
IL_0044: stloc.0
IL_0045: ldarg.0
IL_0046: call TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::get_DynamicConversationTrigger()
IL_004b: callvirt System.Void TheForestOfLove.Interaction.InteractionTrigger::EnableTriggerActivation()
IL_0050: br.s IL_006e
IL_0052: ldc.i4.2
IL_0053: stloc.0
IL_0054: ldarg.0
IL_0055: call TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::get_DynamicConversationTrigger()
IL_005a: callvirt System.Void TheForestOfLove.Interaction.InteractionTrigger::EnableTriggerActivation()
IL_005f: br.s IL_006e
IL_0061: ldc.i4.0
IL_0062: stloc.0
IL_0063: ldarg.0
IL_0064: call TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::get_DynamicConversationTrigger()
IL_0069: callvirt System.Void TheForestOfLove.Interaction.InteractionTrigger::EnableTriggerActivation()
IL_006e: ldarg.0
IL_006f: call TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::get_DynamicConversationTrigger()
IL_0074: ldloc.0
IL_0075: callvirt System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::set_interactionMode(TheForestOfLove.Narrative.QuestManagerInteractionMode)
IL_007a: ldarg.0
IL_007b: ldarg.1
IL_007c: stfld TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUiController::lastSelectedOption
IL_0081: ret
