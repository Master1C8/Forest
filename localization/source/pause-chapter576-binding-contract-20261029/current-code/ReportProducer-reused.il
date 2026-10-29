TYPE TheForestOfLove.BugReportApiHelper
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
