TYPE TheForestOfLove.QuestLogDetailsPane
METHOD System.Void TheForestOfLove.QuestLogDetailsPane::UpdateSelectedQuest(TheForestOfLove.Narrative.Quest)
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory4Back
IL_0006: ldsfld System.String System.String::Empty
IL_000b: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory4BackBullet
IL_0016: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001b: ldc.i4.0
IL_001c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0021: ldarg.1
IL_0022: brtrue IL_00ec
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::portrait
IL_002d: ldnull
IL_002e: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_0033: ldarg.0
IL_0034: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::title
IL_0039: ldsfld System.String System.String::Empty
IL_003e: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0043: ldarg.0
IL_0044: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::description
IL_0049: ldsfld System.String System.String::Empty
IL_004e: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0053: ldarg.0
IL_0054: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistoryCurrent
IL_0059: ldsfld System.String System.String::Empty
IL_005e: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_0069: ldsfld System.String System.String::Empty
IL_006e: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0073: ldarg.0
IL_0074: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory1BackBullet
IL_0079: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_007e: ldc.i4.0
IL_007f: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0084: ldarg.0
IL_0085: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_008a: ldsfld System.String System.String::Empty
IL_008f: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0094: ldarg.0
IL_0095: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory2BackBullet
IL_009a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_009f: ldc.i4.0
IL_00a0: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00a5: ldarg.0
IL_00a6: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory3Back
IL_00ab: ldsfld System.String System.String::Empty
IL_00b0: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_00b5: ldarg.0
IL_00b6: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory3BackBullet
IL_00bb: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00c0: ldc.i4.0
IL_00c1: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00c6: ldarg.0
IL_00c7: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory4Back
IL_00cc: ldsfld System.String System.String::Empty
IL_00d1: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_00d6: ldarg.0
IL_00d7: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory4BackBullet
IL_00dc: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00e1: ldc.i4.0
IL_00e2: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00e7: br IL_0959
IL_00ec: ldarg.1
IL_00ed: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_00f2: ldstr "Act3_AfterstormQuest"
IL_00f7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00fc: brfalse IL_0372
IL_0101: ldarg.0
IL_0102: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory3Back
IL_0107: ldsfld System.String System.String::Empty
IL_010c: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0111: ldarg.0
IL_0112: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory3BackBullet
IL_0117: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_011c: ldc.i4.0
IL_011d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0122: ldc.i4.1
IL_0123: stloc.0
IL_0124: ldloc.0
IL_0125: ldstr "AfterstormQuest_Finley"
IL_012a: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_012f: and
IL_0130: stloc.0
IL_0131: ldloc.0
IL_0132: ldstr "AfterstormQuest_Charlotte"
IL_0137: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_013c: and
IL_013d: stloc.0
IL_013e: ldloc.0
IL_013f: ldstr "AfterstormQuest_Melody"
IL_0144: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0149: and
IL_014a: stloc.0
IL_014b: ldc.i4.1
IL_014c: stloc.1
IL_014d: ldloc.1
IL_014e: ldstr "AfterstormQuest_Oliver"
IL_0153: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0158: and
IL_0159: stloc.1
IL_015a: ldloc.1
IL_015b: ldstr "AfterstormQuest_Coyotes"
IL_0160: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0165: and
IL_0166: stloc.1
IL_0167: ldc.i4.1
IL_0168: stloc.2
IL_0169: ldloc.2
IL_016a: ldstr "AfterstormQuest_Augustus"
IL_016f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0174: and
IL_0175: stloc.2
IL_0176: ldc.i4.1
IL_0177: stloc.3
IL_0178: ldloc.3
IL_0179: ldstr "AfterstormQuest_ScarlettAndPeter"
IL_017e: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0183: and
IL_0184: stloc.3
IL_0185: ldloc.3
IL_0186: ldstr "AfterstormQuest_Bucky"
IL_018b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0190: and
IL_0191: stloc.3
IL_0192: ldloc.3
IL_0193: ldstr "AfterstormQuest_Dustin"
IL_0198: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_019d: and
IL_019e: stloc.3
IL_019f: ldloc.3
IL_01a0: ldstr "AfterstormQuest_Maverick"
IL_01a5: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01aa: and
IL_01ab: stloc.3
IL_01ac: ldc.i4.1
IL_01ad: stloc.s V_4
IL_01af: ldloc.s V_4
IL_01b1: ldstr "AfterstormQuest_Penny"
IL_01b6: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01bb: and
IL_01bc: stloc.s V_4
IL_01be: ldnull
IL_01bf: stloc.s V_5
IL_01c1: ldnull
IL_01c2: stloc.s V_6
IL_01c4: ldnull
IL_01c5: stloc.s V_7
IL_01c7: ldloc.0
IL_01c8: brtrue.s IL_01fe
IL_01ca: ldloc.1
IL_01cb: brtrue.s IL_01fe
IL_01cd: ldloc.2
IL_01ce: brtrue.s IL_01fe
IL_01d0: ldloc.3
IL_01d1: brtrue.s IL_01fe
IL_01d3: ldloc.s V_4
IL_01d5: brtrue.s IL_01fe
IL_01d7: ldstr "Act3_AfterstormQuest_1"
IL_01dc: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_01e1: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_01e6: stloc.s V_6
IL_01e8: ldstr "Act3_AfterstormQuest_2"
IL_01ed: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_01f2: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_01f7: stloc.s V_7
IL_01f9: br IL_029c
IL_01fe: ldstr "More critters {0}{1}{2}{3}{4}."
IL_0203: ldc.i4.5
IL_0204: newarr System.Object
IL_0209: dup
IL_020a: ldc.i4.0
IL_020b: ldloc.0
IL_020c: brtrue.s IL_0215
IL_020e: ldstr "North, "
IL_0213: br.s IL_021a
IL_0215: ldsfld System.String System.String::Empty
IL_021a: stelem.ref
IL_021b: dup
IL_021c: ldc.i4.1
IL_021d: ldloc.1
IL_021e: brtrue.s IL_0227
IL_0220: ldstr "South, "
IL_0225: br.s IL_022c
IL_0227: ldsfld System.String System.String::Empty
IL_022c: stelem.ref
IL_022d: dup
IL_022e: ldc.i4.2
IL_022f: ldloc.2
IL_0230: brtrue.s IL_0239
IL_0232: ldstr "West, "
IL_0237: br.s IL_023e
IL_0239: ldsfld System.String System.String::Empty
IL_023e: stelem.ref
IL_023f: dup
IL_0240: ldc.i4.3
IL_0241: ldloc.3
IL_0242: brtrue.s IL_024b
IL_0244: ldstr "Central, "
IL_0249: br.s IL_0250
IL_024b: ldsfld System.String System.String::Empty
IL_0250: stelem.ref
IL_0251: dup
IL_0252: ldc.i4.4
IL_0253: ldloc.s V_4
IL_0255: brtrue.s IL_025e
IL_0257: ldstr "Perch, "
IL_025c: br.s IL_0263
IL_025e: ldsfld System.String System.String::Empty
IL_0263: stelem.ref
IL_0264: call System.String System.String::Format(System.String,System.Object[])
IL_0269: ldstr ", ."
IL_026e: ldstr "."
IL_0273: callvirt System.String System.String::Replace(System.String,System.String)
IL_0278: ldstr "Act3_AfterstormQuest_1"
IL_027d: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0282: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_0287: stloc.s V_5
IL_0289: ldstr "Act3_AfterstormQuest_2"
IL_028e: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0293: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_0298: stloc.s V_6
IL_029a: stloc.s V_7
IL_029c: ldarg.1
IL_029d: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_02a2: ldc.i4 200
IL_02a7: bne.un.s IL_02b0
IL_02a9: ldstr "[Quest Completed]"
IL_02ae: stloc.s V_7
IL_02b0: ldarg.0
IL_02b1: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::portrait
IL_02b6: ldarg.1
IL_02b7: ldfld UnityEngine.Sprite TheForestOfLove.Narrative.Quest::portrait
IL_02bc: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_02c1: ldarg.0
IL_02c2: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::title
IL_02c7: ldarg.1
IL_02c8: ldfld System.String TheForestOfLove.Narrative.Quest::title
IL_02cd: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_02d2: ldarg.0
IL_02d3: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::description
IL_02d8: ldarg.1
IL_02d9: ldfld System.String TheForestOfLove.Narrative.Quest::description
IL_02de: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_02e3: ldarg.0
IL_02e4: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistoryCurrent
IL_02e9: ldloc.s V_7
IL_02eb: dup
IL_02ec: brtrue.s IL_02f4
IL_02ee: pop
IL_02ef: ldsfld System.String System.String::Empty
IL_02f4: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_02f9: ldarg.0
IL_02fa: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_02ff: ldloc.s V_6
IL_0301: dup
IL_0302: brtrue.s IL_030b
IL_0304: pop
IL_0305: ldarg.0
IL_0306: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_030b: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0310: ldarg.0
IL_0311: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory1BackBullet
IL_0316: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_031b: ldarg.0
IL_031c: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_0321: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0326: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_032b: ldc.i4.0
IL_032c: ceq
IL_032e: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0333: ldarg.0
IL_0334: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_0339: ldloc.s V_5
IL_033b: dup
IL_033c: brtrue.s IL_0345
IL_033e: pop
IL_033f: ldarg.0
IL_0340: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_0345: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_034a: ldarg.0
IL_034b: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory2BackBullet
IL_0350: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0355: ldarg.0
IL_0356: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_035b: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0360: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0365: ldc.i4.0
IL_0366: ceq
IL_0368: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_036d: br IL_0959
IL_0372: ldarg.1
IL_0373: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0378: ldstr "Act3_StormQuest"
IL_037d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0382: brfalse IL_0609
IL_0387: ldstr "Act3_StormQuest_3"
IL_038c: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0391: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_0396: stloc.s V_8
IL_0398: ldstr "Act3_StormQuest_4"
IL_039d: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_03a2: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_03a7: stloc.s V_9
IL_03a9: ldstr "Act3_StormQuest_5"
IL_03ae: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_03b3: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_03b8: stloc.s V_10
IL_03ba: ldc.i4 420
IL_03bf: call System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItemType)
IL_03c4: brtrue.s IL_03c9
IL_03c6: ldnull
IL_03c7: stloc.s V_10
IL_03c9: ldstr "Act3_StormQuest_2"
IL_03ce: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_03d3: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_03d8: stloc.s V_11
IL_03da: ldstr "Act3_StormQuest"
IL_03df: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_03e4: ldc.i4 200
IL_03e9: ceq
IL_03eb: stloc.s V_12
IL_03ed: ldloc.s V_12
IL_03ef: brtrue.s IL_042b
IL_03f1: ldc.i4 420
IL_03f6: call System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItemType)
IL_03fb: ldc.i4.7
IL_03fc: bne.un.s IL_042b
IL_03fe: ldstr "StormQuest_DustinAndBucky"
IL_0403: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0408: brfalse.s IL_041d
IL_040a: ldstr "Act3_StormQuest_5a"
IL_040f: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0414: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_0419: stloc.s V_10
IL_041b: br.s IL_042b
IL_041d: ldstr "DONE - "
IL_0422: ldloc.s V_10
IL_0424: call System.String System.String::Concat(System.String,System.String)
IL_0429: stloc.s V_10
IL_042b: ldloc.s V_12
IL_042d: brtrue.s IL_044c
IL_042f: ldstr "StormQuest_DustinAndBucky"
IL_0434: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0439: brtrue.s IL_044c
IL_043b: ldstr "Act3_StormQuest_4a"
IL_0440: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0445: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_044a: stloc.s V_9
IL_044c: ldloc.s V_12
IL_044e: brtrue.s IL_0472
IL_0450: ldstr "StormQuest_ScarlettAndPeter"
IL_0455: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_045a: brtrue.s IL_0472
IL_045c: ldc.i4 420
IL_0461: call System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItemType)
IL_0466: ldc.i4.0
IL_0467: ble.s IL_0472
IL_0469: ldloc.s V_10
IL_046b: stloc.s V_9
IL_046d: ldnull
IL_046e: stloc.s V_10
IL_0470: br.s IL_0494
IL_0472: ldloc.s V_12
IL_0474: brtrue.s IL_0494
IL_0476: ldstr "StormQuest_ScarlettAndPeter"
IL_047b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0480: brtrue.s IL_0494
IL_0482: ldc.i4 420
IL_0487: call System.Int32 TheForestOfLove.Narrative.NarrativeActions::GetItemQuantity(TheForestOfLove.Inventory.InventoryItemType)
IL_048c: brtrue.s IL_0494
IL_048e: ldnull
IL_048f: stloc.s V_9
IL_0491: ldnull
IL_0492: stloc.s V_10
IL_0494: ldstr "act3_thestorm_finishedhelpingbunnies"
IL_0499: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_049e: brfalse.s IL_04ae
IL_04a0: ldstr "DONE - "
IL_04a5: ldloc.s V_8
IL_04a7: call System.String System.String::Concat(System.String,System.String)
IL_04ac: stloc.s V_8
IL_04ae: ldstr "act3_thestorm_buckyminigamecompleted"
IL_04b3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_04b8: brfalse.s IL_04c8
IL_04ba: ldstr "DONE - "
IL_04bf: ldloc.s V_9
IL_04c1: call System.String System.String::Concat(System.String,System.String)
IL_04c6: stloc.s V_9
IL_04c8: ldstr "act3_thestorm_grabbedthelastpage"
IL_04cd: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_04d2: brfalse.s IL_04e2
IL_04d4: ldstr "DONE - "
IL_04d9: ldloc.s V_10
IL_04db: call System.String System.String::Concat(System.String,System.String)
IL_04e0: stloc.s V_10
IL_04e2: ldstr "act3_thestorm_finishedhelpingbunnies"
IL_04e7: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_04ec: brfalse.s IL_050d
IL_04ee: ldstr "act3_thestorm_buckyminigamecompleted"
IL_04f3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_04f8: brfalse.s IL_050d
IL_04fa: ldstr "act3_thestorm_grabbedthelastpage"
IL_04ff: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0504: brfalse.s IL_050d
IL_0506: ldstr "[Quest Completed]"
IL_050b: stloc.s V_11
IL_050d: ldarg.0
IL_050e: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::portrait
IL_0513: ldarg.1
IL_0514: ldfld UnityEngine.Sprite TheForestOfLove.Narrative.Quest::portrait
IL_0519: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_051e: ldarg.0
IL_051f: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::title
IL_0524: ldarg.1
IL_0525: ldfld System.String TheForestOfLove.Narrative.Quest::title
IL_052a: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_052f: ldarg.0
IL_0530: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::description
IL_0535: ldarg.1
IL_0536: ldfld System.String TheForestOfLove.Narrative.Quest::description
IL_053b: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0540: ldarg.0
IL_0541: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistoryCurrent
IL_0546: ldloc.s V_11
IL_0548: dup
IL_0549: brtrue.s IL_0551
IL_054b: pop
IL_054c: ldsfld System.String System.String::Empty
IL_0551: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0556: ldarg.0
IL_0557: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_055c: ldloc.s V_10
IL_055e: dup
IL_055f: brtrue.s IL_0568
IL_0561: pop
IL_0562: ldarg.0
IL_0563: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_0568: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_056d: ldarg.0
IL_056e: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory1BackBullet
IL_0573: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0578: ldarg.0
IL_0579: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_057e: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0583: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0588: ldc.i4.0
IL_0589: ceq
IL_058b: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0590: ldarg.0
IL_0591: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_0596: ldloc.s V_9
IL_0598: dup
IL_0599: brtrue.s IL_05a2
IL_059b: pop
IL_059c: ldarg.0
IL_059d: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_05a2: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_05a7: ldarg.0
IL_05a8: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory2BackBullet
IL_05ad: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_05b2: ldarg.0
IL_05b3: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_05b8: callvirt System.String UnityEngine.UI.Text::get_text()
IL_05bd: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_05c2: ldc.i4.0
IL_05c3: ceq
IL_05c5: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_05ca: ldarg.0
IL_05cb: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory3Back
IL_05d0: ldloc.s V_8
IL_05d2: dup
IL_05d3: brtrue.s IL_05dc
IL_05d5: pop
IL_05d6: ldarg.0
IL_05d7: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_05dc: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_05e1: ldarg.0
IL_05e2: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory3BackBullet
IL_05e7: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_05ec: ldarg.0
IL_05ed: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory3Back
IL_05f2: callvirt System.String UnityEngine.UI.Text::get_text()
IL_05f7: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_05fc: ldc.i4.0
IL_05fd: ceq
IL_05ff: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0604: br IL_0959
IL_0609: ldarg.1
IL_060a: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_060f: ldstr "Act1_GreetingsQuest"
IL_0614: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0619: brfalse IL_084a
IL_061e: ldstr "Act1_GreetingsQuest_3"
IL_0623: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0628: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_062d: stloc.s V_13
IL_062f: ldstr "Act1_GreetingsQuest_0"
IL_0634: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0639: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_063e: stloc.s V_14
IL_0640: ldstr "Act1_GreetingsQuest_1"
IL_0645: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_064a: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_064f: stloc.s V_15
IL_0651: ldstr "Act1_GreetingsQuest_2"
IL_0656: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_065b: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_0660: stloc.s V_16
IL_0662: ldstr "Say hi to all four of the critters."
IL_0667: stloc.s V_17
IL_0669: ldstr "Augustus"
IL_066e: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0673: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsEncounteredOnce()
IL_0678: brfalse.s IL_0681
IL_067a: ldstr "DONE - Meet Augustus."
IL_067f: stloc.s V_13
IL_0681: ldstr "Penny"
IL_0686: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_068b: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_0690: brfalse.s IL_0699
IL_0692: ldstr "DONE - Meet Penny."
IL_0697: stloc.s V_14
IL_0699: ldstr "Dustin"
IL_069e: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_06a3: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_06a8: brfalse.s IL_06b1
IL_06aa: ldstr "DONE - Meet Dustin."
IL_06af: stloc.s V_15
IL_06b1: ldstr "Finley"
IL_06b6: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_06bb: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_06c0: brfalse.s IL_06c9
IL_06c2: ldstr "DONE - Meet Finley."
IL_06c7: stloc.s V_16
IL_06c9: ldstr "Penny"
IL_06ce: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_06d3: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_06d8: brfalse.s IL_0714
IL_06da: ldstr "Dustin"
IL_06df: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_06e4: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_06e9: brfalse.s IL_0714
IL_06eb: ldstr "Finley"
IL_06f0: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_06f5: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_06fa: brfalse.s IL_0714
IL_06fc: ldstr "Augustus"
IL_0701: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0706: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsEncounteredOnce()
IL_070b: brfalse.s IL_0714
IL_070d: ldstr "[Quest Completed]"
IL_0712: stloc.s V_17
IL_0714: ldarg.0
IL_0715: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::portrait
IL_071a: ldarg.1
IL_071b: ldfld UnityEngine.Sprite TheForestOfLove.Narrative.Quest::portrait
IL_0720: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_0725: ldarg.0
IL_0726: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::title
IL_072b: ldarg.1
IL_072c: ldfld System.String TheForestOfLove.Narrative.Quest::title
IL_0731: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0736: ldarg.0
IL_0737: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::description
IL_073c: ldarg.1
IL_073d: ldfld System.String TheForestOfLove.Narrative.Quest::description
IL_0742: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0747: ldarg.0
IL_0748: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistoryCurrent
IL_074d: ldloc.s V_17
IL_074f: dup
IL_0750: brtrue.s IL_0758
IL_0752: pop
IL_0753: ldsfld System.String System.String::Empty
IL_0758: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_075d: ldarg.0
IL_075e: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_0763: ldloc.s V_16
IL_0765: dup
IL_0766: brtrue.s IL_076f
IL_0768: pop
IL_0769: ldarg.0
IL_076a: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_076f: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0774: ldarg.0
IL_0775: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory1BackBullet
IL_077a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_077f: ldarg.0
IL_0780: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_0785: callvirt System.String UnityEngine.UI.Text::get_text()
IL_078a: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_078f: ldc.i4.0
IL_0790: ceq
IL_0792: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0797: ldarg.0
IL_0798: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_079d: ldloc.s V_15
IL_079f: dup
IL_07a0: brtrue.s IL_07a9
IL_07a2: pop
IL_07a3: ldarg.0
IL_07a4: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_07a9: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_07ae: ldarg.0
IL_07af: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory2BackBullet
IL_07b4: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_07b9: ldarg.0
IL_07ba: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_07bf: callvirt System.String UnityEngine.UI.Text::get_text()
IL_07c4: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_07c9: ldc.i4.0
IL_07ca: ceq
IL_07cc: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_07d1: ldarg.0
IL_07d2: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory3Back
IL_07d7: ldloc.s V_14
IL_07d9: dup
IL_07da: brtrue.s IL_07e3
IL_07dc: pop
IL_07dd: ldarg.0
IL_07de: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_07e3: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_07e8: ldarg.0
IL_07e9: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory3BackBullet
IL_07ee: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_07f3: ldarg.0
IL_07f4: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory3Back
IL_07f9: callvirt System.String UnityEngine.UI.Text::get_text()
IL_07fe: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0803: ldc.i4.0
IL_0804: ceq
IL_0806: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_080b: ldarg.0
IL_080c: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory4Back
IL_0811: ldloc.s V_13
IL_0813: dup
IL_0814: brtrue.s IL_081d
IL_0816: pop
IL_0817: ldarg.0
IL_0818: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_081d: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0822: ldarg.0
IL_0823: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory4BackBullet
IL_0828: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_082d: ldarg.0
IL_082e: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory4Back
IL_0833: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0838: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_083d: ldc.i4.0
IL_083e: ceq
IL_0840: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0845: br IL_0959
IL_084a: ldarg.0
IL_084b: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory3Back
IL_0850: ldsfld System.String System.String::Empty
IL_0855: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_085a: ldarg.0
IL_085b: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory3BackBullet
IL_0860: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0865: ldc.i4.0
IL_0866: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_086b: ldarg.0
IL_086c: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::portrait
IL_0871: ldarg.1
IL_0872: ldfld UnityEngine.Sprite TheForestOfLove.Narrative.Quest::portrait
IL_0877: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_087c: ldarg.0
IL_087d: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::title
IL_0882: ldarg.1
IL_0883: ldfld System.String TheForestOfLove.Narrative.Quest::title
IL_0888: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_088d: ldarg.0
IL_088e: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::description
IL_0893: ldarg.1
IL_0894: ldfld System.String TheForestOfLove.Narrative.Quest::description
IL_0899: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_089e: ldnull
IL_089f: stloc.s V_18
IL_08a1: ldnull
IL_08a2: stloc.s V_19
IL_08a4: ldnull
IL_08a5: stloc.s V_20
IL_08a7: ldarg.1
IL_08a8: ldloca.s V_20
IL_08aa: ldloca.s V_19
IL_08ac: ldloca.s V_18
IL_08ae: call System.Void TheForestOfLove.QuestLog::GenerateLogTextHistory(TheForestOfLove.Narrative.Quest,System.String&,System.String&,System.String&)
IL_08b3: ldarg.1
IL_08b4: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_08b9: ldc.i4 200
IL_08be: bne.un.s IL_08cf
IL_08c0: ldloc.s V_19
IL_08c2: stloc.s V_18
IL_08c4: ldloc.s V_20
IL_08c6: stloc.s V_19
IL_08c8: ldstr "[Quest Completed]"
IL_08cd: stloc.s V_20
IL_08cf: ldarg.0
IL_08d0: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistoryCurrent
IL_08d5: ldloc.s V_20
IL_08d7: dup
IL_08d8: brtrue.s IL_08e0
IL_08da: pop
IL_08db: ldsfld System.String System.String::Empty
IL_08e0: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_08e5: ldarg.0
IL_08e6: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_08eb: ldloc.s V_19
IL_08ed: dup
IL_08ee: brtrue.s IL_08f7
IL_08f0: pop
IL_08f1: ldarg.0
IL_08f2: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_08f7: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_08fc: ldarg.0
IL_08fd: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory1BackBullet
IL_0902: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0907: ldarg.0
IL_0908: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_090d: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0912: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0917: ldc.i4.0
IL_0918: ceq
IL_091a: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_091f: ldarg.0
IL_0920: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_0925: ldloc.s V_18
IL_0927: dup
IL_0928: brtrue.s IL_0931
IL_092a: pop
IL_092b: ldarg.0
IL_092c: ldfld System.String TheForestOfLove.QuestLogDetailsPane::emptyHistoryDefaultText
IL_0931: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0936: ldarg.0
IL_0937: ldfld UnityEngine.UI.Image TheForestOfLove.QuestLogDetailsPane::stepHistory2BackBullet
IL_093c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0941: ldarg.0
IL_0942: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_0947: callvirt System.String UnityEngine.UI.Text::get_text()
IL_094c: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0951: ldc.i4.0
IL_0952: ceq
IL_0954: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0959: ldarg.1
IL_095a: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_095f: ldstr "MelodyFlipbookQuest"
IL_0964: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0969: brfalse IL_0a81
IL_096e: call System.Int32 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerSideQuests::CountNumberUnlockedMelodyFlipbookPhotos()
IL_0973: stloc.s V_21
IL_0975: call System.Int32 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerSideQuests::GetNumberTotalMelodyFlipbookPhotos()
IL_097a: stloc.s V_22
IL_097c: ldarg.0
IL_097d: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistoryCurrent
IL_0982: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0987: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_098c: brtrue.s IL_09d3
IL_098e: ldarg.0
IL_098f: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistoryCurrent
IL_0994: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0999: ldstr "lost photos"
IL_099e: callvirt System.Boolean System.String::Contains(System.String)
IL_09a3: brfalse.s IL_09d3
IL_09a5: ldarg.0
IL_09a6: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistoryCurrent
IL_09ab: dup
IL_09ac: callvirt System.String UnityEngine.UI.Text::get_text()
IL_09b1: ldstr " ({0}/{1})"
IL_09b6: ldloc.s V_21
IL_09b8: box System.Int32
IL_09bd: ldloc.s V_22
IL_09bf: box System.Int32
IL_09c4: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_09c9: call System.String System.String::Concat(System.String,System.String)
IL_09ce: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_09d3: ldarg.0
IL_09d4: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_09d9: callvirt System.String UnityEngine.UI.Text::get_text()
IL_09de: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_09e3: brtrue.s IL_0a2a
IL_09e5: ldarg.0
IL_09e6: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_09eb: callvirt System.String UnityEngine.UI.Text::get_text()
IL_09f0: ldstr "lost photos"
IL_09f5: callvirt System.Boolean System.String::Contains(System.String)
IL_09fa: brfalse.s IL_0a2a
IL_09fc: ldarg.0
IL_09fd: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory1Back
IL_0a02: dup
IL_0a03: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0a08: ldstr " ({0}/{1})"
IL_0a0d: ldloc.s V_21
IL_0a0f: box System.Int32
IL_0a14: ldloc.s V_22
IL_0a16: box System.Int32
IL_0a1b: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0a20: call System.String System.String::Concat(System.String,System.String)
IL_0a25: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0a2a: ldarg.0
IL_0a2b: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_0a30: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0a35: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0a3a: brtrue.s IL_0a81
IL_0a3c: ldarg.0
IL_0a3d: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_0a42: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0a47: ldstr "lost photos"
IL_0a4c: callvirt System.Boolean System.String::Contains(System.String)
IL_0a51: brfalse.s IL_0a81
IL_0a53: ldarg.0
IL_0a54: ldfld UnityEngine.UI.Text TheForestOfLove.QuestLogDetailsPane::stepHistory2Back
IL_0a59: dup
IL_0a5a: callvirt System.String UnityEngine.UI.Text::get_text()
IL_0a5f: ldstr " ({0}/{1})"
IL_0a64: ldloc.s V_21
IL_0a66: box System.Int32
IL_0a6b: ldloc.s V_22
IL_0a6d: box System.Int32
IL_0a72: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0a77: call System.String System.String::Concat(System.String,System.String)
IL_0a7c: callvirt System.Void UnityEngine.UI.Text::set_text(System.String)
IL_0a81: ret
