TYPE TheForestOfLove.Act3WolfQuestReturnToWolfCutscene/<>c
METHOD System.Void TheForestOfLove.Act3WolfQuestReturnToWolfCutscene/<>c::<StartCutscenePart1>b__26_3() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldstr "Scarlett"
IL_0005: call TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Gameplay.SpawnableActor::FindActorByName(System.String)
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0011: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0016: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_001b: ldc.r4 0.4
IL_0020: ldc.r4 0
IL_0025: ldc.r4 0
IL_002a: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_002f: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0034: ldloc.0
IL_0035: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBaseOffset()
IL_003a: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_003f: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0044: call T TheForestOfLove.Services.ServiceLocator::Get<ScarlettHopController>()
IL_0049: ldc.i4.1
IL_004a: newobj System.Void System.Nullable`1<TheForestOfLove.Direction>::.ctor(!0)
IL_004f: callvirt System.Void ScarlettHopController::set_overrideRestDirection(System.Nullable`1<TheForestOfLove.Direction>)
IL_0054: ret
