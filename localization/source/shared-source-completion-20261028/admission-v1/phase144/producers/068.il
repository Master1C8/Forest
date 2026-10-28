TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<ExecuteTrigger>b__3_0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldstr "Dialogue Panel/Text Panel/Response Menu Panel/Viewport/Content"
IL_0005: stloc.0
IL_0006: call PixelCrushers.DialogueSystem.DialogueSystemController PixelCrushers.DialogueSystem.DialogueManager::get_instance()
IL_000b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0010: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren<PixelCrushers.DialogueSystem.StandardDialogueUI>()
IL_0015: stloc.1
IL_0016: ldloc.1
IL_0017: ldnull
IL_0018: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_001d: brfalse.s IL_0070
IL_001f: ldloc.1
IL_0020: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0025: ldloc.0
IL_0026: callvirt UnityEngine.Transform UnityEngine.Transform::Find(System.String)
IL_002b: callvirt !!0 UnityEngine.Component::GetComponentInChildren<UnityEngine.UI.Button>()
IL_0030: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0035: newobj System.Void UnityEngine.EventSystems.BaseEventData::.ctor(UnityEngine.EventSystems.EventSystem)
IL_003a: stloc.2
IL_003b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0040: ldloc.2
IL_0041: call UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<UnityEngine.EventSystems.ISubmitHandler> UnityEngine.EventSystems.ExecuteEvents::get_submitHandler()
IL_0046: call System.Boolean UnityEngine.EventSystems.ExecuteEvents::Execute<UnityEngine.EventSystems.ISubmitHandler>(UnityEngine.GameObject,UnityEngine.EventSystems.BaseEventData,UnityEngine.EventSystems.ExecuteEvents/EventFunction`1<!!0>)
IL_004b: pop
IL_004c: ldloc.1
IL_004d: ldnull
IL_004e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0053: brtrue.s IL_0058
IL_0055: ldnull
IL_0056: br.s IL_005e
IL_0058: ldloc.1
IL_0059: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.CustomTypewriterEffect>()
IL_005e: stloc.3
IL_005f: ldloc.3
IL_0060: ldnull
IL_0061: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0066: brfalse.s IL_0070
IL_0068: ldloc.3
IL_0069: ldc.i4.0
IL_006a: callvirt System.Collections.IEnumerator PixelCrushers.DialogueSystem.UnityUITypewriterEffect::Play(System.Int32)
IL_006f: pop
IL_0070: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<ExecuteTrigger>b__3_12() | attributes=Assembly, HideBySig | impl=IL
IL_0000: call System.Void TheForestOfLove.Content.CentralForestSpawner::Act1VictoryQuestMovePlayerToSharedSpawnLocation()
IL_0005: ldstr "CentralForest"
IL_000a: call System.Void TheForestOfLove.Audio.MusicManager::Play(System.String)
IL_000f: ldc.r4 1.5
IL_0014: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_13
IL_0019: dup
IL_001a: brtrue.s IL_0033
IL_001c: pop
IL_001d: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9
IL_0022: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<ExecuteTrigger>b__3_13()
IL_0028: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_002d: dup
IL_002e: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_13
IL_0033: call System.Void TheForestOfLove.CutsceneManager::FadeFromBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0038: call System.Void TheForestOfLove.CutsceneManager::EndConstantBlack()
IL_003d: ret
