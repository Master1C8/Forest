TYPE ES3Settings
METHOD System.String ES3Settings::get_FullPath() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String ES3Settings::path
IL_0006: brtrue.s IL_0013
IL_0008: ldstr "The 'path' field of this ES3Settings is null, indicating that it was not possible to load the default settings from Resources. Please check that the ES3 Default Settings.prefab exists in Assets/Plugins/Resources/ES3/"
IL_000d: newobj System.Void System.NullReferenceException::.ctor(System.String)
IL_0012: throw
IL_0013: ldarg.0
IL_0014: ldfld System.String ES3Settings::path
IL_0019: call System.Boolean ES3Settings::IsAbsolute(System.String)
IL_001e: brfalse.s IL_0027
IL_0020: ldarg.0
IL_0021: ldfld System.String ES3Settings::path
IL_0026: ret
IL_0027: ldarg.0
IL_0028: call ES3/Location ES3Settings::get_location()
IL_002d: brtrue.s IL_0092
IL_002f: ldarg.0
IL_0030: ldfld ES3/Directory ES3Settings::directory
IL_0035: brtrue.s IL_004d
IL_0037: ldsfld System.String ES3Internal.ES3IO::persistentDataPath
IL_003c: ldstr "/"
IL_0041: ldarg.0
IL_0042: ldfld System.String ES3Settings::path
IL_0047: call System.String System.String::Concat(System.String,System.String,System.String)
IL_004c: ret
IL_004d: ldarg.0
IL_004e: ldfld ES3/Directory ES3Settings::directory
IL_0053: ldc.i4.1
IL_0054: bne.un.s IL_006c
IL_0056: call System.String UnityEngine.Application::get_dataPath()
IL_005b: ldstr "/"
IL_0060: ldarg.0
IL_0061: ldfld System.String ES3Settings::path
IL_0066: call System.String System.String::Concat(System.String,System.String,System.String)
IL_006b: ret
IL_006c: ldstr "File directory ""
IL_0071: ldarg.0
IL_0072: ldflda ES3/Directory ES3Settings::directory
IL_0077: constrained. ES3/Directory
IL_007d: callvirt System.String System.Object::ToString()
IL_0082: ldstr "" has not been implemented."
IL_0087: call System.String System.String::Concat(System.String,System.String,System.String)
IL_008c: newobj System.Void System.NotImplementedException::.ctor(System.String)
IL_0091: throw
IL_0092: ldarg.0
IL_0093: call ES3/Location ES3Settings::get_location()
IL_0098: ldc.i4.3
IL_0099: bne.un.s IL_0100
IL_009b: ldarg.0
IL_009c: ldfld System.String ES3Settings::path
IL_00a1: call System.String System.IO.Path::GetExtension(System.String)
IL_00a6: stloc.0
IL_00a7: ldc.i4.0
IL_00a8: stloc.1
IL_00a9: ldsfld System.String[] ES3Settings::resourcesExtensions
IL_00ae: stloc.2
IL_00af: ldc.i4.0
IL_00b0: stloc.3
IL_00b1: br.s IL_00ca
IL_00b3: ldloc.2
IL_00b4: ldloc.3
IL_00b5: ldelem.ref
IL_00b6: stloc.s V_4
IL_00b8: ldloc.0
IL_00b9: ldloc.s V_4
IL_00bb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00c0: brfalse.s IL_00c6
IL_00c2: ldc.i4.1
IL_00c3: stloc.1
IL_00c4: br.s IL_00d0
IL_00c6: ldloc.3
IL_00c7: ldc.i4.1
IL_00c8: add
IL_00c9: stloc.3
IL_00ca: ldloc.3
IL_00cb: ldloc.2
IL_00cc: ldlen
IL_00cd: conv.i4
IL_00ce: blt.s IL_00b3
IL_00d0: ldloc.1
IL_00d1: brtrue.s IL_00ee
IL_00d3: ldstr "Extension of file in Resources must be .json, .bytes, .txt, .csv, .htm, .html, .xml, .yaml or .fnt, but path given was ""
IL_00d8: ldarg.0
IL_00d9: ldfld System.String ES3Settings::path
IL_00de: ldstr """
IL_00e3: call System.String System.String::Concat(System.String,System.String,System.String)
IL_00e8: newobj System.Void System.ArgumentException::.ctor(System.String)
IL_00ed: throw
IL_00ee: ldarg.0
IL_00ef: ldfld System.String ES3Settings::path
IL_00f4: ldloc.0
IL_00f5: ldstr ""
IL_00fa: callvirt System.String System.String::Replace(System.String,System.String)
IL_00ff: ret
IL_0100: ldarg.0
IL_0101: ldfld System.String ES3Settings::path
IL_0106: ret
