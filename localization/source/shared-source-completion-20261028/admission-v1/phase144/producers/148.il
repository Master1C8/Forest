TYPE TheForestOfLove.Services.ServiceLocator
METHOD System.Void TheForestOfLove.Services.ServiceLocator::Register(T) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld System.Collections.Generic.Dictionary`2<System.Type,System.Object> TheForestOfLove.Services.ServiceLocator::services
IL_0005: ldtoken T
IL_000a: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_000f: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.Type,System.Object>::ContainsKey(!0)
IL_0014: brfalse.s IL_0039
IL_0016: ldstr "service already registered for type "
IL_001b: ldtoken T
IL_0020: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0025: callvirt System.String System.Object::ToString()
IL_002a: call System.String System.String::Concat(System.String,System.String)
IL_002f: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0034: call System.Void TheForestOfLove.Services.ServiceLocator::ForceUnregisterAll<T>()
IL_0039: ldsfld System.Collections.Generic.Dictionary`2<System.Type,System.Object> TheForestOfLove.Services.ServiceLocator::services
IL_003e: ldtoken T
IL_0043: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0048: ldarg.0
IL_0049: box T
IL_004e: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Type,System.Object>::Add(!0,!1)
IL_0053: ret
