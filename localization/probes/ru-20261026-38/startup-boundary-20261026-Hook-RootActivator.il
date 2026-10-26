TYPE TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged
METHOD System.Void TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::Awake()
IL_0000: ldstr "FOREST_STARTUP ROOT_AWAKE_ENTER"
IL_0005: call System.Void UnityEngine.Debug::Log(System.Object)
IL_000a: ldarg.0
IL_000b: ldfld UnityEngine.GameObject TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::target
IL_0010: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0015: callvirt System.Collections.IEnumerator UnityEngine.Transform::GetEnumerator()
IL_001a: stloc.0
IL_001b: br.s IL_0035
IL_001d: ldloc.0
IL_001e: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_0023: castclass UnityEngine.Transform
IL_0028: stloc.1
IL_0029: ldarg.0
IL_002a: ldfld System.Collections.Generic.List`1<UnityEngine.Transform> TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::children
IL_002f: ldloc.1
IL_0030: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.Transform>::Add(!0)
IL_0035: ldloc.0
IL_0036: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_003b: brtrue.s IL_001d
IL_003d: leave.s IL_0050
IL_003f: ldloc.0
IL_0040: isinst System.IDisposable
IL_0045: stloc.2
IL_0046: ldloc.2
IL_0047: brfalse.s IL_004f
IL_0049: ldloc.2
IL_004a: callvirt System.Void System.IDisposable::Dispose()
IL_004f: endfinally
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.GameObject TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::target
IL_0056: ldc.i4.0
IL_0057: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_005c: ldarg.0
IL_005d: ldftn System.Void TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::OnLevelFinishedLoading(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene)
IL_0063: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene>::.ctor(System.Object,System.IntPtr)
IL_0068: call System.Void UnityEngine.SceneManagement.SceneManager::add_activeSceneChanged(UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene>)
IL_006d: ret
METHOD System.Void TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::OnLevelFinishedLoading(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene)
IL_0000: ldstr "FOREST_STARTUP ROOT_SCENE_CHANGED_ENTER"
IL_0005: call System.Void UnityEngine.Debug::Log(System.Object)
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.List`1<UnityEngine.Transform> TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::children
IL_0010: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.Transform>::get_Count()
IL_0015: ldc.i4.1
IL_0016: sub
IL_0017: stloc.0
IL_0018: br.s IL_0031
IL_001a: ldarg.0
IL_001b: ldfld System.Collections.Generic.List`1<UnityEngine.Transform> TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::children
IL_0020: ldloc.0
IL_0021: callvirt !0 System.Collections.Generic.List`1<UnityEngine.Transform>::get_Item(System.Int32)
IL_0026: ldnull
IL_0027: ldc.i4.0
IL_0028: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_002d: ldloc.0
IL_002e: ldc.i4.1
IL_002f: sub
IL_0030: stloc.0
IL_0031: ldloc.0
IL_0032: ldc.i4.0
IL_0033: bge.s IL_001a
IL_0035: ldarg.0
IL_0036: ldfld UnityEngine.GameObject TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::target
IL_003b: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_0040: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0045: ldarg.0
IL_0046: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_004b: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0050: ret
