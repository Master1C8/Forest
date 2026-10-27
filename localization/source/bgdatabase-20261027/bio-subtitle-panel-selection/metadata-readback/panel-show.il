TYPE PixelCrushers.DialogueSystem.StandardUISubtitlePanel
METHOD System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::ShowSubtitle(PixelCrushers.DialogueSystem.Subtitle) | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitlePanel::waitForClose
IL_0006: brfalse.s IL_0028
IL_0008: ldarg.0
IL_0009: call PixelCrushers.DialogueSystem.StandardDialogueUI PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_dialogueUI()
IL_000e: callvirt System.Boolean PixelCrushers.DialogueSystem.StandardDialogueUI::AreAnyPanelsClosing()
IL_0013: brfalse.s IL_0028
IL_0015: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_001a: ldarg.0
IL_001b: ldarg.1
IL_001c: callvirt System.Collections.IEnumerator PixelCrushers.DialogueSystem.StandardUISubtitlePanel::ShowSubtitleAfterClosing(PixelCrushers.DialogueSystem.Subtitle)
IL_0021: callvirt UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0026: pop
IL_0027: ret
IL_0028: ldarg.0
IL_0029: ldarg.1
IL_002a: callvirt System.Void PixelCrushers.DialogueSystem.StandardUISubtitlePanel::ShowSubtitleNow(PixelCrushers.DialogueSystem.Subtitle)
IL_002f: ret
