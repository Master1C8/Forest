TYPE TheForestOfLove.SquirrelAnalMovie/Internal_AnimationTransitionNotifier
METHOD System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.SquirrelAnalMovie/InternalMovieState> TheForestOfLove.SquirrelAnalMovie/Internal_AnimationTransitionNotifier::InitializeStatesByClipName() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.SquirrelAnalMovie/InternalMovieState>::.ctor()
IL_0005: dup
IL_0006: ldstr "Squirrel Scene_Squirrel_Loop1"
IL_000b: ldc.i4.0
IL_000c: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.SquirrelAnalMovie/InternalMovieState>::Add(!0,!1)
IL_0011: dup
IL_0012: ldstr "Squirrel Scene_Squirrel_Loop1Blink"
IL_0017: ldc.i4.1
IL_0018: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.SquirrelAnalMovie/InternalMovieState>::Add(!0,!1)
IL_001d: dup
IL_001e: ldstr "Squirrel Scene_Squirrel_Loop2"
IL_0023: ldc.i4.2
IL_0024: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.SquirrelAnalMovie/InternalMovieState>::Add(!0,!1)
IL_0029: dup
IL_002a: ldstr "Squirrel Scene_Squirrel_Pullout"
IL_002f: ldc.i4.3
IL_0030: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.SquirrelAnalMovie/InternalMovieState>::Add(!0,!1)
IL_0035: dup
IL_0036: ldstr "Squirrel Scene_Squirrel_Idle"
IL_003b: ldc.i4.4
IL_003c: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.SquirrelAnalMovie/InternalMovieState>::Add(!0,!1)
IL_0041: ret
