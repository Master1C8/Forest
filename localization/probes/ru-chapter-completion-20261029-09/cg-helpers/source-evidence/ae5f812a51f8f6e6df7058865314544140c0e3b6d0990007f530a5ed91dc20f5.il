TYPE TheForestOfLove.OutOfSyncContentNotification
METHOD System.Void TheForestOfLove.OutOfSyncContentNotification::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.SelectableUiControl TheForestOfLove.OutOfSyncContentNotification::yesButtonControl
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.SelectableUiControl::onSelected
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.OutOfSyncContentNotification::<Start>b__9_0()
IL_0018: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.SelectableUiControl TheForestOfLove.OutOfSyncContentNotification::noButtonControl
IL_0028: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.SelectableUiControl::onSelected
IL_002d: ldarg.0
IL_002e: ldftn System.Void TheForestOfLove.OutOfSyncContentNotification::<Start>b__9_1()
IL_0034: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_003e: ldarg.0
IL_003f: call System.Void TheForestOfLove.OutOfSyncContentNotification::DisableNavigation()
IL_0044: ret
METHOD System.Void TheForestOfLove.OutOfSyncContentNotification::DisableNavigation() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Selectable TheForestOfLove.OutOfSyncContentNotification::yesButton
IL_0006: ldc.i4.0
IL_0007: callvirt System.Void UnityEngine.UI.Selectable::set_interactable(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.UI.Selectable TheForestOfLove.OutOfSyncContentNotification::noButton
IL_0012: ldc.i4.0
IL_0013: callvirt System.Void UnityEngine.UI.Selectable::set_interactable(System.Boolean)
IL_0018: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_001d: ldnull
IL_001e: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0023: ret
METHOD System.Void TheForestOfLove.OutOfSyncContentNotification::SetChapterNameLabel(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.OutOfSyncContentNotification::chapterNameLabelRoot
IL_0006: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TMPro.TMP_Text>()
IL_000b: stloc.0
IL_000c: ldc.i4.0
IL_000d: stloc.1
IL_000e: br.s IL_001d
IL_0010: ldloc.0
IL_0011: ldloc.1
IL_0012: ldelem.ref
IL_0013: ldarg.1
IL_0014: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0019: ldloc.1
IL_001a: ldc.i4.1
IL_001b: add
IL_001c: stloc.1
IL_001d: ldloc.1
IL_001e: ldloc.0
IL_001f: ldlen
IL_0020: conv.i4
IL_0021: blt.s IL_0010
IL_0023: ret
