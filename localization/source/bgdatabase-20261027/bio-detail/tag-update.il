TYPE TheForestOfLove.Narrative.NarrativeActions
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::UpdateTags(System.Collections.Generic.List`1<System.String>,System.Collections.Generic.List`1<System.String>) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Services.Persistence.DataService::GetActiveTags()
IL_0007: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_000c: ldsfld System.Func`2<TheForestOfLove.Narrative.Tag,System.String> TheForestOfLove.Narrative.NarrativeActions/<>c::<>9__24_0
IL_0011: dup
IL_0012: brtrue.s IL_002b
IL_0014: pop
IL_0015: ldsfld TheForestOfLove.Narrative.NarrativeActions/<>c TheForestOfLove.Narrative.NarrativeActions/<>c::<>9
IL_001a: ldftn System.String TheForestOfLove.Narrative.NarrativeActions/<>c::<UpdateTags>b__24_0(TheForestOfLove.Narrative.Tag)
IL_0020: newobj System.Void System.Func`2<TheForestOfLove.Narrative.Tag,System.String>::.ctor(System.Object,System.IntPtr)
IL_0025: dup
IL_0026: stsfld System.Func`2<TheForestOfLove.Narrative.Tag,System.String> TheForestOfLove.Narrative.NarrativeActions/<>c::<>9__24_0
IL_002b: call System.Collections.Generic.IEnumerable`1<!!1> System.Linq.Enumerable::Select<TheForestOfLove.Narrative.Tag,System.String>(System.Collections.Generic.IEnumerable`1<!!0>,System.Func`2<!!0,!!1>)
IL_0030: call System.Collections.Generic.List`1<!!0> System.Linq.Enumerable::ToList<System.String>(System.Collections.Generic.IEnumerable`1<!!0>)
IL_0035: stloc.1
IL_0036: ldarg.1
IL_0037: brfalse.s IL_0074
IL_0039: ldarg.1
IL_003a: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_003f: stloc.2
IL_0040: br.s IL_005b
IL_0042: ldloca.s V_2
IL_0044: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_0049: stloc.3
IL_004a: ldloc.1
IL_004b: ldloc.3
IL_004c: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_0051: brfalse.s IL_005b
IL_0053: ldc.i4.1
IL_0054: stloc.0
IL_0055: ldloc.3
IL_0056: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveTagFromActive(System.String)
IL_005b: ldloca.s V_2
IL_005d: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_0062: brtrue.s IL_0042
IL_0064: leave.s IL_0074
IL_0066: ldloca.s V_2
IL_0068: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_006e: callvirt System.Void System.IDisposable::Dispose()
IL_0073: endfinally
IL_0074: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Services.Persistence.DataService::GetActiveTags()
IL_0079: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_007e: ldsfld System.Func`2<TheForestOfLove.Narrative.Tag,System.String> TheForestOfLove.Narrative.NarrativeActions/<>c::<>9__24_1
IL_0083: dup
IL_0084: brtrue.s IL_009d
IL_0086: pop
IL_0087: ldsfld TheForestOfLove.Narrative.NarrativeActions/<>c TheForestOfLove.Narrative.NarrativeActions/<>c::<>9
IL_008c: ldftn System.String TheForestOfLove.Narrative.NarrativeActions/<>c::<UpdateTags>b__24_1(TheForestOfLove.Narrative.Tag)
IL_0092: newobj System.Void System.Func`2<TheForestOfLove.Narrative.Tag,System.String>::.ctor(System.Object,System.IntPtr)
IL_0097: dup
IL_0098: stsfld System.Func`2<TheForestOfLove.Narrative.Tag,System.String> TheForestOfLove.Narrative.NarrativeActions/<>c::<>9__24_1
IL_009d: call System.Collections.Generic.IEnumerable`1<!!1> System.Linq.Enumerable::Select<TheForestOfLove.Narrative.Tag,System.String>(System.Collections.Generic.IEnumerable`1<!!0>,System.Func`2<!!0,!!1>)
IL_00a2: call System.Collections.Generic.List`1<!!0> System.Linq.Enumerable::ToList<System.String>(System.Collections.Generic.IEnumerable`1<!!0>)
IL_00a7: stloc.1
IL_00a8: ldarg.0
IL_00a9: brfalse.s IL_00e9
IL_00ab: ldarg.0
IL_00ac: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_00b1: stloc.2
IL_00b2: br.s IL_00d0
IL_00b4: ldloca.s V_2
IL_00b6: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_00bb: stloc.s V_4
IL_00bd: ldloc.1
IL_00be: ldloc.s V_4
IL_00c0: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_00c5: brtrue.s IL_00d0
IL_00c7: ldc.i4.1
IL_00c8: stloc.0
IL_00c9: ldloc.s V_4
IL_00cb: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddTagToActive(System.String)
IL_00d0: ldloca.s V_2
IL_00d2: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_00d7: brtrue.s IL_00b4
IL_00d9: leave.s IL_00e9
IL_00db: ldloca.s V_2
IL_00dd: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_00e3: callvirt System.Void System.IDisposable::Dispose()
IL_00e8: endfinally
IL_00e9: ldloc.0
IL_00ea: brfalse.s IL_00f6
IL_00ec: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onActiveTagsChanged
IL_00f1: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00f6: ret
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::UpdateTags(System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldarg.1
IL_0003: brfalse.s IL_0035
IL_0005: ldarg.1
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_000b: stloc.1
IL_000c: br.s IL_001c
IL_000e: ldloca.s V_1
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_0015: ldc.i4.1
IL_0016: stloc.0
IL_0017: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveTagFromActive(TheForestOfLove.Narrative.Tag)
IL_001c: ldloca.s V_1
IL_001e: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_0023: brtrue.s IL_000e
IL_0025: leave.s IL_0035
IL_0027: ldloca.s V_1
IL_0029: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_002f: callvirt System.Void System.IDisposable::Dispose()
IL_0034: endfinally
IL_0035: ldarg.0
IL_0036: brfalse.s IL_0068
IL_0038: ldarg.0
IL_0039: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_003e: stloc.1
IL_003f: br.s IL_004f
IL_0041: ldloca.s V_1
IL_0043: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_0048: ldc.i4.1
IL_0049: stloc.0
IL_004a: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddTagToActive(TheForestOfLove.Narrative.Tag)
IL_004f: ldloca.s V_1
IL_0051: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_0056: brtrue.s IL_0041
IL_0058: leave.s IL_0068
IL_005a: ldloca.s V_1
IL_005c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_0062: callvirt System.Void System.IDisposable::Dispose()
IL_0067: endfinally
IL_0068: ldloc.0
IL_0069: brfalse.s IL_0075
IL_006b: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onActiveTagsChanged
IL_0070: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0075: ret
