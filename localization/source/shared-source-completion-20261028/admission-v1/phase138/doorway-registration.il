TYPE TheForestOfLove.TransitionEffectsManager
METHOD System.Void TheForestOfLove.TransitionEffectsManager::AddEventListeners() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::AddEventListeners()
IL_0006: ldsfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.Events.GameEvents::onEnteringDoorway
IL_000b: ldarg.0
IL_000c: ldftn System.Void TheForestOfLove.TransitionEffectsManager::ShowExitFade(System.String)
IL_0012: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_001c: ret
