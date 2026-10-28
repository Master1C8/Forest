TYPE Tantawowa.TimelineEvents.EventInvocationInfo
METHOD System.Void Tantawowa.TimelineEvents.EventInvocationInfo::Invoke(System.Object) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Reflection.MethodInfo Tantawowa.TimelineEvents.EventInvocationInfo::MethodInfo
IL_0006: ldnull
IL_0007: call System.Boolean System.Reflection.MethodInfo::op_Inequality(System.Reflection.MethodInfo,System.Reflection.MethodInfo)
IL_000c: brfalse.s IL_002a
IL_000e: ldarg.0
IL_000f: ldfld System.Reflection.MethodInfo Tantawowa.TimelineEvents.EventInvocationInfo::MethodInfo
IL_0014: ldarg.0
IL_0015: ldfld UnityEngine.Behaviour Tantawowa.TimelineEvents.EventInvocationInfo::TargetBehaviour
IL_001a: ldc.i4.1
IL_001b: newarr System.Object
IL_0020: dup
IL_0021: ldc.i4.0
IL_0022: ldarg.1
IL_0023: stelem.ref
IL_0024: callvirt System.Object System.Reflection.MethodBase::Invoke(System.Object,System.Object[])
IL_0029: pop
IL_002a: ret
METHOD System.Void Tantawowa.TimelineEvents.EventInvocationInfo::Invoke(System.Boolean,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse IL_0152
IL_0006: ldarg.0
IL_0007: ldfld System.Reflection.MethodInfo Tantawowa.TimelineEvents.EventInvocationInfo::MethodInfo
IL_000c: callvirt System.Reflection.ParameterInfo[] System.Reflection.MethodBase::GetParameters()
IL_0011: ldc.i4.0
IL_0012: ldelem.ref
IL_0013: callvirt System.Type System.Reflection.ParameterInfo::get_ParameterType()
IL_0018: stloc.0
IL_0019: ldloc.0
IL_001a: callvirt System.Boolean System.Type::get_IsEnum()
IL_001f: brfalse.s IL_0037
IL_0021: ldarg.0
IL_0022: ldarg.2
IL_0023: call T Tantawowa.Extensions.PrimitiveExtensions::ConvertToType<System.Int32>(System.String)
IL_0028: box System.Int32
IL_002d: call System.Void Tantawowa.TimelineEvents.EventInvocationInfo::Invoke(System.Object)
IL_0032: br IL_0158
IL_0037: ldsfld System.Type[] Tantawowa.TimelineEvents.EventInvocationInfo::SupportedTypes
IL_003c: ldloc.0
IL_003d: call System.Boolean System.Linq.Enumerable::Contains<System.Type>(System.Collections.Generic.IEnumerable`1<!!0>,!!0)
IL_0042: brfalse IL_0116
IL_0047: ldloc.0
IL_0048: ldtoken System.String
IL_004d: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0052: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_0057: brfalse.s IL_0065
IL_0059: ldarg.0
IL_005a: ldarg.2
IL_005b: call System.Void Tantawowa.TimelineEvents.EventInvocationInfo::Invoke(System.Object)
IL_0060: br IL_0158
IL_0065: ldloc.0
IL_0066: ldtoken System.Int32
IL_006b: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0070: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_0075: brfalse.s IL_008d
IL_0077: ldarg.0
IL_0078: ldarg.2
IL_0079: call T Tantawowa.Extensions.PrimitiveExtensions::ConvertToType<System.Int32>(System.String)
IL_007e: box System.Int32
IL_0083: call System.Void Tantawowa.TimelineEvents.EventInvocationInfo::Invoke(System.Object)
IL_0088: br IL_0158
IL_008d: ldloc.0
IL_008e: ldtoken System.Single
IL_0093: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0098: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_009d: brfalse.s IL_00b5
IL_009f: ldarg.0
IL_00a0: ldarg.2
IL_00a1: call T Tantawowa.Extensions.PrimitiveExtensions::ConvertToType<System.Single>(System.String)
IL_00a6: box System.Single
IL_00ab: call System.Void Tantawowa.TimelineEvents.EventInvocationInfo::Invoke(System.Object)
IL_00b0: br IL_0158
IL_00b5: ldloc.0
IL_00b6: ldtoken System.Boolean
IL_00bb: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_00c0: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_00c5: brfalse.s IL_00da
IL_00c7: ldarg.0
IL_00c8: ldarg.2
IL_00c9: call T Tantawowa.Extensions.PrimitiveExtensions::ConvertToType<System.Boolean>(System.String)
IL_00ce: box System.Boolean
IL_00d3: call System.Void Tantawowa.TimelineEvents.EventInvocationInfo::Invoke(System.Object)
IL_00d8: br.s IL_0158
IL_00da: ldc.i4.5
IL_00db: newarr System.String
IL_00e0: dup
IL_00e1: ldc.i4.0
IL_00e2: ldstr "Could not parse argument value "
IL_00e7: stelem.ref
IL_00e8: dup
IL_00e9: ldc.i4.1
IL_00ea: ldarg.2
IL_00eb: stelem.ref
IL_00ec: dup
IL_00ed: ldc.i4.2
IL_00ee: ldstr " for method "
IL_00f3: stelem.ref
IL_00f4: dup
IL_00f5: ldc.i4.3
IL_00f6: ldarg.0
IL_00f7: ldfld System.Reflection.MethodInfo Tantawowa.TimelineEvents.EventInvocationInfo::MethodInfo
IL_00fc: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_0101: stelem.ref
IL_0102: dup
IL_0103: ldc.i4.4
IL_0104: ldstr ". Ignoring"
IL_0109: stelem.ref
IL_010a: call System.String System.String::Concat(System.String[])
IL_010f: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0114: br.s IL_0158
IL_0116: ldc.i4.5
IL_0117: newarr System.String
IL_011c: dup
IL_011d: ldc.i4.0
IL_011e: ldstr "Could not parse argument value "
IL_0123: stelem.ref
IL_0124: dup
IL_0125: ldc.i4.1
IL_0126: ldarg.2
IL_0127: stelem.ref
IL_0128: dup
IL_0129: ldc.i4.2
IL_012a: ldstr " for method "
IL_012f: stelem.ref
IL_0130: dup
IL_0131: ldc.i4.3
IL_0132: ldarg.0
IL_0133: ldfld System.Reflection.MethodInfo Tantawowa.TimelineEvents.EventInvocationInfo::MethodInfo
IL_0138: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_013d: stelem.ref
IL_013e: dup
IL_013f: ldc.i4.4
IL_0140: ldstr ". Ignoring"
IL_0145: stelem.ref
IL_0146: call System.String System.String::Concat(System.String[])
IL_014b: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0150: br.s IL_0158
IL_0152: ldarg.0
IL_0153: call System.Void Tantawowa.TimelineEvents.EventInvocationInfo::InvokeNoArgs()
IL_0158: leave.s IL_0189
IL_015a: stloc.1
IL_015b: ldstr "Exception while executing timeline event "
IL_0160: ldarg.0
IL_0161: ldfld System.Reflection.MethodInfo Tantawowa.TimelineEvents.EventInvocationInfo::MethodInfo
IL_0166: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_016b: ldstr " "
IL_0170: ldloc.1
IL_0171: dup
IL_0172: brtrue.s IL_0178
IL_0174: pop
IL_0175: ldnull
IL_0176: br.s IL_017d
IL_0178: callvirt System.String System.Object::ToString()
IL_017d: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0182: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0187: leave.s IL_0189
IL_0189: ret
