TYPE TheForestOfLove.CustomTypewriterEffectTextMeshPro
METHOD System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue()
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.CustomTypewriterEffectTextMeshPro>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldnull
IL_0008: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000d: brfalse.s IL_0015
IL_000f: ldloc.0
IL_0010: callvirt System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue_Internal()
IL_0015: ret
METHOD System.Void TheForestOfLove.CustomTypewriterEffectTextMeshPro::FastForwardTextOrAdvanceDialogue_Internal()
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
