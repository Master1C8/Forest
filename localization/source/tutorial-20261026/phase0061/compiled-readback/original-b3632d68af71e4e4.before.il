METHOD System.Void ForestProbe::DumpIntro() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void ForestProbe/State::.ctor()
IL_0006: stloc.1
IL_0007: ldloc.1
IL_0008: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_000d: stloc.2
IL_000e: ldloca.s V_2
IL_0010: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0015: stfld System.String ForestProbe/State::scene
IL_001a: ldloc.1
IL_001b: call System.String UnityEngine.Application::get_dataPath()
IL_0020: stfld System.String ForestProbe/State::dataPath
IL_0025: ldloc.1
IL_0026: call System.String UnityEngine.Application::get_persistentDataPath()
IL_002b: stfld System.String ForestProbe/State::persistentDataPath
IL_0030: ldloc.1
IL_0031: call System.String UnityEngine.Application::get_companyName()
IL_0036: stfld System.String ForestProbe/State::company
IL_003b: ldloc.1
IL_003c: call System.String UnityEngine.Application::get_productName()
IL_0041: stfld System.String ForestProbe/State::product
IL_0046: ldloc.1
IL_0047: call System.Int32 UnityEngine.Time::get_frameCount()
IL_004c: stfld System.Int32 ForestProbe/State::frame
IL_0051: ldloc.1
IL_0052: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0057: stfld System.Single ForestProbe/State::realtime
IL_005c: ldloc.1
IL_005d: call System.Single UnityEngine.Time::get_time()
IL_0062: stfld System.Single ForestProbe/State::scaledTime
IL_0067: ldloc.1
IL_0068: call System.Single UnityEngine.Time::get_timeScale()
IL_006d: stfld System.Single ForestProbe/State::timeScale
IL_0072: ldloc.1
IL_0073: ldc.i4.0
IL_0074: newarr System.String
IL_0079: stfld System.String[] ForestProbe/State::responseRecords
IL_007e: ldloc.1
IL_007f: ldc.i4.0
IL_0080: newarr System.String
IL_0085: stfld System.String[] ForestProbe/State::introDiagnostics
IL_008a: ldloc.1
IL_008b: stloc.0
IL_008c: ldloc.0
IL_008d: ldarg.0
IL_008e: ldloc.0
IL_008f: ldflda System.Boolean ForestProbe/State::dataServicePresent
IL_0094: ldloc.0
IL_0095: ldflda System.Boolean ForestProbe/State::manifestPresent
IL_009a: ldloc.0
IL_009b: ldflda System.Int32 ForestProbe/State::dataServiceInstance
IL_00a0: call System.String[] ForestProbe::ContinuationReadiness(System.Boolean&,System.Boolean&,System.Int32&)
IL_00a5: stfld System.String[] ForestProbe/State::notReady
IL_00aa: ldloc.0
IL_00ab: ldloc.0
IL_00ac: ldfld System.String[] ForestProbe/State::notReady
IL_00b1: ldlen
IL_00b2: ldc.i4.0
IL_00b3: ceq
IL_00b5: stfld System.Boolean ForestProbe/State::diagnosticsReady
IL_00ba: ldloc.0
IL_00bb: ldfld System.Boolean ForestProbe/State::diagnosticsReady
IL_00c0: stloc.3
IL_00c1: ldloc.3
IL_00c2: brfalse IL_01e1
IL_00c7: nop
IL_00c8: ldarg.0
IL_00c9: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_00ce: stloc.s V_4
IL_00d0: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00d5: stloc.s V_5
IL_00d7: ldloc.s V_5
IL_00d9: ldc.i4.8
IL_00da: newarr System.String
IL_00df: dup
IL_00e0: ldc.i4.0
IL_00e1: ldstr "guards | gameplay="
IL_00e6: stelem.ref
IL_00e7: dup
IL_00e8: ldc.i4.1
IL_00e9: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_00ee: stloc.s V_6
IL_00f0: ldloca.s V_6
IL_00f2: call System.String System.Boolean::ToString()
IL_00f7: stelem.ref
IL_00f8: dup
IL_00f9: ldc.i4.2
IL_00fa: ldstr " | dustin="
IL_00ff: stelem.ref
IL_0100: dup
IL_0101: ldc.i4.3
IL_0102: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_0107: stloc.s V_6
IL_0109: ldloca.s V_6
IL_010b: call System.String System.Boolean::ToString()
IL_0110: stelem.ref
IL_0111: dup
IL_0112: ldc.i4.4
IL_0113: ldstr " | glitch="
IL_0118: stelem.ref
IL_0119: dup
IL_011a: ldc.i4.5
IL_011b: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGlitchRoom()
IL_0120: stloc.s V_6
IL_0122: ldloca.s V_6
IL_0124: call System.String System.Boolean::ToString()
IL_0129: stelem.ref
IL_012a: dup
IL_012b: ldc.i4.6
IL_012c: ldstr " | anyEvent="
IL_0131: stelem.ref
IL_0132: dup
IL_0133: ldc.i4.7
IL_0134: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_0139: stloc.s V_6
IL_013b: ldloca.s V_6
IL_013d: call System.String System.Boolean::ToString()
IL_0142: stelem.ref
IL_0143: call System.String System.String::Concat(System.String[])
IL_0148: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_014d: nop
IL_014e: ldloc.s V_5
IL_0150: ldarg.0
IL_0151: call System.String[] ForestProbe::IntroCleanupDiagnostics()
IL_0156: callvirt System.Void System.Collections.Generic.List`1<System.String>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_015b: nop
IL_015c: ldloc.0
IL_015d: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0162: stfld System.String ForestProbe/State::narrativeDbName
IL_0167: ldloc.0
IL_0168: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_016d: stfld System.String ForestProbe/State::narrativeArcName
IL_0172: ldloc.0
IL_0173: ldloc.s V_4
IL_0175: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_017a: stfld System.Int32 ForestProbe/State::responseCount
IL_017f: ldloc.0
IL_0180: ldloc.s V_4
IL_0182: ldsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__81_0
IL_0187: dup
IL_0188: brtrue.s IL_01a1
IL_018a: pop
IL_018b: ldsfld ForestProbe/<>c ForestProbe/<>c::<>9
IL_0190: ldftn System.String ForestProbe/<>c::<DumpIntro>b__81_0(ForestProbe/ResponseRow)
IL_0196: newobj System.Void System.Converter`2<ForestProbe/ResponseRow,System.String>::.ctor(System.Object,System.IntPtr)
IL_019b: dup
IL_019c: stsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__81_0
IL_01a1: callvirt System.Collections.Generic.List`1<!!0> System.Collections.Generic.List`1<ForestProbe/ResponseRow>::ConvertAll<System.String>(System.Converter`2<!0,!!0>)
IL_01a6: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_01ab: stfld System.String[] ForestProbe/State::responseRecords
IL_01b0: ldloc.0
IL_01b1: call System.Boolean TheForestOfLove.CustomTypewriterEffectTextMeshPro::IsTyping()
IL_01b6: stfld System.Boolean ForestProbe/State::typing
IL_01bb: ldloc.0
IL_01bc: ldloc.s V_5
IL_01be: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_01c3: stfld System.String[] ForestProbe/State::introDiagnostics
IL_01c8: ldarg.0
IL_01c9: ldloc.0
IL_01ca: call System.Void ForestProbe::ReadConversation(ForestProbe/State)
IL_01cf: nop
IL_01d0: ldarg.0
IL_01d1: ldloc.0
IL_01d2: call System.Void ForestProbe::ReadTutorialCompletionRecord(ForestProbe/State)
IL_01d7: nop
IL_01d8: ldarg.0
IL_01d9: ldloc.0
IL_01da: call System.Void ForestProbe::ReadBuckyRecords(ForestProbe/State)
IL_01df: nop
IL_01e0: nop
IL_01e1: ldarg.0
IL_01e2: ldfld System.String ForestProbe::root
IL_01e7: ldstr "intro-state.json"
IL_01ec: call System.String System.IO.Path::Combine(System.String,System.String)
IL_01f1: ldloc.0
IL_01f2: ldc.i4.1
IL_01f3: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_01f8: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_01fd: nop
IL_01fe: ret
