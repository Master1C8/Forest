TYPE TheForestOfLove.InputHelper
METHOD System.Boolean TheForestOfLove.InputHelper::UpdateAxisInputFromKeyboard()
IL_0000: ldarg.0
IL_0001: ldfld Rewired.Player TheForestOfLove.InputHelper::player
IL_0006: ldc.i4.0
IL_0007: ldc.i4.1
IL_0008: callvirt UnityEngine.Vector2 Rewired.Player::GetAxis2D(System.Int32,System.Int32)
IL_000d: call UnityEngine.Vector3 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector2)
IL_0012: call System.Boolean TheForestOfLove.InputHelper::TryUpdateAxisInput(UnityEngine.Vector3)
IL_0017: ret
