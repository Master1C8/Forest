TYPE TheForestOfLove.Services.Persistence.DataService
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::RestoreNonlinearContent(TheForestOfLove.Services.Persistence.Savestate) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt TheForestOfLove.Services.Persistence.SavegameGeneralData TheForestOfLove.Services.Persistence.Savestate::LoadGeneralData()
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0015
IL_000a: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_000f: ldloc.0
IL_0010: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveGeneralData(TheForestOfLove.Services.Persistence.SavegameGeneralData)
IL_0015: ldarg.0
IL_0016: callvirt System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory> TheForestOfLove.Services.Persistence.Savestate::LoadGameplayLogHistoryData()
IL_001b: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory>::GetEnumerator()
IL_0020: stloc.3
IL_0021: br.s IL_003c
IL_0023: ldloc.3
IL_0024: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory>::get_Current()
IL_0029: stloc.s V_4
IL_002b: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0030: ldloc.s V_4
IL_0032: callvirt TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory::DeepCopy()
IL_0037: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveGameplayLogHistoryData(TheForestOfLove.Services.Persistence.SavegameGameplayLogHistory)
IL_003c: ldloc.3
IL_003d: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0042: brtrue.s IL_0023
IL_0044: leave.s IL_0050
IL_0046: ldloc.3
IL_0047: brfalse.s IL_004f
IL_0049: ldloc.3
IL_004a: callvirt System.Void System.IDisposable::Dispose()
IL_004f: endfinally
IL_0050: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_0055: stloc.1
IL_0056: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_005b: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actors
IL_0060: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor>::GetEnumerator()
IL_0065: stloc.s V_5
IL_0067: br IL_029b
IL_006c: ldloca.s V_5
IL_006e: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Actor>::get_Current()
IL_0073: stloc.s V_6
IL_0075: ldarg.0
IL_0076: ldloc.s V_6
IL_0078: ldfld System.String TheForestOfLove.Narrative.Actor::savekey
IL_007d: callvirt TheForestOfLove.Services.Persistence.SavegameActorData TheForestOfLove.Services.Persistence.Savestate::LoadActorData(System.String)
IL_0082: stloc.s V_7
IL_0084: ldnull
IL_0085: stloc.s V_8
IL_0087: ldloc.s V_6
IL_0089: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isExcludedFromSavestate
IL_008e: brtrue.s IL_00b1
IL_0090: newobj System.Void TheForestOfLove.Services.Persistence.SavegameActorData::.ctor()
IL_0095: stloc.s V_8
IL_0097: ldloc.s V_8
IL_0099: ldloc.s V_6
IL_009b: ldfld System.String TheForestOfLove.Narrative.Actor::savekey
IL_00a0: stfld System.String TheForestOfLove.Services.Persistence.SavegameActorData::actorSavekey
IL_00a5: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_00aa: ldloc.s V_8
IL_00ac: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveActorData(TheForestOfLove.Services.Persistence.SavegameActorData)
IL_00b1: ldarg.0
IL_00b2: ldloc.s V_7
IL_00b4: ldloc.s V_8
IL_00b6: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_00bb: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_00c0: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_00c5: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGossipByActorDbName
IL_00ca: ldloc.s V_6
IL_00cc: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00d1: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_00d6: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopyDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>)
IL_00db: ldarg.0
IL_00dc: ldloc.s V_7
IL_00de: ldloc.s V_8
IL_00e0: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_00e5: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_00ea: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_00ef: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeDateByActorDbName
IL_00f4: ldloc.s V_6
IL_00f6: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00fb: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0100: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopyDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>)
IL_0105: ldarg.0
IL_0106: ldloc.s V_7
IL_0108: ldloc.s V_8
IL_010a: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_010f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0114: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0119: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGiftByActorDbName
IL_011e: ldloc.s V_6
IL_0120: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0125: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_012a: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopyDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>)
IL_012f: ldarg.0
IL_0130: ldloc.s V_6
IL_0132: ldloc.s V_7
IL_0134: ldloc.s V_8
IL_0136: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_013b: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0140: ldloc.1
IL_0141: ldstr "MelodyFlipbookQuest"
IL_0146: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_014b: ldarg.0
IL_014c: ldloc.s V_6
IL_014e: ldloc.s V_7
IL_0150: ldloc.s V_8
IL_0152: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0157: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_015c: ldloc.1
IL_015d: ldstr "GlitchQuest"
IL_0162: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_0167: ldarg.0
IL_0168: ldloc.s V_6
IL_016a: ldloc.s V_7
IL_016c: ldloc.s V_8
IL_016e: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0173: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0178: ldloc.1
IL_0179: ldstr "BlessingOfTheBells_History"
IL_017e: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_0183: ldarg.0
IL_0184: ldloc.s V_6
IL_0186: ldloc.s V_7
IL_0188: ldloc.s V_8
IL_018a: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_018f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0194: ldloc.1
IL_0195: ldstr "BlessingOfTheBells_Mabel"
IL_019a: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_019f: ldarg.0
IL_01a0: ldloc.s V_6
IL_01a2: ldloc.s V_7
IL_01a4: ldloc.s V_8
IL_01a6: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_01ab: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_01b0: ldloc.1
IL_01b1: ldstr "BootyLineUpQuest"
IL_01b6: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_01bb: ldarg.0
IL_01bc: ldloc.s V_6
IL_01be: ldloc.s V_7
IL_01c0: ldloc.s V_8
IL_01c2: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_01c7: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_01cc: ldloc.1
IL_01cd: ldstr "BootyLineUpFemalesQuest"
IL_01d2: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_01d7: ldarg.0
IL_01d8: ldloc.s V_6
IL_01da: ldloc.s V_7
IL_01dc: ldloc.s V_8
IL_01de: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_01e3: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_01e8: ldloc.1
IL_01e9: ldstr "MaverickSideHustleQuest"
IL_01ee: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_01f3: ldarg.0
IL_01f4: ldloc.s V_6
IL_01f6: ldloc.s V_7
IL_01f8: ldloc.s V_8
IL_01fa: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_01ff: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0204: ldloc.1
IL_0205: ldstr "SeasonsGreetingsQuest"
IL_020a: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_020f: ldarg.0
IL_0210: ldloc.s V_6
IL_0212: ldloc.s V_7
IL_0214: ldloc.s V_8
IL_0216: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_021b: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0220: ldloc.1
IL_0221: ldstr "Vslice_BearQuest"
IL_0226: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_022b: ldarg.0
IL_022c: ldloc.s V_6
IL_022e: ldloc.s V_7
IL_0230: ldloc.s V_8
IL_0232: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0237: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_023c: ldloc.1
IL_023d: ldstr "Vslice_BeaverQuest"
IL_0242: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_0247: ldarg.0
IL_0248: ldloc.s V_6
IL_024a: ldloc.s V_7
IL_024c: ldloc.s V_8
IL_024e: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0253: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0258: ldloc.1
IL_0259: ldstr "Vslice_BunnyQuest"
IL_025e: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_0263: ldarg.0
IL_0264: ldloc.s V_6
IL_0266: ldloc.s V_7
IL_0268: ldloc.s V_8
IL_026a: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_026f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0274: ldloc.1
IL_0275: ldstr "Vslice_MouseQuest"
IL_027a: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_027f: ldarg.0
IL_0280: ldloc.s V_6
IL_0282: ldloc.s V_7
IL_0284: ldloc.s V_8
IL_0286: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_028b: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0290: ldloc.1
IL_0291: ldstr "Vslice_OtterQuest"
IL_0296: call System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)
IL_029b: ldloca.s V_5
IL_029d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Actor>::MoveNext()
IL_02a2: brtrue IL_006c
IL_02a7: leave.s IL_02b7
IL_02a9: ldloca.s V_5
IL_02ab: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Actor>
IL_02b1: callvirt System.Void System.IDisposable::Dispose()
IL_02b6: endfinally
IL_02b7: ldarg.0
IL_02b8: ldstr "Gifts_Augustus_Rosetta"
IL_02bd: ldc.i4 260
IL_02c2: call System.Void TheForestOfLove.Services.Persistence.DataService::EnsureInventoryItemIfDialogueComplete(TheForestOfLove.Services.Persistence.Savestate,System.String,TheForestOfLove.Inventory.InventoryItemType)
IL_02c7: ldarg.0
IL_02c8: ldstr "Gifts_Maverick_BrokenRadio"
IL_02cd: ldc.i4 215
IL_02d2: call System.Void TheForestOfLove.Services.Persistence.DataService::EnsureInventoryItemIfDialogueComplete(TheForestOfLove.Services.Persistence.Savestate,System.String,TheForestOfLove.Inventory.InventoryItemType)
IL_02d7: ldarg.0
IL_02d8: ldstr "Gifts_Oliver_Horseshoe"
IL_02dd: ldc.i4 220
IL_02e2: call System.Void TheForestOfLove.Services.Persistence.DataService::EnsureInventoryItemIfDialogueComplete(TheForestOfLove.Services.Persistence.Savestate,System.String,TheForestOfLove.Inventory.InventoryItemType)
IL_02e7: ldarg.0
IL_02e8: ldstr "Gifts_Peter_Monocle"
IL_02ed: ldc.i4 240
IL_02f2: call System.Void TheForestOfLove.Services.Persistence.DataService::EnsureInventoryItemIfDialogueComplete(TheForestOfLove.Services.Persistence.Savestate,System.String,TheForestOfLove.Inventory.InventoryItemType)
IL_02f7: ldarg.0
IL_02f8: ldstr "Gifts_Scarlett_Map"
IL_02fd: ldc.i4 230
IL_0302: call System.Void TheForestOfLove.Services.Persistence.DataService::EnsureInventoryItemIfDialogueComplete(TheForestOfLove.Services.Persistence.Savestate,System.String,TheForestOfLove.Inventory.InventoryItemType)
IL_0307: ldarg.0
IL_0308: ldstr "SeasonsGreetingsQuest_TalkToDustin"
IL_030d: ldc.i4 390
IL_0312: call System.Void TheForestOfLove.Services.Persistence.DataService::EnsureInventoryItemIfDialogueComplete(TheForestOfLove.Services.Persistence.Savestate,System.String,TheForestOfLove.Inventory.InventoryItemType)
IL_0317: ldarg.0
IL_0318: ldstr "MelodyFlipbookQuest_ReturnToOtter"
IL_031d: ldc.i4 470
IL_0322: call System.Void TheForestOfLove.Services.Persistence.DataService::EnsureInventoryItemIfDialogueComplete(TheForestOfLove.Services.Persistence.Savestate,System.String,TheForestOfLove.Inventory.InventoryItemType)
IL_0327: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_032c: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.DataManifest::adventuresByAdventureType
IL_0331: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Values()
IL_0336: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::GetEnumerator()
IL_033b: stloc.s V_9
IL_033d: br.s IL_0367
IL_033f: ldloca.s V_9
IL_0341: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Current()
IL_0346: stloc.s V_10
IL_0348: ldarg.0
IL_0349: ldloc.s V_10
IL_034b: ldfld System.String TheForestOfLove.Narrative.Adventure::Savekey
IL_0350: callvirt TheForestOfLove.Services.Persistence.SavegameAdventureData TheForestOfLove.Services.Persistence.Savestate::LoadAdventureData(System.String)
IL_0355: stloc.s V_11
IL_0357: ldloc.s V_11
IL_0359: brfalse.s IL_0367
IL_035b: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0360: ldloc.s V_11
IL_0362: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveAdventureData(TheForestOfLove.Services.Persistence.SavegameAdventureData)
IL_0367: ldloca.s V_9
IL_0369: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::MoveNext()
IL_036e: brtrue.s IL_033f
IL_0370: leave.s IL_0380
IL_0372: ldloca.s V_9
IL_0374: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>
IL_037a: callvirt System.Void System.IDisposable::Dispose()
IL_037f: endfinally
IL_0380: ldarg.0
IL_0381: ldstr "showed_adventure_mode_tutorial"
IL_0386: callvirt TheForestOfLove.Services.Persistence.SavegameTriggerData TheForestOfLove.Services.Persistence.Savestate::LoadTriggerData(System.String)
IL_038b: stloc.2
IL_038c: ldloc.2
IL_038d: brfalse.s IL_039a
IL_038f: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0394: ldloc.2
IL_0395: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveTriggerData(TheForestOfLove.Services.Persistence.SavegameTriggerData)
IL_039a: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_039f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chapters
IL_03a4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_03a9: stloc.s V_12
IL_03ab: br.s IL_03d5
IL_03ad: ldloca.s V_12
IL_03af: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_03b4: stloc.s V_13
IL_03b6: ldarg.0
IL_03b7: ldloc.s V_13
IL_03b9: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::savekey
IL_03be: callvirt TheForestOfLove.Services.Persistence.SavegameChapterData TheForestOfLove.Services.Persistence.Savestate::LoadChapterData(System.String)
IL_03c3: stloc.s V_14
IL_03c5: ldloc.s V_14
IL_03c7: brfalse.s IL_03d5
IL_03c9: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_03ce: ldloc.s V_14
IL_03d0: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveChapterData(TheForestOfLove.Services.Persistence.SavegameChapterData)
IL_03d5: ldloca.s V_12
IL_03d7: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>::MoveNext()
IL_03dc: brtrue.s IL_03ad
IL_03de: leave.s IL_03ee
IL_03e0: ldloca.s V_12
IL_03e2: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ChapterRecord>
IL_03e8: callvirt System.Void System.IDisposable::Dispose()
IL_03ed: endfinally
IL_03ee: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_03f3: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::movies
IL_03f8: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord>::GetEnumerator()
IL_03fd: stloc.s V_15
IL_03ff: br.s IL_0429
IL_0401: ldloca.s V_15
IL_0403: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>::get_Current()
IL_0408: stloc.s V_16
IL_040a: ldarg.0
IL_040b: ldloc.s V_16
IL_040d: ldfld System.String TheForestOfLove.Narrative.MovieRecord::savekey
IL_0412: callvirt TheForestOfLove.Services.Persistence.SavegameMovieData TheForestOfLove.Services.Persistence.Savestate::LoadMovieData(System.String)
IL_0417: stloc.s V_17
IL_0419: ldloc.s V_17
IL_041b: brfalse.s IL_0429
IL_041d: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0422: ldloc.s V_17
IL_0424: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveMovieData(TheForestOfLove.Services.Persistence.SavegameMovieData)
IL_0429: ldloca.s V_15
IL_042b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>::MoveNext()
IL_0430: brtrue.s IL_0401
IL_0432: leave.s IL_0442
IL_0434: ldloca.s V_15
IL_0436: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.MovieRecord>
IL_043c: callvirt System.Void System.IDisposable::Dispose()
IL_0441: endfinally
IL_0442: ldsfld TheForestOfLove.Services.Persistence.DataService TheForestOfLove.Services.Persistence.DataService::_instance
IL_0447: callvirt System.Void TheForestOfLove.Services.Persistence.DataService::GenerateManifest()
IL_044c: ret
METHOD System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopyDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.s dialogues
IL_0002: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0007: stloc.0
IL_0008: br IL_043b
IL_000d: ldloca.s V_0
IL_000f: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0014: stloc.1
IL_0015: ldarg.0
IL_0016: ldloc.1
IL_0017: ldfld System.String TheForestOfLove.Narrative.Dialogue::savekey
IL_001c: callvirt TheForestOfLove.Services.Persistence.SavegameDialogueData TheForestOfLove.Services.Persistence.Savestate::LoadDialogueData(System.String)
IL_0021: stloc.2
IL_0022: ldloc.2
IL_0023: brtrue.s IL_002a
IL_0025: leave IL_0457
IL_002a: ldloc.1
IL_002b: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0030: ldstr "MelodyFlipbookQuest_IntroFromOtter"
IL_0035: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_003a: brfalse.s IL_008e
IL_003c: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0041: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_0046: ldstr "MelodyFlipbookQuest"
IL_004b: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_0050: stloc.s V_5
IL_0052: ldarg.0
IL_0053: ldloc.s V_5
IL_0055: ldfld System.String TheForestOfLove.Narrative.Quest::savekey
IL_005a: callvirt TheForestOfLove.Services.Persistence.SavegameQuestData TheForestOfLove.Services.Persistence.Savestate::LoadQuestData(System.String)
IL_005f: stloc.s V_6
IL_0061: ldloc.s V_6
IL_0063: brtrue.s IL_0068
IL_0065: ldnull
IL_0066: br.s IL_0074
IL_0068: ldloc.s V_6
IL_006a: ldfld System.String TheForestOfLove.Services.Persistence.SavegameQuestData::statusSavekey
IL_006f: call TheForestOfLove.Narrative.QuestStatusRecord TheForestOfLove.Services.Persistence.DataService::GetQuestStatusRecordBySavekey(System.String)
IL_0074: stloc.s V_7
IL_0076: ldloc.s V_7
IL_0078: brtrue.s IL_007d
IL_007a: ldc.i4.0
IL_007b: br.s IL_0084
IL_007d: ldloc.s V_7
IL_007f: ldfld TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.QuestStatusRecord::status
IL_0084: ldc.i4 200
IL_0089: bne.un IL_043b
IL_008e: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0093: ldloc.2
IL_0094: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveDialogueData(TheForestOfLove.Services.Persistence.SavegameDialogueData)
IL_0099: ldloc.2
IL_009a: ldfld System.String TheForestOfLove.Services.Persistence.SavegameDialogueData::statusSavekey
IL_009f: call TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Services.Persistence.DataService::GetDialogueStatusRecordBySavekey(System.String)
IL_00a4: stloc.3
IL_00a5: ldloc.3
IL_00a6: brtrue.s IL_00ab
IL_00a8: ldc.i4.0
IL_00a9: br.s IL_00b1
IL_00ab: ldloc.3
IL_00ac: ldfld TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.DialogueStatusRecord::status
IL_00b1: stloc.s V_4
IL_00b3: ldloc.1
IL_00b4: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_00b9: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_00be: stloc.s V_8
IL_00c0: br.s IL_00ea
IL_00c2: ldloca.s V_8
IL_00c4: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_00c9: stloc.s V_9
IL_00cb: ldarg.0
IL_00cc: ldloc.s V_9
IL_00ce: ldfld System.String TheForestOfLove.Narrative.Arc::generatedSavekey
IL_00d3: callvirt TheForestOfLove.Services.Persistence.SavegameArcData TheForestOfLove.Services.Persistence.Savestate::LoadArcData(System.String)
IL_00d8: stloc.s V_10
IL_00da: ldloc.s V_10
IL_00dc: brfalse.s IL_00ea
IL_00de: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_00e3: ldloc.s V_10
IL_00e5: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveArcData(TheForestOfLove.Services.Persistence.SavegameArcData)
IL_00ea: ldloca.s V_8
IL_00ec: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_00f1: brtrue.s IL_00c2
IL_00f3: leave.s IL_0103
IL_00f5: ldloca.s V_8
IL_00f7: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_00fd: callvirt System.Void System.IDisposable::Dispose()
IL_0102: endfinally
IL_0103: ldloc.1
IL_0104: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_0109: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::GetEnumerator()
IL_010e: stloc.s V_11
IL_0110: br.s IL_017b
IL_0112: ldloca.s V_11
IL_0114: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::get_Current()
IL_0119: stloc.s V_12
IL_011b: ldloc.s V_12
IL_011d: callvirt System.Type System.Object::GetType()
IL_0122: ldtoken TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger
IL_0127: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_012c: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_0131: brfalse.s IL_017b
IL_0133: ldloc.s V_12
IL_0135: castclass TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger
IL_013a: stloc.s V_13
IL_013c: ldloc.s V_13
IL_013e: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_0143: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0148: stloc.s V_14
IL_014a: ldloc.s V_14
IL_014c: brtrue.s IL_015c
IL_014e: ldloc.s V_13
IL_0150: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_0155: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::CreateTriggerOnTheFly(System.String)
IL_015a: stloc.s V_14
IL_015c: ldarg.0
IL_015d: ldloc.s V_14
IL_015f: ldfld System.String TheForestOfLove.Narrative.Trigger::savekey
IL_0164: callvirt TheForestOfLove.Services.Persistence.SavegameTriggerData TheForestOfLove.Services.Persistence.Savestate::LoadTriggerData(System.String)
IL_0169: stloc.s V_15
IL_016b: ldloc.s V_15
IL_016d: brfalse.s IL_017b
IL_016f: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_0174: ldloc.s V_15
IL_0176: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveTriggerData(TheForestOfLove.Services.Persistence.SavegameTriggerData)
IL_017b: ldloca.s V_11
IL_017d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::MoveNext()
IL_0182: brtrue.s IL_0112
IL_0184: leave.s IL_0194
IL_0186: ldloca.s V_11
IL_0188: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>
IL_018e: callvirt System.Void System.IDisposable::Dispose()
IL_0193: endfinally
IL_0194: ldloc.s V_4
IL_0196: ldc.i4 200
IL_019b: bne.un IL_026c
IL_01a0: ldloc.1
IL_01a1: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.Dialogue::triggersRequireAny_bugfix
IL_01a6: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_01ab: stloc.s V_16
IL_01ad: br.s IL_01ed
IL_01af: ldloca.s V_16
IL_01b1: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_01b6: stloc.s V_17
IL_01b8: ldloc.s V_17
IL_01ba: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_01bf: stloc.s V_18
IL_01c1: ldloc.s V_18
IL_01c3: brtrue.s IL_01ce
IL_01c5: ldloc.s V_17
IL_01c7: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::CreateTriggerOnTheFly(System.String)
IL_01cc: stloc.s V_18
IL_01ce: ldarg.0
IL_01cf: ldloc.s V_18
IL_01d1: ldfld System.String TheForestOfLove.Narrative.Trigger::savekey
IL_01d6: callvirt TheForestOfLove.Services.Persistence.SavegameTriggerData TheForestOfLove.Services.Persistence.Savestate::LoadTriggerData(System.String)
IL_01db: stloc.s V_19
IL_01dd: ldloc.s V_19
IL_01df: brfalse.s IL_01ed
IL_01e1: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_01e6: ldloc.s V_19
IL_01e8: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveTriggerData(TheForestOfLove.Services.Persistence.SavegameTriggerData)
IL_01ed: ldloca.s V_16
IL_01ef: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_01f4: brtrue.s IL_01af
IL_01f6: leave.s IL_0206
IL_01f8: ldloca.s V_16
IL_01fa: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_0200: callvirt System.Void System.IDisposable::Dispose()
IL_0205: endfinally
IL_0206: ldloc.1
IL_0207: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.Dialogue::triggersRequireAll_bugfix
IL_020c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_0211: stloc.s V_16
IL_0213: br.s IL_0253
IL_0215: ldloca.s V_16
IL_0217: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_021c: stloc.s V_20
IL_021e: ldloc.s V_20
IL_0220: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0225: stloc.s V_21
IL_0227: ldloc.s V_21
IL_0229: brtrue.s IL_0234
IL_022b: ldloc.s V_20
IL_022d: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::CreateTriggerOnTheFly(System.String)
IL_0232: stloc.s V_21
IL_0234: ldarg.0
IL_0235: ldloc.s V_21
IL_0237: ldfld System.String TheForestOfLove.Narrative.Trigger::savekey
IL_023c: callvirt TheForestOfLove.Services.Persistence.SavegameTriggerData TheForestOfLove.Services.Persistence.Savestate::LoadTriggerData(System.String)
IL_0241: stloc.s V_22
IL_0243: ldloc.s V_22
IL_0245: brfalse.s IL_0253
IL_0247: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.DataService::get_Savestate()
IL_024c: ldloc.s V_22
IL_024e: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveTriggerData(TheForestOfLove.Services.Persistence.SavegameTriggerData)
IL_0253: ldloca.s V_16
IL_0255: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_025a: brtrue.s IL_0215
IL_025c: leave.s IL_026c
IL_025e: ldloca.s V_16
IL_0260: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_0266: callvirt System.Void System.IDisposable::Dispose()
IL_026b: endfinally
IL_026c: ldloc.s V_4
IL_026e: ldc.i4 200
IL_0273: bne.un IL_043b
IL_0278: ldarg.2
IL_0279: brfalse IL_043b
IL_027e: ldarg.1
IL_027f: brfalse IL_043b
IL_0284: ldarg.3
IL_0285: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::GetEnumerator()
IL_028a: stloc.s V_23
IL_028c: br IL_041f
IL_0291: ldloca.s V_23
IL_0293: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKeyword>::get_Current()
IL_0298: stloc.s V_24
IL_029a: ldloc.s V_24
IL_029c: ldfld System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Narrative.BioKeyword::unlockedByDialogueDbNames
IL_02a1: ldloc.1
IL_02a2: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_02a7: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Contains(!0)
IL_02ac: brfalse IL_041f
IL_02b1: ldarg.1
IL_02b2: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioDetailKeywordData
IL_02b7: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Values()
IL_02bc: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::GetEnumerator()
IL_02c1: stloc.s V_25
IL_02c3: br.s IL_0312
IL_02c5: ldloca.s V_25
IL_02c7: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Current()
IL_02cc: stloc.s V_26
IL_02ce: ldloc.s V_26
IL_02d0: ldfld System.String TheForestOfLove.Services.Persistence.SavegameBioKeywordData::keywordSavekey
IL_02d5: ldloc.s V_24
IL_02d7: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_02dc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02e1: brfalse.s IL_0312
IL_02e3: ldarg.2
IL_02e4: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioDetailKeywordData
IL_02e9: ldloc.s V_24
IL_02eb: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_02f0: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::ContainsKey(!0)
IL_02f5: brtrue.s IL_031b
IL_02f7: ldarg.2
IL_02f8: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioDetailKeywordData
IL_02fd: ldloc.s V_24
IL_02ff: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_0304: ldloc.s V_26
IL_0306: callvirt TheForestOfLove.Services.Persistence.SavegameBioKeywordData TheForestOfLove.Services.Persistence.SavegameBioKeywordData::DeepCopy()
IL_030b: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::Add(!0,!1)
IL_0310: leave.s IL_032b
IL_0312: ldloca.s V_25
IL_0314: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::MoveNext()
IL_0319: brtrue.s IL_02c5
IL_031b: leave.s IL_032b
IL_031d: ldloca.s V_25
IL_031f: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>
IL_0325: callvirt System.Void System.IDisposable::Dispose()
IL_032a: endfinally
IL_032b: ldarg.1
IL_032c: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioNotesKeywordData
IL_0331: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Values()
IL_0336: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::GetEnumerator()
IL_033b: stloc.s V_25
IL_033d: br.s IL_038c
IL_033f: ldloca.s V_25
IL_0341: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Current()
IL_0346: stloc.s V_27
IL_0348: ldloc.s V_27
IL_034a: ldfld System.String TheForestOfLove.Services.Persistence.SavegameBioKeywordData::keywordSavekey
IL_034f: ldloc.s V_24
IL_0351: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_0356: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_035b: brfalse.s IL_038c
IL_035d: ldarg.2
IL_035e: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioNotesKeywordData
IL_0363: ldloc.s V_24
IL_0365: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_036a: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::ContainsKey(!0)
IL_036f: brtrue.s IL_0395
IL_0371: ldarg.2
IL_0372: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioNotesKeywordData
IL_0377: ldloc.s V_24
IL_0379: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_037e: ldloc.s V_27
IL_0380: callvirt TheForestOfLove.Services.Persistence.SavegameBioKeywordData TheForestOfLove.Services.Persistence.SavegameBioKeywordData::DeepCopy()
IL_0385: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::Add(!0,!1)
IL_038a: leave.s IL_03a5
IL_038c: ldloca.s V_25
IL_038e: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::MoveNext()
IL_0393: brtrue.s IL_033f
IL_0395: leave.s IL_03a5
IL_0397: ldloca.s V_25
IL_0399: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>
IL_039f: callvirt System.Void System.IDisposable::Dispose()
IL_03a4: endfinally
IL_03a5: ldarg.1
IL_03a6: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioKinksKeywordData
IL_03ab: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Values()
IL_03b0: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::GetEnumerator()
IL_03b5: stloc.s V_25
IL_03b7: br.s IL_0406
IL_03b9: ldloca.s V_25
IL_03bb: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::get_Current()
IL_03c0: stloc.s V_28
IL_03c2: ldloc.s V_28
IL_03c4: ldfld System.String TheForestOfLove.Services.Persistence.SavegameBioKeywordData::keywordSavekey
IL_03c9: ldloc.s V_24
IL_03cb: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_03d0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03d5: brfalse.s IL_0406
IL_03d7: ldarg.2
IL_03d8: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioKinksKeywordData
IL_03dd: ldloc.s V_24
IL_03df: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_03e4: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::ContainsKey(!0)
IL_03e9: brtrue.s IL_040f
IL_03eb: ldarg.2
IL_03ec: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData> TheForestOfLove.Services.Persistence.SavegameActorData::bioKinksKeywordData
IL_03f1: ldloc.s V_24
IL_03f3: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_03f8: ldloc.s V_28
IL_03fa: callvirt TheForestOfLove.Services.Persistence.SavegameBioKeywordData TheForestOfLove.Services.Persistence.SavegameBioKeywordData::DeepCopy()
IL_03ff: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::Add(!0,!1)
IL_0404: leave.s IL_041f
IL_0406: ldloca.s V_25
IL_0408: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>::MoveNext()
IL_040d: brtrue.s IL_03b9
IL_040f: leave.s IL_041f
IL_0411: ldloca.s V_25
IL_0413: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,TheForestOfLove.Services.Persistence.SavegameBioKeywordData>
IL_0419: callvirt System.Void System.IDisposable::Dispose()
IL_041e: endfinally
IL_041f: ldloca.s V_23
IL_0421: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKeyword>::MoveNext()
IL_0426: brtrue IL_0291
IL_042b: leave.s IL_043b
IL_042d: ldloca.s V_23
IL_042f: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKeyword>
IL_0435: callvirt System.Void System.IDisposable::Dispose()
IL_043a: endfinally
IL_043b: ldloca.s V_0
IL_043d: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_0442: brtrue IL_000d
IL_0447: leave.s IL_0457
IL_0449: ldloca.s V_0
IL_044b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_0451: callvirt System.Void System.IDisposable::Dispose()
IL_0456: endfinally
IL_0457: ret
METHOD TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordBySavekey(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord> TheForestOfLove.Narrative.DataManifest::areasBySavekey
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord> TheForestOfLove.Narrative.DataManifest::areasBySavekey
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find area by savekey "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordByUnitySceneName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord> TheForestOfLove.Narrative.DataManifest::areasByUnitySceneName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord> TheForestOfLove.Narrative.DataManifest::areasByUnitySceneName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.AreaRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find area by name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::CreateTriggerOnTheFly(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_001c
IL_000a: ldstr "data service trying to add on the fly trigger that already exists "
IL_000f: ldarg.0
IL_0010: call System.String System.String::Concat(System.String,System.String)
IL_0015: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_001a: ldloc.0
IL_001b: ret
IL_001c: newobj System.Void TheForestOfLove.Narrative.Trigger::.ctor()
IL_0021: dup
IL_0022: ldarg.0
IL_0023: stfld System.String TheForestOfLove.Narrative.Trigger::name
IL_0028: dup
IL_0029: ldnull
IL_002a: stfld TheForestOfLove.DB.Trigger TheForestOfLove.Narrative.Trigger::dbTrigger
IL_002f: dup
IL_0030: ldarg.0
IL_0031: stfld System.String TheForestOfLove.Narrative.Trigger::savekey
IL_0036: stloc.0
IL_0037: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_003c: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggers
IL_0041: ldloc.0
IL_0042: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::Add(!0)
IL_0047: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_004c: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByTriggerName
IL_0051: ldarg.0
IL_0052: ldloc.0
IL_0053: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::Add(!0,!1)
IL_0058: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_005d: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersBySavekey
IL_0062: ldarg.0
IL_0063: ldloc.0
IL_0064: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::Add(!0,!1)
IL_0069: ldloc.0
IL_006a: ret
METHOD TheForestOfLove.Narrative.Adventure TheForestOfLove.Services.Persistence.DataService::GetAdventureByAdventureType(TheForestOfLove.Narrative.AdventureType) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.DataManifest::adventuresByAdventureType
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.DataManifest::adventuresByAdventureType
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find adventure by name {0}"
IL_0028: ldarg.0
IL_0029: box TheForestOfLove.Narrative.AdventureType
IL_002e: call System.String System.String::Format(System.String,System.Object)
IL_0033: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0038: ldnull
IL_0039: ret
METHOD TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Services.Persistence.DataService::GetInventoryItemBySavekey(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsBySavekey
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsBySavekey
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Inventory.InventoryItem>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find inventory item by savekey "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Inventory.InventoryItem TheForestOfLove.Services.Persistence.DataService::GetInventoryItemByItemType(TheForestOfLove.Inventory.InventoryItemType) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByItemType
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem> TheForestOfLove.Narrative.DataManifest::inventoryItemsByItemType
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Inventory.InventoryItemType,TheForestOfLove.Inventory.InventoryItem>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find inventory item by type "
IL_0028: ldarga.s itemType
IL_002a: constrained. TheForestOfLove.Inventory.InventoryItemType
IL_0030: callvirt System.String System.Object::ToString()
IL_0035: call System.String System.String::Concat(System.String,System.String)
IL_003a: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_003f: ldnull
IL_0040: ret
METHOD TheForestOfLove.Narrative.MovieRecord TheForestOfLove.Services.Persistence.DataService::GetMovieRecordByMovie(TheForestOfLove.Narrative.Movie) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesByMovie
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesByMovie
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find movie record by movie "
IL_0028: ldarga.s movie
IL_002a: constrained. TheForestOfLove.Narrative.Movie
IL_0030: callvirt System.String System.Object::ToString()
IL_0035: call System.String System.String::Concat(System.String,System.String)
IL_003a: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_003f: ldnull
IL_0040: ret
METHOD TheForestOfLove.Narrative.MovieRecord TheForestOfLove.Services.Persistence.DataService::GetGlobalMovieRecordByMovie(TheForestOfLove.Narrative.Movie) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::globalMoviesByMovie
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::globalMoviesByMovie
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find movie record by movie "
IL_0028: ldarga.s movie
IL_002a: constrained. TheForestOfLove.Narrative.Movie
IL_0030: callvirt System.String System.Object::ToString()
IL_0035: call System.String System.String::Concat(System.String,System.String)
IL_003a: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_003f: ldnull
IL_0040: ret
METHOD TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Services.Persistence.DataService::GetChapterRecordByDbName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ChapterRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find chapter record by name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Services.Persistence.DataService::GetChapterRecordByChapter(TheForestOfLove.Narrative.Chapter) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByChapter
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Narrative.DataManifest::chaptersByChapter
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Chapter,TheForestOfLove.Narrative.ChapterRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find chapter record by chapter "
IL_0028: ldarga.s chapter
IL_002a: constrained. TheForestOfLove.Narrative.Chapter
IL_0030: callvirt System.String System.Object::ToString()
IL_0035: call System.String System.String::Concat(System.String,System.String)
IL_003a: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_003f: ldnull
IL_0040: ret
METHOD System.Collections.Generic.List`1<TheForestOfLove.Narrative.GossipGreeting> TheForestOfLove.Services.Persistence.DataService::GetGossipGreetingsByActorDbName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.GossipGreeting>> TheForestOfLove.Narrative.DataManifest::gossipGreetingsByActorDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.GossipGreeting>>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.GossipGreeting>> TheForestOfLove.Narrative.DataManifest::gossipGreetingsByActorDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.GossipGreeting>>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find gossip greetings by actor db name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByPluginDbId(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbId
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbId
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find actor by plugin db id {0}"
IL_0028: ldarg.0
IL_0029: box System.Int32
IL_002e: call System.String System.String::Format(System.String,System.Object)
IL_0033: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0038: ldnull
IL_0039: ret
METHOD TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByPluginDbName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find actor by plugin db name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.ActorDialogueOracle TheForestOfLove.Services.Persistence.DataService::GetActorDialogueOracleByActorDbName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ActorDialogueOracle> TheForestOfLove.Narrative.DataManifest::actorDialogueOraclesByActorDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ActorDialogueOracle>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ActorDialogueOracle> TheForestOfLove.Narrative.DataManifest::actorDialogueOraclesByActorDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ActorDialogueOracle>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find actor oracle by actor name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
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
METHOD TheForestOfLove.Narrative.QuestStatusRecord TheForestOfLove.Services.Persistence.DataService::GetQuestStatusRecordBySavekey(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestStatusRecord> TheForestOfLove.Narrative.DataManifest::questStatusesBySavekey
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestStatusRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestStatusRecord> TheForestOfLove.Narrative.DataManifest::questStatusesBySavekey
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestStatusRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find quest status by savekey "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.QuestStatusRecord TheForestOfLove.Services.Persistence.DataService::GetQuestStatusRecordByStatus(TheForestOfLove.Narrative.QuestStatus) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestStatus,TheForestOfLove.Narrative.QuestStatusRecord> TheForestOfLove.Narrative.DataManifest::questStatusesByStatus
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestStatus,TheForestOfLove.Narrative.QuestStatusRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestStatus,TheForestOfLove.Narrative.QuestStatusRecord> TheForestOfLove.Narrative.DataManifest::questStatusesByStatus
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.QuestStatus,TheForestOfLove.Narrative.QuestStatusRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find quest status by status "
IL_0028: ldarga.s status
IL_002a: constrained. TheForestOfLove.Narrative.QuestStatus
IL_0030: callvirt System.String System.Object::ToString()
IL_0035: call System.String System.String::Concat(System.String,System.String)
IL_003a: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_003f: ldnull
IL_0040: ret
METHOD TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestBySavekey(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsBySavekey
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsBySavekey
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find quest by savekey "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Services.Persistence.DataService::GetDialogueStatusRecordBySavekey(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatusesBySavekey
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.DialogueStatusRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatusesBySavekey
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.DialogueStatusRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find dialogue status by savekey "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Services.Persistence.DataService::GetDialogueStatusRecordByStatus(TheForestOfLove.Narrative.DialogueStatus) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatusesByStatus
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord> TheForestOfLove.Narrative.DataManifest::dialogueStatusesByStatus
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatusRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find dialogue status by status "
IL_0028: ldarga.s status
IL_002a: constrained. TheForestOfLove.Narrative.DialogueStatus
IL_0030: callvirt System.String System.Object::ToString()
IL_0035: call System.String System.String::Concat(System.String,System.String)
IL_003a: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_003f: ldnull
IL_0040: ret
METHOD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueBySavekey(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesBySavekey
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesBySavekey
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find dialogue by savekey "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByPluginDbId(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByPluginDbId
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Dialogue>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByPluginDbId
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Dialogue>::get_Item(!0)
IL_0022: ret
IL_0023: call System.Boolean Globals::get_DevCommandActive()
IL_0028: brtrue.s IL_003f
IL_002a: ldstr "data service cannot find dialogue by plugin db id {0}"
IL_002f: ldarg.0
IL_0030: box System.Int32
IL_0035: call System.String System.String::Format(System.String,System.Object)
IL_003a: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_003f: ldnull
IL_0040: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetDialoguesByPrimaryActor(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesByActorDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesByActorDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find dialogue by actor name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetManualDialoguesByPrimaryActor(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeManualByActorDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeManualByActorDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find manual dialogue by actor name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetQuestDialoguesByPrimaryActor(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestByActorDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestByActorDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find quest dialogue by actor name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetFinalIdleDialoguesByPrimaryActor(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeFinalIdleByActorDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeFinalIdleByActorDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find final idle dialogue by actor name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetGossipDialoguesByPrimaryActor(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGossipByActorDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGossipByActorDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find gossip dialogue by actor name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetDateDialoguesByPrimaryActor(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeDateByActorDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeDateByActorDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find date dialogue by actor name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetGiftDialoguesByPrimaryActor(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGiftByActorDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGiftByActorDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find gift dialogue by actor name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetQuestionIdleDialoguesByPrimaryActor(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestionIdleByActorDbName
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestionIdleByActorDbName
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find question idle dialogue by actor name "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.ArcStatusRecord TheForestOfLove.Services.Persistence.DataService::GetArcStatusRecordBySavekey(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ArcStatusRecord> TheForestOfLove.Narrative.DataManifest::arcStatusesBySavekey
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ArcStatusRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ArcStatusRecord> TheForestOfLove.Narrative.DataManifest::arcStatusesBySavekey
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ArcStatusRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find arc status by savekey "
IL_0028: ldarg.0
IL_0029: call System.String System.String::Concat(System.String,System.String)
IL_002e: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0033: ldnull
IL_0034: ret
METHOD TheForestOfLove.Narrative.ArcStatusRecord TheForestOfLove.Services.Persistence.DataService::GetArcStatusRecordByStatus(TheForestOfLove.Narrative.ArcStatus) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0005: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.ArcStatus,TheForestOfLove.Narrative.ArcStatusRecord> TheForestOfLove.Narrative.DataManifest::arcStatusesByStatus
IL_000a: ldarg.0
IL_000b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.ArcStatus,TheForestOfLove.Narrative.ArcStatusRecord>::ContainsKey(!0)
IL_0010: brfalse.s IL_0023
IL_0012: call TheForestOfLove.Narrative.DataManifest TheForestOfLove.Services.Persistence.DataService::get_Manifest()
IL_0017: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.ArcStatus,TheForestOfLove.Narrative.ArcStatusRecord> TheForestOfLove.Narrative.DataManifest::arcStatusesByStatus
IL_001c: ldarg.0
IL_001d: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.ArcStatus,TheForestOfLove.Narrative.ArcStatusRecord>::get_Item(!0)
IL_0022: ret
IL_0023: ldstr "data service cannot find arc status by status "
IL_0028: ldarga.s status
IL_002a: constrained. TheForestOfLove.Narrative.ArcStatus
IL_0030: callvirt System.String System.Object::ToString()
IL_0035: call System.String System.String::Concat(System.String,System.String)
IL_003a: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_003f: ldnull
IL_0040: ret
