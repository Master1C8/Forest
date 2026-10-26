TYPE TheForestOfLove.PlayMenu
METHOD System.Boolean TheForestOfLove.PlayMenu::get_showContinueButton() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.PlayMenu::<showContinueButton>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.PlayMenu::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinations
IL_0007: ldlen
IL_0008: conv.i4
IL_0009: newarr UnityEngine.GameObject
IL_000e: stfld UnityEngine.GameObject[] TheForestOfLove.PlayMenu::fastForwardDestinationsParallel
IL_0013: ret
METHOD System.Void TheForestOfLove.PlayMenu::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.UIPanelMenu::Start()
IL_0006: ldarg.0
IL_0007: call System.Boolean TheForestOfLove.PlayMenu::get_showContinueButton()
IL_000c: brtrue.s IL_0014
IL_000e: ldarg.0
IL_000f: call System.Void TheForestOfLove.PlayMenu::HideContinueButton()
IL_0014: ldarg.0
IL_0015: call System.Void TheForestOfLove.PlayMenu::UpdateFastForwardDestinationUI()
IL_001a: ret
METHOD System.Void TheForestOfLove.PlayMenu::OnClickContinue() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: call System.Void TheForestOfLove.PlayMenu::set_lastClickedFastForward(System.Boolean)
IL_0007: ldc.i4 200
IL_000c: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0011: ldarg.0
IL_0012: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PlayMenu::onClickContinue
IL_0017: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_001c: ret
