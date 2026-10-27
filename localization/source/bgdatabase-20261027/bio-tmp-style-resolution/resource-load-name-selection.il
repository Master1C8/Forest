TYPE UnityEngine.Resources
METHOD UnityEngine.Object UnityEngine.Resources::Load(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldtoken UnityEngine.Object
IL_0007: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_000c: call UnityEngine.Object UnityEngine.Resources::Load(System.String,System.Type)
IL_0011: stloc.0
IL_0012: br.s IL_0014
IL_0014: ldloc.0
IL_0015: ret
METHOD T UnityEngine.Resources::Load(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldtoken T
IL_0007: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_000c: call UnityEngine.Object UnityEngine.Resources::Load(System.String,System.Type)
IL_0011: unbox.any T
IL_0016: stloc.0
IL_0017: br.s IL_0019
IL_0019: ldloc.0
IL_001a: ret
METHOD UnityEngine.Object UnityEngine.Resources::Load(System.String,System.Type) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: call UnityEngine.ResourcesAPI UnityEngine.ResourcesAPI::get_ActiveAPI()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: callvirt UnityEngine.Object UnityEngine.ResourcesAPI::Load(System.String,System.Type)
IL_000d: stloc.0
IL_000e: br.s IL_0010
IL_0010: ldloc.0
IL_0011: ret
