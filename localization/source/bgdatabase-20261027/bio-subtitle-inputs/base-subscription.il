TYPE TheForestOfLove.Core.BaseBehavior
METHOD System.Void TheForestOfLove.Core.BaseBehavior::Awake() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.Core.BaseBehavior::set_isAwakened(System.Boolean)
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.Core.BaseBehavior::RegisterServices_Internal()
IL_000d: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::Start() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.Core.BaseBehavior::set_isStarted(System.Boolean)
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners_Internal()
IL_000d: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::OnEnable() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isAwakened()
IL_0006: brfalse.s IL_000e
IL_0008: ldarg.0
IL_0009: call System.Void TheForestOfLove.Core.BaseBehavior::RegisterServices_Internal()
IL_000e: ldarg.0
IL_000f: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isStarted()
IL_0014: brfalse.s IL_001c
IL_0016: ldarg.0
IL_0017: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners_Internal()
IL_001c: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::OnDisable() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners_Internal()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Core.BaseBehavior::UnregisterServices_Internal()
IL_000c: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::OnDestroy() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.Core.BaseBehavior::set_isDestroyed(System.Boolean)
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners_Internal()
IL_000d: ldarg.0
IL_000e: call System.Void TheForestOfLove.Core.BaseBehavior::UnregisterServices_Internal()
IL_0013: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners_Internal() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Core.BaseBehavior::eventsRegistered
IL_0006: brtrue.s IL_0028
IL_0008: ldarg.0
IL_0009: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isAwakened()
IL_000e: brfalse.s IL_0028
IL_0010: ldarg.0
IL_0011: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isStarted()
IL_0016: brfalse.s IL_0028
IL_0018: ldarg.0
IL_0019: ldfld System.Boolean TheForestOfLove.Core.BaseBehavior::isApplicationQuitting
IL_001e: brtrue.s IL_0028
IL_0020: ldarg.0
IL_0021: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isDestroyed()
IL_0026: brfalse.s IL_0029
IL_0028: ret
IL_0029: ldarg.0
IL_002a: dup
IL_002b: ldvirtftn System.Void TheForestOfLove.Core.BaseBehavior::OnSceneLoaded(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode)
IL_0031: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode>::.ctor(System.Object,System.IntPtr)
IL_0036: call System.Void UnityEngine.SceneManagement.SceneManager::add_sceneLoaded(UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode>)
IL_003b: ldarg.0
IL_003c: dup
IL_003d: ldvirtftn System.Void TheForestOfLove.Core.BaseBehavior::OnActiveSceneChanged(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene)
IL_0043: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene>::.ctor(System.Object,System.IntPtr)
IL_0048: call System.Void UnityEngine.SceneManagement.SceneManager::add_activeSceneChanged(UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene>)
IL_004d: ldarg.0
IL_004e: dup
IL_004f: ldvirtftn System.Void TheForestOfLove.Core.BaseBehavior::OnSceneUnloaded(UnityEngine.SceneManagement.Scene)
IL_0055: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.SceneManagement.Scene>::.ctor(System.Object,System.IntPtr)
IL_005a: call System.Void UnityEngine.SceneManagement.SceneManager::add_sceneUnloaded(UnityEngine.Events.UnityAction`1<UnityEngine.SceneManagement.Scene>)
IL_005f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Core.BaseBehavior::onSaving
IL_0064: ldarg.0
IL_0065: dup
IL_0066: ldvirtftn System.Void TheForestOfLove.Core.BaseBehavior::Save()
IL_006c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0071: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0076: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Core.BaseBehavior::onSaved
IL_007b: ldarg.0
IL_007c: dup
IL_007d: ldvirtftn System.Void TheForestOfLove.Core.BaseBehavior::PostSave()
IL_0083: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0088: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_008d: ldarg.0
IL_008e: callvirt System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0093: ldarg.0
IL_0094: ldc.i4.1
IL_0095: stfld System.Boolean TheForestOfLove.Core.BaseBehavior::eventsRegistered
IL_009a: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners_Internal() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Core.BaseBehavior::eventsRegistered
IL_0006: brfalse.s IL_0020
IL_0008: ldarg.0
IL_0009: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isAwakened()
IL_000e: brfalse.s IL_0020
IL_0010: ldarg.0
IL_0011: call System.Boolean TheForestOfLove.Core.BaseBehavior::get_isStarted()
IL_0016: brfalse.s IL_0020
IL_0018: ldarg.0
IL_0019: ldfld System.Boolean TheForestOfLove.Core.BaseBehavior::isApplicationQuitting
IL_001e: brfalse.s IL_0021
IL_0020: ret
IL_0021: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Core.BaseBehavior::onSaving
IL_0026: ldarg.0
IL_0027: dup
IL_0028: ldvirtftn System.Void TheForestOfLove.Core.BaseBehavior::Save()
IL_002e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0033: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_0038: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Core.BaseBehavior::onSaved
IL_003d: ldarg.0
IL_003e: dup
IL_003f: ldvirtftn System.Void TheForestOfLove.Core.BaseBehavior::PostSave()
IL_0045: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_004a: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_004f: ldarg.0
IL_0050: callvirt System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners()
IL_0055: ldarg.0
IL_0056: dup
IL_0057: ldvirtftn System.Void TheForestOfLove.Core.BaseBehavior::OnSceneLoaded(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode)
IL_005d: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode>::.ctor(System.Object,System.IntPtr)
IL_0062: call System.Void UnityEngine.SceneManagement.SceneManager::remove_sceneLoaded(UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.LoadSceneMode>)
IL_0067: ldarg.0
IL_0068: dup
IL_0069: ldvirtftn System.Void TheForestOfLove.Core.BaseBehavior::OnActiveSceneChanged(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene)
IL_006f: newobj System.Void UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene>::.ctor(System.Object,System.IntPtr)
IL_0074: call System.Void UnityEngine.SceneManagement.SceneManager::remove_activeSceneChanged(UnityEngine.Events.UnityAction`2<UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene>)
IL_0079: ldarg.0
IL_007a: dup
IL_007b: ldvirtftn System.Void TheForestOfLove.Core.BaseBehavior::OnSceneUnloaded(UnityEngine.SceneManagement.Scene)
IL_0081: newobj System.Void UnityEngine.Events.UnityAction`1<UnityEngine.SceneManagement.Scene>::.ctor(System.Object,System.IntPtr)
IL_0086: call System.Void UnityEngine.SceneManagement.SceneManager::remove_sceneUnloaded(UnityEngine.Events.UnityAction`1<UnityEngine.SceneManagement.Scene>)
IL_008b: ldarg.0
IL_008c: ldc.i4.0
IL_008d: stfld System.Boolean TheForestOfLove.Core.BaseBehavior::eventsRegistered
IL_0092: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ret
METHOD System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ret
