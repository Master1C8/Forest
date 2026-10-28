TYPE TheForestOfLove.ChapterSelectUI
METHOD System.Void TheForestOfLove.ChapterSelectUI::DoChapterSelect(TheForestOfLove.Narrative.Chapter,System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: stsfld System.Boolean Globals::isChapterSelect
IL_0006: ldstr "ChapterSelect"
IL_000b: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)
IL_0010: call System.Void TheForestOfLove.Narrative.InstancedStoryController::AbortAnyActiveAdventureChapterSelect()
IL_0015: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Services.Persistence.Savestate>()
IL_001a: callvirt TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.Savestate::DeepCopy()
IL_001f: call System.Void TheForestOfLove.Services.Persistence.SaveManager::DeleteSavedPlaySession()
IL_0024: call System.Void TheForestOfLove.Services.Persistence.SaveManager::ResetSavestateForChapterSelect()
IL_0029: call System.Void TheForestOfLove.Services.Persistence.DataService::RestoreNonlinearContent(TheForestOfLove.Services.Persistence.Savestate)
IL_002e: ldarg.0
IL_002f: call System.Void TheForestOfLove.UnlockHelper::Unlock(TheForestOfLove.Narrative.Chapter)
IL_0034: ldarg.1
IL_0035: ldarg.2
IL_0036: ldarg.3
IL_0037: call System.Void TheForestOfLove.SpawnManager::ReplaceSpawnData(System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_003c: ldarg.0
IL_003d: call TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Services.Persistence.DataService::GetChapterRecordByChapter(TheForestOfLove.Narrative.Chapter)
IL_0042: stloc.0
IL_0043: ldloc.0
IL_0044: brfalse.s IL_005b
IL_0046: ldstr "chapter selected to "
IL_004b: ldloc.0
IL_004c: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::title
IL_0051: call System.String System.String::Concat(System.String,System.String)
IL_0056: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_005b: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSave()
IL_0060: ldc.i4.0
IL_0061: stsfld System.Boolean Globals::isChapterSelect
IL_0066: ldstr "ChapterSelect"
IL_006b: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSoftResetScene(System.String)
IL_0070: ret
