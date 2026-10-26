TYPE TheForestOfLove.DialogueNameplateController
METHOD System.Void TheForestOfLove.DialogueNameplateController::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle)
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.DialogueNameplateController::setFontToMainNextLine
IL_0006: brfalse.s IL_0010
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.DialogueNameplateController::SetFontToMain()
IL_000e: br.s IL_001e
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean TheForestOfLove.DialogueNameplateController::setFontToMouseNextLine
IL_0016: brfalse.s IL_001e
IL_0018: ldarg.0
IL_0019: call System.Void TheForestOfLove.DialogueNameplateController::SetFontToMouse()
IL_001e: ldarg.0
IL_001f: ldfld PixelCrushers.DialogueSystem.StandardDialogueUI TheForestOfLove.DialogueNameplateController::standardDialogueUI
IL_0024: callvirt System.Boolean PixelCrushers.DialogueSystem.AbstractDialogueUI::get_isOpen()
IL_0029: brtrue.s IL_002c
IL_002b: ret
IL_002c: ldarg.2
IL_002d: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0032: brfalse.s IL_004c
IL_0034: ldarg.2
IL_0035: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_003a: callvirt System.String System.String::ToLower()
IL_003f: ldstr "none"
IL_0044: callvirt System.Boolean System.String::Contains(System.String)
IL_0049: brfalse.s IL_004c
IL_004b: ret
IL_004c: ldarg.1
IL_004d: brtrue.s IL_0052
IL_004f: ldnull
IL_0050: br.s IL_0058
IL_0052: ldarg.1
IL_0053: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0058: stloc.0
IL_0059: ldarg.0
IL_005a: ldloc.0
IL_005b: call System.Void TheForestOfLove.DialogueNameplateController::UpdateNameplate(System.String)
IL_0060: ret
METHOD System.Void TheForestOfLove.DialogueNameplateController::SetFontToMouse()
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.DialogueNameplateController::setFontToMainNextLine
IL_0007: ldarg.0
IL_0008: ldc.i4.0
IL_0009: stfld System.Boolean TheForestOfLove.DialogueNameplateController::setFontToMouseNextLine
IL_000e: ldarg.0
IL_000f: ldfld TMPro.TMP_Text TheForestOfLove.DialogueNameplateController::dialogueBoxSubtitleTextTMPRO
IL_0014: ldnull
IL_0015: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001a: brfalse.s IL_004a
IL_001c: ldarg.0
IL_001d: ldfld TMPro.TMP_Text TheForestOfLove.DialogueNameplateController::dialogueBoxSubtitleTextTMPRO
IL_0022: ldsfld System.String System.String::Empty
IL_0027: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_002c: ldarg.0
IL_002d: ldfld TMPro.TMP_Text TheForestOfLove.DialogueNameplateController::dialogueBoxSubtitleTextTMPRO
IL_0032: ldarg.0
IL_0033: ldfld TMPro.TMP_FontAsset TheForestOfLove.DialogueNameplateController::fontMouse
IL_0038: callvirt System.Void TMPro.TMP_Text::set_font(TMPro.TMP_FontAsset)
IL_003d: ldarg.0
IL_003e: ldfld TMPro.TMP_Text TheForestOfLove.DialogueNameplateController::dialogueBoxSubtitleTextTMPRO
IL_0043: ldc.i4.1
IL_0044: ldc.i4.1
IL_0045: callvirt System.Void TMPro.TMP_Text::ForceMeshUpdate(System.Boolean,System.Boolean)
IL_004a: ret
