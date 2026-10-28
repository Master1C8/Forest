TYPE TheForestOfLove.Gameplay.CritterActor
METHOD TheForestOfLove.Gameplay.CritterActor TheForestOfLove.Gameplay.CritterActor::FindActorByName(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call !!0[] UnityEngine.Object::FindObjectsOfType<TheForestOfLove.Gameplay.CritterActor>()
IL_0005: stloc.0
IL_0006: ldc.i4.0
IL_0007: stloc.1
IL_0008: br.s IL_0022
IL_000a: ldloc.0
IL_000b: ldloc.1
IL_000c: ldelem.ref
IL_000d: stloc.2
IL_000e: ldloc.2
IL_000f: callvirt System.String TheForestOfLove.Gameplay.SpawnableActor::get_ActorDbName()
IL_0014: ldarg.0
IL_0015: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_001a: brfalse.s IL_001e
IL_001c: ldloc.2
IL_001d: ret
IL_001e: ldloc.1
IL_001f: ldc.i4.1
IL_0020: add
IL_0021: stloc.1
IL_0022: ldloc.1
IL_0023: ldloc.0
IL_0024: ldlen
IL_0025: conv.i4
IL_0026: blt.s IL_000a
IL_0028: ldnull
IL_0029: ret
