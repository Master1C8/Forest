TYPE TheForestOfLove.LevelTransitionFade
METHOD System.Void TheForestOfLove.LevelTransitionFade::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call !!0 UnityEngine.Component::GetComponent<TheForestOfLove.AnimationStateEventListener>()
IL_0007: stfld TheForestOfLove.AnimationStateEventListener TheForestOfLove.LevelTransitionFade::animationStateEventListener
IL_000c: ldarg.0
IL_000d: ldfld TheForestOfLove.AnimationStateEventListener TheForestOfLove.LevelTransitionFade::animationStateEventListener
IL_0012: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.AnimationStateEventListener::onClipFinishedLoop
IL_0017: ldarg.0
IL_0018: ldftn System.Void TheForestOfLove.LevelTransitionFade::OnAnimationClipFinishedLoop(System.String)
IL_001e: newobj System.Void UnityEngine.Events.UnityAction`1<System.String>::.ctor(System.Object,System.IntPtr)
IL_0023: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0028: ldarg.0
IL_0029: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_002e: ldarg.0
IL_002f: ldfld System.Single TheForestOfLove.LevelTransitionFade::animSpeedScaleFactor
IL_0034: callvirt System.Void UnityEngine.Animator::set_speed(System.Single)
IL_0039: ldarg.0
IL_003a: call !!0 UnityEngine.Component::GetComponent<UnityEngine.Animator>()
IL_003f: ldstr "FadeFromBlack"
IL_0044: ldc.i4.0
IL_0045: ldc.r4 0
IL_004a: callvirt System.Void UnityEngine.Animator::Play(System.String,System.Int32,System.Single)
IL_004f: ret
