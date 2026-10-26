TYPE TheForestOfLove.Interaction.DialogueInteractionTrigger
METHOD TheForestOfLove.Narrative.QuestManagerInteractionMode TheForestOfLove.Interaction.DialogueInteractionTrigger::get_interactionMode()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.QuestManagerInteractionMode TheForestOfLove.Interaction.DialogueInteractionTrigger::<interactionMode>k__BackingField
IL_0006: ret
METHOD System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::get_IsAuthority()
IL_0000: ldarg.0
IL_0001: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_0010
IL_000e: ldc.i4.0
IL_000f: ret
IL_0010: ldsfld System.Int32 TheForestOfLove.Interaction.DialogueInteractionTrigger::authorityId
IL_0015: ldarg.0
IL_0016: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001b: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0020: ceq
IL_0022: ret
METHOD System.String TheForestOfLove.Interaction.DialogueInteractionTrigger::get_dialogueDbName()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.DialogueSettings TheForestOfLove.Interaction.DialogueInteractionTrigger::settings
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_0010
IL_000e: ldnull
IL_000f: ret
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.DialogueSettings TheForestOfLove.Interaction.DialogueInteractionTrigger::settings
IL_0016: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_001b: ret
METHOD System.String TheForestOfLove.Interaction.DialogueInteractionTrigger::get_arcDbName()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.DialogueSettings TheForestOfLove.Interaction.DialogueInteractionTrigger::settings
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_0010
IL_000e: ldnull
IL_000f: ret
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.DialogueSettings TheForestOfLove.Interaction.DialogueInteractionTrigger::settings
IL_0016: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_001b: ret
METHOD System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::TryActivateTrigger()
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Interaction.InteractionTrigger::get_interactionBlocked()
IL_0006: brtrue.s IL_0027
IL_0008: ldsfld System.Int32 TheForestOfLove.Interaction.DialogueInteractionTrigger::authorityId
IL_000d: brtrue.s IL_0027
IL_000f: ldarg.0
IL_0010: call System.Boolean TheForestOfLove.Interaction.InteractionTrigger::CanTrigger()
IL_0015: brfalse.s IL_0027
IL_0017: ldarg.0
IL_0018: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001d: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0022: stsfld System.Int32 TheForestOfLove.Interaction.DialogueInteractionTrigger::authorityId
IL_0027: ldarg.0
IL_0028: ldfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::triggerOnCollision
IL_002d: brfalse.s IL_0051
IL_002f: ldarg.0
IL_0030: callvirt System.Boolean TheForestOfLove.Interaction.InteractionTrigger::CanTrigger()
IL_0035: brfalse.s IL_0051
IL_0037: ldarg.0
IL_0038: call System.Void TheForestOfLove.Interaction.InteractionTrigger::Fire()
IL_003d: ldarg.0
IL_003e: ldc.i4.1
IL_003f: stfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::isTriggered
IL_0044: ldc.i4.0
IL_0045: ldarg.0
IL_0046: ldfld TheForestOfLove.DialogueSettings TheForestOfLove.Interaction.DialogueInteractionTrigger::settings
IL_004b: call System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.DialogueSettings)
IL_0050: pop
IL_0051: ret
METHOD System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::CanTrigger()
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Interaction.InteractionTrigger::CanTrigger()
IL_0006: brfalse.s IL_0087
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::isTriggered
IL_000e: brtrue.s IL_0087
IL_0010: ldarg.0
IL_0011: ldfld System.Int32 TheForestOfLove.Interaction.DialogueInteractionTrigger::cooldownLoopsRemaining
IL_0016: brtrue.s IL_0087
IL_0018: ldarg.0
IL_0019: call System.Boolean TheForestOfLove.Interaction.InteractionTrigger::get_interactionBlocked()
IL_001e: brtrue.s IL_0087
IL_0020: ldarg.0
IL_0021: ldfld TheForestOfLove.DialogueSettings TheForestOfLove.Interaction.DialogueInteractionTrigger::settings
IL_0026: ldnull
IL_0027: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_002c: brfalse.s IL_0087
IL_002e: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0033: brtrue.s IL_0087
IL_0035: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_003a: brtrue.s IL_0087
IL_003c: call System.Boolean TheForestOfLove.InteractionUiController::get_isVisible()
IL_0041: brtrue.s IL_0053
IL_0043: ldarg.0
IL_0044: ldfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::allowTriggeringWithoutUi
IL_0049: brtrue.s IL_0053
IL_004b: ldarg.0
IL_004c: ldfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::triggerOnCollision
IL_0051: brfalse.s IL_0087
IL_0053: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0058: ldnull
IL_0059: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_005e: brfalse.s IL_0087
IL_0060: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0065: callvirt System.Boolean TheForestOfLove.Player::get_canInteract()
IL_006a: brfalse.s IL_0087
IL_006c: ldarg.0
IL_006d: call System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::get_IsAuthority()
IL_0072: brtrue.s IL_0085
IL_0074: ldarg.0
IL_0075: ldfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::triggerOnCollision
IL_007a: brfalse.s IL_0083
IL_007c: ldarg.0
IL_007d: ldfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::isPlayerTouching
IL_0082: ret
IL_0083: ldc.i4.0
IL_0084: ret
IL_0085: ldc.i4.1
IL_0086: ret
IL_0087: ldc.i4.0
IL_0088: ret
