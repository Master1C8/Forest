TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::<GenerateQuests>b__0(TheForestOfLove.DB.Quest) | attributes=Assembly, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: newobj System.Void TheForestOfLove.Narrative.Quest::.ctor()
IL_000c: stfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0011: ldloc.0
IL_0012: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0017: ldarg.1
IL_0018: callvirt System.String BansheeGz.BGDatabase.BGEntity::get_Name()
IL_001d: stfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0022: ldloc.0
IL_0023: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0028: ldarg.1
IL_0029: stfld TheForestOfLove.DB.Quest TheForestOfLove.Narrative.Quest::dbQuest
IL_002e: ldloc.0
IL_002f: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0034: ldarg.1
IL_0035: callvirt System.String TheForestOfLove.DB.Quest::get_savekey()
IL_003a: stfld System.String TheForestOfLove.Narrative.Quest::savekey
IL_003f: ldloc.0
IL_0040: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0045: ldarg.1
IL_0046: callvirt System.String TheForestOfLove.DB.Quest::get_bio_title()
IL_004b: stfld System.String TheForestOfLove.Narrative.Quest::title
IL_0050: ldloc.0
IL_0051: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0056: ldarg.1
IL_0057: callvirt System.String TheForestOfLove.DB.Quest::get_bio_description()
IL_005c: stfld System.String TheForestOfLove.Narrative.Quest::description
IL_0061: ldloc.0
IL_0062: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0067: ldarg.1
IL_0068: callvirt System.Boolean TheForestOfLove.DB.Quest::get_bio_hidden()
IL_006d: stfld System.Boolean TheForestOfLove.Narrative.Quest::isHiddenInQuestLog
IL_0072: ldloc.0
IL_0073: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0078: ldarg.1
IL_0079: callvirt System.Int32 TheForestOfLove.DB.Quest::get_priority()
IL_007e: stfld System.Int32 TheForestOfLove.Narrative.Quest::priority
IL_0083: ldloc.0
IL_0084: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0089: ldarg.1
IL_008a: callvirt System.Boolean TheForestOfLove.DB.Quest::get_is_side_quest()
IL_008f: stfld System.Boolean TheForestOfLove.Narrative.Quest::isSideQuest
IL_0094: ldarg.1
IL_0095: callvirt UnityEngine.Sprite TheForestOfLove.DB.Quest::get_bio_portrait()
IL_009a: ldnull
IL_009b: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00a0: brfalse.s IL_00ed
IL_00a2: newobj System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite>::.ctor()
IL_00a7: stloc.1
IL_00a8: ldloc.1
IL_00a9: call BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.Quest::get__bio_portrait()
IL_00ae: ldarg.1
IL_00af: callvirt System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_00b4: callvirt System.String BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::GetAddressablesAddress(System.Int32)
IL_00b9: callvirt System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite>::SetAssetKey(System.String)
IL_00be: ldloc.1
IL_00bf: ldloc.0
IL_00c0: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::<GenerateQuests>b__2(UnityEngine.Sprite)
IL_00c6: newobj System.Void System.Action`1<UnityEngine.Sprite>::.ctor(System.Object,System.IntPtr)
IL_00cb: callvirt System.Void TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite>::SetCallback(System.Action`1<T>)
IL_00d0: ldloc.0
IL_00d1: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_00d6: ldloc.1
IL_00d7: stfld TheForestOfLove.Utility.GenericAddressableAssetLoader`1<UnityEngine.Sprite> TheForestOfLove.Narrative.Quest::portraitAssetLoader
IL_00dc: ldarg.0
IL_00dd: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::manifest
IL_00e2: ldfld System.Collections.Generic.List`1<TheForestOfLove.Utility.IAddressableAssetLoader> TheForestOfLove.Narrative.DataManifest::addressableAssets
IL_00e7: ldloc.1
IL_00e8: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Utility.IAddressableAssetLoader>::Add(!0)
IL_00ed: ldarg.1
IL_00ee: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.Quest::get_enable_with_tags()
IL_00f3: brfalse.s IL_0149
IL_00f5: ldarg.1
IL_00f6: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.Quest::get_enable_with_tags()
IL_00fb: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_0100: stloc.2
IL_0101: br.s IL_0130
IL_0103: ldloca.s V_2
IL_0105: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_010a: stloc.3
IL_010b: ldarg.0
IL_010c: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::manifest
IL_0111: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_0116: ldloc.3
IL_0117: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_011c: stloc.s V_4
IL_011e: ldloc.0
IL_011f: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0124: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Quest::enableWithTags
IL_0129: ldloc.s V_4
IL_012b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0130: ldloca.s V_2
IL_0132: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_0137: brtrue.s IL_0103
IL_0139: leave.s IL_0149
IL_013b: ldloca.s V_2
IL_013d: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_0143: callvirt System.Void System.IDisposable::Dispose()
IL_0148: endfinally
IL_0149: ldarg.1
IL_014a: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.Quest::get_disable_with_tags()
IL_014f: brfalse.s IL_01a7
IL_0151: ldarg.1
IL_0152: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.Quest::get_disable_with_tags()
IL_0157: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_015c: stloc.2
IL_015d: br.s IL_018e
IL_015f: ldloca.s V_2
IL_0161: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_0166: stloc.s V_5
IL_0168: ldarg.0
IL_0169: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::manifest
IL_016e: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_0173: ldloc.s V_5
IL_0175: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_017a: stloc.s V_6
IL_017c: ldloc.0
IL_017d: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0182: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Quest::disableWithTags
IL_0187: ldloc.s V_6
IL_0189: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_018e: ldloca.s V_2
IL_0190: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_0195: brtrue.s IL_015f
IL_0197: leave.s IL_01a7
IL_0199: ldloca.s V_2
IL_019b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_01a1: callvirt System.Void System.IDisposable::Dispose()
IL_01a6: endfinally
IL_01a7: ldarg.0
IL_01a8: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::manifest
IL_01ad: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::quests
IL_01b2: ldloc.0
IL_01b3: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_01b8: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Quest>::Add(!0)
IL_01bd: ldarg.0
IL_01be: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::manifest
IL_01c3: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_01c8: ldloc.0
IL_01c9: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_01ce: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_01d3: ldloc.0
IL_01d4: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_01d9: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::Add(!0,!1)
IL_01de: ldarg.0
IL_01df: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::manifest
IL_01e4: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbQuest
IL_01e9: ldloc.0
IL_01ea: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_01ef: ldfld TheForestOfLove.DB.Quest TheForestOfLove.Narrative.Quest::dbQuest
IL_01f4: ldloc.0
IL_01f5: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_01fa: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest>::Add(!0,!1)
IL_01ff: ldarg.0
IL_0200: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_0::manifest
IL_0205: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsBySavekey
IL_020a: ldloc.0
IL_020b: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_0210: ldfld System.String TheForestOfLove.Narrative.Quest::savekey
IL_0215: ldloc.0
IL_0216: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass20_1::quest
IL_021b: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::Add(!0,!1)
IL_0220: ret
