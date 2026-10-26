TYPE TheForestOfLove.InteractionUi
METHOD System.Void TheForestOfLove.InteractionUi::Show() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_0007: call System.Void TheForestOfLove.InteractionUi::Show(TheForestOfLove.InteractionUiOption)
IL_000c: ret
METHOD System.Void TheForestOfLove.InteractionUi::Show(TheForestOfLove.InteractionUiOption) | attributes=Public, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.InteractionUi::get_visible()
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldc.i4.1
IL_0009: call System.Void TheForestOfLove.InteractionUi::set_visible(System.Boolean)
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.Animator TheForestOfLove.InteractionUi::uiAnimator
IL_0014: ldstr "Show"
IL_0019: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_001e: ldarg.0
IL_001f: ldfld UnityEngine.Animator TheForestOfLove.InteractionUi::uiAnimator
IL_0024: ldstr "Hide"
IL_0029: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_002e: ldarg.0
IL_002f: ldfld UnityEngine.Animator TheForestOfLove.InteractionUi::uiAnimator
IL_0034: ldstr "Show"
IL_0039: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_003e: ldarg.0
IL_003f: ldarg.0
IL_0040: ldarg.1
IL_0041: dup
IL_0042: stloc.0
IL_0043: stfld TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::currentDisplayedOption
IL_0048: ldloc.0
IL_0049: call System.Void TheForestOfLove.InteractionUi::set_currentSelectedOption(TheForestOfLove.InteractionUiOption)
IL_004e: ldarg.0
IL_004f: ldfld TheForestOfLove.InteractionUi/OnOptionSelectedHandler TheForestOfLove.InteractionUi::onOptionSelected
IL_0054: dup
IL_0055: brtrue.s IL_005a
IL_0057: pop
IL_0058: br.s IL_0065
IL_005a: ldarg.0
IL_005b: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_0060: callvirt System.Void TheForestOfLove.InteractionUi/OnOptionSelectedHandler::Invoke(TheForestOfLove.InteractionUiOption)
IL_0065: ldarg.0
IL_0066: call System.Void TheForestOfLove.InteractionUi::ResetStuff()
IL_006b: ldarg.0
IL_006c: call System.Void TheForestOfLove.InteractionUi::UpdateVisibleOptionLabel()
IL_0071: ldarg.0
IL_0072: ldarg.0
IL_0073: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_0078: call System.Void TheForestOfLove.InteractionUi::UpdatePlaceholderContents(TheForestOfLove.InteractionUiOption)
IL_007d: ldarg.0
IL_007e: ldarg.0
IL_007f: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_0084: call System.Void TheForestOfLove.InteractionUi::UpdateControlsVisibility(TheForestOfLove.InteractionUiOption)
IL_0089: ret
METHOD System.Void TheForestOfLove.InteractionUi::SetAvailableOptions(TheForestOfLove.InteractionUiOption[]) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldloca.s V_0
IL_0004: initobj System.Nullable`1<TheForestOfLove.InteractionUiOption>
IL_000a: ldloc.0
IL_000b: call System.Void TheForestOfLove.InteractionUi::SetAvailableOptions(TheForestOfLove.InteractionUiOption[],System.Nullable`1<TheForestOfLove.InteractionUiOption>)
IL_0010: ret
METHOD System.Void TheForestOfLove.InteractionUi::SetAvailableOptions(TheForestOfLove.InteractionUiOption[],System.Nullable`1<TheForestOfLove.InteractionUiOption>) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUi::availableOptions
IL_0006: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Clear()
IL_000b: ldarg.1
IL_000c: stloc.1
IL_000d: ldc.i4.0
IL_000e: stloc.2
IL_000f: br.s IL_0033
IL_0011: ldloc.1
IL_0012: ldloc.2
IL_0013: ldelem.i4
IL_0014: stloc.3
IL_0015: ldarg.0
IL_0016: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUi::availableOptions
IL_001b: ldloc.3
IL_001c: callvirt System.Boolean System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Contains(!0)
IL_0021: brtrue.s IL_002f
IL_0023: ldarg.0
IL_0024: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUi::availableOptions
IL_0029: ldloc.3
IL_002a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::Add(!0)
IL_002f: ldloc.2
IL_0030: ldc.i4.1
IL_0031: add
IL_0032: stloc.2
IL_0033: ldloc.2
IL_0034: ldloc.1
IL_0035: ldlen
IL_0036: conv.i4
IL_0037: blt.s IL_0011
IL_0039: ldarg.0
IL_003a: ldfld System.Action TheForestOfLove.InteractionUi::onAvailableOptionsUpdated
IL_003f: dup
IL_0040: brtrue.s IL_0045
IL_0042: pop
IL_0043: br.s IL_004a
IL_0045: callvirt System.Void System.Action::Invoke()
IL_004a: ldarg.0
IL_004b: ldarg.2
IL_004c: stloc.s V_4
IL_004e: ldloca.s V_4
IL_0050: call System.Boolean System.Nullable`1<TheForestOfLove.InteractionUiOption>::get_HasValue()
IL_0055: brtrue.s IL_005f
IL_0057: ldarg.0
IL_0058: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_005d: br.s IL_0066
IL_005f: ldloca.s V_4
IL_0061: call !0 System.Nullable`1<TheForestOfLove.InteractionUiOption>::GetValueOrDefault()
IL_0066: call System.Int32 TheForestOfLove.InteractionUi::GetAvailableOptionIndex(TheForestOfLove.InteractionUiOption)
IL_006b: stloc.0
IL_006c: ldloc.0
IL_006d: ldc.i4.0
IL_006e: bge.s IL_00a8
IL_0070: ldarg.0
IL_0071: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUi::availableOptions
IL_0076: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Count()
IL_007b: ldc.i4.0
IL_007c: ble.s IL_0094
IL_007e: ldarg.0
IL_007f: ldarg.0
IL_0080: ldarg.1
IL_0081: ldc.i4.0
IL_0082: ldelem.i4
IL_0083: dup
IL_0084: stloc.s V_5
IL_0086: stfld TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::currentDisplayedOption
IL_008b: ldloc.s V_5
IL_008d: call System.Void TheForestOfLove.InteractionUi::set_currentSelectedOption(TheForestOfLove.InteractionUiOption)
IL_0092: br.s IL_00c5
IL_0094: ldarg.0
IL_0095: ldarg.0
IL_0096: ldc.i4.0
IL_0097: dup
IL_0098: stloc.s V_5
IL_009a: stfld TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::currentDisplayedOption
IL_009f: ldloc.s V_5
IL_00a1: call System.Void TheForestOfLove.InteractionUi::set_currentSelectedOption(TheForestOfLove.InteractionUiOption)
IL_00a6: br.s IL_00c5
IL_00a8: ldarg.0
IL_00a9: ldarg.0
IL_00aa: ldarg.0
IL_00ab: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUi::availableOptions
IL_00b0: ldloc.0
IL_00b1: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Item(System.Int32)
IL_00b6: dup
IL_00b7: stloc.s V_5
IL_00b9: stfld TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::currentDisplayedOption
IL_00be: ldloc.s V_5
IL_00c0: call System.Void TheForestOfLove.InteractionUi::set_currentSelectedOption(TheForestOfLove.InteractionUiOption)
IL_00c5: ldarg.0
IL_00c6: ldfld TheForestOfLove.InteractionUi/OnOptionSelectedHandler TheForestOfLove.InteractionUi::onOptionSelected
IL_00cb: dup
IL_00cc: brtrue.s IL_00d1
IL_00ce: pop
IL_00cf: br.s IL_00dc
IL_00d1: ldarg.0
IL_00d2: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_00d7: callvirt System.Void TheForestOfLove.InteractionUi/OnOptionSelectedHandler::Invoke(TheForestOfLove.InteractionUiOption)
IL_00dc: ldarg.0
IL_00dd: ldarg.0
IL_00de: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_00e3: call System.Void TheForestOfLove.InteractionUi::UpdatePlaceholderContents(TheForestOfLove.InteractionUiOption)
IL_00e8: ldarg.0
IL_00e9: ldarg.0
IL_00ea: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_00ef: call System.Void TheForestOfLove.InteractionUi::UpdateControlsVisibility(TheForestOfLove.InteractionUiOption)
IL_00f4: ret
METHOD System.Void TheForestOfLove.InteractionUi::NavigateOptions() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0005: brtrue.s IL_000f
IL_0007: ldarg.0
IL_0008: call System.Boolean TheForestOfLove.InteractionUi::get_locked()
IL_000d: brtrue.s IL_0010
IL_000f: ret
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean TheForestOfLove.InteractionUi::canvasAnimatorTransitioning
IL_0016: brtrue.s IL_001f
IL_0018: ldarg.0
IL_0019: ldc.i4.0
IL_001a: stfld System.Int32 TheForestOfLove.InteractionUi::waitingOnDirection
IL_001f: call System.Boolean TheForestOfLove.InputHelper::get_IsLeftBumperDown()
IL_0024: brfalse IL_00e3
IL_0029: ldarg.0
IL_002a: ldfld System.Boolean TheForestOfLove.InteractionUi::allowWraparound
IL_002f: brtrue.s IL_004f
IL_0031: ldarg.0
IL_0032: ldarg.0
IL_0033: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_0038: call System.Int32 TheForestOfLove.InteractionUi::GetAvailableOptionIndex(TheForestOfLove.InteractionUiOption)
IL_003d: ldc.i4.0
IL_003e: bgt.s IL_004f
IL_0040: ldc.i4 300
IL_0045: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_004a: br IL_00d2
IL_004f: ldarg.0
IL_0050: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUi::availableOptions
IL_0055: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Count()
IL_005a: ldc.i4.1
IL_005b: ble.s IL_00c8
IL_005d: ldarg.0
IL_005e: ldfld System.Int32 TheForestOfLove.InteractionUi::waitingOnDirection
IL_0063: ldc.i4.2
IL_0064: beq.s IL_00bf
IL_0066: ldarg.0
IL_0067: ldc.i4.1
IL_0068: stfld System.Int32 TheForestOfLove.InteractionUi::waitingOnDirection
IL_006d: ldarg.0
IL_006e: ldarg.0
IL_006f: ldarg.0
IL_0070: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_0075: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::GetLeftOption(TheForestOfLove.InteractionUiOption)
IL_007a: call System.Void TheForestOfLove.InteractionUi::set_currentSelectedOption(TheForestOfLove.InteractionUiOption)
IL_007f: ldarg.0
IL_0080: ldfld TheForestOfLove.InteractionUi/OnOptionSelectedHandler TheForestOfLove.InteractionUi::onOptionSelected
IL_0085: dup
IL_0086: brtrue.s IL_008b
IL_0088: pop
IL_0089: br.s IL_0096
IL_008b: ldarg.0
IL_008c: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_0091: callvirt System.Void TheForestOfLove.InteractionUi/OnOptionSelectedHandler::Invoke(TheForestOfLove.InteractionUiOption)
IL_0096: ldarg.0
IL_0097: ldfld UnityEngine.Animator TheForestOfLove.InteractionUi::placeholdersAnimator
IL_009c: ldstr "left"
IL_00a1: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00a6: ldarg.0
IL_00a7: ldc.i4.1
IL_00a8: stfld System.Boolean TheForestOfLove.InteractionUi::canvasAnimatorTransitioning
IL_00ad: ldarg.0
IL_00ae: call System.Void TheForestOfLove.InteractionUi::LockOptionInteractions()
IL_00b3: ldarg.0
IL_00b4: ldarg.0
IL_00b5: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_00ba: call System.Void TheForestOfLove.InteractionUi::UpdateControlsVisibility(TheForestOfLove.InteractionUiOption)
IL_00bf: ldc.i4.s 100
IL_00c1: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_00c6: br.s IL_00d2
IL_00c8: ldc.i4 300
IL_00cd: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_00d2: ldarg.0
IL_00d3: ldfld UnityEngine.Animator TheForestOfLove.InteractionUi::animatorControlsL
IL_00d8: ldstr "pressed"
IL_00dd: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_00e2: ret
IL_00e3: call System.Boolean TheForestOfLove.InputHelper::get_IsRightBumperDown()
IL_00e8: brfalse IL_01b2
IL_00ed: ldarg.0
IL_00ee: ldfld System.Boolean TheForestOfLove.InteractionUi::allowWraparound
IL_00f3: brtrue.s IL_011f
IL_00f5: ldarg.0
IL_00f6: ldarg.0
IL_00f7: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_00fc: call System.Int32 TheForestOfLove.InteractionUi::GetAvailableOptionIndex(TheForestOfLove.InteractionUiOption)
IL_0101: ldarg.0
IL_0102: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUi::availableOptions
IL_0107: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Count()
IL_010c: ldc.i4.1
IL_010d: sub
IL_010e: bne.un.s IL_011f
IL_0110: ldc.i4 300
IL_0115: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_011a: br IL_01a2
IL_011f: ldarg.0
IL_0120: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUi::availableOptions
IL_0125: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Count()
IL_012a: ldc.i4.1
IL_012b: ble.s IL_0198
IL_012d: ldarg.0
IL_012e: ldfld System.Int32 TheForestOfLove.InteractionUi::waitingOnDirection
IL_0133: ldc.i4.1
IL_0134: beq.s IL_018f
IL_0136: ldarg.0
IL_0137: ldc.i4.2
IL_0138: stfld System.Int32 TheForestOfLove.InteractionUi::waitingOnDirection
IL_013d: ldarg.0
IL_013e: ldarg.0
IL_013f: ldarg.0
IL_0140: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_0145: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::GetRightOption(TheForestOfLove.InteractionUiOption)
IL_014a: call System.Void TheForestOfLove.InteractionUi::set_currentSelectedOption(TheForestOfLove.InteractionUiOption)
IL_014f: ldarg.0
IL_0150: ldfld TheForestOfLove.InteractionUi/OnOptionSelectedHandler TheForestOfLove.InteractionUi::onOptionSelected
IL_0155: dup
IL_0156: brtrue.s IL_015b
IL_0158: pop
IL_0159: br.s IL_0166
IL_015b: ldarg.0
IL_015c: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_0161: callvirt System.Void TheForestOfLove.InteractionUi/OnOptionSelectedHandler::Invoke(TheForestOfLove.InteractionUiOption)
IL_0166: ldarg.0
IL_0167: ldfld UnityEngine.Animator TheForestOfLove.InteractionUi::placeholdersAnimator
IL_016c: ldstr "right"
IL_0171: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0176: ldarg.0
IL_0177: ldc.i4.1
IL_0178: stfld System.Boolean TheForestOfLove.InteractionUi::canvasAnimatorTransitioning
IL_017d: ldarg.0
IL_017e: call System.Void TheForestOfLove.InteractionUi::LockOptionInteractions()
IL_0183: ldarg.0
IL_0184: ldarg.0
IL_0185: call TheForestOfLove.InteractionUiOption TheForestOfLove.InteractionUi::get_currentSelectedOption()
IL_018a: call System.Void TheForestOfLove.InteractionUi::UpdateControlsVisibility(TheForestOfLove.InteractionUiOption)
IL_018f: ldc.i4.s 100
IL_0191: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0196: br.s IL_01a2
IL_0198: ldc.i4 300
IL_019d: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_01a2: ldarg.0
IL_01a3: ldfld UnityEngine.Animator TheForestOfLove.InteractionUi::animatorControlsR
IL_01a8: ldstr "pressed"
IL_01ad: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_01b2: ret
