TYPE TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged
METHOD System.Void TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::Awake()
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::target
IL_0006: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_000b: callvirt System.Collections.IEnumerator UnityEngine.Transform::GetEnumerator()
IL_0010: stloc.0
IL_0011: br.s IL_002b
IL_0013: ldloc.0
IL_0014: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_0019: castclass UnityEngine.Transform
IL_001e: stloc.1
IL_001f: ldarg.0
IL_0020: ldfld System.Collections.Generic.List`1<UnityEngine.Transform> TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::children
IL_0025: ldloc.1
IL_0026: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.Transform>::Add(!0)
IL_002b: ldloc.0
IL_002c: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0031: brtrue.s IL_0013
IL_0033: leave.s IL_0046
IL_0035: ldloc.0
IL_0036: isinst System.IDisposable
IL_003b: stloc.2
IL_003c: ldloc.2
IL_003d: brfalse.s IL_0045
IL_003f: ldloc.2
IL_0040: callvirt System.Void System.IDisposable::Dispose()
IL_0045: endfinally
IL_0046: ldarg.0
IL_0047: ldfld UnityEngine.GameObject TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::target
IL_004c: ldc.i4.0
IL_004d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0052: ldarg.0
IL_0053: ldftn System.Void TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::OnLevelFinishedLoading(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene)
IL_0059: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene>::.ctor(System.Object,System.IntPtr)
IL_005e: call System.Void UnityEngine.SceneManagement.SceneManager::add_activeSceneChanged(UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene>)
IL_0063: ret
METHOD System.Void TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::OnLevelFinishedLoading(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene)
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<UnityEngine.Transform> TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::children
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.Transform>::get_Count()
IL_000b: ldc.i4.1
IL_000c: sub
IL_000d: stloc.0
IL_000e: br.s IL_0027
IL_0010: ldarg.0
IL_0011: ldfld System.Collections.Generic.List`1<UnityEngine.Transform> TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::children
IL_0016: ldloc.0
IL_0017: callvirt !0 System.Collections.Generic.List`1<UnityEngine.Transform>::get_Item(System.Int32)
IL_001c: ldnull
IL_001d: ldc.i4.0
IL_001e: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_0023: ldloc.0
IL_0024: ldc.i4.1
IL_0025: sub
IL_0026: stloc.0
IL_0027: ldloc.0
IL_0028: ldc.i4.0
IL_0029: bge.s IL_0010
IL_002b: ldarg.0
IL_002c: ldfld UnityEngine.GameObject TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged::target
IL_0031: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_0036: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_003b: ldarg.0
IL_003c: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0041: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0046: ret
