TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates
METHOD System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::get_triggerFilters() | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "Dates_"
IL_000b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0010: pop
IL_0011: dup
IL_0012: ldstr "Gossip_Coyotes_Bukkake"
IL_0017: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_001c: pop
IL_001d: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::ScarlettPennyRascalStory_OnRequestedSceneActive() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "show_scarlett_penny_rascal_story_unlock"
IL_0005: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_000a: call UnityEngine.Events.UnityEvent TheForestOfLove.Services.SceneManagement.SceneHelper::get_onRequestedSceneActive()
IL_000f: ldnull
IL_0010: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates::ScarlettPennyRascalStory_OnRequestedSceneActive()
IL_0016: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001b: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_0020: call System.Boolean Globals::get_DisableTriggeredEffects()
IL_0025: brfalse.s IL_002f
IL_0027: ldc.i4.s 22
IL_0029: call System.Void TheForestOfLove.QuestTriggerHelper::UnlockMovie(TheForestOfLove.Narrative.Movie)
IL_002e: ret
IL_002f: ldstr "CentralForest"
IL_0034: ldstr "BunnyHouse"
IL_0039: ldloca.s V_0
IL_003b: initobj System.Nullable`1<TheForestOfLove.Direction>
IL_0041: ldloc.0
IL_0042: call System.Void TheForestOfLove.SpawnManager::ReplaceSpawnData(System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)
IL_0047: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_004c: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0051: ldc.r4 0.5
IL_0056: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<>9__7_0
IL_005b: dup
IL_005c: brtrue.s IL_0075
IL_005e: pop
IL_005f: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<>9
IL_0064: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<ScarlettPennyRascalStory_OnRequestedSceneActive>b__7_0()
IL_006a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_006f: dup
IL_0070: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerDates/<>c::<>9__7_0
IL_0075: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_007a: call System.Void TheForestOfLove.CutsceneManager::EndConstantBlack()
IL_007f: ret
