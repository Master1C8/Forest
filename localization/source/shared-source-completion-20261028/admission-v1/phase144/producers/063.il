TYPE TheForestOfLove.DonkeyRunCutscene
METHOD System.Void TheForestOfLove.DonkeyRunCutscene::PlayCutscene() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inPlainsField()
IL_0005: brfalse.s IL_003a
IL_0007: ldstr "Plains_End"
IL_000c: call TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordByUnitySceneName(System.String)
IL_0011: stloc.0
IL_0012: ldloc.0
IL_0013: brfalse.s IL_002a
IL_0015: ldstr "initiated oliver fast travel to area "
IL_001a: ldloc.0
IL_001b: ldfld System.String TheForestOfLove.Narrative.AreaRecord::dbName
IL_0020: call System.String System.String::Concat(System.String,System.String)
IL_0025: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_002a: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::SpawnDonkeyRunCutscene()
IL_002f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0034: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0039: ret
IL_003a: ldstr "Plains_Field"
IL_003f: call TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordByUnitySceneName(System.String)
IL_0044: stloc.1
IL_0045: ldloc.1
IL_0046: brfalse.s IL_005d
IL_0048: ldstr "initiated oliver fast travel to area "
IL_004d: ldloc.1
IL_004e: ldfld System.String TheForestOfLove.Narrative.AreaRecord::dbName
IL_0053: call System.String System.String::Concat(System.String,System.String)
IL_0058: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_005d: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0062: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0067: ldc.r4 1.5
IL_006c: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.DonkeyRunCutscene/<>c::<>9__11_0
IL_0071: dup
IL_0072: brtrue.s IL_008b
IL_0074: pop
IL_0075: ldsfld TheForestOfLove.DonkeyRunCutscene/<>c TheForestOfLove.DonkeyRunCutscene/<>c::<>9
IL_007a: ldftn System.Void TheForestOfLove.DonkeyRunCutscene/<>c::<PlayCutscene>b__11_0()
IL_0080: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0085: dup
IL_0086: stsfld UnityEngine.Events.UnityAction TheForestOfLove.DonkeyRunCutscene/<>c::<>9__11_0
IL_008b: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0090: ret
