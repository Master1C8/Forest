TYPE TheForestOfLove.Services.Persistence.DataService
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::SaveActor(TheForestOfLove.Narrative.Actor) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isExcludedFromSavestate
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_000e: ldarg.0
IL_000f: ldfld System.String TheForestOfLove.Narrative.Actor::savekey
IL_0014: callvirt TheForestOfLove.Services.Persistence.SavegameActorData TheForestOfLove.Services.Persistence.Savestate::LoadActorData(System.String)
IL_0019: dup
IL_001a: brtrue.s IL_0022
IL_001c: pop
IL_001d: newobj System.Void TheForestOfLove.Services.Persistence.SavegameActorData::.ctor()
IL_0022: stloc.0
IL_0023: ldloc.0
IL_0024: ldarg.0
IL_0025: ldfld System.String TheForestOfLove.Narrative.Actor::savekey
IL_002a: stfld System.String TheForestOfLove.Services.Persistence.SavegameActorData::actorSavekey
IL_002f: ldloc.0
IL_0030: ldarg.0
IL_0031: ldfld System.Single TheForestOfLove.Narrative.Actor::timeSinceLastDialogue
IL_0036: stfld System.Single TheForestOfLove.Services.Persistence.SavegameActorData::timeSinceLastDialogue
IL_003b: ldloc.0
IL_003c: ldarg.0
IL_003d: ldfld System.Single TheForestOfLove.Narrative.Actor::timeOfLastDialogue
IL_0042: stfld System.Single TheForestOfLove.Services.Persistence.SavegameActorData::timeOfLastDialogue
IL_0047: ldloc.0
IL_0048: ldarg.0
IL_0049: ldfld System.Int32 TheForestOfLove.Narrative.Actor::spawnedScenesCurrentCount
IL_004e: stfld System.Int32 TheForestOfLove.Services.Persistence.SavegameActorData::spawnedAreasCurrentCount
IL_0053: ldloc.0
IL_0054: ldarg.0
IL_0055: ldfld System.Int32 TheForestOfLove.Narrative.Actor::spawnedScenesRequiredCount
IL_005a: stfld System.Int32 TheForestOfLove.Services.Persistence.SavegameActorData::spawnedAreasRequiredCount
IL_005f: ldloc.0
IL_0060: ldarg.0
IL_0061: ldfld System.Int32 TheForestOfLove.Narrative.Actor::despawnedScenesCurrentCount
IL_0066: stfld System.Int32 TheForestOfLove.Services.Persistence.SavegameActorData::despawnedAreasCurrentCount
IL_006b: ldloc.0
IL_006c: ldarg.0
IL_006d: ldfld System.Int32 TheForestOfLove.Narrative.Actor::despawnedScenesRequiredCount
IL_0072: stfld System.Int32 TheForestOfLove.Services.Persistence.SavegameActorData::despawnedAreasRequiredCount
IL_0077: ldloc.0
IL_0078: ldarg.0
IL_0079: ldfld System.Single TheForestOfLove.Narrative.Actor::timeSinceLastDespawn
IL_007e: stfld System.Single TheForestOfLove.Services.Persistence.SavegameActorData::timeSinceLastDespawn
IL_0083: ldloc.0
IL_0084: ldarg.0
IL_0085: ldfld System.Single TheForestOfLove.Narrative.Actor::timeOfLastDespawn
IL_008a: stfld System.Single TheForestOfLove.Services.Persistence.SavegameActorData::timeOfLastDespawn
IL_008f: ldloc.0
IL_0090: ldarg.0
IL_0091: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsEncounteredOnce()
IL_0096: stfld System.Boolean TheForestOfLove.Services.Persistence.SavegameActorData::isEncounteredOnce
IL_009b: ldloc.0
IL_009c: ldarg.0
IL_009d: callvirt System.Boolean TheForestOfLove.Narrative.Actor::get_IsIntroduced()
IL_00a2: stfld System.Boolean TheForestOfLove.Services.Persistence.SavegameActorData::isIntroduced
IL_00a7: ldloc.0
IL_00a8: ldfld System.Collections.Generic.List`1<TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory> TheForestOfLove.Services.Persistence.SavegameActorData::spawnHistory
IL_00ad: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory>::Clear()
IL_00b2: ldarg.0
IL_00b3: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ActorSpawnHistory> TheForestOfLove.Narrative.Actor::spawnHistory
IL_00b8: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ActorSpawnHistory>::GetEnumerator()
IL_00bd: stloc.1
IL_00be: br.s IL_00fc
IL_00c0: ldloca.s V_1
IL_00c2: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ActorSpawnHistory>::get_Current()
IL_00c7: stloc.2
IL_00c8: ldloc.0
IL_00c9: ldfld System.Collections.Generic.List`1<TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory> TheForestOfLove.Services.Persistence.SavegameActorData::spawnHistory
IL_00ce: newobj System.Void TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory::.ctor()
IL_00d3: dup
IL_00d4: ldloc.2
IL_00d5: ldfld System.String TheForestOfLove.Narrative.ActorSpawnHistory::actorSavekey
IL_00da: stfld System.String TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory::actorSavekey
IL_00df: dup
IL_00e0: ldloc.2
IL_00e1: ldfld System.Boolean TheForestOfLove.Narrative.ActorSpawnHistory::isSpawned
IL_00e6: stfld System.Boolean TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory::isSpawned
IL_00eb: dup
IL_00ec: ldloc.2
IL_00ed: ldfld System.String TheForestOfLove.Narrative.ActorSpawnHistory::sceneSavekey
IL_00f2: stfld System.String TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory::sceneSavekey
IL_00f7: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory>::Add(!0)
IL_00fc: ldloca.s V_1
IL_00fe: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ActorSpawnHistory>::MoveNext()
IL_0103: brtrue.s IL_00c0
IL_0105: leave.s IL_0115
IL_0107: ldloca.s V_1
IL_0109: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ActorSpawnHistory>
IL_010f: callvirt System.Void System.IDisposable::Dispose()
IL_0114: endfinally
IL_0115: ldloc.0
IL_0116: ldarg.0
IL_0117: ldfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_011c: stfld System.Single TheForestOfLove.Services.Persistence.SavegameActorData::timeLastViewedInCritterLog
IL_0121: ldarg.0
IL_0122: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0127: brtrue.s IL_012c
IL_0129: ldnull
IL_012a: br.s IL_0137
IL_012c: ldarg.0
IL_012d: callvirt TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0132: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioDetail::keywordData
IL_0137: ldloc.0
IL_0138: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioDetailKeywordData
IL_013d: call System.Void TheForestOfLove.Services.Persistence.DataService::CreateBioKeywordData(System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>,System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>)
IL_0142: ldarg.0
IL_0143: callvirt TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::get_CurrentBioNotes()
IL_0148: brtrue.s IL_014d
IL_014a: ldnull
IL_014b: br.s IL_0158
IL_014d: ldarg.0
IL_014e: callvirt TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::get_CurrentBioNotes()
IL_0153: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioNotes::keywordData
IL_0158: ldloc.0
IL_0159: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioNotesKeywordData
IL_015e: call System.Void TheForestOfLove.Services.Persistence.DataService::CreateBioKeywordData(System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>,System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>)
IL_0163: ldarg.0
IL_0164: callvirt TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::get_CurrentBioKinks()
IL_0169: brtrue.s IL_016e
IL_016b: ldnull
IL_016c: br.s IL_0179
IL_016e: ldarg.0
IL_016f: callvirt TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::get_CurrentBioKinks()
IL_0174: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.BioKinks::keywordData
IL_0179: ldloc.0
IL_017a: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioKinksKeywordData
IL_017f: call System.Void TheForestOfLove.Services.Persistence.DataService::CreateBioKeywordData(System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>,System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>)
IL_0184: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0189: ldloc.0
IL_018a: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveActorData(TheForestOfLove.Services.Persistence.SavegameActorData)
IL_018f: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::CreateBioKeywordData(System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>,System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: brfalse IL_00ad
IL_0006: ldarg.0
IL_0007: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Values()
IL_000c: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,TheForestOfLove.Narrative.BioKeywordData>::GetEnumerator()
IL_0011: stloc.0
IL_0012: br.s IL_0091
IL_0014: ldloca.s V_0
IL_0016: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Narrative.BioKeywordData>::get_Current()
IL_001b: stloc.1
IL_001c: ldarg.1
IL_001d: ldloc.1
IL_001e: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKeywordData::keyword
IL_0023: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_0028: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::ContainsKey(!0)
IL_002d: brtrue.s IL_0064
IL_002f: ldarg.1
IL_0030: ldloc.1
IL_0031: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKeywordData::keyword
IL_0036: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_003b: newobj System.Void TheForestOfLove.Services.Persistence.SavegameBioKeywordData::.ctor()
IL_0040: dup
IL_0041: ldloc.1
IL_0042: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKeywordData::keyword
IL_0047: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_004c: stfld System.String TheForestOfLove.Services.Persistence.SavegameBioKeywordData::keywordSavekey
IL_0051: dup
IL_0052: ldloc.1
IL_0053: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_0058: stfld System.Single TheForestOfLove.Services.Persistence.SavegameBioKeywordData::timeUnlocked
IL_005d: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::Add(!0,!1)
IL_0062: br.s IL_0091
IL_0064: ldarg.1
IL_0065: ldloc.1
IL_0066: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKeywordData::keyword
IL_006b: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_0070: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Item(!0)
IL_0075: dup
IL_0076: ldloc.1
IL_0077: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKeywordData::keyword
IL_007c: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_0081: stfld System.String TheForestOfLove.Services.Persistence.SavegameBioKeywordData::keywordSavekey
IL_0086: ldloc.1
IL_0087: ldfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_008c: stfld System.Single TheForestOfLove.Services.Persistence.SavegameBioKeywordData::timeUnlocked
IL_0091: ldloca.s V_0
IL_0093: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Narrative.BioKeywordData>::MoveNext()
IL_0098: brtrue IL_0014
IL_009d: leave.s IL_00ad
IL_009f: ldloca.s V_0
IL_00a1: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Narrative.BioKeywordData>
IL_00a7: callvirt System.Void System.IDisposable::Dispose()
IL_00ac: endfinally
IL_00ad: ret
METHOD TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Services.Persistence.DataService::GetBioKeywordBySavekey(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsBySavekey
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsBySavekey
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find bio keyword by savekey "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Services.Persistence.DataService::GetBioKeywordByDbName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find bio keyword by db name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Services.Persistence.DataService::GetBioKeywordByPluginDbTriggerName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByPluginDbTriggerName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByPluginDbTriggerName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find bio keyword by plugin db trigger name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
