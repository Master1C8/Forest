TYPE BugReportTest
METHOD System.Void BugReportTest::SendTestBugReport(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldstr <original embedded report token omitted; exact value remains in pinned source index>
IL_0005: stloc.0
IL_0006: ldstr "https://api.codecks.io/user-report/v1/create-report?token="
IL_000b: ldloc.0
IL_000c: call System.String System.String::Concat(System.String,System.String)
IL_0011: newobj System.Void System.Uri::.ctor(System.String)
IL_0016: ldarg.0
IL_0017: ldftn System.Void BugReportTest::OnSendTestBugReportRequestFinished(BestHTTP.HTTPRequest,BestHTTP.HTTPResponse)
IL_001d: newobj System.Void BestHTTP.OnRequestFinishedDelegate::.ctor(System.Object,System.IntPtr)
IL_0022: newobj System.Void BestHTTP.HTTPRequest::.ctor(System.Uri,BestHTTP.OnRequestFinishedDelegate)
IL_0027: stloc.1
IL_0028: ldloc.1
IL_0029: ldc.i4.2
IL_002a: callvirt System.Void BestHTTP.HTTPRequest::set_MethodType(BestHTTP.HTTPMethods)
IL_002f: newobj System.Void BugReportTest/CodecksBugReport::.ctor()
IL_0034: stloc.3
IL_0035: ldloc.3
IL_0036: ldarg.1
IL_0037: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_003c: brtrue.s IL_0041
IL_003e: ldarg.1
IL_003f: br.s IL_0046
IL_0041: ldstr "test"
IL_0046: ldarg.0
IL_0047: call System.String BugReportTest::AppendSystemSpecs()
IL_004c: call System.String System.String::Concat(System.String,System.String)
IL_0051: stfld System.String BugReportTest/CodecksBugReport::content
IL_0056: ldloc.3
IL_0057: ldstr "high"
IL_005c: stfld System.String BugReportTest/CodecksBugReport::severity
IL_0061: ldloc.3
IL_0062: ldc.i4.1
IL_0063: newarr System.String
IL_0068: dup
IL_0069: ldc.i4.0
IL_006a: ldstr "screenshot"
IL_006f: stelem.ref
IL_0070: stfld System.String[] BugReportTest/CodecksBugReport::fileNames
IL_0075: ldloc.3
IL_0076: ldloc.1
IL_0077: ldstr "Content-Type"
IL_007c: ldstr "application/json"
IL_0081: callvirt System.Void BestHTTP.HTTPRequest::AddHeader(System.String,System.String)
IL_0086: ldnull
IL_0087: call System.Byte[] ES3::Serialize<BugReportTest/CodecksBugReport>(!!0,ES3Settings)
IL_008c: newobj System.Void System.IO.MemoryStream::.ctor(System.Byte[])
IL_0091: stloc.2
IL_0092: ldloc.1
IL_0093: ldloc.2
IL_0094: callvirt System.Void BestHTTP.HTTPRequest::set_UploadStream(System.IO.Stream)
IL_0099: ldloc.1
IL_009a: callvirt BestHTTP.HTTPRequest BestHTTP.HTTPRequest::Send()
IL_009f: pop
IL_00a0: ret
METHOD System.String BugReportTest::AppendSystemSpecs() | attributes=Private, HideBySig | impl=IL
IL_0000: ldsfld System.String System.String::Empty
IL_0005: ldstr "


"
IL_000a: call System.String System.String::Concat(System.String,System.String)
IL_000f: ldarg.0
IL_0010: call System.String UnityEngine.Application::get_version()
IL_0015: ldstr "Tfol Version"
IL_001a: call System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String)
IL_001f: call System.String System.String::Concat(System.String,System.String)
IL_0024: ldarg.0
IL_0025: call UnityEngine.DeviceType UnityEngine.SystemInfo::get_deviceType()
IL_002a: box UnityEngine.DeviceType
IL_002f: ldstr "Device Type"
IL_0034: call System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String)
IL_0039: call System.String System.String::Concat(System.String,System.String)
IL_003e: ldarg.0
IL_003f: call UnityEngine.RuntimePlatform UnityEngine.Application::get_platform()
IL_0044: box UnityEngine.RuntimePlatform
IL_0049: ldstr "Platform"
IL_004e: call System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String)
IL_0053: call System.String System.String::Concat(System.String,System.String)
IL_0058: ldarg.0
IL_0059: call UnityEngine.OperatingSystemFamily UnityEngine.SystemInfo::get_operatingSystemFamily()
IL_005e: box UnityEngine.OperatingSystemFamily
IL_0063: ldstr "OS"
IL_0068: call System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String)
IL_006d: call System.String System.String::Concat(System.String,System.String)
IL_0072: ldarg.0
IL_0073: call UnityEngine.SystemLanguage UnityEngine.Application::get_systemLanguage()
IL_0078: box UnityEngine.SystemLanguage
IL_007d: ldstr "System Language"
IL_0082: call System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String)
IL_0087: call System.String System.String::Concat(System.String,System.String)
IL_008c: ldarg.0
IL_008d: call System.Int32 UnityEngine.SystemInfo::get_systemMemorySize()
IL_0092: box System.Int32
IL_0097: ldstr "RAM"
IL_009c: call System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String)
IL_00a1: call System.String System.String::Concat(System.String,System.String)
IL_00a6: ldarg.0
IL_00a7: call System.Int32 UnityEngine.SystemInfo::get_graphicsMemorySize()
IL_00ac: box System.Int32
IL_00b1: ldstr "VRAM"
IL_00b6: call System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String)
IL_00bb: call System.String System.String::Concat(System.String,System.String)
IL_00c0: ldarg.0
IL_00c1: call System.Int32 UnityEngine.SystemInfo::get_processorCount()
IL_00c6: box System.Int32
IL_00cb: ldstr "CPU Cores"
IL_00d0: call System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String)
IL_00d5: call System.String System.String::Concat(System.String,System.String)
IL_00da: ldarg.0
IL_00db: call System.Int32 UnityEngine.SystemInfo::get_processorFrequency()
IL_00e0: box System.Int32
IL_00e5: ldstr "CPU Freq"
IL_00ea: call System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String)
IL_00ef: call System.String System.String::Concat(System.String,System.String)
IL_00f4: ldarg.0
IL_00f5: call System.Boolean UnityEngine.SystemInfo::get_supportsAudio()
IL_00fa: box System.Boolean
IL_00ff: ldstr "Supports Audio"
IL_0104: call System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String)
IL_0109: call System.String System.String::Concat(System.String,System.String)
IL_010e: ret
METHOD System.String BugReportTest::AppendSystemSpecIfSupported(System.Object,System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: isinst System.String
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_002a
IL_000a: ldloc.0
IL_000b: ldstr "n/a"
IL_0010: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0015: brtrue.s IL_0024
IL_0017: ldstr "{0}: {1}
"
IL_001c: ldarg.2
IL_001d: ldarg.1
IL_001e: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0023: ret
IL_0024: ldsfld System.String System.String::Empty
IL_0029: ret
IL_002a: ldstr "{0}: {1}
"
IL_002f: ldarg.2
IL_0030: ldarg.1
IL_0031: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0036: ret
METHOD System.Void BugReportTest::UploadFiles(BestHTTP.HTTPRequest,BestHTTP.HTTPResponse) | attributes=Private, HideBySig | impl=IL
IL_0000: call UnityEngine.Texture2D UnityEngine.ScreenCapture::CaptureScreenshotAsTexture()
IL_0005: dup
IL_0006: call System.Byte[] UnityEngine.ImageConversion::EncodeToJPG(UnityEngine.Texture2D)
IL_000b: stloc.0
IL_000c: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0011: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,System.ValueTuple`2<System.Byte[],BugReportTest/CodecksFileType>>::.ctor()
IL_0016: stloc.1
IL_0017: ldloc.1
IL_0018: ldstr "screenshot"
IL_001d: ldloc.0
IL_001e: ldc.i4.4
IL_001f: newobj System.Void System.ValueTuple`2<System.Byte[],BugReportTest/CodecksFileType>::.ctor(!0,!1)
IL_0024: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.ValueTuple`2<System.Byte[],BugReportTest/CodecksFileType>>::Add(!0,!1)
IL_0029: ldarg.2
IL_002a: callvirt System.Byte[] BestHTTP.HTTPResponse::get_Data()
IL_002f: ldnull
IL_0030: call !!0 ES3::Deserialize<BugReportTest/CardCreateResponseData>(System.Byte[],ES3Settings)
IL_0035: ldfld BugReportTest/CardCreateFileResponseData[] BugReportTest/CardCreateResponseData::uploadUrls
IL_003a: stloc.2
IL_003b: ldc.i4.0
IL_003c: stloc.3
IL_003d: br IL_016a
IL_0042: ldloc.2
IL_0043: ldloc.3
IL_0044: ldelem.any BugReportTest/CardCreateFileResponseData
IL_0049: stloc.s V_4
IL_004b: ldloc.1
IL_004c: ldloc.s V_4
IL_004e: ldfld System.String BugReportTest/CardCreateFileResponseData::fileName
IL_0053: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.ValueTuple`2<System.Byte[],BugReportTest/CodecksFileType>>::ContainsKey(!0)
IL_0058: brtrue.s IL_0071
IL_005a: ldstr "Unexpected file in uploadUrls "
IL_005f: ldloc.s V_4
IL_0061: ldfld System.String BugReportTest/CardCreateFileResponseData::fileName
IL_0066: call System.String System.String::Concat(System.String,System.String)
IL_006b: newobj System.Void System.Exception::.ctor(System.String)
IL_0070: throw
IL_0071: newobj System.Void System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>::.ctor()
IL_0076: stloc.s V_5
IL_0078: ldloc.s V_4
IL_007a: ldfld System.Collections.Generic.Dictionary`2<System.String,System.String> BugReportTest/CardCreateFileResponseData::fields
IL_007f: callvirt System.Collections.Generic.Dictionary`2/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2<System.String,System.String>::GetEnumerator()
IL_0084: stloc.s V_8
IL_0086: br.s IL_00ab
IL_0088: ldloca.s V_8
IL_008a: call System.Collections.Generic.KeyValuePair`2<!0,!1> System.Collections.Generic.Dictionary`2/Enumerator<System.String,System.String>::get_Current()
IL_008f: stloc.s V_9
IL_0091: ldloc.s V_5
IL_0093: ldloca.s V_9
IL_0095: call !0 System.Collections.Generic.KeyValuePair`2<System.String,System.String>::get_Key()
IL_009a: ldloca.s V_9
IL_009c: call !1 System.Collections.Generic.KeyValuePair`2<System.String,System.String>::get_Value()
IL_00a1: newobj System.Void UnityEngine.Networking.MultipartFormDataSection::.ctor(System.String,System.String)
IL_00a6: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>::Add(!0)
IL_00ab: ldloca.s V_8
IL_00ad: call System.Boolean System.Collections.Generic.Dictionary`2/Enumerator<System.String,System.String>::MoveNext()
IL_00b2: brtrue.s IL_0088
IL_00b4: leave.s IL_00c4
IL_00b6: ldloca.s V_8
IL_00b8: constrained. System.Collections.Generic.Dictionary`2/Enumerator<System.String,System.String>
IL_00be: callvirt System.Void System.IDisposable::Dispose()
IL_00c3: endfinally
IL_00c4: ldloc.1
IL_00c5: ldloc.s V_4
IL_00c7: ldfld System.String BugReportTest/CardCreateFileResponseData::fileName
IL_00cc: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.ValueTuple`2<System.Byte[],BugReportTest/CodecksFileType>>::get_Item(!0)
IL_00d1: stloc.s V_6
IL_00d3: ldloc.s V_6
IL_00d5: ldfld !1 System.ValueTuple`2<System.Byte[],BugReportTest/CodecksFileType>::Item2
IL_00da: stloc.s V_10
IL_00dc: ldloc.s V_10
IL_00de: ldc.i4.1
IL_00df: sub
IL_00e0: switch IL_00fe,IL_0107,IL_0110,IL_0119
IL_00f5: ldstr "application/octet-stream"
IL_00fa: stloc.s V_7
IL_00fc: br.s IL_0120
IL_00fe: ldstr "text/plain"
IL_0103: stloc.s V_7
IL_0105: br.s IL_0120
IL_0107: ldstr "application/json"
IL_010c: stloc.s V_7
IL_010e: br.s IL_0120
IL_0110: ldstr "image/png"
IL_0115: stloc.s V_7
IL_0117: br.s IL_0120
IL_0119: ldstr "image/jpeg"
IL_011e: stloc.s V_7
IL_0120: ldloc.s V_5
IL_0122: ldstr "Content-Type"
IL_0127: ldloc.s V_7
IL_0129: newobj System.Void UnityEngine.Networking.MultipartFormDataSection::.ctor(System.String,System.String)
IL_012e: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>::Add(!0)
IL_0133: ldloc.s V_5
IL_0135: ldstr "file"
IL_013a: ldloc.s V_6
IL_013c: ldfld !0 System.ValueTuple`2<System.Byte[],BugReportTest/CodecksFileType>::Item1
IL_0141: ldloc.s V_4
IL_0143: ldfld System.String BugReportTest/CardCreateFileResponseData::fileName
IL_0148: ldloc.s V_7
IL_014a: newobj System.Void UnityEngine.Networking.MultipartFormFileSection::.ctor(System.String,System.Byte[],System.String,System.String)
IL_014f: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>::Add(!0)
IL_0154: ldarg.0
IL_0155: ldloc.s V_4
IL_0157: ldloc.s V_5
IL_0159: ldloc.s V_6
IL_015b: call System.Collections.IEnumerator BugReportTest::WaitForResultCoroutine(BugReportTest/CardCreateFileResponseData,System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>,System.ValueTuple`2<System.Byte[],BugReportTest/CodecksFileType>)
IL_0160: call UnityEngine.Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)
IL_0165: pop
IL_0166: ldloc.3
IL_0167: ldc.i4.1
IL_0168: add
IL_0169: stloc.3
IL_016a: ldloc.3
IL_016b: ldloc.2
IL_016c: ldlen
IL_016d: conv.i4
IL_016e: blt IL_0042
IL_0173: ret
METHOD System.Boolean BugReportTest::CheckAndHandleErrors(BestHTTP.HTTPRequest,BestHTTP.HTTPResponse) | attributes=Private, Static, HideBySig | impl=IL
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
