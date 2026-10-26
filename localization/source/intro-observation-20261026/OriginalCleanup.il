TYPE TheForestOfLove.IntroBunnyHouseCutscene
METHOD System.Void TheForestOfLove.IntroBunnyHouseCutscene::Update()
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.IntroBunnyHouseCutscene::timerSet
IL_0006: brfalse.s IL_0041
IL_0008: ldarg.0
IL_0009: ldfld System.Single TheForestOfLove.IntroBunnyHouseCutscene::timerSecondsRemaining
IL_000e: ldc.r4 0
IL_0013: ble.un.s IL_0041
IL_0015: ldarg.0
IL_0016: ldarg.0
IL_0017: ldfld System.Single TheForestOfLove.IntroBunnyHouseCutscene::timerSecondsRemaining
IL_001c: call System.Single UnityEngine.Time::get_deltaTime()
IL_0021: sub
IL_0022: stfld System.Single TheForestOfLove.IntroBunnyHouseCutscene::timerSecondsRemaining
IL_0027: ldarg.0
IL_0028: ldfld System.Single TheForestOfLove.IntroBunnyHouseCutscene::timerSecondsRemaining
IL_002d: ldc.r4 0
IL_0032: bgt.un.s IL_0041
IL_0034: ldarg.0
IL_0035: ldc.i4.0
IL_0036: stfld System.Boolean TheForestOfLove.IntroBunnyHouseCutscene::timerSet
IL_003b: ldarg.0
IL_003c: call System.Void TheForestOfLove.IntroBunnyHouseCutscene::EndCutsceneStage()
IL_0041: ret
METHOD System.Void TheForestOfLove.IntroBunnyHouseCutscene::EndCutsceneStage()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: switch IL_002b,IL_0034,IL_003d,IL_0046,IL_004f,IL_0058,IL_005f
IL_0029: br.s IL_005f
IL_002b: ldarg.0
IL_002c: ldc.i4.1
IL_002d: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_0032: br.s IL_005f
IL_0034: ldarg.0
IL_0035: ldc.i4.2
IL_0036: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_003b: br.s IL_005f
IL_003d: ldarg.0
IL_003e: ldc.i4.3
IL_003f: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_0044: br.s IL_005f
IL_0046: ldarg.0
IL_0047: ldc.i4.4
IL_0048: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_004d: br.s IL_005f
IL_004f: ldarg.0
IL_0050: ldc.i4.5
IL_0051: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_0056: br.s IL_005f
IL_0058: ldarg.0
IL_0059: ldc.i4.6
IL_005a: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_005f: ldarg.0
IL_0060: call System.Void TheForestOfLove.IntroBunnyHouseCutscene::ConfigureCutsceneStage()
IL_0065: ret
METHOD System.Void TheForestOfLove.IntroBunnyHouseCutscene::ConfigureCutsceneStage()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: switch IL_002a,IL_00b5,IL_00d6,IL_0116,IL_0140,IL_0157,IL_0170
IL_0029: ret
IL_002a: ldarg.0
IL_002b: ldfld UnityEngine.Transform TheForestOfLove.IntroBunnyHouseCutscene::bunny
IL_0030: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0035: ldarg.0
IL_0036: ldfld UnityEngine.Transform TheForestOfLove.IntroBunnyHouseCutscene::bunnyLocationFar
IL_003b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0040: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0045: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_004a: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_004f: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0054: ldarg.0
IL_0055: ldfld UnityEngine.Transform TheForestOfLove.IntroBunnyHouseCutscene::redInBed
IL_005a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_005f: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0064: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0069: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_006e: callvirt TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0073: ldc.i4.3
IL_0074: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(TheForestOfLove.Direction)
IL_0079: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_007e: callvirt System.Void TheForestOfLove.Player::Sleep()
IL_0083: call System.Void TheForestOfLove.CutsceneManager::ConstantBlack()
IL_0088: ldc.r4 1
IL_008d: ldarg.0
IL_008e: ldftn System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_0()
IL_0094: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0099: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_009e: ldc.r4 1
IL_00a3: ldarg.0
IL_00a4: ldftn System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_1()
IL_00aa: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00af: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00b4: ret
IL_00b5: ldc.i4 1300
IL_00ba: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_00bf: ldc.r4 4
IL_00c4: ldarg.0
IL_00c5: ldftn System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_2()
IL_00cb: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00d0: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00d5: ret
IL_00d6: call System.Void TheForestOfLove.CutsceneManager::EndConstantBlack()
IL_00db: ldc.r4 1.25
IL_00e0: ldarg.0
IL_00e1: ldftn System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_3()
IL_00e7: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00ec: call System.Void TheForestOfLove.CutsceneManager::FadeFromBlack(System.Single,UnityEngine.Events.UnityAction)
IL_00f1: ldarg.0
IL_00f2: ldfld UnityEngine.Transform TheForestOfLove.IntroBunnyHouseCutscene::bunny
IL_00f7: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00fc: ldc.r4 2.35
IL_0101: ldc.r4 0.53
IL_0106: ldc.r4 0
IL_010b: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0110: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0115: ret
IL_0116: ldc.r4 0.5
IL_011b: ldsfld System.Action TheForestOfLove.IntroBunnyHouseCutscene/<>c::<>9__23_4
IL_0120: dup
IL_0121: brtrue.s IL_013a
IL_0123: pop
IL_0124: ldsfld TheForestOfLove.IntroBunnyHouseCutscene/<>c TheForestOfLove.IntroBunnyHouseCutscene/<>c::<>9
IL_0129: ldftn System.Void TheForestOfLove.IntroBunnyHouseCutscene/<>c::<ConfigureCutsceneStage>b__23_4()
IL_012f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0134: dup
IL_0135: stsfld System.Action TheForestOfLove.IntroBunnyHouseCutscene/<>c::<>9__23_4
IL_013a: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_013f: ret
IL_0140: ldc.r4 1
IL_0145: ldarg.0
IL_0146: ldftn System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_5()
IL_014c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0151: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0156: ret
IL_0157: ldarg.0
IL_0158: call System.Void TheForestOfLove.IntroBunnyHouseCutscene::EndCutscene()
IL_015d: ldarg.0
IL_015e: ldc.i4.1
IL_015f: stfld System.Boolean TheForestOfLove.IntroBunnyHouseCutscene::timerSet
IL_0164: ldarg.0
IL_0165: ldc.r4 3
IL_016a: stfld System.Single TheForestOfLove.IntroBunnyHouseCutscene::timerSecondsRemaining
IL_016f: ret
IL_0170: ldarg.0
IL_0171: call System.Void TheForestOfLove.IntroBunnyHouseCutscene::FinishCleanup()
IL_0176: ret
METHOD System.Void TheForestOfLove.IntroBunnyHouseCutscene::EndCutscene()
IL_0000: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_0005: ldarg.0
IL_0006: ldftn System.Void TheForestOfLove.IntroBunnyHouseCutscene::EndCutsceneStage()
IL_000c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0011: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_0016: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnFinishIntroBunnyHouseCutscene()
IL_001b: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0020: ldarg.0
IL_0021: ldfld System.Single TheForestOfLove.IntroBunnyHouseCutscene::oldPlayerIdleThresholdMs
IL_0026: stfld System.Single TheForestOfLove.Player::idleThresholdMs
IL_002b: call System.Void TheForestOfLove.CutsceneManager::EndCinematicMode()
IL_0030: ret
METHOD System.Void TheForestOfLove.IntroBunnyHouseCutscene::FinishCleanup()
IL_0000: ldsfld TheForestOfLove.Content.BunnyHouseSpawner TheForestOfLove.Content.BunnyHouseSpawner::instance
IL_0005: callvirt AreaContent TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsBed()
IL_000a: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::EnableInteractionInChildren(AreaContent)
IL_000f: ldarg.0
IL_0010: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0015: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_001a: ret
METHOD System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_1()
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean TheForestOfLove.IntroBunnyHouseCutscene::timerSet
IL_0007: ldarg.0
IL_0008: ldc.r4 0.5
IL_000d: stfld System.Single TheForestOfLove.IntroBunnyHouseCutscene::timerSecondsRemaining
IL_0012: ret
METHOD System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_5()
IL_0000: call System.Void TheForestOfLove.CutsceneManager::ConstantBlack()
IL_0005: ldc.i4 1500
IL_000a: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_000f: ldc.r4 4
IL_0014: ldarg.0
IL_0015: ldftn System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_8()
IL_001b: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0020: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0025: ret
METHOD System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_8()
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Transform TheForestOfLove.IntroBunnyHouseCutscene::bunny
IL_0006: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_000b: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.Animator TheForestOfLove.IntroBunnyHouseCutscene::bunnyMomHopSceneAnimator
IL_0016: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001b: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0020: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0025: ldc.i4.1
IL_0026: callvirt System.Void TheForestOfLove.Player::Idle(System.Boolean)
IL_002b: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0030: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0035: ldarg.0
IL_0036: ldfld UnityEngine.Transform TheForestOfLove.IntroBunnyHouseCutscene::bunnyLocationClose
IL_003b: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0040: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0045: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_004a: ldc.r4 1.5
IL_004f: ldarg.0
IL_0050: ldftn System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_9()
IL_0056: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_005b: call System.Void TheForestOfLove.CutsceneManager::FadeFromBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0060: call System.Void TheForestOfLove.CutsceneManager::EndConstantBlack()
IL_0065: ldc.r4 1
IL_006a: ldsfld System.Action TheForestOfLove.IntroBunnyHouseCutscene/<>c::<>9__23_10
IL_006f: dup
IL_0070: brtrue.s IL_0089
IL_0072: pop
IL_0073: ldsfld TheForestOfLove.IntroBunnyHouseCutscene/<>c TheForestOfLove.IntroBunnyHouseCutscene/<>c::<>9
IL_0078: ldftn System.Void TheForestOfLove.IntroBunnyHouseCutscene/<>c::<ConfigureCutsceneStage>b__23_10()
IL_007e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0083: dup
IL_0084: stsfld System.Action TheForestOfLove.IntroBunnyHouseCutscene/<>c::<>9__23_10
IL_0089: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_008e: ret
METHOD System.Void TheForestOfLove.IntroBunnyHouseCutscene::<ConfigureCutsceneStage>b__23_9()
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.IntroBunnyHouseCutscene::EndCutsceneStage()
IL_0006: ret
