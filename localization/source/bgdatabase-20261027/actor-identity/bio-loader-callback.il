TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::<GenerateActorBios>b__0(TheForestOfLove.DB.Actor) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0006: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByDbActor
IL_000b: ldarg.1
IL_000c: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_0011: stloc.0
IL_0012: ldarg.1
IL_0013: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.BioDetail> TheForestOfLove.DB.Actor::get_RelatedBioDetailListUsingactorRelation()
IL_0018: brfalse IL_0251
IL_001d: ldarg.1
IL_001e: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.BioDetail> TheForestOfLove.DB.Actor::get_RelatedBioDetailListUsingactorRelation()
IL_0023: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.BioDetail>::GetEnumerator()
IL_0028: stloc.1
IL_0029: br IL_0235
IL_002e: ldloca.s V_1
IL_0030: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.BioDetail>::get_Current()
IL_0035: stloc.2
IL_0036: newobj System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::.ctor()
IL_003b: stloc.3
IL_003c: ldloc.3
IL_003d: ldloc.0
IL_003e: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.Actor::keywordDataDetail
IL_0043: newobj System.Void TheForestOfLove.Narrative.BioDetail::.ctor(System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>)
IL_0048: stfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_004d: ldloc.3
IL_004e: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_0053: ldloc.0
IL_0054: stfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.BioDetail::actor
IL_0059: ldloc.3
IL_005a: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_005f: ldloc.2
IL_0060: callvirt System.String TheForestOfLove.DB.BioDetail::get_name()
IL_0065: stfld System.String TheForestOfLove.Narrative.BioDetail::dbName
IL_006a: ldloc.3
IL_006b: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_0070: ldloc.2
IL_0071: stfld TheForestOfLove.DB.BioDetail TheForestOfLove.Narrative.BioDetail::dbBioDetail
IL_0076: ldloc.3
IL_0077: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_007c: ldloc.2
IL_007d: callvirt System.String TheForestOfLove.DB.BioDetail::get_nameplate_name_override()
IL_0082: stfld System.String TheForestOfLove.Narrative.BioDetail::overrideNameplateName
IL_0087: ldloc.3
IL_0088: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_008d: ldloc.2
IL_008e: callvirt System.String TheForestOfLove.DB.BioDetail::get_full_name_override()
IL_0093: stfld System.String TheForestOfLove.Narrative.BioDetail::overrideFullName
IL_0098: ldloc.3
IL_0099: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_009e: ldloc.2
IL_009f: callvirt System.Boolean TheForestOfLove.DB.BioDetail::get_is_default()
IL_00a4: stfld System.Boolean TheForestOfLove.Narrative.BioDetail::isDefault
IL_00a9: ldloc.2
IL_00aa: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioDetail::get_line1()
IL_00af: brfalse.s IL_00ed
IL_00b1: ldloc.3
IL_00b2: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_00b7: ldarg.0
IL_00b8: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_00bd: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_00c2: ldloc.2
IL_00c3: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioDetail::get_line1()
IL_00c8: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_00cd: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioSpeciesKeyword
IL_00d2: ldloc.3
IL_00d3: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_00d8: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioDetail::bios
IL_00dd: ldloc.3
IL_00de: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_00e3: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioSpeciesKeyword
IL_00e8: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_00ed: ldloc.2
IL_00ee: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioDetail::get_line2()
IL_00f3: brfalse.s IL_0131
IL_00f5: ldloc.3
IL_00f6: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_00fb: ldarg.0
IL_00fc: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0101: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_0106: ldloc.2
IL_0107: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioDetail::get_line2()
IL_010c: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0111: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioAgeKeyword
IL_0116: ldloc.3
IL_0117: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_011c: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioDetail::bios
IL_0121: ldloc.3
IL_0122: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_0127: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioAgeKeyword
IL_012c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_0131: ldloc.2
IL_0132: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioDetail::get_line3()
IL_0137: brfalse.s IL_0175
IL_0139: ldloc.3
IL_013a: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_013f: ldarg.0
IL_0140: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0145: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_014a: ldloc.2
IL_014b: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioDetail::get_line3()
IL_0150: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0155: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioRoleKeyword
IL_015a: ldloc.3
IL_015b: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_0160: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioDetail::bios
IL_0165: ldloc.3
IL_0166: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_016b: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioDetail::bioRoleKeyword
IL_0170: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_0175: ldloc.2
IL_0176: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.BioDetail::get_enable_with_tags()
IL_017b: brfalse.s IL_01d4
IL_017d: ldloc.2
IL_017e: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.BioDetail::get_enable_with_tags()
IL_0183: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_0188: stloc.s V_5
IL_018a: br.s IL_01bb
IL_018c: ldloca.s V_5
IL_018e: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_0193: stloc.s V_6
IL_0195: ldarg.0
IL_0196: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_019b: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_01a0: ldloc.s V_6
IL_01a2: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_01a7: stloc.s V_7
IL_01a9: ldloc.3
IL_01aa: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_01af: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.BioDetail::enableWithTags
IL_01b4: ldloc.s V_7
IL_01b6: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_01bb: ldloca.s V_5
IL_01bd: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_01c2: brtrue.s IL_018c
IL_01c4: leave.s IL_01d4
IL_01c6: ldloca.s V_5
IL_01c8: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_01ce: callvirt System.Void System.IDisposable::Dispose()
IL_01d3: endfinally
IL_01d4: newobj System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite>::.ctor()
IL_01d9: stloc.s V_4
IL_01db: ldloc.s V_4
IL_01dd: call BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.BioDetail::get__bio_portrait()
IL_01e2: ldloc.2
IL_01e3: callvirt System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_01e8: callvirt System.String BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::GetAddressablesAddress(System.Int32)
IL_01ed: callvirt System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite>::SetAssetKey(System.String)
IL_01f2: ldloc.s V_4
IL_01f4: ldloc.3
IL_01f5: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::<GenerateActorBios>b__1(UnityEngine.Sprite)
IL_01fb: newobj System.Void System.Action`1<UnityEngine.Sprite>::.ctor(System.Object,System.IntPtr)
IL_0200: callvirt System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite>::SetCallback(System.Action`1<T>)
IL_0205: ldloc.3
IL_0206: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_020b: ldloc.s V_4
IL_020d: stfld TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite> TheForestOfLove.Narrative.BioDetail::bioPortraitAssetLoader
IL_0212: ldarg.0
IL_0213: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0218: ldfld System.Collections.Generic.List`1<TheForestOfLove.Utility.IAddressableAssetLoader> TheForestOfLove.Narrative.DataManifest::addressableAssets
IL_021d: ldloc.s V_4
IL_021f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Utility.IAddressableAssetLoader>::Add(!0)
IL_0224: ldloc.0
IL_0225: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail> TheForestOfLove.Narrative.Actor::bioDetails
IL_022a: ldloc.3
IL_022b: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_1::record
IL_0230: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail>::Add(!0)
IL_0235: ldloca.s V_1
IL_0237: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.BioDetail>::MoveNext()
IL_023c: brtrue IL_002e
IL_0241: leave.s IL_0251
IL_0243: ldloca.s V_1
IL_0245: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.BioDetail>
IL_024b: callvirt System.Void System.IDisposable::Dispose()
IL_0250: endfinally
IL_0251: ldarg.1
IL_0252: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.BioNote> TheForestOfLove.DB.Actor::get_RelatedBioNoteListUsingactorRelation()
IL_0257: brfalse IL_04e7
IL_025c: ldarg.1
IL_025d: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.BioNote> TheForestOfLove.DB.Actor::get_RelatedBioNoteListUsingactorRelation()
IL_0262: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.BioNote>::GetEnumerator()
IL_0267: stloc.s V_8
IL_0269: br IL_04cb
IL_026e: ldloca.s V_8
IL_0270: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.BioNote>::get_Current()
IL_0275: stloc.s V_9
IL_0277: ldloc.0
IL_0278: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.Actor::keywordDataNotes
IL_027d: newobj System.Void TheForestOfLove.Narrative.BioNotes::.ctor(System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>)
IL_0282: stloc.s V_10
IL_0284: ldloc.s V_10
IL_0286: ldloc.0
IL_0287: stfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.BioNotes::actor
IL_028c: ldloc.s V_10
IL_028e: ldloc.s V_9
IL_0290: callvirt System.String TheForestOfLove.DB.BioNote::get_name()
IL_0295: stfld System.String TheForestOfLove.Narrative.BioNotes::dbName
IL_029a: ldloc.s V_10
IL_029c: ldloc.s V_9
IL_029e: stfld TheForestOfLove.DB.BioNote TheForestOfLove.Narrative.BioNotes::dbBioNotes
IL_02a3: ldloc.s V_10
IL_02a5: ldloc.s V_9
IL_02a7: callvirt System.Boolean TheForestOfLove.DB.BioNote::get_is_default()
IL_02ac: stfld System.Boolean TheForestOfLove.Narrative.BioNotes::isDefault
IL_02b1: ldloc.s V_9
IL_02b3: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note1()
IL_02b8: brfalse.s IL_02f9
IL_02ba: ldloc.s V_10
IL_02bc: ldarg.0
IL_02bd: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_02c2: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_02c7: ldloc.s V_9
IL_02c9: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note1()
IL_02ce: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_02d3: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note1Keyword
IL_02d8: ldloc.s V_10
IL_02da: ldloc.s V_9
IL_02dc: callvirt System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list1()
IL_02e1: stfld System.Boolean TheForestOfLove.Narrative.BioNotes::note1Hidden
IL_02e6: ldloc.s V_10
IL_02e8: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioNotes::notes
IL_02ed: ldloc.s V_10
IL_02ef: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note1Keyword
IL_02f4: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_02f9: ldloc.s V_9
IL_02fb: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note2()
IL_0300: brfalse.s IL_0341
IL_0302: ldloc.s V_10
IL_0304: ldarg.0
IL_0305: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_030a: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_030f: ldloc.s V_9
IL_0311: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note2()
IL_0316: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_031b: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note2Keyword
IL_0320: ldloc.s V_10
IL_0322: ldloc.s V_9
IL_0324: callvirt System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list2()
IL_0329: stfld System.Boolean TheForestOfLove.Narrative.BioNotes::note2Hidden
IL_032e: ldloc.s V_10
IL_0330: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioNotes::notes
IL_0335: ldloc.s V_10
IL_0337: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note2Keyword
IL_033c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_0341: ldloc.s V_9
IL_0343: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note3()
IL_0348: brfalse.s IL_0389
IL_034a: ldloc.s V_10
IL_034c: ldarg.0
IL_034d: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0352: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_0357: ldloc.s V_9
IL_0359: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note3()
IL_035e: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0363: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note3Keyword
IL_0368: ldloc.s V_10
IL_036a: ldloc.s V_9
IL_036c: callvirt System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list3()
IL_0371: stfld System.Boolean TheForestOfLove.Narrative.BioNotes::note3Hidden
IL_0376: ldloc.s V_10
IL_0378: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioNotes::notes
IL_037d: ldloc.s V_10
IL_037f: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note3Keyword
IL_0384: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_0389: ldloc.s V_9
IL_038b: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note4()
IL_0390: brfalse.s IL_03d1
IL_0392: ldloc.s V_10
IL_0394: ldarg.0
IL_0395: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_039a: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_039f: ldloc.s V_9
IL_03a1: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note4()
IL_03a6: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_03ab: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note4Keyword
IL_03b0: ldloc.s V_10
IL_03b2: ldloc.s V_9
IL_03b4: callvirt System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list4()
IL_03b9: stfld System.Boolean TheForestOfLove.Narrative.BioNotes::note4Hidden
IL_03be: ldloc.s V_10
IL_03c0: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioNotes::notes
IL_03c5: ldloc.s V_10
IL_03c7: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note4Keyword
IL_03cc: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_03d1: ldloc.s V_9
IL_03d3: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note5()
IL_03d8: brfalse.s IL_0419
IL_03da: ldloc.s V_10
IL_03dc: ldarg.0
IL_03dd: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_03e2: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_03e7: ldloc.s V_9
IL_03e9: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note5()
IL_03ee: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_03f3: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note5Keyword
IL_03f8: ldloc.s V_10
IL_03fa: ldloc.s V_9
IL_03fc: callvirt System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list5()
IL_0401: stfld System.Boolean TheForestOfLove.Narrative.BioNotes::note5Hidden
IL_0406: ldloc.s V_10
IL_0408: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioNotes::notes
IL_040d: ldloc.s V_10
IL_040f: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note5Keyword
IL_0414: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_0419: ldloc.s V_9
IL_041b: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note6()
IL_0420: brfalse.s IL_0461
IL_0422: ldloc.s V_10
IL_0424: ldarg.0
IL_0425: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_042a: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_042f: ldloc.s V_9
IL_0431: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note6()
IL_0436: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_043b: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note6Keyword
IL_0440: ldloc.s V_10
IL_0442: ldloc.s V_9
IL_0444: callvirt System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list6()
IL_0449: stfld System.Boolean TheForestOfLove.Narrative.BioNotes::note6Hidden
IL_044e: ldloc.s V_10
IL_0450: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioNotes::notes
IL_0455: ldloc.s V_10
IL_0457: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioNotes::note6Keyword
IL_045c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_0461: ldloc.s V_9
IL_0463: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.BioNote::get_enable_with_tags()
IL_0468: brfalse.s IL_04be
IL_046a: ldloc.s V_9
IL_046c: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.BioNote::get_enable_with_tags()
IL_0471: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_0476: stloc.s V_5
IL_0478: br.s IL_04a5
IL_047a: ldloca.s V_5
IL_047c: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_0481: stloc.s V_11
IL_0483: ldarg.0
IL_0484: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0489: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_048e: ldloc.s V_11
IL_0490: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_0495: stloc.s V_12
IL_0497: ldloc.s V_10
IL_0499: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.BioNotes::enableWithTags
IL_049e: ldloc.s V_12
IL_04a0: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_04a5: ldloca.s V_5
IL_04a7: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_04ac: brtrue.s IL_047a
IL_04ae: leave.s IL_04be
IL_04b0: ldloca.s V_5
IL_04b2: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_04b8: callvirt System.Void System.IDisposable::Dispose()
IL_04bd: endfinally
IL_04be: ldloc.0
IL_04bf: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioNotes> TheForestOfLove.Narrative.Actor::bioNotes
IL_04c4: ldloc.s V_10
IL_04c6: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioNotes>::Add(!0)
IL_04cb: ldloca.s V_8
IL_04cd: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.BioNote>::MoveNext()
IL_04d2: brtrue IL_026e
IL_04d7: leave.s IL_04e7
IL_04d9: ldloca.s V_8
IL_04db: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.BioNote>
IL_04e1: callvirt System.Void System.IDisposable::Dispose()
IL_04e6: endfinally
IL_04e7: ldarg.1
IL_04e8: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.BioKink> TheForestOfLove.DB.Actor::get_RelatedBioKinkListUsingactorRelation()
IL_04ed: brfalse IL_0855
IL_04f2: ldarg.1
IL_04f3: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.BioKink> TheForestOfLove.DB.Actor::get_RelatedBioKinkListUsingactorRelation()
IL_04f8: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.BioKink>::GetEnumerator()
IL_04fd: stloc.s V_13
IL_04ff: br IL_0839
IL_0504: ldloca.s V_13
IL_0506: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.BioKink>::get_Current()
IL_050b: stloc.s V_14
IL_050d: ldloc.0
IL_050e: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData> TheForestOfLove.Narrative.Actor::keywordDataKinks
IL_0513: newobj System.Void TheForestOfLove.Narrative.BioKinks::.ctor(System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeywordData>)
IL_0518: stloc.s V_15
IL_051a: ldloc.s V_15
IL_051c: ldloc.0
IL_051d: stfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.BioKinks::actor
IL_0522: ldloc.s V_15
IL_0524: ldloc.s V_14
IL_0526: callvirt System.String TheForestOfLove.DB.BioKink::get_name()
IL_052b: stfld System.String TheForestOfLove.Narrative.BioKinks::dbName
IL_0530: ldloc.s V_15
IL_0532: ldloc.s V_14
IL_0534: stfld TheForestOfLove.DB.BioKink TheForestOfLove.Narrative.BioKinks::dbBioKinks
IL_0539: ldloc.s V_15
IL_053b: ldloc.s V_14
IL_053d: callvirt System.Boolean TheForestOfLove.DB.BioKink::get_is_default()
IL_0542: stfld System.Boolean TheForestOfLove.Narrative.BioKinks::isDefault
IL_0547: ldloc.s V_14
IL_0549: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink1()
IL_054e: brfalse.s IL_058f
IL_0550: ldloc.s V_15
IL_0552: ldarg.0
IL_0553: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0558: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_055d: ldloc.s V_14
IL_055f: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink1()
IL_0564: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0569: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink1Keyword
IL_056e: ldloc.s V_15
IL_0570: ldloc.s V_14
IL_0572: callvirt System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list1()
IL_0577: stfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink1Hidden
IL_057c: ldloc.s V_15
IL_057e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_0583: ldloc.s V_15
IL_0585: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink1Keyword
IL_058a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_058f: ldloc.s V_14
IL_0591: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink2()
IL_0596: brfalse.s IL_05d7
IL_0598: ldloc.s V_15
IL_059a: ldarg.0
IL_059b: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_05a0: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_05a5: ldloc.s V_14
IL_05a7: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink2()
IL_05ac: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_05b1: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink2Keyword
IL_05b6: ldloc.s V_15
IL_05b8: ldloc.s V_14
IL_05ba: callvirt System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list2()
IL_05bf: stfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink2Hidden
IL_05c4: ldloc.s V_15
IL_05c6: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_05cb: ldloc.s V_15
IL_05cd: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink2Keyword
IL_05d2: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_05d7: ldloc.s V_14
IL_05d9: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink3()
IL_05de: brfalse.s IL_061f
IL_05e0: ldloc.s V_15
IL_05e2: ldarg.0
IL_05e3: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_05e8: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_05ed: ldloc.s V_14
IL_05ef: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink3()
IL_05f4: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_05f9: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink3Keyword
IL_05fe: ldloc.s V_15
IL_0600: ldloc.s V_14
IL_0602: callvirt System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list3()
IL_0607: stfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink3Hidden
IL_060c: ldloc.s V_15
IL_060e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_0613: ldloc.s V_15
IL_0615: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink3Keyword
IL_061a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_061f: ldloc.s V_14
IL_0621: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink4()
IL_0626: brfalse.s IL_0667
IL_0628: ldloc.s V_15
IL_062a: ldarg.0
IL_062b: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0630: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_0635: ldloc.s V_14
IL_0637: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink4()
IL_063c: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0641: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink4Keyword
IL_0646: ldloc.s V_15
IL_0648: ldloc.s V_14
IL_064a: callvirt System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list4()
IL_064f: stfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink4Hidden
IL_0654: ldloc.s V_15
IL_0656: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_065b: ldloc.s V_15
IL_065d: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink4Keyword
IL_0662: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_0667: ldloc.s V_14
IL_0669: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink5()
IL_066e: brfalse.s IL_06af
IL_0670: ldloc.s V_15
IL_0672: ldarg.0
IL_0673: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0678: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_067d: ldloc.s V_14
IL_067f: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink5()
IL_0684: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0689: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink5Keyword
IL_068e: ldloc.s V_15
IL_0690: ldloc.s V_14
IL_0692: callvirt System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list5()
IL_0697: stfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink5Hidden
IL_069c: ldloc.s V_15
IL_069e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_06a3: ldloc.s V_15
IL_06a5: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink5Keyword
IL_06aa: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_06af: ldloc.s V_14
IL_06b1: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink6()
IL_06b6: brfalse.s IL_06f7
IL_06b8: ldloc.s V_15
IL_06ba: ldarg.0
IL_06bb: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_06c0: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_06c5: ldloc.s V_14
IL_06c7: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink6()
IL_06cc: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_06d1: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink6Keyword
IL_06d6: ldloc.s V_15
IL_06d8: ldloc.s V_14
IL_06da: callvirt System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list6()
IL_06df: stfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink6Hidden
IL_06e4: ldloc.s V_15
IL_06e6: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_06eb: ldloc.s V_15
IL_06ed: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink6Keyword
IL_06f2: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_06f7: ldloc.s V_14
IL_06f9: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink7()
IL_06fe: brfalse.s IL_073f
IL_0700: ldloc.s V_15
IL_0702: ldarg.0
IL_0703: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0708: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_070d: ldloc.s V_14
IL_070f: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink7()
IL_0714: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0719: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink7Keyword
IL_071e: ldloc.s V_15
IL_0720: ldloc.s V_14
IL_0722: callvirt System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list7()
IL_0727: stfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink7Hidden
IL_072c: ldloc.s V_15
IL_072e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_0733: ldloc.s V_15
IL_0735: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink7Keyword
IL_073a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_073f: ldloc.s V_14
IL_0741: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink8()
IL_0746: brfalse.s IL_0787
IL_0748: ldloc.s V_15
IL_074a: ldarg.0
IL_074b: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0750: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_0755: ldloc.s V_14
IL_0757: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink8()
IL_075c: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_0761: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink8Keyword
IL_0766: ldloc.s V_15
IL_0768: ldloc.s V_14
IL_076a: callvirt System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list8()
IL_076f: stfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink8Hidden
IL_0774: ldloc.s V_15
IL_0776: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_077b: ldloc.s V_15
IL_077d: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink8Keyword
IL_0782: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_0787: ldloc.s V_14
IL_0789: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink9()
IL_078e: brfalse.s IL_07cf
IL_0790: ldloc.s V_15
IL_0792: ldarg.0
IL_0793: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_0798: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_079d: ldloc.s V_14
IL_079f: callvirt TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink9()
IL_07a4: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::get_Item(!0)
IL_07a9: stfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink9Keyword
IL_07ae: ldloc.s V_15
IL_07b0: ldloc.s V_14
IL_07b2: callvirt System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list9()
IL_07b7: stfld System.Boolean TheForestOfLove.Narrative.BioKinks::kink9Hidden
IL_07bc: ldloc.s V_15
IL_07be: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.BioKinks::kinks
IL_07c3: ldloc.s V_15
IL_07c5: ldfld TheForestOfLove.Narrative.BioKeyword TheForestOfLove.Narrative.BioKinks::kink9Keyword
IL_07ca: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_07cf: ldloc.s V_14
IL_07d1: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.BioKink::get_enable_with_tags()
IL_07d6: brfalse.s IL_082c
IL_07d8: ldloc.s V_14
IL_07da: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.BioKink::get_enable_with_tags()
IL_07df: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_07e4: stloc.s V_5
IL_07e6: br.s IL_0813
IL_07e8: ldloca.s V_5
IL_07ea: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_07ef: stloc.s V_16
IL_07f1: ldarg.0
IL_07f2: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass17_0::manifest
IL_07f7: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_07fc: ldloc.s V_16
IL_07fe: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_0803: stloc.s V_17
IL_0805: ldloc.s V_15
IL_0807: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.BioKinks::enableWithTags
IL_080c: ldloc.s V_17
IL_080e: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0813: ldloca.s V_5
IL_0815: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_081a: brtrue.s IL_07e8
IL_081c: leave.s IL_082c
IL_081e: ldloca.s V_5
IL_0820: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_0826: callvirt System.Void System.IDisposable::Dispose()
IL_082b: endfinally
IL_082c: ldloc.0
IL_082d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKinks> TheForestOfLove.Narrative.Actor::bioKinks
IL_0832: ldloc.s V_15
IL_0834: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKinks>::Add(!0)
IL_0839: ldloca.s V_13
IL_083b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.BioKink>::MoveNext()
IL_0840: brtrue IL_0504
IL_0845: leave.s IL_0855
IL_0847: ldloca.s V_13
IL_0849: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.BioKink>
IL_084f: callvirt System.Void System.IDisposable::Dispose()
IL_0854: endfinally
IL_0855: ret
