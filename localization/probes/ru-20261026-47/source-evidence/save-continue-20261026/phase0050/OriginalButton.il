TYPE TheForestOfLove.TextMeshProUIContinueButtonFastForward
METHOD System.Void TheForestOfLove.TextMeshProUIContinueButtonFastForward::OnFastForward() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld Febucci.UI.Core.TypewriterCore TheForestOfLove.TextMeshProUIContinueButtonFastForward::febucciTypewriterEffect
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_0027
IL_000e: ldarg.0
IL_000f: ldfld Febucci.UI.Core.TypewriterCore TheForestOfLove.TextMeshProUIContinueButtonFastForward::febucciTypewriterEffect
IL_0014: callvirt System.Boolean Febucci.UI.Core.TypewriterCore::get_isShowingText()
IL_0019: brfalse.s IL_0027
IL_001b: ldarg.0
IL_001c: ldfld Febucci.UI.Core.TypewriterCore TheForestOfLove.TextMeshProUIContinueButtonFastForward::febucciTypewriterEffect
IL_0021: callvirt System.Void Febucci.UI.Core.TypewriterCore::SkipTypewriter()
IL_0026: ret
IL_0027: ldarg.0
IL_0028: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::hideContinueButtonOnContinue
IL_002d: brfalse.s IL_004e
IL_002f: ldarg.0
IL_0030: ldfld UnityEngine.UI.Button TheForestOfLove.TextMeshProUIContinueButtonFastForward::zz_continueButton
IL_0035: ldnull
IL_0036: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_003b: brfalse.s IL_004e
IL_003d: ldarg.0
IL_003e: ldfld UnityEngine.UI.Button TheForestOfLove.TextMeshProUIContinueButtonFastForward::zz_continueButton
IL_0043: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0048: ldc.i4.0
IL_0049: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_004e: ldarg.0
IL_004f: call PixelCrushers.DialogueSystem.AbstractDialogueUI TheForestOfLove.TextMeshProUIContinueButtonFastForward::get_zz_runtimeDialogueUI()
IL_0054: ldnull
IL_0055: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_005a: brfalse.s IL_009f
IL_005c: ldarg.0
IL_005d: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::continueSubtitlePanel
IL_0062: brfalse.s IL_0078
IL_0064: ldarg.0
IL_0065: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::continueAlertPanel
IL_006a: brfalse.s IL_0078
IL_006c: ldarg.0
IL_006d: call PixelCrushers.DialogueSystem.AbstractDialogueUI TheForestOfLove.TextMeshProUIContinueButtonFastForward::get_zz_runtimeDialogueUI()
IL_0072: callvirt System.Void PixelCrushers.DialogueSystem.AbstractDialogueUI::OnContinue()
IL_0077: ret
IL_0078: ldarg.0
IL_0079: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::continueSubtitlePanel
IL_007e: brfalse.s IL_008c
IL_0080: ldarg.0
IL_0081: call PixelCrushers.DialogueSystem.AbstractDialogueUI TheForestOfLove.TextMeshProUIContinueButtonFastForward::get_zz_runtimeDialogueUI()
IL_0086: callvirt System.Void PixelCrushers.DialogueSystem.AbstractDialogueUI::OnContinueConversation()
IL_008b: ret
IL_008c: ldarg.0
IL_008d: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::continueAlertPanel
IL_0092: brfalse.s IL_009f
IL_0094: ldarg.0
IL_0095: call PixelCrushers.DialogueSystem.AbstractDialogueUI TheForestOfLove.TextMeshProUIContinueButtonFastForward::get_zz_runtimeDialogueUI()
IL_009a: callvirt System.Void PixelCrushers.DialogueSystem.AbstractDialogueUI::OnContinueAlert()
IL_009f: ret
