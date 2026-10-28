TYPE TheForestOfLove.Services.Persistence.DataService
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.s tmpList
IL_0002: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Clear()
IL_0007: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_000c: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_0011: ldarg.s questDbName
IL_0013: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::ContainsKey(!0)
IL_0018: brtrue.s IL_001d
IL_001a: ldnull
IL_001b: br.s IL_002e
IL_001d: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0022: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_0027: ldarg.s questDbName
IL_0029: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_002e: stloc.0
IL_002f: ldloc.0
IL_0030: brtrue.s IL_0033
IL_0032: ret
IL_0033: ldarg.0
IL_0034: ldloc.0
IL_0035: ldfld System.String TheForestOfLove.Narrative.Quest::savekey
IL_003a: callvirt TheForestOfLove.Services.Persistence.SavegameQuestData TheForestOfLove.Services.Persistence.Savestate::LoadQuestData(System.String)
IL_003f: stloc.1
IL_0040: ldloc.1
IL_0041: brtrue.s IL_0046
IL_0043: ldnull
IL_0044: br.s IL_0051
IL_0046: ldloc.1
IL_0047: ldfld System.String TheForestOfLove.Services.Persistence.SavegameQuestData::statusSavekey
IL_004c: call TheForestOfLove.Narrative.QuestStatusRecord TheForestOfLove.Services.Persistence.DataService::GetQuestStatusRecordBySavekey(System.String)
IL_0051: stloc.2
IL_0052: ldloc.2
IL_0053: brtrue.s IL_0058
IL_0055: ldc.i4.0
IL_0056: br.s IL_005e
IL_0058: ldloc.2
IL_0059: ldfld TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.QuestStatusRecord::status
IL_005e: ldc.i4 200
IL_0063: bne.un IL_0172
IL_0068: ldloc.0
IL_0069: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.Quest::dialogues
IL_006e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0073: stloc.3
IL_0074: br.s IL_009c
IL_0076: ldloca.s V_3
IL_0078: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_007d: stloc.s V_4
IL_007f: ldloc.s V_4
IL_0081: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_0086: ldarg.1
IL_0087: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_008c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0091: brfalse.s IL_009c
IL_0093: ldarg.s tmpList
IL_0095: ldloc.s V_4
IL_0097: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_009c: ldloca.s V_3
IL_009e: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_00a3: brtrue.s IL_0076
IL_00a5: leave.s IL_00b5
IL_00a7: ldloca.s V_3
IL_00a9: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_00af: callvirt System.Void System.IDisposable::Dispose()
IL_00b4: endfinally
IL_00b5: ldarg.0
IL_00b6: ldarg.2
IL_00b7: ldarg.3
IL_00b8: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_00bd: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_00c2: ldarg.s tmpList
IL_00c4: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopyDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>)
IL_00c9: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_00ce: ldloc.0
IL_00cf: ldfld System.String TheForestOfLove.Narrative.Quest::savekey
IL_00d4: callvirt TheForestOfLove.Services.Persistence.SavegameQuestData TheForestOfLove.Services.Persistence.Savestate::LoadQuestData(System.String)
IL_00d9: brtrue IL_0172
IL_00de: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_00e3: ldloc.1
IL_00e4: callvirt TheForestOfLove.Services.Persistence.SavegameQuestData TheForestOfLove.Services.Persistence.SavegameQuestData::DeepCopy()
IL_00e9: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveQuestData(TheForestOfLove.Services.Persistence.SavegameQuestData)
IL_00ee: ldloc.0
IL_00ef: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.Quest::progressLogEntries
IL_00f4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::GetEnumerator()
IL_00f9: stloc.s V_5
IL_00fb: br.s IL_012a
IL_00fd: ldloca.s V_5
IL_00ff: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Current()
IL_0104: stloc.s V_6
IL_0106: ldarg.0
IL_0107: ldloc.s V_6
IL_0109: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::savekey
IL_010e: callvirt TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry TheForestOfLove.Services.Persistence.Savestate::LoadQuestProgressLogData(System.String)
IL_0113: stloc.s V_7
IL_0115: ldloc.s V_7
IL_0117: brfalse.s IL_012a
IL_0119: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_011e: ldloc.s V_7
IL_0120: callvirt TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry::DeepCopy()
IL_0125: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveQuestProgressLogData(TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry)
IL_012a: ldloca.s V_5
IL_012c: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>::MoveNext()
IL_0131: brtrue.s IL_00fd
IL_0133: leave.s IL_0143
IL_0135: ldloca.s V_5
IL_0137: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>
IL_013d: callvirt System.Void System.IDisposable::Dispose()
IL_0142: endfinally
IL_0143: ldloc.0
IL_0144: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0149: ldstr "GlitchQuest"
IL_014e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0153: brfalse.s IL_0172
IL_0155: ldarg.0
IL_0156: callvirt TheForestOfLove.Services.Persistence.SavegameGlitchRascalPart1Data TheForestOfLove.Services.Persistence.Savestate::LoadGlitchRascalPart1Data()
IL_015b: stloc.s V_8
IL_015d: ldloc.s V_8
IL_015f: brfalse.s IL_0172
IL_0161: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0166: ldloc.s V_8
IL_0168: callvirt TheForestOfLove.Services.Persistence.SavegameGlitchRascalPart1Data TheForestOfLove.Services.Persistence.SavegameGlitchRascalPart1Data::DeepCopy()
IL_016d: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveGlitchRascalPart1Data(TheForestOfLove.Services.Persistence.SavegameGlitchRascalPart1Data)
IL_0172: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::EnsureInventoryItemIfDialogueComplete(TheForestOfLove.Services.Persistence.Savestate,System.String,TheForestOfLove.Inventory.InventoryItemType) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbName
IL_000a: ldarg.1
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::ContainsKey(!0)
IL_0010: brfalse.s IL_0028
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatusesByStatus
IL_001c: ldc.i4 200
IL_0021: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord>::ContainsKey(!0)
IL_0026: brtrue.s IL_0029
IL_0028: ret
IL_0029: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_002e: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatusesByStatus
IL_0033: ldc.i4 200
IL_0038: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord>::get_Item(!0)
IL_003d: stloc.0
IL_003e: ldarg.0
IL_003f: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0044: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbName
IL_0049: ldarg.1
IL_004a: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_004f: ldfld System.String TheForestOfLove.Narrative.Dialogue::savekey
IL_0054: callvirt TheForestOfLove.Services.Persistence.SavegameDialogueData TheForestOfLove.Services.Persistence.Savestate::LoadDialogueData(System.String)
IL_0059: stloc.1
IL_005a: ldloc.1
IL_005b: brfalse.s IL_0073
IL_005d: ldloc.0
IL_005e: brfalse.s IL_0073
IL_0060: ldloc.1
IL_0061: ldfld System.String TheForestOfLove.Services.Persistence.SavegameDialogueData::statusSavekey
IL_0066: ldloc.0
IL_0067: ldfld System.String TheForestOfLove.Narrative.DialogueStatusRecord::savekey
IL_006c: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0071: brfalse.s IL_0074
IL_0073: ret
IL_0074: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0079: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByItemType
IL_007e: ldarg.2
IL_007f: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem>::ContainsKey(!0)
IL_0084: brtrue.s IL_0087
IL_0086: ret
IL_0087: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_008c: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByItemType
IL_0091: ldarg.2
IL_0092: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem>::get_Item(!0)
IL_0097: stloc.2
IL_0098: ldloc.2
IL_0099: brtrue.s IL_009c
IL_009b: ret
IL_009c: ldloc.2
IL_009d: callvirt System.Void TheForestOfLove.Inventory.InventoryItem::EnsurePlayerHasOne()
IL_00a2: ldloc.2
IL_00a3: call System.Void TheForestOfLove.Services.Persistence.DataService::SaveInventoryItem(TheForestOfLove.Inventory.InventoryItem)
IL_00a8: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::AddTagToActive(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brtrue.s IL_0015
IL_000a: ldstr "data service cannot add a null tag"
IL_000f: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0014: ret
IL_0015: ldarg.0
IL_0016: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_001b: brtrue.s IL_0033
IL_001d: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0022: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::activeTagsByDbName
IL_0027: ldloc.0
IL_0028: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_002d: ldloc.0
IL_002e: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag>::Add(!0,!1)
IL_0033: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::RemoveTagFromActive(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Tag TheForestOfLove.Services.Persistence.DataService::GetTagByDbName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brtrue.s IL_0015
IL_000a: ldstr "data service cannot add a null tag"
IL_000f: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0014: ret
IL_0015: ldarg.0
IL_0016: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_001b: brfalse.s IL_0033
IL_001d: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0022: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::activeTagsByDbName
IL_0027: ldloc.0
IL_0028: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_002d: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag>::Remove(!0)
IL_0032: pop
IL_0033: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::ClearTriggerData(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0010
IL_000a: ldloc.0
IL_000b: callvirt System.Void TheForestOfLove.Narrative.Trigger::ResetTriggerDevtoolsOnly()
IL_0010: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0015: ldarg.0
IL_0016: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::ClearTriggerData(System.String)
IL_001b: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0005: ldarg.0
IL_0006: ldarg.1
IL_0007: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveVariable(System.String,System.String)
IL_000c: ret
