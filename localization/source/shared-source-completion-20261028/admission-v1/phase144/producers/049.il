TYPE TheForestOfLove.Core.SceneSetup.FirstLaunch
METHOD System.Void TheForestOfLove.Core.SceneSetup.FirstLaunch::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "en-US"
IL_0005: newobj System.Void System.Globalization.CultureInfo::.ctor(System.String)
IL_000a: dup
IL_000b: call System.Void System.Globalization.CultureInfo::set_DefaultThreadCurrentCulture(System.Globalization.CultureInfo)
IL_0010: call System.Void System.Globalization.CultureInfo::set_DefaultThreadCurrentUICulture(System.Globalization.CultureInfo)
IL_0015: ldstr "starting tfol version "
IL_001a: call System.String TheForestOfLove.GameVersionHelper::GetApplicationVersion_MajorVersionOnly()
IL_001f: call System.String System.String::Concat(System.String,System.String)
IL_0024: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0029: ret
