TYPE TheForestOfLove.PlantMovie/Internal_PlantAnimationTransitionNotifier
METHOD System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.PlantMovie/PlantInternalMovieState> TheForestOfLove.PlantMovie/Internal_PlantAnimationTransitionNotifier::InitializeStatesByClipName() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.PlantMovie/PlantInternalMovieState>::.ctor()
IL_0005: dup
IL_0006: ldstr "PlantMovie_Tentacles_Idle"
IL_000b: ldc.i4.0
IL_000c: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.PlantMovie/PlantInternalMovieState>::Add(!0,!1)
IL_0011: dup
IL_0012: ldstr "PlantMovie_Tentacles_LickingLips"
IL_0017: ldc.i4.1
IL_0018: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.PlantMovie/PlantInternalMovieState>::Add(!0,!1)
IL_001d: ret
