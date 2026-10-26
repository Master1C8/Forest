TYPE TheForestOfLove.IntroForestCutscene
METHOD System.Void TheForestOfLove.IntroForestCutscene::Start()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.IntroForestCutscene::StartCutscene()
IL_000c: ret
METHOD System.Void TheForestOfLove.IntroForestCutscene::OnWaypointArrived(TheForestOfLove.Waypoint)
IL_0000: ldarg.1
IL_0001: ldfld System.String TheForestOfLove.Waypoint::title
IL_0006: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_000b: brfalse.s IL_000e
IL_000d: ret
IL_000e: ldstr "NewGame_Intro"
IL_0013: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0018: ldstr "Scarlett"
IL_001d: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0022: ldstr "Narrator"
IL_0027: stsfld System.String TheForestOfLove.QuestConversationHelper::preferredConversantActorName
IL_002c: ldarg.1
IL_002d: ldfld System.String TheForestOfLove.Waypoint::title
IL_0032: stloc.0
IL_0033: ldloc.0
IL_0034: brfalse IL_00d3
IL_0039: ldloc.0
IL_003a: ldstr "double_take"
IL_003f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0044: brtrue.s IL_006e
IL_0046: ldloc.0
IL_0047: ldstr "familiar_rock"
IL_004c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0051: brtrue.s IL_007e
IL_0053: ldloc.0
IL_0054: ldstr "familiar_tree"
IL_0059: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_005e: brtrue.s IL_009a
IL_0060: ldloc.0
IL_0061: ldstr "slow1"
IL_0066: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_006b: brtrue.s IL_00aa
IL_006d: ret
IL_006e: ldstr "red_double_take"
IL_0073: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0078: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_007d: ret
IL_007e: ldstr "red_recognizes_rock"
IL_0083: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0088: ldc.i4.1
IL_0089: stsfld System.Boolean TheForestOfLove.QuestConversationHelper::usePreferredDirection
IL_008e: ldc.i4.1
IL_008f: stsfld TheForestOfLove.Direction TheForestOfLove.QuestConversationHelper::preferredPlayerDirection
IL_0094: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0099: ret
IL_009a: ldstr "red_recognizes_tree"
IL_009f: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_00a4: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_00a9: ret
IL_00aa: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_00af: dup
IL_00b0: ldfld UnityEngine.Vector2 TheForestOfLove.Player::speed
IL_00b5: ldc.r4 0.25
IL_00ba: call UnityEngine.Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,System.Single)
IL_00bf: stfld UnityEngine.Vector2 TheForestOfLove.Player::speed
IL_00c4: ldstr "red_feeling_woozy"
IL_00c9: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_00ce: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_00d3: ret
METHOD System.Void TheForestOfLove.IntroForestCutscene::OnWaypointWaitTimeElapsed(TheForestOfLove.Waypoint)
IL_0000: ldarg.1
IL_0001: ldfld System.String TheForestOfLove.Waypoint::title
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0038
IL_000a: ldloc.0
IL_000b: ldstr "sleep"
IL_0010: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0015: brfalse.s IL_0038
IL_0017: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_001c: callvirt System.Void TheForestOfLove.Player::SleepIntroForest()
IL_0021: ldarg.0
IL_0022: ldfld System.Single TheForestOfLove.IntroForestCutscene::fadeoutSeconds
IL_0027: ldarg.0
IL_0028: ldftn System.Void TheForestOfLove.IntroForestCutscene::EndCutscene()
IL_002e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0033: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0038: ret
METHOD System.Void TheForestOfLove.IntroForestCutscene::StartCutscene()
IL_0000: call System.Void TheForestOfLove.CutsceneManager::InstantCinematicMode()
IL_0005: ldarg.0
IL_0006: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_000b: ldfld System.Single TheForestOfLove.Player::idleThresholdMs
IL_0010: stfld System.Single TheForestOfLove.IntroForestCutscene::oldPlayerIdleThresholdMs
IL_0015: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_001a: ldarg.0
IL_001b: ldfld System.Single TheForestOfLove.IntroForestCutscene::newPlayerIdleThresholdMs
IL_0020: stfld System.Single TheForestOfLove.Player::idleThresholdMs
IL_0025: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_002a: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_002f: ldc.r4 2.5
IL_0034: ldarg.0
IL_0035: ldftn System.Void TheForestOfLove.IntroForestCutscene::<StartCutscene>b__14_0()
IL_003b: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0040: call System.Void TheForestOfLove.CutsceneManager::FadeFromBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0045: ret
METHOD System.Void TheForestOfLove.IntroForestCutscene::EndCutscene()
IL_0000: call System.Void TheForestOfLove.CutsceneManager::ConstantBlack()
IL_0005: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnFinishIntroForestCutscene()
IL_000a: ldc.r4 0.5
IL_000f: ldsfld System.Action TheForestOfLove.IntroForestCutscene/<>c::<>9__15_0
IL_0014: dup
IL_0015: brtrue.s IL_002e
IL_0017: pop
IL_0018: ldsfld TheForestOfLove.IntroForestCutscene/<>c TheForestOfLove.IntroForestCutscene/<>c::<>9
IL_001d: ldftn System.Void TheForestOfLove.IntroForestCutscene/<>c::<EndCutscene>b__15_0()
IL_0023: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0028: dup
IL_0029: stsfld System.Action TheForestOfLove.IntroForestCutscene/<>c::<>9__15_0
IL_002e: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0033: ret
METHOD System.Void TheForestOfLove.IntroForestCutscene::<StartCutscene>b__14_0()
IL_0000: ldc.r4 2
IL_0005: ldarg.0
IL_0006: ldftn System.Void TheForestOfLove.IntroForestCutscene::<StartCutscene>b__14_1()
IL_000c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0011: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0016: ret
METHOD System.Void TheForestOfLove.IntroForestCutscene::<StartCutscene>b__14_1()
IL_0000: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0005: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_000a: ldarg.0
IL_000b: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0010: callvirt System.Void TheForestOfLove.WaypointController::SetWaypoints(UnityEngine.Transform)
IL_0015: ldc.r4 1
IL_001a: ldarg.0
IL_001b: ldftn System.Void TheForestOfLove.IntroForestCutscene::<StartCutscene>b__14_2()
IL_0021: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0026: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_002b: ret
METHOD System.Void TheForestOfLove.IntroForestCutscene::<StartCutscene>b__14_2()
IL_0000: ldarg.0
IL_0001: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.Cameras.CameraSettings TheForestOfLove.IntroForestCutscene::initialCameraSettings
IL_000c: ldc.i4.1
IL_000d: callvirt System.Int32 TheForestOfLove.Cameras.CameraController::PushSettingsAndLock(TheForestOfLove.Cameras.CameraSettings,System.Boolean)
IL_0012: stfld System.Int32 TheForestOfLove.IntroForestCutscene::cameraSettingsId
IL_0017: ret
