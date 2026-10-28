TYPE TheForestOfLove.TransitionEffectsManager
METHOD System.Void TheForestOfLove.TransitionEffectsManager::ShowExitFade(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.TransitionEffectsManager/<>c__DisplayClass20_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld TheForestOfLove.TransitionEffectsManager TheForestOfLove.TransitionEffectsManager/<>c__DisplayClass20_0::<>4__this
IL_000d: ldloc.0
IL_000e: ldarg.1
IL_000f: stfld System.String TheForestOfLove.TransitionEffectsManager/<>c__DisplayClass20_0::sceneName
IL_0014: ldloc.0
IL_0015: ldfld System.String TheForestOfLove.TransitionEffectsManager/<>c__DisplayClass20_0::sceneName
IL_001a: ldstr "BunnyHouse"
IL_001f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0024: brfalse.s IL_0064
IL_0026: ldarg.0
IL_0027: ldfld UnityEngine.GameObject TheForestOfLove.TransitionEffectsManager::fxExitFadePrefab
IL_002c: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0031: dup
IL_0032: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.LevelTransitionFade>()
IL_0037: dup
IL_0038: ldfld System.Single TheForestOfLove.LevelTransitionFade::animSpeedScaleFactor
IL_003d: ldc.r4 0.25
IL_0042: mul
IL_0043: stfld System.Single TheForestOfLove.LevelTransitionFade::animSpeedScaleFactor
IL_0048: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.LevelTransitionFade>()
IL_004d: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.LevelTransitionFade::onAnimationComplete
IL_0052: ldloc.0
IL_0053: ldftn System.Void TheForestOfLove.TransitionEffectsManager/<>c__DisplayClass20_0::<ShowExitFade>b__1()
IL_0059: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_005e: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_0063: ret
IL_0064: ldarg.0
IL_0065: ldfld UnityEngine.GameObject TheForestOfLove.TransitionEffectsManager::fxExitFadePrefab
IL_006a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_006f: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.LevelTransitionFade>()
IL_0074: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.LevelTransitionFade::onAnimationComplete
IL_0079: ldloc.0
IL_007a: ldftn System.Void TheForestOfLove.TransitionEffectsManager/<>c__DisplayClass20_0::<ShowExitFade>b__0()
IL_0080: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0085: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_008a: ret
