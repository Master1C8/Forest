TYPE TheForestOfLove.CCTeleport
METHOD System.Void TheForestOfLove.CCTeleport::Teleport(System.String,UnityEngine.Transform,TheForestOfLove.TransformOffset) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.String System.String::ToLower()
IL_0006: ldstr "player"
IL_000b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0010: brfalse.s IL_002a
IL_0012: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0017: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_001c: stloc.0
IL_001d: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0022: callvirt TheForestOfLove.TransformOffset TheForestOfLove.Gameplay.SpawnableActor::get_TransformOffset()
IL_0027: stloc.1
IL_0028: br.s IL_003d
IL_002a: ldarg.0
IL_002b: call TheForestOfLove.Gameplay.CritterActor TheForestOfLove.Gameplay.CritterActor::FindActorByName(System.String)
IL_0030: dup
IL_0031: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0036: stloc.0
IL_0037: callvirt TheForestOfLove.TransformOffset TheForestOfLove.Gameplay.SpawnableActor::get_TransformOffset()
IL_003c: stloc.1
IL_003d: ldloc.0
IL_003e: ldloc.1
IL_003f: ldarg.1
IL_0040: ldarg.2
IL_0041: call System.Void TheForestOfLove.CCTeleport::Teleport(UnityEngine.Transform,TheForestOfLove.TransformOffset,UnityEngine.Transform,TheForestOfLove.TransformOffset)
IL_0046: ret
METHOD System.Void TheForestOfLove.CCTeleport::Teleport(UnityEngine.GameObject,UnityEngine.Transform,TheForestOfLove.TransformOffset) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0006: ldarg.0
IL_0007: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.TransformOffset>()
IL_000c: stloc.0
IL_000d: ldloc.0
IL_000e: ldarg.1
IL_000f: ldarg.2
IL_0010: call System.Void TheForestOfLove.CCTeleport::Teleport(UnityEngine.Transform,TheForestOfLove.TransformOffset,UnityEngine.Transform,TheForestOfLove.TransformOffset)
IL_0015: ret
METHOD System.Void TheForestOfLove.CCTeleport::Teleport(UnityEngine.Transform,TheForestOfLove.TransformOffset,UnityEngine.Transform,TheForestOfLove.TransformOffset) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.2
IL_0002: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0007: ldarg.1
IL_0008: ldnull
IL_0009: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000e: brtrue.s IL_0017
IL_0010: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_0015: br.s IL_001d
IL_0017: ldarg.1
IL_0018: ldfld UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_001d: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0022: ldarg.3
IL_0023: ldnull
IL_0024: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0029: brtrue.s IL_0032
IL_002b: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_0030: br.s IL_0038
IL_0032: ldarg.3
IL_0033: ldfld UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_0038: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_003d: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0042: ret
