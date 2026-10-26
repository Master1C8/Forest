TYPE PixelCrushers.DialogueSystem.StandardUIResponseButton
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::OnClick() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_002b
IL_000e: ldarg.0
IL_000f: callvirt System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::SetCurrentResponse()
IL_0014: ldarg.0
IL_0015: call UnityEngine.Transform PixelCrushers.DialogueSystem.StandardUIResponseButton::get_target()
IL_001a: ldstr "OnClick"
IL_001f: ldarg.0
IL_0020: call PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0025: ldc.i4.0
IL_0026: callvirt System.Void UnityEngine.Component::SendMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_002b: ret
