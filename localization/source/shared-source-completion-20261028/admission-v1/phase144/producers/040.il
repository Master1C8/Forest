TYPE TheForestOfLove.Content.KeyedSpawnerService
METHOD System.Void TheForestOfLove.Content.KeyedSpawnerService::SpawnInstance(System.String,UnityEngine.GameObject) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,AreaContent> TheForestOfLove.Content.KeyedSpawnerService::areaContentByPrefabKey
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,AreaContent>::ContainsKey(!0)
IL_000c: brfalse.s IL_001f
IL_000e: ldstr "prefab already spawned, replacing "
IL_0013: ldarg.1
IL_0014: call System.String System.String::Concat(System.String,System.String)
IL_0019: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_001e: ret
IL_001f: ldarg.0
IL_0020: ldarg.2
IL_0021: ldnull
IL_0022: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0027: stloc.0
IL_0028: ldarg.0
IL_0029: ldfld System.Collections.Generic.Dictionary`2<System.String,AreaContent> TheForestOfLove.Content.KeyedSpawnerService::areaContentByPrefabKey
IL_002e: ldarg.1
IL_002f: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,AreaContent>::ContainsKey(!0)
IL_0034: brtrue.s IL_0044
IL_0036: ldarg.0
IL_0037: ldfld System.Collections.Generic.Dictionary`2<System.String,AreaContent> TheForestOfLove.Content.KeyedSpawnerService::areaContentByPrefabKey
IL_003c: ldarg.1
IL_003d: ldloc.0
IL_003e: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,AreaContent>::Add(!0,!1)
IL_0043: ret
IL_0044: ldarg.0
IL_0045: ldfld System.Collections.Generic.Dictionary`2<System.String,AreaContent> TheForestOfLove.Content.KeyedSpawnerService::areaContentByPrefabKey
IL_004a: ldarg.1
IL_004b: ldloc.0
IL_004c: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,AreaContent>::set_Item(!0,!1)
IL_0051: ret
