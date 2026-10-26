TYPE TheForestOfLove.CustomTypewriterEffectTextMeshPro
METHOD System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue_Internal() | attributes=Public, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldarg.0
IL_0009: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_000e: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_0013: callvirt !!0 UnityEngine.Component::GetComponentInChildren<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>()
IL_0018: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUISubtitlePanel::continueButton
IL_001d: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0022: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0027: ret
