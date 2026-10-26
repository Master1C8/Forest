TYPE ForestProbe/<Capture>d__35
METHOD System.Void ForestProbe/<Capture>d__35::.ctor(System.Int32) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
ATTRIBUTE System.Diagnostics.DebuggerHiddenAttribute
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: stfld System.Int32 ForestProbe/<Capture>d__35::<>1__state
IL_000e: ret
METHOD System.Void ForestProbe/<Capture>d__35::System.IDisposable.Dispose() | attributes=Private, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
ATTRIBUTE System.Diagnostics.DebuggerHiddenAttribute
IL_0000: ret
METHOD System.Boolean ForestProbe/<Capture>d__35::MoveNext() | attributes=Private, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 ForestProbe/<Capture>d__35::<>1__state
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0012
IL_000a: br.s IL_000c
IL_000c: ldloc.0
IL_000d: ldc.i4.1
IL_000e: beq.s IL_0014
IL_0010: br.s IL_0016
IL_0012: br.s IL_0018
IL_0014: br.s IL_0034
IL_0016: ldc.i4.0
IL_0017: ret
IL_0018: ldarg.0
IL_0019: ldc.i4.m1
IL_001a: stfld System.Int32 ForestProbe/<Capture>d__35::<>1__state
IL_001f: nop
IL_0020: ldarg.0
IL_0021: newobj System.Void UnityEngine.WaitForEndOfFrame::.ctor()
IL_0026: stfld System.Object ForestProbe/<Capture>d__35::<>2__current
IL_002b: ldarg.0
IL_002c: ldc.i4.1
IL_002d: stfld System.Int32 ForestProbe/<Capture>d__35::<>1__state
IL_0032: ldc.i4.1
IL_0033: ret
IL_0034: ldarg.0
IL_0035: ldc.i4.m1
IL_0036: stfld System.Int32 ForestProbe/<Capture>d__35::<>1__state
IL_003b: ldarg.0
IL_003c: ldfld System.String ForestProbe/<Capture>d__35::path
IL_0041: call System.Void UnityEngine.ScreenCapture::CaptureScreenshot(System.String)
IL_0046: nop
IL_0047: ldstr "FOREST_PROBE_CAPTURE "
IL_004c: ldarg.0
IL_004d: ldfld System.String ForestProbe/<Capture>d__35::path
IL_0052: call System.String System.String::Concat(System.String,System.String)
IL_0057: call System.Void UnityEngine.Debug::Log(System.Object)
IL_005c: nop
IL_005d: ldc.i4.0
IL_005e: ret
METHOD System.Object ForestProbe/<Capture>d__35::System.Collections.Generic.IEnumerator<System.Object>.get_Current() | attributes=Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
ATTRIBUTE System.Diagnostics.DebuggerHiddenAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Object ForestProbe/<Capture>d__35::<>2__current
IL_0006: ret
METHOD System.Void ForestProbe/<Capture>d__35::System.Collections.IEnumerator.Reset() | attributes=Private, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
ATTRIBUTE System.Diagnostics.DebuggerHiddenAttribute
IL_0000: newobj System.Void System.NotSupportedException::.ctor()
IL_0005: throw
METHOD System.Object ForestProbe/<Capture>d__35::System.Collections.IEnumerator.get_Current() | attributes=Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName | impl=IL
ATTRIBUTE System.Diagnostics.DebuggerHiddenAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Object ForestProbe/<Capture>d__35::<>2__current
IL_0006: ret
