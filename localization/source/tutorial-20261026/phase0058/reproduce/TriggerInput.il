TYPE TheForestOfLove.Interaction.DialogueInteractionTrigger
METHOD System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: ldarg.0
IL_0008: ldfld TheForestOfLove.DialogueSettings TheForestOfLove.Interaction.DialogueInteractionTrigger::settings
IL_000d: ldnull
IL_000e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0013: brtrue.s IL_001d
IL_0015: ldarg.0
IL_0016: ldfld TheForestOfLove.DialogueSettings TheForestOfLove.Interaction.DialogueInteractionTrigger::settings
IL_001b: br.s IL_0023
IL_001d: ldarg.0
IL_001e: call !!0 UnityEngine.Component::GetComponent<TheForestOfLove.DialogueSettings>()
IL_0023: stfld TheForestOfLove.DialogueSettings TheForestOfLove.Interaction.DialogueInteractionTrigger::settings
IL_0028: ret
METHOD System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::TryResetAuthority() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::get_IsAuthority()
IL_0006: brfalse.s IL_002b
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::isTriggered
IL_000e: brfalse.s IL_001e
IL_0010: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0015: brfalse.s IL_001e
IL_0017: ldarg.0
IL_0018: ldc.i4.1
IL_0019: stfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::wasTriggeredDialoguePlayingDuringAuthorityReset
IL_001e: ldc.i4.0
IL_001f: stsfld System.Int32 TheForestOfLove.Interaction.DialogueInteractionTrigger::authorityId
IL_0024: ldarg.0
IL_0025: ldc.i4.0
IL_0026: stfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::isTriggered
IL_002b: ret
METHOD System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueStart
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::OnDialogueStart()
IL_0012: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_001c: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::OnDialogueEnd()
IL_0028: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0032: ldarg.0
IL_0033: ldfld TheForestOfLove.CollisionEventListener TheForestOfLove.Interaction.DialogueInteractionTrigger::collisionEventListener
IL_0038: ldnull
IL_0039: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_003e: brfalse.s IL_0078
IL_0040: ldarg.0
IL_0041: ldfld TheForestOfLove.CollisionEventListener TheForestOfLove.Interaction.DialogueInteractionTrigger::collisionEventListener
IL_0046: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerEnter2D
IL_004b: ldarg.0
IL_004c: ldftn System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::OnTriggerEnter2D(UnityEngine.Collider2D)
IL_0052: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Collider2D>::.ctor(System.Object,System.IntPtr)
IL_0057: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Collider2D>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_005c: ldarg.0
IL_005d: ldfld TheForestOfLove.CollisionEventListener TheForestOfLove.Interaction.DialogueInteractionTrigger::collisionEventListener
IL_0062: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerExit2D
IL_0067: ldarg.0
IL_0068: ldftn System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::OnTriggerExit2D(UnityEngine.Collider2D)
IL_006e: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Collider2D>::.ctor(System.Object,System.IntPtr)
IL_0073: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Collider2D>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0078: ret
METHOD System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.Interaction.DialogueInteractionTrigger::cooldownLoopsRemaining
IL_0006: ldc.i4.0
IL_0007: ble.s IL_0017
IL_0009: ldarg.0
IL_000a: ldarg.0
IL_000b: ldfld System.Int32 TheForestOfLove.Interaction.DialogueInteractionTrigger::cooldownLoopsRemaining
IL_0010: ldc.i4.1
IL_0011: sub
IL_0012: stfld System.Int32 TheForestOfLove.Interaction.DialogueInteractionTrigger::cooldownLoopsRemaining
IL_0017: ldarg.0
IL_0018: ldfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::isPlayerTouching
IL_001d: brfalse.s IL_0034
IL_001f: ldarg.0
IL_0020: ldfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::isTriggered
IL_0025: brtrue.s IL_0034
IL_0027: ldsfld System.Int32 TheForestOfLove.Interaction.DialogueInteractionTrigger::authorityId
IL_002c: brtrue.s IL_0034
IL_002e: ldarg.0
IL_002f: call System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::TryActivateTrigger()
IL_0034: call System.Boolean TheForestOfLove.InputHelper::get_IsSubmitButtonDown()
IL_0039: brfalse.s IL_0073
IL_003b: ldarg.0
IL_003c: ldfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::triggerOnCollision
IL_0041: brtrue.s IL_0073
IL_0043: ldarg.0
IL_0044: callvirt System.Boolean TheForestOfLove.Interaction.InteractionTrigger::CanTrigger()
IL_0049: brfalse.s IL_0073
IL_004b: ldarg.0
IL_004c: call TheForestOfLove.Narrative.QuestManagerInteractionMode TheForestOfLove.Interaction.DialogueInteractionTrigger::get_interactionMode()
IL_0051: ldc.i4.2
IL_0052: beq.s IL_0073
IL_0054: ldarg.0
IL_0055: call System.Void TheForestOfLove.Interaction.InteractionTrigger::Fire()
IL_005a: ldarg.0
IL_005b: ldc.i4.1
IL_005c: stfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::isTriggered
IL_0061: ldarg.0
IL_0062: call TheForestOfLove.Narrative.QuestManagerInteractionMode TheForestOfLove.Interaction.DialogueInteractionTrigger::get_interactionMode()
IL_0067: ldarg.0
IL_0068: ldfld TheForestOfLove.DialogueSettings TheForestOfLove.Interaction.DialogueInteractionTrigger::settings
IL_006d: call System.Boolean TheForestOfLove.Narrative.StoryManager::PlayDialogue(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.DialogueSettings)
IL_0072: pop
IL_0073: ret
METHOD System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::OnTriggerEnter2D(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_0031
IL_000d: ldarg.1
IL_000e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0013: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0018: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0022: brfalse.s IL_0031
IL_0024: ldarg.0
IL_0025: ldc.i4.1
IL_0026: stfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::isPlayerTouching
IL_002b: ldarg.0
IL_002c: call System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::TryActivateTrigger()
IL_0031: ret
METHOD System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::TryActivateTrigger() | attributes=Private, HideBySig | impl=IL
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
METHOD System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::OnTriggerExit2D(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_0031
IL_000d: ldarg.1
IL_000e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0013: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0018: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0022: brfalse.s IL_0031
IL_0024: ldarg.0
IL_0025: ldc.i4.0
IL_0026: stfld System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::isPlayerTouching
IL_002b: ldarg.0
IL_002c: call System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::TryResetAuthority()
IL_0031: ret
METHOD System.Boolean TheForestOfLove.Interaction.DialogueInteractionTrigger::CanTrigger() | attributes=Family, Virtual, HideBySig | impl=IL
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
