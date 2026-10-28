TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerMovieEndings
METHOD System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Events.TriggerHandlers.TriggerHandlerMovieEndings::get_triggerFilters() | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "global-handler:_run-for-all-triggers"
IL_000b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0010: pop
IL_0011: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerMovieEndings::StartPlantQuestMinigame() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Act1_PlantQuest"
IL_0005: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_000a: ldc.i4 200
IL_000f: bne.un.s IL_0012
IL_0011: ret
IL_0012: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.PlantQuestMinigameControllerRedux>()
IL_0017: callvirt System.Void TheForestOfLove.PlantQuestMinigameControllerRedux::StartMinigame()
IL_001c: ret
