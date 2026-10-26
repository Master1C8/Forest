TYPE ForestProbe
METHOD System.Void ForestProbe::Install()
IL_0000: nop
IL_0001: ldstr "FOREST_STARTUP INSTALL_ENTER company="
IL_0006: call System.String UnityEngine.Application::get_companyName()
IL_000b: ldstr " product="
IL_0010: call System.String UnityEngine.Application::get_productName()
IL_0015: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_001a: call System.Void UnityEngine.Debug::Log(System.Object)
IL_001f: nop
IL_0020: call System.String UnityEngine.Application::get_companyName()
IL_0025: ldstr "VNRevivalQA"
IL_002a: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_002f: brtrue.s IL_0042
IL_0031: call System.String UnityEngine.Application::get_productName()
IL_0036: ldstr "ForestRuRendererProbe"
IL_003b: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0040: br.s IL_0043
IL_0042: ldc.i4.1
IL_0043: stloc.1
IL_0044: ldloc.1
IL_0045: brfalse.s IL_0052
IL_0047: ldstr "QA bridge requires the isolated player identity."
IL_004c: newobj System.Void System.InvalidOperationException::.ctor(System.String)
IL_0051: throw
IL_0052: ldstr "FOREST_STARTUP IDENTITY_ACCEPTED"
IL_0057: call System.Void UnityEngine.Debug::Log(System.Object)
IL_005c: nop
IL_005d: ldstr "ForestRendererProbeBridge"
IL_0062: newobj System.Void UnityEngine.GameObject::.ctor(System.String)
IL_0067: stloc.0
IL_0068: ldloc.0
IL_0069: call System.Void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)
IL_006e: nop
IL_006f: ldstr "FOREST_STARTUP BEFORE_ADD_COMPONENT"
IL_0074: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0079: nop
IL_007a: ldloc.0
IL_007b: callvirt !!0 UnityEngine.GameObject::AddComponent<ForestProbe>()
IL_0080: pop
IL_0081: ldstr "FOREST_STARTUP INSTALL_RETURN"
IL_0086: call System.Void UnityEngine.Debug::Log(System.Object)
IL_008b: nop
IL_008c: ret
METHOD System.Void ForestProbe::Awake()
IL_0000: nop
IL_0001: ldstr "FOREST_STARTUP AWAKE_ENTER"
IL_0006: call System.Void UnityEngine.Debug::Log(System.Object)
IL_000b: nop
IL_000c: ldarg.0
IL_000d: call System.String UnityEngine.Application::get_dataPath()
IL_0012: ldstr "../.."
IL_0017: call System.String System.IO.Path::Combine(System.String,System.String)
IL_001c: call System.String System.IO.Path::GetFullPath(System.String)
IL_0021: stfld System.String ForestProbe::root
IL_0026: ldstr "FOREST_PROBE_READY "
IL_002b: ldarg.0
IL_002c: ldfld System.String ForestProbe::root
IL_0031: ldstr " SAVES "
IL_0036: call System.String UnityEngine.Application::get_persistentDataPath()
IL_003b: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0040: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0045: nop
IL_0046: ret
