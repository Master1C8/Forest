TYPE PixelCrushers.DialogueSystem.DialogueManager
METHOD PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::m_instance
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_0017
IL_000d: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.DialogueSystemController>()
IL_0012: stsfld PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::m_instance
IL_0017: ldsfld PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::m_instance
IL_001c: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueManager::InitStaticVariables() | attributes=Private, Static, HideBySig | impl=IL
ATTRIBUTE UnityEngine.RuntimeInitializeOnLoadMethodAttribute
IL_0000: ldnull
IL_0001: stsfld PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::m_instance
IL_0006: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueManager::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ret
