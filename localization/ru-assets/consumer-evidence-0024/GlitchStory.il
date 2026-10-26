TYPE TheForestOfLove.GlitchRascalPart1Story
METHOD System.Void TheForestOfLove.GlitchRascalPart1Story::OnDialogueLine(System.String)
IL_0000: ret
METHOD System.Void TheForestOfLove.GlitchRascalPart1Story::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle)
IL_0000: call PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueManager::get_dialogueUI()
IL_0005: castclass PixelCrushers.DialogueSystem.StandardDialogueUI
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: ldnull
IL_000d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0012: brtrue.s IL_001c
IL_0014: ldloc.0
IL_0015: callvirt System.Boolean PixelCrushers.DialogueSystem.AbstractDialogueUI::get_isOpen()
IL_001a: brtrue.s IL_001d
IL_001c: ret
IL_001d: ldarg.2
IL_001e: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0023: brfalse.s IL_003d
IL_0025: ldarg.2
IL_0026: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_002b: callvirt System.String System.String::ToLower()
IL_0030: ldstr "none"
IL_0035: callvirt System.Boolean System.String::Contains(System.String)
IL_003a: brfalse.s IL_003d
IL_003c: ret
IL_003d: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsCurrentActorPlayer()
IL_0042: brfalse.s IL_0045
IL_0044: ret
IL_0045: call System.Boolean TheForestOfLove.GlitchRascalPart1Story::get_IsPart2SexScene()
IL_004a: brfalse.s IL_00c9
IL_004c: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0051: brfalse.s IL_00c9
IL_0053: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_0058: ldstr "glitch_respawned_rascal"
IL_005d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0062: brtrue.s IL_0075
IL_0064: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_0069: ldstr "glitch_sex_scene"
IL_006e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0073: brfalse.s IL_00c9
IL_0075: ldarg.0
IL_0076: ldfld UnityEngine.CanvasGroup TheForestOfLove.GlitchRascalPart1Story::rascalSubtitleTextSharedCanvas
IL_007b: ldc.r4 0
IL_0080: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0085: ldarg.0
IL_0086: ldfld UnityEngine.CanvasGroup TheForestOfLove.GlitchRascalPart1Story::glitchSubtitleTextSharedCanvas
IL_008b: ldc.r4 0
IL_0090: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_0095: ldarg.1
IL_0096: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_009b: ldstr "Glitch Rascal"
IL_00a0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00a5: brfalse.s IL_00b9
IL_00a7: ldarg.0
IL_00a8: ldfld UnityEngine.CanvasGroup TheForestOfLove.GlitchRascalPart1Story::glitchSubtitleTextSharedCanvas
IL_00ad: ldc.r4 1
IL_00b2: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00b7: br.s IL_00c9
IL_00b9: ldarg.0
IL_00ba: ldfld UnityEngine.CanvasGroup TheForestOfLove.GlitchRascalPart1Story::rascalSubtitleTextSharedCanvas
IL_00bf: ldc.r4 1
IL_00c4: callvirt System.Void UnityEngine.CanvasGroup::set_alpha(System.Single)
IL_00c9: ldarg.0
IL_00ca: ldfld System.Boolean TheForestOfLove.GlitchRascalPart1Story::disableAutomaticPortraits
IL_00cf: brfalse.s IL_00d2
IL_00d1: ret
IL_00d2: ldarg.2
IL_00d3: callvirt UnityEngine.Sprite PixelCrushers.DialogueSystem.Subtitle::GetSpeakerPortrait()
IL_00d8: stloc.1
IL_00d9: ldnull
IL_00da: stloc.2
IL_00db: ldnull
IL_00dc: stloc.3
IL_00dd: ldarg.0
IL_00de: ldloc.1
IL_00df: ldloca.s V_2
IL_00e1: ldloca.s V_3
IL_00e3: call TheForestOfLove.Narrative.Portrait TheForestOfLove.GlitchRascalPart1Story::FindSchemaBySprite(UnityEngine.Sprite,UnityEngine.Sprite&,UnityEngine.Sprite&)
IL_00e8: stloc.s V_4
IL_00ea: ldloc.s V_4
IL_00ec: brfalse.s IL_013b
IL_00ee: ldarg.0
IL_00ef: ldfld System.String TheForestOfLove.GlitchRascalPart1Story::lastPortraitName
IL_00f4: ldloc.s V_4
IL_00f6: ldfld System.String TheForestOfLove.Narrative.Portrait::dbName
IL_00fb: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0100: brfalse.s IL_013b
IL_0102: ldarg.0
IL_0103: ldloc.s V_4
IL_0105: ldfld System.String TheForestOfLove.Narrative.Portrait::dbName
IL_010a: stfld System.String TheForestOfLove.GlitchRascalPart1Story::lastPortraitName
IL_010f: ldarg.0
IL_0110: ldfld TheForestOfLove.GeneralStoryUIController TheForestOfLove.GlitchRascalPart1Story::storyController
IL_0115: ldloc.s V_4
IL_0117: ldfld UnityEngine.Sprite TheForestOfLove.Narrative.Portrait::sprite
IL_011c: ldc.r4 0
IL_0121: ldc.r4 0
IL_0126: callvirt System.Void TheForestOfLove.GeneralStoryUIController::SetStoryImage(UnityEngine.Sprite,System.Single,System.Single)
IL_012b: ldarg.0
IL_012c: ldfld UnityEngine.Animator TheForestOfLove.GlitchRascalPart1Story::portraitAnimator
IL_0131: ldstr "bounce"
IL_0136: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_013b: ret
