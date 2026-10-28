TYPE TheForestOfLove.DebugHelper
METHOD System.Void TheForestOfLove.DebugHelper::DebugTeleport() | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_000e
IL_000d: ret
IL_000e: ldnull
IL_000f: stloc.0
IL_0010: ldc.i4.s 49
IL_0012: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_0017: brfalse.s IL_001f
IL_0019: ldstr "bunny"
IL_001e: stloc.0
IL_001f: ldc.i4.s 50
IL_0021: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_0026: brfalse.s IL_002e
IL_0028: ldstr "beaver"
IL_002d: stloc.0
IL_002e: ldc.i4.s 51
IL_0030: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_0035: brfalse.s IL_003d
IL_0037: ldstr "mouse"
IL_003c: stloc.0
IL_003d: ldc.i4.s 52
IL_003f: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_0044: brfalse.s IL_004c
IL_0046: ldstr "otter"
IL_004b: stloc.0
IL_004c: ldc.i4.s 53
IL_004e: call System.Boolean UnityEngine.Input::GetKeyDown(UnityEngine.KeyCode)
IL_0053: brfalse.s IL_005b
IL_0055: ldstr "bear"
IL_005a: stloc.0
IL_005b: call !!0[] UnityEngine.Object::FindObjectsOfType<TheForestOfLove.Gameplay.SpawnableActor>()
IL_0060: stloc.1
IL_0061: ldc.i4.0
IL_0062: stloc.2
IL_0063: br.s IL_009c
IL_0065: ldloc.1
IL_0066: ldloc.2
IL_0067: ldelem.ref
IL_0068: stloc.3
IL_0069: ldloc.3
IL_006a: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_006f: ldloc.0
IL_0070: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0075: brfalse.s IL_0098
IL_0077: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_007c: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0081: ldloc.3
IL_0082: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_0087: ldarg.0
IL_0088: ldfld UnityEngine.Vector3 TheForestOfLove.DebugHelper::teleportOffset
IL_008d: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0092: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0097: ret
IL_0098: ldloc.2
IL_0099: ldc.i4.1
IL_009a: add
IL_009b: stloc.2
IL_009c: ldloc.2
IL_009d: ldloc.1
IL_009e: ldlen
IL_009f: conv.i4
IL_00a0: blt.s IL_0065
IL_00a2: ret
