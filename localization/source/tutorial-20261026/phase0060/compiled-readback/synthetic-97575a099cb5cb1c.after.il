METHOD System.Object ForestProbe/<>c__DisplayClass42_0::<KeyboardEligibility>b__0(System.String) | attributes=Assembly, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Object ForestProbe/<>c__DisplayClass42_0::watchers
IL_0007: ldarg.1
IL_0008: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_000d: stloc.0
IL_000e: ldloc.0
IL_000f: callvirt System.Type System.Object::GetType()
IL_0014: ldstr "value"
IL_0019: callvirt System.Reflection.PropertyInfo System.Type::GetProperty(System.String)
IL_001e: ldloc.0
IL_001f: ldnull
IL_0020: callvirt System.Object System.Reflection.PropertyInfo::GetValue(System.Object,System.Object[])
IL_0025: stloc.1
IL_0026: br.s IL_0028
IL_0028: ldloc.1
IL_0029: ret
