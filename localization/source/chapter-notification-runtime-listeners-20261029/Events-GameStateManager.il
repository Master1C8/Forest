TYPE TheForestOfLove.Events.GameStateManager
METHOD System.Void TheForestOfLove.Events.GameStateManager::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueStart
IL_0005: ldarg.0
IL_0006: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_0()
IL_000c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0011: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0016: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_001b: ldarg.0
IL_001c: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_1()
IL_0022: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0027: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_002c: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowMasterLog
IL_0031: ldarg.0
IL_0032: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_2()
IL_0038: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_003d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0042: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideMasterLog
IL_0047: ldarg.0
IL_0048: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_3()
IL_004e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0053: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0058: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowItemGetAchievement
IL_005d: ldarg.0
IL_005e: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_4()
IL_0064: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0069: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_006e: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideItemGetAchievement
IL_0073: ldarg.0
IL_0074: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_5()
IL_007a: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_007f: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0084: ldsfld TheForestOfLove.Events.MovieEvent TheForestOfLove.Events.GameEvents::onMovieStarting
IL_0089: ldarg.0
IL_008a: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_6(TheForestOfLove.Narrative.Movie)
IL_0090: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Movie>::.ctor(System.Object,System.IntPtr)
IL_0095: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Movie>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_009a: ldsfld TheForestOfLove.Events.MovieEvent TheForestOfLove.Events.GameEvents::onMovieEnding
IL_009f: ldarg.0
IL_00a0: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_7(TheForestOfLove.Narrative.Movie)
IL_00a6: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Movie>::.ctor(System.Object,System.IntPtr)
IL_00ab: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Movie>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_00b0: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onPause
IL_00b5: ldarg.0
IL_00b6: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_8()
IL_00bc: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00c1: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00c6: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onUnpause
IL_00cb: ldarg.0
IL_00cc: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_9()
IL_00d2: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00d7: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00dc: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onTutorialStarting
IL_00e1: ldarg.0
IL_00e2: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_10()
IL_00e8: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_00ed: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_00f2: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onTutorialEnding
IL_00f7: ldarg.0
IL_00f8: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_11()
IL_00fe: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0103: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0108: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.GameEvents::onEnteringDoorway
IL_010d: ldarg.0
IL_010e: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_12(System.String)
IL_0114: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0119: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_011e: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.GameEvents::onExitingDoorway
IL_0123: ldarg.0
IL_0124: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_13(System.String)
IL_012a: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_012f: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0134: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onFastTravelStart
IL_0139: ldarg.0
IL_013a: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_14()
IL_0140: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0145: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_014a: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onFastTravelEnd
IL_014f: ldarg.0
IL_0150: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_15()
IL_0156: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_015b: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0160: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0165: ldarg.0
IL_0166: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_16()
IL_016c: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0171: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0176: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_017b: ldarg.0
IL_017c: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_17()
IL_0182: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0187: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_018c: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onShowGossipUI
IL_0191: ldarg.0
IL_0192: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_18()
IL_0198: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_019d: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01a2: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideGossipUI
IL_01a7: ldarg.0
IL_01a8: ldftn System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_19()
IL_01ae: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_01b3: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_01b8: ret
METHOD System.Void TheForestOfLove.Events.GameStateManager::<AddEventListeners>b__35_4() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldc.i4.4
IL_0002: ldc.i4.1
IL_0003: call System.Void TheForestOfLove.Events.GameStateManager::HandleEvent(TheForestOfLove.Events.GameStateManager/GameEvent,System.Boolean)
IL_0008: ret
