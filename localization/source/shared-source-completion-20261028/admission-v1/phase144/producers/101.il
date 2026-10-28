TYPE TheForestOfLove.InteractionUiStatusIconController
METHOD System.Void TheForestOfLove.InteractionUiStatusIconController::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.InteractionUiStatusIconController::playerInRange
IL_0006: brfalse.s IL_0034
IL_0008: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_000d: brfalse.s IL_001f
IL_000f: ldarg.0
IL_0010: ldc.i4.1
IL_0011: call System.Void TheForestOfLove.InteractionUiStatusIconController::HideAllIcons(System.Boolean)
IL_0016: ldarg.0
IL_0017: ldc.i4.1
IL_0018: stfld System.Boolean TheForestOfLove.InteractionUiStatusIconController::refreshIconsAfterEvent
IL_001d: br.s IL_0034
IL_001f: ldarg.0
IL_0020: ldfld System.Boolean TheForestOfLove.InteractionUiStatusIconController::refreshIconsAfterEvent
IL_0025: brfalse.s IL_0034
IL_0027: ldarg.0
IL_0028: ldc.i4.0
IL_0029: stfld System.Boolean TheForestOfLove.InteractionUiStatusIconController::refreshIconsAfterEvent
IL_002e: ldarg.0
IL_002f: call System.Void TheForestOfLove.InteractionUiStatusIconController::ChooseVisibleIcons()
IL_0034: ldarg.0
IL_0035: ldfld System.Single TheForestOfLove.InteractionUiStatusIconController::secondsSinceLastPlayerScreenCheck
IL_003a: ldc.r4 0
IL_003f: bgt.un IL_01b1
IL_0044: ldarg.0
IL_0045: ldarg.0
IL_0046: ldfld System.Single TheForestOfLove.InteractionUiStatusIconController::playerScreenCheckFrequencySeconds
IL_004b: stfld System.Single TheForestOfLove.InteractionUiStatusIconController::secondsSinceLastPlayerScreenCheck
IL_0050: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0055: ldnull
IL_0056: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_005b: brfalse.s IL_008a
IL_005d: ldarg.0
IL_005e: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiStatusIconController::character
IL_0063: ldnull
IL_0064: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0069: brfalse.s IL_008a
IL_006b: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0070: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_0075: ldarg.0
IL_0076: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiStatusIconController::character
IL_007b: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_0080: call System.Boolean TheForestOfLove.Utility.PositionHelper::IsPositionOffscreen(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0085: ldc.i4.0
IL_0086: ceq
IL_0088: br.s IL_008b
IL_008a: ldc.i4.0
IL_008b: brfalse IL_01a5
IL_0090: ldc.i4.0
IL_0091: stloc.0
IL_0092: ldarg.0
IL_0093: call TheForestOfLove.Narrative.StoryManager TheForestOfLove.InteractionUiStatusIconController::get_StoryManager()
IL_0098: ldnull
IL_0099: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_009e: brfalse IL_01b1
IL_00a3: ldarg.0
IL_00a4: ldfld TheForestOfLove.InteractionUiController TheForestOfLove.InteractionUiStatusIconController::interactionUiController
IL_00a9: callvirt System.Boolean TheForestOfLove.InteractionUiController::get_isAuthority()
IL_00ae: brfalse.s IL_00ce
IL_00b0: ldarg.0
IL_00b1: ldfld TheForestOfLove.InteractionUiController TheForestOfLove.InteractionUiStatusIconController::interactionUiController
IL_00b6: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiController::availableOptions
IL_00bb: ldc.i4.1
IL_00bc: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Contains(!0)
IL_00c1: brfalse.s IL_00ce
IL_00c3: ldarg.0
IL_00c4: ldfld TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUiStatusIconController::lastSelectedOption
IL_00c9: ldc.i4.0
IL_00ca: ceq
IL_00cc: br.s IL_00cf
IL_00ce: ldc.i4.0
IL_00cf: stloc.1
IL_00d0: ldloc.0
IL_00d1: ldloc.1
IL_00d2: brtrue.s IL_00f2
IL_00d4: ldarg.0
IL_00d5: call TheForestOfLove.Narrative.StoryManager TheForestOfLove.InteractionUiStatusIconController::get_StoryManager()
IL_00da: ldarg.0
IL_00db: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiStatusIconController::character
IL_00e0: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_00e5: ldc.i4.1
IL_00e6: ldnull
IL_00e7: ldnull
IL_00e8: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasAvailableMessages(System.String,TheForestOfLove.Narrative.QuestManagerInteractionMode,System.String,System.String)
IL_00ed: ldnull
IL_00ee: cgt.un
IL_00f0: br.s IL_00f3
IL_00f2: ldc.i4.0
IL_00f3: or
IL_00f4: stloc.0
IL_00f5: ldloc.0
IL_00f6: ldarg.0
IL_00f7: call TheForestOfLove.Narrative.StoryManager TheForestOfLove.InteractionUiStatusIconController::get_StoryManager()
IL_00fc: ldarg.0
IL_00fd: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiStatusIconController::character
IL_0102: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_0107: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasNewMainQuest(System.String)
IL_010c: ldnull
IL_010d: cgt.un
IL_010f: or
IL_0110: stloc.0
IL_0111: ldloc.0
IL_0112: ldarg.0
IL_0113: call TheForestOfLove.Narrative.StoryManager TheForestOfLove.InteractionUiStatusIconController::get_StoryManager()
IL_0118: ldarg.0
IL_0119: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiStatusIconController::character
IL_011e: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_0123: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasNewSideQuest(System.String)
IL_0128: ldnull
IL_0129: cgt.un
IL_012b: or
IL_012c: stloc.0
IL_012d: ldloc.0
IL_012e: ldarg.0
IL_012f: call TheForestOfLove.Narrative.StoryManager TheForestOfLove.InteractionUiStatusIconController::get_StoryManager()
IL_0134: ldarg.0
IL_0135: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiStatusIconController::character
IL_013a: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_013f: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasQuestToTurnIn(System.String)
IL_0144: brtrue.s IL_0164
IL_0146: ldarg.0
IL_0147: call TheForestOfLove.Narrative.StoryManager TheForestOfLove.InteractionUiStatusIconController::get_StoryManager()
IL_014c: ldarg.0
IL_014d: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiStatusIconController::character
IL_0152: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_0157: ldc.i4.0
IL_0158: ldnull
IL_0159: ldnull
IL_015a: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasAvailableMessages(System.String,TheForestOfLove.Narrative.QuestManagerInteractionMode,System.String,System.String)
IL_015f: ldnull
IL_0160: cgt.un
IL_0162: br.s IL_0165
IL_0164: ldc.i4.1
IL_0165: or
IL_0166: stloc.0
IL_0167: ldloc.0
IL_0168: brtrue.s IL_01b1
IL_016a: ldarg.0
IL_016b: call TheForestOfLove.Narrative.StoryManager TheForestOfLove.InteractionUiStatusIconController::get_StoryManager()
IL_0170: ldarg.0
IL_0171: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.InteractionUiStatusIconController::character
IL_0176: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_017b: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasNewGift(System.String)
IL_0180: brfalse.s IL_01b1
IL_0182: ldarg.0
IL_0183: ldsfld System.String System.String::Empty
IL_0188: call System.Void TheForestOfLove.InteractionUiStatusIconController::UpdateGiftIconText(System.String)
IL_018d: ldarg.0
IL_018e: ldstr "Hey Rascal!"
IL_0193: call System.Void TheForestOfLove.InteractionUiStatusIconController::UpdateGiftIconText(System.String)
IL_0198: ldarg.0
IL_0199: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.InteractionUiStatusIconController::giftIcon
IL_019e: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::Show()
IL_01a3: br.s IL_01b1
IL_01a5: ldarg.0
IL_01a6: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.InteractionUiStatusIconController::giftIcon
IL_01ab: ldc.i4.0
IL_01ac: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::Hide(System.Boolean)
IL_01b1: ldarg.0
IL_01b2: ldarg.0
IL_01b3: ldfld System.Single TheForestOfLove.InteractionUiStatusIconController::secondsSinceLastPlayerScreenCheck
IL_01b8: call System.Single UnityEngine.Time::get_deltaTime()
IL_01bd: sub
IL_01be: stfld System.Single TheForestOfLove.InteractionUiStatusIconController::secondsSinceLastPlayerScreenCheck
IL_01c3: ret
METHOD System.Void TheForestOfLove.InteractionUiStatusIconController::ChooseAndShowNewGiftIcon(TheForestOfLove.Narrative.Dialogue) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld TheForestOfLove.InteractionUiStatusIconProfileType TheForestOfLove.Narrative.Dialogue::interactionUiStatusIconProfileType
IL_0006: ldc.i4.s 50
IL_0008: bne.un.s IL_000b
IL_000a: ret
IL_000b: ldarg.0
IL_000c: ldsfld System.String System.String::Empty
IL_0011: call System.Void TheForestOfLove.InteractionUiStatusIconController::UpdateGiftIconText(System.String)
IL_0016: ldarg.0
IL_0017: ldstr "Hey Rascal!"
IL_001c: call System.Void TheForestOfLove.InteractionUiStatusIconController::UpdateGiftIconText(System.String)
IL_0021: ldarg.0
IL_0022: ldfld TheForestOfLove.InteractionUiStatusIcon TheForestOfLove.InteractionUiStatusIconController::giftIcon
IL_0027: callvirt System.Void TheForestOfLove.InteractionUiStatusIcon::Show()
IL_002c: ret
