TYPE TheForestOfLove.GossipUI
METHOD System.Void TheForestOfLove.GossipUI::SelectItemLabel(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem> TheForestOfLove.GossipUI::gossipItems
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem>::get_Count()
IL_000b: brtrue.s IL_000e
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldarg.1
IL_0010: stfld System.Int32 TheForestOfLove.GossipUI::itemLabelSelectedIndex
IL_0015: ldarg.0
IL_0016: ldfld System.Int32 TheForestOfLove.GossipUI::gossipItemSelectedIndex
IL_001b: ldc.i4.0
IL_001c: ldarg.0
IL_001d: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem> TheForestOfLove.GossipUI::gossipItems
IL_0022: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem>::get_Count()
IL_0027: ldc.i4.1
IL_0028: sub
IL_0029: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_002e: stloc.0
IL_002f: ldarg.0
IL_0030: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel> TheForestOfLove.GossipUI::itemLabels
IL_0035: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel>::get_Count()
IL_003a: ldc.i4.1
IL_003b: sub
IL_003c: ldarg.0
IL_003d: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem> TheForestOfLove.GossipUI::gossipItems
IL_0042: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem>::get_Count()
IL_0047: ldc.i4.1
IL_0048: sub
IL_0049: call System.Int32 UnityEngine.Mathf::Min(System.Int32,System.Int32)
IL_004e: stloc.1
IL_004f: ldarg.0
IL_0050: ldfld System.Int32 TheForestOfLove.GossipUI::gossipItemSelectedIndex
IL_0055: ldarg.0
IL_0056: ldfld System.Int32 TheForestOfLove.GossipUI::numVisibleOptions
IL_005b: add
IL_005c: ldloc.1
IL_005d: ldarg.0
IL_005e: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem> TheForestOfLove.GossipUI::gossipItems
IL_0063: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem>::get_Count()
IL_0068: ldc.i4.1
IL_0069: sub
IL_006a: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_006f: stloc.2
IL_0070: ldc.i4.0
IL_0071: stloc.s V_4
IL_0073: ldloc.0
IL_0074: stloc.s V_5
IL_0076: br IL_0172
IL_007b: ldloc.s V_5
IL_007d: ldloc.0
IL_007e: blt IL_0152
IL_0083: ldloc.s V_5
IL_0085: ldloc.2
IL_0086: bgt IL_0152
IL_008b: ldloc.s V_4
IL_008d: ldarg.0
IL_008e: ldfld System.Int32 TheForestOfLove.GossipUI::itemLabelSelectedIndex
IL_0093: bne.un.s IL_00f5
IL_0095: ldarg.0
IL_0096: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem> TheForestOfLove.GossipUI::gossipItems
IL_009b: ldloc.s V_5
IL_009d: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem>::get_Item(System.Int32)
IL_00a2: ldfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.GossipUI/GossipItem::dialogue
IL_00a7: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::isBlockedByAntitags
IL_00ac: brfalse.s IL_00d3
IL_00ae: ldarg.0
IL_00af: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel> TheForestOfLove.GossipUI::itemLabels
IL_00b4: ldloc.s V_4
IL_00b6: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel>::get_Item(System.Int32)
IL_00bb: ldc.i4.2
IL_00bc: ldarg.0
IL_00bd: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem> TheForestOfLove.GossipUI::gossipItems
IL_00c2: ldloc.s V_5
IL_00c4: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem>::get_Item(System.Int32)
IL_00c9: callvirt System.Void TheForestOfLove.GossipUI/GossipItemLabel::SetStatus(TheForestOfLove.GossipUI/ItemLabelStatus,TheForestOfLove.GossipUI/GossipItem)
IL_00ce: br IL_0166
IL_00d3: ldarg.0
IL_00d4: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel> TheForestOfLove.GossipUI::itemLabels
IL_00d9: ldloc.s V_4
IL_00db: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel>::get_Item(System.Int32)
IL_00e0: ldc.i4.0
IL_00e1: ldarg.0
IL_00e2: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem> TheForestOfLove.GossipUI::gossipItems
IL_00e7: ldloc.s V_5
IL_00e9: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem>::get_Item(System.Int32)
IL_00ee: callvirt System.Void TheForestOfLove.GossipUI/GossipItemLabel::SetStatus(TheForestOfLove.GossipUI/ItemLabelStatus,TheForestOfLove.GossipUI/GossipItem)
IL_00f3: br.s IL_0166
IL_00f5: ldarg.0
IL_00f6: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem> TheForestOfLove.GossipUI::gossipItems
IL_00fb: ldloc.s V_5
IL_00fd: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem>::get_Item(System.Int32)
IL_0102: ldfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.GossipUI/GossipItem::dialogue
IL_0107: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::isBlockedByAntitags
IL_010c: brfalse.s IL_0130
IL_010e: ldarg.0
IL_010f: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel> TheForestOfLove.GossipUI::itemLabels
IL_0114: ldloc.s V_4
IL_0116: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel>::get_Item(System.Int32)
IL_011b: ldc.i4.3
IL_011c: ldarg.0
IL_011d: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem> TheForestOfLove.GossipUI::gossipItems
IL_0122: ldloc.s V_5
IL_0124: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem>::get_Item(System.Int32)
IL_0129: callvirt System.Void TheForestOfLove.GossipUI/GossipItemLabel::SetStatus(TheForestOfLove.GossipUI/ItemLabelStatus,TheForestOfLove.GossipUI/GossipItem)
IL_012e: br.s IL_0166
IL_0130: ldarg.0
IL_0131: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel> TheForestOfLove.GossipUI::itemLabels
IL_0136: ldloc.s V_4
IL_0138: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel>::get_Item(System.Int32)
IL_013d: ldc.i4.1
IL_013e: ldarg.0
IL_013f: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem> TheForestOfLove.GossipUI::gossipItems
IL_0144: ldloc.s V_5
IL_0146: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItem>::get_Item(System.Int32)
IL_014b: callvirt System.Void TheForestOfLove.GossipUI/GossipItemLabel::SetStatus(TheForestOfLove.GossipUI/ItemLabelStatus,TheForestOfLove.GossipUI/GossipItem)
IL_0150: br.s IL_0166
IL_0152: ldarg.0
IL_0153: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel> TheForestOfLove.GossipUI::itemLabels
IL_0158: ldloc.s V_4
IL_015a: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel>::get_Item(System.Int32)
IL_015f: ldc.i4.4
IL_0160: ldnull
IL_0161: callvirt System.Void TheForestOfLove.GossipUI/GossipItemLabel::SetStatus(TheForestOfLove.GossipUI/ItemLabelStatus,TheForestOfLove.GossipUI/GossipItem)
IL_0166: ldloc.s V_4
IL_0168: ldc.i4.1
IL_0169: add
IL_016a: stloc.s V_4
IL_016c: ldloc.s V_5
IL_016e: ldc.i4.1
IL_016f: add
IL_0170: stloc.s V_5
IL_0172: ldloc.s V_4
IL_0174: ldarg.0
IL_0175: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel> TheForestOfLove.GossipUI::itemLabels
IL_017a: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel>::get_Count()
IL_017f: blt IL_007b
IL_0184: ldarg.0
IL_0185: ldfld UnityEngine.GameObject TheForestOfLove.GossipUI::moreOptionsBelow
IL_018a: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_018f: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_0194: ldarg.0
IL_0195: ldfld UnityEngine.GameObject TheForestOfLove.GossipUI::visibleContentContainer
IL_019a: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_019f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01a4: brfalse.s IL_01d2
IL_01a6: ldarg.0
IL_01a7: ldfld UnityEngine.GameObject TheForestOfLove.GossipUI::moreOptionsBelow
IL_01ac: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01b1: ldnull
IL_01b2: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_01b7: ldarg.0
IL_01b8: ldfld UnityEngine.GameObject TheForestOfLove.GossipUI::moreOptionsBelow
IL_01bd: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01c2: ldarg.0
IL_01c3: ldfld UnityEngine.GameObject TheForestOfLove.GossipUI::visibleContentContainer
IL_01c8: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01cd: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_01d2: ldarg.0
IL_01d3: ldfld System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel> TheForestOfLove.GossipUI::itemLabels
IL_01d8: ldarg.0
IL_01d9: ldfld System.Int32 TheForestOfLove.GossipUI::itemLabelSelectedIndex
IL_01de: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.GossipUI/GossipItemLabel>::get_Item(System.Int32)
IL_01e3: callvirt TheForestOfLove.GossipUI/GossipItem TheForestOfLove.GossipUI/GossipItemLabel::get_gossipItem()
IL_01e8: stloc.3
IL_01e9: ldloc.3
IL_01ea: ldfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.GossipUI/GossipItem::dialogue
IL_01ef: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::isBlockedByAntitags
IL_01f4: brfalse.s IL_0208
IL_01f6: ldarg.0
IL_01f7: ldloc.3
IL_01f8: call System.String TheForestOfLove.GossipUI::GenerateTooltipText(TheForestOfLove.GossipUI/GossipItem)
IL_01fd: stloc.s V_6
IL_01ff: ldarg.0
IL_0200: ldloc.s V_6
IL_0202: call System.Void TheForestOfLove.GossipUI::UpdateTooltipText(System.String)
IL_0207: ret
IL_0208: ldarg.0
IL_0209: ldsfld System.String System.String::Empty
IL_020e: call System.Void TheForestOfLove.GossipUI::UpdateTooltipText(System.String)
IL_0213: ret
