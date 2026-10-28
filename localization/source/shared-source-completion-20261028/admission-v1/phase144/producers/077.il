TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles
METHOD System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles::get_triggerFilters() | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "Idles_"
IL_000b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0010: pop
IL_0011: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles::ExecuteTrigger(System.String) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "idle_dash"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse IL_011a
IL_0010: newobj System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::.ctor()
IL_0015: stloc.0
IL_0016: ldarg.0
IL_0017: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_001c: brtrue.s IL_002e
IL_001e: ldarg.0
IL_001f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0024: brtrue.s IL_002e
IL_0026: ldarg.0
IL_0027: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_002c: brfalse.s IL_002f
IL_002e: ret
IL_002f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0034: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0039: ldloc.0
IL_003a: ldstr "Dustin"
IL_003f: call TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Gameplay.SpawnableActor::FindActorByName(System.String)
IL_0044: stfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::squirrel
IL_0049: ldloc.0
IL_004a: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::squirrel
IL_004f: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0054: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0059: ldc.r4 2.1
IL_005e: ldc.r4 0.3
IL_0063: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_0068: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_006d: stloc.1
IL_006e: ldloc.0
IL_006f: ldloc.0
IL_0070: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::squirrel
IL_0075: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_007a: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_007f: ldc.r4 2.7
IL_0084: ldc.r4 0.3
IL_0089: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_008e: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0093: stfld UnityEngine.Vector3 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::dashAnimatorPositionEnd
IL_0098: ldloc.0
IL_0099: ldloc.0
IL_009a: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::squirrel
IL_009f: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Interaction.DustinIdleDashAnimator>()
IL_00a4: stfld TheForestOfLove.Interaction.DustinIdleDashAnimator TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::dashAnimatorGameObject
IL_00a9: ldloc.0
IL_00aa: ldfld TheForestOfLove.Interaction.DustinIdleDashAnimator TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::dashAnimatorGameObject
IL_00af: ldnull
IL_00b0: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00b5: brfalse.s IL_00cc
IL_00b7: ldstr "trying to play a dustin dash effect but the fx prefab is unavailable, please investigate!"
IL_00bc: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00c1: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_00c6: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00cb: ret
IL_00cc: ldloc.0
IL_00cd: ldfld TheForestOfLove.Interaction.DustinIdleDashAnimator TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::dashAnimatorGameObject
IL_00d2: ldfld UnityEngine.GameObject TheForestOfLove.Interaction.DustinIdleDashAnimator::container
IL_00d7: ldc.i4.1
IL_00d8: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00dd: ldloc.0
IL_00de: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::squirrel
IL_00e3: callvirt System.Void TheForestOfLove.Gameplay.SpawnableActor::HideSprites()
IL_00e8: ldloc.0
IL_00e9: ldfld TheForestOfLove.Interaction.DustinIdleDashAnimator TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::dashAnimatorGameObject
IL_00ee: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00f3: ldloc.1
IL_00f4: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_00f9: ldloc.0
IL_00fa: ldfld TheForestOfLove.Interaction.DustinIdleDashAnimator TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::dashAnimatorGameObject
IL_00ff: callvirt System.Void TheForestOfLove.Interaction.DustinIdleDashAnimator::Dash()
IL_0104: ldc.r4 2
IL_0109: ldloc.0
IL_010a: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_0::<ExecuteTrigger>b__0()
IL_0110: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0115: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_011a: ldarg.1
IL_011b: ldstr "painting2"
IL_0120: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0125: brfalse IL_01c1
IL_012a: newobj System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_1::.ctor()
IL_012f: stloc.2
IL_0130: ldarg.0
IL_0131: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0136: brtrue.s IL_0140
IL_0138: ldarg.0
IL_0139: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_013e: brfalse.s IL_0141
IL_0140: ret
IL_0141: ldloc.2
IL_0142: ldstr "Finley"
IL_0147: call TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Gameplay.SpawnableActor::FindActorByName(System.String)
IL_014c: stfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_1::finley
IL_0151: ldsfld TheForestOfLove.Content.MountainsSpawner TheForestOfLove.Content.MountainsSpawner::instance
IL_0156: ldnull
IL_0157: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_015c: brtrue.s IL_017e
IL_015e: ldloc.2
IL_015f: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_1::finley
IL_0164: ldnull
IL_0165: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_016a: brtrue.s IL_017e
IL_016c: ldsfld TheForestOfLove.Content.MountainsSpawner TheForestOfLove.Content.MountainsSpawner::instance
IL_0171: callvirt AreaContent TheForestOfLove.Content.MountainsSpawner::get_EaselCameraTarget()
IL_0176: ldnull
IL_0177: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_017c: brfalse.s IL_017f
IL_017e: ret
IL_017f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0184: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0189: ldsfld TheForestOfLove.Content.MountainsSpawner TheForestOfLove.Content.MountainsSpawner::instance
IL_018e: callvirt AreaContent TheForestOfLove.Content.MountainsSpawner::get_EaselCameraTarget()
IL_0193: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Cameras.CameraSettings>()
IL_0198: stloc.3
IL_0199: ldloc.2
IL_019a: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_019f: ldloc.3
IL_01a0: ldc.i4.0
IL_01a1: callvirt System.Int32 TheForestOfLove.Cameras.CameraController::PushSettings(TheForestOfLove.Cameras.CameraSettings,System.Boolean)
IL_01a6: stfld System.Int32 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_1::id
IL_01ab: ldc.r4 4
IL_01b0: ldloc.2
IL_01b1: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFinalIdles/<>c__DisplayClass2_1::<ExecuteTrigger>b__2()
IL_01b7: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01bc: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_01c1: ldarg.1
IL_01c2: ldstr "check_melody_idle_before_photoshoot"
IL_01c7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01cc: brfalse.s IL_01ff
IL_01ce: ldarg.0
IL_01cf: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_01d4: brtrue.s IL_01de
IL_01d6: ldarg.0
IL_01d7: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_01dc: brfalse.s IL_01df
IL_01de: ret
IL_01df: ldstr "MelodyQuest_ReadyForPhotoshoot"
IL_01e4: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01e9: ldc.i4.0
IL_01ea: ceq
IL_01ec: stloc.s V_4
IL_01ee: ldstr "bool_condition"
IL_01f3: ldloc.s V_4
IL_01f5: box System.Boolean
IL_01fa: call System.Void PixelCrushers.DialogueSystem.DialogueLua::SetVariable(System.String,System.Object)
IL_01ff: ldarg.1
IL_0200: ldstr "check_melody_idle_after_photoshoot"
IL_0205: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_020a: brfalse.s IL_023a
IL_020c: ldarg.0
IL_020d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0212: brtrue.s IL_021c
IL_0214: ldarg.0
IL_0215: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_021a: brfalse.s IL_021d
IL_021c: ret
IL_021d: ldstr "MelodyQuest_ReadyForPhotoshoot"
IL_0222: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0227: stloc.s V_5
IL_0229: ldstr "bool_condition"
IL_022e: ldloc.s V_5
IL_0230: box System.Boolean
IL_0235: call System.Void PixelCrushers.DialogueSystem.DialogueLua::SetVariable(System.String,System.Object)
IL_023a: ldarg.1
IL_023b: ldstr "check_finley_idle_painting2_available"
IL_0240: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0245: brfalse.s IL_026c
IL_0247: ldarg.0
IL_0248: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_024d: brtrue.s IL_0257
IL_024f: ldarg.0
IL_0250: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0255: brfalse.s IL_0258
IL_0257: ret
IL_0258: ldstr "bool_condition"
IL_025d: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inMountains()
IL_0262: box System.Boolean
IL_0267: call System.Void PixelCrushers.DialogueSystem.DialogueLua::SetVariable(System.String,System.Object)
IL_026c: ldarg.1
IL_026d: ldstr "act3_idles_check_mabel_nearby"
IL_0272: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0277: brfalse.s IL_0299
IL_0279: ldarg.0
IL_027a: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_027f: brtrue.s IL_0289
IL_0281: ldarg.0
IL_0282: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0287: brfalse.s IL_028a
IL_0289: ret
IL_028a: ldstr "Mabel"
IL_028f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorOnScreen(System.String)
IL_0294: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_0299: ret
