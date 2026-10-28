TYPE TheForestOfLove.InputHelper
METHOD System.Void TheForestOfLove.InputHelper::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Awake()
IL_0006: ldarg.0
IL_0007: call Rewired.ReInput/PlayerHelper Rewired.ReInput::get_players()
IL_000c: ldc.i4.0
IL_000d: callvirt Rewired.Player Rewired.ReInput/PlayerHelper::GetPlayer(System.Int32)
IL_0012: stfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0017: ldarg.0
IL_0018: call !!0 UnityEngine.Object::FindObjectOfType<Itelisoft.KOF.TheKingOfJoysticks>()
IL_001d: stfld Itelisoft.KOF.TheKingOfJoysticks TheForestOfLove.InputHelper::theKingOfJoysticks
IL_0022: ldarg.0
IL_0023: call !!0 UnityEngine.Object::FindObjectOfType<TheForestOfLove.TouchInputHelper>()
IL_0028: stfld TheForestOfLove.TouchInputHelper TheForestOfLove.InputHelper::touchInputHelper
IL_002d: ldarg.0
IL_002e: ldarg.0
IL_002f: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0034: ldfld Rewired.Player/ControllerHelper Rewired.Player::controllers
IL_0039: ldstr "kingofjoysticks"
IL_003e: callvirt !!0 Rewired.Player/ControllerHelper::GetControllerWithTag<Rewired.CustomController>(System.String)
IL_0043: stfld Rewired.CustomController TheForestOfLove.InputHelper::kingOfJoysticksRewiredCustomController
IL_0048: ldarg.0
IL_0049: ldfld Rewired.CustomController TheForestOfLove.InputHelper::kingOfJoysticksRewiredCustomController
IL_004e: brfalse.s IL_007e
IL_0050: ldarg.0
IL_0051: ldfld Rewired.CustomController TheForestOfLove.InputHelper::kingOfJoysticksRewiredCustomController
IL_0056: ldarg.0
IL_0057: ldftn System.Single TheForestOfLove.InputHelper::GetAxisValueCallback(System.Int32)
IL_005d: newobj System.Void System.Func`2<System.Int32,System.Single>::.ctor(System.Object,System.IntPtr)
IL_0062: callvirt System.Void Rewired.CustomController::SetAxisUpdateCallback(System.Func`2<System.Int32,System.Single>)
IL_0067: ldarg.0
IL_0068: ldfld Rewired.CustomController TheForestOfLove.InputHelper::kingOfJoysticksRewiredCustomController
IL_006d: ldarg.0
IL_006e: ldftn System.Boolean TheForestOfLove.InputHelper::GetButtonValueCallback(System.Int32)
IL_0074: newobj System.Void System.Func`2<System.Int32,System.Boolean>::.ctor(System.Object,System.IntPtr)
IL_0079: callvirt System.Void Rewired.CustomController::SetButtonUpdateCallback(System.Func`2<System.Int32,System.Boolean>)
IL_007e: ret
METHOD System.Void TheForestOfLove.InputHelper::UpdateRewiredInputMaps() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0006: ldfld Rewired.Player/ControllerHelper Rewired.Player::controllers
IL_000b: ldfld Rewired.Player/ControllerHelper/MapHelper Rewired.Player/ControllerHelper::maps
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean TheForestOfLove.InputHelper::uiInputsDisabled
IL_0016: ldc.i4.0
IL_0017: ceq
IL_0019: ldstr "Menus"
IL_001e: callvirt System.Int32 Rewired.Player/ControllerHelper/MapHelper::SetMapsEnabled(System.Boolean,System.String)
IL_0023: pop
IL_0024: ret
