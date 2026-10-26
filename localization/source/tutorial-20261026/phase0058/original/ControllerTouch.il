TYPE TheForestOfLove.InteractionUiController
METHOD System.Void TheForestOfLove.InteractionUiController::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.GameObject[] TheForestOfLove.InteractionUiController::setActiveOnAwake
IL_000c: brfalse.s IL_0037
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.GameObject[] TheForestOfLove.InteractionUiController::setActiveOnAwake
IL_0014: stloc.0
IL_0015: ldc.i4.0
IL_0016: stloc.1
IL_0017: br.s IL_0031
IL_0019: ldloc.0
IL_001a: ldloc.1
IL_001b: ldelem.ref
IL_001c: stloc.2
IL_001d: ldloc.2
IL_001e: ldnull
IL_001f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0024: brfalse.s IL_002d
IL_0026: ldloc.2
IL_0027: ldc.i4.1
IL_0028: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_002d: ldloc.1
IL_002e: ldc.i4.1
IL_002f: add
IL_0030: stloc.1
IL_0031: ldloc.1
IL_0032: ldloc.0
IL_0033: ldlen
IL_0034: conv.i4
IL_0035: blt.s IL_0019
IL_0037: ldarg.0
IL_0038: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.InteractionUi>()
IL_003d: stfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_0042: ldarg.0
IL_0043: ldarg.0
IL_0044: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.Gameplay.SpawnableActor>()
IL_0049: stfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiController::character
IL_004e: ret
METHOD System.Void TheForestOfLove.InteractionUiController::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: ldarg.0
IL_0008: ldfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_000d: ldnull
IL_000e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0013: brtrue.s IL_001d
IL_0015: ldarg.0
IL_0016: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.Interaction.DialogueInteractionTrigger>()
IL_001b: br.s IL_0023
IL_001d: ldarg.0
IL_001e: ldfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_0023: stfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_0028: ldarg.0
IL_0029: call TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::get_DynamicConversationTrigger()
IL_002e: ldnull
IL_002f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0034: brfalse.s IL_0040
IL_0036: ldstr "Interaction Ui Controller: DynamicConversationTrigger not assigned!"
IL_003b: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0040: ldarg.0
IL_0041: ldfld TheForestOfLove.CollisionEventListener TheForestOfLove.InteractionUiController::collisionEventListener
IL_0046: ldnull
IL_0047: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_004c: brfalse.s IL_005a
IL_004e: ldarg.0
IL_004f: ldarg.0
IL_0050: call !!0 UnityEngine.Component::GetComponentInParent<TheForestOfLove.CollisionEventListener>()
IL_0055: stfld TheForestOfLove.CollisionEventListener TheForestOfLove.InteractionUiController::collisionEventListener
IL_005a: ldarg.0
IL_005b: ldfld TheForestOfLove.CollisionEventListener TheForestOfLove.InteractionUiController::collisionEventListener
IL_0060: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerEnter2D
IL_0065: ldarg.0
IL_0066: ldftn System.Void TheForestOfLove.InteractionUiController::OnTriggerEnter2D(UnityEngine.Collider2D)
IL_006c: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Collider2D>::.ctor(System.Object,System.IntPtr)
IL_0071: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Collider2D>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0076: ldarg.0
IL_0077: ldfld TheForestOfLove.CollisionEventListener TheForestOfLove.InteractionUiController::collisionEventListener
IL_007c: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerStay2D
IL_0081: ldarg.0
IL_0082: ldftn System.Void TheForestOfLove.InteractionUiController::OnTriggerStay2D(UnityEngine.Collider2D)
IL_0088: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Collider2D>::.ctor(System.Object,System.IntPtr)
IL_008d: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Collider2D>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0092: ldarg.0
IL_0093: ldfld TheForestOfLove.CollisionEventListener TheForestOfLove.InteractionUiController::collisionEventListener
IL_0098: ldfld TheForestOfLove.Collider2DEvent TheForestOfLove.CollisionEventListener::onTriggerExit2D
IL_009d: ldarg.0
IL_009e: ldftn System.Void TheForestOfLove.InteractionUiController::OnTriggerExit2D(UnityEngine.Collider2D)
IL_00a4: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.Collider2D>::.ctor(System.Object,System.IntPtr)
IL_00a9: callvirt System.Void UnityEngine.Events.UnityEvent`1<UnityEngine.Collider2D>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00ae: ldarg.0
IL_00af: ldfld System.Boolean TheForestOfLove.InteractionUiController::disableTalk
IL_00b4: brfalse.s IL_00c2
IL_00b6: ldarg.0
IL_00b7: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_00bc: ldc.i4.0
IL_00bd: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_00c2: ldarg.0
IL_00c3: ldfld System.Boolean TheForestOfLove.InteractionUiController::disableContinue
IL_00c8: brfalse.s IL_00d6
IL_00ca: ldarg.0
IL_00cb: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_00d0: ldc.i4.1
IL_00d1: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_00d6: ldarg.0
IL_00d7: ldfld System.Boolean TheForestOfLove.InteractionUiController::disableGossip
IL_00dc: brfalse.s IL_00ea
IL_00de: ldarg.0
IL_00df: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_00e4: ldc.i4.2
IL_00e5: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_00ea: ldarg.0
IL_00eb: ldfld System.Boolean TheForestOfLove.InteractionUiController::disableAdvice
IL_00f0: brfalse.s IL_00fe
IL_00f2: ldarg.0
IL_00f3: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_00f8: ldc.i4.4
IL_00f9: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_00fe: ldarg.0
IL_00ff: ldfld System.Boolean TheForestOfLove.InteractionUiController::disableExamine
IL_0104: brfalse.s IL_0112
IL_0106: ldarg.0
IL_0107: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_010c: ldc.i4.3
IL_010d: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_0112: ldarg.0
IL_0113: ldftn System.Void TheForestOfLove.InteractionUiController::<Start>b__35_0()
IL_0119: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_011e: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_0123: ret
METHOD System.Void TheForestOfLove.InteractionUiController::TakeControl() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_0026
IL_000e: ldarg.0
IL_000f: ldnull
IL_0010: stfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_0015: ldarg.0
IL_0016: ldarg.0
IL_0017: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001c: callvirt !!0 UnityEngine.GameObject::GetComponentInParent<TheForestOfLove.Interaction.DialogueInteractionTrigger>()
IL_0021: stfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_0026: ldarg.0
IL_0027: ldarg.0
IL_0028: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_002d: ldnull
IL_002e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0033: brtrue.s IL_003c
IL_0035: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.InteractionUi>()
IL_003a: br.s IL_0042
IL_003c: ldarg.0
IL_003d: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_0042: stfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_0047: ldarg.0
IL_0048: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_004d: ldnull
IL_004e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0053: brtrue.s IL_0085
IL_0055: ldarg.0
IL_0056: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_005b: callvirt System.Boolean TheForestOfLove.InteractionUi::get_locked()
IL_0060: brtrue.s IL_0085
IL_0062: ldarg.0
IL_0063: call TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::get_DynamicConversationTrigger()
IL_0068: ldnull
IL_0069: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_006e: brtrue.s IL_0085
IL_0070: ldarg.0
IL_0071: call TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::get_DynamicConversationTrigger()
IL_0076: callvirt System.Boolean TheForestOfLove.Interaction.InteractionTrigger::get_interactionBlocked()
IL_007b: brfalse.s IL_0086
IL_007d: ldarg.0
IL_007e: ldfld System.Boolean TheForestOfLove.InteractionUiController::injectFastTravelReinitiationConversation
IL_0083: brtrue.s IL_0086
IL_0085: ret
IL_0086: ldarg.0
IL_0087: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_008c: ldc.i4.1
IL_008d: callvirt System.Void TheForestOfLove.InteractionUi::set_locked(System.Boolean)
IL_0092: ldarg.0
IL_0093: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_0098: dup
IL_0099: ldfld TheForestOfLove.InteractionUi/OnOptionSelectedHandler TheForestOfLove.InteractionUi::onOptionSelected
IL_009e: ldarg.0
IL_009f: ldftn System.Void TheForestOfLove.InteractionUiController::OnInterationOptionSelected(TheForestOfLove.InteractionUiOption)
IL_00a5: newobj System.Void TheForestOfLove.InteractionUi/OnOptionSelectedHandler::.ctor(System.Object,System.IntPtr)
IL_00aa: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_00af: castclass TheForestOfLove.InteractionUi/OnOptionSelectedHandler
IL_00b4: stfld TheForestOfLove.InteractionUi/OnOptionSelectedHandler TheForestOfLove.InteractionUi::onOptionSelected
IL_00b9: ldarg.0
IL_00ba: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00bf: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_00c4: stsfld System.Int32 TheForestOfLove.InteractionUiController::authorityId
IL_00c9: ldarg.0
IL_00ca: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiController::character
IL_00cf: ldnull
IL_00d0: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00d5: brtrue.s IL_00da
IL_00d7: ldnull
IL_00d8: br.s IL_00e5
IL_00da: ldarg.0
IL_00db: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiController::character
IL_00e0: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_00e5: call System.Void TheForestOfLove.GossipUI::set_targetActorDbName(System.String)
IL_00ea: ldarg.0
IL_00eb: call System.Void TheForestOfLove.InteractionUiController::UpdateAvailableOptions()
IL_00f0: ldarg.0
IL_00f1: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_00f6: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Count()
IL_00fb: ldc.i4.0
IL_00fc: ble.s IL_0129
IL_00fe: ldarg.0
IL_00ff: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_0104: ldarg.0
IL_0105: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_010a: callvirt !0[] System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::ToArray()
IL_010f: ldarg.0
IL_0110: ldfld System.Nullable`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::firstSelectedOption
IL_0115: callvirt System.Void TheForestOfLove.InteractionUi::SetAvailableOptions(TheForestOfLove.InteractionUiOption[],System.Nullable`1<TheForestOfLove.InteractionUiOption>)
IL_011a: ldarg.0
IL_011b: call System.Boolean TheForestOfLove.InteractionUiController::CanShow()
IL_0120: brfalse.s IL_012f
IL_0122: ldarg.0
IL_0123: call System.Void TheForestOfLove.InteractionUiController::Show()
IL_0128: ret
IL_0129: ldarg.0
IL_012a: call System.Void TheForestOfLove.InteractionUiController::ReleaseControl()
IL_012f: ret
METHOD System.Void TheForestOfLove.InteractionUiController::ReleaseControl() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_002b
IL_000e: ldarg.0
IL_000f: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_0014: callvirt System.Boolean TheForestOfLove.InteractionUi::get_locked()
IL_0019: brfalse.s IL_002b
IL_001b: ldarg.0
IL_001c: call System.Boolean TheForestOfLove.InteractionUiController::get_isAuthority()
IL_0021: brfalse.s IL_002b
IL_0023: ldarg.0
IL_0024: ldfld System.Boolean TheForestOfLove.Core.BaseBehavior::isApplicationQuitting
IL_0029: brfalse.s IL_002c
IL_002b: ret
IL_002c: ldarg.0
IL_002d: call System.Void TheForestOfLove.InteractionUiController::Hide()
IL_0032: ldc.i4.0
IL_0033: stsfld System.Int32 TheForestOfLove.InteractionUiController::authorityId
IL_0038: ldarg.0
IL_0039: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_003e: ldc.i4.0
IL_003f: callvirt System.Void TheForestOfLove.InteractionUi::set_locked(System.Boolean)
IL_0044: ldarg.0
IL_0045: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_004a: dup
IL_004b: ldfld TheForestOfLove.InteractionUi/OnOptionSelectedHandler TheForestOfLove.InteractionUi::onOptionSelected
IL_0050: ldarg.0
IL_0051: ldftn System.Void TheForestOfLove.InteractionUiController::OnInterationOptionSelected(TheForestOfLove.InteractionUiOption)
IL_0057: newobj System.Void TheForestOfLove.InteractionUi/OnOptionSelectedHandler::.ctor(System.Object,System.IntPtr)
IL_005c: call System.Delegate System.Delegate::Remove(System.Delegate,System.Delegate)
IL_0061: castclass TheForestOfLove.InteractionUi/OnOptionSelectedHandler
IL_0066: stfld TheForestOfLove.InteractionUi/OnOptionSelectedHandler TheForestOfLove.InteractionUi::onOptionSelected
IL_006b: ldnull
IL_006c: call System.Void TheForestOfLove.GossipUI::set_targetActorDbName(System.String)
IL_0071: ldarg.0
IL_0072: call TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::get_DynamicConversationTrigger()
IL_0077: ldc.i4.0
IL_0078: callvirt System.Void TheForestOfLove.Interaction.DialogueInteractionTrigger::set_interactionMode(TheForestOfLove.Narrative.QuestManagerInteractionMode)
IL_007d: ret
METHOD System.Void TheForestOfLove.InteractionUiController::OnTriggerEnter2D(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0006: brfalse.s IL_002c
IL_0008: ldarg.1
IL_0009: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_000e: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0013: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0018: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_001d: brfalse.s IL_002c
IL_001f: ldarg.0
IL_0020: ldc.i4.1
IL_0021: stfld System.Boolean TheForestOfLove.InteractionUiController::isPlayerTouching
IL_0026: ldarg.0
IL_0027: call System.Void TheForestOfLove.InteractionUiController::TakeControl()
IL_002c: ret
METHOD System.Void TheForestOfLove.InteractionUiController::OnTriggerStay2D(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brtrue.s IL_0024
IL_000d: ldarg.1
IL_000e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0013: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0018: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0022: brfalse.s IL_002b
IL_0024: ldarg.0
IL_0025: ldc.i4.1
IL_0026: stfld System.Boolean TheForestOfLove.InteractionUiController::isPlayerTouching
IL_002b: ret
METHOD System.Void TheForestOfLove.InteractionUiController::OnTriggerExit2D(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brtrue.s IL_0024
IL_000d: ldarg.1
IL_000e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0013: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0018: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0022: brfalse.s IL_0031
IL_0024: ldarg.0
IL_0025: call System.Void TheForestOfLove.InteractionUiController::ReleaseControl()
IL_002a: ldarg.0
IL_002b: ldc.i4.0
IL_002c: stfld System.Boolean TheForestOfLove.InteractionUiController::isPlayerTouching
IL_0031: ret
