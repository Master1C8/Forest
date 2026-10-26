TYPE TheForestOfLove.InteractionUiController
METHOD System.Void TheForestOfLove.InteractionUiController::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.InteractionUiController::CanShow()
IL_0006: brfalse.s IL_0010
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.InteractionUiController::Show()
IL_000e: br.s IL_0016
IL_0010: ldarg.0
IL_0011: call System.Void TheForestOfLove.InteractionUiController::Hide()
IL_0016: ldarg.0
IL_0017: call System.Void TheForestOfLove.InteractionUiController::ListenForAdviceUi()
IL_001c: ldarg.0
IL_001d: call System.Void TheForestOfLove.InteractionUiController::ListenForGossipUi()
IL_0022: ldarg.0
IL_0023: call System.Void TheForestOfLove.InteractionUiController::ListenForFastTravelReinitiation()
IL_0028: ldarg.0
IL_0029: call System.Void TheForestOfLove.InteractionUiController::ListenForAdventureInteraction()
IL_002e: ret
METHOD System.Void TheForestOfLove.InteractionUiController::UpdateAvailableOptions() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.InteractionUiController::UpdateAvailableOptions(System.Boolean)
IL_0007: ret
METHOD System.Void TheForestOfLove.InteractionUiController::UpdateAvailableOptions(System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0006: brtrue.s IL_0039
IL_0008: ldarg.0
IL_0009: call System.Boolean TheForestOfLove.InteractionUiController::get_isAuthority()
IL_000e: ldc.i4.0
IL_000f: ceq
IL_0011: ldarg.1
IL_0012: and
IL_0013: brtrue.s IL_0039
IL_0015: ldarg.0
IL_0016: ldnull
IL_0017: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_001c: brtrue.s IL_0039
IL_001e: ldarg.0
IL_001f: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0024: ldnull
IL_0025: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_002a: brtrue.s IL_0039
IL_002c: ldarg.0
IL_002d: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0032: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0037: brtrue.s IL_003a
IL_0039: ret
IL_003a: ldarg.0
IL_003b: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_0040: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Clear()
IL_0045: ldloca.s V_0
IL_0047: initobj System.Nullable`1<TheForestOfLove.InteractionUiOption>
IL_004d: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.StoryManager>()
IL_0052: stloc.1
IL_0053: ldloc.1
IL_0054: ldnull
IL_0055: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_005a: brfalse.s IL_005d
IL_005c: ret
IL_005d: ldarg.0
IL_005e: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiController::character
IL_0063: ldnull
IL_0064: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0069: brtrue.s IL_006e
IL_006b: ldnull
IL_006c: br.s IL_0079
IL_006e: ldarg.0
IL_006f: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiController::character
IL_0074: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_0079: stloc.2
IL_007a: ldloc.2
IL_007b: brtrue.s IL_00a0
IL_007d: ldarg.0
IL_007e: ldfld System.Boolean TheForestOfLove.InteractionUiController::alwaysAllowExamine
IL_0083: brfalse.s IL_009f
IL_0085: ldarg.0
IL_0086: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_008b: ldc.i4.3
IL_008c: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Contains(!0)
IL_0091: brtrue.s IL_009f
IL_0093: ldarg.0
IL_0094: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_0099: ldc.i4.3
IL_009a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_009f: ret
IL_00a0: ldarg.0
IL_00a1: ldfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_00a6: ldnull
IL_00a7: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00ac: stloc.3
IL_00ad: ldarg.0
IL_00ae: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_00b3: ldc.i4.0
IL_00b4: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Contains(!0)
IL_00b9: brtrue.s IL_00d4
IL_00bb: ldarg.0
IL_00bc: ldfld System.Boolean TheForestOfLove.InteractionUiController::injectFastTravelReinitiationConversation
IL_00c1: brfalse.s IL_00d4
IL_00c3: ldarg.0
IL_00c4: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_00c9: ldc.i4.0
IL_00ca: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_00cf: br IL_0188
IL_00d4: ldloc.1
IL_00d5: ldloc.2
IL_00d6: ldc.i4.0
IL_00d7: ldloc.3
IL_00d8: brtrue.s IL_00dd
IL_00da: ldnull
IL_00db: br.s IL_00e8
IL_00dd: ldarg.0
IL_00de: ldfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_00e3: callvirt System.String TheForestOfLove.Interaction.DialogueInteractionTrigger::get_dialogueDbName()
IL_00e8: ldloc.3
IL_00e9: brtrue.s IL_00ee
IL_00eb: ldnull
IL_00ec: br.s IL_00f9
IL_00ee: ldarg.0
IL_00ef: ldfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_00f4: callvirt System.String TheForestOfLove.Interaction.DialogueInteractionTrigger::get_arcDbName()
IL_00f9: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasAvailableMessages(System.String,TheForestOfLove.Narrative.QuestManagerInteractionMode,System.String,System.String)
IL_00fe: brtrue.s IL_017c
IL_0100: ldloc.1
IL_0101: ldloc.2
IL_0102: ldarg.0
IL_0103: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.InteractionUiController::forcePushSettings
IL_0108: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasQuestIdleMessages(System.String,TheForestOfLove.Gameplay.DynamicConversationCustomTrigger)
IL_010d: brtrue.s IL_017c
IL_010f: ldloc.1
IL_0110: ldloc.2
IL_0111: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasNewGift(System.String)
IL_0116: brtrue.s IL_017c
IL_0118: ldarg.0
IL_0119: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.InteractionUiController::forcePushSettings
IL_011e: ldnull
IL_011f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0124: brfalse.s IL_0135
IL_0126: ldloc.1
IL_0127: ldloc.2
IL_0128: ldarg.0
IL_0129: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.InteractionUiController::forcePushSettings
IL_012e: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasIdleMessages(System.String,TheForestOfLove.Gameplay.DynamicConversationCustomTrigger)
IL_0133: brtrue.s IL_017c
IL_0135: ldarg.0
IL_0136: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.InteractionUiController::forcePushSettings
IL_013b: ldnull
IL_013c: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0141: brfalse.s IL_0188
IL_0143: ldloc.1
IL_0144: ldloc.2
IL_0145: ldloc.3
IL_0146: brtrue.s IL_014b
IL_0148: ldnull
IL_0149: br.s IL_0156
IL_014b: ldarg.0
IL_014c: ldfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_0151: callvirt System.String TheForestOfLove.Interaction.DialogueInteractionTrigger::get_dialogueDbName()
IL_0156: ldloc.3
IL_0157: brtrue.s IL_015c
IL_0159: ldnull
IL_015a: br.s IL_0167
IL_015c: ldarg.0
IL_015d: ldfld TheForestOfLove.Interaction.DialogueInteractionTrigger TheForestOfLove.InteractionUiController::dialogueInteractionTrigger
IL_0162: callvirt System.String TheForestOfLove.Interaction.DialogueInteractionTrigger::get_arcDbName()
IL_0167: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasIdleMessages(System.String,System.String,System.String)
IL_016c: brfalse.s IL_0188
IL_016e: ldarg.0
IL_016f: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_0174: ldc.i4.0
IL_0175: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Contains(!0)
IL_017a: brtrue.s IL_0188
IL_017c: ldarg.0
IL_017d: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_0182: ldc.i4.0
IL_0183: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_0188: ldloc.1
IL_0189: ldloc.2
IL_018a: ldc.i4.1
IL_018b: ldnull
IL_018c: ldnull
IL_018d: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasAvailableMessages(System.String,TheForestOfLove.Narrative.QuestManagerInteractionMode,System.String,System.String)
IL_0192: brfalse.s IL_01b6
IL_0194: ldarg.0
IL_0195: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_019a: ldc.i4.1
IL_019b: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Contains(!0)
IL_01a0: brtrue.s IL_01b6
IL_01a2: ldarg.0
IL_01a3: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_01a8: ldc.i4.1
IL_01a9: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_01ae: ldloca.s V_0
IL_01b0: ldc.i4.1
IL_01b1: call System.Void System.Nullable`1<TheForestOfLove.InteractionUiOption>::.ctor(!0)
IL_01b6: ldloc.1
IL_01b7: ldloc.2
IL_01b8: ldc.i4.2
IL_01b9: ldnull
IL_01ba: ldnull
IL_01bb: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasAvailableMessages(System.String,TheForestOfLove.Narrative.QuestManagerInteractionMode,System.String,System.String)
IL_01c0: brfalse.s IL_01dc
IL_01c2: ldarg.0
IL_01c3: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_01c8: ldc.i4.2
IL_01c9: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Contains(!0)
IL_01ce: brtrue.s IL_01dc
IL_01d0: ldarg.0
IL_01d1: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_01d6: ldc.i4.2
IL_01d7: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_01dc: ldarg.0
IL_01dd: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_01e2: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Count()
IL_01e7: brtrue.s IL_01fd
IL_01e9: ldarg.0
IL_01ea: ldfld System.Boolean TheForestOfLove.InteractionUiController::alwaysAllowTalk
IL_01ef: brfalse.s IL_01fd
IL_01f1: ldarg.0
IL_01f2: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_01f7: ldc.i4.0
IL_01f8: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_01fd: ldarg.0
IL_01fe: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_0203: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Count()
IL_0208: brtrue.s IL_022c
IL_020a: ldarg.0
IL_020b: ldfld System.Boolean TheForestOfLove.InteractionUiController::alwaysAllowExamine
IL_0210: brfalse.s IL_022c
IL_0212: ldarg.0
IL_0213: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::disallowedOptions
IL_0218: ldc.i4.3
IL_0219: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Contains(!0)
IL_021e: brtrue.s IL_022c
IL_0220: ldarg.0
IL_0221: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_0226: ldc.i4.3
IL_0227: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_022c: ldarg.0
IL_022d: ldarg.0
IL_022e: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_0233: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Count()
IL_0238: ldc.i4.0
IL_0239: bgt.s IL_0247
IL_023b: ldloca.s V_4
IL_023d: initobj System.Nullable`1<TheForestOfLove.InteractionUiOption>
IL_0243: ldloc.s V_4
IL_0245: br.s IL_026d
IL_0247: ldloc.0
IL_0248: stloc.s V_4
IL_024a: ldloca.s V_4
IL_024c: call System.Boolean System.Nullable`1<TheForestOfLove.InteractionUiOption>::get_HasValue()
IL_0251: brtrue.s IL_0261
IL_0253: ldarg.0
IL_0254: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_0259: ldc.i4.0
IL_025a: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Item(System.Int32)
IL_025f: br.s IL_0268
IL_0261: ldloca.s V_4
IL_0263: call !0 System.Nullable`1<TheForestOfLove.InteractionUiOption>::GetValueOrDefault()
IL_0268: newobj System.Void System.Nullable`1<TheForestOfLove.InteractionUiOption>::.ctor(!0)
IL_026d: stfld System.Nullable`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::firstSelectedOption
IL_0272: ldarg.0
IL_0273: ldarg.0
IL_0274: ldfld TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUiController::lastSelectedOption
IL_0279: ldc.i4.2
IL_027a: bne.un.s IL_028a
IL_027c: ldarg.0
IL_027d: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_0282: ldc.i4.2
IL_0283: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Contains(!0)
IL_0288: brtrue.s IL_0292
IL_028a: ldarg.0
IL_028b: ldfld System.Nullable`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::firstSelectedOption
IL_0290: br.s IL_0298
IL_0292: ldc.i4.2
IL_0293: newobj System.Void System.Nullable`1<TheForestOfLove.InteractionUiOption>::.ctor(!0)
IL_0298: stfld System.Nullable`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::firstSelectedOption
IL_029d: ldarg.0
IL_029e: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.InteractionUiController::onOptionsUpdated
IL_02a3: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_02a8: ret
METHOD System.Boolean TheForestOfLove.InteractionUiController::CanShow() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0005: ldc.i4.0
IL_0006: ceq
IL_0008: ret
METHOD System.Void TheForestOfLove.InteractionUiController::Show() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.InteractionUiController::get_isVisible()
IL_0005: brtrue.s IL_000f
IL_0007: ldarg.0
IL_0008: call System.Boolean TheForestOfLove.InteractionUiController::get_isAuthority()
IL_000d: brtrue.s IL_0010
IL_000f: ret
IL_0010: ldc.i4.1
IL_0011: call System.Void TheForestOfLove.InteractionUiController::set_isVisible(System.Boolean)
IL_0016: ldarg.0
IL_0017: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_001c: callvirt System.Void TheForestOfLove.InteractionUi::Show()
IL_0021: ret
METHOD System.Void TheForestOfLove.InteractionUiController::Hide() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.InteractionUiController::get_isVisible()
IL_0005: brfalse.s IL_000f
IL_0007: ldarg.0
IL_0008: call System.Boolean TheForestOfLove.InteractionUiController::get_isAuthority()
IL_000d: brtrue.s IL_0010
IL_000f: ret
IL_0010: ldc.i4.0
IL_0011: call System.Void TheForestOfLove.InteractionUiController::set_isVisible(System.Boolean)
IL_0016: ldarg.0
IL_0017: ldfld TheForestOfLove.InteractionUi TheForestOfLove.InteractionUiController::interactionUi
IL_001c: callvirt System.Void TheForestOfLove.InteractionUi::Hide()
IL_0021: ret
METHOD System.Void TheForestOfLove.InteractionUiController::OnInterationOptionSelected(TheForestOfLove.InteractionUiOption) | attributes=Private, HideBySig | impl=IL
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
