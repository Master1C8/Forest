TYPE BugReportTest/<WaitForResultCoroutine>d__15
METHOD System.Boolean BugReportTest/<WaitForResultCoroutine>d__15::MoveNext() | attributes=Private, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 BugReportTest/<WaitForResultCoroutine>d__15::<>1__state
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0010
IL_000a: ldloc.0
IL_000b: ldc.i4.1
IL_000c: beq.s IL_004d
IL_000e: ldc.i4.0
IL_000f: ret
IL_0010: ldarg.0
IL_0011: ldc.i4.m1
IL_0012: stfld System.Int32 BugReportTest/<WaitForResultCoroutine>d__15::<>1__state
IL_0017: ldarg.0
IL_0018: ldarg.0
IL_0019: ldflda BugReportTest/CardCreateFileResponseData BugReportTest/<WaitForResultCoroutine>d__15::uploadUrl
IL_001e: ldfld System.String BugReportTest/CardCreateFileResponseData::url
IL_0023: ldarg.0
IL_0024: ldfld System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection> BugReportTest/<WaitForResultCoroutine>d__15::formData
IL_0029: call UnityEngine.Networking.UnityWebRequest UnityEngine.Networking.UnityWebRequest::Post(System.String,System.Collections.Generic.List`1<UnityEngine.Networking.IMultipartFormSection>)
IL_002e: stfld UnityEngine.Networking.UnityWebRequest BugReportTest/<WaitForResultCoroutine>d__15::<uploadRequest>5__2
IL_0033: ldarg.0
IL_0034: ldarg.0
IL_0035: ldfld UnityEngine.Networking.UnityWebRequest BugReportTest/<WaitForResultCoroutine>d__15::<uploadRequest>5__2
IL_003a: callvirt UnityEngine.Networking.UnityWebRequestAsyncOperation UnityEngine.Networking.UnityWebRequest::SendWebRequest()
IL_003f: stfld System.Object BugReportTest/<WaitForResultCoroutine>d__15::<>2__current
IL_0044: ldarg.0
IL_0045: ldc.i4.1
IL_0046: stfld System.Int32 BugReportTest/<WaitForResultCoroutine>d__15::<>1__state
IL_004b: ldc.i4.1
IL_004c: ret
IL_004d: ldarg.0
IL_004e: ldc.i4.m1
IL_004f: stfld System.Int32 BugReportTest/<WaitForResultCoroutine>d__15::<>1__state
IL_0054: ldarg.0
IL_0055: ldfld UnityEngine.Networking.UnityWebRequest BugReportTest/<WaitForResultCoroutine>d__15::<uploadRequest>5__2
IL_005a: callvirt UnityEngine.Networking.UnityWebRequest/Result UnityEngine.Networking.UnityWebRequest::get_result()
IL_005f: ldc.i4.1
IL_0060: beq.s IL_00ca
IL_0062: ldc.i4.5
IL_0063: newarr System.String
IL_0068: dup
IL_0069: ldc.i4.0
IL_006a: ldstr "Error uploading file "
IL_006f: stelem.ref
IL_0070: dup
IL_0071: ldc.i4.1
IL_0072: ldarg.0
IL_0073: ldflda BugReportTest/CardCreateFileResponseData BugReportTest/<WaitForResultCoroutine>d__15::uploadUrl
IL_0078: ldfld System.String BugReportTest/CardCreateFileResponseData::fileName
IL_007d: stelem.ref
IL_007e: dup
IL_007f: ldc.i4.2
IL_0080: ldstr " to "
IL_0085: stelem.ref
IL_0086: dup
IL_0087: ldc.i4.3
IL_0088: ldarg.0
IL_0089: ldflda BugReportTest/CardCreateFileResponseData BugReportTest/<WaitForResultCoroutine>d__15::uploadUrl
IL_008e: ldfld System.String BugReportTest/CardCreateFileResponseData::url
IL_0093: stelem.ref
IL_0094: dup
IL_0095: ldc.i4.4
IL_0096: ldstr " with {0} bytes: {1}"
IL_009b: ldarg.0
IL_009c: ldflda System.ValueTuple`2<System.Byte[],BugReportTest/CodecksFileType> BugReportTest/<WaitForResultCoroutine>d__15::fileData
IL_00a1: ldfld !0 System.ValueTuple`2<System.Byte[],BugReportTest/CodecksFileType>::Item1
IL_00a6: ldlen
IL_00a7: conv.i4
IL_00a8: box System.Int32
IL_00ad: ldarg.0
IL_00ae: ldfld UnityEngine.Networking.UnityWebRequest BugReportTest/<WaitForResultCoroutine>d__15::<uploadRequest>5__2
IL_00b3: callvirt System.String UnityEngine.Networking.UnityWebRequest::get_error()
IL_00b8: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_00bd: stelem.ref
IL_00be: call System.String System.String::Concat(System.String[])
IL_00c3: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00c8: ldc.i4.0
IL_00c9: ret
IL_00ca: ldc.i4.0
IL_00cb: ret
