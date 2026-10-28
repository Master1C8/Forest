TYPE TheForestOfLove.GlitchRascalPart1Story
METHOD System.Void TheForestOfLove.GlitchRascalPart1Story::SetAnimatorTrigger(UnityEngine.Animator,System.Collections.Generic.List`1<System.String>,System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_0006: stloc.0
IL_0007: br.s IL_0018
IL_0009: ldloca.s V_0
IL_000b: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_0010: stloc.1
IL_0011: ldarg.1
IL_0012: ldloc.1
IL_0013: callvirt System.Void UnityEngine.Animator::ResetTrigger(System.String)
IL_0018: ldloca.s V_0
IL_001a: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_001f: brtrue.s IL_0009
IL_0021: leave.s IL_0031
IL_0023: ldloca.s V_0
IL_0025: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_002b: callvirt System.Void System.IDisposable::Dispose()
IL_0030: endfinally
IL_0031: ldarg.1
IL_0032: ldarg.3
IL_0033: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0038: ret
