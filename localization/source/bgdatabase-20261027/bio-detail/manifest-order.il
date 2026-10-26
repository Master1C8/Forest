TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader::GenerateManifest() | attributes=Public, HideBySig | impl=IL
IL_0000: call PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueManager::get_databaseManager()
IL_0005: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_000a: stloc.0
IL_000b: newobj System.Void TheForestOfLove.Narrative.DataManifest::.ctor()
IL_0010: stloc.1
IL_0011: ldarg.0
IL_0012: ldloc.1
IL_0013: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateTags(TheForestOfLove.Narrative.DataManifest)
IL_0018: ldarg.0
IL_0019: ldloc.1
IL_001a: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateBioKeywords(TheForestOfLove.Narrative.DataManifest)
IL_001f: ldarg.0
IL_0020: ldloc.1
IL_0021: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateAreas(TheForestOfLove.Narrative.DataManifest)
IL_0026: ldarg.0
IL_0027: ldloc.1
IL_0028: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateTriggers(TheForestOfLove.Narrative.DataManifest)
IL_002d: ldarg.0
IL_002e: ldloc.1
IL_002f: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateMovies(TheForestOfLove.Narrative.DataManifest)
IL_0034: ldarg.0
IL_0035: ldloc.1
IL_0036: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateItems(TheForestOfLove.Narrative.DataManifest)
IL_003b: ldarg.0
IL_003c: ldloc.1
IL_003d: ldloc.0
IL_003e: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateActors(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0043: ldarg.0
IL_0044: ldloc.1
IL_0045: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GeneratePortraits(TheForestOfLove.Narrative.DataManifest)
IL_004a: ldarg.0
IL_004b: ldloc.1
IL_004c: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateActorBios(TheForestOfLove.Narrative.DataManifest)
IL_0051: ldarg.0
IL_0052: ldloc.1
IL_0053: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateGossipGreetings(TheForestOfLove.Narrative.DataManifest)
IL_0058: ldarg.0
IL_0059: ldloc.1
IL_005a: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateQuestStatuses(TheForestOfLove.Narrative.DataManifest)
IL_005f: ldarg.0
IL_0060: ldloc.1
IL_0061: ldloc.0
IL_0062: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateQuests(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0067: ldarg.0
IL_0068: ldloc.1
IL_0069: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateQuestProgressLogText(TheForestOfLove.Narrative.DataManifest)
IL_006e: ldarg.0
IL_006f: ldloc.1
IL_0070: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateDialogueStatuses(TheForestOfLove.Narrative.DataManifest)
IL_0075: ldarg.0
IL_0076: ldloc.1
IL_0077: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateArcStatuses(TheForestOfLove.Narrative.DataManifest)
IL_007c: ldarg.0
IL_007d: ldloc.1
IL_007e: ldloc.0
IL_007f: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateDialogues(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase)
IL_0084: ldarg.0
IL_0085: ldloc.1
IL_0086: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateChapters(TheForestOfLove.Narrative.DataManifest)
IL_008b: ldarg.0
IL_008c: ldloc.1
IL_008d: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddDialoguePreconditionsAndTriggers(TheForestOfLove.Narrative.DataManifest)
IL_0092: ldarg.0
IL_0093: ldloc.1
IL_0094: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddTriggerDialogueTriggers(TheForestOfLove.Narrative.DataManifest)
IL_0099: ldarg.0
IL_009a: ldloc.1
IL_009b: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddArcPreconditionsAndTriggers(TheForestOfLove.Narrative.DataManifest)
IL_00a0: ldarg.0
IL_00a1: ldloc.1
IL_00a2: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::AddDialoguePreconditionsOnscreenOffscreenWatchInferredTriggers(TheForestOfLove.Narrative.DataManifest)
IL_00a7: ldarg.0
IL_00a8: ldloc.1
IL_00a9: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PrioritizeArcTriggers(TheForestOfLove.Narrative.DataManifest)
IL_00ae: ldloc.1
IL_00af: ret
