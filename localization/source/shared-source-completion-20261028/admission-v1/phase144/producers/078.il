TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::<ExecuteTrigger>b__0() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::squirrel
IL_0006: callvirt System.Void TheForestOfLove.Gameplay.SpawnableActor::ShowSprites()
IL_000b: ldarg.0
IL_000c: ldfld TheForestOfLove.Interaction.DustinIdleDashAnimator TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::dashAnimatorGameObject
IL_0011: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Vector3 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::dashAnimatorPositionEnd
IL_001c: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0021: ldarg.0
IL_0022: ldfld TheForestOfLove.Interaction.DustinIdleDashAnimator TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::dashAnimatorGameObject
IL_0027: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_002c: ldc.r4 -1
IL_0031: ldc.r4 1
IL_0036: ldc.r4 1
IL_003b: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0040: callvirt System.Void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)
IL_0045: ldarg.0
IL_0046: ldfld TheForestOfLove.Interaction.DustinIdleDashAnimator TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::dashAnimatorGameObject
IL_004b: callvirt System.Void TheForestOfLove.Interaction.DustinIdleDashAnimator::Dash()
IL_0050: ldarg.0
IL_0051: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::squirrel
IL_0056: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Cameras.CameraSettings>()
IL_005b: stsfld TheForestOfLove.Cameras.CameraSettings TheForestOfLove.QuestConversationHelper::targetCameraSettings
IL_0060: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_0065: brtrue.s IL_006e
IL_0067: ldstr "Idles_Act1_Squirrel"
IL_006c: br.s IL_0073
IL_006e: ldstr "Idles_Act2_Dustin"
IL_0073: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0078: ldstr "Dustin"
IL_007d: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0082: ldstr "finish_dash"
IL_0087: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_008c: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0091: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0096: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_009b: ldc.r4 2
IL_00a0: ldarg.0
IL_00a1: ldfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::<>9__1
IL_00a6: dup
IL_00a7: brtrue.s IL_00bf
IL_00a9: pop
IL_00aa: ldarg.0
IL_00ab: ldarg.0
IL_00ac: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::<ExecuteTrigger>b__1()
IL_00b2: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00b7: dup
IL_00b8: stloc.0
IL_00b9: stfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::<>9__1
IL_00be: ldloc.0
IL_00bf: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00c4: ret
