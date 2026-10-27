TYPE PixelCrushers.DialogueSystem.DialogueSystemController
METHOD PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::get_dialogueUI() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::GetDialogueUI()
IL_0006: ret
METHOD PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::GetDialogueUI() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::ValidateCurrentDialogueUI()
IL_0006: ldarg.0
IL_0007: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::m_currentDialogueUI
IL_000c: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::GetDialogueUIFromDisplaySettings() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0006: ldfld UnityEngine.GameObject PixelCrushers.DialogueSystem.DisplaySettings::dialogueUI
IL_000b: ldnull
IL_000c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0011: brfalse IL_00a6
IL_0016: ldarg.0
IL_0017: ldarg.0
IL_0018: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_001d: ldfld UnityEngine.GameObject PixelCrushers.DialogueSystem.DisplaySettings::dialogueUI
IL_0022: call System.Boolean PixelCrushers.DialogueSystem.Tools::IsPrefab(UnityEngine.GameObject)
IL_0027: brtrue.s IL_004a
IL_0029: ldarg.0
IL_002a: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_002f: ldfld UnityEngine.GameObject PixelCrushers.DialogueSystem.DisplaySettings::dialogueUI
IL_0034: ldtoken PixelCrushers.DialogueSystem.IDialogueUI
IL_0039: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_003e: callvirt UnityEngine.Component UnityEngine.GameObject::GetComponentInChildren(System.Type)
IL_0043: isinst PixelCrushers.DialogueSystem.IDialogueUI
IL_0048: br.s IL_005b
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0051: ldfld UnityEngine.GameObject PixelCrushers.DialogueSystem.DisplaySettings::dialogueUI
IL_0056: call PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::LoadDialogueUIPrefab(UnityEngine.GameObject)
IL_005b: stfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::m_currentDialogueUI
IL_0060: ldarg.0
IL_0061: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::m_currentDialogueUI
IL_0066: brtrue.s IL_00c1
IL_0068: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_006d: brfalse.s IL_00c1
IL_006f: ldstr "{0}: No Dialogue UI found on '{1}'. Is the GameObject active and the dialogue UI script enabled? (Will load default UI for now.)"
IL_0074: ldc.i4.2
IL_0075: newarr System.Object
IL_007a: dup
IL_007b: ldc.i4.0
IL_007c: ldstr "Dialogue System"
IL_0081: stelem.ref
IL_0082: dup
IL_0083: ldc.i4.1
IL_0084: ldarg.0
IL_0085: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_008a: ldfld UnityEngine.GameObject PixelCrushers.DialogueSystem.DisplaySettings::dialogueUI
IL_008f: stelem.ref
IL_0090: call System.String System.String::Format(System.String,System.Object[])
IL_0095: ldarg.0
IL_0096: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_009b: ldfld UnityEngine.GameObject PixelCrushers.DialogueSystem.DisplaySettings::dialogueUI
IL_00a0: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_00a5: ret
IL_00a6: ldarg.0
IL_00a7: ldarg.0
IL_00a8: ldtoken PixelCrushers.DialogueSystem.IDialogueUI
IL_00ad: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_00b2: call UnityEngine.Component UnityEngine.Component::GetComponentInChildren(System.Type)
IL_00b7: isinst PixelCrushers.DialogueSystem.IDialogueUI
IL_00bc: stfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::m_currentDialogueUI
IL_00c1: ret
METHOD PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::LoadDialogueUIPrefab(UnityEngine.GameObject) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldarg.1
IL_0009: callvirt System.String UnityEngine.Object::get_name()
IL_000e: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_0013: ldnull
IL_0014: stloc.1
IL_0015: ldloc.0
IL_0016: ldnull
IL_0017: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001c: brfalse.s IL_009c
IL_001e: ldloc.0
IL_001f: ldtoken PixelCrushers.DialogueSystem.IDialogueUI
IL_0024: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0029: callvirt UnityEngine.Component UnityEngine.GameObject::GetComponentInChildren(System.Type)
IL_002e: isinst PixelCrushers.DialogueSystem.IDialogueUI
IL_0033: stloc.1
IL_0034: ldloc.1
IL_0035: brtrue.s IL_0067
IL_0037: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logErrors()
IL_003c: brfalse.s IL_005f
IL_003e: ldstr "{0}: No Dialogue UI component found on {1}."
IL_0043: ldc.i4.2
IL_0044: newarr System.Object
IL_0049: dup
IL_004a: ldc.i4.0
IL_004b: ldstr "Dialogue System"
IL_0050: stelem.ref
IL_0051: dup
IL_0052: ldc.i4.1
IL_0053: ldarg.1
IL_0054: stelem.ref
IL_0055: call System.String System.String::Format(System.String,System.Object[])
IL_005a: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_005f: ldloc.0
IL_0060: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0065: br.s IL_009c
IL_0067: ldloc.1
IL_0068: isinst PixelCrushers.DialogueSystem.CanvasDialogueUI
IL_006d: brfalse.s IL_008a
IL_006f: ldarg.0
IL_0070: call UnityEngine.Canvas PixelCrushers.DialogueSystem.DialogueSystemController::GetOrCreateDefaultCanvas()
IL_0075: stloc.2
IL_0076: ldloc.0
IL_0077: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_007c: ldloc.2
IL_007d: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0082: ldc.i4.0
IL_0083: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_0088: br.s IL_009c
IL_008a: ldloc.0
IL_008b: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0090: ldarg.0
IL_0091: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0096: ldc.i4.0
IL_0097: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_009c: ldloc.1
IL_009d: ret
