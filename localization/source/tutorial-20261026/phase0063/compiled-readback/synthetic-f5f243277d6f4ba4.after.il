METHOD System.Void ForestProbe::ObserveLifecycle(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.String ForestProbe::root
IL_0007: brfalse.s IL_001b
IL_0009: ldarg.0
IL_000a: ldfld System.Int32 ForestProbe::lifecycleSequence
IL_000f: ldc.i4 4096
IL_0014: clt
IL_0016: ldc.i4.0
IL_0017: ceq
IL_0019: br.s IL_001c
IL_001b: ldc.i4.1
IL_001c: stloc.0
IL_001d: ldloc.0
IL_001e: brfalse.s IL_0025
IL_0020: br IL_0118
IL_0025: nop
IL_0026: nop
IL_0027: newobj System.Void ForestProbe/LifecycleRow::.ctor()
IL_002c: dup
IL_002d: ldarg.0
IL_002e: ldarg.0
IL_002f: ldfld System.Int32 ForestProbe::lifecycleSequence
IL_0034: stloc.2
IL_0035: ldloc.2
IL_0036: ldc.i4.1
IL_0037: add
IL_0038: stfld System.Int32 ForestProbe::lifecycleSequence
IL_003d: ldloc.2
IL_003e: stfld System.Int32 ForestProbe/LifecycleRow::sequence
IL_0043: dup
IL_0044: ldarg.1
IL_0045: stfld System.String ForestProbe/LifecycleRow::kind
IL_004a: dup
IL_004b: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0050: stfld System.Int32 ForestProbe/LifecycleRow::frame
IL_0055: dup
IL_0056: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_005b: stfld System.Single ForestProbe/LifecycleRow::realtime
IL_0060: dup
IL_0061: call System.UInt32 ForestProbe::GetCurrentProcessId()
IL_0066: stfld System.UInt32 ForestProbe/LifecycleRow::winPid
IL_006b: dup
IL_006c: call System.DateTime System.DateTime::get_UtcNow()
IL_0071: stloc.3
IL_0072: ldloca.s V_3
IL_0074: ldstr "O"
IL_0079: call System.String System.DateTime::ToString(System.String)
IL_007e: stfld System.String ForestProbe/LifecycleRow::utc
IL_0083: dup
IL_0084: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_0089: stloc.s V_4
IL_008b: ldloca.s V_4
IL_008d: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0092: stfld System.String ForestProbe/LifecycleRow::scene
IL_0097: dup
IL_0098: ldarg.0
IL_0099: ldfld System.String ForestProbe::lifecycleCommand
IL_009e: stfld System.String ForestProbe/LifecycleRow::command
IL_00a3: stloc.1
IL_00a4: ldarg.0
IL_00a5: ldfld System.Int32 ForestProbe::lifecycleSequence
IL_00aa: ldc.i4 4096
IL_00af: ceq
IL_00b1: stloc.s V_5
IL_00b3: ldloc.s V_5
IL_00b5: brfalse.s IL_00c2
IL_00b7: ldloc.1
IL_00b8: ldstr "limit"
IL_00bd: stfld System.String ForestProbe/LifecycleRow::kind
IL_00c2: ldarg.0
IL_00c3: ldfld System.String ForestProbe::root
IL_00c8: ldstr "lifecycle.jsonl"
IL_00cd: call System.String System.IO.Path::Combine(System.String,System.String)
IL_00d2: ldloc.1
IL_00d3: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_00d8: ldstr "
"
IL_00dd: call System.String System.String::Concat(System.String,System.String)
IL_00e2: call System.Void System.IO.File::AppendAllText(System.String,System.String)
IL_00e7: nop
IL_00e8: nop
IL_00e9: leave.s IL_0118
IL_00eb: stloc.s V_6
IL_00ed: nop
IL_00ee: ldarg.0
IL_00ef: ldc.i4 4096
IL_00f4: stfld System.Int32 ForestProbe::lifecycleSequence
IL_00f9: ldstr "FOREST_LIFECYCLE_IO_FAILED "
IL_00fe: ldloc.s V_6
IL_0100: callvirt System.Type System.Exception::GetType()
IL_0105: callvirt System.String System.Reflection.MemberInfo::get_Name()
IL_010a: call System.String System.String::Concat(System.String,System.String)
IL_010f: call System.Void UnityEngine.Debug::Log(System.Object)
IL_0114: nop
IL_0115: nop
IL_0116: leave.s IL_0118
IL_0118: ret
