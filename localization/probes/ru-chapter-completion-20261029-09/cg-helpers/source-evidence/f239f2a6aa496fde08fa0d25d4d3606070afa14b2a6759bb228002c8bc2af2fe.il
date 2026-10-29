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
METHOD System.Void TheForestOfLove.ChapterSelectUI::RegisterServices() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RegisterServices()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.ServiceLocator::Register<TheForestOfLove.ChapterSelectUI>(T)
IL_000c: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::UnregisterServices() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::UnregisterServices()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.ServiceLocator::Unregister<TheForestOfLove.ChapterSelectUI>(T)
IL_000c: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::ShowUi() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ChapterSelectUI>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldnull
IL_0008: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000d: brfalse.s IL_0015
IL_000f: ldloc.0
IL_0010: callvirt System.Void TheForestOfLove.ChapterSelectUI::Show()
IL_0015: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::Show() | attributes=Public, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.ChapterSelectUI::get_visible()
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldc.i4.1
IL_0009: call System.Void TheForestOfLove.ChapterSelectUI::set_visible(System.Boolean)
IL_000e: ldarg.0
IL_000f: ldc.i4.0
IL_0010: stfld System.Boolean TheForestOfLove.ChapterSelectUI::waitedAtLeastOneFrameForVisibilityToggle
IL_0015: ldarg.0
IL_0016: call System.Void TheForestOfLove.ChapterSelectUI::RefreshUI()
IL_001b: ldarg.0
IL_001c: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::gossipUIAnimator
IL_0021: ldstr "show"
IL_0026: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_002b: ldarg.0
IL_002c: ldc.i4.0
IL_002d: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_0032: ldarg.0
IL_0033: call System.Void TheForestOfLove.ChapterSelectUI::HideButtonHints()
IL_0038: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowGossipUI
IL_003d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0042: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::Hide(System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.ChapterSelectUI::get_visible()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldc.i4.0
IL_0009: call System.Void TheForestOfLove.ChapterSelectUI::set_visible(System.Boolean)
IL_000e: ldarg.0
IL_000f: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0014: brtrue.s IL_004f
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::gossipUIAnimator
IL_001c: ldnull
IL_001d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0022: brfalse.s IL_004f
IL_0024: ldarg.1
IL_0025: brfalse.s IL_0039
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::gossipUIAnimator
IL_002d: ldstr "hide_immediately"
IL_0032: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0037: br.s IL_0049
IL_0039: ldarg.0
IL_003a: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::gossipUIAnimator
IL_003f: ldstr "hide"
IL_0044: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0049: ldarg.0
IL_004a: call System.Void TheForestOfLove.ChapterSelectUI::HideButtonHints()
IL_004f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideGossipUI
IL_0054: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0059: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::HideImmediately() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.ChapterSelectUI::Hide(System.Boolean)
IL_0007: ret
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
