TYPE TheForestOfLove.Narrative.Actor
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
METHOD System.Void TheForestOfLove.Narrative.Actor::LoadBioKeywords(System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameBioKeywordData>,System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::GetEnumerator()
IL_0006: stloc.0
IL_0007: br.s IL_0051
IL_0009: ldloc.0
IL_000a: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Current()
IL_000f: stloc.1
IL_0010: ldloc.1
IL_0011: ldfld System.String TheForestOfLove.Services.Persistence.SavegameBioKeywordData::keywordSavekey
IL_0016: call TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Services.Persistence.DataService::GetBioKeywordBySavekey(System.String)
IL_001b: stloc.2
IL_001c: ldloc.2
IL_001d: brfalse.s IL_0051
IL_001f: ldarg.2
IL_0020: ldloc.2
IL_0021: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_0026: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::ContainsKey(!0)
IL_002b: brtrue.s IL_0051
IL_002d: ldarg.2
IL_002e: ldloc.2
IL_002f: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_0034: newobj System.Void TheForestOfLove.Narrative.BioKeywordData::.ctor()
IL_0039: dup
IL_003a: ldloc.2
IL_003b: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKeywordData::keyword
IL_0040: dup
IL_0041: ldloc.1
IL_0042: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameBioKeywordData::timeUnlocked
IL_0047: stfld System.Single TheForestOfLove.Narrative.BioKeywordData::timeUnlocked
IL_004c: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>::Add(!0,!1)
IL_0051: ldloc.0
IL_0052: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0057: brtrue.s IL_0009
IL_0059: leave.s IL_0065
IL_005b: ldloc.0
IL_005c: brfalse.s IL_0064
IL_005e: ldloc.0
IL_005f: callvirt System.Void System.IDisposable::Dispose()
IL_0064: endfinally
IL_0065: ret
METHOD System.Void TheForestOfLove.Narrative.Actor::UnlockBioKeyword(TheForestOfLove.Narrative.BioKeyword) | attributes=Public, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldarg.0
IL_0003: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0008: brfalse.s IL_0019
IL_000a: ldloc.0
IL_000b: ldarg.0
IL_000c: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0011: ldarg.1
IL_0012: callvirt System.Boolean TheForestOfLove.Narrative.BioDetail::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword)
IL_0017: or
IL_0018: stloc.0
IL_0019: ldarg.0
IL_001a: call TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::get_CurrentBioNotes()
IL_001f: brfalse.s IL_0030
IL_0021: ldloc.0
IL_0022: ldarg.0
IL_0023: call TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::get_CurrentBioNotes()
IL_0028: ldarg.1
IL_0029: callvirt System.Boolean TheForestOfLove.Narrative.BioNotes::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword)
IL_002e: or
IL_002f: stloc.0
IL_0030: ldarg.0
IL_0031: call TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::get_CurrentBioKinks()
IL_0036: brfalse.s IL_0047
IL_0038: ldloc.0
IL_0039: ldarg.0
IL_003a: call TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::get_CurrentBioKinks()
IL_003f: ldarg.1
IL_0040: callvirt System.Boolean TheForestOfLove.Narrative.BioKinks::TryUnlockKeyword(TheForestOfLove.Narrative.BioKeyword)
IL_0045: or
IL_0046: stloc.0
IL_0047: ldloc.0
IL_0048: brfalse.s IL_0056
IL_004a: ldsfld TheForestOfLove.Events.ActorBioKeywordEvent TheForestOfLove.Events.NarrativeEvents::onUnlockActorBioKeyword
IL_004f: ldarg.0
IL_0050: ldarg.1
IL_0051: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,TheForestOfLove.Narrative.BioKeyword>::Invoke(!0,!1)
IL_0056: ret
