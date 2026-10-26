TYPE TheForestOfLove.DialogueCanvasNarratorLayoutController
METHOD System.Void TheForestOfLove.DialogueCanvasNarratorLayoutController::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,System.String)
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.DialogueCanvasNarratorLayoutController::conversationStarted
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldarg.0
IL_000b: ldfld PixelCrushers.DialogueSystem.DialogueSystemController TheForestOfLove.DialogueCanvasNarratorLayoutController::dialogueSystemController
IL_0010: ldnull
IL_0011: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0016: brtrue.s IL_001f
IL_0018: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.DialogueSystemController>()
IL_001d: br.s IL_0025
IL_001f: ldarg.0
IL_0020: ldfld PixelCrushers.DialogueSystem.DialogueSystemController TheForestOfLove.DialogueCanvasNarratorLayoutController::dialogueSystemController
IL_0025: stfld PixelCrushers.DialogueSystem.DialogueSystemController TheForestOfLove.DialogueCanvasNarratorLayoutController::dialogueSystemController
IL_002a: ldarg.0
IL_002b: ldarg.0
IL_002c: ldfld System.Boolean TheForestOfLove.DialogueCanvasNarratorLayoutController::encounteredAtLeastOneLineWithText
IL_0031: brtrue.s IL_0057
IL_0033: ldarg.0
IL_0034: ldfld PixelCrushers.DialogueSystem.DialogueSystemController TheForestOfLove.DialogueCanvasNarratorLayoutController::dialogueSystemController
IL_0039: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueSystemController::get_currentConversationState()
IL_003e: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0043: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0048: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_004d: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0052: ldc.i4.0
IL_0053: ceq
IL_0055: br.s IL_0058
IL_0057: ldc.i4.1
IL_0058: stfld System.Boolean TheForestOfLove.DialogueCanvasNarratorLayoutController::encounteredAtLeastOneLineWithText
IL_005d: ldarg.1
IL_005e: brtrue.s IL_0063
IL_0060: ldnull
IL_0061: br.s IL_0069
IL_0063: ldarg.1
IL_0064: ldfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_0069: stloc.0
IL_006a: ldloc.0
IL_006b: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0070: brfalse.s IL_0079
IL_0072: ldarg.0
IL_0073: call System.String TheForestOfLove.DialogueCanvasNarratorLayoutController::GetActorNameTheSlowWay()
IL_0078: stloc.0
IL_0079: ldarg.0
IL_007a: ldloc.0
IL_007b: call System.Void TheForestOfLove.DialogueCanvasNarratorLayoutController::SwitchNpcAndNarratorLayouts(System.String)
IL_0080: ret
