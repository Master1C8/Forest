TYPE TheForestOfLove.GlitchCubeCutscene/<>c
METHOD System.Void TheForestOfLove.GlitchCubeCutscene/<>c::<Cutscene>b__11_0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Services.Persistence.GlitchRascalPart1Data TheForestOfLove.Services.Persistence.DataService::GetGlitchRascalPart1Data()
IL_0005: ldc.i4.1
IL_0006: stfld System.Boolean TheForestOfLove.Services.Persistence.GlitchRascalPart1Data::foundGlitchCube
IL_000b: ldc.i4 400
IL_0010: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0015: ldstr "CentralForest"
IL_001a: ldnull
IL_001b: ldloca.s V_0
IL_001d: initobj System.Nullable`1<TheForestOfLove.Direction>
IL_0023: ldloc.0
IL_0024: call System.Void TheForestOfLove.SpawnManager::ReplaceSpawnData(System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_0029: call System.Void TheForestOfLove.Services.Persistence.SaveManager::SilentSave()
IL_002e: ldstr "StartMenu"
IL_0033: call System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadScene(System.String)
IL_0038: ldc.i4.1
IL_0039: stsfld System.Boolean TheForestOfLove.MainMenuController::gameJustStarted
IL_003e: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0048: ret
