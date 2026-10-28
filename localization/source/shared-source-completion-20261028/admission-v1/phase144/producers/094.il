TYPE TheForestOfLove.GlitchRascalPart1Story
METHOD System.Void TheForestOfLove.GlitchRascalPart1Story::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0006: dup
IL_0007: ldstr "reset"
IL_000c: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0011: dup
IL_0012: ldstr "show"
IL_0017: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_001c: dup
IL_001d: ldstr "hide"
IL_0022: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0027: dup
IL_0028: ldstr "visible"
IL_002d: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0032: stfld System.Collections.Generic.List`1<System.String> TheForestOfLove.GlitchRascalPart1Story::blackBackgroundAnimatorTriggers
IL_0037: ldarg.0
IL_0038: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_003d: dup
IL_003e: ldstr "reset"
IL_0043: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0048: dup
IL_0049: ldstr "show"
IL_004e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0053: dup
IL_0054: ldstr "hide"
IL_0059: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_005e: dup
IL_005f: ldstr "visible"
IL_0064: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0069: stfld System.Collections.Generic.List`1<System.String> TheForestOfLove.GlitchRascalPart1Story::summonRascalAnimatorTriggers
IL_006e: ldarg.0
IL_006f: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0074: dup
IL_0075: ldstr "reset"
IL_007a: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_007f: dup
IL_0080: ldstr "small_glitch"
IL_0085: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_008a: dup
IL_008b: ldstr "medium_glitch"
IL_0090: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0095: dup
IL_0096: ldstr "big_glitch"
IL_009b: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00a0: dup
IL_00a1: ldstr "big_reveal_glitch"
IL_00a6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00ab: dup
IL_00ac: ldstr "glitch_away"
IL_00b1: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00b6: dup
IL_00b7: ldstr "glitch_back"
IL_00bc: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00c1: stfld System.Collections.Generic.List`1<System.String> TheForestOfLove.GlitchRascalPart1Story::portraitGlitchAnimatorTriggers
IL_00c6: ldarg.0
IL_00c7: call System.Void TheForestOfLove.Core.BaseBehavior::.ctor()
IL_00cc: ret
