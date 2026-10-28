TYPE TheForestOfLove.BugReportApiHelper
METHOD TheForestOfLove.CodecksApiSettings TheForestOfLove.BugReportApiHelper::LoadCodecksApiSettingsForLabel(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.CodecksApiSettings>::.ctor()
IL_0005: stloc.0
IL_0006: ldstr "Codecks/"
IL_000b: call !!0[] UnityEngine.Resources::LoadAll<TheForestOfLove.CodecksApiSettings>(System.String)
IL_0010: stloc.1
IL_0011: ldc.i4.0
IL_0012: stloc.2
IL_0013: br.s IL_0032
IL_0015: ldloc.1
IL_0016: ldloc.2
IL_0017: ldelem.ref
IL_0018: stloc.3
IL_0019: ldloc.3
IL_001a: ldfld System.String TheForestOfLove.CodecksApiSettings::label
IL_001f: ldarg.0
IL_0020: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0025: brfalse.s IL_002e
IL_0027: ldloc.0
IL_0028: ldloc.3
IL_0029: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.CodecksApiSettings>::Add(!0)
IL_002e: ldloc.2
IL_002f: ldc.i4.1
IL_0030: add
IL_0031: stloc.2
IL_0032: ldloc.2
IL_0033: ldloc.1
IL_0034: ldlen
IL_0035: conv.i4
IL_0036: blt.s IL_0015
IL_0038: ldloc.0
IL_0039: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.CodecksApiSettings>::get_Count()
IL_003e: brtrue.s IL_0052
IL_0040: ldstr "missing api settings scriptable object for label "
IL_0045: ldarg.0
IL_0046: call System.String System.String::Concat(System.String,System.String)
IL_004b: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0050: ldnull
IL_0051: ret
IL_0052: ldloc.0
IL_0053: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.CodecksApiSettings>::get_Count()
IL_0058: ldc.i4.1
IL_0059: ble.s IL_0072
IL_005b: ldstr "multiple api settings scriptable objects found for label "
IL_0060: ldarg.0
IL_0061: ldstr ", only one should exist"
IL_0066: call System.String System.String::Concat(System.String,System.String,System.String)
IL_006b: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0070: ldnull
IL_0071: ret
IL_0072: ldloc.0
IL_0073: ldc.i4.0
IL_0074: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.CodecksApiSettings>::get_Item(System.Int32)
IL_0079: ret
METHOD System.Void TheForestOfLove.BugReportApiHelper::OnApplicationMessageReceived(System.String,System.String,UnityEngine.LogType) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.3
IL_0001: brfalse.s IL_0007
IL_0003: ldarg.3
IL_0004: ldc.i4.4
IL_0005: bne.un.s IL_0072
IL_0007: ldarg.1
IL_0008: ldstr " "
IL_000d: ldarg.2
IL_000e: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0013: ldstr "`"
IL_0018: ldsfld System.String System.String::Empty
IL_001d: callvirt System.String System.String::Replace(System.String,System.String)
IL_0022: stloc.0
IL_0023: ldloc.0
IL_0024: ldc.i4.0
IL_0025: ldc.i4.0
IL_0026: ldloc.0
IL_0027: callvirt System.Int32 System.String::get_Length()
IL_002c: call System.Int32 System.Math::Max(System.Int32,System.Int32)
IL_0031: ldc.i4 1536
IL_0036: call System.Int32 System.Math::Min(System.Int32,System.Int32)
IL_003b: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_0040: stloc.0
IL_0041: ldsfld System.Collections.Generic.Queue`1<System.String> TheForestOfLove.BugReportApiHelper::latestApplicationMessagesCritical
IL_0046: ldloc.0
IL_0047: ldstr "
"
IL_004c: call System.String System.String::Concat(System.String,System.String)
IL_0051: callvirt System.Void System.Collections.Generic.Queue`1<System.String>::Enqueue(!0)
IL_0056: br.s IL_0063
IL_0058: ldsfld System.Collections.Generic.Queue`1<System.String> TheForestOfLove.BugReportApiHelper::latestApplicationMessagesCritical
IL_005d: callvirt !0 System.Collections.Generic.Queue`1<System.String>::Dequeue()
IL_0062: pop
IL_0063: ldsfld System.Collections.Generic.Queue`1<System.String> TheForestOfLove.BugReportApiHelper::latestApplicationMessagesCritical
IL_0068: callvirt System.Int32 System.Collections.Generic.Queue`1<System.String>::get_Count()
IL_006d: ldc.i4.s 20
IL_006f: bgt.s IL_0058
IL_0071: ret
IL_0072: ldarg.1
IL_0073: ldstr " "
IL_0078: ldarg.2
IL_0079: call System.String System.String::Concat(System.String,System.String,System.String)
IL_007e: ldstr "`"
IL_0083: ldsfld System.String System.String::Empty
IL_0088: callvirt System.String System.String::Replace(System.String,System.String)
IL_008d: stloc.1
IL_008e: ldloc.1
IL_008f: ldc.i4.0
IL_0090: ldc.i4.0
IL_0091: ldloc.1
IL_0092: callvirt System.Int32 System.String::get_Length()
IL_0097: call System.Int32 System.Math::Max(System.Int32,System.Int32)
IL_009c: ldc.i4 768
IL_00a1: call System.Int32 System.Math::Min(System.Int32,System.Int32)
IL_00a6: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_00ab: stloc.1
IL_00ac: ldsfld System.Collections.Generic.Queue`1<System.String> TheForestOfLove.BugReportApiHelper::latestApplicationMessagesNoncritical
IL_00b1: ldloc.1
IL_00b2: ldstr "
"
IL_00b7: call System.String System.String::Concat(System.String,System.String)
IL_00bc: callvirt System.Void System.Collections.Generic.Queue`1<System.String>::Enqueue(!0)
IL_00c1: br.s IL_00ce
IL_00c3: ldsfld System.Collections.Generic.Queue`1<System.String> TheForestOfLove.BugReportApiHelper::latestApplicationMessagesNoncritical
IL_00c8: callvirt !0 System.Collections.Generic.Queue`1<System.String>::Dequeue()
IL_00cd: pop
IL_00ce: ldsfld System.Collections.Generic.Queue`1<System.String> TheForestOfLove.BugReportApiHelper::latestApplicationMessagesNoncritical
IL_00d3: callvirt System.Int32 System.Collections.Generic.Queue`1<System.String>::get_Count()
IL_00d8: ldc.i4.s 20
IL_00da: bgt.s IL_00c3
IL_00dc: ret
METHOD System.Void TheForestOfLove.BugReportApiHelper::SubmitBugReport(System.String,System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.CodecksApiSettings TheForestOfLove.BugReportApiHelper::apiSettings
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_0019
IL_000e: ldstr "no api settings available"
IL_0013: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0018: ret
IL_0019: ldarg.0
IL_001a: ldfld TheForestOfLove.CodecksApiSettings TheForestOfLove.BugReportApiHelper::apiSettings
IL_001f: ldfld System.String TheForestOfLove.CodecksApiSettings::reportToken
IL_0024: stloc.0
IL_0025: ldstr "https://api.codecks.io/user-report/v1/create-report?token="
IL_002a: ldloc.0
IL_002b: call System.String System.String::Concat(System.String,System.String)
IL_0030: newobj System.Void System.Uri::.ctor(System.String)
IL_0035: ldarg.0
IL_0036: ldftn System.Void TheForestOfLove.BugReportApiHelper::OnSubmitBugReportFinished(BestHTTP.HTTPRequest,BestHTTP.HTTPResponse)
IL_003c: newobj System.Void BestHTTP.OnRequestFinishedDelegate::.ctor(System.Object,System.IntPtr)
IL_0041: newobj System.Void BestHTTP.HTTPRequest::.ctor(System.Uri,BestHTTP.OnRequestFinishedDelegate)
IL_0046: stloc.1
IL_0047: ldloc.1
IL_0048: ldc.i4.2
IL_0049: callvirt System.Void BestHTTP.HTTPRequest::set_MethodType(BestHTTP.HTTPMethods)
IL_004e: newobj System.Void TheForestOfLove.BugReportApiHelper/CodecksBugReport::.ctor()
IL_0053: stloc.3
IL_0054: ldloc.3
IL_0055: ldc.i4.s 11
IL_0057: newarr System.String
IL_005c: dup
IL_005d: ldc.i4.0
IL_005e: ldarg.1
IL_005f: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0064: brtrue.s IL_0069
IL_0066: ldarg.1
IL_0067: br.s IL_006e
IL_0069: ldstr "test"
IL_006e: stelem.ref
IL_006f: dup
IL_0070: ldc.i4.1
IL_0071: ldstr "


Application Info:
"
IL_0076: stelem.ref
IL_0077: dup
IL_0078: ldc.i4.2
IL_0079: ldarg.0
IL_007a: ldarg.2
IL_007b: call System.String TheForestOfLove.BugReportApiHelper::GenerateApplicationInfo(System.Int32)
IL_0080: stelem.ref
IL_0081: dup
IL_0082: ldc.i4.3
IL_0083: ldstr "
System Info:
"
IL_0088: stelem.ref
IL_0089: dup
IL_008a: ldc.i4.4
IL_008b: ldarg.0
IL_008c: ldarg.2
IL_008d: call System.String TheForestOfLove.BugReportApiHelper::GenerateSystemSpecs(System.Int32)
IL_0092: stelem.ref
IL_0093: dup
IL_0094: ldc.i4.5
IL_0095: ldstr "
Recent Events:
"
IL_009a: stelem.ref
IL_009b: dup
IL_009c: ldc.i4.6
IL_009d: ldarg.0
IL_009e: call System.String TheForestOfLove.BugReportApiHelper::GenerateRecentStoryEvents()
IL_00a3: stelem.ref
IL_00a4: dup
IL_00a5: ldc.i4.7
IL_00a6: ldstr "
Recent Errors:
"
IL_00ab: stelem.ref
IL_00ac: dup
IL_00ad: ldc.i4.8
IL_00ae: ldarg.0
IL_00af: call System.String TheForestOfLove.BugReportApiHelper::GenerateRecentMessagesCritical()
IL_00b4: stelem.ref
IL_00b5: dup
IL_00b6: ldc.i4.s 9
IL_00b8: ldstr "
Recent Messages:
"
IL_00bd: stelem.ref
IL_00be: dup
IL_00bf: ldc.i4.s 10
IL_00c1: ldarg.0
IL_00c2: call System.String TheForestOfLove.BugReportApiHelper::GenerateRecentMessagesNoncritical()
IL_00c7: stelem.ref
IL_00c8: call System.String System.String::Concat(System.String[])
IL_00cd: stfld System.String TheForestOfLove.BugReportApiHelper/CodecksBugReport::content
IL_00d2: ldloc.3
IL_00d3: ldstr "high"
IL_00d8: stfld System.String TheForestOfLove.BugReportApiHelper/CodecksBugReport::severity
IL_00dd: ldloc.3
IL_00de: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_00e3: brtrue.s IL_00f5
IL_00e5: ldc.i4.1
IL_00e6: newarr System.String
IL_00eb: dup
IL_00ec: ldc.i4.0
IL_00ed: ldstr "screenshot"
IL_00f2: stelem.ref
IL_00f3: br.s IL_00fb
IL_00f5: ldc.i4.0
IL_00f6: newarr System.String
IL_00fb: stfld System.String[] TheForestOfLove.BugReportApiHelper/CodecksBugReport::fileNames
IL_0100: ldloc.3
IL_0101: ldloc.1
IL_0102: ldstr "Content-Type"
IL_0107: ldstr "application/json"
IL_010c: callvirt System.Void BestHTTP.HTTPRequest::AddHeader(System.String,System.String)
IL_0111: ldnull
IL_0112: call System.Byte[] ES3::Serialize<TheForestOfLove.BugReportApiHelper/CodecksBugReport>(!!0,ES3Settings)
IL_0117: newobj System.Void System.IO.MemoryStream::.ctor(System.Byte[])
IL_011c: stloc.2
IL_011d: ldloc.1
IL_011e: ldloc.2
IL_011f: callvirt System.Void BestHTTP.HTTPRequest::set_UploadStream(System.IO.Stream)
IL_0124: ldloc.1
IL_0125: callvirt BestHTTP.HTTPRequest BestHTTP.HTTPRequest::Send()
IL_012a: pop
IL_012b: ret
METHOD System.String TheForestOfLove.BugReportApiHelper::GenerateApplicationInfo(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: stloc.0
IL_0002: ldsfld System.String System.String::Empty
IL_0007: ldarg.0
IL_0008: ldloc.0
IL_0009: ldc.i4.0
IL_000a: call System.String UnityEngine.Application::get_version()
IL_000f: ldstr ".1"
IL_0014: call System.String System.String::Concat(System.String,System.String)
IL_0019: ldstr "Tfol Version"
IL_001e: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_0023: call System.String System.String::Concat(System.String,System.String)
IL_0028: ldarg.0
IL_0029: ldloc.0
IL_002a: ldc.i4.0
IL_002b: call System.Boolean TheForestOfLove.UI.WindowController::get_IsFullscreen()
IL_0030: box System.Boolean
IL_0035: ldstr "Fullscreen"
IL_003a: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_003f: call System.String System.String::Concat(System.String,System.String)
IL_0044: ldarg.0
IL_0045: ldloc.0
IL_0046: ldc.i4.0
IL_0047: call System.Boolean TheForestOfLove.UI.WindowController::get_EnableFullscreenStretch()
IL_004c: box System.Boolean
IL_0051: ldstr "Fullscreen Stretch"
IL_0056: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_005b: call System.String System.String::Concat(System.String,System.String)
IL_0060: ldarg.0
IL_0061: ldloc.0
IL_0062: ldc.i4.0
IL_0063: ldstr "{0} x {1}"
IL_0068: call System.Int32 UnityEngine.Screen::get_width()
IL_006d: box System.Int32
IL_0072: call System.Int32 UnityEngine.Screen::get_height()
IL_0077: box System.Int32
IL_007c: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0081: ldstr "Window Resolution"
IL_0086: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_008b: call System.String System.String::Concat(System.String,System.String)
IL_0090: ldarg.0
IL_0091: ldloc.0
IL_0092: ldc.i4.0
IL_0093: call UnityEngine.ScreenOrientation UnityEngine.Screen::get_orientation()
IL_0098: box UnityEngine.ScreenOrientation
IL_009d: ldstr "Screen Orientation"
IL_00a2: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_00a7: call System.String System.String::Concat(System.String,System.String)
IL_00ac: ldarg.0
IL_00ad: ldloc.0
IL_00ae: ldc.i4.0
IL_00af: call UnityEngine.Resolution UnityEngine.Screen::get_currentResolution()
IL_00b4: box UnityEngine.Resolution
IL_00b9: ldstr "Screen Resolution"
IL_00be: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_00c3: call System.String System.String::Concat(System.String,System.String)
IL_00c8: ldarg.0
IL_00c9: ldloc.0
IL_00ca: ldc.i4.0
IL_00cb: ldarg.0
IL_00cc: call System.Single TheForestOfLove.BugReportApiHelper::get_AverageFPSDisplayValue()
IL_00d1: box System.Single
IL_00d6: ldstr "Average Frame Rate"
IL_00db: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_00e0: call System.String System.String::Concat(System.String,System.String)
IL_00e5: ret
METHOD System.String TheForestOfLove.BugReportApiHelper::GenerateSystemSpecs(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: stloc.0
IL_0002: ldsfld System.String System.String::Empty
IL_0007: stloc.1
IL_0008: ldloc.1
IL_0009: ldarg.0
IL_000a: ldloc.0
IL_000b: ldc.i4.0
IL_000c: call UnityEngine.RuntimePlatform UnityEngine.Application::get_platform()
IL_0011: stloc.2
IL_0012: ldloca.s V_2
IL_0014: constrained. UnityEngine.RuntimePlatform
IL_001a: callvirt System.String System.Object::ToString()
IL_001f: ldstr "Player"
IL_0024: ldsfld System.String System.String::Empty
IL_0029: callvirt System.String System.String::Replace(System.String,System.String)
IL_002e: ldstr "Platform"
IL_0033: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_0038: call System.String System.String::Concat(System.String,System.String)
IL_003d: stloc.1
IL_003e: ldloc.1
IL_003f: ldarg.0
IL_0040: ldloc.0
IL_0041: ldc.i4.2
IL_0042: call System.String UnityEngine.SystemInfo::get_deviceModel()
IL_0047: ldstr "Device Model"
IL_004c: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_0051: call System.String System.String::Concat(System.String,System.String)
IL_0056: stloc.1
IL_0057: ldloc.1
IL_0058: ldarg.0
IL_0059: ldloc.0
IL_005a: ldc.i4.0
IL_005b: call UnityEngine.DeviceType UnityEngine.SystemInfo::get_deviceType()
IL_0060: box UnityEngine.DeviceType
IL_0065: ldstr "Device Type"
IL_006a: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_006f: call System.String System.String::Concat(System.String,System.String)
IL_0074: stloc.1
IL_0075: ldloc.0
IL_0076: ldc.i4.1
IL_0077: bne.un.s IL_00a3
IL_0079: ldloc.1
IL_007a: ldarg.0
IL_007b: ldloc.0
IL_007c: ldc.i4.1
IL_007d: call System.String UnityEngine.SystemInfo::get_operatingSystem()
IL_0082: ldstr "\(.*\)"
IL_0087: ldsfld System.String System.String::Empty
IL_008c: call System.String System.Text.RegularExpressions.Regex::Replace(System.String,System.String,System.String)
IL_0091: ldstr "OS Version"
IL_0096: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_009b: call System.String System.String::Concat(System.String,System.String)
IL_00a0: stloc.1
IL_00a1: br.s IL_00bc
IL_00a3: ldloc.1
IL_00a4: ldarg.0
IL_00a5: ldloc.0
IL_00a6: ldc.i4.2
IL_00a7: call System.String UnityEngine.SystemInfo::get_operatingSystem()
IL_00ac: ldstr "OS Version"
IL_00b1: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_00b6: call System.String System.String::Concat(System.String,System.String)
IL_00bb: stloc.1
IL_00bc: ldloc.1
IL_00bd: ldarg.0
IL_00be: ldloc.0
IL_00bf: ldc.i4.2
IL_00c0: call UnityEngine.SystemLanguage UnityEngine.Application::get_systemLanguage()
IL_00c5: box UnityEngine.SystemLanguage
IL_00ca: ldstr "System Language"
IL_00cf: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_00d4: call System.String System.String::Concat(System.String,System.String)
IL_00d9: stloc.1
IL_00da: ldloc.1
IL_00db: ldarg.0
IL_00dc: ldloc.0
IL_00dd: ldc.i4.1
IL_00de: call System.Int32 UnityEngine.SystemInfo::get_systemMemorySize()
IL_00e3: box System.Int32
IL_00e8: ldstr "Memory Size"
IL_00ed: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_00f2: call System.String System.String::Concat(System.String,System.String)
IL_00f7: stloc.1
IL_00f8: ldloc.1
IL_00f9: ldarg.0
IL_00fa: ldloc.0
IL_00fb: ldc.i4.3
IL_00fc: call System.String UnityEngine.SystemInfo::get_graphicsDeviceVendor()
IL_0101: ldstr "Graphics Vendor"
IL_0106: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_010b: call System.String System.String::Concat(System.String,System.String)
IL_0110: stloc.1
IL_0111: ldloc.1
IL_0112: ldarg.0
IL_0113: ldloc.0
IL_0114: ldc.i4.3
IL_0115: call System.String UnityEngine.SystemInfo::get_graphicsDeviceName()
IL_011a: ldstr "Graphics Name"
IL_011f: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_0124: call System.String System.String::Concat(System.String,System.String)
IL_0129: stloc.1
IL_012a: ldloc.1
IL_012b: ldarg.0
IL_012c: ldloc.0
IL_012d: ldc.i4.2
IL_012e: call UnityEngine.Rendering.GraphicsDeviceType UnityEngine.SystemInfo::get_graphicsDeviceType()
IL_0133: box UnityEngine.Rendering.GraphicsDeviceType
IL_0138: ldstr "Graphics Type"
IL_013d: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_0142: call System.String System.String::Concat(System.String,System.String)
IL_0147: stloc.1
IL_0148: ldloc.1
IL_0149: ldarg.0
IL_014a: ldloc.0
IL_014b: ldc.i4.1
IL_014c: call System.Int32 UnityEngine.SystemInfo::get_graphicsMemorySize()
IL_0151: box System.Int32
IL_0156: ldstr "Graphics VRAM"
IL_015b: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_0160: call System.String System.String::Concat(System.String,System.String)
IL_0165: stloc.1
IL_0166: ldloc.1
IL_0167: ldarg.0
IL_0168: ldloc.0
IL_0169: ldc.i4.1
IL_016a: call System.Boolean UnityEngine.SystemInfo::get_graphicsMultiThreaded()
IL_016f: box System.Boolean
IL_0174: ldstr "Graphics Multithreaded"
IL_0179: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_017e: call System.String System.String::Concat(System.String,System.String)
IL_0183: stloc.1
IL_0184: ldloc.1
IL_0185: ldarg.0
IL_0186: ldloc.0
IL_0187: ldc.i4.3
IL_0188: call System.String UnityEngine.SystemInfo::get_processorType()
IL_018d: ldstr "Processor Type"
IL_0192: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_0197: call System.String System.String::Concat(System.String,System.String)
IL_019c: stloc.1
IL_019d: ldloc.1
IL_019e: ldarg.0
IL_019f: ldloc.0
IL_01a0: ldc.i4.1
IL_01a1: call System.Int32 UnityEngine.SystemInfo::get_processorCount()
IL_01a6: box System.Int32
IL_01ab: ldstr "Processor Count"
IL_01b0: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_01b5: call System.String System.String::Concat(System.String,System.String)
IL_01ba: stloc.1
IL_01bb: ldloc.1
IL_01bc: ldarg.0
IL_01bd: ldloc.0
IL_01be: ldc.i4.1
IL_01bf: call System.Int32 UnityEngine.SystemInfo::get_processorFrequency()
IL_01c4: box System.Int32
IL_01c9: ldstr "Processor Frequency"
IL_01ce: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_01d3: call System.String System.String::Concat(System.String,System.String)
IL_01d8: stloc.1
IL_01d9: ldloc.1
IL_01da: ldarg.0
IL_01db: ldloc.0
IL_01dc: ldc.i4.0
IL_01dd: call System.Boolean UnityEngine.SystemInfo::get_supportsAudio()
IL_01e2: box System.Boolean
IL_01e7: ldstr "Supports Audio"
IL_01ec: call System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String)
IL_01f1: call System.String System.String::Concat(System.String,System.String)
IL_01f6: stloc.1
IL_01f7: ldloc.1
IL_01f8: ret
METHOD System.String TheForestOfLove.BugReportApiHelper::AppendSystemSpecIfSupported(System.Int32,System.Int32,System.Object,System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldarg.1
IL_0002: ble.s IL_000a
IL_0004: ldsfld System.String System.String::Empty
IL_0009: ret
IL_000a: ldarg.3
IL_000b: isinst System.String
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: brfalse.s IL_003c
IL_0014: ldloc.0
IL_0015: ldstr "n/a"
IL_001a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_001f: brtrue.s IL_002f
IL_0021: ldstr "{0}: {1}
"
IL_0026: ldarg.s label
IL_0028: ldarg.3
IL_0029: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_002e: ret
IL_002f: ldstr "{0}: [Unknown]
"
IL_0034: ldarg.s label
IL_0036: call System.String System.String::Format(System.String,System.Object)
IL_003b: ret
IL_003c: ldstr "{0}: {1}
"
IL_0041: ldarg.s label
IL_0043: ldarg.3
IL_0044: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0049: ret
METHOD System.String TheForestOfLove.BugReportApiHelper::GenerateRecentStoryEvents() | attributes=Public, HideBySig | impl=IL
IL_0000: ldsfld System.String System.String::Empty
IL_0005: stloc.0
IL_0006: call System.Collections.Generic.IEnumerable`1<GameplayLogHistory> TheForestOfLove.GameplayLogManager::GetLogHistory()
IL_000b: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<GameplayLogHistory>::GetEnumerator()
IL_0010: stloc.1
IL_0011: br.s IL_002c
IL_0013: ldloc.1
IL_0014: callvirt !0 System.Collections.Generic.IEnumerator`1<GameplayLogHistory>::get_Current()
IL_0019: stloc.2
IL_001a: ldloc.0
IL_001b: ldloc.2
IL_001c: ldfld System.String GameplayLogHistory::message
IL_0021: ldstr "
"
IL_0026: call System.String System.String::Concat(System.String,System.String,System.String)
IL_002b: stloc.0
IL_002c: ldloc.1
IL_002d: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0032: brtrue.s IL_0013
IL_0034: leave.s IL_0040
IL_0036: ldloc.1
IL_0037: brfalse.s IL_003f
IL_0039: ldloc.1
IL_003a: callvirt System.Void System.IDisposable::Dispose()
IL_003f: endfinally
IL_0040: ldloc.0
IL_0041: ldsfld System.String System.String::Empty
IL_0046: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_004b: brfalse.s IL_0087
IL_004d: call System.Collections.Generic.IEnumerable`1<GameplayLogHistory> TheForestOfLove.Services.Persistence.DataService::GetLogHistory()
IL_0052: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<GameplayLogHistory>::GetEnumerator()
IL_0057: stloc.1
IL_0058: br.s IL_0073
IL_005a: ldloc.1
IL_005b: callvirt !0 System.Collections.Generic.IEnumerator`1<GameplayLogHistory>::get_Current()
IL_0060: stloc.3
IL_0061: ldloc.0
IL_0062: ldloc.3
IL_0063: ldfld System.String GameplayLogHistory::message
IL_0068: ldstr "
"
IL_006d: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0072: stloc.0
IL_0073: ldloc.1
IL_0074: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0079: brtrue.s IL_005a
IL_007b: leave.s IL_0087
IL_007d: ldloc.1
IL_007e: brfalse.s IL_0086
IL_0080: ldloc.1
IL_0081: callvirt System.Void System.IDisposable::Dispose()
IL_0086: endfinally
IL_0087: ldloc.0
IL_0088: ret
METHOD System.String TheForestOfLove.BugReportApiHelper::GenerateRecentMessagesCritical() | attributes=Public, HideBySig | impl=IL
IL_0000: ldsfld System.String System.String::Empty
IL_0005: stloc.0
IL_0006: ldsfld System.Collections.Generic.Queue`1<System.String> TheForestOfLove.BugReportApiHelper::latestApplicationMessagesCritical
IL_000b: callvirt System.Collections.Generic.Queue`1/Enumerator<!0> System.Collections.Generic.Queue`1<System.String>::GetEnumerator()
IL_0010: stloc.1
IL_0011: br.s IL_0028
IL_0013: ldloca.s V_1
IL_0015: call !0 System.Collections.Generic.Queue`1/Enumerator<System.String>::get_Current()
IL_001a: stloc.2
IL_001b: ldloc.0
IL_001c: ldloc.2
IL_001d: ldstr "
"
IL_0022: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0027: stloc.0
IL_0028: ldloca.s V_1
IL_002a: call System.Boolean System.Collections.Generic.Queue`1/Enumerator<System.String>::MoveNext()
IL_002f: brtrue.s IL_0013
IL_0031: leave.s IL_0041
IL_0033: ldloca.s V_1
IL_0035: constrained. System.Collections.Generic.Queue`1/Enumerator<System.String>
IL_003b: callvirt System.Void System.IDisposable::Dispose()
IL_0040: endfinally
IL_0041: ldloc.0
IL_0042: ret
METHOD System.String TheForestOfLove.BugReportApiHelper::GenerateRecentMessagesNoncritical() | attributes=Public, HideBySig | impl=IL
IL_0000: ldsfld System.String System.String::Empty
IL_0005: stloc.0
IL_0006: ldsfld System.Collections.Generic.Queue`1<System.String> TheForestOfLove.BugReportApiHelper::latestApplicationMessagesNoncritical
IL_000b: callvirt System.Collections.Generic.Queue`1/Enumerator<!0> System.Collections.Generic.Queue`1<System.String>::GetEnumerator()
IL_0010: stloc.1
IL_0011: br.s IL_0028
IL_0013: ldloca.s V_1
IL_0015: call !0 System.Collections.Generic.Queue`1/Enumerator<System.String>::get_Current()
IL_001a: stloc.2
IL_001b: ldloc.0
IL_001c: ldloc.2
IL_001d: ldstr "
"
IL_0022: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0027: stloc.0
IL_0028: ldloca.s V_1
IL_002a: call System.Boolean System.Collections.Generic.Queue`1/Enumerator<System.String>::MoveNext()
IL_002f: brtrue.s IL_0013
IL_0031: leave.s IL_0041
IL_0033: ldloca.s V_1
IL_0035: constrained. System.Collections.Generic.Queue`1/Enumerator<System.String>
IL_003b: callvirt System.Void System.IDisposable::Dispose()
IL_0040: endfinally
IL_0041: ldloc.0
IL_0042: ret
METHOD System.Void TheForestOfLove.BugReportApiHelper::UploadFiles(BestHTTP.HTTPRequest,BestHTTP.HTTPResponse) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0005: brfalse.s IL_0008
IL_0007: ret
IL_0008: ldarg.0
IL_0009: ldfld UnityEngine.Texture2D TheForestOfLove.BugReportApiHelper::screenshotTex
IL_000e: ldnull
IL_000f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0014: brfalse.s IL_0021
IL_0016: ldstr "missing screenshot texture for bug report. normally this shouldn't happen"
IL_001b: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0020: ret
IL_0021: ldarg.0
IL_0022: ldfld UnityEngine.Texture2D TheForestOfLove.BugReportApiHelper::screenshotTex
IL_0027: call System.Byte[] UnityEngine.ImageConversion::EncodeToJPG(UnityEngine.Texture2D)
IL_002c: stloc.0
IL_002d: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.ValueTuple`2<System.Byte[],TheForestOfLove.BugReportApiHelper/CodecksFileType>>::.ctor()
IL_0032: stloc.1
IL_0033: ldloc.1
IL_0034: ldstr "screenshot"
IL_0039: ldloc.0
IL_003a: ldc.i4.4
IL_003b: newobj System.Void System.ValueTuple`2<System.Byte[],TheForestOfLove.BugReportApiHelper/CodecksFileType>::.ctor(!0,!1)
IL_0040: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.ValueTuple`2<System.Byte[],TheForestOfLove.BugReportApiHelper/CodecksFileType>>::Add(!0,!1)
IL_0045: ldarg.2
IL_0046: callvirt System.Byte[] BestHTTP.HTTPResponse::get_Data()
IL_004b: ldnull
IL_004c: call !!0 ES3::Deserialize<TheForestOfLove.BugReportApiHelper/CardCreateResponseData>(System.Byte[],ES3Settings)
IL_0051: ldfld TheForestOfLove.BugReportApiHelper/CardCreateFileResponseData[] TheForestOfLove.BugReportApiHelper/CardCreateResponseData::uploadUrls
IL_0056: stloc.2
IL_0057: ldc.i4.0
IL_0058: stloc.3
IL_0059: br IL_0186
IL_005e: ldloc.2
IL_005f: ldloc.3
IL_0060: ldelem.any TheForestOfLove.BugReportApiHelper/CardCreateFileResponseData
IL_0065: stloc.s V_4
IL_0067: ldloc.1
IL_0068: ldloc.s V_4
IL_006a: ldfld System.String TheForestOfLove.BugReportApiHelper/CardCreateFileResponseData::fileName
IL_006f: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.ValueTuple`2<System.Byte[],TheForestOfLove.BugReportApiHelper/CodecksFileType>>::ContainsKey(!0)
IL_0074: brtrue.s IL_008d
IL_0076: ldstr "Unexpected file in uploadUrls "
IL_007b: ldloc.s V_4
IL_007d: ldfld System.String TheForestOfLove.BugReportApiHelper/CardCreateFileResponseData::fileName
IL_0082: call System.String System.String::Concat(System.String,System.String)
IL_0087: newobj System.Void System.Exception::.ctor(System.String)
IL_008c: throw
IL_008d: newobj System.Void System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>::.ctor()
IL_0092: stloc.s V_5
IL_0094: ldloc.s V_4
IL_0096: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> TheForestOfLove.BugReportApiHelper/CardCreateFileResponseData::fields
IL_009b: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,System.String>::GetEnumerator()
IL_00a0: stloc.s V_8
IL_00a2: br.s IL_00c7
IL_00a4: ldloca.s V_8
IL_00a6: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,System.String>::get_Current()
IL_00ab: stloc.s V_9
IL_00ad: ldloc.s V_5
IL_00af: ldloca.s V_9
IL_00b1: call !0 System.Collections.Generic.KeyValuePair`2<System.String,System.String>::get_Key()
IL_00b6: ldloca.s V_9
IL_00b8: call !1 System.Collections.Generic.KeyValuePair`2<System.String,System.String>::get_Value()
IL_00bd: newobj System.Void UnityEngine.Networking.MultipartFormDataSection::.ctor(System.String,System.String)
IL_00c2: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>::Add(!0)
IL_00c7: ldloca.s V_8
IL_00c9: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,System.String>::MoveNext()
IL_00ce: brtrue.s IL_00a4
IL_00d0: leave.s IL_00e0
IL_00d2: ldloca.s V_8
IL_00d4: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,System.String>
IL_00da: callvirt System.Void System.IDisposable::Dispose()
IL_00df: endfinally
IL_00e0: ldloc.1
IL_00e1: ldloc.s V_4
IL_00e3: ldfld System.String TheForestOfLove.BugReportApiHelper/CardCreateFileResponseData::fileName
IL_00e8: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.ValueTuple`2<System.Byte[],TheForestOfLove.BugReportApiHelper/CodecksFileType>>::get_Item(!0)
IL_00ed: stloc.s V_6
IL_00ef: ldloc.s V_6
IL_00f1: ldfld !1 System.ValueTuple`2<System.Byte[],TheForestOfLove.BugReportApiHelper/CodecksFileType>::Item2
IL_00f6: stloc.s V_10
IL_00f8: ldloc.s V_10
IL_00fa: ldc.i4.1
IL_00fb: sub
IL_00fc: switch IL_011a,IL_0123,IL_012c,IL_0135
IL_0111: ldstr "application/octet-stream"
IL_0116: stloc.s V_7
IL_0118: br.s IL_013c
IL_011a: ldstr "text/plain"
IL_011f: stloc.s V_7
IL_0121: br.s IL_013c
IL_0123: ldstr "application/json"
IL_0128: stloc.s V_7
IL_012a: br.s IL_013c
IL_012c: ldstr "image/png"
IL_0131: stloc.s V_7
IL_0133: br.s IL_013c
IL_0135: ldstr "image/jpeg"
IL_013a: stloc.s V_7
IL_013c: ldloc.s V_5
IL_013e: ldstr "Content-Type"
IL_0143: ldloc.s V_7
IL_0145: newobj System.Void UnityEngine.Networking.MultipartFormDataSection::.ctor(System.String,System.String)
IL_014a: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>::Add(!0)
IL_014f: ldloc.s V_5
IL_0151: ldstr "file"
IL_0156: ldloc.s V_6
IL_0158: ldfld !0 System.ValueTuple`2<System.Byte[],TheForestOfLove.BugReportApiHelper/CodecksFileType>::Item1
IL_015d: ldloc.s V_4
IL_015f: ldfld System.String TheForestOfLove.BugReportApiHelper/CardCreateFileResponseData::fileName
IL_0164: ldloc.s V_7
IL_0166: newobj System.Void UnityEngine.Networking.MultipartFormFileSection::.ctor(System.String,System.Byte[],System.String,System.String)
IL_016b: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>::Add(!0)
IL_0170: ldarg.0
IL_0171: ldloc.s V_4
IL_0173: ldloc.s V_5
IL_0175: ldloc.s V_6
IL_0177: call System.Collections.IEnumerator TheForestOfLove.BugReportApiHelper::WaitForResultCoroutine(TheForestOfLove.BugReportApiHelper/CardCreateFileResponseData,System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>,System.ValueTuple`2<System.Byte[],TheForestOfLove.BugReportApiHelper/CodecksFileType>)
IL_017c: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0181: pop
IL_0182: ldloc.3
IL_0183: ldc.i4.1
IL_0184: add
IL_0185: stloc.3
IL_0186: ldloc.3
IL_0187: ldloc.2
IL_0188: ldlen
IL_0189: conv.i4
IL_018a: blt IL_005e
IL_018f: ret
METHOD System.Boolean TheForestOfLove.BugReportApiHelper::CheckAndHandleErrors(BestHTTP.HTTPRequest,BestHTTP.HTTPResponse) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt BestHTTP.HTTPRequestStates BestHTTP.HTTPRequest::get_State()
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: ldc.i4.3
IL_0009: sub
IL_000a: switch IL_0028,IL_0069,IL_00a9,IL_00b5,IL_00c1
IL_0023: br IL_00cd
IL_0028: ldarg.1
IL_0029: brtrue.s IL_0037
IL_002b: ldstr "Request finished successfully but response was unexpectedly null."
IL_0030: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0035: ldc.i4.1
IL_0036: ret
IL_0037: ldarg.1
IL_0038: callvirt System.Boolean BestHTTP.HTTPResponse::get_IsSuccess()
IL_003d: brtrue.s IL_0067
IL_003f: ldstr "Request finished successfully, but the server sent an error. Status Code: {0}-{1} Message: {2}"
IL_0044: ldarg.1
IL_0045: callvirt System.Int32 BestHTTP.HTTPResponse::get_StatusCode()
IL_004a: box System.Int32
IL_004f: ldarg.1
IL_0050: callvirt System.String BestHTTP.HTTPResponse::get_Message()
IL_0055: ldarg.1
IL_0056: callvirt System.String BestHTTP.HTTPResponse::get_DataAsText()
IL_005b: call System.String System.String::Format(System.String,System.Object,System.Object,System.Object)
IL_0060: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0065: ldc.i4.1
IL_0066: ret
IL_0067: ldc.i4.0
IL_0068: ret
IL_0069: ldstr "Request finished with error. "
IL_006e: ldarg.0
IL_006f: callvirt System.Exception BestHTTP.HTTPRequest::get_Exception()
IL_0074: brtrue.s IL_007d
IL_0076: ldstr "No Exception"
IL_007b: br.s IL_009d
IL_007d: ldarg.0
IL_007e: callvirt System.Exception BestHTTP.HTTPRequest::get_Exception()
IL_0083: callvirt System.String System.Exception::get_Message()
IL_0088: ldstr "
"
IL_008d: ldarg.0
IL_008e: callvirt System.Exception BestHTTP.HTTPRequest::get_Exception()
IL_0093: callvirt System.String System.Exception::get_StackTrace()
IL_0098: call System.String System.String::Concat(System.String,System.String,System.String)
IL_009d: call System.String System.String::Concat(System.String,System.String)
IL_00a2: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00a7: ldc.i4.1
IL_00a8: ret
IL_00a9: ldstr "Request aborted."
IL_00ae: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_00b3: ldc.i4.1
IL_00b4: ret
IL_00b5: ldstr "Connection timed out."
IL_00ba: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00bf: ldc.i4.1
IL_00c0: ret
IL_00c1: ldstr "Processing the request timed out."
IL_00c6: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00cb: ldc.i4.1
IL_00cc: ret
IL_00cd: ldstr "An unknown error occurred."
IL_00d2: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00d7: ldc.i4.1
IL_00d8: ret
