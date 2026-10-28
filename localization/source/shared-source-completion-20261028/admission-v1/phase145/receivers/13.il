TYPE TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper
METHOD System.Collections.Generic.List`1<System.String> TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::ReadPlayerPrefsJsonStringList(System.String) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0005: stloc.0
IL_0006: ldarg.0
IL_0007: call System.Boolean UnityEngine.PlayerPrefs::HasKey(System.String)
IL_000c: brfalse.s IL_0076
IL_000e: ldarg.0
IL_000f: call System.String UnityEngine.PlayerPrefs::GetString(System.String)
IL_0014: call System.Object SRF.Json::Deserialize(System.String)
IL_0019: castclass System.Collections.Generic.List`1<System.Object>
IL_001e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.Object>::GetEnumerator()
IL_0023: stloc.1
IL_0024: br.s IL_003a
IL_0026: ldloca.s V_1
IL_0028: call !0 System.Collections.Generic.List`1/Enumerator<System.Object>::get_Current()
IL_002d: stloc.2
IL_002e: ldloc.0
IL_002f: ldloc.2
IL_0030: callvirt System.String System.Object::ToString()
IL_0035: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_003a: ldloca.s V_1
IL_003c: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.Object>::MoveNext()
IL_0041: brtrue.s IL_0026
IL_0043: leave.s IL_0053
IL_0045: ldloca.s V_1
IL_0047: constrained. System.Collections.Generic.List`1/Enumerator<System.Object>
IL_004d: callvirt System.Void System.IDisposable::Dispose()
IL_0052: endfinally
IL_0053: leave.s IL_0076
IL_0055: ldstr "Global Savestate PlayerPrefs Json Deserialize Failed!"
IL_005a: call System.Void UnityEngine.Debug::Log(System.Object)
IL_005f: dup
IL_0060: callvirt System.String System.Exception::get_Message()
IL_0065: call System.Void UnityEngine.Debug::Log(System.Object)
IL_006a: callvirt System.String System.Exception::get_StackTrace()
IL_006f: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0074: leave.s IL_0076
IL_0076: ldloc.0
IL_0077: ret
