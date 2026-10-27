TYPE PixelCrushers.DialogueSystem.Localization
METHOD System.Void PixelCrushers.DialogueSystem.Localization::set_UseDefaultIfUndefined(System.Boolean) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void PixelCrushers.DialogueSystem.Localization::set_useDefaultIfUndefined(System.Boolean)
IL_0006: ret
METHOD System.Int32 PixelCrushers.DialogueSystem.Localization::GetCurrentLanguageID(PixelCrushers.TextTable) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Int32 PixelCrushers.DialogueSystem.Localization::m_currentLanguageID
IL_0005: ldc.i4.m1
IL_0006: bne.un.s IL_0021
IL_0008: ldarg.0
IL_0009: ldnull
IL_000a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000f: brfalse.s IL_0021
IL_0011: ldarg.0
IL_0012: call System.String PixelCrushers.DialogueSystem.Localization::get_language()
IL_0017: callvirt System.Int32 PixelCrushers.TextTable::GetLanguageID(System.String)
IL_001c: stsfld System.Int32 PixelCrushers.DialogueSystem.Localization::m_currentLanguageID
IL_0021: ldsfld System.Int32 PixelCrushers.DialogueSystem.Localization::m_currentLanguageID
IL_0026: ldc.i4.m1
IL_0027: beq.s IL_002f
IL_0029: ldsfld System.Int32 PixelCrushers.DialogueSystem.Localization::m_currentLanguageID
IL_002e: ret
IL_002f: ldc.i4.0
IL_0030: ret
