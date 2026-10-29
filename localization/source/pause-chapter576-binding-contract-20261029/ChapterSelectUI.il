TYPE TheForestOfLove.ChapterSelectUI
METHOD System.Void TheForestOfLove.ChapterSelectUI::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::hiddenContentContainer
IL_000c: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.CanvasGroup>()
IL_0011: ldc.r4 0
IL_0016: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_001b: ldc.i4.0
IL_001c: stloc.0
IL_001d: br.s IL_0092
IL_001f: ldarg.0
IL_0020: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI::gossipItemTemplateSelected
IL_0025: ldarg.0
IL_0026: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_002b: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0030: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.GossipUIItemTemplate>(!!0,UnityEngine.Transform)
IL_0035: ldarg.0
IL_0036: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI::gossipItemTemplateEnabled
IL_003b: ldarg.0
IL_003c: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_0041: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0046: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.GossipUIItemTemplate>(!!0,UnityEngine.Transform)
IL_004b: stloc.1
IL_004c: ldarg.0
IL_004d: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI::gossipItemTemplateNewUnread
IL_0052: ldarg.0
IL_0053: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_0058: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_005d: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.GossipUIItemTemplate>(!!0,UnityEngine.Transform)
IL_0062: stloc.2
IL_0063: ldloc.1
IL_0064: ldloc.2
IL_0065: ldarg.0
IL_0066: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_006b: ldarg.0
IL_006c: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::hiddenContentContainer
IL_0071: newobj System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::.ctor(TheForestOfLove.GossipUIItemTemplate,TheForestOfLove.GossipUIItemTemplate,TheForestOfLove.GossipUIItemTemplate,UnityEngine.GameObject,UnityEngine.GameObject)
IL_0076: stloc.3
IL_0077: ldarg.0
IL_0078: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_007d: ldloc.3
IL_007e: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::Add(!0)
IL_0083: ldloc.3
IL_0084: ldsfld System.String System.String::Empty
IL_0089: callvirt System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetText(System.String)
IL_008e: ldloc.0
IL_008f: ldc.i4.1
IL_0090: add
IL_0091: stloc.0
IL_0092: ldloc.0
IL_0093: ldarg.0
IL_0094: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::numVisibleOptions
IL_0099: blt.s IL_001f
IL_009b: ldc.i4.0
IL_009c: call System.Void TheForestOfLove.ChapterSelectUI::set_visible(System.Boolean)
IL_00a1: ldarg.0
IL_00a2: ldarg.0
IL_00a3: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_00a8: stfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::gossipUIAnimator
IL_00ad: ldarg.0
IL_00ae: ldarg.0
IL_00af: call !!0 UnityEngine.Component::GetComponent<UnityEngine.CanvasGroup>()
IL_00b4: stfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::gossipUICanvasGroup
IL_00b9: ldarg.0
IL_00ba: ldarg.0
IL_00bb: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_00c0: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.UI.VerticalLayoutGroup>()
IL_00c5: stfld UnityEngine.UI.VerticalLayoutGroup TheForestOfLove.ChapterSelectUI::visibleContentContainerVerticalLayoutGroup
IL_00ca: ldarg.0
IL_00cb: ldarg.0
IL_00cc: ldfld UnityEngine.UI.VerticalLayoutGroup TheForestOfLove.ChapterSelectUI::visibleContentContainerVerticalLayoutGroup
IL_00d1: callvirt System.Single UnityEngine.UI.HorizontalOrVerticalLayoutGroup::get_spacing()
IL_00d6: stfld System.Single TheForestOfLove.ChapterSelectUI::visibleContentContainerVerticalLayoutGroupOriginalSpacing
IL_00db: ldarg.0
IL_00dc: ldarg.0
IL_00dd: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsAbove
IL_00e2: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_00e7: stfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::moreOptionsAboveAnimator
IL_00ec: ldarg.0
IL_00ed: ldarg.0
IL_00ee: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsAbove
IL_00f3: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.CanvasGroup>()
IL_00f8: stfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::moreOptionsAboveCanvasGroup
IL_00fd: ldarg.0
IL_00fe: ldarg.0
IL_00ff: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsBelow
IL_0104: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.Animator>()
IL_0109: stfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::moreOptionsBelowAnimator
IL_010e: ldarg.0
IL_010f: ldarg.0
IL_0110: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsBelow
IL_0115: callvirt !!0 UnityEngine.GameObject::GetComponent<UnityEngine.CanvasGroup>()
IL_011a: stfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::moreOptionsBelowCanvasGroup
IL_011f: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::moreOptionsAboveAnimator
IL_000c: ldstr "above"
IL_0011: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::moreOptionsBelowAnimator
IL_001c: ldstr "below"
IL_0021: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0026: ldarg.0
IL_0027: call System.Void TheForestOfLove.ChapterSelectUI::FilterAvailableChapters()
IL_002c: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::UpdateTooltipText(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::tooltipContainer
IL_0006: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_000b: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TMPro.TextMeshProUGUI>()
IL_0010: stloc.0
IL_0011: ldc.i4.0
IL_0012: stloc.1
IL_0013: br.s IL_0022
IL_0015: ldloc.0
IL_0016: ldloc.1
IL_0017: ldelem.ref
IL_0018: ldarg.1
IL_0019: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_001e: ldloc.1
IL_001f: ldc.i4.1
IL_0020: add
IL_0021: stloc.1
IL_0022: ldloc.1
IL_0023: ldloc.0
IL_0024: ldlen
IL_0025: conv.i4
IL_0026: blt.s IL_0015
IL_0028: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::RefreshUI() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.ChapterSelectUI::get_visible()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.ChapterSelectUI::RefreshItemsMasterList()
IL_000e: ldarg.0
IL_000f: call System.Void TheForestOfLove.ChapterSelectUI::RefreshVisibleItems()
IL_0014: ldarg.0
IL_0015: ldc.i4.0
IL_0016: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_001b: ret
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
