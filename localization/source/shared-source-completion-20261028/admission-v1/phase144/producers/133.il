TYPE TheForestOfLove.Player
METHOD System.Void TheForestOfLove.Player::OnSetDirection() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0006: ldc.i4.4
IL_0007: beq.s IL_0011
IL_0009: ldarg.0
IL_000a: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_000f: brtrue.s IL_0012
IL_0011: ret
IL_0012: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsDialoguePlaying()
IL_0017: brfalse.s IL_0028
IL_0019: ldarg.0
IL_001a: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_001f: ldc.i4.3
IL_0020: beq.s IL_0028
IL_0022: ldarg.0
IL_0023: call System.Void TheForestOfLove.Player::RestInstantly()
IL_0028: ldarg.0
IL_0029: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_002e: ldc.i4.2
IL_002f: beq IL_01e0
IL_0034: ldarg.0
IL_0035: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_003a: ldc.i4.5
IL_003b: beq IL_01e0
IL_0040: ldarg.0
IL_0041: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0046: callvirt TheForestOfLove.Direction TheForestOfLove.Gameplay.DirectionController::get_direction()
IL_004b: call UnityEngine.Vector3 TheForestOfLove.GeneralExtensions::ToUnitVector(TheForestOfLove.Direction)
IL_0050: stloc.0
IL_0051: ldarg.0
IL_0052: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0057: ldstr "x"
IL_005c: ldloca.s V_0
IL_005e: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_0063: ldfld System.Single UnityEngine.Vector3::x
IL_0068: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_006d: ldarg.0
IL_006e: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0073: ldstr "y"
IL_0078: ldloca.s V_0
IL_007a: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_007f: ldfld System.Single UnityEngine.Vector3::y
IL_0084: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0089: ldarg.0
IL_008a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_008f: ldstr "x"
IL_0094: ldloca.s V_0
IL_0096: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_009b: ldfld System.Single UnityEngine.Vector3::x
IL_00a0: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_00a5: ldarg.0
IL_00a6: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_00ab: ldstr "y"
IL_00b0: ldloca.s V_0
IL_00b2: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_00b7: ldfld System.Single UnityEngine.Vector3::y
IL_00bc: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_00c1: ldarg.0
IL_00c2: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_00c7: ldnull
IL_00c8: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00cd: brfalse.s IL_0107
IL_00cf: ldarg.0
IL_00d0: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_00d5: ldstr "x"
IL_00da: ldloca.s V_0
IL_00dc: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_00e1: ldfld System.Single UnityEngine.Vector3::x
IL_00e6: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_00eb: ldarg.0
IL_00ec: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_00f1: ldstr "y"
IL_00f6: ldloca.s V_0
IL_00f8: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_00fd: ldfld System.Single UnityEngine.Vector3::y
IL_0102: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0107: ldarg.0
IL_0108: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_010d: ldnull
IL_010e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0113: brfalse.s IL_014d
IL_0115: ldarg.0
IL_0116: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_011b: ldstr "x"
IL_0120: ldloca.s V_0
IL_0122: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_0127: ldfld System.Single UnityEngine.Vector3::x
IL_012c: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0131: ldarg.0
IL_0132: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0137: ldstr "y"
IL_013c: ldloca.s V_0
IL_013e: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_0143: ldfld System.Single UnityEngine.Vector3::y
IL_0148: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_014d: ldarg.0
IL_014e: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_0153: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0158: stloc.1
IL_0159: br.s IL_018f
IL_015b: ldloca.s V_1
IL_015d: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_0162: dup
IL_0163: ldstr "x"
IL_0168: ldloca.s V_0
IL_016a: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_016f: ldfld System.Single UnityEngine.Vector3::x
IL_0174: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0179: ldstr "y"
IL_017e: ldloca.s V_0
IL_0180: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_0185: ldfld System.Single UnityEngine.Vector3::y
IL_018a: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_018f: ldloca.s V_1
IL_0191: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_0196: brtrue.s IL_015b
IL_0198: leave.s IL_01a8
IL_019a: ldloca.s V_1
IL_019c: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_01a2: callvirt System.Void System.IDisposable::Dispose()
IL_01a7: endfinally
IL_01a8: ldarg.0
IL_01a9: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_01ae: ldstr "x"
IL_01b3: ldloca.s V_0
IL_01b5: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_01ba: ldfld System.Single UnityEngine.Vector3::x
IL_01bf: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01c4: ldarg.0
IL_01c5: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_01ca: ldstr "y"
IL_01cf: ldloca.s V_0
IL_01d1: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_01d6: ldfld System.Single UnityEngine.Vector3::y
IL_01db: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01e0: ret
METHOD System.Void TheForestOfLove.Player::ToggleLanternWithoutTransition() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0007: ldc.i4.0
IL_0008: ceq
IL_000a: call System.Void TheForestOfLove.Player::set_lanternEquipped(System.Boolean)
IL_000f: ldarg.0
IL_0010: ldarg.0
IL_0011: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0016: call System.Void TheForestOfLove.Player::ToggleLanternWithoutTransition(System.Boolean)
IL_001b: ret
METHOD System.Void TheForestOfLove.Player::ToggleLanternWithoutTransition(System.Boolean) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void TheForestOfLove.Player::set_lanternEquipped(System.Boolean)
IL_0007: ldarg.0
IL_0008: ldc.i4.1
IL_0009: call System.Void TheForestOfLove.Player::set_lanternTransitioning(System.Boolean)
IL_000e: ldarg.0
IL_000f: call System.Void TheForestOfLove.Player::SwapLanternAnimator()
IL_0014: ldarg.0
IL_0015: ldstr "trigger_idle"
IL_001a: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_001f: ldarg.0
IL_0020: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_0025: ldstr "trigger_idle"
IL_002a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_002f: ldarg.0
IL_0030: ldc.i4.1
IL_0031: call System.Void TheForestOfLove.Player::Idle(System.Boolean)
IL_0036: ldarg.0
IL_0037: ldc.i4.0
IL_0038: call System.Void TheForestOfLove.Player::set_lanternTransitioning(System.Boolean)
IL_003d: ldarg.0
IL_003e: ldfld TheForestOfLove.SpriteRendererAlphaGroup TheForestOfLove.Player::lanternAlphaController
IL_0043: ldarg.1
IL_0044: ldc.i4.0
IL_0045: ceq
IL_0047: stfld System.Boolean TheForestOfLove.SpriteRendererAlphaGroup::transparent
IL_004c: ldarg.0
IL_004d: ldfld TheForestOfLove.SpriteRendererAlphaGroup TheForestOfLove.Player::lanternAlphaController
IL_0052: callvirt System.Void TheForestOfLove.SpriteRendererAlphaGroup::SnapToTargetValues()
IL_0057: ldarg.0
IL_0058: ldfld TheForestOfLove.SpriteRendererAlphaGroup TheForestOfLove.Player::lanternAlphaController
IL_005d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0062: ldc.i4.1
IL_0063: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0068: ldarg.1
IL_0069: brfalse.s IL_0076
IL_006b: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onLanternEquippedInstant
IL_0070: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0075: ret
IL_0076: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onLanternUnequippedInstant
IL_007b: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0080: ret
METHOD System.Void TheForestOfLove.Player::ToggleSweaterWithTransition() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.Player::set_sweaterTransitioning(System.Boolean)
IL_0007: ldarg.0
IL_0008: ldarg.0
IL_0009: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_000e: ldc.i4.0
IL_000f: ceq
IL_0011: call System.Void TheForestOfLove.Player::set_sweaterEquipped(System.Boolean)
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_001c: ldarg.0
IL_001d: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_0022: brtrue.s IL_002b
IL_0024: ldstr "trigger_sweater_unequip"
IL_0029: br.s IL_0030
IL_002b: ldstr "trigger_sweater_equip"
IL_0030: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0035: ldarg.0
IL_0036: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_003b: ldarg.0
IL_003c: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_0041: brtrue.s IL_004a
IL_0043: ldstr "trigger_sweater_unequip"
IL_0048: br.s IL_004f
IL_004a: ldstr "trigger_sweater_equip"
IL_004f: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0054: ldarg.0
IL_0055: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_005a: ldnull
IL_005b: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0060: brfalse.s IL_0081
IL_0062: ldarg.0
IL_0063: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0068: ldarg.0
IL_0069: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_006e: brtrue.s IL_0077
IL_0070: ldstr "trigger_sweater_unequip"
IL_0075: br.s IL_007c
IL_0077: ldstr "trigger_sweater_equip"
IL_007c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0081: ldarg.0
IL_0082: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0087: ldnull
IL_0088: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_008d: brfalse.s IL_00ae
IL_008f: ldarg.0
IL_0090: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0095: ldarg.0
IL_0096: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_009b: brtrue.s IL_00a4
IL_009d: ldstr "trigger_sweater_unequip"
IL_00a2: br.s IL_00a9
IL_00a4: ldstr "trigger_sweater_equip"
IL_00a9: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00ae: ldarg.0
IL_00af: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_00b4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_00b9: stloc.0
IL_00ba: br.s IL_00dc
IL_00bc: ldloca.s V_0
IL_00be: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_00c3: ldarg.0
IL_00c4: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_00c9: brtrue.s IL_00d2
IL_00cb: ldstr "trigger_sweater_unequip"
IL_00d0: br.s IL_00d7
IL_00d2: ldstr "trigger_sweater_equip"
IL_00d7: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00dc: ldloca.s V_0
IL_00de: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00e3: brtrue.s IL_00bc
IL_00e5: leave.s IL_00f5
IL_00e7: ldloca.s V_0
IL_00e9: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00ef: callvirt System.Void System.IDisposable::Dispose()
IL_00f4: endfinally
IL_00f5: ret
METHOD System.Void TheForestOfLove.Player::ToggleLanternWithTransition() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0007: ldc.i4.0
IL_0008: ceq
IL_000a: call System.Void TheForestOfLove.Player::ToggleLanternWithTransition(System.Boolean)
IL_000f: ret
METHOD System.Void TheForestOfLove.Player::ToggleLanternWithTransition(System.Boolean) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call System.Void TheForestOfLove.Player::set_lanternTransitioning(System.Boolean)
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: call System.Void TheForestOfLove.Player::set_lanternEquipped(System.Boolean)
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0014: ldarg.0
IL_0015: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_001a: brtrue.s IL_0023
IL_001c: ldstr "trigger_lantern_unequip"
IL_0021: br.s IL_0028
IL_0023: ldstr "trigger_lantern_equip"
IL_0028: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_002d: ldarg.0
IL_002e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0033: ldarg.0
IL_0034: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0039: brtrue.s IL_0042
IL_003b: ldstr "trigger_lantern_unequip"
IL_0040: br.s IL_0047
IL_0042: ldstr "trigger_lantern_equip"
IL_0047: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_004c: ldarg.0
IL_004d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0052: ldnull
IL_0053: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0058: brfalse.s IL_0079
IL_005a: ldarg.0
IL_005b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0060: ldarg.0
IL_0061: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0066: brtrue.s IL_006f
IL_0068: ldstr "trigger_lantern_unequip"
IL_006d: br.s IL_0074
IL_006f: ldstr "trigger_lantern_equip"
IL_0074: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0079: ldarg.0
IL_007a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_007f: ldnull
IL_0080: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0085: brfalse.s IL_00a6
IL_0087: ldarg.0
IL_0088: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_008d: ldarg.0
IL_008e: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0093: brtrue.s IL_009c
IL_0095: ldstr "trigger_lantern_unequip"
IL_009a: br.s IL_00a1
IL_009c: ldstr "trigger_lantern_equip"
IL_00a1: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a6: ldarg.0
IL_00a7: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_00ac: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_00b1: stloc.0
IL_00b2: br.s IL_00d4
IL_00b4: ldloca.s V_0
IL_00b6: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_00bb: ldarg.0
IL_00bc: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_00c1: brtrue.s IL_00ca
IL_00c3: ldstr "trigger_lantern_unequip"
IL_00c8: br.s IL_00cf
IL_00ca: ldstr "trigger_lantern_equip"
IL_00cf: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00d4: ldloca.s V_0
IL_00d6: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00db: brtrue.s IL_00b4
IL_00dd: leave.s IL_00ed
IL_00df: ldloca.s V_0
IL_00e1: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00e7: callvirt System.Void System.IDisposable::Dispose()
IL_00ec: endfinally
IL_00ed: ldarg.0
IL_00ee: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_00f3: ldstr "has_lantern_equipped"
IL_00f8: ldarg.0
IL_00f9: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_00fe: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0103: ldarg.0
IL_0104: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0109: ldstr "has_lantern_equipped"
IL_010e: ldarg.0
IL_010f: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0114: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0119: ldarg.0
IL_011a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_011f: ldnull
IL_0120: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0125: brfalse.s IL_013d
IL_0127: ldarg.0
IL_0128: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_012d: ldstr "has_lantern_equipped"
IL_0132: ldarg.0
IL_0133: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0138: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_013d: ldarg.1
IL_013e: brfalse.s IL_0159
IL_0140: ldarg.0
IL_0141: ldfld System.Single TheForestOfLove.Player::lanternAlphaDelayEquip
IL_0146: ldarg.0
IL_0147: ldftn System.Void TheForestOfLove.Player::<ToggleLanternWithTransition>b__209_0()
IL_014d: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0152: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0157: br.s IL_0170
IL_0159: ldarg.0
IL_015a: ldfld System.Single TheForestOfLove.Player::lanternAlphaDelayUnequip
IL_015f: ldarg.0
IL_0160: ldftn System.Void TheForestOfLove.Player::<ToggleLanternWithTransition>b__209_1()
IL_0166: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_016b: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0170: ldarg.0
IL_0171: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_0176: ldstr "trigger_idle"
IL_017b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0180: ldarg.1
IL_0181: brfalse.s IL_018e
IL_0183: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onLanternEquippedSmooth
IL_0188: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_018d: ret
IL_018e: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onLanternUnequippedSmooth
IL_0193: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0198: ret
METHOD System.Void TheForestOfLove.Player::SleepIntroForest() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0010: ldarg.0
IL_0011: ldc.i4.0
IL_0012: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_0017: ldc.i4.0
IL_0018: call System.Void TheForestOfLove.Audio.SoundManager::PlayFootstepSound(TheForestOfLove.TerrainType)
IL_001d: ldarg.0
IL_001e: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_0023: ldstr "trigger_sleep_introforest"
IL_0028: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_002d: brfalse IL_00e1
IL_0032: ldarg.0
IL_0033: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0038: ldstr "trigger_sleep_introforest"
IL_003d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0042: ldarg.0
IL_0043: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0048: ldstr "trigger_sleep_introforest"
IL_004d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0052: ldarg.0
IL_0053: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0058: ldnull
IL_0059: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_005e: brfalse.s IL_0070
IL_0060: ldarg.0
IL_0061: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0066: ldstr "trigger_sleep_introforest"
IL_006b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0070: ldarg.0
IL_0071: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0076: ldnull
IL_0077: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_007c: brfalse.s IL_008e
IL_007e: ldarg.0
IL_007f: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0084: ldstr "trigger_sleep_introforest"
IL_0089: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_008e: ldarg.0
IL_008f: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_0094: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0099: stloc.0
IL_009a: br.s IL_00ad
IL_009c: ldloca.s V_0
IL_009e: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_00a3: ldstr "trigger_sleep_introforest"
IL_00a8: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00ad: ldloca.s V_0
IL_00af: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00b4: brtrue.s IL_009c
IL_00b6: leave.s IL_00c6
IL_00b8: ldloca.s V_0
IL_00ba: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00c0: callvirt System.Void System.IDisposable::Dispose()
IL_00c5: endfinally
IL_00c6: ldarg.0
IL_00c7: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00cc: ldstr "trigger_sleep_introforest"
IL_00d1: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00d6: ldarg.0
IL_00d7: ldstr "trigger_sleep_introforest"
IL_00dc: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00e1: ret
METHOD System.Void TheForestOfLove.Player::Sleep() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldc.i4.0
IL_000b: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0010: ldarg.0
IL_0011: ldc.i4.0
IL_0012: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_0017: ldarg.0
IL_0018: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_001d: ldstr "trigger_sleep"
IL_0022: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0027: brfalse IL_00db
IL_002c: ldarg.0
IL_002d: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0032: ldstr "trigger_sleep"
IL_0037: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0042: ldstr "trigger_sleep"
IL_0047: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_004c: ldarg.0
IL_004d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0052: ldnull
IL_0053: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0058: brfalse.s IL_006a
IL_005a: ldarg.0
IL_005b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0060: ldstr "trigger_sleep"
IL_0065: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006a: ldarg.0
IL_006b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0070: ldnull
IL_0071: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0076: brfalse.s IL_0088
IL_0078: ldarg.0
IL_0079: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_007e: ldstr "trigger_sleep"
IL_0083: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0088: ldarg.0
IL_0089: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_008e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0093: stloc.0
IL_0094: br.s IL_00a7
IL_0096: ldloca.s V_0
IL_0098: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_009d: ldstr "trigger_sleep"
IL_00a2: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a7: ldloca.s V_0
IL_00a9: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00ae: brtrue.s IL_0096
IL_00b0: leave.s IL_00c0
IL_00b2: ldloca.s V_0
IL_00b4: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00ba: callvirt System.Void System.IDisposable::Dispose()
IL_00bf: endfinally
IL_00c0: ldarg.0
IL_00c1: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00c6: ldstr "trigger_sleep"
IL_00cb: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00d0: ldarg.0
IL_00d1: ldstr "trigger_sleep"
IL_00d6: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00db: ret
METHOD System.Void TheForestOfLove.Player::Wakeup() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0007: ldarg.0
IL_0008: ldc.i4.0
IL_0009: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_000e: ldarg.0
IL_000f: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_0014: ldstr "trigger_wakeup"
IL_0019: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_001e: brfalse IL_00d2
IL_0023: ldarg.0
IL_0024: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0029: ldstr "trigger_wakeup"
IL_002e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0033: ldarg.0
IL_0034: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0039: ldstr "trigger_wakeup"
IL_003e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0043: ldarg.0
IL_0044: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0049: ldnull
IL_004a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_004f: brfalse.s IL_0061
IL_0051: ldarg.0
IL_0052: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0057: ldstr "trigger_wakeup"
IL_005c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0061: ldarg.0
IL_0062: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0067: ldnull
IL_0068: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_006d: brfalse.s IL_007f
IL_006f: ldarg.0
IL_0070: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0075: ldstr "trigger_wakeup"
IL_007a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_007f: ldarg.0
IL_0080: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_0085: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_008a: stloc.0
IL_008b: br.s IL_009e
IL_008d: ldloca.s V_0
IL_008f: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_0094: ldstr "trigger_wakeup"
IL_0099: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_009e: ldloca.s V_0
IL_00a0: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00a5: brtrue.s IL_008d
IL_00a7: leave.s IL_00b7
IL_00a9: ldloca.s V_0
IL_00ab: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00b1: callvirt System.Void System.IDisposable::Dispose()
IL_00b6: endfinally
IL_00b7: ldarg.0
IL_00b8: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00bd: ldstr "trigger_wakeup"
IL_00c2: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00c7: ldarg.0
IL_00c8: ldstr "trigger_wakeup"
IL_00cd: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00d2: ret
METHOD System.Void TheForestOfLove.Player::Rest() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0006: ldc.i4.3
IL_0007: bne.un.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.0
IL_000c: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0011: ldarg.0
IL_0012: ldc.i4.3
IL_0013: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_0018: ldarg.0
IL_0019: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_001e: ldstr "trigger_rest"
IL_0023: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0028: brfalse IL_00dc
IL_002d: ldarg.0
IL_002e: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0033: ldstr "trigger_rest"
IL_0038: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_003d: ldarg.0
IL_003e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0043: ldstr "trigger_rest"
IL_0048: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_004d: ldarg.0
IL_004e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0053: ldnull
IL_0054: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0059: brfalse.s IL_006b
IL_005b: ldarg.0
IL_005c: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0061: ldstr "trigger_rest"
IL_0066: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006b: ldarg.0
IL_006c: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0071: ldnull
IL_0072: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0077: brfalse.s IL_0089
IL_0079: ldarg.0
IL_007a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_007f: ldstr "trigger_rest"
IL_0084: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0089: ldarg.0
IL_008a: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_008f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0094: stloc.0
IL_0095: br.s IL_00a8
IL_0097: ldloca.s V_0
IL_0099: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_009e: ldstr "trigger_rest"
IL_00a3: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a8: ldloca.s V_0
IL_00aa: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00af: brtrue.s IL_0097
IL_00b1: leave.s IL_00c1
IL_00b3: ldloca.s V_0
IL_00b5: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00bb: callvirt System.Void System.IDisposable::Dispose()
IL_00c0: endfinally
IL_00c1: ldarg.0
IL_00c2: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00c7: ldstr "trigger_rest"
IL_00cc: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00d1: ldarg.0
IL_00d2: ldstr "trigger_rest"
IL_00d7: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00dc: ret
METHOD System.Void TheForestOfLove.Player::RestInstantly() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0006: ldc.i4.3
IL_0007: bne.un.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.0
IL_000c: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0011: ldarg.0
IL_0012: ldc.i4.3
IL_0013: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_0018: ldarg.0
IL_0019: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_001e: ldstr "trigger_rest_instantly"
IL_0023: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0028: brfalse IL_00dc
IL_002d: ldarg.0
IL_002e: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0033: ldstr "trigger_rest_instantly"
IL_0038: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_003d: ldarg.0
IL_003e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0043: ldstr "trigger_rest_instantly"
IL_0048: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_004d: ldarg.0
IL_004e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0053: ldnull
IL_0054: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0059: brfalse.s IL_006b
IL_005b: ldarg.0
IL_005c: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0061: ldstr "trigger_rest_instantly"
IL_0066: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006b: ldarg.0
IL_006c: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0071: ldnull
IL_0072: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0077: brfalse.s IL_0089
IL_0079: ldarg.0
IL_007a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_007f: ldstr "trigger_rest_instantly"
IL_0084: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0089: ldarg.0
IL_008a: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_008f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0094: stloc.0
IL_0095: br.s IL_00a8
IL_0097: ldloca.s V_0
IL_0099: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_009e: ldstr "trigger_rest_instantly"
IL_00a3: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a8: ldloca.s V_0
IL_00aa: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00af: brtrue.s IL_0097
IL_00b1: leave.s IL_00c1
IL_00b3: ldloca.s V_0
IL_00b5: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00bb: callvirt System.Void System.IDisposable::Dispose()
IL_00c0: endfinally
IL_00c1: ldarg.0
IL_00c2: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00c7: ldstr "trigger_rest_instantly"
IL_00cc: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00d1: ldarg.0
IL_00d2: ldstr "trigger_rest_instantly"
IL_00d7: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00dc: ret
METHOD System.Void TheForestOfLove.Player::Idle() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.0
IL_0002: call System.Void TheForestOfLove.Player::Idle(System.Boolean)
IL_0007: ret
METHOD System.Void TheForestOfLove.Player::Idle(System.Boolean) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0006: ldc.i4.1
IL_0007: bne.un.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Boolean TheForestOfLove.Player::enableMovement
IL_0010: ldarg.1
IL_0011: or
IL_0012: brfalse IL_00fd
IL_0017: ldarg.0
IL_0018: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_001d: ldarg.0
IL_001e: ldfld UnityEngine.Vector3 TheForestOfLove.Player::lastNonzeroXAxisInput
IL_0023: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(UnityEngine.Vector3)
IL_0028: ldarg.0
IL_0029: ldc.i4.0
IL_002a: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_002f: ldarg.0
IL_0030: ldc.i4.1
IL_0031: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_0036: ldarg.1
IL_0037: brtrue.s IL_004e
IL_0039: ldarg.0
IL_003a: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_003f: ldstr "trigger_idle"
IL_0044: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0049: brfalse IL_00fd
IL_004e: ldarg.0
IL_004f: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0054: ldstr "trigger_idle"
IL_0059: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_005e: ldarg.0
IL_005f: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0064: ldstr "trigger_idle"
IL_0069: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006e: ldarg.0
IL_006f: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0074: ldnull
IL_0075: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_007a: brfalse.s IL_008c
IL_007c: ldarg.0
IL_007d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0082: ldstr "trigger_idle"
IL_0087: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_008c: ldarg.0
IL_008d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0092: ldnull
IL_0093: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0098: brfalse.s IL_00aa
IL_009a: ldarg.0
IL_009b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_00a0: ldstr "trigger_idle"
IL_00a5: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00aa: ldarg.0
IL_00ab: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_00b0: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_00b5: stloc.0
IL_00b6: br.s IL_00c9
IL_00b8: ldloca.s V_0
IL_00ba: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_00bf: ldstr "trigger_idle"
IL_00c4: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00c9: ldloca.s V_0
IL_00cb: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00d0: brtrue.s IL_00b8
IL_00d2: leave.s IL_00e2
IL_00d4: ldloca.s V_0
IL_00d6: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00dc: callvirt System.Void System.IDisposable::Dispose()
IL_00e1: endfinally
IL_00e2: ldarg.0
IL_00e3: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00e8: ldstr "trigger_idle"
IL_00ed: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00f2: ldarg.0
IL_00f3: ldstr "trigger_idle"
IL_00f8: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00fd: ret
METHOD System.Void TheForestOfLove.Player::IdleBrace() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0006: ldc.i4.6
IL_0007: bne.un.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.0
IL_000c: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0011: ldarg.0
IL_0012: ldc.i4.6
IL_0013: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_0018: ldarg.0
IL_0019: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_001e: ldstr "trigger_idle_brace"
IL_0023: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0028: brfalse IL_00dc
IL_002d: ldarg.0
IL_002e: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0033: ldstr "trigger_idle_brace"
IL_0038: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_003d: ldarg.0
IL_003e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0043: ldstr "trigger_idle_brace"
IL_0048: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_004d: ldarg.0
IL_004e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0053: ldnull
IL_0054: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0059: brfalse.s IL_006b
IL_005b: ldarg.0
IL_005c: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0061: ldstr "trigger_idle_brace"
IL_0066: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_006b: ldarg.0
IL_006c: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0071: ldnull
IL_0072: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0077: brfalse.s IL_0089
IL_0079: ldarg.0
IL_007a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_007f: ldstr "trigger_idle_brace"
IL_0084: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0089: ldarg.0
IL_008a: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_008f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0094: stloc.0
IL_0095: br.s IL_00a8
IL_0097: ldloca.s V_0
IL_0099: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_009e: ldstr "trigger_idle_brace"
IL_00a3: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a8: ldloca.s V_0
IL_00aa: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00af: brtrue.s IL_0097
IL_00b1: leave.s IL_00c1
IL_00b3: ldloca.s V_0
IL_00b5: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00bb: callvirt System.Void System.IDisposable::Dispose()
IL_00c0: endfinally
IL_00c1: ldarg.0
IL_00c2: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00c7: ldstr "trigger_idle_brace"
IL_00cc: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00d1: ldarg.0
IL_00d2: ldstr "trigger_idle_brace"
IL_00d7: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00dc: ret
METHOD System.Void TheForestOfLove.Player::Bellring() | attributes=Public, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inPlainsEnd()
IL_0005: brfalse IL_00a1
IL_000a: ldarg.0
IL_000b: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0010: ldstr "trigger_bellring_redbell"
IL_0015: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_001a: ldarg.0
IL_001b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0020: ldstr "trigger_bellring_redbell"
IL_0025: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_002a: ldarg.0
IL_002b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0030: ldnull
IL_0031: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0036: brfalse.s IL_0048
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_003e: ldstr "trigger_bellring_redbell"
IL_0043: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0048: ldarg.0
IL_0049: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_004e: ldnull
IL_004f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0054: brfalse.s IL_0066
IL_0056: ldarg.0
IL_0057: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_005c: ldstr "trigger_bellring_redbell"
IL_0061: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0066: ldarg.0
IL_0067: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_006c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0071: stloc.0
IL_0072: br.s IL_0085
IL_0074: ldloca.s V_0
IL_0076: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_007b: ldstr "trigger_bellring_redbell"
IL_0080: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0085: ldloca.s V_0
IL_0087: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_008c: brtrue.s IL_0074
IL_008e: leave IL_0277
IL_0093: ldloca.s V_0
IL_0095: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_009b: callvirt System.Void System.IDisposable::Dispose()
IL_00a0: endfinally
IL_00a1: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inCentralForest()
IL_00a6: brfalse IL_0142
IL_00ab: ldarg.0
IL_00ac: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_00b1: ldstr "trigger_bellring_greenbell"
IL_00b6: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00bb: ldarg.0
IL_00bc: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_00c1: ldstr "trigger_bellring_greenbell"
IL_00c6: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00cb: ldarg.0
IL_00cc: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_00d1: ldnull
IL_00d2: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00d7: brfalse.s IL_00e9
IL_00d9: ldarg.0
IL_00da: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_00df: ldstr "trigger_bellring_greenbell"
IL_00e4: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00e9: ldarg.0
IL_00ea: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_00ef: ldnull
IL_00f0: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00f5: brfalse.s IL_0107
IL_00f7: ldarg.0
IL_00f8: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_00fd: ldstr "trigger_bellring_greenbell"
IL_0102: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0107: ldarg.0
IL_0108: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_010d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0112: stloc.0
IL_0113: br.s IL_0126
IL_0115: ldloca.s V_0
IL_0117: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_011c: ldstr "trigger_bellring_greenbell"
IL_0121: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0126: ldloca.s V_0
IL_0128: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_012d: brtrue.s IL_0115
IL_012f: leave IL_0277
IL_0134: ldloca.s V_0
IL_0136: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_013c: callvirt System.Void System.IDisposable::Dispose()
IL_0141: endfinally
IL_0142: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inMountains()
IL_0147: brfalse IL_01e3
IL_014c: ldarg.0
IL_014d: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0152: ldstr "trigger_bellring_purplebell"
IL_0157: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_015c: ldarg.0
IL_015d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0162: ldstr "trigger_bellring_purplebell"
IL_0167: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_016c: ldarg.0
IL_016d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0172: ldnull
IL_0173: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0178: brfalse.s IL_018a
IL_017a: ldarg.0
IL_017b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0180: ldstr "trigger_bellring_purplebell"
IL_0185: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_018a: ldarg.0
IL_018b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0190: ldnull
IL_0191: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0196: brfalse.s IL_01a8
IL_0198: ldarg.0
IL_0199: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_019e: ldstr "trigger_bellring_purplebell"
IL_01a3: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_01a8: ldarg.0
IL_01a9: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_01ae: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_01b3: stloc.0
IL_01b4: br.s IL_01c7
IL_01b6: ldloca.s V_0
IL_01b8: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_01bd: ldstr "trigger_bellring_purplebell"
IL_01c2: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_01c7: ldloca.s V_0
IL_01c9: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_01ce: brtrue.s IL_01b6
IL_01d0: leave IL_0277
IL_01d5: ldloca.s V_0
IL_01d7: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_01dd: callvirt System.Void System.IDisposable::Dispose()
IL_01e2: endfinally
IL_01e3: ldarg.0
IL_01e4: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01e9: ldstr "trigger_bellring"
IL_01ee: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_01f3: ldarg.0
IL_01f4: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_01f9: ldstr "trigger_bellring"
IL_01fe: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0203: ldarg.0
IL_0204: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0209: ldnull
IL_020a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_020f: brfalse.s IL_0221
IL_0211: ldarg.0
IL_0212: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0217: ldstr "trigger_bellring"
IL_021c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0221: ldarg.0
IL_0222: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0227: ldnull
IL_0228: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_022d: brfalse.s IL_023f
IL_022f: ldarg.0
IL_0230: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0235: ldstr "trigger_bellring"
IL_023a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_023f: ldarg.0
IL_0240: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_0245: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_024a: stloc.0
IL_024b: br.s IL_025e
IL_024d: ldloca.s V_0
IL_024f: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_0254: ldstr "trigger_bellring"
IL_0259: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_025e: ldloca.s V_0
IL_0260: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_0265: brtrue.s IL_024d
IL_0267: leave.s IL_0277
IL_0269: ldloca.s V_0
IL_026b: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_0271: callvirt System.Void System.IDisposable::Dispose()
IL_0276: endfinally
IL_0277: ldarg.0
IL_0278: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_027d: ldstr "trigger_bellring"
IL_0282: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0287: ldarg.0
IL_0288: ldstr "trigger_bellring"
IL_028d: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_0292: ret
METHOD System.Void TheForestOfLove.Player::Swim() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_0006: ldc.i4.4
IL_0007: bne.un.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.Vector3 TheForestOfLove.Player::lastNonzeroXAxisInput
IL_0016: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(UnityEngine.Vector3)
IL_001b: ldarg.0
IL_001c: ldc.i4.0
IL_001d: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0022: ldarg.0
IL_0023: ldc.i4.4
IL_0024: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_0029: ldarg.0
IL_002a: ldc.r4 0
IL_002f: stfld System.Single TheForestOfLove.Player::swimIdleTime
IL_0034: ldarg.0
IL_0035: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_003a: ldstr "trigger_swimming"
IL_003f: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0044: brfalse IL_00f8
IL_0049: ldarg.0
IL_004a: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_004f: ldstr "trigger_swimming"
IL_0054: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0059: ldarg.0
IL_005a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_005f: ldstr "trigger_swimming"
IL_0064: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0069: ldarg.0
IL_006a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_006f: ldnull
IL_0070: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0075: brfalse.s IL_0087
IL_0077: ldarg.0
IL_0078: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_007d: ldstr "trigger_swimming"
IL_0082: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0087: ldarg.0
IL_0088: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_008d: ldnull
IL_008e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0093: brfalse.s IL_00a5
IL_0095: ldarg.0
IL_0096: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_009b: ldstr "trigger_swimming"
IL_00a0: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a5: ldarg.0
IL_00a6: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_00ab: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_00b0: stloc.0
IL_00b1: br.s IL_00c4
IL_00b3: ldloca.s V_0
IL_00b5: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_00ba: ldstr "trigger_swimming"
IL_00bf: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00c4: ldloca.s V_0
IL_00c6: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00cb: brtrue.s IL_00b3
IL_00cd: leave.s IL_00dd
IL_00cf: ldloca.s V_0
IL_00d1: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00d7: callvirt System.Void System.IDisposable::Dispose()
IL_00dc: endfinally
IL_00dd: ldarg.0
IL_00de: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00e3: ldstr "trigger_swimming"
IL_00e8: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00ed: ldarg.0
IL_00ee: ldstr "trigger_swimming"
IL_00f3: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00f8: ldarg.0
IL_00f9: ldc.r4 0
IL_00fe: stfld System.Single TheForestOfLove.Player::superStrokeCooldownTimeRemaining
IL_0103: ldarg.0
IL_0104: ldc.i4.0
IL_0105: stfld System.Int32 TheForestOfLove.Player::currentUsedSuperStrokes
IL_010a: ldarg.0
IL_010b: ldc.i4.1
IL_010c: stfld System.Boolean TheForestOfLove.Player::swimmingReadyForNewStrokeSound
IL_0111: ldc.i4 1100
IL_0116: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_011b: ret
METHOD System.Void TheForestOfLove.Player::SwimIdle() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_0006: ldstr "trigger_swim_idle"
IL_000b: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0010: brfalse IL_00c4
IL_0015: ldarg.0
IL_0016: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_001b: ldstr "trigger_swim_idle"
IL_0020: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0025: ldarg.0
IL_0026: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_002b: ldstr "trigger_swim_idle"
IL_0030: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0035: ldarg.0
IL_0036: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_003b: ldnull
IL_003c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0041: brfalse.s IL_0053
IL_0043: ldarg.0
IL_0044: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0049: ldstr "trigger_swim_idle"
IL_004e: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0053: ldarg.0
IL_0054: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0059: ldnull
IL_005a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_005f: brfalse.s IL_0071
IL_0061: ldarg.0
IL_0062: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0067: ldstr "trigger_swim_idle"
IL_006c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0071: ldarg.0
IL_0072: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_0077: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_007c: stloc.0
IL_007d: br.s IL_0090
IL_007f: ldloca.s V_0
IL_0081: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_0086: ldstr "trigger_swim_idle"
IL_008b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0090: ldloca.s V_0
IL_0092: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_0097: brtrue.s IL_007f
IL_0099: leave.s IL_00a9
IL_009b: ldloca.s V_0
IL_009d: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00a3: callvirt System.Void System.IDisposable::Dispose()
IL_00a8: endfinally
IL_00a9: ldarg.0
IL_00aa: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00af: ldstr "trigger_swim_idle"
IL_00b4: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00b9: ldarg.0
IL_00ba: ldstr "trigger_swim_idle"
IL_00bf: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00c4: ret
METHOD System.Void TheForestOfLove.Player::Walk(UnityEngine.Vector3) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarga.s input
IL_0002: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0007: ldc.r4 0
IL_000c: bne.un.s IL_000f
IL_000e: ret
IL_000f: ldarg.0
IL_0010: ldc.i4.1
IL_0011: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0016: ldarg.0
IL_0017: ldc.i4.2
IL_0018: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_001d: ldarga.s input
IL_001f: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_0024: stloc.0
IL_0025: ldloc.0
IL_0026: ldfld System.Single UnityEngine.Vector3::x
IL_002b: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0030: ldc.r4 0
IL_0035: ble.un.s IL_004b
IL_0037: ldloc.0
IL_0038: ldfld System.Single UnityEngine.Vector3::y
IL_003d: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0042: ldc.r4 0
IL_0047: cgt
IL_0049: br.s IL_004c
IL_004b: ldc.i4.0
IL_004c: brfalse IL_00ef
IL_0051: ldarg.0
IL_0052: ldflda UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
IL_0057: ldfld System.Single UnityEngine.Vector2::x
IL_005c: ldc.r4 1
IL_0061: bne.un.s IL_00aa
IL_0063: ldloca.s V_0
IL_0065: ldc.r4 0
IL_006a: stfld System.Single UnityEngine.Vector3::y
IL_006f: ldarg.1
IL_0070: ldfld System.Single UnityEngine.Vector3::x
IL_0075: ldarg.1
IL_0076: ldfld System.Single UnityEngine.Vector3::x
IL_007b: call System.Single UnityEngine.Mathf::Sign(System.Single)
IL_0080: ldarg.1
IL_0081: ldfld System.Single UnityEngine.Vector3::y
IL_0086: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_008b: mul
IL_008c: ldarg.0
IL_008d: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_0092: mul
IL_0093: add
IL_0094: ldarg.1
IL_0095: ldfld System.Single UnityEngine.Vector3::y
IL_009a: ldarg.0
IL_009b: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_00a0: mul
IL_00a1: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_00a6: starg.s input
IL_00a8: br.s IL_00ef
IL_00aa: ldloca.s V_0
IL_00ac: ldc.r4 0
IL_00b1: stfld System.Single UnityEngine.Vector3::x
IL_00b6: ldarg.1
IL_00b7: ldfld System.Single UnityEngine.Vector3::x
IL_00bc: ldarg.0
IL_00bd: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_00c2: mul
IL_00c3: ldarg.1
IL_00c4: ldfld System.Single UnityEngine.Vector3::y
IL_00c9: ldarg.1
IL_00ca: ldfld System.Single UnityEngine.Vector3::y
IL_00cf: call System.Single UnityEngine.Mathf::Sign(System.Single)
IL_00d4: ldarg.1
IL_00d5: ldfld System.Single UnityEngine.Vector3::x
IL_00da: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_00df: mul
IL_00e0: ldarg.0
IL_00e1: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_00e6: mul
IL_00e7: add
IL_00e8: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_00ed: starg.s input
IL_00ef: ldarga.s input
IL_00f1: call System.Void UnityEngine.Vector3::Normalize()
IL_00f6: ldarg.0
IL_00f7: ldfld System.Boolean TheForestOfLove.Player::flipAnimatorVectorY
IL_00fc: brfalse.s IL_010c
IL_00fe: ldloca.s V_0
IL_0100: ldloc.0
IL_0101: ldfld System.Single UnityEngine.Vector3::y
IL_0106: neg
IL_0107: stfld System.Single UnityEngine.Vector3::y
IL_010c: ldarg.0
IL_010d: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_0112: ldstr "trigger_walk"
IL_0117: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_011c: brfalse IL_01d0
IL_0121: ldarg.0
IL_0122: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0127: ldstr "trigger_walk"
IL_012c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0131: ldarg.0
IL_0132: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0137: ldstr "trigger_walk"
IL_013c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0141: ldarg.0
IL_0142: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0147: ldnull
IL_0148: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_014d: brfalse.s IL_015f
IL_014f: ldarg.0
IL_0150: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0155: ldstr "trigger_walk"
IL_015a: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_015f: ldarg.0
IL_0160: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0165: ldnull
IL_0166: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_016b: brfalse.s IL_017d
IL_016d: ldarg.0
IL_016e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0173: ldstr "trigger_walk"
IL_0178: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_017d: ldarg.0
IL_017e: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_0183: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0188: stloc.3
IL_0189: br.s IL_019c
IL_018b: ldloca.s V_3
IL_018d: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_0192: ldstr "trigger_walk"
IL_0197: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_019c: ldloca.s V_3
IL_019e: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_01a3: brtrue.s IL_018b
IL_01a5: leave.s IL_01b5
IL_01a7: ldloca.s V_3
IL_01a9: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_01af: callvirt System.Void System.IDisposable::Dispose()
IL_01b4: endfinally
IL_01b5: ldarg.0
IL_01b6: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_01bb: ldstr "trigger_walk"
IL_01c0: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_01c5: ldarg.0
IL_01c6: ldstr "trigger_walk"
IL_01cb: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_01d0: ldarg.0
IL_01d1: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01d6: ldstr "x"
IL_01db: ldloc.0
IL_01dc: ldfld System.Single UnityEngine.Vector3::x
IL_01e1: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01e6: ldarg.0
IL_01e7: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01ec: ldstr "y"
IL_01f1: ldloc.0
IL_01f2: ldfld System.Single UnityEngine.Vector3::y
IL_01f7: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01fc: ldarg.0
IL_01fd: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0202: ldstr "x"
IL_0207: ldloc.0
IL_0208: ldfld System.Single UnityEngine.Vector3::x
IL_020d: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0212: ldarg.0
IL_0213: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0218: ldstr "y"
IL_021d: ldloc.0
IL_021e: ldfld System.Single UnityEngine.Vector3::y
IL_0223: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0228: ldarg.0
IL_0229: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_022e: ldnull
IL_022f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0234: brfalse.s IL_0262
IL_0236: ldarg.0
IL_0237: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_023c: ldstr "x"
IL_0241: ldloc.0
IL_0242: ldfld System.Single UnityEngine.Vector3::x
IL_0247: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_024c: ldarg.0
IL_024d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0252: ldstr "y"
IL_0257: ldloc.0
IL_0258: ldfld System.Single UnityEngine.Vector3::y
IL_025d: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0262: ldarg.0
IL_0263: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0268: ldnull
IL_0269: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_026e: brfalse.s IL_029c
IL_0270: ldarg.0
IL_0271: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0276: ldstr "x"
IL_027b: ldloc.0
IL_027c: ldfld System.Single UnityEngine.Vector3::x
IL_0281: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0286: ldarg.0
IL_0287: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_028c: ldstr "y"
IL_0291: ldloc.0
IL_0292: ldfld System.Single UnityEngine.Vector3::y
IL_0297: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_029c: ldarg.0
IL_029d: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_02a2: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_02a7: stloc.3
IL_02a8: br.s IL_02d2
IL_02aa: ldloca.s V_3
IL_02ac: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_02b1: dup
IL_02b2: ldstr "x"
IL_02b7: ldloc.0
IL_02b8: ldfld System.Single UnityEngine.Vector3::x
IL_02bd: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02c2: ldstr "y"
IL_02c7: ldloc.0
IL_02c8: ldfld System.Single UnityEngine.Vector3::y
IL_02cd: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02d2: ldloca.s V_3
IL_02d4: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_02d9: brtrue.s IL_02aa
IL_02db: leave.s IL_02eb
IL_02dd: ldloca.s V_3
IL_02df: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_02e5: callvirt System.Void System.IDisposable::Dispose()
IL_02ea: endfinally
IL_02eb: ldarg.0
IL_02ec: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_02f1: ldstr "x"
IL_02f6: ldloc.0
IL_02f7: ldfld System.Single UnityEngine.Vector3::x
IL_02fc: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0301: ldarg.0
IL_0302: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_0307: ldstr "y"
IL_030c: ldloc.0
IL_030d: ldfld System.Single UnityEngine.Vector3::y
IL_0312: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0317: ldloc.0
IL_0318: ldfld System.Single UnityEngine.Vector3::x
IL_031d: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0322: ldloc.0
IL_0323: ldfld System.Single UnityEngine.Vector3::y
IL_0328: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_032d: ble.un.s IL_0348
IL_032f: ldarg.0
IL_0330: ldloc.0
IL_0331: ldfld System.Single UnityEngine.Vector3::x
IL_0336: ldc.r4 0
IL_033b: bge.s IL_0340
IL_033d: ldc.i4.3
IL_033e: br.s IL_0341
IL_0340: ldc.i4.1
IL_0341: stfld TheForestOfLove.Direction TheForestOfLove.Player::animatorDirection
IL_0346: br.s IL_035f
IL_0348: ldarg.0
IL_0349: ldloc.0
IL_034a: ldfld System.Single UnityEngine.Vector3::y
IL_034f: ldc.r4 0
IL_0354: bge.s IL_0359
IL_0356: ldc.i4.0
IL_0357: br.s IL_035a
IL_0359: ldc.i4.2
IL_035a: stfld TheForestOfLove.Direction TheForestOfLove.Player::animatorDirection
IL_035f: ldloca.s V_1
IL_0361: ldarg.0
IL_0362: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0367: ldfld System.Single UnityEngine.Vector2::x
IL_036c: ldarg.1
IL_036d: ldfld System.Single UnityEngine.Vector3::x
IL_0372: mul
IL_0373: ldarg.0
IL_0374: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0379: ldfld System.Single UnityEngine.Vector2::y
IL_037e: ldarg.1
IL_037f: ldfld System.Single UnityEngine.Vector3::y
IL_0384: mul
IL_0385: ldc.r4 0
IL_038a: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_038f: ldc.i4.0
IL_0390: stloc.2
IL_0391: ldarg.0
IL_0392: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0397: callvirt System.Boolean TheForestOfLove.WaypointController::get_HasWaypoints()
IL_039c: brfalse IL_051f
IL_03a1: ldarg.0
IL_03a2: call TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_03a7: callvirt UnityEngine.Vector3 TheForestOfLove.WaypointController::get_currentWaypointPosition()
IL_03ac: ldarg.0
IL_03ad: call UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBasePosition()
IL_03b2: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_03b7: stloc.s V_4
IL_03b9: ldloc.s V_4
IL_03bb: ldfld System.Single UnityEngine.Vector3::x
IL_03c0: ldc.r4 1E-45
IL_03c5: ble.un IL_0467
IL_03ca: ldloc.s V_4
IL_03cc: ldfld System.Single UnityEngine.Vector3::x
IL_03d1: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_03d6: ldarg.0
IL_03d7: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_03dc: ldfld System.Single UnityEngine.Vector2::x
IL_03e1: call System.Single UnityEngine.Time::get_deltaTime()
IL_03e6: mul
IL_03e7: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_03ec: bge.un.s IL_0467
IL_03ee: ldloca.s V_1
IL_03f0: ldc.r4 0
IL_03f5: stfld System.Single UnityEngine.Vector3::x
IL_03fa: ldarg.0
IL_03fb: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0400: ldarg.0
IL_0401: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0406: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_040b: ldfld System.Single UnityEngine.Vector3::x
IL_0410: ldloc.s V_4
IL_0412: ldfld System.Single UnityEngine.Vector3::x
IL_0417: add
IL_0418: ldarg.0
IL_0419: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_041e: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0423: ldfld System.Single UnityEngine.Vector3::y
IL_0428: ldarg.0
IL_0429: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_042e: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0433: ldfld System.Single UnityEngine.Vector3::z
IL_0438: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_043d: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0442: ldc.i4.1
IL_0443: brfalse.s IL_0467
IL_0445: ldarg.1
IL_0446: ldfld System.Single UnityEngine.Vector3::x
IL_044b: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0450: ldc.r4 0
IL_0455: ble.un.s IL_0467
IL_0457: ldarga.s input
IL_0459: ldloc.s V_4
IL_045b: ldfld System.Single UnityEngine.Vector3::x
IL_0460: stfld System.Single UnityEngine.Vector3::x
IL_0465: ldc.i4.1
IL_0466: stloc.2
IL_0467: ldloc.s V_4
IL_0469: ldfld System.Single UnityEngine.Vector3::y
IL_046e: ldc.r4 1E-45
IL_0473: ble.un IL_0515
IL_0478: ldloc.s V_4
IL_047a: ldfld System.Single UnityEngine.Vector3::y
IL_047f: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0484: ldarg.0
IL_0485: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_048a: ldfld System.Single UnityEngine.Vector2::y
IL_048f: call System.Single UnityEngine.Time::get_deltaTime()
IL_0494: mul
IL_0495: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_049a: bge.un.s IL_0515
IL_049c: ldloca.s V_1
IL_049e: ldc.r4 0
IL_04a3: stfld System.Single UnityEngine.Vector3::y
IL_04a8: ldarg.0
IL_04a9: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04ae: ldarg.0
IL_04af: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04b4: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_04b9: ldfld System.Single UnityEngine.Vector3::x
IL_04be: ldarg.0
IL_04bf: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04c4: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_04c9: ldfld System.Single UnityEngine.Vector3::y
IL_04ce: ldloc.s V_4
IL_04d0: ldfld System.Single UnityEngine.Vector3::y
IL_04d5: add
IL_04d6: ldarg.0
IL_04d7: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04dc: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_04e1: ldfld System.Single UnityEngine.Vector3::z
IL_04e6: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_04eb: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_04f0: ldc.i4.1
IL_04f1: brfalse.s IL_0515
IL_04f3: ldarg.1
IL_04f4: ldfld System.Single UnityEngine.Vector3::y
IL_04f9: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_04fe: ldc.r4 0
IL_0503: ble.un.s IL_0515
IL_0505: ldarga.s input
IL_0507: ldloc.s V_4
IL_0509: ldfld System.Single UnityEngine.Vector3::y
IL_050e: stfld System.Single UnityEngine.Vector3::y
IL_0513: ldc.i4.1
IL_0514: stloc.2
IL_0515: ldloc.2
IL_0516: brfalse.s IL_051f
IL_0518: ldarga.s input
IL_051a: call System.Void UnityEngine.Vector3::Normalize()
IL_051f: ldarg.0
IL_0520: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_0525: ldloc.1
IL_0526: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_052b: callvirt System.Void UnityEngine.Rigidbody2D::set_velocity(UnityEngine.Vector2)
IL_0530: ldarg.0
IL_0531: ldflda UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
IL_0536: ldfld System.Single UnityEngine.Vector2::y
IL_053b: ldc.r4 1
IL_0540: beq.s IL_054e
IL_0542: ldarg.0
IL_0543: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0548: ldarg.1
IL_0549: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(UnityEngine.Vector3)
IL_054e: ldarg.1
IL_054f: ldfld System.Single UnityEngine.Vector3::x
IL_0554: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0559: ldc.r4 0
IL_055e: ble.un.s IL_0571
IL_0560: ldarg.0
IL_0561: ldflda UnityEngine.Vector3 TheForestOfLove.Player::lastNonzeroXAxisInput
IL_0566: ldarg.1
IL_0567: ldfld System.Single UnityEngine.Vector3::x
IL_056c: stfld System.Single UnityEngine.Vector3::x
IL_0571: ldloca.s V_1
IL_0573: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0578: ldc.r4 0
IL_057d: ble.un IL_0605
IL_0582: ldarg.0
IL_0583: ldfld System.Single TheForestOfLove.Player::timeSinceLastStepSound
IL_0588: ldarg.0
IL_0589: ldfld System.Single TheForestOfLove.Player::timeBetweenStepSoundsWalking
IL_058e: ldarg.0
IL_058f: ldfld System.Single TheForestOfLove.Player::stepSoundTimerStartPhase
IL_0594: add
IL_0595: ble.un.s IL_05b0
IL_0597: ldarg.0
IL_0598: ldarg.0
IL_0599: ldfld System.Single TheForestOfLove.Player::stepSoundTimerStartPhase
IL_059e: stfld System.Single TheForestOfLove.Player::timeSinceLastStepSound
IL_05a3: ldarg.0
IL_05a4: call TheForestOfLove.TerrainType TheForestOfLove.Player::get_currentTerrainType()
IL_05a9: call System.Void TheForestOfLove.Audio.SoundManager::PlayFootstepSound(TheForestOfLove.TerrainType)
IL_05ae: br.s IL_05c2
IL_05b0: ldarg.0
IL_05b1: ldarg.0
IL_05b2: ldfld System.Single TheForestOfLove.Player::timeSinceLastStepSound
IL_05b7: call System.Single UnityEngine.Time::get_deltaTime()
IL_05bc: add
IL_05bd: stfld System.Single TheForestOfLove.Player::timeSinceLastStepSound
IL_05c2: ldarg.0
IL_05c3: ldfld System.Single TheForestOfLove.Player::timeSinceLastSnowTrack
IL_05c8: ldarg.0
IL_05c9: ldfld System.Single TheForestOfLove.Player::timeBetweenSnowTracksWalking
IL_05ce: ldarg.0
IL_05cf: ldfld System.Single TheForestOfLove.Player::snowTrackTimerStartPhase
IL_05d4: add
IL_05d5: ble.un.s IL_05f3
IL_05d7: ldarg.0
IL_05d8: ldarg.0
IL_05d9: ldfld System.Single TheForestOfLove.Player::snowTrackTimerStartPhase
IL_05de: stfld System.Single TheForestOfLove.Player::timeSinceLastSnowTrack
IL_05e3: ldarg.0
IL_05e4: call TheForestOfLove.TerrainType TheForestOfLove.Player::get_currentTerrainType()
IL_05e9: ldc.i4.3
IL_05ea: bne.un.s IL_0605
IL_05ec: ldarg.0
IL_05ed: call System.Void TheForestOfLove.Player::TryEmitSnowTrackParticle()
IL_05f2: ret
IL_05f3: ldarg.0
IL_05f4: ldarg.0
IL_05f5: ldfld System.Single TheForestOfLove.Player::timeSinceLastSnowTrack
IL_05fa: call System.Single UnityEngine.Time::get_deltaTime()
IL_05ff: add
IL_0600: stfld System.Single TheForestOfLove.Player::timeSinceLastSnowTrack
IL_0605: ret
METHOD System.Void TheForestOfLove.Player::Swim(UnityEngine.Vector3) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarga.s input
IL_0002: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0007: ldc.r4 0
IL_000c: bne.un.s IL_000f
IL_000e: ret
IL_000f: ldarg.0
IL_0010: ldc.i4.1
IL_0011: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0016: ldarg.0
IL_0017: ldc.i4.4
IL_0018: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_001d: ldarg.0
IL_001e: ldc.i4.0
IL_001f: stfld System.Boolean TheForestOfLove.Player::swimmingEnding
IL_0024: ldarga.s input
IL_0026: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_002b: stloc.0
IL_002c: ldloc.0
IL_002d: ldfld System.Single UnityEngine.Vector3::x
IL_0032: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0037: ldc.r4 0
IL_003c: ble.un.s IL_0052
IL_003e: ldloc.0
IL_003f: ldfld System.Single UnityEngine.Vector3::y
IL_0044: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0049: ldc.r4 0
IL_004e: cgt
IL_0050: br.s IL_0053
IL_0052: ldc.i4.0
IL_0053: brfalse IL_00f6
IL_0058: ldarg.0
IL_0059: ldflda UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
IL_005e: ldfld System.Single UnityEngine.Vector2::x
IL_0063: ldc.r4 1
IL_0068: bne.un.s IL_00b1
IL_006a: ldloca.s V_0
IL_006c: ldc.r4 0
IL_0071: stfld System.Single UnityEngine.Vector3::y
IL_0076: ldarg.1
IL_0077: ldfld System.Single UnityEngine.Vector3::x
IL_007c: ldarg.1
IL_007d: ldfld System.Single UnityEngine.Vector3::x
IL_0082: call System.Single UnityEngine.Mathf::Sign(System.Single)
IL_0087: ldarg.1
IL_0088: ldfld System.Single UnityEngine.Vector3::y
IL_008d: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0092: mul
IL_0093: ldarg.0
IL_0094: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_0099: mul
IL_009a: add
IL_009b: ldarg.1
IL_009c: ldfld System.Single UnityEngine.Vector3::y
IL_00a1: ldarg.0
IL_00a2: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_00a7: mul
IL_00a8: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_00ad: starg.s input
IL_00af: br.s IL_00f6
IL_00b1: ldloca.s V_0
IL_00b3: ldc.r4 0
IL_00b8: stfld System.Single UnityEngine.Vector3::x
IL_00bd: ldarg.1
IL_00be: ldfld System.Single UnityEngine.Vector3::x
IL_00c3: ldarg.0
IL_00c4: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_00c9: mul
IL_00ca: ldarg.1
IL_00cb: ldfld System.Single UnityEngine.Vector3::y
IL_00d0: ldarg.1
IL_00d1: ldfld System.Single UnityEngine.Vector3::y
IL_00d6: call System.Single UnityEngine.Mathf::Sign(System.Single)
IL_00db: ldarg.1
IL_00dc: ldfld System.Single UnityEngine.Vector3::x
IL_00e1: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_00e6: mul
IL_00e7: ldarg.0
IL_00e8: ldfld System.Single TheForestOfLove.Player::currentNudgeFactor
IL_00ed: mul
IL_00ee: add
IL_00ef: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_00f4: starg.s input
IL_00f6: ldarga.s input
IL_00f8: call System.Void UnityEngine.Vector3::Normalize()
IL_00fd: ldarg.0
IL_00fe: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_0103: ldstr "trigger_swimming"
IL_0108: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_010d: brfalse IL_01c1
IL_0112: ldarg.0
IL_0113: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0118: ldstr "trigger_swimming"
IL_011d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0122: ldarg.0
IL_0123: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0128: ldstr "trigger_swimming"
IL_012d: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0132: ldarg.0
IL_0133: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0138: ldnull
IL_0139: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_013e: brfalse.s IL_0150
IL_0140: ldarg.0
IL_0141: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0146: ldstr "trigger_swimming"
IL_014b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0150: ldarg.0
IL_0151: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0156: ldnull
IL_0157: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_015c: brfalse.s IL_016e
IL_015e: ldarg.0
IL_015f: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0164: ldstr "trigger_swimming"
IL_0169: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_016e: ldarg.0
IL_016f: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_0174: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0179: stloc.3
IL_017a: br.s IL_018d
IL_017c: ldloca.s V_3
IL_017e: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_0183: ldstr "trigger_swimming"
IL_0188: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_018d: ldloca.s V_3
IL_018f: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_0194: brtrue.s IL_017c
IL_0196: leave.s IL_01a6
IL_0198: ldloca.s V_3
IL_019a: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_01a0: callvirt System.Void System.IDisposable::Dispose()
IL_01a5: endfinally
IL_01a6: ldarg.0
IL_01a7: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_01ac: ldstr "trigger_swimming"
IL_01b1: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_01b6: ldarg.0
IL_01b7: ldstr "trigger_swimming"
IL_01bc: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_01c1: ldarg.0
IL_01c2: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01c7: ldstr "x"
IL_01cc: ldloc.0
IL_01cd: ldfld System.Single UnityEngine.Vector3::x
IL_01d2: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01d7: ldarg.0
IL_01d8: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01dd: ldstr "y"
IL_01e2: ldloc.0
IL_01e3: ldfld System.Single UnityEngine.Vector3::y
IL_01e8: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01ed: ldarg.0
IL_01ee: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_01f3: ldstr "x"
IL_01f8: ldloc.0
IL_01f9: ldfld System.Single UnityEngine.Vector3::x
IL_01fe: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0203: ldarg.0
IL_0204: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0209: ldstr "y"
IL_020e: ldloc.0
IL_020f: ldfld System.Single UnityEngine.Vector3::y
IL_0214: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0219: ldarg.0
IL_021a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_021f: ldnull
IL_0220: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0225: brfalse.s IL_0253
IL_0227: ldarg.0
IL_0228: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_022d: ldstr "x"
IL_0232: ldloc.0
IL_0233: ldfld System.Single UnityEngine.Vector3::x
IL_0238: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_023d: ldarg.0
IL_023e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0243: ldstr "y"
IL_0248: ldloc.0
IL_0249: ldfld System.Single UnityEngine.Vector3::y
IL_024e: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0253: ldarg.0
IL_0254: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0259: ldnull
IL_025a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_025f: brfalse.s IL_028d
IL_0261: ldarg.0
IL_0262: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0267: ldstr "x"
IL_026c: ldloc.0
IL_026d: ldfld System.Single UnityEngine.Vector3::x
IL_0272: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0277: ldarg.0
IL_0278: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_027d: ldstr "y"
IL_0282: ldloc.0
IL_0283: ldfld System.Single UnityEngine.Vector3::y
IL_0288: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_028d: ldarg.0
IL_028e: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_0293: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0298: stloc.3
IL_0299: br.s IL_02c3
IL_029b: ldloca.s V_3
IL_029d: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_02a2: dup
IL_02a3: ldstr "x"
IL_02a8: ldloc.0
IL_02a9: ldfld System.Single UnityEngine.Vector3::x
IL_02ae: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02b3: ldstr "y"
IL_02b8: ldloc.0
IL_02b9: ldfld System.Single UnityEngine.Vector3::y
IL_02be: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02c3: ldloca.s V_3
IL_02c5: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_02ca: brtrue.s IL_029b
IL_02cc: leave.s IL_02dc
IL_02ce: ldloca.s V_3
IL_02d0: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_02d6: callvirt System.Void System.IDisposable::Dispose()
IL_02db: endfinally
IL_02dc: ldarg.0
IL_02dd: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_02e2: ldstr "x"
IL_02e7: ldloc.0
IL_02e8: ldfld System.Single UnityEngine.Vector3::x
IL_02ed: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02f2: ldarg.0
IL_02f3: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_02f8: ldstr "y"
IL_02fd: ldloc.0
IL_02fe: ldfld System.Single UnityEngine.Vector3::y
IL_0303: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0308: ldarg.0
IL_0309: ldfld UnityEngine.Transform TheForestOfLove.Player::swimmingMotionTransform
IL_030e: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_0313: stloc.1
IL_0314: ldloca.s V_2
IL_0316: ldarg.0
IL_0317: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_031c: ldfld System.Single UnityEngine.Vector2::x
IL_0321: ldloca.s V_1
IL_0323: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0328: mul
IL_0329: ldarg.1
IL_032a: ldfld System.Single UnityEngine.Vector3::x
IL_032f: mul
IL_0330: ldarg.0
IL_0331: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0336: ldfld System.Single UnityEngine.Vector2::y
IL_033b: ldloca.s V_1
IL_033d: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0342: mul
IL_0343: ldarg.1
IL_0344: ldfld System.Single UnityEngine.Vector3::y
IL_0349: mul
IL_034a: ldc.r4 0
IL_034f: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0354: ldarg.0
IL_0355: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_035a: ldloc.2
IL_035b: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_0360: callvirt System.Void UnityEngine.Rigidbody2D::set_velocity(UnityEngine.Vector2)
IL_0365: ldarg.0
IL_0366: ldflda UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
IL_036b: ldfld System.Single UnityEngine.Vector2::y
IL_0370: ldc.r4 1
IL_0375: beq.s IL_0383
IL_0377: ldarg.0
IL_0378: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_037d: ldarg.1
IL_037e: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(UnityEngine.Vector3)
IL_0383: ldarg.1
IL_0384: ldfld System.Single UnityEngine.Vector3::x
IL_0389: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_038e: ldc.r4 0
IL_0393: ble.un.s IL_03a6
IL_0395: ldarg.0
IL_0396: ldflda UnityEngine.Vector3 TheForestOfLove.Player::lastNonzeroXAxisInput
IL_039b: ldarg.1
IL_039c: ldfld System.Single UnityEngine.Vector3::x
IL_03a1: stfld System.Single UnityEngine.Vector3::x
IL_03a6: ret
METHOD System.Void TheForestOfLove.Player::OnAnimatorClipFinishedLoop(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "WalkCyclesWIP_Roll_UpMODIFIED"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brtrue.s IL_004e
IL_000d: ldarg.1
IL_000e: ldstr "WalkCyclesWIP_Roll_FrontMODIFIED"
IL_0013: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0018: brtrue.s IL_004e
IL_001a: ldarg.1
IL_001b: ldstr "WalkCyclesWIP_Roll_SideMODIFIED"
IL_0020: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0025: brtrue.s IL_004e
IL_0027: ldarg.1
IL_0028: ldstr "WalkCyclesWIP_Sweater_Roll_UpMODIFIED"
IL_002d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0032: brtrue.s IL_004e
IL_0034: ldarg.1
IL_0035: ldstr "WalkCyclesWIP_Sweater_Roll_FrontMODIFIED"
IL_003a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_003f: brtrue.s IL_004e
IL_0041: ldarg.1
IL_0042: ldstr "WalkCyclesWIP_Sweater_Roll_SideMODIFIED"
IL_0047: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_004c: br.s IL_004f
IL_004e: ldc.i4.1
IL_004f: brfalse.s IL_005f
IL_0051: ldarg.0
IL_0052: ldfld System.Boolean TheForestOfLove.Player::dashingEnding
IL_0057: brfalse.s IL_005f
IL_0059: ldarg.0
IL_005a: call System.Void TheForestOfLove.Player::EndDash()
IL_005f: ldarg.1
IL_0060: ldstr "Swimming_Swim_UpMODIFIED"
IL_0065: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_006a: brtrue.s IL_00a0
IL_006c: ldarg.1
IL_006d: ldstr "Swimming_Swim_DownMODIFIED"
IL_0072: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0077: brtrue.s IL_00a0
IL_0079: ldarg.1
IL_007a: ldstr "Swimming_Swim_RightMODIFIED"
IL_007f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0084: brtrue.s IL_00a0
IL_0086: ldarg.1
IL_0087: ldstr "Swimming_Idle"
IL_008c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0091: brtrue.s IL_00a0
IL_0093: ldarg.1
IL_0094: ldstr "Swimming_Idle_Up"
IL_0099: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_009e: br.s IL_00a1
IL_00a0: ldc.i4.1
IL_00a1: dup
IL_00a2: brfalse.s IL_00b9
IL_00a4: ldarg.0
IL_00a5: ldfld System.Boolean TheForestOfLove.Player::swimmingEnding
IL_00aa: brfalse.s IL_00b9
IL_00ac: ldarg.0
IL_00ad: ldc.i4.0
IL_00ae: stfld System.Boolean TheForestOfLove.Player::swimmingEnding
IL_00b3: ldarg.0
IL_00b4: call System.Void TheForestOfLove.Player::CheckInput()
IL_00b9: brfalse.s IL_00c2
IL_00bb: ldarg.0
IL_00bc: ldc.i4.1
IL_00bd: stfld System.Boolean TheForestOfLove.Player::swimmingReadyForNewStrokeSound
IL_00c2: ldarg.1
IL_00c3: ldstr "Rascal_Attack_E_Full Swipe"
IL_00c8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00cd: brtrue.s IL_00e9
IL_00cf: ldarg.1
IL_00d0: ldstr "Rascal_Attack_E_Bonus Swipe End"
IL_00d5: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00da: brtrue.s IL_00e9
IL_00dc: ldarg.1
IL_00dd: ldstr "Rascal_Attack_E_Full Swipe End"
IL_00e2: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00e7: br.s IL_00ea
IL_00e9: ldc.i4.1
IL_00ea: brfalse.s IL_00fa
IL_00ec: ldarg.0
IL_00ed: ldfld System.Boolean TheForestOfLove.Player::slashingEnding
IL_00f2: brfalse.s IL_00fa
IL_00f4: ldarg.0
IL_00f5: call System.Void TheForestOfLove.Player::EndSlash()
IL_00fa: ldarg.1
IL_00fb: ldstr "Sweater Transition_M_Equip"
IL_0100: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0105: brtrue.s IL_0114
IL_0107: ldarg.1
IL_0108: ldstr "Sweater Transition_M_Unequip"
IL_010d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0112: brfalse.s IL_012b
IL_0114: ldarg.0
IL_0115: call System.Void TheForestOfLove.Player::SwapSweaterAnimator()
IL_011a: ldarg.0
IL_011b: ldftn System.Void TheForestOfLove.Player::<OnAnimatorClipFinishedLoop>b__239_0()
IL_0121: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0126: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_012b: ldarg.1
IL_012c: ldstr "Lantern_Equip_Placeholder"
IL_0131: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0136: brtrue.s IL_0145
IL_0138: ldarg.1
IL_0139: ldstr "RascalFireFlies2_E_Equip"
IL_013e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0143: brfalse.s IL_015c
IL_0145: ldarg.0
IL_0146: call System.Void TheForestOfLove.Player::SwapLanternAnimator()
IL_014b: ldarg.0
IL_014c: ldftn System.Void TheForestOfLove.Player::<OnAnimatorClipFinishedLoop>b__239_1()
IL_0152: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0157: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_015c: ldarg.1
IL_015d: ldstr "Lantern_Unequip_Placeholder"
IL_0162: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0167: brtrue.s IL_0176
IL_0169: ldarg.1
IL_016a: ldstr "RascalFireFlies2_E_Unequip"
IL_016f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0174: brfalse.s IL_01af
IL_0176: ldarg.0
IL_0177: ldstr "trigger_idle"
IL_017c: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_0181: ldarg.0
IL_0182: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_0187: ldstr "trigger_idle"
IL_018c: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0191: ldarg.0
IL_0192: ldc.i4.1
IL_0193: call System.Void TheForestOfLove.Player::Idle(System.Boolean)
IL_0198: ldarg.0
IL_0199: call System.Void TheForestOfLove.Player::SwapLanternAnimator()
IL_019e: ldarg.0
IL_019f: ldftn System.Void TheForestOfLove.Player::<OnAnimatorClipFinishedLoop>b__239_2()
IL_01a5: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01aa: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_01af: ret
METHOD System.Void TheForestOfLove.Player::OnLanternAnimatorClipFinishedLoop(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "Lantern_Equip_Placeholder"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brtrue.s IL_001a
IL_000d: ldarg.1
IL_000e: ldstr "RascalFireFlies2_E_Equip"
IL_0013: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0018: brfalse.s IL_0031
IL_001a: ldarg.0
IL_001b: call System.Void TheForestOfLove.Player::SwapLanternAnimator()
IL_0020: ldarg.0
IL_0021: ldftn System.Void TheForestOfLove.Player::<OnLanternAnimatorClipFinishedLoop>b__240_0()
IL_0027: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_002c: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_0031: ldarg.1
IL_0032: ldstr "Lantern_Unequip_Placeholder"
IL_0037: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_003c: brtrue.s IL_004b
IL_003e: ldarg.1
IL_003f: ldstr "RascalFireFlies2_E_Unequip"
IL_0044: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0049: brfalse.s IL_0084
IL_004b: ldarg.0
IL_004c: ldstr "trigger_idle"
IL_0051: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_0056: ldarg.0
IL_0057: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_005c: ldstr "trigger_idle"
IL_0061: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0066: ldarg.0
IL_0067: ldc.i4.1
IL_0068: call System.Void TheForestOfLove.Player::Idle(System.Boolean)
IL_006d: ldarg.0
IL_006e: call System.Void TheForestOfLove.Player::SwapLanternAnimator()
IL_0073: ldarg.0
IL_0074: ldftn System.Void TheForestOfLove.Player::<OnLanternAnimatorClipFinishedLoop>b__240_1()
IL_007a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_007f: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_0084: ret
METHOD System.Void TheForestOfLove.Player::SwapSweaterAnimator() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0006: ldarg.0
IL_0007: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_000c: brtrue.s IL_0016
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::defaultAnimatorController
IL_0014: br.s IL_001c
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::sweaterAnimatorController
IL_001c: callvirt System.Void UnityEngine.Animator::set_runtimeAnimatorController(UnityEngine.RuntimeAnimatorController)
IL_0021: ldarg.0
IL_0022: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0027: ldarg.0
IL_0028: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_002d: brtrue.s IL_0037
IL_002f: ldarg.0
IL_0030: ldfld UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::defaultAnimatorController
IL_0035: br.s IL_003d
IL_0037: ldarg.0
IL_0038: ldfld UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::sweaterAnimatorController
IL_003d: callvirt System.Void UnityEngine.Animator::set_runtimeAnimatorController(UnityEngine.RuntimeAnimatorController)
IL_0042: ldarg.0
IL_0043: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0048: ldnull
IL_0049: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_004e: brfalse.s IL_0071
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0056: ldarg.0
IL_0057: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_005c: brtrue.s IL_0066
IL_005e: ldarg.0
IL_005f: ldfld UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::defaultAnimatorController
IL_0064: br.s IL_006c
IL_0066: ldarg.0
IL_0067: ldfld UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::sweaterAnimatorController
IL_006c: callvirt System.Void UnityEngine.Animator::set_runtimeAnimatorController(UnityEngine.RuntimeAnimatorController)
IL_0071: ldarg.0
IL_0072: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_0077: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_007c: stloc.0
IL_007d: br.s IL_00a1
IL_007f: ldloca.s V_0
IL_0081: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_0086: ldarg.0
IL_0087: call System.Boolean TheForestOfLove.Player::get_sweaterEquipped()
IL_008c: brtrue.s IL_0096
IL_008e: ldarg.0
IL_008f: ldfld UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::defaultAnimatorController
IL_0094: br.s IL_009c
IL_0096: ldarg.0
IL_0097: ldfld UnityEngine.RuntimeAnimatorController TheForestOfLove.Player::sweaterAnimatorController
IL_009c: callvirt System.Void UnityEngine.Animator::set_runtimeAnimatorController(UnityEngine.RuntimeAnimatorController)
IL_00a1: ldloca.s V_0
IL_00a3: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_00a8: brtrue.s IL_007f
IL_00aa: leave.s IL_00ba
IL_00ac: ldloca.s V_0
IL_00ae: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_00b4: callvirt System.Void System.IDisposable::Dispose()
IL_00b9: endfinally
IL_00ba: ldarg.0
IL_00bb: ldstr "trigger_idle"
IL_00c0: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00c5: ldarg.0
IL_00c6: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00cb: ldstr "trigger_idle"
IL_00d0: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00d5: ldarg.0
IL_00d6: ldc.i4.1
IL_00d7: call System.Void TheForestOfLove.Player::Idle(System.Boolean)
IL_00dc: ret
METHOD System.Void TheForestOfLove.Player::SwapLanternAnimator() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.SpriteRenderer TheForestOfLove.Player::syncedMainSpriteRenderer
IL_0006: ldarg.0
IL_0007: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_000c: brtrue.s IL_0016
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.Color TheForestOfLove.Player::COLOR_WHITE_OPAQUE
IL_0014: br.s IL_001c
IL_0016: ldarg.0
IL_0017: ldfld UnityEngine.Color TheForestOfLove.Player::COLOR_WHITE_TRANSPARENT
IL_001c: callvirt System.Void UnityEngine.SpriteRenderer::set_color(UnityEngine.Color)
IL_0021: ldarg.0
IL_0022: ldfld UnityEngine.SpriteRenderer TheForestOfLove.Player::syncedLanternSpriteRenderer
IL_0027: ldnull
IL_0028: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_002d: brfalse.s IL_0050
IL_002f: ldarg.0
IL_0030: ldfld UnityEngine.SpriteRenderer TheForestOfLove.Player::syncedLanternSpriteRenderer
IL_0035: ldarg.0
IL_0036: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_003b: brtrue.s IL_0045
IL_003d: ldarg.0
IL_003e: ldfld UnityEngine.Color TheForestOfLove.Player::COLOR_WHITE_TRANSPARENT
IL_0043: br.s IL_004b
IL_0045: ldarg.0
IL_0046: ldfld UnityEngine.Color TheForestOfLove.Player::COLOR_WHITE_OPAQUE
IL_004b: callvirt System.Void UnityEngine.SpriteRenderer::set_color(UnityEngine.Color)
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0056: ldstr "has_lantern_equipped"
IL_005b: ldarg.0
IL_005c: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0061: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_0066: ldarg.0
IL_0067: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_006c: ldstr "has_lantern_equipped"
IL_0071: ldarg.0
IL_0072: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_0077: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_007c: ldarg.0
IL_007d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0082: ldnull
IL_0083: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0088: brfalse.s IL_00a0
IL_008a: ldarg.0
IL_008b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0090: ldstr "has_lantern_equipped"
IL_0095: ldarg.0
IL_0096: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_009b: callvirt System.Void UnityEngine.Animator::SetBool(System.String,System.Boolean)
IL_00a0: ldarg.0
IL_00a1: call System.Boolean TheForestOfLove.Player::get_lanternEquipped()
IL_00a6: brtrue.s IL_00ca
IL_00a8: ldarg.0
IL_00a9: ldstr "trigger_idle"
IL_00ae: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00b3: ldarg.0
IL_00b4: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_00b9: ldstr "trigger_idle"
IL_00be: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00c3: ldarg.0
IL_00c4: ldc.i4.1
IL_00c5: call System.Void TheForestOfLove.Player::Idle(System.Boolean)
IL_00ca: ret
METHOD System.Void TheForestOfLove.Player::Dash(UnityEngine.Vector3) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarga.s input
IL_0002: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0007: ldc.r4 0
IL_000c: bne.un.s IL_000f
IL_000e: ret
IL_000f: ldarg.0
IL_0010: ldc.i4.1
IL_0011: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0016: ldarg.0
IL_0017: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_001c: ldc.i4.5
IL_001d: ceq
IL_001f: ldc.i4.0
IL_0020: ceq
IL_0022: stloc.0
IL_0023: ldarg.0
IL_0024: ldc.i4.5
IL_0025: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_002a: ldarg.0
IL_002b: ldc.i4.0
IL_002c: stfld System.Boolean TheForestOfLove.Player::dashingEnding
IL_0031: ldloc.0
IL_0032: brfalse.s IL_003b
IL_0034: ldarg.0
IL_0035: ldarg.1
IL_0036: stfld UnityEngine.Vector3 TheForestOfLove.Player::dashingInput
IL_003b: ldarga.s input
IL_003d: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_0042: stloc.1
IL_0043: ldloc.1
IL_0044: ldfld System.Single UnityEngine.Vector3::x
IL_0049: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_004e: ldc.r4 0
IL_0053: ble.un.s IL_0069
IL_0055: ldloc.1
IL_0056: ldfld System.Single UnityEngine.Vector3::y
IL_005b: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0060: ldc.r4 0
IL_0065: cgt
IL_0067: br.s IL_006a
IL_0069: ldc.i4.0
IL_006a: ldarga.s input
IL_006c: call System.Void UnityEngine.Vector3::Normalize()
IL_0071: brfalse IL_0106
IL_0076: ldarg.0
IL_0077: ldflda UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
IL_007c: ldfld System.Single UnityEngine.Vector2::x
IL_0081: ldc.r4 1
IL_0086: bne.un.s IL_00c8
IL_0088: ldloca.s V_1
IL_008a: ldc.r4 0
IL_008f: stfld System.Single UnityEngine.Vector3::y
IL_0094: ldarg.1
IL_0095: ldfld System.Single UnityEngine.Vector3::x
IL_009a: ldarg.1
IL_009b: ldfld System.Single UnityEngine.Vector3::x
IL_00a0: call System.Single UnityEngine.Mathf::Sign(System.Single)
IL_00a5: ldarg.1
IL_00a6: ldfld System.Single UnityEngine.Vector3::y
IL_00ab: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_00b0: mul
IL_00b1: ldarg.0
IL_00b2: ldfld System.Single TheForestOfLove.Player::nudgeFactorDashing
IL_00b7: mul
IL_00b8: add
IL_00b9: ldarg.1
IL_00ba: ldfld System.Single UnityEngine.Vector3::y
IL_00bf: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_00c4: starg.s input
IL_00c6: br.s IL_0106
IL_00c8: ldloca.s V_1
IL_00ca: ldc.r4 0
IL_00cf: stfld System.Single UnityEngine.Vector3::x
IL_00d4: ldarg.1
IL_00d5: ldfld System.Single UnityEngine.Vector3::x
IL_00da: ldarg.1
IL_00db: ldfld System.Single UnityEngine.Vector3::y
IL_00e0: ldarg.1
IL_00e1: ldfld System.Single UnityEngine.Vector3::y
IL_00e6: call System.Single UnityEngine.Mathf::Sign(System.Single)
IL_00eb: ldarg.1
IL_00ec: ldfld System.Single UnityEngine.Vector3::x
IL_00f1: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_00f6: mul
IL_00f7: ldarg.0
IL_00f8: ldfld System.Single TheForestOfLove.Player::nudgeFactorDashing
IL_00fd: mul
IL_00fe: add
IL_00ff: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_0104: starg.s input
IL_0106: ldarg.0
IL_0107: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_010c: ldstr "trigger_dashing"
IL_0111: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0116: brfalse IL_01cb
IL_011b: ldarg.0
IL_011c: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0121: ldstr "trigger_dashing"
IL_0126: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_012b: ldarg.0
IL_012c: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0131: ldstr "trigger_dashing"
IL_0136: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_013b: ldarg.0
IL_013c: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0141: ldnull
IL_0142: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0147: brfalse.s IL_0159
IL_0149: ldarg.0
IL_014a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_014f: ldstr "trigger_dashing"
IL_0154: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0159: ldarg.0
IL_015a: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_015f: ldnull
IL_0160: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0165: brfalse.s IL_0177
IL_0167: ldarg.0
IL_0168: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_016d: ldstr "trigger_dashing"
IL_0172: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0177: ldarg.0
IL_0178: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_017d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0182: stloc.s V_4
IL_0184: br.s IL_0197
IL_0186: ldloca.s V_4
IL_0188: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_018d: ldstr "trigger_dashing"
IL_0192: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0197: ldloca.s V_4
IL_0199: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_019e: brtrue.s IL_0186
IL_01a0: leave.s IL_01b0
IL_01a2: ldloca.s V_4
IL_01a4: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_01aa: callvirt System.Void System.IDisposable::Dispose()
IL_01af: endfinally
IL_01b0: ldarg.0
IL_01b1: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_01b6: ldstr "trigger_dashing"
IL_01bb: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_01c0: ldarg.0
IL_01c1: ldstr "trigger_dashing"
IL_01c6: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_01cb: ldarg.0
IL_01cc: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01d1: ldstr "x"
IL_01d6: ldloc.1
IL_01d7: ldfld System.Single UnityEngine.Vector3::x
IL_01dc: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01e1: ldarg.0
IL_01e2: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01e7: ldstr "y"
IL_01ec: ldloc.1
IL_01ed: ldfld System.Single UnityEngine.Vector3::y
IL_01f2: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01f7: ldarg.0
IL_01f8: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_01fd: ldstr "x"
IL_0202: ldloc.1
IL_0203: ldfld System.Single UnityEngine.Vector3::x
IL_0208: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_020d: ldarg.0
IL_020e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0213: ldstr "y"
IL_0218: ldloc.1
IL_0219: ldfld System.Single UnityEngine.Vector3::y
IL_021e: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0223: ldarg.0
IL_0224: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0229: ldnull
IL_022a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_022f: brfalse.s IL_025d
IL_0231: ldarg.0
IL_0232: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0237: ldstr "x"
IL_023c: ldloc.1
IL_023d: ldfld System.Single UnityEngine.Vector3::x
IL_0242: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0247: ldarg.0
IL_0248: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_024d: ldstr "y"
IL_0252: ldloc.1
IL_0253: ldfld System.Single UnityEngine.Vector3::y
IL_0258: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_025d: ldarg.0
IL_025e: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0263: ldnull
IL_0264: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0269: brfalse.s IL_0297
IL_026b: ldarg.0
IL_026c: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0271: ldstr "x"
IL_0276: ldloc.1
IL_0277: ldfld System.Single UnityEngine.Vector3::x
IL_027c: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0281: ldarg.0
IL_0282: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0287: ldstr "y"
IL_028c: ldloc.1
IL_028d: ldfld System.Single UnityEngine.Vector3::y
IL_0292: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0297: ldarg.0
IL_0298: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_029d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_02a2: stloc.s V_4
IL_02a4: br.s IL_02ce
IL_02a6: ldloca.s V_4
IL_02a8: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_02ad: dup
IL_02ae: ldstr "x"
IL_02b3: ldloc.1
IL_02b4: ldfld System.Single UnityEngine.Vector3::x
IL_02b9: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02be: ldstr "y"
IL_02c3: ldloc.1
IL_02c4: ldfld System.Single UnityEngine.Vector3::y
IL_02c9: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02ce: ldloca.s V_4
IL_02d0: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_02d5: brtrue.s IL_02a6
IL_02d7: leave.s IL_02e7
IL_02d9: ldloca.s V_4
IL_02db: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_02e1: callvirt System.Void System.IDisposable::Dispose()
IL_02e6: endfinally
IL_02e7: ldarg.0
IL_02e8: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_02ed: ldstr "x"
IL_02f2: ldloc.1
IL_02f3: ldfld System.Single UnityEngine.Vector3::x
IL_02f8: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02fd: ldarg.0
IL_02fe: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_0303: ldstr "y"
IL_0308: ldloc.1
IL_0309: ldfld System.Single UnityEngine.Vector3::y
IL_030e: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0313: ldarg.0
IL_0314: ldfld UnityEngine.Transform TheForestOfLove.Player::dashingMotionTransform
IL_0319: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_031e: stloc.2
IL_031f: ldloca.s V_3
IL_0321: ldarg.0
IL_0322: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0327: ldfld System.Single UnityEngine.Vector2::x
IL_032c: ldloca.s V_2
IL_032e: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0333: mul
IL_0334: ldarg.1
IL_0335: ldfld System.Single UnityEngine.Vector3::x
IL_033a: mul
IL_033b: ldarg.0
IL_033c: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0341: ldfld System.Single UnityEngine.Vector2::y
IL_0346: ldloca.s V_2
IL_0348: call System.Single UnityEngine.Vector3::get_magnitude()
IL_034d: mul
IL_034e: ldarg.1
IL_034f: ldfld System.Single UnityEngine.Vector3::y
IL_0354: mul
IL_0355: ldc.r4 0
IL_035a: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_035f: ldarg.0
IL_0360: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_0365: ldloc.3
IL_0366: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_036b: callvirt System.Void UnityEngine.Rigidbody2D::set_velocity(UnityEngine.Vector2)
IL_0370: ldarg.0
IL_0371: ldflda UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
IL_0376: ldfld System.Single UnityEngine.Vector2::y
IL_037b: ldc.r4 1
IL_0380: beq.s IL_038e
IL_0382: ldarg.0
IL_0383: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0388: ldarg.1
IL_0389: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(UnityEngine.Vector3)
IL_038e: ldarg.1
IL_038f: ldfld System.Single UnityEngine.Vector3::x
IL_0394: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0399: ldc.r4 0
IL_039e: ble.un.s IL_03b1
IL_03a0: ldarg.0
IL_03a1: ldflda UnityEngine.Vector3 TheForestOfLove.Player::lastNonzeroXAxisInput
IL_03a6: ldarg.1
IL_03a7: ldfld System.Single UnityEngine.Vector3::x
IL_03ac: stfld System.Single UnityEngine.Vector3::x
IL_03b1: ldloc.0
IL_03b2: brfalse.s IL_03be
IL_03b4: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Player::onDashrollStarted
IL_03b9: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_03be: ret
METHOD System.Void TheForestOfLove.Player::Slash(UnityEngine.Vector3) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: stfld System.Boolean TheForestOfLove.Player::tookAtLeastOneStep
IL_0007: ldarg.0
IL_0008: call TheForestOfLove.PlayerState TheForestOfLove.Player::get_playerState()
IL_000d: ldc.i4.7
IL_000e: ceq
IL_0010: ldc.i4.0
IL_0011: ceq
IL_0013: stloc.0
IL_0014: ldarg.0
IL_0015: ldc.i4.7
IL_0016: call System.Void TheForestOfLove.Player::set_playerState(TheForestOfLove.PlayerState)
IL_001b: ldarg.0
IL_001c: ldc.i4.0
IL_001d: stfld System.Boolean TheForestOfLove.Player::slashingEnding
IL_0022: ldloc.0
IL_0023: brfalse.s IL_002c
IL_0025: ldarg.0
IL_0026: ldarg.1
IL_0027: stfld UnityEngine.Vector3 TheForestOfLove.Player::slashingInput
IL_002c: ldarga.s input
IL_002e: call UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()
IL_0033: stloc.1
IL_0034: ldloc.1
IL_0035: ldfld System.Single UnityEngine.Vector3::x
IL_003a: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_003f: ldc.r4 0
IL_0044: ble.un.s IL_005a
IL_0046: ldloc.1
IL_0047: ldfld System.Single UnityEngine.Vector3::y
IL_004c: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_0051: ldc.r4 0
IL_0056: cgt
IL_0058: br.s IL_005b
IL_005a: ldc.i4.0
IL_005b: ldarga.s input
IL_005d: call System.Void UnityEngine.Vector3::Normalize()
IL_0062: brfalse IL_00f7
IL_0067: ldarg.0
IL_0068: ldflda UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
IL_006d: ldfld System.Single UnityEngine.Vector2::x
IL_0072: ldc.r4 1
IL_0077: bne.un.s IL_00b9
IL_0079: ldloca.s V_1
IL_007b: ldc.r4 0
IL_0080: stfld System.Single UnityEngine.Vector3::y
IL_0085: ldarg.1
IL_0086: ldfld System.Single UnityEngine.Vector3::x
IL_008b: ldarg.1
IL_008c: ldfld System.Single UnityEngine.Vector3::x
IL_0091: call System.Single UnityEngine.Mathf::Sign(System.Single)
IL_0096: ldarg.1
IL_0097: ldfld System.Single UnityEngine.Vector3::y
IL_009c: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_00a1: mul
IL_00a2: ldarg.0
IL_00a3: ldfld System.Single TheForestOfLove.Player::nudgeFactorSlashing
IL_00a8: mul
IL_00a9: add
IL_00aa: ldarg.1
IL_00ab: ldfld System.Single UnityEngine.Vector3::y
IL_00b0: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_00b5: starg.s input
IL_00b7: br.s IL_00f7
IL_00b9: ldloca.s V_1
IL_00bb: ldc.r4 0
IL_00c0: stfld System.Single UnityEngine.Vector3::x
IL_00c5: ldarg.1
IL_00c6: ldfld System.Single UnityEngine.Vector3::x
IL_00cb: ldarg.1
IL_00cc: ldfld System.Single UnityEngine.Vector3::y
IL_00d1: ldarg.1
IL_00d2: ldfld System.Single UnityEngine.Vector3::y
IL_00d7: call System.Single UnityEngine.Mathf::Sign(System.Single)
IL_00dc: ldarg.1
IL_00dd: ldfld System.Single UnityEngine.Vector3::x
IL_00e2: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_00e7: mul
IL_00e8: ldarg.0
IL_00e9: ldfld System.Single TheForestOfLove.Player::nudgeFactorSlashing
IL_00ee: mul
IL_00ef: add
IL_00f0: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_00f5: starg.s input
IL_00f7: ldarg.0
IL_00f8: ldfld System.String TheForestOfLove.Player::lastSetTrigger
IL_00fd: ldstr "trigger_slash"
IL_0102: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0107: brfalse IL_01bc
IL_010c: ldarg.0
IL_010d: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_0112: ldstr "trigger_slash"
IL_0117: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_011c: ldarg.0
IL_011d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0122: ldstr "trigger_slash"
IL_0127: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_012c: ldarg.0
IL_012d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0132: ldnull
IL_0133: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0138: brfalse.s IL_014a
IL_013a: ldarg.0
IL_013b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0140: ldstr "trigger_slash"
IL_0145: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_014a: ldarg.0
IL_014b: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0150: ldnull
IL_0151: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0156: brfalse.s IL_0168
IL_0158: ldarg.0
IL_0159: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_015e: ldstr "trigger_slash"
IL_0163: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0168: ldarg.0
IL_0169: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_016e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0173: stloc.s V_4
IL_0175: br.s IL_0188
IL_0177: ldloca.s V_4
IL_0179: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_017e: ldstr "trigger_slash"
IL_0183: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0188: ldloca.s V_4
IL_018a: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_018f: brtrue.s IL_0177
IL_0191: leave.s IL_01a1
IL_0193: ldloca.s V_4
IL_0195: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_019b: callvirt System.Void System.IDisposable::Dispose()
IL_01a0: endfinally
IL_01a1: ldarg.0
IL_01a2: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_01a7: ldstr "trigger_slash"
IL_01ac: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_01b1: ldarg.0
IL_01b2: ldstr "trigger_slash"
IL_01b7: stfld System.String TheForestOfLove.Player::lastSetTrigger
IL_01bc: ldarg.0
IL_01bd: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01c2: ldstr "x"
IL_01c7: ldloc.1
IL_01c8: ldfld System.Single UnityEngine.Vector3::x
IL_01cd: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01d2: ldarg.0
IL_01d3: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::animator
IL_01d8: ldstr "y"
IL_01dd: ldloc.1
IL_01de: ldfld System.Single UnityEngine.Vector3::y
IL_01e3: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01e8: ldarg.0
IL_01e9: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_01ee: ldstr "x"
IL_01f3: ldloc.1
IL_01f4: ldfld System.Single UnityEngine.Vector3::x
IL_01f9: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_01fe: ldarg.0
IL_01ff: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedMainAnimator
IL_0204: ldstr "y"
IL_0209: ldloc.1
IL_020a: ldfld System.Single UnityEngine.Vector3::y
IL_020f: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0214: ldarg.0
IL_0215: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_021a: ldnull
IL_021b: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0220: brfalse.s IL_024e
IL_0222: ldarg.0
IL_0223: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_0228: ldstr "x"
IL_022d: ldloc.1
IL_022e: ldfld System.Single UnityEngine.Vector3::x
IL_0233: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0238: ldarg.0
IL_0239: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedLanternAnimator
IL_023e: ldstr "y"
IL_0243: ldloc.1
IL_0244: ldfld System.Single UnityEngine.Vector3::y
IL_0249: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_024e: ldarg.0
IL_024f: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0254: ldnull
IL_0255: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_025a: brfalse.s IL_0288
IL_025c: ldarg.0
IL_025d: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0262: ldstr "x"
IL_0267: ldloc.1
IL_0268: ldfld System.Single UnityEngine.Vector3::x
IL_026d: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0272: ldarg.0
IL_0273: ldfld UnityEngine.Animator TheForestOfLove.Player::syncedReflectionAnimator
IL_0278: ldstr "y"
IL_027d: ldloc.1
IL_027e: ldfld System.Single UnityEngine.Vector3::y
IL_0283: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0288: ldarg.0
IL_0289: call System.Collections.Generic.List`1<UnityEngine.Animator> TheForestOfLove.Player::get_SyncedAnimators()
IL_028e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<UnityEngine.Animator>::GetEnumerator()
IL_0293: stloc.s V_4
IL_0295: br.s IL_02bf
IL_0297: ldloca.s V_4
IL_0299: call !0 System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::get_Current()
IL_029e: dup
IL_029f: ldstr "x"
IL_02a4: ldloc.1
IL_02a5: ldfld System.Single UnityEngine.Vector3::x
IL_02aa: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02af: ldstr "y"
IL_02b4: ldloc.1
IL_02b5: ldfld System.Single UnityEngine.Vector3::y
IL_02ba: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02bf: ldloca.s V_4
IL_02c1: call System.Boolean System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>::MoveNext()
IL_02c6: brtrue.s IL_0297
IL_02c8: leave.s IL_02d8
IL_02ca: ldloca.s V_4
IL_02cc: constrained. System.Collections.Generic.List`1/Enumerator<UnityEngine.Animator>
IL_02d2: callvirt System.Void System.IDisposable::Dispose()
IL_02d7: endfinally
IL_02d8: ldarg.0
IL_02d9: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_02de: ldstr "x"
IL_02e3: ldloc.1
IL_02e4: ldfld System.Single UnityEngine.Vector3::x
IL_02e9: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_02ee: ldarg.0
IL_02ef: ldfld UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::shadowAnimator
IL_02f4: ldstr "y"
IL_02f9: ldloc.1
IL_02fa: ldfld System.Single UnityEngine.Vector3::y
IL_02ff: callvirt System.Void UnityEngine.Animator::SetFloat(System.String,System.Single)
IL_0304: ldarg.0
IL_0305: ldfld UnityEngine.Transform TheForestOfLove.Player::slashingMotionTransform
IL_030a: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_localPosition()
IL_030f: stloc.2
IL_0310: ldloca.s V_3
IL_0312: ldarg.0
IL_0313: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0318: ldfld System.Single UnityEngine.Vector2::x
IL_031d: ldloca.s V_2
IL_031f: call System.Single UnityEngine.Vector3::get_magnitude()
IL_0324: mul
IL_0325: ldarg.1
IL_0326: ldfld System.Single UnityEngine.Vector3::x
IL_032b: mul
IL_032c: ldarg.0
IL_032d: ldflda UnityEngine.Vector2 TheForestOfLove.Player::currentSpeed
IL_0332: ldfld System.Single UnityEngine.Vector2::y
IL_0337: ldloca.s V_2
IL_0339: call System.Single UnityEngine.Vector3::get_magnitude()
IL_033e: mul
IL_033f: ldarg.1
IL_0340: ldfld System.Single UnityEngine.Vector3::y
IL_0345: mul
IL_0346: ldc.r4 0
IL_034b: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0350: ldarg.0
IL_0351: ldfld UnityEngine.Rigidbody2D TheForestOfLove.Gameplay.SpawnableActor::rigidbody
IL_0356: ldloc.3
IL_0357: call UnityEngine.Vector2 UnityEngine.Vector2::op_Implicit(UnityEngine.Vector3)
IL_035c: callvirt System.Void UnityEngine.Rigidbody2D::set_velocity(UnityEngine.Vector2)
IL_0361: ldarg.0
IL_0362: ldflda UnityEngine.Vector2 TheForestOfLove.Player::lastFullAxis
IL_0367: ldfld System.Single UnityEngine.Vector2::y
IL_036c: ldc.r4 1
IL_0371: beq.s IL_037f
IL_0373: ldarg.0
IL_0374: call TheForestOfLove.Gameplay.DirectionController TheForestOfLove.Gameplay.SpawnableActor::get_DirectionController()
IL_0379: ldarg.1
IL_037a: callvirt System.Void TheForestOfLove.Gameplay.DirectionController::SetDirection(UnityEngine.Vector3)
IL_037f: ldarg.1
IL_0380: ldfld System.Single UnityEngine.Vector3::x
IL_0385: call System.Single UnityEngine.Mathf::Abs(System.Single)
IL_038a: ldc.r4 0
IL_038f: ble.un.s IL_03a2
IL_0391: ldarg.0
IL_0392: ldflda UnityEngine.Vector3 TheForestOfLove.Player::lastNonzeroXAxisInput
IL_0397: ldarg.1
IL_0398: ldfld System.Single UnityEngine.Vector3::x
IL_039d: stfld System.Single UnityEngine.Vector3::x
IL_03a2: ldloc.0
IL_03a3: brfalse.s IL_03af
IL_03a5: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Player::onSlashStarted
IL_03aa: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_03af: ret
