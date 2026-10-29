TYPE TheForestOfLove.StoryInstanceContainedEventsTutorial
METHOD System.Void TheForestOfLove.StoryInstanceContainedEventsTutorial::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.StoryInstanceContainedEventsTutorial::pagedTutorial
IL_000c: ldc.i4.0
IL_000d: stfld System.Boolean TheForestOfLove.PagedTutorial::allowNavigation
IL_0012: ldarg.0
IL_0013: ldfld UnityEngine.Animator TheForestOfLove.StoryInstanceContainedEventsTutorial::page1Animator
IL_0018: ldstr "fadein"
IL_001d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0022: ret
METHOD System.Void TheForestOfLove.StoryInstanceContainedEventsTutorial::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.StoryInstanceContainedEventsTutorial::pagedTutorial
IL_000c: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PagedTutorial::onSubmit
IL_0011: ldarg.0
IL_0012: ldftn System.Void TheForestOfLove.StoryInstanceContainedEventsTutorial::OnPagedTutorialSubmit()
IL_0018: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.AnimationStateEventListener TheForestOfLove.StoryInstanceContainedEventsTutorial::animationStateEventListener
IL_0028: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipEnded
IL_002d: ldarg.0
IL_002e: ldftn System.Void TheForestOfLove.StoryInstanceContainedEventsTutorial::OnFadeIn(System.String)
IL_0034: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0039: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_003e: ret
METHOD System.Void TheForestOfLove.StoryInstanceContainedEventsTutorial::RemoveEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::RemoveEventListeners()
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.StoryInstanceContainedEventsTutorial::pagedTutorial
IL_000c: ldnull
IL_000d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0012: brfalse.s IL_0030
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.StoryInstanceContainedEventsTutorial::pagedTutorial
IL_001a: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PagedTutorial::onSubmit
IL_001f: ldarg.0
IL_0020: ldftn System.Void TheForestOfLove.StoryInstanceContainedEventsTutorial::OnPagedTutorialSubmit()
IL_0026: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_002b: callvirt System.Void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)
IL_0030: ret
METHOD System.Void TheForestOfLove.StoryInstanceContainedEventsTutorial::OnPagedTutorialSubmit() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.StoryInstanceContainedEventsTutorial::pagedTutorial
IL_0006: callvirt System.Boolean TheForestOfLove.PagedTutorial::get_finishedTutorial()
IL_000b: brfalse.s IL_0019
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.GameObject TheForestOfLove.StoryInstanceContainedEventsTutorial::page2LockIcon
IL_0013: ldc.i4.0
IL_0014: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0019: ret
METHOD System.Void TheForestOfLove.StoryInstanceContainedEventsTutorial::OnFadeIn(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "ContainedEvents_Fadein"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_0019
IL_000d: ldarg.0
IL_000e: ldfld TheForestOfLove.PagedTutorial TheForestOfLove.StoryInstanceContainedEventsTutorial::pagedTutorial
IL_0013: ldc.i4.1
IL_0014: stfld System.Boolean TheForestOfLove.PagedTutorial::allowNavigation
IL_0019: ret
METHOD System.Void TheForestOfLove.StoryInstanceContainedEventsTutorial::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::.ctor()
IL_0006: ret
