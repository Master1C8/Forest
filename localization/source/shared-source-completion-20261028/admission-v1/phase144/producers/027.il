TYPE TheForestOfLove.Content.ActorSpawnerService
METHOD System.Void TheForestOfLove.Content.ActorSpawnerService::SpawnDefaultActor(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Gameplay.SpawnableActor> TheForestOfLove.Content.ActorSpawnerService::defaultActorPrefabsByName
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Gameplay.SpawnableActor>::ContainsKey(!0)
IL_000c: brtrue.s IL_001f
IL_000e: ldstr "default actor unrecognized, failed to spawn "
IL_0013: ldarg.1
IL_0014: call System.String System.String::Concat(System.String,System.String)
IL_0019: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_001e: ret
IL_001f: ldarg.0
IL_0020: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Gameplay.SpawnableActor> TheForestOfLove.Content.ActorSpawnerService::defaultActorPrefabsByName
IL_0025: ldarg.1
IL_0026: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Gameplay.SpawnableActor>::get_Item(!0)
IL_002b: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.Gameplay.SpawnableActor>(!!0)
IL_0030: stloc.0
IL_0031: ldarg.0
IL_0032: ldloc.0
IL_0033: call System.Void TheForestOfLove.Content.ActorSpawnerService::RegisterActor(TheForestOfLove.Gameplay.SpawnableActor)
IL_0038: ret
