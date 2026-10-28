TYPE TheForestOfLove.Content.BaseSpawner
METHOD AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet) | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0008: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,UnityEngine.Transform)
IL_000d: ret
METHOD AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,UnityEngine.Transform) | attributes=Family, HideBySig | impl=IL
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
IL_0023: callvirt !!0 UnityEngine.GameObject::AddComponent<AreaContent>()
IL_0028: ret
