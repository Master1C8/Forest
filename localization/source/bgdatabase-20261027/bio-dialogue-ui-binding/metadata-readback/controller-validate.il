TYPE PixelCrushers.DialogueSystem.DialogueSystemController
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::ValidateCurrentDialogueUI() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::m_currentDialogueUI
IL_0006: brtrue.s IL_0048
IL_0008: ldarg.0
IL_0009: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::GetDialogueUIFromDisplaySettings()
IL_000e: ldarg.0
IL_000f: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::m_currentDialogueUI
IL_0014: brtrue.s IL_0022
IL_0016: ldarg.0
IL_0017: ldarg.0
IL_0018: call PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::LoadDefaultDialogueUI()
IL_001d: stfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::m_currentDialogueUI
IL_0022: ldarg.0
IL_0023: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::m_currentDialogueUI
IL_0028: isinst UnityEngine.MonoBehaviour
IL_002d: stloc.0
IL_002e: ldloc.0
IL_002f: ldnull
IL_0030: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0035: brfalse.s IL_0048
IL_0037: ldarg.0
IL_0038: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_003d: ldloc.0
IL_003e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0043: stfld UnityEngine.GameObject PixelCrushers.DialogueSystem.DisplaySettings::dialogueUI
IL_0048: ret
