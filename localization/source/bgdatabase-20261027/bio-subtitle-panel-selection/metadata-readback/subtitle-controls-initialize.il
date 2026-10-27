TYPE PixelCrushers.DialogueSystem.StandardUISubtitleControls
METHOD PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::get_defaultNPCPanel() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultNPCPanel
IL_0006: ret
METHOD PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::get_defaultPCPanel() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultPCPanel
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUISubtitleControls::Initialize(PixelCrushers.DialogueSystem.StandardUISubtitlePanel[],PixelCrushers.DialogueSystem.StandardUISubtitlePanel,PixelCrushers.DialogueSystem.StandardUISubtitlePanel) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_0006: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::Clear()
IL_000b: ldarg.0
IL_000c: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_0011: ldarg.1
IL_0012: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_0017: ldarg.0
IL_0018: ldarg.2
IL_0019: ldnull
IL_001a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001f: brtrue.s IL_0040
IL_0021: ldarg.0
IL_0022: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_0027: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Count()
IL_002c: ldc.i4.0
IL_002d: bgt.s IL_0032
IL_002f: ldnull
IL_0030: br.s IL_0041
IL_0032: ldarg.0
IL_0033: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_0038: ldc.i4.0
IL_0039: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Item(System.Int32)
IL_003e: br.s IL_0041
IL_0040: ldarg.2
IL_0041: stfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultNPCPanel
IL_0046: ldarg.0
IL_0047: ldarg.3
IL_0048: ldnull
IL_0049: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_004e: brtrue.s IL_006f
IL_0050: ldarg.0
IL_0051: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_0056: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Count()
IL_005b: ldc.i4.0
IL_005c: bgt.s IL_0061
IL_005e: ldnull
IL_005f: br.s IL_0070
IL_0061: ldarg.0
IL_0062: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_0067: ldc.i4.0
IL_0068: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Item(System.Int32)
IL_006d: br.s IL_0070
IL_006f: ldarg.3
IL_0070: stfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultPCPanel
IL_0075: ldarg.0
IL_0076: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultNPCPanel
IL_007b: ldnull
IL_007c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0081: brfalse.s IL_008f
IL_0083: ldarg.0
IL_0084: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultNPCPanel
IL_0089: ldc.i4.1
IL_008a: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_isDefaultNPCPanel(System.Boolean)
IL_008f: ldarg.0
IL_0090: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultPCPanel
IL_0095: ldnull
IL_0096: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_009b: brfalse.s IL_00a9
IL_009d: ldarg.0
IL_009e: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_defaultPCPanel
IL_00a3: ldc.i4.1
IL_00a4: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_isDefaultPCPanel(System.Boolean)
IL_00a9: ldc.i4.0
IL_00aa: stloc.0
IL_00ab: br.s IL_00d7
IL_00ad: ldarg.0
IL_00ae: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_00b3: ldloc.0
IL_00b4: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Item(System.Int32)
IL_00b9: ldnull
IL_00ba: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00bf: brfalse.s IL_00d3
IL_00c1: ldarg.0
IL_00c2: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_00c7: ldloc.0
IL_00c8: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Item(System.Int32)
IL_00cd: ldloc.0
IL_00ce: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::set_panelNumber(System.Int32)
IL_00d3: ldloc.0
IL_00d4: ldc.i4.1
IL_00d5: add
IL_00d6: stloc.0
IL_00d7: ldloc.0
IL_00d8: ldarg.0
IL_00d9: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_builtinPanels
IL_00de: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>::get_Count()
IL_00e3: blt.s IL_00ad
IL_00e5: ldarg.0
IL_00e6: call System.Void PixelCrushers.DialogueSystem.StandardUISubtitleControls::ClearCache()
IL_00eb: ret
