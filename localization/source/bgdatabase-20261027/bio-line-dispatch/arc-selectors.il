TYPE TheForestOfLove.Narrative.Dialogue
METHOD TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetArcByName(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_0028
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0015: stloc.1
IL_0016: ldloc.1
IL_0017: ldfld System.String TheForestOfLove.Narrative.Arc::customName
IL_001c: ldarg.1
IL_001d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0022: brfalse.s IL_0028
IL_0024: ldloc.1
IL_0025: stloc.2
IL_0026: leave.s IL_0043
IL_0028: ldloca.s V_0
IL_002a: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_002f: brtrue.s IL_000e
IL_0031: leave.s IL_0041
IL_0033: ldloca.s V_0
IL_0035: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_003b: callvirt System.Void System.IDisposable::Dispose()
IL_0040: endfinally
IL_0041: ldnull
IL_0042: ret
IL_0043: ldloc.2
IL_0044: ret
METHOD TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetArcByGeneratedName(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::arcs
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_0028
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0015: stloc.1
IL_0016: ldloc.1
IL_0017: ldfld System.String TheForestOfLove.Narrative.Arc::generatedName
IL_001c: ldarg.1
IL_001d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0022: brfalse.s IL_0028
IL_0024: ldloc.1
IL_0025: stloc.2
IL_0026: leave.s IL_0043
IL_0028: ldloca.s V_0
IL_002a: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_002f: brtrue.s IL_000e
IL_0031: leave.s IL_0041
IL_0033: ldloca.s V_0
IL_0035: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_003b: callvirt System.Void System.IDisposable::Dispose()
IL_0040: endfinally
IL_0041: ldnull
IL_0042: ret
IL_0043: ldloc.2
IL_0044: ret
METHOD TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetFirstPrimaryArc() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::get_Count()
IL_000b: ldc.i4.0
IL_000c: ble.s IL_001b
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_0014: ldc.i4.0
IL_0015: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::get_Item(System.Int32)
IL_001a: ret
IL_001b: ldnull
IL_001c: ret
METHOD TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetFirstIdleArc() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::idleArcs
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::get_Count()
IL_000b: ldc.i4.0
IL_000c: ble.s IL_001b
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::idleArcs
IL_0014: ldc.i4.0
IL_0015: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::get_Item(System.Int32)
IL_001a: ret
IL_001b: ldnull
IL_001c: ret
METHOD TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetFirstNamedArc() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_0006: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::get_Count()
IL_000b: ldc.i4.0
IL_000c: ble.s IL_001b
IL_000e: ldarg.0
IL_000f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_0014: ldc.i4.0
IL_0015: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::get_Item(System.Int32)
IL_001a: ret
IL_001b: ldnull
IL_001c: ret
