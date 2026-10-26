METHOD System.String ForestProbe::BuckyRuntimeListeners(UnityEngine.Events.UnityEventBase) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldtoken UnityEngine.Events.UnityEventBase
IL_0006: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_000b: ldstr "m_Calls"
IL_0010: ldc.i4.s 36
IL_0012: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0017: ldarg.0
IL_0018: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_001d: stloc.0
IL_001e: ldloc.0
IL_001f: ldstr "m_RuntimeCalls"
IL_0024: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0029: isinst System.Collections.IList
IL_002e: stloc.1
IL_002f: ldloc.1
IL_0030: brfalse.s IL_003e
IL_0032: ldloc.1
IL_0033: callvirt System.Int32 System.Collections.ICollection::get_Count()
IL_0038: ldc.i4.s 16
IL_003a: cgt
IL_003c: br.s IL_003f
IL_003e: ldc.i4.1
IL_003f: stloc.3
IL_0040: ldloc.3
IL_0041: brfalse.s IL_004e
IL_0043: ldstr "Missing or unbounded Bucky collision listeners"
IL_0048: newobj System.Void System.Exception::.ctor(System.String)
IL_004d: throw
IL_004e: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0053: stloc.2
IL_0054: nop
IL_0055: ldloc.1
IL_0056: callvirt System.Collections.IEnumerator System.Collections.IEnumerable::GetEnumerator()
IL_005b: stloc.s V_4
IL_005d: br.s IL_00b2
IL_005f: ldloc.s V_4
IL_0061: callvirt System.Object System.Collections.IEnumerator::get_Current()
IL_0066: stloc.s V_5
IL_0068: nop
IL_0069: ldloc.s V_5
IL_006b: ldstr "Delegate"
IL_0070: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_0075: isinst System.Delegate
IL_007a: stloc.s V_6
IL_007c: ldloc.s V_6
IL_007e: brfalse.s IL_0091
IL_0080: ldloc.s V_6
IL_0082: callvirt System.Delegate[] System.Delegate::GetInvocationList()
IL_0087: ldlen
IL_0088: conv.i4
IL_0089: ldc.i4.1
IL_008a: ceq
IL_008c: ldc.i4.0
IL_008d: ceq
IL_008f: br.s IL_0092
IL_0091: ldc.i4.1
IL_0092: stloc.s V_7
IL_0094: ldloc.s V_7
IL_0096: brfalse.s IL_00a3
IL_0098: ldstr "Unknown Bucky collision callback"
IL_009d: newobj System.Void System.Exception::.ctor(System.String)
IL_00a2: throw
IL_00a3: ldloc.2
IL_00a4: ldloc.s V_6
IL_00a6: call System.String ForestProbe::BuckyCallback(System.Delegate)
IL_00ab: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00b0: nop
IL_00b1: nop
IL_00b2: ldloc.s V_4
IL_00b4: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_00b9: brtrue.s IL_005f
IL_00bb: leave.s IL_00d3
IL_00bd: ldloc.s V_4
IL_00bf: isinst System.IDisposable
IL_00c4: stloc.s V_8
IL_00c6: ldloc.s V_8
IL_00c8: brfalse.s IL_00d2
IL_00ca: ldloc.s V_8
IL_00cc: callvirt System.Void System.IDisposable::Dispose()
IL_00d1: nop
IL_00d2: endfinally
IL_00d3: ldloc.2
IL_00d4: call System.StringComparer System.StringComparer::get_Ordinal()
IL_00d9: callvirt System.Void System.Collections.Generic.List`1<System.String>::Sort(System.Collections.Generic.IComparer`1<!0>)
IL_00de: nop
IL_00df: ldstr "persistent="
IL_00e4: ldarg.0
IL_00e5: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_00ea: stloc.s V_9
IL_00ec: ldloca.s V_9
IL_00ee: call System.String System.Int32::ToString()
IL_00f3: ldstr " | callbacks="
IL_00f8: ldstr ","
IL_00fd: ldloc.2
IL_00fe: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0103: call System.String System.String::Join(System.String,System.String[])
IL_0108: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_010d: stloc.s V_10
IL_010f: br.s IL_0111
IL_0111: ldloc.s V_10
IL_0113: ret
