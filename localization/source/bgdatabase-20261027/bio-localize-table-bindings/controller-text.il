TYPE PixelCrushers.DialogueSystem.DialogueSystemController
METHOD System.String PixelCrushers.DialogueSystem.DialogueSystemController::GetLocalizedText(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0006: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_000b: ldfld PixelCrushers.TextTable PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::textTable
IL_0010: ldnull
IL_0011: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0016: brfalse.s IL_001a
IL_0018: ldarg.1
IL_0019: ret
IL_001a: ldarg.0
IL_001b: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0020: ldfld PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings PixelCrushers.DialogueSystem.DisplaySettings::localizationSettings
IL_0025: ldfld PixelCrushers.TextTable PixelCrushers.DialogueSystem.DisplaySettings/LocalizationSettings::textTable
IL_002a: stloc.0
IL_002b: ldloc.0
IL_002c: ldarg.1
IL_002d: ldloc.0
IL_002e: call System.Int32 PixelCrushers.DialogueSystem.Localization::GetCurrentLanguageID(PixelCrushers.TextTable)
IL_0033: callvirt System.String PixelCrushers.TextTable::GetFieldTextForLanguage(System.String,System.Int32)
IL_0038: stloc.1
IL_0039: ldloc.1
IL_003a: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_003f: brtrue.s IL_0043
IL_0041: ldloc.1
IL_0042: ret
IL_0043: ldarg.1
IL_0044: ret
