TYPE TheForestOfLove.PauseHelper
METHOD System.Boolean TheForestOfLove.PauseHelper::get_isPaused() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldsfld System.Boolean TheForestOfLove.PauseHelper::<isPaused>k__BackingField
IL_0005: ret
METHOD System.Void TheForestOfLove.PauseHelper::Pause() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.PauseHelper::get_isPaused()
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldc.i4.1
IL_0009: call System.Void TheForestOfLove.PauseHelper::set_isPaused(System.Boolean)
IL_000e: call System.Single UnityEngine.Time::get_timeScale()
IL_0013: stsfld System.Single TheForestOfLove.PauseHelper::previousTimeScale
IL_0018: ldc.r4 0
IL_001d: call System.Void UnityEngine.Time::set_timeScale(System.Single)
IL_0022: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onPause
IL_0027: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_002c: ret
METHOD System.Void TheForestOfLove.PauseHelper::Resume() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.PauseHelper::get_isPaused()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldc.i4.0
IL_0009: call System.Void TheForestOfLove.PauseHelper::set_isPaused(System.Boolean)
IL_000e: ldsfld System.Single TheForestOfLove.PauseHelper::previousTimeScale
IL_0013: call System.Void UnityEngine.Time::set_timeScale(System.Single)
IL_0018: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onUnpause
IL_001d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0022: ret
