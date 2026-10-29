TYPE TheForestOfLove.InteractionIconChatUi
METHOD System.Void TheForestOfLove.InteractionIconChatUi::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueStart
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.InteractionIconChatUi::OnConversationStart()
IL_0012: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_001c: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_0021: ldarg.0
IL_0022: ldftn System.Void TheForestOfLove.InteractionIconChatUi::OnConversationEnd()
IL_0028: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0032: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueLine
IL_0037: ldarg.0
IL_0038: ldftn System.Void TheForestOfLove.InteractionIconChatUi::OnConversationLine()
IL_003e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0043: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0048: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideMasterLog
IL_004d: ldarg.0
IL_004e: ldftn System.Void TheForestOfLove.InteractionIconChatUi::ShowImmediate()
IL_0054: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0059: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_005e: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowMasterLog
IL_0063: ldarg.0
IL_0064: ldftn System.Void TheForestOfLove.InteractionIconChatUi::HideImmediate()
IL_006a: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_006f: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0074: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideItemGetAchievement
IL_0079: ldarg.0
IL_007a: ldftn System.Void TheForestOfLove.InteractionIconChatUi::Show()
IL_0080: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0085: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_008a: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowItemGetAchievement
IL_008f: ldarg.0
IL_0090: ldftn System.Void TheForestOfLove.InteractionIconChatUi::HideImmediate()
IL_0096: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_009b: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00a0: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onPause
IL_00a5: ldarg.0
IL_00a6: ldftn System.Void TheForestOfLove.InteractionIconChatUi::HideImmediate()
IL_00ac: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00b1: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00b6: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onUnpause
IL_00bb: ldarg.0
IL_00bc: ldftn System.Void TheForestOfLove.InteractionIconChatUi::Show()
IL_00c2: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00c7: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00cc: ldsfld TheForestOfLove.Events.MovieEvent TheForestOfLove.Events.GameEvents::onMovieStarting
IL_00d1: ldarg.0
IL_00d2: ldftn System.Void TheForestOfLove.InteractionIconChatUi::OnMovieStarting(TheForestOfLove.Narrative.Movie)
IL_00d8: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Movie>::.ctor(System.Object,System.IntPtr)
IL_00dd: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Movie>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00e2: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onTutorialStarting
IL_00e7: ldarg.0
IL_00e8: ldftn System.Void TheForestOfLove.InteractionIconChatUi::HideImmediate()
IL_00ee: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00f3: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00f8: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onTutorialEnding
IL_00fd: ldarg.0
IL_00fe: ldftn System.Void TheForestOfLove.InteractionIconChatUi::Show()
IL_0104: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0109: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_010e: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onFastTravelStart
IL_0113: ldarg.0
IL_0114: ldftn System.Void TheForestOfLove.InteractionIconChatUi::HideImmediate()
IL_011a: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_011f: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0124: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onFastTravelEnd
IL_0129: ldarg.0
IL_012a: ldftn System.Void TheForestOfLove.InteractionIconChatUi::ShowImmediate()
IL_0130: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0135: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_013a: ret
METHOD System.Void TheForestOfLove.InteractionIconChatUi::HideImmediate() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.InteractionIconChatUi/InteractionUiState TheForestOfLove.InteractionIconChatUi::state
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call System.Void TheForestOfLove.InteractionIconChatUi::Hide()
IL_000f: ldarg.0
IL_0010: ldfld UnityEngine.Animator TheForestOfLove.InteractionIconChatUi::animator
IL_0015: ldstr "hide"
IL_001a: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_001f: ldarg.0
IL_0020: ldfld UnityEngine.Animator TheForestOfLove.InteractionIconChatUi::animator
IL_0025: ldstr "hide_immediate"
IL_002a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_002f: ret
