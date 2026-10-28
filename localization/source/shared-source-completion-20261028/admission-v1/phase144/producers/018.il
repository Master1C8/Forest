TYPE TheForestOfLove.BugReportMenu
METHOD System.Void TheForestOfLove.BugReportMenu::OnGlitchRascalCodeActivationTyped() | attributes=Private, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Services.Persistence.GlitchRascalPart1Data TheForestOfLove.Services.Persistence.DataService::GetGlitchRascalPart1Data()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldfld System.Boolean TheForestOfLove.Services.Persistence.GlitchRascalPart1Data::metGlitch
IL_000c: brfalse.s IL_0052
IL_000e: ldloc.0
IL_000f: ldfld System.Boolean TheForestOfLove.Services.Persistence.GlitchRascalPart1Data::typedBugReportCommand
IL_0014: brtrue.s IL_0052
IL_0016: ldloc.0
IL_0017: ldc.i4.1
IL_0018: stfld System.Boolean TheForestOfLove.Services.Persistence.GlitchRascalPart1Data::typedBugReportCommand
IL_001d: ldloc.0
IL_001e: ldarg.0
IL_001f: ldfld TMPro.TMP_InputField TheForestOfLove.BugReportMenu::bugReportText
IL_0024: callvirt System.String TMPro.TMP_InputField::get_text()
IL_0029: stfld System.String TheForestOfLove.Services.Persistence.GlitchRascalPart1Data::originalBugReportText
IL_002e: ldc.i4 400
IL_0033: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0038: call System.Void TheForestOfLove.UICameraGlitchController::DoHardGlitchDuringPausedGame()
IL_003d: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSave()
IL_0042: ldstr "Glitch Rascal"
IL_0047: call System.Void TheForestOfLove.Audio.SoundManager::PlayTypewriterSound(System.String)
IL_004c: ldarg.0
IL_004d: call System.Void TheForestOfLove.BugReportMenu::OnAlphabetKeyboardPendingActive()
IL_0052: ret
