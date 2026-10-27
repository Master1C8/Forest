TYPE PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109
METHOD System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::MoveNext() | attributes=Private, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::<>1__state
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: ldfld PixelCrushers.DialogueSystem.StandardUISubtitlePanel PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::<>4__this
IL_000d: stloc.1
IL_000e: ldloc.0
IL_000f: brfalse.s IL_0017
IL_0011: ldloc.0
IL_0012: ldc.i4.1
IL_0013: beq.s IL_0085
IL_0015: ldc.i4.0
IL_0016: ret
IL_0017: ldarg.0
IL_0018: ldc.i4.m1
IL_0019: stfld System.Int32 PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::<>1__state
IL_001e: ldloc.1
IL_001f: call UnityEngine.Animator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_animator()
IL_0024: callvirt UnityEngine.RuntimeAnimatorController UnityEngine.Animator::get_runtimeAnimatorController()
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.RuntimeAnimatorController PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::animatorController
IL_002f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0034: brfalse.s IL_0047
IL_0036: ldloc.1
IL_0037: call UnityEngine.Animator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_animator()
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.RuntimeAnimatorController PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::animatorController
IL_0042: callvirt System.Void UnityEngine.Animator::set_runtimeAnimatorController(UnityEngine.RuntimeAnimatorController)
IL_0047: ldarg.0
IL_0048: ldfld UnityEngine.RuntimeAnimatorController PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::animatorController
IL_004d: ldnull
IL_004e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0053: brfalse.s IL_0071
IL_0055: ldloc.1
IL_0056: ldfld UnityEngine.UI.Image PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitImage
IL_005b: ldloc.1
IL_005c: ldfld UnityEngine.UI.Image PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitImage
IL_0061: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_0066: ldnull
IL_0067: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_006c: call System.Void PixelCrushers.DialogueSystem.Tools::SetGameObjectActive(UnityEngine.Component,System.Boolean)
IL_0071: ldarg.0
IL_0072: newobj System.Void UnityEngine.WaitForEndOfFrame::.ctor()
IL_0077: stfld System.Object PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::<>2__current
IL_007c: ldarg.0
IL_007d: ldc.i4.1
IL_007e: stfld System.Int32 PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::<>1__state
IL_0083: ldc.i4.1
IL_0084: ret
IL_0085: ldarg.0
IL_0086: ldc.i4.m1
IL_0087: stfld System.Int32 PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::<>1__state
IL_008c: ldloc.1
IL_008d: call UnityEngine.Animator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_animator()
IL_0092: callvirt UnityEngine.RuntimeAnimatorController UnityEngine.Animator::get_runtimeAnimatorController()
IL_0097: ldarg.0
IL_0098: ldfld UnityEngine.RuntimeAnimatorController PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::animatorController
IL_009d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00a2: brfalse.s IL_00b5
IL_00a4: ldloc.1
IL_00a5: call UnityEngine.Animator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_animator()
IL_00aa: ldarg.0
IL_00ab: ldfld UnityEngine.RuntimeAnimatorController PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::animatorController
IL_00b0: callvirt System.Void UnityEngine.Animator::set_runtimeAnimatorController(UnityEngine.RuntimeAnimatorController)
IL_00b5: ldarg.0
IL_00b6: ldfld UnityEngine.RuntimeAnimatorController PixelCrushers.DialogueSystem.StandardUISubtitlePanel/<SetAnimatorAtEndOfFrame>d__109::animatorController
IL_00bb: ldnull
IL_00bc: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00c1: brfalse.s IL_00df
IL_00c3: ldloc.1
IL_00c4: ldfld UnityEngine.UI.Image PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitImage
IL_00c9: ldloc.1
IL_00ca: ldfld UnityEngine.UI.Image PixelCrushers.DialogueSystem.StandardUISubtitlePanel::portraitImage
IL_00cf: callvirt UnityEngine.Sprite UnityEngine.UI.Image::get_sprite()
IL_00d4: ldnull
IL_00d5: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00da: call System.Void PixelCrushers.DialogueSystem.Tools::SetGameObjectActive(UnityEngine.Component,System.Boolean)
IL_00df: ldc.i4.0
IL_00e0: ret
