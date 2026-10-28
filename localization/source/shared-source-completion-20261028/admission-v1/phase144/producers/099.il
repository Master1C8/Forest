TYPE TheForestOfLove.InteractionUiDemoMode
METHOD System.Int32 TheForestOfLove.InteractionUiDemoMode::GetAvailableOptionIndex(TheForestOfLove.InteractionUiOption) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldc.i4.0
IL_0003: call System.Int32 TheForestOfLove.InteractionUiDemoMode::GetAvailableOptionIndex(TheForestOfLove.InteractionUiOption,System.Boolean)
IL_0008: ret
METHOD System.Int32 TheForestOfLove.InteractionUiDemoMode::GetAvailableOptionIndex(TheForestOfLove.InteractionUiOption,System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: br.s IL_0019
IL_0004: ldarg.0
IL_0005: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiDemoMode::availableOptions
IL_000a: ldloc.0
IL_000b: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Item(System.Int32)
IL_0010: ldarg.1
IL_0011: bne.un.s IL_0015
IL_0013: ldloc.0
IL_0014: ret
IL_0015: ldloc.0
IL_0016: ldc.i4.1
IL_0017: add
IL_0018: stloc.0
IL_0019: ldloc.0
IL_001a: ldarg.0
IL_001b: ldfld System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption> TheForestOfLove.InteractionUiDemoMode::availableOptions
IL_0020: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.InteractionUiOption>::get_Count()
IL_0025: blt.s IL_0004
IL_0027: ldarg.2
IL_0028: brtrue.s IL_004b
IL_002a: ldstr "option "
IL_002f: ldarga.s fromOption
IL_0031: constrained. TheForestOfLove.InteractionUiOption
IL_0037: callvirt System.String System.Object::ToString()
IL_003c: ldstr " not found in available options list!"
IL_0041: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0046: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_004b: ldc.i4.0
IL_004c: ret
