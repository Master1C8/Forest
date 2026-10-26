TYPE Itelisoft.KOF.TheKingOfJoysticks
METHOD System.Void Itelisoft.KOF.TheKingOfJoysticks::UpdateMouseMode()
IL_0000: ldc.i4.0
IL_0001: call System.Boolean UnityEngine.Input::GetMouseButtonUp(System.Int32)
IL_0006: brfalse IL_00a6
IL_000b: ldarg.0
IL_000c: ldc.i4.0
IL_000d: stfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::recCombos
IL_0012: ldarg.0
IL_0013: ldc.i4.0
IL_0014: stfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::insideArea
IL_0019: ldarg.0
IL_001a: ldc.i4.0
IL_001b: stfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::inUse
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.UI.Image Itelisoft.KOF.TheKingOfJoysticks::centerImage
IL_0026: callvirt !!0 UnityEngine.Component::GetComponent<UnityEngine.RectTransform>()
IL_002b: ldarg.0
IL_002c: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::startPosition
IL_0031: ldfld System.Single UnityEngine.Vector2::x
IL_0036: ldarg.0
IL_0037: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::centerSize
IL_003c: ldfld System.Single UnityEngine.Vector2::x
IL_0041: sub
IL_0042: ldarg.0
IL_0043: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::startPosition
IL_0048: ldfld System.Single UnityEngine.Vector2::y
IL_004d: ldarg.0
IL_004e: ldflda UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::centerSize
IL_0053: ldfld System.Single UnityEngine.Vector2::y
IL_0058: sub
IL_0059: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_005e: callvirt System.Void UnityEngine.RectTransform::set_anchoredPosition(UnityEngine.Vector2)
IL_0063: ldarg.0
IL_0064: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::hideJoystickOnTouchEnd
IL_0069: brfalse.s IL_0071
IL_006b: ldarg.0
IL_006c: call System.Void Itelisoft.KOF.TheKingOfJoysticks::HideJoystick()
IL_0071: ldarg.0
IL_0072: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::D_padMode
IL_0077: brfalse.s IL_008a
IL_0079: ldarg.0
IL_007a: ldfld UnityEngine.UI.Image Itelisoft.KOF.TheKingOfJoysticks::borderImage
IL_007f: ldarg.0
IL_0080: ldfld UnityEngine.Sprite Itelisoft.KOF.TheKingOfJoysticks::idleSp
IL_0085: callvirt System.Void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)
IL_008a: ldarg.0
IL_008b: ldfld UnityEngine.Events.UnityEvent Itelisoft.KOF.JoystickCore::OnMoveEnds
IL_0090: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0095: ldarg.0
IL_0096: call System.Void Itelisoft.KOF.TheKingOfJoysticks::ClearDirections()
IL_009b: ldarg.0
IL_009c: ldfld System.Collections.Generic.HashSet`1<System.Int32> Itelisoft.KOF.TheKingOfJoysticks::touchesToCareAbout
IL_00a1: callvirt System.Void System.Collections.Generic.HashSet`1<System.Int32>::Clear()
IL_00a6: ldarg.0
IL_00a7: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::inUse
IL_00ac: brfalse.s IL_00c0
IL_00ae: ldarg.0
IL_00af: call UnityEngine.Vector3 UnityEngine.Input::get_mousePosition()
IL_00b4: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_00b9: call System.Void Itelisoft.KOF.TheKingOfJoysticks::TranslateCenter(UnityEngine.Vector2)
IL_00be: br.s IL_0115
IL_00c0: ldc.i4.0
IL_00c1: call System.Boolean UnityEngine.Input::GetMouseButtonDown(System.Int32)
IL_00c6: brfalse.s IL_0115
IL_00c8: ldarg.0
IL_00c9: call UnityEngine.Vector3 UnityEngine.Input::get_mousePosition()
IL_00ce: call System.Boolean Itelisoft.KOF.TheKingOfJoysticks::IsPositionOutOfBounds(UnityEngine.Vector3)
IL_00d3: brfalse.s IL_00d6
IL_00d5: ret
IL_00d6: ldarg.0
IL_00d7: ldfld System.Collections.Generic.HashSet`1<System.Int32> Itelisoft.KOF.TheKingOfJoysticks::touchesToCareAbout
IL_00dc: callvirt System.Int32 System.Collections.Generic.HashSet`1<System.Int32>::get_Count()
IL_00e1: brtrue.s IL_00f0
IL_00e3: ldarg.0
IL_00e4: ldfld System.Collections.Generic.HashSet`1<System.Int32> Itelisoft.KOF.TheKingOfJoysticks::touchesToCareAbout
IL_00e9: ldc.i4.0
IL_00ea: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_00ef: pop
IL_00f0: ldarg.0
IL_00f1: ldfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::insideArea
IL_00f6: brfalse.s IL_0115
IL_00f8: ldarg.0
IL_00f9: call UnityEngine.Vector3 UnityEngine.Input::get_mousePosition()
IL_00fe: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_0103: stfld UnityEngine.Vector2 Itelisoft.KOF.TheKingOfJoysticks::temporalPosStart
IL_0108: ldarg.0
IL_0109: ldarg.0
IL_010a: call System.Collections.IEnumerator Itelisoft.KOF.TheKingOfJoysticks::ValidateMouseMode()
IL_010f: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0114: pop
IL_0115: ldarg.0
IL_0116: call System.Void Itelisoft.KOF.TheKingOfJoysticks::SaveLastMovement()
IL_011b: ret
METHOD System.Collections.IEnumerator Itelisoft.KOF.TheKingOfJoysticks::ValidateMouseMode()
IL_0000: ldc.i4.0
IL_0001: newobj System.Void Itelisoft.KOF.TheKingOfJoysticks/<ValidateMouseMode>d__64::.ctor(System.Int32)
IL_0006: dup
IL_0007: ldarg.0
IL_0008: stfld Itelisoft.KOF.TheKingOfJoysticks Itelisoft.KOF.TheKingOfJoysticks/<ValidateMouseMode>d__64::<>4__this
IL_000d: ret
METHOD System.Void Itelisoft.KOF.TheKingOfJoysticks::MouseDown()
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean Itelisoft.KOF.TheKingOfJoysticks::insideArea
IL_0007: ret
METHOD System.Void Itelisoft.KOF.TheKingOfJoysticks::MouseUp()
IL_0000: ret
