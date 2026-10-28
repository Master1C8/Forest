TYPE TheForestOfLove.Content.BaseSpawner
METHOD System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnAdventuresForGatewayName(System.String) | attributes=Family, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAdventuresMechanicDisabled()
IL_0005: brfalse.s IL_0009
IL_0007: ldc.i4.0
IL_0008: ret
IL_0009: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_000e: brfalse.s IL_0012
IL_0010: ldc.i4.0
IL_0011: ret
IL_0012: ldarg.1
IL_0013: ldstr "home"
IL_0018: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_001d: brfalse.s IL_0028
IL_001f: call System.Boolean TheForestOfLove.QuestTriggerHelper::HasAnyUnlockedCompletedOnceAdventures()
IL_0024: brfalse.s IL_0028
IL_0026: ldc.i4.1
IL_0027: ret
IL_0028: ldarg.1
IL_0029: call System.Boolean TheForestOfLove.QuestTriggerHelper::HasAnyUnlockedUnfinishedAdventuresByGatewayName(System.String)
IL_002e: brtrue.s IL_0032
IL_0030: ldc.i4.0
IL_0031: ret
IL_0032: ldc.i4.1
IL_0033: ret
METHOD AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,AreaContentSet) | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: ret
METHOD AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform) | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: newobj System.Void UnityEngine.GameObject::.ctor(System.String)
IL_0006: dup
IL_0007: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_000c: ldarg.2
IL_000d: ldnull
IL_000e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0013: brtrue.s IL_0018
IL_0015: ldarg.2
IL_0016: br.s IL_001e
IL_0018: ldarg.0
IL_0019: call UnityEngine.Transform TheForestOfLove.Content.BaseSpawner::get_RootContainer()
IL_001e: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0023: callvirt !!0 UnityEngine.GameObject::AddComponent<AreaContentSet>()
IL_0028: ret
