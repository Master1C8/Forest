TYPE TheForestOfLove.ItemGetNotification
METHOD System.Void TheForestOfLove.ItemGetNotification::RegisterServices() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RegisterServices()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.ServiceLocator::Register<TheForestOfLove.ItemGetNotification>(T)
IL_000c: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::UnregisterServices() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::UnregisterServices()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.Services.ServiceLocator::Unregister<TheForestOfLove.ItemGetNotification>(T)
IL_000c: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld TheForestOfLove.Events.InventoryEvent TheForestOfLove.Events.NarrativeEvents::onInventoryItemAdded
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.ItemGetNotification::OnItemAdded(TheForestOfLove.Inventory.InventoryItem,System.Int32)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_001c: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::RemoveEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners()
IL_0006: ldsfld TheForestOfLove.Events.InventoryEvent TheForestOfLove.Events.NarrativeEvents::onInventoryItemAdded
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.ItemGetNotification::OnItemAdded(TheForestOfLove.Inventory.InventoryItem,System.Int32)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::RemoveListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_001c: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::ShowOrHide() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.ItemGetNotification::get_visible()
IL_0006: brfalse.s IL_002e
IL_0008: ldarg.0
IL_0009: ldc.r4 0
IL_000e: stfld System.Single TheForestOfLove.ItemGetNotification::currentOpenTime
IL_0013: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowItemGetAchievement
IL_0018: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_001d: ldsfld UnityEngine.Events.UnityEvent`1<System.Boolean> TheForestOfLove.Events.GameEvents::onShowItemGetAchievementOverloadedForAdventures
IL_0022: ldarg.0
IL_0023: ldfld System.Boolean TheForestOfLove.ItemGetNotification::showingAdventureNotification
IL_0028: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Boolean>::Invoke(!0)
IL_002d: ret
IL_002e: ldc.r4 1
IL_0033: ldarg.0
IL_0034: ldftn System.Void TheForestOfLove.ItemGetNotification::<ShowOrHide>b__64_0()
IL_003a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_003f: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0044: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::<ShowOrHide>b__64_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::messageContainer
IL_0006: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_000b: callvirt System.Collections.IEnumerator UnityEngine.Transform::GetEnumerator()
IL_0010: stloc.0
IL_0011: br.s IL_003d
IL_0013: ldloc.0
IL_0014: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_0019: castclass UnityEngine.Transform
IL_001e: stloc.1
IL_001f: ldloc.1
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::messageContainer
IL_0026: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_002b: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0030: brfalse.s IL_003d
IL_0032: ldloc.1
IL_0033: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0038: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_003d: ldloc.0
IL_003e: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0043: brtrue.s IL_0013
IL_0045: leave.s IL_0058
IL_0047: ldloc.0
IL_0048: isinst System.IDisposable
IL_004d: stloc.2
IL_004e: ldloc.2
IL_004f: brfalse.s IL_0057
IL_0051: ldloc.2
IL_0052: callvirt System.Void System.IDisposable::Dispose()
IL_0057: endfinally
IL_0058: ldarg.0
IL_0059: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::extraControlsContainer
IL_005e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0063: callvirt System.Collections.IEnumerator UnityEngine.Transform::GetEnumerator()
IL_0068: stloc.0
IL_0069: br.s IL_0095
IL_006b: ldloc.0
IL_006c: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_0071: castclass UnityEngine.Transform
IL_0076: stloc.3
IL_0077: ldloc.3
IL_0078: ldarg.0
IL_0079: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::extraControlsContainer
IL_007e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0083: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0088: brfalse.s IL_0095
IL_008a: ldloc.3
IL_008b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0090: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0095: ldloc.0
IL_0096: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_009b: brtrue.s IL_006b
IL_009d: leave.s IL_00b0
IL_009f: ldloc.0
IL_00a0: isinst System.IDisposable
IL_00a5: stloc.2
IL_00a6: ldloc.2
IL_00a7: brfalse.s IL_00af
IL_00a9: ldloc.2
IL_00aa: callvirt System.Void System.IDisposable::Dispose()
IL_00af: endfinally
IL_00b0: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideItemGetAchievement
IL_00b5: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00ba: ldsfld UnityEngine.Events.UnityEvent`1<System.Boolean> TheForestOfLove.Events.GameEvents::onHideItemGetAchievementOverloadedForAdventures
IL_00bf: ldarg.0
IL_00c0: ldfld System.Boolean TheForestOfLove.ItemGetNotification::showingAdventureNotification
IL_00c5: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Boolean>::Invoke(!0)
IL_00ca: ret
