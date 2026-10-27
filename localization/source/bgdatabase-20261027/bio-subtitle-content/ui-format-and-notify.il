TYPE PixelCrushers.DialogueSystem.UITools
METHOD System.String PixelCrushers.DialogueSystem.UITools::GetUIFormattedText(PixelCrushers.DialogueSystem.FormattedText) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: brtrue.s IL_0009
IL_0003: ldsfld System.String System.String::Empty
IL_0008: ret
IL_0009: ldarg.0
IL_000a: callvirt System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_italic()
IL_000f: brfalse.s IL_0027
IL_0011: ldstr "<i>"
IL_0016: ldarg.0
IL_0017: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_001c: ldstr "</i>"
IL_0021: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0026: ret
IL_0027: ldarg.0
IL_0028: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_002d: ret
METHOD System.Void PixelCrushers.DialogueSystem.UITools::SendTextChangeMessage(UnityEngine.UI.Text) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_000a
IL_0009: ret
IL_000a: ldsfld PixelCrushers.DialogueSystem.AbstractDialogueUI PixelCrushers.DialogueSystem.UITools::dialogueUI
IL_000f: ldnull
IL_0010: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0015: brfalse.s IL_0022
IL_0017: ldarg.0
IL_0018: callvirt !!0 UnityEngine.Component::GetComponentInParent<PixelCrushers.DialogueSystem.AbstractDialogueUI>()
IL_001d: stsfld PixelCrushers.DialogueSystem.AbstractDialogueUI PixelCrushers.DialogueSystem.UITools::dialogueUI
IL_0022: ldsfld PixelCrushers.DialogueSystem.AbstractDialogueUI PixelCrushers.DialogueSystem.UITools::dialogueUI
IL_0027: ldnull
IL_0028: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_002d: brfalse.s IL_0030
IL_002f: ret
IL_0030: ldsfld PixelCrushers.DialogueSystem.AbstractDialogueUI PixelCrushers.DialogueSystem.UITools::dialogueUI
IL_0035: ldstr "OnTextChange"
IL_003a: ldarg.0
IL_003b: ldc.i4.1
IL_003c: callvirt System.Void UnityEngine.Component::SendMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_0041: ret
METHOD System.Void PixelCrushers.DialogueSystem.UITools::SendTextChangeMessage(PixelCrushers.UITextField) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt UnityEngine.GameObject PixelCrushers.UITextField::get_gameObject()
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: ldarg.0
IL_0010: callvirt UnityEngine.GameObject PixelCrushers.UITextField::get_gameObject()
IL_0015: ldstr "OnTextChange"
IL_001a: ldarg.0
IL_001b: ldc.i4.1
IL_001c: callvirt System.Void UnityEngine.GameObject::SendMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_0021: ret
