TYPE TheForestOfLove.ChapterSelectUI/GossipItemLabel
METHOD System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::.ctor(TheForestOfLove.GossipUIItemTemplate,TheForestOfLove.GossipUIItemTemplate,TheForestOfLove.GossipUIItemTemplate,UnityEngine.GameObject,UnityEngine.GameObject) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: stfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiSelected
IL_000d: ldarg.0
IL_000e: ldarg.2
IL_000f: stfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiEnabled
IL_0014: ldarg.0
IL_0015: ldarg.3
IL_0016: stfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiEnabledUnread
IL_001b: ldarg.0
IL_001c: ldarg.s visibleObjectsContainer
IL_001e: stfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI/GossipItemLabel::visibleObjectsContainer
IL_0023: ldarg.0
IL_0024: ldarg.s hiddenObjectsContainer
IL_0026: stfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI/GossipItemLabel::hiddenObjectsContainer
IL_002b: ldarg.0
IL_002c: ldc.i4.2
IL_002d: ldnull
IL_002e: call System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetStatus(TheForestOfLove.ChapterSelectUI/ItemLabelStatus,TheForestOfLove.ChapterSelectUI/GossipItem)
IL_0033: ret
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
METHOD System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::SetStatus(TheForestOfLove.ChapterSelectUI/ItemLabelStatus,TheForestOfLove.ChapterSelectUI/GossipItem) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiSelected
IL_0006: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI/GossipItemLabel::hiddenObjectsContainer
IL_0011: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0016: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_001b: ldarg.0
IL_001c: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiEnabled
IL_0021: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0026: ldarg.0
IL_0027: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI/GossipItemLabel::hiddenObjectsContainer
IL_002c: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0031: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0036: ldarg.0
IL_0037: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiEnabledUnread
IL_003c: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0041: ldarg.0
IL_0042: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI/GossipItemLabel::hiddenObjectsContainer
IL_0047: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_004c: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0051: ldarg.0
IL_0052: ldnull
IL_0053: call System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::set_gossipItem(TheForestOfLove.ChapterSelectUI/GossipItem)
IL_0058: ldarg.1
IL_0059: brfalse.s IL_0064
IL_005b: ldarg.1
IL_005c: ldc.i4.1
IL_005d: beq.s IL_0099
IL_005f: br IL_0102
IL_0064: ldarg.0
IL_0065: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiSelected
IL_006a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_006f: ldarg.0
IL_0070: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI/GossipItemLabel::visibleObjectsContainer
IL_0075: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_007a: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_007f: ldarg.0
IL_0080: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiSelected
IL_0085: ldarg.0
IL_0086: call System.String TheForestOfLove.ChapterSelectUI/GossipItemLabel::get_text()
IL_008b: callvirt System.Void TheForestOfLove.GossipUIItemTemplate::SetText(System.String)
IL_0090: ldarg.0
IL_0091: ldarg.2
IL_0092: call System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::set_gossipItem(TheForestOfLove.ChapterSelectUI/GossipItem)
IL_0097: br.s IL_0102
IL_0099: ldarg.2
IL_009a: ldfld System.Boolean TheForestOfLove.ChapterSelectUI/GossipItem::isNew
IL_009f: brfalse.s IL_00cf
IL_00a1: ldarg.0
IL_00a2: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiEnabledUnread
IL_00a7: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00ac: ldarg.0
IL_00ad: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI/GossipItemLabel::visibleObjectsContainer
IL_00b2: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_00b7: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_00bc: ldarg.0
IL_00bd: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiEnabledUnread
IL_00c2: ldarg.0
IL_00c3: call System.String TheForestOfLove.ChapterSelectUI/GossipItemLabel::get_text()
IL_00c8: callvirt System.Void TheForestOfLove.GossipUIItemTemplate::SetText(System.String)
IL_00cd: br.s IL_00fb
IL_00cf: ldarg.0
IL_00d0: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiEnabled
IL_00d5: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00da: ldarg.0
IL_00db: ldfld UnityEngine.GameObject TheForestOfLove.ChapterSelectUI/GossipItemLabel::visibleObjectsContainer
IL_00e0: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_00e5: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_00ea: ldarg.0
IL_00eb: ldfld TheForestOfLove.GossipUIItemTemplate TheForestOfLove.ChapterSelectUI/GossipItemLabel::uiEnabled
IL_00f0: ldarg.0
IL_00f1: call System.String TheForestOfLove.ChapterSelectUI/GossipItemLabel::get_text()
IL_00f6: callvirt System.Void TheForestOfLove.GossipUIItemTemplate::SetText(System.String)
IL_00fb: ldarg.0
IL_00fc: ldarg.2
IL_00fd: call System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::set_gossipItem(TheForestOfLove.ChapterSelectUI/GossipItem)
IL_0102: ldarg.0
IL_0103: ldarg.1
IL_0104: call System.Void TheForestOfLove.ChapterSelectUI/GossipItemLabel::set_status(TheForestOfLove.ChapterSelectUI/ItemLabelStatus)
IL_0109: ret
