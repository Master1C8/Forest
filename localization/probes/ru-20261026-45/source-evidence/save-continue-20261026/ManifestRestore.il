TYPE TheForestOfLove.Services.Persistence.DataService
METHOD TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest() | attributes=Private, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld TheForestOfLove.Services.Persistence.DataService TheForestOfLove.Services.Persistence.DataService::_instance
IL_0005: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_000a: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::GenerateManifest() | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.DialogueSystemLoader::.ctor()
IL_0005: stloc.0
IL_0006: ldarg.0
IL_0007: ldloc.0
IL_0008: callvirt TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader::GenerateManifest()
IL_000d: stfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0012: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0017: callvirt System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Services.Persistence.Savestate::LoadTags()
IL_001c: stloc.1
IL_001d: ldarg.0
IL_001e: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0023: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tags
IL_0028: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_002d: stloc.2
IL_002e: br.s IL_005d
IL_0030: ldloca.s V_2
IL_0032: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_0037: stloc.3
IL_0038: ldloc.1
IL_0039: ldloc.3
IL_003a: ldfld System.String TheForestOfLove.Narrative.Tag::savekey
IL_003f: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Contains(!0)
IL_0044: brfalse.s IL_005d
IL_0046: ldarg.0
IL_0047: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_004c: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::activeTagsByDbName
IL_0051: ldloc.3
IL_0052: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_0057: ldloc.3
IL_0058: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag>::Add(!0,!1)
IL_005d: ldloca.s V_2
IL_005f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_0064: brtrue.s IL_0030
IL_0066: leave.s IL_0076
IL_0068: ldloca.s V_2
IL_006a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_0070: callvirt System.Void System.IDisposable::Dispose()
IL_0075: endfinally
IL_0076: ldarg.0
IL_0077: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_007c: ldfld TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Narrative.DataManifest::generalData
IL_0081: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0086: callvirt TheForestOfLove.Services.Persistence.SavegameGeneralData TheForestOfLove.Services.Persistence.Savestate::LoadGeneralData()
IL_008b: callvirt System.Void TheForestOfLove.Services.Persistence.GeneralData::Load(TheForestOfLove.Services.Persistence.SavegameGeneralData)
IL_0090: ldarg.0
IL_0091: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0096: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Narrative.DataManifest::playerRespawnData
IL_009b: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_00a0: callvirt TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData TheForestOfLove.Services.Persistence.Savestate::LoadPlayerRespawnData()
IL_00a5: callvirt System.Void TheForestOfLove.Services.Persistence.PlayerRespawnData::Load(TheForestOfLove.Services.Persistence.SavegamePlayerRespawnData)
IL_00aa: ldarg.0
IL_00ab: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_00b0: ldfld TheForestOfLove.Services.Persistence.PlantQuestMinigameData TheForestOfLove.Narrative.DataManifest::plantQuestMinigameData
IL_00b5: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_00ba: callvirt TheForestOfLove.Services.Persistence.SavegamePlantQuestMinigameData TheForestOfLove.Services.Persistence.Savestate::LoadPlantQuestMinigameData()
IL_00bf: callvirt System.Void TheForestOfLove.Services.Persistence.PlantQuestMinigameData::Load(TheForestOfLove.Services.Persistence.SavegamePlantQuestMinigameData)
IL_00c4: ldarg.0
IL_00c5: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_00ca: ldfld TheForestOfLove.Services.Persistence.DashQuestMinigameData TheForestOfLove.Narrative.DataManifest::dashQuestMinigameData
IL_00cf: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_00d4: callvirt TheForestOfLove.Services.Persistence.SavegameDashQuestMinigameData TheForestOfLove.Services.Persistence.Savestate::LoadDashQuestMinigameData()
IL_00d9: callvirt System.Void TheForestOfLove.Services.Persistence.DashQuestMinigameData::Load(TheForestOfLove.Services.Persistence.SavegameDashQuestMinigameData)
IL_00de: ldarg.0
IL_00df: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_00e4: ldfld TheForestOfLove.Services.Persistence.DustinMinigameTrainingData TheForestOfLove.Narrative.DataManifest::dustinMinigameTrainingData
IL_00e9: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_00ee: callvirt TheForestOfLove.Services.Persistence.SavegameDustinMinigameTrainingData TheForestOfLove.Services.Persistence.Savestate::LoadDustinMinigameTrainingData()
IL_00f3: callvirt System.Void TheForestOfLove.Services.Persistence.DustinMinigameTrainingData::Load(TheForestOfLove.Services.Persistence.SavegameDustinMinigameTrainingData)
IL_00f8: ldarg.0
IL_00f9: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_00fe: ldfld TheForestOfLove.Services.Persistence.DustinMinigameNoviceData TheForestOfLove.Narrative.DataManifest::dustinMinigameNoviceData
IL_0103: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0108: callvirt TheForestOfLove.Services.Persistence.SavegameDustinMinigameNoviceData TheForestOfLove.Services.Persistence.Savestate::LoadDustinMinigameNoviceData()
IL_010d: callvirt System.Void TheForestOfLove.Services.Persistence.DustinMinigameNoviceData::Load(TheForestOfLove.Services.Persistence.SavegameDustinMinigameNoviceData)
IL_0112: ldarg.0
IL_0113: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0118: ldfld TheForestOfLove.Services.Persistence.GlitchRascalPart1Data TheForestOfLove.Narrative.DataManifest::glitchRascalPart1Data
IL_011d: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0122: callvirt TheForestOfLove.Services.Persistence.SavegameGlitchRascalPart1Data TheForestOfLove.Services.Persistence.Savestate::LoadGlitchRascalPart1Data()
IL_0127: callvirt System.Void TheForestOfLove.Services.Persistence.GlitchRascalPart1Data::Load(TheForestOfLove.Services.Persistence.SavegameGlitchRascalPart1Data)
IL_012c: ldarg.0
IL_012d: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0132: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggers
IL_0137: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::GetEnumerator()
IL_013c: stloc.s V_4
IL_013e: br.s IL_0165
IL_0140: ldloca.s V_4
IL_0142: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::get_Current()
IL_0147: stloc.s V_5
IL_0149: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_014e: ldloc.s V_5
IL_0150: ldfld System.String TheForestOfLove.Narrative.Trigger::savekey
IL_0155: callvirt TheForestOfLove.Services.Persistence.SavegameTriggerData TheForestOfLove.Services.Persistence.Savestate::LoadTriggerData(System.String)
IL_015a: stloc.s V_6
IL_015c: ldloc.s V_5
IL_015e: ldloc.s V_6
IL_0160: callvirt System.Void TheForestOfLove.Narrative.Trigger::Load(TheForestOfLove.Services.Persistence.SavegameTriggerData)
IL_0165: ldloca.s V_4
IL_0167: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>::MoveNext()
IL_016c: brtrue.s IL_0140
IL_016e: leave.s IL_017e
IL_0170: ldloca.s V_4
IL_0172: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Trigger>
IL_0178: callvirt System.Void System.IDisposable::Dispose()
IL_017d: endfinally
IL_017e: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0183: callvirt System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameTriggerData> TheForestOfLove.Services.Persistence.Savestate::LoadTriggerData()
IL_0188: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameTriggerData>::GetEnumerator()
IL_018d: stloc.s V_7
IL_018f: br.s IL_01c6
IL_0191: ldloc.s V_7
IL_0193: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Services.Persistence.SavegameTriggerData>::get_Current()
IL_0198: stloc.s V_8
IL_019a: ldarg.0
IL_019b: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_01a0: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersBySavekey
IL_01a5: ldloc.s V_8
IL_01a7: ldfld System.String TheForestOfLove.Services.Persistence.SavegameTriggerData::triggerSavekey
IL_01ac: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::ContainsKey(!0)
IL_01b1: brtrue.s IL_01c6
IL_01b3: ldloc.s V_8
IL_01b5: ldfld System.String TheForestOfLove.Services.Persistence.SavegameTriggerData::triggerSavekey
IL_01ba: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::CreateTriggerOnTheFly(System.String)
IL_01bf: ldloc.s V_8
IL_01c1: callvirt System.Void TheForestOfLove.Narrative.Trigger::Load(TheForestOfLove.Services.Persistence.SavegameTriggerData)
IL_01c6: ldloc.s V_7
IL_01c8: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_01cd: brtrue.s IL_0191
IL_01cf: leave.s IL_01dd
IL_01d1: ldloc.s V_7
IL_01d3: brfalse.s IL_01dc
IL_01d5: ldloc.s V_7
IL_01d7: callvirt System.Void System.IDisposable::Dispose()
IL_01dc: endfinally
IL_01dd: ldarg.0
IL_01de: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_01e3: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.DataManifest::adventuresByAdventureType
IL_01e8: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Values()
IL_01ed: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::GetEnumerator()
IL_01f2: stloc.s V_9
IL_01f4: br.s IL_021b
IL_01f6: ldloca.s V_9
IL_01f8: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Current()
IL_01fd: stloc.s V_10
IL_01ff: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0204: ldloc.s V_10
IL_0206: ldfld System.String TheForestOfLove.Narrative.Adventure::Savekey
IL_020b: callvirt TheForestOfLove.Services.Persistence.SavegameAdventureData TheForestOfLove.Services.Persistence.Savestate::LoadAdventureData(System.String)
IL_0210: stloc.s V_11
IL_0212: ldloc.s V_10
IL_0214: ldloc.s V_11
IL_0216: callvirt System.Void TheForestOfLove.Narrative.Adventure::Load(TheForestOfLove.Services.Persistence.SavegameAdventureData)
IL_021b: ldloca.s V_9
IL_021d: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::MoveNext()
IL_0222: brtrue.s IL_01f6
IL_0224: leave.s IL_0234
IL_0226: ldloca.s V_9
IL_0228: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>
IL_022e: callvirt System.Void System.IDisposable::Dispose()
IL_0233: endfinally
IL_0234: ldarg.0
IL_0235: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_023a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItems
IL_023f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Inventory.InventoryItem>::GetEnumerator()
IL_0244: stloc.s V_12
IL_0246: br.s IL_026d
IL_0248: ldloca.s V_12
IL_024a: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::get_Current()
IL_024f: stloc.s V_13
IL_0251: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0256: ldloc.s V_13
IL_0258: ldfld System.String TheForestOfLove.Inventory.InventoryItem::savekey
IL_025d: callvirt TheForestOfLove.Services.Persistence.SavegameInventoryItemData TheForestOfLove.Services.Persistence.Savestate::LoadInventoryItemData(System.String)
IL_0262: stloc.s V_14
IL_0264: ldloc.s V_13
IL_0266: ldloc.s V_14
IL_0268: callvirt System.Void TheForestOfLove.Inventory.InventoryItem::Load(TheForestOfLove.Services.Persistence.SavegameInventoryItemData)
IL_026d: ldloca.s V_12
IL_026f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>::MoveNext()
IL_0274: brtrue.s IL_0248
IL_0276: leave.s IL_0286
IL_0278: ldloca.s V_12
IL_027a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Inventory.InventoryItem>
IL_0280: callvirt System.Void System.IDisposable::Dispose()
IL_0285: endfinally
IL_0286: ldarg.0
IL_0287: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_028c: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::movies
IL_0291: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord>::GetEnumerator()
IL_0296: stloc.s V_15
IL_0298: br.s IL_02bf
IL_029a: ldloca.s V_15
IL_029c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>::get_Current()
IL_02a1: stloc.s V_16
IL_02a3: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_02a8: ldloc.s V_16
IL_02aa: ldfld System.String TheForestOfLove.Narrative.MovieRecord::savekey
IL_02af: callvirt TheForestOfLove.Services.Persistence.SavegameMovieData TheForestOfLove.Services.Persistence.Savestate::LoadMovieData(System.String)
IL_02b4: stloc.s V_17
IL_02b6: ldloc.s V_16
IL_02b8: ldloc.s V_17
IL_02ba: callvirt System.Void TheForestOfLove.Narrative.MovieRecord::Load(TheForestOfLove.Services.Persistence.SavegameMovieData)
IL_02bf: ldloca.s V_15
IL_02c1: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>::MoveNext()
IL_02c6: brtrue.s IL_029a
IL_02c8: leave.s IL_02d8
IL_02ca: ldloca.s V_15
IL_02cc: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>
IL_02d2: callvirt System.Void System.IDisposable::Dispose()
IL_02d7: endfinally
IL_02d8: ldarg.0
IL_02d9: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_02de: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chapters
IL_02e3: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_02e8: stloc.s V_18
IL_02ea: br.s IL_0311
IL_02ec: ldloca.s V_18
IL_02ee: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_02f3: stloc.s V_19
IL_02f5: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_02fa: ldloc.s V_19
IL_02fc: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::savekey
IL_0301: callvirt TheForestOfLove.Services.Persistence.SavegameChapterData TheForestOfLove.Services.Persistence.Savestate::LoadChapterData(System.String)
IL_0306: stloc.s V_20
IL_0308: ldloc.s V_19
IL_030a: ldloc.s V_20
IL_030c: callvirt System.Void TheForestOfLove.Narrative.ChapterRecord::Load(TheForestOfLove.Services.Persistence.SavegameChapterData)
IL_0311: ldloca.s V_18
IL_0313: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::MoveNext()
IL_0318: brtrue.s IL_02ec
IL_031a: leave.s IL_032a
IL_031c: ldloca.s V_18
IL_031e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>
IL_0324: callvirt System.Void System.IDisposable::Dispose()
IL_0329: endfinally
IL_032a: ldarg.0
IL_032b: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0330: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actors
IL_0335: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor>::GetEnumerator()
IL_033a: stloc.s V_21
IL_033c: br.s IL_0363
IL_033e: ldloca.s V_21
IL_0340: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Actor>::get_Current()
IL_0345: stloc.s V_22
IL_0347: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_034c: ldloc.s V_22
IL_034e: ldfld System.String TheForestOfLove.Narrative.Actor::savekey
IL_0353: callvirt TheForestOfLove.Services.Persistence.SavegameActorData TheForestOfLove.Services.Persistence.Savestate::LoadActorData(System.String)
IL_0358: stloc.s V_23
IL_035a: ldloc.s V_22
IL_035c: ldloc.s V_23
IL_035e: callvirt System.Void TheForestOfLove.Narrative.Actor::Load(TheForestOfLove.Services.Persistence.SavegameActorData)
IL_0363: ldloca.s V_21
IL_0365: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Actor>::MoveNext()
IL_036a: brtrue.s IL_033e
IL_036c: leave.s IL_037c
IL_036e: ldloca.s V_21
IL_0370: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Actor>
IL_0376: callvirt System.Void System.IDisposable::Dispose()
IL_037b: endfinally
IL_037c: ldarg.0
IL_037d: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0382: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ActorDialogueOracle> TheForestOfLove.Narrative.DataManifest::actorDialogueOracles
IL_0387: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ActorDialogueOracle>::GetEnumerator()
IL_038c: stloc.s V_24
IL_038e: br.s IL_03b5
IL_0390: ldloca.s V_24
IL_0392: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ActorDialogueOracle>::get_Current()
IL_0397: stloc.s V_25
IL_0399: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_039e: ldloc.s V_25
IL_03a0: callvirt System.String TheForestOfLove.Narrative.ActorDialogueOracle::get_ActorSavekey()
IL_03a5: callvirt TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData TheForestOfLove.Services.Persistence.Savestate::LoadActorDialogueOracleData(System.String)
IL_03aa: stloc.s V_26
IL_03ac: ldloc.s V_25
IL_03ae: ldloc.s V_26
IL_03b0: callvirt System.Void TheForestOfLove.Narrative.ActorDialogueOracle::Load(TheForestOfLove.Services.Persistence.SavegameActorDialogueOracleData)
IL_03b5: ldloca.s V_24
IL_03b7: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ActorDialogueOracle>::MoveNext()
IL_03bc: brtrue.s IL_0390
IL_03be: leave.s IL_03ce
IL_03c0: ldloca.s V_24
IL_03c2: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ActorDialogueOracle>
IL_03c8: callvirt System.Void System.IDisposable::Dispose()
IL_03cd: endfinally
IL_03ce: ldarg.0
IL_03cf: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_03d4: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::quests
IL_03d9: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::GetEnumerator()
IL_03de: stloc.s V_27
IL_03e0: br.s IL_0407
IL_03e2: ldloca.s V_27
IL_03e4: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::get_Current()
IL_03e9: stloc.s V_28
IL_03eb: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_03f0: ldloc.s V_28
IL_03f2: ldfld System.String TheForestOfLove.Narrative.Quest::savekey
IL_03f7: callvirt TheForestOfLove.Services.Persistence.SavegameQuestData TheForestOfLove.Services.Persistence.Savestate::LoadQuestData(System.String)
IL_03fc: stloc.s V_29
IL_03fe: ldloc.s V_28
IL_0400: ldloc.s V_29
IL_0402: callvirt System.Void TheForestOfLove.Narrative.Quest::Load(TheForestOfLove.Services.Persistence.SavegameQuestData)
IL_0407: ldloca.s V_27
IL_0409: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>::MoveNext()
IL_040e: brtrue.s IL_03e2
IL_0410: leave.s IL_0420
IL_0412: ldloca.s V_27
IL_0414: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Quest>
IL_041a: callvirt System.Void System.IDisposable::Dispose()
IL_041f: endfinally
IL_0420: ldarg.0
IL_0421: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0426: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntries
IL_042b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::GetEnumerator()
IL_0430: stloc.s V_30
IL_0432: br.s IL_0459
IL_0434: ldloca.s V_30
IL_0436: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Current()
IL_043b: stloc.s V_31
IL_043d: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0442: ldloc.s V_31
IL_0444: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::savekey
IL_0449: callvirt TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry TheForestOfLove.Services.Persistence.Savestate::LoadQuestProgressLogData(System.String)
IL_044e: stloc.s V_32
IL_0450: ldloc.s V_31
IL_0452: ldloc.s V_32
IL_0454: callvirt System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::Load(TheForestOfLove.Services.Persistence.SavegameQuestProgressLogEntry)
IL_0459: ldloca.s V_30
IL_045b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>::MoveNext()
IL_0460: brtrue.s IL_0434
IL_0462: leave.s IL_0472
IL_0464: ldloca.s V_30
IL_0466: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.QuestProgressLogEntry>
IL_046c: callvirt System.Void System.IDisposable::Dispose()
IL_0471: endfinally
IL_0472: ldarg.0
IL_0473: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0478: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialogues
IL_047d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0482: stloc.s V_33
IL_0484: br.s IL_04ab
IL_0486: ldloca.s V_33
IL_0488: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_048d: stloc.s V_34
IL_048f: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0494: ldloc.s V_34
IL_0496: ldfld System.String TheForestOfLove.Narrative.Dialogue::savekey
IL_049b: callvirt TheForestOfLove.Services.Persistence.SavegameDialogueData TheForestOfLove.Services.Persistence.Savestate::LoadDialogueData(System.String)
IL_04a0: stloc.s V_35
IL_04a2: ldloc.s V_34
IL_04a4: ldloc.s V_35
IL_04a6: callvirt System.Void TheForestOfLove.Narrative.Dialogue::Load(TheForestOfLove.Services.Persistence.SavegameDialogueData)
IL_04ab: ldloca.s V_33
IL_04ad: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_04b2: brtrue.s IL_0486
IL_04b4: leave.s IL_04c4
IL_04b6: ldloca.s V_33
IL_04b8: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_04be: callvirt System.Void System.IDisposable::Dispose()
IL_04c3: endfinally
IL_04c4: ldarg.0
IL_04c5: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_04ca: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.DataManifest::arcs
IL_04cf: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_04d4: stloc.s V_36
IL_04d6: br.s IL_04fd
IL_04d8: ldloca.s V_36
IL_04da: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_04df: stloc.s V_37
IL_04e1: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_04e6: ldloc.s V_37
IL_04e8: ldfld System.String TheForestOfLove.Narrative.Arc::generatedSavekey
IL_04ed: callvirt TheForestOfLove.Services.Persistence.SavegameArcData TheForestOfLove.Services.Persistence.Savestate::LoadArcData(System.String)
IL_04f2: stloc.s V_38
IL_04f4: ldloc.s V_37
IL_04f6: ldloc.s V_38
IL_04f8: callvirt System.Void TheForestOfLove.Narrative.Arc::Load(TheForestOfLove.Services.Persistence.SavegameArcData)
IL_04fd: ldloca.s V_36
IL_04ff: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_0504: brtrue.s IL_04d8
IL_0506: leave.s IL_0516
IL_0508: ldloca.s V_36
IL_050a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_0510: callvirt System.Void System.IDisposable::Dispose()
IL_0515: endfinally
IL_0516: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_051b: callvirt System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory> TheForestOfLove.Services.Persistence.Savestate::LoadGameplayLogHistoryData()
IL_0520: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory>::GetEnumerator()
IL_0525: stloc.s V_39
IL_0527: br.s IL_0561
IL_0529: ldloc.s V_39
IL_052b: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory>::get_Current()
IL_0530: stloc.s V_40
IL_0532: ldarg.0
IL_0533: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0538: ldfld System.Collections.Generic.List`1<GameplayLogHistory> TheForestOfLove.Narrative.DataManifest::gameplayLogHistory
IL_053d: newobj System.Void GameplayLogHistory::.ctor()
IL_0542: dup
IL_0543: ldloc.s V_40
IL_0545: ldfld System.String TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory::message
IL_054a: stfld System.String GameplayLogHistory::message
IL_054f: dup
IL_0550: ldloc.s V_40
IL_0552: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory::timeUnlocked
IL_0557: stfld System.Single GameplayLogHistory::timeUnlocked
IL_055c: callvirt System.Void System.Collections.Generic.List`1<GameplayLogHistory>::Add(!0)
IL_0561: ldloc.s V_39
IL_0563: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0568: brtrue.s IL_0529
IL_056a: leave.s IL_0578
IL_056c: ldloc.s V_39
IL_056e: brfalse.s IL_0577
IL_0570: ldloc.s V_39
IL_0572: callvirt System.Void System.IDisposable::Dispose()
IL_0577: endfinally
IL_0578: ldarg.0
IL_0579: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_057e: ldfld TheForestOfLove.Services.Persistence.GlobalGeneralData TheForestOfLove.Narrative.DataManifest::globalGeneralData
IL_0583: call TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.DataService::get_GlobalSavestate()
IL_0588: callvirt TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData TheForestOfLove.Services.Persistence.GlobalSavestate::LoadGeneralData()
IL_058d: callvirt System.Void TheForestOfLove.Services.Persistence.GlobalGeneralData::Load(TheForestOfLove.Services.Persistence.SavegameGlobalGeneralData)
IL_0592: ldarg.0
IL_0593: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_0598: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::globalMovies
IL_059d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord>::GetEnumerator()
IL_05a2: stloc.s V_15
IL_05a4: br.s IL_05cb
IL_05a6: ldloca.s V_15
IL_05a8: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>::get_Current()
IL_05ad: stloc.s V_41
IL_05af: call TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.DataService::get_GlobalSavestate()
IL_05b4: ldloc.s V_41
IL_05b6: ldfld System.String TheForestOfLove.Narrative.MovieRecord::savekey
IL_05bb: callvirt System.Boolean TheForestOfLove.Services.Persistence.GlobalSavestate::IsMovieUnlocked(System.String)
IL_05c0: stloc.s V_42
IL_05c2: ldloc.s V_41
IL_05c4: ldloc.s V_42
IL_05c6: callvirt System.Void TheForestOfLove.Narrative.MovieRecord::Load(System.Boolean)
IL_05cb: ldloca.s V_15
IL_05cd: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>::MoveNext()
IL_05d2: brtrue.s IL_05a6
IL_05d4: leave.s IL_05e4
IL_05d6: ldloca.s V_15
IL_05d8: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>
IL_05de: callvirt System.Void System.IDisposable::Dispose()
IL_05e3: endfinally
IL_05e4: ldarg.0
IL_05e5: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::_manifest
IL_05ea: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::globalChapters
IL_05ef: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_05f4: stloc.s V_18
IL_05f6: br.s IL_061d
IL_05f8: ldloca.s V_18
IL_05fa: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_05ff: stloc.s V_43
IL_0601: call TheForestOfLove.Services.Persistence.GlobalSavestate TheForestOfLove.Services.Persistence.DataService::get_GlobalSavestate()
IL_0606: ldloc.s V_43
IL_0608: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::savekey
IL_060d: callvirt System.Boolean TheForestOfLove.Services.Persistence.GlobalSavestate::IsChapterUnlocked(System.String)
IL_0612: stloc.s V_44
IL_0614: ldloc.s V_43
IL_0616: ldloc.s V_44
IL_0618: callvirt System.Void TheForestOfLove.Narrative.ChapterRecord::Load(System.Boolean)
IL_061d: ldloca.s V_18
IL_061f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::MoveNext()
IL_0624: brtrue.s IL_05f8
IL_0626: leave.s IL_0636
IL_0628: ldloca.s V_18
IL_062a: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>
IL_0630: callvirt System.Void System.IDisposable::Dispose()
IL_0635: endfinally
IL_0636: ret
METHOD TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Services.Persistence.DataService::GetGeneralData() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Narrative.DataManifest::generalData
IL_000a: ret
METHOD TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Narrative.DataManifest::playerRespawnData
IL_000a: ret
