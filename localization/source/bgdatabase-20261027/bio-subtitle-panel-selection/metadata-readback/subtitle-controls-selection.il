TYPE PixelCrushers.DialogueSystem.StandardUISubtitleControls
METHOD PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::GetPanel(PixelCrushers.DialogueSystem.Subtitle,PixelCrushers.DialogueSystem.DialogueActor&) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.2
IL_0001: ldnull
IL_0002: stind.ref
IL_0003: ldarg.1
IL_0004: brtrue.s IL_000d
IL_0006: ldarg.0
IL_0007: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultNPCPanel
IL_000c: ret
IL_000d: ldarg.0
IL_000e: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_forcedOverridePanel
IL_0013: ldnull
IL_0014: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0019: brfalse.s IL_0022
IL_001b: ldarg.0
IL_001c: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_forcedOverridePanel
IL_0021: ret
IL_0022: ldarg.1
IL_0023: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0028: callvirt System.Int32 PixelCrushers.DialogueSystem.FormattedText::get_subtitlePanelNumber()
IL_002d: stloc.0
IL_002e: ldc.i4.0
IL_002f: ldloc.0
IL_0030: bgt.s IL_005e
IL_0032: ldloc.0
IL_0033: ldarg.0
IL_0034: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_0039: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Count()
IL_003e: bge.s IL_005e
IL_0040: ldarg.0
IL_0041: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_0046: ldloc.0
IL_0047: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Item(System.Int32)
IL_004c: dup
IL_004d: ldarg.1
IL_004e: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0053: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0058: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_actorOverridingPanel(UnityEngine.Transform)
IL_005d: ret
IL_005e: ldarg.0
IL_005f: ldfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_actorIdOverridePanel
IL_0064: ldarg.1
IL_0065: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_006a: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_006f: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::ContainsKey(!0)
IL_0074: brfalse.s IL_009e
IL_0076: ldarg.0
IL_0077: ldfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_actorIdOverridePanel
IL_007c: ldarg.1
IL_007d: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0082: ldfld System.Int32 PixelCrushers.DialogueSystem.CharacterInfo::id
IL_0087: callvirt !1 System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Item(!0)
IL_008c: dup
IL_008d: ldarg.1
IL_008e: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0093: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0098: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_actorOverridingPanel(UnityEngine.Transform)
IL_009d: ret
IL_009e: ldarg.1
IL_009f: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_00a4: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_00a9: stloc.1
IL_00aa: ldarg.0
IL_00ab: ldloc.1
IL_00ac: ldarg.1
IL_00ad: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_00b2: callvirt System.Boolean PixelCrushers.DialogueSystem.CharacterInfo::get_isNPC()
IL_00b7: brtrue.s IL_00c1
IL_00b9: ldarg.0
IL_00ba: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultPCPanel
IL_00bf: br.s IL_00c7
IL_00c1: ldarg.0
IL_00c2: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultNPCPanel
IL_00c7: ldarg.2
IL_00c8: call PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::GetActorTransformPanel(UnityEngine.Transform,PixelCrushers.DialogueSystem.StandardUISubtitlePanel,PixelCrushers.DialogueSystem.DialogueActor&)
IL_00cd: ret
METHOD PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::GetActorTransformPanel(UnityEngine.Transform,PixelCrushers.DialogueSystem.StandardUISubtitlePanel,PixelCrushers.DialogueSystem.DialogueActor&) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.3
IL_0001: ldnull
IL_0002: stind.ref
IL_0003: ldarg.1
IL_0004: ldnull
IL_0005: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000a: brfalse.s IL_000e
IL_000c: ldarg.2
IL_000d: ret
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.DialogueActor> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_dialogueActorCache
IL_0014: ldarg.1
IL_0015: callvirt System.Boolean System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.DialogueActor>::ContainsKey(!0)
IL_001a: brfalse.s IL_002c
IL_001c: ldarg.3
IL_001d: ldarg.0
IL_001e: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.DialogueActor> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_dialogueActorCache
IL_0023: ldarg.1
IL_0024: callvirt !1 System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.DialogueActor>::get_Item(!0)
IL_0029: stind.ref
IL_002a: br.s IL_0042
IL_002c: ldarg.3
IL_002d: ldarg.1
IL_002e: call PixelCrushers.DialogueSystem.DialogueActor PixelCrushers.DialogueSystem.DialogueActor::GetDialogueActorComponent(UnityEngine.Transform)
IL_0033: stind.ref
IL_0034: ldarg.0
IL_0035: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.DialogueActor> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_dialogueActorCache
IL_003a: ldarg.1
IL_003b: ldarg.3
IL_003c: ldind.ref
IL_003d: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.DialogueActor>::Add(!0,!1)
IL_0042: ldarg.0
IL_0043: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_actorPanelCache
IL_0048: ldarg.1
IL_0049: callvirt System.Boolean System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::ContainsKey(!0)
IL_004e: brfalse.s IL_005d
IL_0050: ldarg.0
IL_0051: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_actorPanelCache
IL_0056: ldarg.1
IL_0057: callvirt !1 System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Item(!0)
IL_005c: ret
IL_005d: ldarg.0
IL_005e: ldfld System.Collections.Generic.List`1<UnityEngine.Transform> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_useBarkUIs
IL_0063: ldarg.1
IL_0064: callvirt System.Boolean System.Collections.Generic.List`1<UnityEngine.Transform>::Contains(!0)
IL_0069: brfalse.s IL_006d
IL_006b: ldnull
IL_006c: ret
IL_006d: ldarg.0
IL_006e: ldarg.3
IL_006f: ldind.ref
IL_0070: call System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitleControls::DialogueActorUsesBarkUI(PixelCrushers.DialogueSystem.DialogueActor)
IL_0075: brfalse.s IL_0085
IL_0077: ldarg.0
IL_0078: ldfld System.Collections.Generic.List`1<UnityEngine.Transform> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_useBarkUIs
IL_007d: ldarg.1
IL_007e: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.Transform>::Add(!0)
IL_0083: ldnull
IL_0084: ret
IL_0085: ldarg.0
IL_0086: ldarg.3
IL_0087: ldind.ref
IL_0088: call PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::GetDialogueActorPanel(PixelCrushers.DialogueSystem.DialogueActor)
IL_008d: stloc.0
IL_008e: ldloc.0
IL_008f: ldnull
IL_0090: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0095: brfalse.s IL_0099
IL_0097: ldarg.2
IL_0098: stloc.0
IL_0099: ldarg.0
IL_009a: ldfld System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_actorPanelCache
IL_009f: ldarg.1
IL_00a0: ldloc.0
IL_00a1: callvirt System.Void System.Collections.Generic.Dictionary`2<UnityEngine.Transform,PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::Add(!0,!1)
IL_00a6: ldloc.0
IL_00a7: ret
METHOD PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::GetDialogueActorPanel(PixelCrushers.DialogueSystem.DialogueActor) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_000b
IL_0009: ldnull
IL_000a: ret
IL_000b: ldarg.0
IL_000c: ldarg.1
IL_000d: ldfld PixelCrushers.DialogueSystem.DialogueActor/StandardDialogueUISettings PixelCrushers.DialogueSystem.DialogueActor::standardDialogueUISettings
IL_0012: ldfld PixelCrushers.DialogueSystem.SubtitlePanelNumber PixelCrushers.DialogueSystem.DialogueActor/StandardDialogueUISettings::subtitlePanelNumber
IL_0017: ldarg.1
IL_0018: ldfld PixelCrushers.DialogueSystem.DialogueActor/StandardDialogueUISettings PixelCrushers.DialogueSystem.DialogueActor::standardDialogueUISettings
IL_001d: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.DialogueActor/StandardDialogueUISettings::customSubtitlePanel
IL_0022: call PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::GetPanelFromNumber(PixelCrushers.DialogueSystem.SubtitlePanelNumber,PixelCrushers.DialogueSystem.StandardUISubtitlePanel)
IL_0027: ret
METHOD PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::GetPanelFromNumber(PixelCrushers.DialogueSystem.SubtitlePanelNumber,PixelCrushers.DialogueSystem.StandardUISubtitlePanel) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: switch IL_0014,IL_0032,IL_0016
IL_0012: br.s IL_0034
IL_0014: ldnull
IL_0015: ret
IL_0016: ldarg.0
IL_0017: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_customPanels
IL_001c: ldarg.2
IL_001d: callvirt System.Boolean System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::Contains(!0)
IL_0022: brtrue.s IL_0030
IL_0024: ldarg.0
IL_0025: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_customPanels
IL_002a: ldarg.2
IL_002b: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::Add(!0)
IL_0030: ldarg.2
IL_0031: ret
IL_0032: ldnull
IL_0033: ret
IL_0034: ldarg.1
IL_0035: call System.Int32 PixelCrushers.DialogueSystem.PanelNumberUtility::GetSubtitlePanelIndex(PixelCrushers.DialogueSystem.SubtitlePanelNumber)
IL_003a: stloc.0
IL_003b: ldc.i4.0
IL_003c: ldloc.0
IL_003d: bgt.s IL_004d
IL_003f: ldloc.0
IL_0040: ldarg.0
IL_0041: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_0046: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Count()
IL_004b: blt.s IL_004f
IL_004d: ldnull
IL_004e: ret
IL_004f: ldarg.0
IL_0050: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_0055: ldloc.0
IL_0056: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Item(System.Int32)
IL_005b: ret
