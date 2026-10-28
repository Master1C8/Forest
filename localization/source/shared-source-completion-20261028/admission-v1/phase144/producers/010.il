TYPE TheForestOfLove.AdventureTeleportScrollController
METHOD System.Void TheForestOfLove.AdventureTeleportScrollController::OnTriggerEnter2D(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0006: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_000b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0010: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0015: brfalse.s IL_0018
IL_0017: ret
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.Animator TheForestOfLove.AdventureTeleportScrollController::animator
IL_001e: ldstr "high"
IL_0023: ldc.i4.1
IL_0024: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.Animator TheForestOfLove.AdventureTeleportScrollController::animator
IL_002f: ldstr "unavailable"
IL_0034: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAdventuresUnavailable()
IL_0039: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_003e: ret
METHOD System.Void TheForestOfLove.AdventureTeleportScrollController::OnTriggerExit2D(UnityEngine.Collider2D) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0006: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_000b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0010: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0015: brfalse.s IL_0018
IL_0017: ret
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.Animator TheForestOfLove.AdventureTeleportScrollController::animator
IL_001e: ldstr "high"
IL_0023: ldc.i4.0
IL_0024: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.Animator TheForestOfLove.AdventureTeleportScrollController::animator
IL_002f: ldstr "unavailable"
IL_0034: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAdventuresUnavailable()
IL_0039: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_003e: ret
