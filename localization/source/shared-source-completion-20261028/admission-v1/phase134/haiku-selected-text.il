TYPE TheForestOfLove.ResponseOptionsUI
METHOD System.Void TheForestOfLove.ResponseOptionsUI::SelectResponseOption(System.Int32) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Int32 TheForestOfLove.ResponseOptionsUI::responseOptionSelectedIndex
IL_0007: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.StandardUIMenuPanel>()
IL_000c: stloc.0
IL_000d: ldloc.0
IL_000e: ldnull
IL_000f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0014: brfalse.s IL_0063
IL_0016: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_001b: ldnull
IL_001c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0021: brfalse.s IL_0063
IL_0023: ldloc.0
IL_0024: callvirt System.Collections.Generic.List`1<UnityEngine.GameObject> PixelCrushers.DialogueSystem.StandardUIMenuPanel::get_instantiatedButtons()
IL_0029: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.GameObject>::get_Count()
IL_002e: ldc.i4.0
IL_002f: ble.s IL_0063
IL_0031: ldarg.1
IL_0032: ldarg.0
IL_0033: ldfld System.Int32 TheForestOfLove.ResponseOptionsUI::dialogueCanvasResponseOptionSelectedIndex
IL_0038: add
IL_0039: ldloc.0
IL_003a: callvirt System.Collections.Generic.List`1<UnityEngine.GameObject> PixelCrushers.DialogueSystem.StandardUIMenuPanel::get_instantiatedButtons()
IL_003f: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.GameObject>::get_Count()
IL_0044: bge.s IL_0063
IL_0046: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_004b: ldloc.0
IL_004c: callvirt System.Collections.Generic.List`1<UnityEngine.GameObject> PixelCrushers.DialogueSystem.StandardUIMenuPanel::get_instantiatedButtons()
IL_0051: ldarg.1
IL_0052: ldarg.0
IL_0053: ldfld System.Int32 TheForestOfLove.ResponseOptionsUI::dialogueCanvasResponseOptionSelectedIndex
IL_0058: add
IL_0059: callvirt !0 System.Collections.Generic.List`1<UnityEngine.GameObject>::get_Item(System.Int32)
IL_005e: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0063: ldarg.0
IL_0064: ldfld System.Int32 TheForestOfLove.ResponseOptionsUI::dialogueCanvasResponseOptionSelectedIndex
IL_0069: ldc.i4.0
IL_006a: ldarg.0
IL_006b: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.ResponseOptionsUI::dialogueCanvasResponseOptionsText
IL_0070: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0075: ldc.i4.1
IL_0076: sub
IL_0077: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_007c: stloc.1
IL_007d: ldarg.0
IL_007e: call System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption> TheForestOfLove.ResponseOptionsUI::get_responseOptionLabels()
IL_0083: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption>::get_Count()
IL_0088: ldc.i4.1
IL_0089: sub
IL_008a: ldarg.0
IL_008b: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.ResponseOptionsUI::dialogueCanvasResponseOptionsText
IL_0090: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0095: ldc.i4.1
IL_0096: sub
IL_0097: call System.Int32 UnityEngine.Mathf::Min(System.Int32,System.Int32)
IL_009c: stloc.2
IL_009d: ldarg.0
IL_009e: ldfld System.Int32 TheForestOfLove.ResponseOptionsUI::dialogueCanvasResponseOptionSelectedIndex
IL_00a3: ldarg.0
IL_00a4: ldfld System.Int32 TheForestOfLove.ResponseOptionsUI::numVisibleOptions
IL_00a9: add
IL_00aa: ldloc.2
IL_00ab: ldarg.0
IL_00ac: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.ResponseOptionsUI::dialogueCanvasResponseOptionsText
IL_00b1: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_00b6: ldc.i4.1
IL_00b7: sub
IL_00b8: call System.Int32 UnityEngine.Mathf::Clamp(System.Int32,System.Int32,System.Int32)
IL_00bd: stloc.3
IL_00be: ldc.i4.0
IL_00bf: stloc.s V_4
IL_00c1: ldloc.1
IL_00c2: stloc.s V_5
IL_00c4: br.s IL_0135
IL_00c6: ldloc.s V_5
IL_00c8: ldloc.1
IL_00c9: blt.s IL_0116
IL_00cb: ldloc.s V_5
IL_00cd: ldloc.3
IL_00ce: bgt.s IL_0116
IL_00d0: ldloc.s V_4
IL_00d2: ldarg.1
IL_00d3: bne.un.s IL_0101
IL_00d5: ldarg.0
IL_00d6: call System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption> TheForestOfLove.ResponseOptionsUI::get_responseOptionLabels()
IL_00db: ldloc.s V_4
IL_00dd: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption>::get_Item(System.Int32)
IL_00e2: ldc.i4.0
IL_00e3: callvirt System.Void TheForestOfLove.ResponseOptionsUI/ResponseOption::SetStatus(TheForestOfLove.ResponseOptionsUI/ResponseOptionStatus)
IL_00e8: ldarg.0
IL_00e9: call System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption> TheForestOfLove.ResponseOptionsUI::get_responseOptionLabels()
IL_00ee: ldloc.s V_4
IL_00f0: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption>::get_Item(System.Int32)
IL_00f5: callvirt System.String TheForestOfLove.ResponseOptionsUI/ResponseOption::get_text()
IL_00fa: call System.Void TheForestOfLove.ResponseOptionsUI::set_lastSelectedResponseOptionText(System.String)
IL_00ff: br.s IL_0129
IL_0101: ldarg.0
IL_0102: call System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption> TheForestOfLove.ResponseOptionsUI::get_responseOptionLabels()
IL_0107: ldloc.s V_4
IL_0109: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption>::get_Item(System.Int32)
IL_010e: ldc.i4.1
IL_010f: callvirt System.Void TheForestOfLove.ResponseOptionsUI/ResponseOption::SetStatus(TheForestOfLove.ResponseOptionsUI/ResponseOptionStatus)
IL_0114: br.s IL_0129
IL_0116: ldarg.0
IL_0117: call System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption> TheForestOfLove.ResponseOptionsUI::get_responseOptionLabels()
IL_011c: ldloc.s V_4
IL_011e: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption>::get_Item(System.Int32)
IL_0123: ldc.i4.2
IL_0124: callvirt System.Void TheForestOfLove.ResponseOptionsUI/ResponseOption::SetStatus(TheForestOfLove.ResponseOptionsUI/ResponseOptionStatus)
IL_0129: ldloc.s V_4
IL_012b: ldc.i4.1
IL_012c: add
IL_012d: stloc.s V_4
IL_012f: ldloc.s V_5
IL_0131: ldc.i4.1
IL_0132: add
IL_0133: stloc.s V_5
IL_0135: ldloc.s V_4
IL_0137: ldarg.0
IL_0138: call System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption> TheForestOfLove.ResponseOptionsUI::get_responseOptionLabels()
IL_013d: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ResponseOptionsUI/ResponseOption>::get_Count()
IL_0142: blt.s IL_00c6
IL_0144: ldarg.0
IL_0145: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::moreOptionsBelow
IL_014a: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_014f: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_0154: ldarg.0
IL_0155: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::responseOptionsContainer
IL_015a: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_015f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0164: brfalse.s IL_0192
IL_0166: ldarg.0
IL_0167: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::moreOptionsBelow
IL_016c: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0171: ldnull
IL_0172: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0177: ldarg.0
IL_0178: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::moreOptionsBelow
IL_017d: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0182: ldarg.0
IL_0183: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::responseOptionsContainer
IL_0188: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_018d: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0192: ldarg.0
IL_0193: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::responseOptionsContainerMirrored
IL_0198: ldnull
IL_0199: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_019e: brfalse.s IL_01ee
IL_01a0: ldarg.0
IL_01a1: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::moreOptionsBelow
IL_01a6: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01ab: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_01b0: ldarg.0
IL_01b1: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::responseOptionsContainerMirrored
IL_01b6: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01bb: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01c0: brfalse.s IL_01ee
IL_01c2: ldarg.0
IL_01c3: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::moreOptionsBelow
IL_01c8: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01cd: ldnull
IL_01ce: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_01d3: ldarg.0
IL_01d4: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::moreOptionsBelow
IL_01d9: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01de: ldarg.0
IL_01df: ldfld UnityEngine.GameObject TheForestOfLove.ResponseOptionsUI::responseOptionsContainerMirrored
IL_01e4: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01e9: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_01ee: ret
