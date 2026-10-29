TYPE TheForestOfLove.ConfirmBeginAdventureNotification
METHOD System.Void TheForestOfLove.ConfirmBeginAdventureNotification::<OnClickStart>b__41_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.ConfirmBeginAdventureNotification::madeSelection
IL_0007: ldarg.0
IL_0008: ldfld UnityEngine.Transform TheForestOfLove.ConfirmBeginAdventureNotification::adventureSelectScreen
IL_000d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0012: ldc.i4.0
IL_0013: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.Transform TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreen
IL_001e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0023: ldc.i4.1
IL_0024: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0029: ldarg.0
IL_002a: ldarg.0
IL_002b: ldfld System.Collections.Generic.List`1<TheForestOfLove.ConfirmBeginAdventureNotificationPage> TheForestOfLove.ConfirmBeginAdventureNotification::pages
IL_0030: ldarg.0
IL_0031: ldfld System.Int32 TheForestOfLove.ConfirmBeginAdventureNotification::currentPageSelected
IL_0036: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ConfirmBeginAdventureNotificationPage>::get_Item(System.Int32)
IL_003b: callvirt System.String TheForestOfLove.ConfirmBeginAdventureNotificationPage::get_Title()
IL_0040: call System.Void TheForestOfLove.ConfirmBeginAdventureNotification::SetConfirmationScreenTitleText(System.String)
IL_0045: ldarg.0
IL_0046: call System.Void TheForestOfLove.ConfirmBeginAdventureNotification::EnableNavigationConfirmationScreen()
IL_004b: ret
TYPE TheForestOfLove.ItemGetNotification
METHOD System.Void TheForestOfLove.ItemGetNotification::ShowOutOfSyncContentNotification(System.String,System.Action,System.Action) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld TheForestOfLove.ItemGetNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::<>4__this
IL_000d: ldarg.0
IL_000e: call System.Boolean TheForestOfLove.ItemGetNotification::get_visible()
IL_0013: brfalse.s IL_0016
IL_0015: ret
IL_0016: ldloc.0
IL_0017: ldarg.0
IL_0018: ldfld TheForestOfLove.OutOfSyncContentNotification TheForestOfLove.ItemGetNotification::outOfSyncContentPrefab
IL_001d: ldarg.0
IL_001e: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::messageContainer
IL_0023: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.OutOfSyncContentNotification>(!!0,UnityEngine.Transform)
IL_0028: stfld TheForestOfLove.OutOfSyncContentNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::notification
IL_002d: ldarg.2
IL_002e: brfalse.s IL_004c
IL_0030: ldloc.0
IL_0031: ldfld TheForestOfLove.OutOfSyncContentNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::notification
IL_0036: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.OutOfSyncContentNotification::onClickYes
IL_003b: ldarg.2
IL_003c: ldftn System.Void System.Action::Invoke()
IL_0042: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0047: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_004c: ldarg.3
IL_004d: brfalse.s IL_006b
IL_004f: ldloc.0
IL_0050: ldfld TheForestOfLove.OutOfSyncContentNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::notification
IL_0055: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.OutOfSyncContentNotification::onClickNo
IL_005a: ldarg.3
IL_005b: ldftn System.Void System.Action::Invoke()
IL_0061: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0066: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_006b: ldloc.0
IL_006c: ldfld TheForestOfLove.OutOfSyncContentNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::notification
IL_0071: ldarg.1
IL_0072: callvirt System.Void TheForestOfLove.OutOfSyncContentNotification::SetChapterNameLabel(System.String)
IL_0077: ldc.r4 1
IL_007c: ldsfld System.Action TheForestOfLove.ItemGetNotification/<>c::<>9__82_0
IL_0081: dup
IL_0082: brtrue.s IL_009b
IL_0084: pop
IL_0085: ldsfld TheForestOfLove.ItemGetNotification/<>c TheForestOfLove.ItemGetNotification/<>c::<>9
IL_008a: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c::<ShowOutOfSyncContentNotification>b__82_0()
IL_0090: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0095: dup
IL_0096: stsfld System.Action TheForestOfLove.ItemGetNotification/<>c::<>9__82_0
IL_009b: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00a0: ldc.r4 2.5
IL_00a5: ldloc.0
IL_00a6: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::<ShowOutOfSyncContentNotification>b__1()
IL_00ac: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00b1: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00b6: ldloc.0
IL_00b7: ldfld TheForestOfLove.OutOfSyncContentNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::notification
IL_00bc: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.OutOfSyncContentNotification::onMadeSelection
IL_00c1: ldloc.0
IL_00c2: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass82_0::<ShowOutOfSyncContentNotification>b__2()
IL_00c8: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00cd: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00d2: ldarg.0
IL_00d3: ldc.i4.0
IL_00d4: ldc.i4.1
IL_00d5: call System.Void TheForestOfLove.ItemGetNotification::StartNotification_CleanedUp(System.Boolean,System.Boolean)
IL_00da: ret
