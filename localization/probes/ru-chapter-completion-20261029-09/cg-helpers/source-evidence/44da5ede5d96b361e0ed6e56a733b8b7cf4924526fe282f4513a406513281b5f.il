TYPE TheForestOfLove.ChapterSelectUI
METHOD System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_000b: brtrue.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldarg.1
IL_0010: stfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_0015: ldarg.0
IL_0016: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_001b: ldc.i4.0
IL_001c: ldarg.0
IL_001d: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_0022: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_0027: ldc.i4.1
IL_0028: sub
IL_0029: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_002e: stloc.0
IL_002f: ldarg.0
IL_0030: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_0035: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Count()
IL_003a: ldc.i4.1
IL_003b: sub
IL_003c: ldarg.0
IL_003d: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_0042: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_0047: ldc.i4.1
IL_0048: sub
IL_0049: call System.Int32 UnityEngine.Mathf::Min(System.Int32,System.Int32)
IL_004e: stloc.1
IL_004f: ldarg.0
IL_0050: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_0055: ldarg.0
IL_0056: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::numVisibleOptions
IL_005b: add
IL_005c: ldloc.1
IL_005d: ldarg.0
IL_005e: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_0063: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_0068: ldc.i4.1
IL_0069: sub
IL_006a: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_006f: stloc.2
IL_0070: ldc.i4.0
IL_0071: stloc.s V_4
IL_0073: ldloc.0
IL_0074: stloc.s V_5
IL_0076: br.s IL_00f0
IL_0078: ldloc.s V_5
IL_007a: ldloc.0
IL_007b: blt.s IL_00d0
IL_007d: ldloc.s V_5
IL_007f: ldloc.2
IL_0080: bgt.s IL_00d0
IL_0082: ldloc.s V_4
IL_0084: ldarg.0
IL_0085: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_008a: bne.un.s IL_00ae
IL_008c: ldarg.0
IL_008d: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_0092: ldloc.s V_4
IL_0094: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Item(System.Int32)
IL_0099: ldc.i4.0
IL_009a: ldarg.0
IL_009b: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_00a0: ldloc.s V_5
IL_00a2: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Item(System.Int32)
IL_00a7: callvirt System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetStatus(TheForestOfLove.ChapterSelectUI/ItemLabelStatus,TheForestOfLove.ChapterSelectUI/GossipItem)
IL_00ac: br.s IL_00e4
IL_00ae: ldarg.0
IL_00af: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_00b4: ldloc.s V_4
IL_00b6: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Item(System.Int32)
IL_00bb: ldc.i4.1
IL_00bc: ldarg.0
IL_00bd: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_00c2: ldloc.s V_5
IL_00c4: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Item(System.Int32)
IL_00c9: callvirt System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetStatus(TheForestOfLove.ChapterSelectUI/ItemLabelStatus,TheForestOfLove.ChapterSelectUI/GossipItem)
IL_00ce: br.s IL_00e4
IL_00d0: ldarg.0
IL_00d1: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_00d6: ldloc.s V_4
IL_00d8: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Item(System.Int32)
IL_00dd: ldc.i4.2
IL_00de: ldnull
IL_00df: callvirt System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetStatus(TheForestOfLove.ChapterSelectUI/ItemLabelStatus,TheForestOfLove.ChapterSelectUI/GossipItem)
IL_00e4: ldloc.s V_4
IL_00e6: ldc.i4.1
IL_00e7: add
IL_00e8: stloc.s V_4
IL_00ea: ldloc.s V_5
IL_00ec: ldc.i4.1
IL_00ed: add
IL_00ee: stloc.s V_5
IL_00f0: ldloc.s V_4
IL_00f2: ldarg.0
IL_00f3: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_00f8: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Count()
IL_00fd: blt IL_0078
IL_0102: ldarg.0
IL_0103: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsBelow
IL_0108: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_010d: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_0112: ldarg.0
IL_0113: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_0118: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_011d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0122: brfalse.s IL_0150
IL_0124: ldarg.0
IL_0125: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsBelow
IL_012a: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_012f: ldnull
IL_0130: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0135: ldarg.0
IL_0136: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsBelow
IL_013b: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0140: ldarg.0
IL_0141: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_0146: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_014b: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0150: ldarg.0
IL_0151: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_0156: ldarg.0
IL_0157: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_015c: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Item(System.Int32)
IL_0161: callvirt TheForestOfLove.ChapterSelectUI/GossipItem TheForestOfLove.ChapterSelectUI/GossipItemLabel::get_gossipItem()
IL_0166: stloc.3
IL_0167: ldarg.0
IL_0168: ldloc.3
IL_0169: ldfld System.String TheForestOfLove.ChapterSelectUI/GossipItem::tooltipText
IL_016e: call System.Void TheForestOfLove.ChapterSelectUI::UpdateTooltipText(System.String)
IL_0173: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::RefreshVisibleItems() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_000b: brtrue.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_0014: ldc.i4.0
IL_0015: ldarg.0
IL_0016: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_001b: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_0020: ldc.i4.1
IL_0021: sub
IL_0022: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_0027: stloc.0
IL_0028: ldarg.0
IL_0029: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_002e: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Count()
IL_0033: ldc.i4.1
IL_0034: sub
IL_0035: ldarg.0
IL_0036: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_003b: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_0040: ldc.i4.1
IL_0041: sub
IL_0042: call System.Int32 UnityEngine.Mathf::Min(System.Int32,System.Int32)
IL_0047: stloc.1
IL_0048: ldarg.0
IL_0049: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_004e: ldarg.0
IL_004f: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::numVisibleOptions
IL_0054: add
IL_0055: ldloc.1
IL_0056: ldarg.0
IL_0057: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_005c: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_0061: ldc.i4.1
IL_0062: sub
IL_0063: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_0068: stloc.2
IL_0069: ldc.i4.0
IL_006a: stloc.3
IL_006b: ldloc.0
IL_006c: stloc.s V_4
IL_006e: br IL_00f7
IL_0073: ldloc.s V_4
IL_0075: ldloc.0
IL_0076: blt.s IL_00c5
IL_0078: ldloc.s V_4
IL_007a: ldloc.2
IL_007b: bgt.s IL_00c5
IL_007d: ldarg.0
IL_007e: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_0083: ldloc.3
IL_0084: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Item(System.Int32)
IL_0089: ldarg.0
IL_008a: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_008f: ldloc.s V_4
IL_0091: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Item(System.Int32)
IL_0096: ldfld System.String TheForestOfLove.ChapterSelectUI/GossipItem::displayText
IL_009b: callvirt System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetText(System.String)
IL_00a0: ldarg.0
IL_00a1: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_00a6: ldloc.3
IL_00a7: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Item(System.Int32)
IL_00ac: ldarg.0
IL_00ad: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_00b2: ldloc.s V_4
IL_00b4: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Item(System.Int32)
IL_00b9: ldfld System.Boolean TheForestOfLove.ChapterSelectUI/GossipItem::isNew
IL_00be: callvirt System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetNewLabelVisible(System.Boolean)
IL_00c3: br.s IL_00ed
IL_00c5: ldarg.0
IL_00c6: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_00cb: ldloc.3
IL_00cc: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Item(System.Int32)
IL_00d1: ldsfld System.String System.String::Empty
IL_00d6: callvirt System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetText(System.String)
IL_00db: ldarg.0
IL_00dc: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_00e1: ldloc.3
IL_00e2: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Item(System.Int32)
IL_00e7: ldc.i4.0
IL_00e8: callvirt System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetNewLabelVisible(System.Boolean)
IL_00ed: ldloc.3
IL_00ee: ldc.i4.1
IL_00ef: add
IL_00f0: stloc.3
IL_00f1: ldloc.s V_4
IL_00f3: ldc.i4.1
IL_00f4: add
IL_00f5: stloc.s V_4
IL_00f7: ldloc.3
IL_00f8: ldarg.0
IL_00f9: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_00fe: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Count()
IL_0103: blt IL_0073
IL_0108: ret

TYPE TheForestOfLove.ChapterSelectUI/GossipItemLabel
METHOD System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetText(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiSelected
IL_0006: ldarg.1
IL_0007: callvirt System.Void TheForestOfLove.GossipUIItemTemplate::SetText(System.String)
IL_000c: ldarg.0
IL_000d: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiEnabled
IL_0012: ldarg.1
IL_0013: callvirt System.Void TheForestOfLove.GossipUIItemTemplate::SetText(System.String)
IL_0018: ldarg.0
IL_0019: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiEnabledUnread
IL_001e: ldarg.1
IL_001f: callvirt System.Void TheForestOfLove.GossipUIItemTemplate::SetText(System.String)
IL_0024: ldarg.0
IL_0025: ldarg.1
IL_0026: call System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::set_text(System.String)
IL_002b: ret

TYPE TheForestOfLove.Services.Persistence.DataService
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

TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0::<GenerateMovies>b__0(TheForestOfLove.DB.Movie) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.DialogueSystemLoader TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0::<>4__this
IL_0006: ldarg.1
IL_0007: call TheForestOfLove.Narrative.MovieRecord TheForestOfLove.Narrative.DialogueSystemLoader::CreateMovieRecord(TheForestOfLove.DB.Movie)
IL_000c: stloc.0
IL_000d: ldarg.0
IL_000e: ldfld TheForestOfLove.Narrative.DialogueSystemLoader TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0::<>4__this
IL_0013: ldarg.1
IL_0014: call TheForestOfLove.Narrative.MovieRecord TheForestOfLove.Narrative.DialogueSystemLoader::CreateMovieRecord(TheForestOfLove.DB.Movie)
IL_0019: stloc.1
IL_001a: ldarg.0
IL_001b: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0::manifest
IL_0020: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::movies
IL_0025: ldloc.0
IL_0026: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord>::Add(!0)
IL_002b: ldarg.0
IL_002c: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0::manifest
IL_0031: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesByDbName
IL_0036: ldloc.0
IL_0037: ldfld System.String TheForestOfLove.Narrative.MovieRecord::dbName
IL_003c: ldloc.0
IL_003d: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.MovieRecord>::Add(!0,!1)
IL_0042: ldarg.0
IL_0043: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0::manifest
IL_0048: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesByDbMovie
IL_004d: ldloc.0
IL_004e: ldfld TheForestOfLove.DB.Movie TheForestOfLove.Narrative.MovieRecord::dbMovie
IL_0053: ldloc.0
IL_0054: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Movie,TheForestOfLove.Narrative.MovieRecord>::Add(!0,!1)
IL_0059: ldarg.0
IL_005a: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0::manifest
IL_005f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesBySavekey
IL_0064: ldloc.0
IL_0065: ldfld System.String TheForestOfLove.Narrative.MovieRecord::savekey
IL_006a: ldloc.0
IL_006b: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.MovieRecord>::Add(!0,!1)
IL_0070: ldarg.0
IL_0071: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0::manifest
IL_0076: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::moviesByMovie
IL_007b: ldloc.0
IL_007c: ldfld TheForestOfLove.Narrative.Movie TheForestOfLove.Narrative.MovieRecord::movie
IL_0081: ldloc.0
IL_0082: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord>::Add(!0,!1)
IL_0087: ldarg.0
IL_0088: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0::manifest
IL_008d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::globalMovies
IL_0092: ldloc.1
IL_0093: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.MovieRecord>::Add(!0)
IL_0098: ldarg.0
IL_0099: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass12_0::manifest
IL_009e: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord> TheForestOfLove.Narrative.DataManifest::globalMoviesByMovie
IL_00a3: ldloc.1
IL_00a4: ldfld TheForestOfLove.Narrative.Movie TheForestOfLove.Narrative.MovieRecord::movie
IL_00a9: ldloc.1
IL_00aa: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Movie,TheForestOfLove.Narrative.MovieRecord>::Add(!0,!1)
IL_00af: ret
