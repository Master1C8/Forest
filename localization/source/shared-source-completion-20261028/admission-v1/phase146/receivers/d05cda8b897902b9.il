TYPE TheForestOfLove.Content.CentralForestSpawner/<>c__DisplayClass299_0
METHOD System.Void TheForestOfLove.Content.CentralForestSpawner/<>c__DisplayClass299_0::<SpawnDustin>b__1() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Content.CentralForestSpawner TheForestOfLove.Content.CentralForestSpawner/<>c__DisplayClass299_0::<>4__this
IL_0006: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_Dustin()
IL_000b: callvirt UnityEngine.Transform AreaContent::get_Content()
IL_0010: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Gameplay.SwapCameraSettingsDuringDialogue>()
IL_0015: stloc.0
IL_0016: ldloc.0
IL_0017: ldnull
IL_0018: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001d: brtrue.s IL_0022
IL_001f: ldnull
IL_0020: br.s IL_0028
IL_0022: ldloc.0
IL_0023: callvirt TheForestOfLove.Cameras.CameraSettings TheForestOfLove.Gameplay.SwapCameraSettingsDuringDialogue::get_targetCameraSettings()
IL_0028: ldarg.0
IL_0029: ldfld System.String TheForestOfLove.Content.CentralForestSpawner/<>c__DisplayClass299_0::targetConversationName
IL_002e: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0033: ldstr "Dustin"
IL_0038: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_003d: ldarg.0
IL_003e: ldfld System.String TheForestOfLove.Content.CentralForestSpawner/<>c__DisplayClass299_0::targetDialogueArc
IL_0043: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0048: stsfld TheForestOfLove.Cameras.CameraSettings TheForestOfLove.QuestConversationHelper::targetCameraSettings
IL_004d: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0052: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0057: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_005c: ret
