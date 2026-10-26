TYPE Rewired.Utils.Classes.Utility.ValueWatcher`1
METHOD T Rewired.Utils.Classes.Utility.ValueWatcher`1::get_value() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld T Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::eAKYTWpmchhzPZnAFYwhyHoMSuu
IL_0006: ret
METHOD System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1::.ctor(T,System.Boolean) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void Rewired.Utils.Classes.Utility.ValueWatcher::.ctor()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: stfld T Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::eAKYTWpmchhzPZnAFYwhyHoMSuu
IL_000d: ldarg.0
IL_000e: ldarg.2
IL_000f: stfld System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::oFKZGzubknviKoVewMnVkZVHULm
IL_0014: ret
METHOD System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1::.ctor(T,System.Func`1<T>,System.Boolean) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.3
IL_0003: call System.Void Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::.ctor(T,System.Boolean)
IL_0008: ldarg.0
IL_0009: ldarg.2
IL_000a: stfld System.Func`1<T> Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::TenHBVpYBIaGtZIcXHrwKtCLyfF
IL_000f: ret
METHOD System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1::Update() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Func`1<T> Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::TenHBVpYBIaGtZIcXHrwKtCLyfF
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldarg.0
IL_000c: ldfld System.Func`1<T> Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::TenHBVpYBIaGtZIcXHrwKtCLyfF
IL_0011: callvirt !0 System.Func`1<T>::Invoke()
IL_0016: call System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::Set(T)
IL_001b: stloc.1
IL_001c: leave.s IL_0033
IL_001e: stloc.0
IL_001f: ldstr "An exception was thrown by getValueDelegate.
"
IL_0024: ldloc.0
IL_0025: call System.String System.String::Concat(System.Object,System.Object)
IL_002a: call System.Void Rewired.Logger::LogError(System.Object)
IL_002f: ldc.i4.0
IL_0030: stloc.1
IL_0031: leave.s IL_0033
IL_0033: ldloc.1
IL_0034: ret
METHOD System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1::TriggerEvent() | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::KEzfIYEQzEPHHpufVSLVziRLavZL
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.0
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.Action`1<T> Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::LhFNSYdrNTJajOFgNQhCZDAHysq
IL_0010: brtrue.s IL_0014
IL_0012: ldc.i4.1
IL_0013: ret
IL_0014: ldarg.0
IL_0015: callvirt System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher::Use()
IL_001a: pop
IL_001b: ldarg.0
IL_001c: ldfld System.Action`1<T> Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::LhFNSYdrNTJajOFgNQhCZDAHysq
IL_0021: ldarg.0
IL_0022: ldfld T Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::eAKYTWpmchhzPZnAFYwhyHoMSuu
IL_0027: callvirt System.Void System.Action`1<T>::Invoke(!0)
IL_002c: ldc.i4.1
IL_002d: stloc.1
IL_002e: leave.s IL_006a
IL_0030: stloc.0
IL_0031: ldc.i4 321106443
IL_0036: ldc.i4 321106442
IL_003b: xor
IL_003c: switch IL_0031,IL_004f,IL_0066
IL_004d: br.s IL_0066
IL_004f: ldstr "An exception was thrown by ValueChangedEvent handler.
"
IL_0054: ldloc.0
IL_0055: call System.String System.String::Concat(System.Object,System.Object)
IL_005a: call System.Void Rewired.Logger::LogError(System.Object)
IL_005f: ldc.i4 321106440
IL_0064: br.s IL_0036
IL_0066: ldc.i4.0
IL_0067: stloc.1
IL_0068: leave.s IL_006a
IL_006a: ldloc.1
IL_006b: ret
METHOD System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1::Set(T) | attributes=Public, HideBySig | impl=IL
IL_0000: ldsfld System.Collections.Generic.IEqualityComparer`1<T> Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::oqYJsMKqyqXKPHhTtDYVehAZingh
IL_0005: ldarg.0
IL_0006: ldfld T Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::eAKYTWpmchhzPZnAFYwhyHoMSuu
IL_000b: ldarg.1
IL_000c: callvirt System.Boolean System.Collections.Generic.IEqualityComparer`1<T>::Equals(!0,!0)
IL_0011: brfalse.s IL_0015
IL_0013: ldc.i4.0
IL_0014: ret
IL_0015: ldarg.0
IL_0016: ldarg.1
IL_0017: stfld T Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::eAKYTWpmchhzPZnAFYwhyHoMSuu
IL_001c: ldarg.0
IL_001d: ldc.i4.1
IL_001e: stfld System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::KEzfIYEQzEPHHpufVSLVziRLavZL
IL_0023: ldc.i4 -691789055
IL_0028: ldc.i4 -691789053
IL_002d: xor
IL_002e: switch IL_0023,IL_0057,IL_0041
IL_003f: br.s IL_0057
IL_0041: ldarg.0
IL_0042: ldfld System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher`1<T>::oFKZGzubknviKoVewMnVkZVHULm
IL_0047: brfalse.s IL_0057
IL_0049: ldarg.0
IL_004a: callvirt System.Boolean Rewired.Utils.Classes.Utility.ValueWatcher::TriggerEvent()
IL_004f: pop
IL_0050: ldc.i4 -691789054
IL_0055: br.s IL_0028
IL_0057: ldc.i4.1
IL_0058: ret
