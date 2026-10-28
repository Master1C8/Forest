TYPE TheForestOfLove.ItemGetNotification
METHOD System.Void TheForestOfLove.ItemGetNotification::StartNotification() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.ItemGetNotification::set_visible(System.Boolean)
IL_0007: ldarg.0
IL_0008: call System.Void TheForestOfLove.ItemGetNotification::ResetAnimatorTriggers()
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::notificationAnimator
IL_0013: ldstr "show"
IL_0018: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_001d: ldarg.0
IL_001e: call System.Void TheForestOfLove.ItemGetNotification::ShowOrHide()
IL_0023: ldc.r4 1
IL_0028: ldsfld System.Action TheForestOfLove.ItemGetNotification/<>c::<>9__57_0
IL_002d: dup
IL_002e: brtrue.s IL_0047
IL_0030: pop
IL_0031: ldsfld TheForestOfLove.ItemGetNotification/<>c TheForestOfLove.ItemGetNotification/<>c::<>9
IL_0036: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c::<StartNotification>b__57_0()
IL_003c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0041: dup
IL_0042: stsfld System.Action TheForestOfLove.ItemGetNotification/<>c::<>9__57_0
IL_0047: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_004c: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::StartNotification_CleanedUp(System.Boolean,System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.ItemGetNotification::get_visible()
IL_0006: brfalse.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.1
IL_000b: call System.Void TheForestOfLove.ItemGetNotification::set_visible(System.Boolean)
IL_0010: ldarg.0
IL_0011: call System.Void TheForestOfLove.ItemGetNotification::ResetAnimatorTriggers()
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::notificationAnimator
IL_001c: ldstr "show"
IL_0021: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0026: ldarg.0
IL_0027: ldc.r4 0
IL_002c: stfld System.Single TheForestOfLove.ItemGetNotification::currentOpenTime
IL_0031: ldarg.0
IL_0032: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::continueButtonAnimator
IL_0037: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_003c: ldarg.1
IL_003d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0042: ldarg.0
IL_0043: ldfld UnityEngine.CanvasGroup TheForestOfLove.ItemGetNotification::itemGetPanelGroup
IL_0048: ldarg.2
IL_0049: callvirt System.Void UnityEngine.CanvasGroup::set_interactable(System.Boolean)
IL_004e: ldarg.0
IL_004f: ldfld UnityEngine.CanvasGroup TheForestOfLove.ItemGetNotification::messageGroup
IL_0054: ldarg.2
IL_0055: callvirt System.Void UnityEngine.CanvasGroup::set_interactable(System.Boolean)
IL_005a: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowItemGetAchievement
IL_005f: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0064: ldsfld UnityEngine.Events.UnityEvent`1<System.Boolean> TheForestOfLove.Events.GameEvents::onShowItemGetAchievementOverloadedForAdventures
IL_0069: ldarg.0
IL_006a: ldfld System.Boolean TheForestOfLove.ItemGetNotification::showingAdventureNotification
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Boolean>::Invoke(!0)
IL_0074: ret
METHOD TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification::ShowPagedTutorial(TheForestOfLove.PagedTutorial) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld TheForestOfLove.ItemGetNotification TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<>4__this
IL_000d: ldarg.0
IL_000e: call System.Boolean TheForestOfLove.ItemGetNotification::get_visible()
IL_0013: brfalse.s IL_0017
IL_0015: ldnull
IL_0016: ret
IL_0017: ldloc.0
IL_0018: ldarg.1
IL_0019: ldarg.0
IL_001a: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::messageContainer
IL_001f: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.PagedTutorial>(!!0,UnityEngine.Transform)
IL_0024: stfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0029: ldloc.0
IL_002a: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_002f: ldc.i4.0
IL_0030: stfld System.Boolean TheForestOfLove.PagedTutorial::allowNavigation
IL_0035: ldc.r4 2.5
IL_003a: ldloc.0
IL_003b: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__0()
IL_0041: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0046: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_004b: ldarg.0
IL_004c: ldloc.0
IL_004d: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0052: ldfld UnityEngine.Animator[] TheForestOfLove.PagedTutorial::nav
IL_0057: ldarg.0
IL_0058: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::extraControlsContainer
IL_005d: call System.Void TheForestOfLove.ItemGetNotification::ReparentTutorialNav(UnityEngine.Animator[],UnityEngine.Transform)
IL_0062: ldloc.0
IL_0063: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0068: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PagedTutorial::onSubmit
IL_006d: ldloc.0
IL_006e: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__1()
IL_0074: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0079: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_007e: ldloc.0
IL_007f: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_0084: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PagedTutorial::onTutorialFinished
IL_0089: ldloc.0
IL_008a: ldftn System.Void TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::<ShowPagedTutorial>b__2()
IL_0090: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0095: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_009a: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onTutorialStarting
IL_009f: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00a4: ldarg.0
IL_00a5: call System.Void TheForestOfLove.ItemGetNotification::StartNotification()
IL_00aa: ldloc.0
IL_00ab: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification/<>c__DisplayClass59_0::pagedTutorial
IL_00b0: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::ReparentTutorialNav(UnityEngine.Animator[],UnityEngine.Transform) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldc.i4.0
IL_0002: ldelem.ref
IL_0003: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0008: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_000d: ldarg.2
IL_000e: ldc.i4.1
IL_000f: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_0014: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::HideNotification() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.ItemGetNotification::get_visible()
IL_0006: brfalse.s IL_003b
IL_0008: ldarg.0
IL_0009: ldc.i4.0
IL_000a: call System.Void TheForestOfLove.ItemGetNotification::set_visible(System.Boolean)
IL_000f: ldarg.0
IL_0010: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::continueButtonAnimator
IL_0015: ldstr "pressed"
IL_001a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_001f: ldarg.0
IL_0020: call System.Void TheForestOfLove.ItemGetNotification::ResetAnimatorTriggers()
IL_0025: ldarg.0
IL_0026: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::notificationAnimator
IL_002b: ldstr "hide"
IL_0030: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0035: ldarg.0
IL_0036: call System.Void TheForestOfLove.ItemGetNotification::ShowOrHide()
IL_003b: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::HideNotification_CleanedUp() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.ItemGetNotification::get_visible()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: call System.Void TheForestOfLove.ItemGetNotification::set_visible(System.Boolean)
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::continueButtonAnimator
IL_0016: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001b: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0020: brfalse.s IL_0032
IL_0022: ldarg.0
IL_0023: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::continueButtonAnimator
IL_0028: ldstr "pressed"
IL_002d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0032: ldarg.0
IL_0033: call System.Void TheForestOfLove.ItemGetNotification::ResetAnimatorTriggers()
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::notificationAnimator
IL_003e: ldstr "hide"
IL_0043: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0048: ldc.r4 1
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.ItemGetNotification::<HideNotification_CleanedUp>b__63_0()
IL_0054: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0059: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_005e: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::ShowPennyCloacaFistingStory() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification::pennyCloacaFistingStoryPrefab
IL_0007: call TheForestOfLove.PagedTutorial TheForestOfLove.ItemGetNotification::ShowPagedTutorial(TheForestOfLove.PagedTutorial)
IL_000c: pop
IL_000d: ret
METHOD System.Void TheForestOfLove.ItemGetNotification::<HideNotification_CleanedUp>b__63_0() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.ItemGetNotification::continueButtonAnimator
IL_0006: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_000b: ldc.i4.1
IL_000c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.CanvasGroup TheForestOfLove.ItemGetNotification::itemGetPanelGroup
IL_0017: ldc.i4.0
IL_0018: callvirt System.Void UnityEngine.CanvasGroup::set_interactable(System.Boolean)
IL_001d: ldarg.0
IL_001e: ldfld UnityEngine.CanvasGroup TheForestOfLove.ItemGetNotification::messageGroup
IL_0023: ldc.i4.0
IL_0024: callvirt System.Void UnityEngine.CanvasGroup::set_interactable(System.Boolean)
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::messageContainer
IL_002f: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0034: callvirt System.Collections.IEnumerator UnityEngine.Transform::GetEnumerator()
IL_0039: stloc.0
IL_003a: br.s IL_0066
IL_003c: ldloc.0
IL_003d: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_0042: castclass UnityEngine.Transform
IL_0047: stloc.1
IL_0048: ldloc.1
IL_0049: ldarg.0
IL_004a: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::messageContainer
IL_004f: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0054: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0059: brfalse.s IL_0066
IL_005b: ldloc.1
IL_005c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0061: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0066: ldloc.0
IL_0067: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_006c: brtrue.s IL_003c
IL_006e: leave.s IL_0081
IL_0070: ldloc.0
IL_0071: isinst System.IDisposable
IL_0076: stloc.2
IL_0077: ldloc.2
IL_0078: brfalse.s IL_0080
IL_007a: ldloc.2
IL_007b: callvirt System.Void System.IDisposable::Dispose()
IL_0080: endfinally
IL_0081: ldarg.0
IL_0082: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::extraControlsContainer
IL_0087: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_008c: callvirt System.Collections.IEnumerator UnityEngine.Transform::GetEnumerator()
IL_0091: stloc.0
IL_0092: br.s IL_00be
IL_0094: ldloc.0
IL_0095: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_009a: castclass UnityEngine.Transform
IL_009f: stloc.3
IL_00a0: ldloc.3
IL_00a1: ldarg.0
IL_00a2: ldfld UnityEngine.Transform TheForestOfLove.ItemGetNotification::extraControlsContainer
IL_00a7: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00ac: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00b1: brfalse.s IL_00be
IL_00b3: ldloc.3
IL_00b4: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00b9: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_00be: ldloc.0
IL_00bf: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_00c4: brtrue.s IL_0094
IL_00c6: leave.s IL_00d9
IL_00c8: ldloc.0
IL_00c9: isinst System.IDisposable
IL_00ce: stloc.2
IL_00cf: ldloc.2
IL_00d0: brfalse.s IL_00d8
IL_00d2: ldloc.2
IL_00d3: callvirt System.Void System.IDisposable::Dispose()
IL_00d8: endfinally
IL_00d9: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideItemGetAchievement
IL_00de: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00e3: ldsfld UnityEngine.Events.UnityEvent`1<System.Boolean> TheForestOfLove.Events.GameEvents::onHideItemGetAchievementOverloadedForAdventures
IL_00e8: ldarg.0
IL_00e9: ldfld System.Boolean TheForestOfLove.ItemGetNotification::showingAdventureNotification
IL_00ee: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.Boolean>::Invoke(!0)
IL_00f3: ret
