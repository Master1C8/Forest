TYPE TheForestOfLove.OverworldAllInOneNotification
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld TheForestOfLove.Events.InventoryEvent TheForestOfLove.Events.NarrativeEvents::onInventoryItemAdded
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::OnItemAdded(TheForestOfLove.Inventory.InventoryItem,System.Int32)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_001c: ldsfld TheForestOfLove.Events.InventoryEvent TheForestOfLove.Events.NarrativeEvents::onInventoryItemRemoved
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::OnItemRemoved(TheForestOfLove.Inventory.InventoryItem,System.Int32)
IL_0028: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Inventory.InventoryItem,System.Int32>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0032: ldsfld TheForestOfLove.Events.ActorEvent TheForestOfLove.Events.GameEvents::onGossipUnlocked
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::OnGossipUnlocked(TheForestOfLove.Narrative.Actor)
IL_003e: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Actor>::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Actor>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0048: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onGlobalGossipUnlocked
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::OnGlobalGossipUnlocked()
IL_0054: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_005e: ldsfld TheForestOfLove.Events.ActorBioKeywordEvent TheForestOfLove.Events.NarrativeEvents::onUnlockActorBioKeyword
IL_0063: ldarg.0
IL_0064: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::OnBioUnlocked(TheForestOfLove.Narrative.Actor,TheForestOfLove.Narrative.BioKeyword)
IL_006a: newobj System.Void UnityEngine.Events.UnityAction`2<TheForestOfLove.Narrative.Actor,TheForestOfLove.Narrative.BioKeyword>::.ctor(System.Object,System.IntPtr)
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,TheForestOfLove.Narrative.BioKeyword>::AddListener(UnityEngine.Events.UnityAction`2<!0,!1>)
IL_0074: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueStart
IL_0079: ldarg.0
IL_007a: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications()
IL_0080: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0085: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_008a: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowMasterLog
IL_008f: ldarg.0
IL_0090: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications()
IL_0096: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_009b: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00a0: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowItemGetAchievement
IL_00a5: ldarg.0
IL_00a6: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications()
IL_00ac: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00b1: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00b6: ldsfld TheForestOfLove.Events.MovieEvent TheForestOfLove.Events.GameEvents::onMovieStarting
IL_00bb: ldarg.0
IL_00bc: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications(TheForestOfLove.Narrative.Movie)
IL_00c2: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Movie>::.ctor(System.Object,System.IntPtr)
IL_00c7: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Movie>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00cc: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.GameEvents::onEnteringDoorway
IL_00d1: ldarg.0
IL_00d2: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications(System.String)
IL_00d8: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_00dd: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00e2: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onFastTravelStart
IL_00e7: ldarg.0
IL_00e8: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications()
IL_00ee: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00f3: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00f8: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onTutorialStarting
IL_00fd: ldarg.0
IL_00fe: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications()
IL_0104: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0109: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_010e: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Adventure> TheForestOfLove.Events.GameEvents::onAdventureUnlocked
IL_0113: ldarg.0
IL_0114: ldftn System.Void TheForestOfLove.OverworldAllInOneNotification::OnAdventureUnlocked(TheForestOfLove.Narrative.Adventure)
IL_011a: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Adventure>::.ctor(System.Object,System.IntPtr)
IL_011f: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Adventure>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0124: ret
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.OverworldAllInOneNotification::ShowNextNotification(System.Boolean)
IL_0007: ret
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications(TheForestOfLove.Narrative.Movie) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications()
IL_0006: ret
METHOD System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.OverworldAllInOneNotification::ClearAllNotifications()
IL_0006: ret
