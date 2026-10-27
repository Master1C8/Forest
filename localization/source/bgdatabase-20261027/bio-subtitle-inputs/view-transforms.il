TYPE PixelCrushers.DialogueSystem.ConversationView
METHOD System.Boolean PixelCrushers.DialogueSystem.ConversationView::CharacterInfoHasValidTransform(PixelCrushers.DialogueSystem.CharacterInfo) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_0010
IL_0003: ldarg.1
IL_0004: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0009: ldnull
IL_000a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000f: ret
IL_0010: ldc.i4.0
IL_0011: ret
