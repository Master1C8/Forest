TYPE PixelCrushers.DialogueSystem.StandardUIResponseButton
METHOD System.String PixelCrushers.DialogueSystem.StandardUIResponseButton::get_text()
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUIResponseButton::label
IL_0006: callvirt System.String PixelCrushers.UITextField::get_text()
IL_000b: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isClickable()
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_001a
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUIResponseButton::button
IL_0014: callvirt System.Boolean UnityEngine.UI.Selectable::get_interactable()
IL_0019: ret
IL_001a: ldc.i4.0
IL_001b: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::get_isVisible()
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIResponseButton::<isVisible>k__BackingField
IL_0006: ret
METHOD PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::get_response()
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.Response PixelCrushers.DialogueSystem.StandardUIResponseButton::<response>k__BackingField
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.StandardUIResponseButton::OnClick()
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
