TYPE UnityEngine.ResourcesAPI
METHOD UnityEngine.ResourcesAPI UnityEngine.ResourcesAPI::get_ActiveAPI() | attributes=Assembly, Static, HideBySig, SpecialName | impl=IL
IL_0000: call UnityEngine.ResourcesAPI UnityEngine.ResourcesAPI::get_overrideAPI()
IL_0005: dup
IL_0006: brtrue.s IL_000e
IL_0008: pop
IL_0009: ldsfld UnityEngine.ResourcesAPI UnityEngine.ResourcesAPI::s_DefaultAPI
IL_000e: ret
METHOD UnityEngine.Object UnityEngine.ResourcesAPI::Load(System.String,System.Type) | attributes=FamORAssem, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.2
IL_0002: call UnityEngine.Object UnityEngine.ResourcesAPIInternal::Load(System.String,System.Type)
IL_0007: ret
