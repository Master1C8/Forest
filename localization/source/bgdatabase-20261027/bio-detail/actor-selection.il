TYPE TheForestOfLove.Narrative.Actor
METHOD TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::_currentBioDetail
IL_0006: brtrue.s IL_0014
IL_0008: ldarg.0
IL_0009: ldarg.0
IL_000a: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::ChooseBioDetail()
IL_000f: stfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::_currentBioDetail
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::_currentBioDetail
IL_001a: ret
METHOD System.Void TheForestOfLove.Narrative.Actor::Load(TheForestOfLove.Services.Persistence.SavegameActorData) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0004
IL_0003: ret
IL_0004: ldarg.0
IL_0005: ldarg.1
IL_0006: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameActorData::timeSinceLastDialogue
IL_000b: stfld System.Single TheForestOfLove.Narrative.Actor::timeSinceLastDialogue
IL_0010: ldarg.0
IL_0011: ldarg.1
IL_0012: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameActorData::timeOfLastDialogue
IL_0017: stfld System.Single TheForestOfLove.Narrative.Actor::timeOfLastDialogue
IL_001c: ldarg.0
IL_001d: ldarg.1
IL_001e: ldfld System.Int32 TheForestOfLove.Services.Persistence.SavegameActorData::spawnedAreasCurrentCount
IL_0023: stfld System.Int32 TheForestOfLove.Narrative.Actor::spawnedScenesCurrentCount
IL_0028: ldarg.0
IL_0029: ldarg.1
IL_002a: ldfld System.Int32 TheForestOfLove.Services.Persistence.SavegameActorData::spawnedAreasRequiredCount
IL_002f: stfld System.Int32 TheForestOfLove.Narrative.Actor::spawnedScenesRequiredCount
IL_0034: ldarg.0
IL_0035: ldarg.1
IL_0036: ldfld System.Int32 TheForestOfLove.Services.Persistence.SavegameActorData::despawnedAreasCurrentCount
IL_003b: stfld System.Int32 TheForestOfLove.Narrative.Actor::despawnedScenesCurrentCount
IL_0040: ldarg.0
IL_0041: ldarg.1
IL_0042: ldfld System.Int32 TheForestOfLove.Services.Persistence.SavegameActorData::despawnedAreasRequiredCount
IL_0047: stfld System.Int32 TheForestOfLove.Narrative.Actor::despawnedScenesRequiredCount
IL_004c: ldarg.0
IL_004d: ldarg.1
IL_004e: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameActorData::timeSinceLastDespawn
IL_0053: stfld System.Single TheForestOfLove.Narrative.Actor::timeSinceLastDespawn
IL_0058: ldarg.0
IL_0059: ldarg.1
IL_005a: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameActorData::timeOfLastDespawn
IL_005f: stfld System.Single TheForestOfLove.Narrative.Actor::timeOfLastDespawn
IL_0064: ldarg.1
IL_0065: ldfld System.Collections.Generic.List`1<TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory> TheForestOfLove.Services.Persistence.SavegameActorData::spawnHistory
IL_006a: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory>::GetEnumerator()
IL_006f: stloc.0
IL_0070: br.s IL_00d2
IL_0072: ldloca.s V_0
IL_0074: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory>::get_Current()
IL_0079: stloc.1
IL_007a: ldloc.1
IL_007b: ldfld System.String TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory::sceneSavekey
IL_0080: call TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordBySavekey(System.String)
IL_0085: stloc.2
IL_0086: ldarg.0
IL_0087: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ActorSpawnHistory> TheForestOfLove.Narrative.Actor::spawnHistory
IL_008c: newobj System.Void TheForestOfLove.Narrative.ActorSpawnHistory::.ctor()
IL_0091: dup
IL_0092: ldarg.0
IL_0093: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0098: stfld System.String TheForestOfLove.Narrative.ActorSpawnHistory::actorDbName
IL_009d: dup
IL_009e: ldloc.1
IL_009f: ldfld System.String TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory::actorSavekey
IL_00a4: stfld System.String TheForestOfLove.Narrative.ActorSpawnHistory::actorSavekey
IL_00a9: dup
IL_00aa: ldloc.1
IL_00ab: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory::isSpawned
IL_00b0: stfld System.Boolean TheForestOfLove.Narrative.ActorSpawnHistory::isSpawned
IL_00b5: dup
IL_00b6: ldloc.2
IL_00b7: ldfld System.String TheForestOfLove.Narrative.AreaRecord::unitySceneName
IL_00bc: stfld System.String TheForestOfLove.Narrative.ActorSpawnHistory::sceneName
IL_00c1: dup
IL_00c2: ldloc.2
IL_00c3: ldfld System.String TheForestOfLove.Narrative.AreaRecord::savekey
IL_00c8: stfld System.String TheForestOfLove.Narrative.ActorSpawnHistory::sceneSavekey
IL_00cd: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ActorSpawnHistory>::Add(!0)
IL_00d2: ldloca.s V_0
IL_00d4: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory>::MoveNext()
IL_00d9: brtrue.s IL_0072
IL_00db: leave.s IL_00eb
IL_00dd: ldloca.s V_0
IL_00df: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Services.Persistence.SavegameActorSpawnHistory>
IL_00e5: callvirt System.Void System.IDisposable::Dispose()
IL_00ea: endfinally
IL_00eb: ldarg.0
IL_00ec: ldarg.1
IL_00ed: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameActorData::isEncounteredOnce
IL_00f2: call System.Void TheForestOfLove.Narrative.Actor::set_IsEncounteredOnce(System.Boolean)
IL_00f7: ldarg.0
IL_00f8: ldarg.1
IL_00f9: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameActorData::isIntroduced
IL_00fe: call System.Void TheForestOfLove.Narrative.Actor::set_IsIntroduced(System.Boolean)
IL_0103: ldarg.0
IL_0104: ldarg.1
IL_0105: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameActorData::timeLastViewedInCritterLog
IL_010a: stfld System.Single TheForestOfLove.Narrative.Actor::timeLastViewedInCritterLog
IL_010f: ldarg.0
IL_0110: ldarg.1
IL_0111: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioDetailKeywordData
IL_0116: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Values()
IL_011b: ldarg.0
IL_011c: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.Actor::keywordDataDetail
IL_0121: call System.Void TheForestOfLove.Narrative.Actor::LoadBioKeywords(System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameBioKeywordData>,System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>)
IL_0126: ldarg.0
IL_0127: ldarg.1
IL_0128: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioNotesKeywordData
IL_012d: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Values()
IL_0132: ldarg.0
IL_0133: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.Actor::keywordDataNotes
IL_0138: call System.Void TheForestOfLove.Narrative.Actor::LoadBioKeywords(System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameBioKeywordData>,System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>)
IL_013d: ldarg.0
IL_013e: ldarg.1
IL_013f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioKinksKeywordData
IL_0144: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Values()
IL_0149: ldarg.0
IL_014a: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.Actor::keywordDataKinks
IL_014f: call System.Void TheForestOfLove.Narrative.Actor::LoadBioKeywords(System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameBioKeywordData>,System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>)
IL_0154: ret
METHOD TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::ChooseBioDetail() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail> TheForestOfLove.Narrative.Actor::bioDetails
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_0057
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>::get_Current()
IL_0015: stloc.1
IL_0016: ldloc.1
IL_0017: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.BioDetail::enableWithTags
IL_001c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_0021: stloc.2
IL_0022: br.s IL_003e
IL_0024: ldloca.s V_2
IL_0026: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_002b: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_0030: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_0035: brfalse.s IL_003e
IL_0037: ldloc.1
IL_0038: stloc.3
IL_0039: leave IL_00cb
IL_003e: ldloca.s V_2
IL_0040: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_0045: brtrue.s IL_0024
IL_0047: leave.s IL_0057
IL_0049: ldloca.s V_2
IL_004b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_0051: callvirt System.Void System.IDisposable::Dispose()
IL_0056: endfinally
IL_0057: ldloca.s V_0
IL_0059: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>::MoveNext()
IL_005e: brtrue.s IL_000e
IL_0060: leave.s IL_0070
IL_0062: ldloca.s V_0
IL_0064: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>
IL_006a: callvirt System.Void System.IDisposable::Dispose()
IL_006f: endfinally
IL_0070: ldarg.0
IL_0071: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail> TheForestOfLove.Narrative.Actor::bioDetails
IL_0076: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail>::GetEnumerator()
IL_007b: stloc.0
IL_007c: br.s IL_0095
IL_007e: ldloca.s V_0
IL_0080: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>::get_Current()
IL_0085: stloc.s V_4
IL_0087: ldloc.s V_4
IL_0089: ldfld System.Boolean TheForestOfLove.Narrative.BioDetail::isDefault
IL_008e: brfalse.s IL_0095
IL_0090: ldloc.s V_4
IL_0092: stloc.3
IL_0093: leave.s IL_00cb
IL_0095: ldloca.s V_0
IL_0097: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>::MoveNext()
IL_009c: brtrue.s IL_007e
IL_009e: leave.s IL_00ae
IL_00a0: ldloca.s V_0
IL_00a2: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>
IL_00a8: callvirt System.Void System.IDisposable::Dispose()
IL_00ad: endfinally
IL_00ae: ldarg.0
IL_00af: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail> TheForestOfLove.Narrative.Actor::bioDetails
IL_00b4: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail>::get_Count()
IL_00b9: ldc.i4.0
IL_00ba: bgt.s IL_00be
IL_00bc: ldnull
IL_00bd: ret
IL_00be: ldarg.0
IL_00bf: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail> TheForestOfLove.Narrative.Actor::bioDetails
IL_00c4: ldc.i4.0
IL_00c5: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail>::get_Item(System.Int32)
IL_00ca: ret
IL_00cb: ldloc.3
IL_00cc: ret
METHOD System.Void TheForestOfLove.Narrative.Actor::SetDirtyBioData() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: stfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::_currentBioDetail
IL_0007: ldarg.0
IL_0008: ldnull
IL_0009: stfld TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::_currentBioNotes
IL_000e: ldarg.0
IL_000f: ldnull
IL_0010: stfld TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::_currentBioKinks
IL_0015: ret
