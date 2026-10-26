TYPE TheForestOfLove.Narrative.StoryManager
METHOD System.Void TheForestOfLove.Narrative.StoryManager::OnDialogueStatusCompleted(TheForestOfLove.Narrative.Dialogue) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.Void TheForestOfLove.Narrative.Dialogue::FireDialogueTriggers()
IL_0006: ret
METHOD System.Void TheForestOfLove.Narrative.StoryManager::HandleDialogueEndFinishOrCancel(TheForestOfLove.Narrative.Dialogue,System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.ActorTrackingService>()
IL_0005: pop
IL_0006: ldarg.1
IL_0007: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_000c: call TheForestOfLove.Narrative.ActorDialogueOracle TheForestOfLove.Services.Persistence.DataService::GetActorDialogueOracleByActorDbName(System.String)
IL_0011: ldarg.1
IL_0012: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0017: callvirt System.Void TheForestOfLove.Narrative.ActorDialogueOracle::UpdateDialogueHistoryWithPlayedDialogue(System.String)
IL_001c: ret
