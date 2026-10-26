TYPE TheForestOfLove.DialogueNameplateController
METHOD System.Void TheForestOfLove.DialogueNameplateController::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle) | attributes=Public, HideBySig | impl=IL
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
METHOD System.Void TheForestOfLove.DialogueNameplateController::OnConversationTriggerUpdatePortraits(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean Globals::get_DisableTriggeredEffects()
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldarg.1
IL_0009: brfalse.s IL_003d
IL_000b: ldarg.1
IL_000c: ldstr "everyone"
IL_0011: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0016: brtrue.s IL_0026
IL_0018: ldarg.1
IL_0019: ldstr "unison"
IL_001e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0023: brtrue.s IL_0032
IL_0025: ret
IL_0026: ldarg.0
IL_0027: ldstr "(Everyone)"
IL_002c: call System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateNextLineOnly(System.String)
IL_0031: ret
IL_0032: ldarg.0
IL_0033: ldstr "(Both)"
IL_0038: call System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateNextLineOnly(System.String)
IL_003d: ret
METHOD System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateUntilCleared(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.DialogueNameplateController::customNameplateNextLineOnly
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: stfld System.String TheForestOfLove.DialogueNameplateController::customNameplate
IL_000e: ret
METHOD System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateNextLineOnly(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean TheForestOfLove.DialogueNameplateController::customNameplateNextLineOnly
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: stfld System.String TheForestOfLove.DialogueNameplateController::customNameplate
IL_000e: ret
