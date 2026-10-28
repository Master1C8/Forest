TYPE TheForestOfLove.ItemPowerup
METHOD System.Void TheForestOfLove.ItemPowerup::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.ItemPowerup::set_allowPickingUp(System.Boolean)
IL_0007: ldarg.0
IL_0008: ldarg.0
IL_0009: call !!0 UnityEngine.Component::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_000e: stfld TheForestOfLove.AnimationStateEventListener TheForestOfLove.ItemPowerup::animationStateEventListener
IL_0013: ldarg.0
IL_0014: ldfld TheForestOfLove.AnimationStateEventListener TheForestOfLove.ItemPowerup::animationStateEventListener
IL_0019: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipEnded
IL_001e: ldarg.0
IL_001f: ldftn System.Void TheForestOfLove.ItemPowerup::onClipEnded(System.String)
IL_0025: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_002a: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_002f: ldarg.0
IL_0030: ldarg.0
IL_0031: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_0036: stfld UnityEngine.Animator TheForestOfLove.ItemPowerup::animator
IL_003b: ldarg.0
IL_003c: ldfld UnityEngine.Animator TheForestOfLove.ItemPowerup::animator
IL_0041: call System.Single UnityEngine.Random::get_value()
IL_0046: call System.Void TheForestOfLove.GeneralExtensions::Scrub(UnityEngine.Animator,System.Single)
IL_004b: ldarg.0
IL_004c: ldsfld System.String TheForestOfLove.ItemPowerup::SAVEKEY_PREFIX
IL_0051: ldarg.0
IL_0052: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0057: callvirt System.String UnityEngine.Object::get_name()
IL_005c: call System.String System.String::Concat(System.String,System.String)
IL_0061: stfld System.String TheForestOfLove.ItemPowerup::saveKey
IL_0066: ldarg.0
IL_0067: ldfld System.String TheForestOfLove.ItemPowerup::saveKey
IL_006c: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0071: brfalse.s IL_0079
IL_0073: ldarg.0
IL_0074: call System.Void TheForestOfLove.ItemPowerup::SelfDestruct()
IL_0079: ldarg.0
IL_007a: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_007f: stloc.0
IL_0080: ldloc.0
IL_0081: ldc.i4 180
IL_0086: bgt.s IL_00a1
IL_0088: ldloc.0
IL_0089: ldc.i4.s 60
IL_008b: beq.s IL_00c3
IL_008d: ldloc.0
IL_008e: ldc.i4.s 90
IL_0090: beq IL_0170
IL_0095: ldloc.0
IL_0096: ldc.i4 180
IL_009b: beq IL_015d
IL_00a0: ret
IL_00a1: ldloc.0
IL_00a2: ldc.i4 370
IL_00a7: beq IL_0183
IL_00ac: ldloc.0
IL_00ad: ldc.i4 380
IL_00b2: beq IL_0196
IL_00b7: ldloc.0
IL_00b8: ldc.i4 420
IL_00bd: beq IL_01a9
IL_00c2: ret
IL_00c3: ldstr "ITEMPOWERUP_act1/gatorWoodStack"
IL_00c8: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_00cd: brtrue.s IL_014a
IL_00cf: ldarg.0
IL_00d0: ldfld System.String TheForestOfLove.ItemPowerup::saveKey
IL_00d5: ldstr "ITEMPOWERUP_ShorelineWood_13"
IL_00da: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00df: brtrue IL_01bb
IL_00e4: ldarg.0
IL_00e5: ldfld System.String TheForestOfLove.ItemPowerup::saveKey
IL_00ea: ldstr "ITEMPOWERUP_ShorelineWood_14"
IL_00ef: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00f4: brtrue IL_01bb
IL_00f9: ldarg.0
IL_00fa: ldfld System.String TheForestOfLove.ItemPowerup::saveKey
IL_00ff: ldstr "ITEMPOWERUP_ShorelineWood_15"
IL_0104: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0109: brtrue IL_01bb
IL_010e: ldarg.0
IL_010f: ldfld System.String TheForestOfLove.ItemPowerup::saveKey
IL_0114: ldstr "ITEMPOWERUP_ShorelineWood_16"
IL_0119: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_011e: brtrue IL_01bb
IL_0123: ldarg.0
IL_0124: ldfld System.String TheForestOfLove.ItemPowerup::saveKey
IL_0129: ldstr "ITEMPOWERUP_ShorelineWood_17"
IL_012e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0133: brtrue IL_01bb
IL_0138: ldarg.0
IL_0139: ldfld System.String TheForestOfLove.ItemPowerup::saveKey
IL_013e: ldstr "ITEMPOWERUP_ShorelineWood_18"
IL_0143: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0148: brtrue.s IL_01bb
IL_014a: ldstr "collected_enough_wood"
IL_014f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0154: brfalse.s IL_01bb
IL_0156: ldarg.0
IL_0157: call System.Void TheForestOfLove.ItemPowerup::SelfDestruct()
IL_015c: ret
IL_015d: ldstr "found_blue_fast_travel_bell"
IL_0162: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0167: brfalse.s IL_01bb
IL_0169: ldarg.0
IL_016a: call System.Void TheForestOfLove.ItemPowerup::SelfDestruct()
IL_016f: ret
IL_0170: ldstr "collected_apples"
IL_0175: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_017a: brfalse.s IL_01bb
IL_017c: ldarg.0
IL_017d: call System.Void TheForestOfLove.ItemPowerup::SelfDestruct()
IL_0182: ret
IL_0183: ldstr "finleyquest_receive_finley_stuff"
IL_0188: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_018d: brfalse.s IL_01bb
IL_018f: ldarg.0
IL_0190: call System.Void TheForestOfLove.ItemPowerup::SelfDestruct()
IL_0195: ret
IL_0196: ldstr "melody_photoshoot_pick_up_camera"
IL_019b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_01a0: brfalse.s IL_01bb
IL_01a2: ldarg.0
IL_01a3: call System.Void TheForestOfLove.ItemPowerup::SelfDestruct()
IL_01a8: ret
IL_01a9: ldstr "StormQuest_MabelGrabbedTheLastPage"
IL_01ae: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01b3: brfalse.s IL_01bb
IL_01b5: ldarg.0
IL_01b6: call System.Void TheForestOfLove.ItemPowerup::SelfDestruct()
IL_01bb: ret
METHOD System.Void TheForestOfLove.ItemPowerup::ActivateTrigger() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.ItemPowerup::triggered
IL_0006: brtrue.s IL_0018
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean TheForestOfLove.ItemPowerup::destroyed
IL_000e: brtrue.s IL_0018
IL_0010: ldarg.0
IL_0011: call System.Boolean TheForestOfLove.ItemPowerup::get_allowPickingUp()
IL_0016: brtrue.s IL_0019
IL_0018: ret
IL_0019: ldarg.0
IL_001a: ldc.i4.1
IL_001b: stfld System.Boolean TheForestOfLove.ItemPowerup::triggered
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.Animator TheForestOfLove.ItemPowerup::animator
IL_0026: ldsfld System.String TheForestOfLove.ItemPowerup::TRIGGER_NAME_FADEOUT
IL_002b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0030: ldc.i4 200
IL_0035: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_003a: ldarg.0
IL_003b: ldfld System.String TheForestOfLove.ItemPowerup::saveKey
IL_0040: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0045: ldarg.0
IL_0046: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_004b: ldc.i4 430
IL_0050: beq.s IL_005d
IL_0052: ldarg.0
IL_0053: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_0058: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_005d: ldarg.0
IL_005e: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_0063: ldc.i4.s 60
IL_0065: bne.un.s IL_006e
IL_0067: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnPickedUpAtLeastOnePieceOfWood()
IL_006c: br.s IL_00e7
IL_006e: ldarg.0
IL_006f: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_0074: ldc.i4 180
IL_0079: bne.un.s IL_009c
IL_007b: call System.Void TheForestOfLove.Content.LakeSpawner::RefreshFastTravelPerch()
IL_0080: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ItemGetNotification>()
IL_0085: stloc.0
IL_0086: ldloc.0
IL_0087: ldnull
IL_0088: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_008d: brfalse.s IL_0095
IL_008f: ldloc.0
IL_0090: callvirt System.Void TheForestOfLove.ItemGetNotification::ShowLakeBellNotification()
IL_0095: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnFoundBlueFastTravelBell()
IL_009a: br.s IL_00e7
IL_009c: ldarg.0
IL_009d: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_00a2: ldc.i4.s 90
IL_00a4: bne.un.s IL_00ad
IL_00a6: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::OnPickedUpApple()
IL_00ab: br.s IL_00e7
IL_00ad: ldarg.0
IL_00ae: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_00b3: ldc.i4 140
IL_00b8: bne.un.s IL_00c1
IL_00ba: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::OnPickedUpPackage()
IL_00bf: br.s IL_00e7
IL_00c1: ldarg.0
IL_00c2: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_00c7: ldc.i4 370
IL_00cc: bne.un.s IL_00d5
IL_00ce: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnPickedUpFinleyStuff()
IL_00d3: br.s IL_00e7
IL_00d5: ldarg.0
IL_00d6: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_00db: ldc.i4 380
IL_00e0: bne.un.s IL_00e7
IL_00e2: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnPickedUpPhotoshootCamera()
IL_00e7: ldarg.0
IL_00e8: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_00ed: ldc.i4.s 60
IL_00ef: bne.un.s IL_0106
IL_00f1: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.WoodCollectionUIController>()
IL_00f6: stloc.1
IL_00f7: ldloc.1
IL_00f8: ldnull
IL_00f9: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00fe: brfalse.s IL_0106
IL_0100: ldloc.1
IL_0101: callvirt System.Void TheForestOfLove.WoodCollectionUIController::OnCollectedWood()
IL_0106: ldarg.0
IL_0107: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_010c: ldc.i4 420
IL_0111: bne.un.s IL_0118
IL_0113: call System.Void TheForestOfLove.StormQuestFinalStuckPageCutscene::OnPickedUpStuckPagePowerup()
IL_0118: ldarg.0
IL_0119: ldfld TheForestOfLove.Inventory.InventoryItemType TheForestOfLove.ItemPowerup::itemType
IL_011e: ldc.i4 430
IL_0123: bne.un.s IL_012a
IL_0125: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnCollectedFirefly()
IL_012a: ret
METHOD System.Void TheForestOfLove.ItemPowerup::onClipEnded(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldsfld System.String TheForestOfLove.ItemPowerup::CLIP_NAME_FADEOUT
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_0024
IL_000d: ldarg.0
IL_000e: ldfld System.Action TheForestOfLove.ItemPowerup::onPickedUp
IL_0013: dup
IL_0014: brtrue.s IL_0019
IL_0016: pop
IL_0017: br.s IL_001e
IL_0019: callvirt System.Void System.Action::Invoke()
IL_001e: ldarg.0
IL_001f: call System.Void TheForestOfLove.ItemPowerup::SelfDestruct()
IL_0024: ret
