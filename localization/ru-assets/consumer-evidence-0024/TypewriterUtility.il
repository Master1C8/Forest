TYPE PixelCrushers.DialogueSystem.TypewriterUtility
METHOD System.Void PixelCrushers.DialogueSystem.TypewriterUtility::StartTyping(PixelCrushers.UITextField,System.String,System.Int32)
IL_0000: ldarg.0
IL_0001: call PixelCrushers.DialogueSystem.AbstractTypewriterEffect PixelCrushers.DialogueSystem.TypewriterUtility::GetTypewriter(PixelCrushers.UITextField)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldnull
IL_0009: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000e: brfalse.s IL_0020
IL_0010: ldloc.0
IL_0011: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0016: brfalse.s IL_0020
IL_0018: ldloc.0
IL_0019: ldarg.1
IL_001a: ldarg.2
IL_001b: callvirt System.Void PixelCrushers.DialogueSystem.AbstractTypewriterEffect::StartTyping(System.String,System.Int32)
IL_0020: ret
