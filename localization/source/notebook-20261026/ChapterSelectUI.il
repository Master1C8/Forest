TYPE TheForestOfLove.ChapterSelectUI
METHOD System.Void TheForestOfLove.ChapterSelectUI::RefreshChapters()
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ChapterSelectUI>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldnull
IL_0008: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000d: brfalse.s IL_0015
IL_000f: ldloc.0
IL_0010: callvirt System.Void TheForestOfLove.ChapterSelectUI::FilterAvailableChapters()
IL_0015: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::FilterAvailableChapters()
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_0006: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::Clear()
IL_000b: ldarg.0
IL_000c: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::allGossipItems
IL_0011: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::Clear()
IL_0016: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord> TheForestOfLove.Services.Persistence.DataService::GetChapterRecords()
IL_001b: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.ChapterRecord>::GetEnumerator()
IL_0020: stloc.0
IL_0021: br IL_00e7
IL_0026: ldloc.0
IL_0027: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.ChapterRecord>::get_Current()
IL_002c: stloc.1
IL_002d: ldsfld System.Boolean Globals::enableAllChapters
IL_0032: brtrue.s IL_003f
IL_0034: ldloc.1
IL_0035: callvirt System.Boolean TheForestOfLove.Narrative.ChapterRecord::get_IsUnlocked()
IL_003a: brfalse IL_00e7
IL_003f: ldloc.1
IL_0040: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::title
IL_0045: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_004a: brtrue IL_00e7
IL_004f: ldloc.1
IL_0050: ldfld System.Boolean TheForestOfLove.Narrative.ChapterRecord::isHiddenInList
IL_0055: brtrue IL_00e7
IL_005a: ldc.i4.0
IL_005b: stloc.2
IL_005c: ldloc.1
IL_005d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.ChapterRecord::enableWithTags
IL_0062: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_0067: stloc.s V_4
IL_0069: br.s IL_0082
IL_006b: ldloca.s V_4
IL_006d: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_0072: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_0077: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_007c: brfalse.s IL_0082
IL_007e: ldc.i4.1
IL_007f: stloc.2
IL_0080: leave.s IL_009b
IL_0082: ldloca.s V_4
IL_0084: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_0089: brtrue.s IL_006b
IL_008b: leave.s IL_009b
IL_008d: ldloca.s V_4
IL_008f: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_0095: callvirt System.Void System.IDisposable::Dispose()
IL_009a: endfinally
IL_009b: ldloc.2
IL_009c: brfalse.s IL_00e7
IL_009e: newobj System.Void TheForestOfLove.ChapterSelectUI/GossipItem::.ctor()
IL_00a3: dup
IL_00a4: ldloc.1
IL_00a5: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.Narrative.ChapterRecord::unlockStopPoint
IL_00aa: stfld TheForestOfLove.Narrative.Chapter TheForestOfLove.ChapterSelectUI/GossipItem::unlockStopPoint
IL_00af: dup
IL_00b0: ldloc.1
IL_00b1: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::title
IL_00b6: stfld System.String TheForestOfLove.ChapterSelectUI/GossipItem::displayText
IL_00bb: dup
IL_00bc: ldloc.1
IL_00bd: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::description
IL_00c2: stfld System.String TheForestOfLove.ChapterSelectUI/GossipItem::tooltipText
IL_00c7: dup
IL_00c8: ldloc.1
IL_00c9: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::respawnInScene
IL_00ce: stfld System.String TheForestOfLove.ChapterSelectUI/GossipItem::respawnInScene
IL_00d3: dup
IL_00d4: ldc.i4.0
IL_00d5: stfld System.Boolean TheForestOfLove.ChapterSelectUI/GossipItem::isNew
IL_00da: stloc.3
IL_00db: ldarg.0
IL_00dc: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::allGossipItems
IL_00e1: ldloc.3
IL_00e2: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::Add(!0)
IL_00e7: ldloc.0
IL_00e8: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_00ed: brtrue IL_0026
IL_00f2: leave.s IL_00fe
IL_00f4: ldloc.0
IL_00f5: brfalse.s IL_00fd
IL_00f7: ldloc.0
IL_00f8: callvirt System.Void System.IDisposable::Dispose()
IL_00fd: endfinally
IL_00fe: ldarg.0
IL_00ff: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::allGossipItems
IL_0104: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::GetEnumerator()
IL_0109: stloc.s V_5
IL_010b: br.s IL_0170
IL_010d: ldloca.s V_5
IL_010f: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Current()
IL_0114: stloc.s V_6
IL_0116: ldarg.0
IL_0117: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_011c: ldloc.s V_6
IL_011e: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::Contains(!0)
IL_0123: brtrue.s IL_0170
IL_0125: ldloc.s V_6
IL_0127: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.ChapterSelectUI/GossipItem::unlockStopPoint
IL_012c: call TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Services.Persistence.DataService::GetChapterRecordByChapter(TheForestOfLove.Narrative.Chapter)
IL_0131: stloc.s V_7
IL_0133: ldsfld System.Boolean Globals::enableAllChapters
IL_0138: brtrue.s IL_0163
IL_013a: ldloc.s V_6
IL_013c: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.ChapterSelectUI/GossipItem::unlockStopPoint
IL_0141: ldc.i4.s 100
IL_0143: beq.s IL_0163
IL_0145: ldloc.s V_6
IL_0147: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.ChapterSelectUI/GossipItem::unlockStopPoint
IL_014c: ldc.i4 200
IL_0151: beq.s IL_0163
IL_0153: ldsfld System.Boolean Globals::enableAllChapters
IL_0158: brtrue.s IL_0170
IL_015a: ldloc.s V_7
IL_015c: callvirt System.Boolean TheForestOfLove.Narrative.ChapterRecord::get_IsUnlocked()
IL_0161: brfalse.s IL_0170
IL_0163: ldarg.0
IL_0164: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_0169: ldloc.s V_6
IL_016b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::Add(!0)
IL_0170: ldloca.s V_5
IL_0172: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ChapterSelectUI/GossipItem>::MoveNext()
IL_0177: brtrue.s IL_010d
IL_0179: leave.s IL_0189
IL_017b: ldloca.s V_5
IL_017d: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.ChapterSelectUI/GossipItem>
IL_0183: callvirt System.Void System.IDisposable::Dispose()
IL_0188: endfinally
IL_0189: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::ShowUi()
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ChapterSelectUI>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldnull
IL_0008: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000d: brfalse.s IL_0015
IL_000f: ldloc.0
IL_0010: callvirt System.Void TheForestOfLove.ChapterSelectUI::Show()
IL_0015: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::Show()
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
METHOD System.Void TheForestOfLove.ChapterSelectUI::Update()
IL_0000: call System.Boolean TheForestOfLove.ChapterSelectUI::get_visible()
IL_0005: brfalse.s IL_002a
IL_0007: ldarg.0
IL_0008: ldfld UnityEngine.UI.VerticalLayoutGroup TheForestOfLove.ChapterSelectUI::visibleContentContainerVerticalLayoutGroup
IL_000d: callvirt System.Single UnityEngine.UI.HorizontalOrVerticalLayoutGroup::get_spacing()
IL_0012: ldc.r4 0
IL_0017: ble.un.s IL_002a
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.UI.VerticalLayoutGroup TheForestOfLove.ChapterSelectUI::visibleContentContainerVerticalLayoutGroup
IL_001f: ldarg.0
IL_0020: ldfld System.Single TheForestOfLove.ChapterSelectUI::visibleContentContainerVerticalLayoutGroupOriginalSpacing
IL_0025: callvirt System.Void UnityEngine.UI.HorizontalOrVerticalLayoutGroup::set_spacing(System.Single)
IL_002a: call System.Boolean TheForestOfLove.ChapterSelectUI::get_visible()
IL_002f: brfalse.s IL_0039
IL_0031: ldarg.0
IL_0032: call System.Boolean TheForestOfLove.ChapterSelectUI::get_LockInteractions()
IL_0037: brfalse.s IL_003a
IL_0039: ret
IL_003a: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_003f: brfalse.s IL_0042
IL_0041: ret
IL_0042: ldarg.0
IL_0043: ldfld System.Single TheForestOfLove.ChapterSelectUI::timeSinceLastButtonsReminder
IL_0048: ldarg.0
IL_0049: ldfld System.Single TheForestOfLove.ChapterSelectUI::timeBeforeButtonsReminder
IL_004e: ble.un.s IL_0058
IL_0050: ldarg.0
IL_0051: call System.Void TheForestOfLove.ChapterSelectUI::ShowButtonHints()
IL_0056: br.s IL_006a
IL_0058: ldarg.0
IL_0059: ldarg.0
IL_005a: ldfld System.Single TheForestOfLove.ChapterSelectUI::timeSinceLastButtonsReminder
IL_005f: call System.Single UnityEngine.Time::get_deltaTime()
IL_0064: add
IL_0065: stfld System.Single TheForestOfLove.ChapterSelectUI::timeSinceLastButtonsReminder
IL_006a: ldarg.0
IL_006b: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_0070: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_0075: ldc.i4.0
IL_0076: ble IL_0481
IL_007b: call System.Boolean TheForestOfLove.InputHelper::get_IsUpAxisButtonDown()
IL_0080: brfalse.s IL_00b4
IL_0082: ldarg.0
IL_0083: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_0088: ldc.i4.0
IL_0089: ble.s IL_00b4
IL_008b: ldarg.0
IL_008c: ldarg.0
IL_008d: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_0092: ldc.i4.1
IL_0093: sub
IL_0094: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_0099: ldarg.0
IL_009a: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::moreOptionsAboveAnimator
IL_009f: ldstr "pressed"
IL_00a4: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a9: ldarg.0
IL_00aa: call System.Void TheForestOfLove.ChapterSelectUI::HideButtonHints()
IL_00af: br IL_01c1
IL_00b4: call System.Boolean TheForestOfLove.InputHelper::get_IsDownAxisButtonDown()
IL_00b9: brfalse.s IL_010e
IL_00bb: ldarg.0
IL_00bc: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_00c1: ldarg.0
IL_00c2: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_00c7: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Count()
IL_00cc: ldc.i4.1
IL_00cd: sub
IL_00ce: bge.s IL_010e
IL_00d0: ldarg.0
IL_00d1: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_00d6: ldarg.0
IL_00d7: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_00dc: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_00e1: ldc.i4.1
IL_00e2: sub
IL_00e3: bge.s IL_010e
IL_00e5: ldarg.0
IL_00e6: ldarg.0
IL_00e7: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_00ec: ldc.i4.1
IL_00ed: add
IL_00ee: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_00f3: ldarg.0
IL_00f4: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::moreOptionsBelowAnimator
IL_00f9: ldstr "pressed"
IL_00fe: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0103: ldarg.0
IL_0104: call System.Void TheForestOfLove.ChapterSelectUI::HideButtonHints()
IL_0109: br IL_01c1
IL_010e: call System.Boolean TheForestOfLove.InputHelper::get_IsUpAxisButtonDown()
IL_0113: brfalse.s IL_0151
IL_0115: ldarg.0
IL_0116: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_011b: ldc.i4.0
IL_011c: ble.s IL_0151
IL_011e: ldarg.0
IL_011f: ldarg.0
IL_0120: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_0125: ldc.i4.1
IL_0126: sub
IL_0127: stfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_012c: ldarg.0
IL_012d: call System.Void TheForestOfLove.ChapterSelectUI::RefreshVisibleItems()
IL_0132: ldarg.0
IL_0133: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::moreOptionsAboveAnimator
IL_0138: ldstr "pressed"
IL_013d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0142: ldarg.0
IL_0143: call System.Void TheForestOfLove.ChapterSelectUI::HideButtonHints()
IL_0148: ldarg.0
IL_0149: ldc.i4.0
IL_014a: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_014f: br.s IL_01c1
IL_0151: call System.Boolean TheForestOfLove.InputHelper::get_IsDownAxisButtonDown()
IL_0156: brfalse.s IL_01c1
IL_0158: ldarg.0
IL_0159: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_015e: ldarg.0
IL_015f: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_0164: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_0169: ldarg.0
IL_016a: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::numVisibleOptions
IL_016f: sub
IL_0170: bge.s IL_01c1
IL_0172: ldarg.0
IL_0173: ldarg.0
IL_0174: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_0179: ldc.i4.1
IL_017a: add
IL_017b: stfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_0180: ldarg.0
IL_0181: call System.Void TheForestOfLove.ChapterSelectUI::RefreshVisibleItems()
IL_0186: ldarg.0
IL_0187: ldfld UnityEngine.Animator TheForestOfLove.ChapterSelectUI::moreOptionsBelowAnimator
IL_018c: ldstr "pressed"
IL_0191: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0196: ldarg.0
IL_0197: call System.Void TheForestOfLove.ChapterSelectUI::HideButtonHints()
IL_019c: ldarg.0
IL_019d: ldarg.0
IL_019e: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_01a3: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Count()
IL_01a8: ldc.i4.1
IL_01a9: sub
IL_01aa: ldarg.0
IL_01ab: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_01b0: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_01b5: ldc.i4.1
IL_01b6: sub
IL_01b7: call System.Int32 UnityEngine.Mathf::Min(System.Int32,System.Int32)
IL_01bc: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_01c1: ldarg.0
IL_01c2: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_01c7: ldc.i4.0
IL_01c8: bgt.s IL_01d5
IL_01ca: ldarg.0
IL_01cb: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_01d0: ldc.i4.0
IL_01d1: cgt
IL_01d3: br.s IL_01d6
IL_01d5: ldc.i4.1
IL_01d6: stloc.0
IL_01d7: ldarg.0
IL_01d8: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_01dd: ldarg.0
IL_01de: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_01e3: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Count()
IL_01e8: ldc.i4.1
IL_01e9: sub
IL_01ea: bge.s IL_0201
IL_01ec: ldarg.0
IL_01ed: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_01f2: ldarg.0
IL_01f3: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_01f8: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_01fd: ldc.i4.1
IL_01fe: sub
IL_01ff: blt.s IL_021d
IL_0201: ldarg.0
IL_0202: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_0207: ldarg.0
IL_0208: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem> TheForestOfLove.ChapterSelectUI::gossipItems
IL_020d: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItem>::get_Count()
IL_0212: ldarg.0
IL_0213: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::numVisibleOptions
IL_0218: sub
IL_0219: clt
IL_021b: br.s IL_021e
IL_021d: ldc.i4.1
IL_021e: stloc.1
IL_021f: ldarg.0
IL_0220: ldfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::moreOptionsAboveCanvasGroup
IL_0225: callvirt System.Single UnityEngine.CanvasGroup::get_alpha()
IL_022a: ldc.r4 0
IL_022f: ceq
IL_0231: ldloc.0
IL_0232: and
IL_0233: brfalse.s IL_0271
IL_0235: ldarg.0
IL_0236: ldfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::moreOptionsAboveCanvasGroup
IL_023b: ldc.r4 1
IL_0240: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0245: ldarg.0
IL_0246: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsAbove
IL_024b: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0250: ldarg.0
IL_0251: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_0256: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_025b: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0260: ldarg.0
IL_0261: ldarg.0
IL_0262: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_0267: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_026c: br IL_0308
IL_0271: ldarg.0
IL_0272: ldfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::moreOptionsAboveCanvasGroup
IL_0277: callvirt System.Single UnityEngine.CanvasGroup::get_alpha()
IL_027c: ldc.r4 1
IL_0281: bne.un.s IL_02bf
IL_0283: ldloc.0
IL_0284: brtrue.s IL_02bf
IL_0286: ldarg.0
IL_0287: ldfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::moreOptionsAboveCanvasGroup
IL_028c: ldc.r4 0
IL_0291: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0296: ldarg.0
IL_0297: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsAbove
IL_029c: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_02a1: ldarg.0
IL_02a2: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_02a7: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_02ac: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_02b1: ldarg.0
IL_02b2: ldarg.0
IL_02b3: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_02b8: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_02bd: br.s IL_0308
IL_02bf: ldarg.0
IL_02c0: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsAbove
IL_02c5: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_02ca: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_02cf: ldarg.0
IL_02d0: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_02d5: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_02da: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_02df: brfalse.s IL_0308
IL_02e1: ldarg.0
IL_02e2: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsAbove
IL_02e7: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_02ec: ldarg.0
IL_02ed: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_02f2: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_02f7: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_02fc: ldarg.0
IL_02fd: ldarg.0
IL_02fe: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_0303: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_0308: ldarg.0
IL_0309: ldfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::moreOptionsBelowCanvasGroup
IL_030e: callvirt System.Single UnityEngine.CanvasGroup::get_alpha()
IL_0313: ldc.r4 0
IL_0318: ceq
IL_031a: ldloc.1
IL_031b: and
IL_031c: brfalse.s IL_035a
IL_031e: ldarg.0
IL_031f: ldfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::moreOptionsBelowCanvasGroup
IL_0324: ldc.r4 1
IL_0329: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_032e: ldarg.0
IL_032f: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsBelow
IL_0334: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0339: ldarg.0
IL_033a: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_033f: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0344: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0349: ldarg.0
IL_034a: ldarg.0
IL_034b: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_0350: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_0355: br IL_03f1
IL_035a: ldarg.0
IL_035b: ldfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::moreOptionsBelowCanvasGroup
IL_0360: callvirt System.Single UnityEngine.CanvasGroup::get_alpha()
IL_0365: ldc.r4 1
IL_036a: bne.un.s IL_03a8
IL_036c: ldloc.1
IL_036d: brtrue.s IL_03a8
IL_036f: ldarg.0
IL_0370: ldfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::moreOptionsBelowCanvasGroup
IL_0375: ldc.r4 0
IL_037a: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_037f: ldarg.0
IL_0380: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsBelow
IL_0385: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_038a: ldarg.0
IL_038b: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_0390: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0395: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_039a: ldarg.0
IL_039b: ldarg.0
IL_039c: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_03a1: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_03a6: br.s IL_03f1
IL_03a8: ldarg.0
IL_03a9: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsBelow
IL_03ae: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_03b3: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_03b8: ldarg.0
IL_03b9: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_03be: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_03c3: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_03c8: brfalse.s IL_03f1
IL_03ca: ldarg.0
IL_03cb: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::moreOptionsBelow
IL_03d0: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_03d5: ldarg.0
IL_03d6: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI::visibleContentContainer
IL_03db: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_03e0: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_03e5: ldarg.0
IL_03e6: ldarg.0
IL_03e7: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_03ec: call System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
IL_03f1: ldarg.0
IL_03f2: ldfld UnityEngine.UI.VerticalLayoutGroup TheForestOfLove.ChapterSelectUI::visibleContentContainerVerticalLayoutGroup
IL_03f7: dup
IL_03f8: callvirt System.Single UnityEngine.UI.HorizontalOrVerticalLayoutGroup::get_spacing()
IL_03fd: ldc.r4 0.01
IL_0402: add
IL_0403: callvirt System.Void UnityEngine.UI.HorizontalOrVerticalLayoutGroup::set_spacing(System.Single)
IL_0408: call System.Boolean TheForestOfLove.InputHelper::get_IsSubmitButtonDown()
IL_040d: brfalse.s IL_046b
IL_040f: ldarg.0
IL_0410: ldfld System.Boolean TheForestOfLove.ChapterSelectUI::waitingForSubmitButtonToClear
IL_0415: brtrue.s IL_046b
IL_0417: ldarg.0
IL_0418: ldfld UnityEngine.CanvasGroup TheForestOfLove.ChapterSelectUI::gossipUICanvasGroup
IL_041d: callvirt System.Single UnityEngine.CanvasGroup::get_alpha()
IL_0422: ldc.r4 1
IL_0427: bne.un.s IL_046b
IL_0429: ldarg.0
IL_042a: ldfld System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel> TheForestOfLove.ChapterSelectUI::itemLabels
IL_042f: ldarg.0
IL_0430: ldfld System.Int32 TheForestOfLove.ChapterSelectUI::itemLabelSelectedIndex
IL_0435: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ChapterSelectUI/GossipItemLabel>::get_Item(System.Int32)
IL_043a: callvirt TheForestOfLove.ChapterSelectUI/GossipItem TheForestOfLove.ChapterSelectUI/GossipItemLabel::get_gossipItem()
IL_043f: stloc.2
IL_0440: ldarg.0
IL_0441: ldc.i4.0
IL_0442: call System.Void TheForestOfLove.ChapterSelectUI::Hide(System.Boolean)
IL_0447: call System.Void TheForestOfLove.Services.Persistence.SaveManager::ForceAutosaveNow()
IL_044c: ldloc.2
IL_044d: ldfld TheForestOfLove.Narrative.Chapter TheForestOfLove.ChapterSelectUI/GossipItem::unlockStopPoint
IL_0452: ldloc.2
IL_0453: ldfld System.String TheForestOfLove.ChapterSelectUI/GossipItem::respawnInScene
IL_0458: ldloc.2
IL_0459: ldfld System.String TheForestOfLove.ChapterSelectUI/GossipItem::namedSpawnPoint
IL_045e: ldloc.2
IL_045f: ldfld System.Nullable`1<TheForestOfLove.Direction> TheForestOfLove.ChapterSelectUI/GossipItem::playerDirection
IL_0464: call System.Void TheForestOfLove.ChapterSelectUI::DoChapterSelect(TheForestOfLove.Narrative.Chapter,System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_0469: br.s IL_0481
IL_046b: call System.Boolean TheForestOfLove.InputHelper::get_IsSubmitButtonDown()
IL_0470: brtrue.s IL_0481
IL_0472: ldarg.0
IL_0473: ldfld System.Boolean TheForestOfLove.ChapterSelectUI::waitingForSubmitButtonToClear
IL_0478: brfalse.s IL_0481
IL_047a: ldarg.0
IL_047b: ldc.i4.0
IL_047c: stfld System.Boolean TheForestOfLove.ChapterSelectUI::waitingForSubmitButtonToClear
IL_0481: call System.Boolean TheForestOfLove.InputHelper::get_IsBackButtonDown()
IL_0486: brtrue.s IL_0499
IL_0488: ldarg.0
IL_0489: ldfld System.Boolean TheForestOfLove.ChapterSelectUI::waitedAtLeastOneFrameForVisibilityToggle
IL_048e: brfalse.s IL_04a0
IL_0490: ldc.i4.s 99
IL_0492: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_0497: brfalse.s IL_04a0
IL_0499: ldarg.0
IL_049a: ldc.i4.0
IL_049b: call System.Void TheForestOfLove.ChapterSelectUI::Hide(System.Boolean)
IL_04a0: ldarg.0
IL_04a1: ldc.i4.1
IL_04a2: stfld System.Boolean TheForestOfLove.ChapterSelectUI::waitedAtLeastOneFrameForVisibilityToggle
IL_04a7: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::DoChapterSelect(TheForestOfLove.Narrative.Chapter,System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_0000: ldc.i4.1
IL_0001: stsfld System.Boolean Globals::isChapterSelect
IL_0006: ldstr "ChapterSelect"
IL_000b: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)
IL_0010: call System.Void TheForestOfLove.Narrative.InstancedStoryController::AbortAnyActiveAdventureChapterSelect()
IL_0015: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Services.Persistence.Savestate>()
IL_001a: callvirt TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.Savestate::DeepCopy()
IL_001f: call System.Void TheForestOfLove.Services.Persistence.SaveManager::DeleteSavedPlaySession()
IL_0024: call System.Void TheForestOfLove.Services.Persistence.SaveManager::ResetSavestateForChapterSelect()
IL_0029: call System.Void TheForestOfLove.Services.Persistence.DataService::RestoreNonlinearContent(TheForestOfLove.Services.Persistence.Savestate)
IL_002e: ldarg.0
IL_002f: call System.Void TheForestOfLove.UnlockHelper::Unlock(TheForestOfLove.Narrative.Chapter)
IL_0034: ldarg.1
IL_0035: ldarg.2
IL_0036: ldarg.3
IL_0037: call System.Void TheForestOfLove.SpawnManager::ReplaceSpawnData(System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_003c: ldarg.0
IL_003d: call TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Services.Persistence.DataService::GetChapterRecordByChapter(TheForestOfLove.Narrative.Chapter)
IL_0042: stloc.0
IL_0043: ldloc.0
IL_0044: brfalse.s IL_005b
IL_0046: ldstr "chapter selected to "
IL_004b: ldloc.0
IL_004c: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::title
IL_0051: call System.String System.String::Concat(System.String,System.String)
IL_0056: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_005b: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSave()
IL_0060: ldc.i4.0
IL_0061: stsfld System.Boolean Globals::isChapterSelect
IL_0066: ldstr "ChapterSelect"
IL_006b: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSoftResetScene(System.String)
IL_0070: ret
METHOD System.Void TheForestOfLove.ChapterSelectUI::SelectItemLabel(System.Int32)
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
METHOD System.Void TheForestOfLove.ChapterSelectUI::RefreshItemsMasterList()
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Int32 TheForestOfLove.ChapterSelectUI::gossipItemSelectedIndex
IL_0007: ret
