TYPE ForestProbe
METHOD System.String[] ForestProbe::ContinuationReadiness(System.Boolean&,System.Boolean&,System.Int32&) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.1
IL_0002: ldc.i4.0
IL_0003: stind.i1
IL_0004: ldarg.2
IL_0005: ldc.i4.0
IL_0006: stind.i1
IL_0007: ldarg.3
IL_0008: ldc.i4.0
IL_0009: stind.i4
IL_000a: ldtoken TheForestOfLove.Services.Persistence.DataService
IL_000f: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0014: ldstr "_instance"
IL_0019: ldc.i4.s 40
IL_001b: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0020: stloc.0
IL_0021: ldloc.0
IL_0022: ldnull
IL_0023: call System.Boolean System.Reflection.FieldInfo::op_Equality(System.Reflection.FieldInfo,System.Reflection.FieldInfo)
IL_0028: stloc.s V_6
IL_002a: ldloc.s V_6
IL_002c: brfalse.s IL_0039
IL_002e: ldstr "Unknown original DataService singleton field"
IL_0033: newobj System.Void System.Exception::.ctor(System.String)
IL_0038: throw
IL_0039: ldloc.0
IL_003a: ldnull
IL_003b: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0040: isinst TheForestOfLove.Services.Persistence.DataService
IL_0045: stloc.1
IL_0046: ldloc.1
IL_0047: ldnull
IL_0048: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_004d: stloc.s V_7
IL_004f: ldloc.s V_7
IL_0051: brfalse.s IL_0068
IL_0053: ldc.i4.1
IL_0054: newarr System.String
IL_0059: dup
IL_005a: ldc.i4.0
IL_005b: ldstr "DataService._instance"
IL_0060: stelem.ref
IL_0061: stloc.s V_8
IL_0063: br IL_0382
IL_0068: ldarg.1
IL_0069: ldc.i4.1
IL_006a: stind.i1
IL_006b: ldarg.3
IL_006c: ldloc.1
IL_006d: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_0072: stind.i4
IL_0073: ldloc.1
IL_0074: ldstr "_manifest"
IL_0079: call System.Object ForestProbe::ReadField(System.Object,System.String)
IL_007e: isinst TheForestOfLove.Narrative.DataManifest
IL_0083: stloc.2
IL_0084: ldloc.2
IL_0085: ldnull
IL_0086: ceq
IL_0088: stloc.s V_9
IL_008a: ldloc.s V_9
IL_008c: brfalse.s IL_00a3
IL_008e: ldc.i4.1
IL_008f: newarr System.String
IL_0094: dup
IL_0095: ldc.i4.0
IL_0096: ldstr "DataService._manifest"
IL_009b: stelem.ref
IL_009c: stloc.s V_8
IL_009e: br IL_0382
IL_00a3: ldarg.2
IL_00a4: ldc.i4.1
IL_00a5: stind.i1
IL_00a6: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_00ab: stloc.3
IL_00ac: ldloc.2
IL_00ad: ldfld TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Narrative.DataManifest::playerRespawnData
IL_00b2: ldnull
IL_00b3: ceq
IL_00b5: stloc.s V_10
IL_00b7: ldloc.s V_10
IL_00b9: brfalse.s IL_00c7
IL_00bb: ldloc.3
IL_00bc: ldstr "DataManifest.playerRespawnData"
IL_00c1: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00c6: nop
IL_00c7: ldloc.2
IL_00c8: ldfld TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Narrative.DataManifest::generalData
IL_00cd: ldnull
IL_00ce: ceq
IL_00d0: stloc.s V_11
IL_00d2: ldloc.s V_11
IL_00d4: brfalse.s IL_00e2
IL_00d6: ldloc.3
IL_00d7: ldstr "DataManifest.generalData"
IL_00dc: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00e1: nop
IL_00e2: ldloc.2
IL_00e3: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByTriggerName
IL_00e8: ldnull
IL_00e9: ceq
IL_00eb: stloc.s V_12
IL_00ed: ldloc.s V_12
IL_00ef: brfalse.s IL_00fd
IL_00f1: ldloc.3
IL_00f2: ldstr "DataManifest.triggersByTriggerName"
IL_00f7: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00fc: nop
IL_00fd: ldloc.2
IL_00fe: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::activeTagsByDbName
IL_0103: ldnull
IL_0104: ceq
IL_0106: stloc.s V_13
IL_0108: ldloc.s V_13
IL_010a: brfalse.s IL_0118
IL_010c: ldloc.3
IL_010d: ldstr "DataManifest.activeTagsByDbName"
IL_0112: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0117: nop
IL_0118: ldloc.2
IL_0119: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbName
IL_011e: ldnull
IL_011f: ceq
IL_0121: stloc.s V_14
IL_0123: ldloc.s V_14
IL_0125: brfalse.s IL_0135
IL_0127: ldloc.3
IL_0128: ldstr "DataManifest.dialoguesByDbName"
IL_012d: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0132: nop
IL_0133: br.s IL_0165
IL_0135: nop
IL_0136: ldloc.2
IL_0137: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbName
IL_013c: ldstr "NewGame_Intro"
IL_0141: ldloca.s V_15
IL_0143: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::TryGetValue(!0,!1&)
IL_0148: brfalse.s IL_0151
IL_014a: ldloc.s V_15
IL_014c: ldnull
IL_014d: ceq
IL_014f: br.s IL_0152
IL_0151: ldc.i4.1
IL_0152: stloc.s V_16
IL_0154: ldloc.s V_16
IL_0156: brfalse.s IL_0164
IL_0158: ldloc.3
IL_0159: ldstr "dialogue.NewGame_Intro"
IL_015e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0163: nop
IL_0164: nop
IL_0165: ldloc.2
IL_0166: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_016b: ldnull
IL_016c: ceq
IL_016e: stloc.s V_17
IL_0170: ldloc.s V_17
IL_0172: brfalse.s IL_0185
IL_0174: ldloc.3
IL_0175: ldstr "DataManifest.questsByDbName"
IL_017a: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_017f: nop
IL_0180: br IL_030d
IL_0185: nop
IL_0186: ldc.i4.2
IL_0187: newarr System.String
IL_018c: dup
IL_018d: ldc.i4.0
IL_018e: ldstr "Act1_TutorialQuest"
IL_0193: stelem.ref
IL_0194: dup
IL_0195: ldc.i4.1
IL_0196: ldstr "Act1_GossipQuest"
IL_019b: stelem.ref
IL_019c: stloc.s V_18
IL_019e: ldc.i4.0
IL_019f: stloc.s V_19
IL_01a1: br IL_0302
IL_01a6: ldloc.s V_18
IL_01a8: ldloc.s V_19
IL_01aa: ldelem.ref
IL_01ab: stloc.s V_20
IL_01ad: nop
IL_01ae: ldloc.2
IL_01af: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbName
IL_01b4: ldloc.s V_20
IL_01b6: ldloca.s V_21
IL_01b8: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::TryGetValue(!0,!1&)
IL_01bd: brfalse.s IL_01c6
IL_01bf: ldloc.s V_21
IL_01c1: ldnull
IL_01c2: ceq
IL_01c4: br.s IL_01c7
IL_01c6: ldc.i4.1
IL_01c7: stloc.s V_22
IL_01c9: ldloc.s V_22
IL_01cb: brfalse.s IL_01e6
IL_01cd: nop
IL_01ce: ldloc.3
IL_01cf: ldstr "quest."
IL_01d4: ldloc.s V_20
IL_01d6: call System.String System.String::Concat(System.String,System.String)
IL_01db: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_01e0: nop
IL_01e1: br IL_02fc
IL_01e6: ldloc.s V_21
IL_01e8: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.Quest::dialogues
IL_01ed: ldnull
IL_01ee: ceq
IL_01f0: stloc.s V_23
IL_01f2: ldloc.s V_23
IL_01f4: brfalse.s IL_0214
IL_01f6: nop
IL_01f7: ldloc.3
IL_01f8: ldstr "quest."
IL_01fd: ldloc.s V_20
IL_01ff: ldstr ".dialogues"
IL_0204: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0209: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_020e: nop
IL_020f: br IL_02fc
IL_0214: nop
IL_0215: ldloc.s V_21
IL_0217: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.Quest::dialogues
IL_021c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0221: stloc.s V_24
IL_0223: br IL_02de
IL_0228: ldloca.s V_24
IL_022a: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_022f: stloc.s V_25
IL_0231: nop
IL_0232: ldloc.s V_25
IL_0234: ldnull
IL_0235: ceq
IL_0237: stloc.s V_26
IL_0239: ldloc.s V_26
IL_023b: brfalse.s IL_025b
IL_023d: nop
IL_023e: ldloc.3
IL_023f: ldstr "quest."
IL_0244: ldloc.s V_20
IL_0246: ldstr ".dialogue"
IL_024b: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0250: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0255: nop
IL_0256: br IL_02de
IL_025b: ldloc.s V_25
IL_025d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_0262: ldnull
IL_0263: ceq
IL_0265: stloc.s V_27
IL_0267: ldloc.s V_27
IL_0269: brfalse.s IL_0286
IL_026b: nop
IL_026c: ldloc.3
IL_026d: ldstr "quest."
IL_0272: ldloc.s V_20
IL_0274: ldstr ".primaryArcs"
IL_0279: call System.String System.String::Concat(System.String,System.String,System.String)
IL_027e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0283: nop
IL_0284: br.s IL_02de
IL_0286: nop
IL_0287: ldloc.s V_25
IL_0289: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_028e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0293: stloc.s V_28
IL_0295: br.s IL_02c3
IL_0297: ldloca.s V_28
IL_0299: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::get_Current()
IL_029e: stloc.s V_29
IL_02a0: ldloc.s V_29
IL_02a2: ldnull
IL_02a3: ceq
IL_02a5: stloc.s V_30
IL_02a7: ldloc.s V_30
IL_02a9: brfalse.s IL_02c3
IL_02ab: ldloc.3
IL_02ac: ldstr "quest."
IL_02b1: ldloc.s V_20
IL_02b3: ldstr ".primaryArc"
IL_02b8: call System.String System.String::Concat(System.String,System.String,System.String)
IL_02bd: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_02c2: nop
IL_02c3: ldloca.s V_28
IL_02c5: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>::MoveNext()
IL_02ca: brtrue.s IL_0297
IL_02cc: leave.s IL_02dd
IL_02ce: ldloca.s V_28
IL_02d0: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Arc>
IL_02d6: callvirt System.Void System.IDisposable::Dispose()
IL_02db: nop
IL_02dc: endfinally
IL_02dd: nop
IL_02de: ldloca.s V_24
IL_02e0: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_02e5: brtrue IL_0228
IL_02ea: leave.s IL_02fb
IL_02ec: ldloca.s V_24
IL_02ee: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Dialogue>
IL_02f4: callvirt System.Void System.IDisposable::Dispose()
IL_02f9: nop
IL_02fa: endfinally
IL_02fb: nop
IL_02fc: ldloc.s V_19
IL_02fe: ldc.i4.1
IL_02ff: add
IL_0300: stloc.s V_19
IL_0302: ldloc.s V_19
IL_0304: ldloc.s V_18
IL_0306: ldlen
IL_0307: conv.i4
IL_0308: blt IL_01a6
IL_030d: ldtoken TheForestOfLove.Events.GameStateManager
IL_0312: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0317: ldstr "isEventActive"
IL_031c: ldc.i4.s 56
IL_031e: callvirt System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)
IL_0323: stloc.s V_4
IL_0325: ldloc.s V_4
IL_0327: ldnull
IL_0328: call System.Boolean System.Reflection.FieldInfo::op_Equality(System.Reflection.FieldInfo,System.Reflection.FieldInfo)
IL_032d: stloc.s V_31
IL_032f: ldloc.s V_31
IL_0331: brfalse.s IL_033e
IL_0333: ldstr "Unknown original event array field"
IL_0338: newobj System.Void System.Exception::.ctor(System.String)
IL_033d: throw
IL_033e: ldloc.s V_4
IL_0340: ldnull
IL_0341: callvirt System.Object System.Reflection.FieldInfo::GetValue(System.Object)
IL_0346: isinst System.Boolean[]
IL_034b: stloc.s V_5
IL_034d: ldloc.s V_5
IL_034f: brfalse.s IL_035b
IL_0351: ldloc.s V_5
IL_0353: ldlen
IL_0354: conv.i4
IL_0355: ldc.i4.s 11
IL_0357: clt
IL_0359: br.s IL_035c
IL_035b: ldc.i4.1
IL_035c: stloc.s V_32
IL_035e: ldloc.s V_32
IL_0360: brfalse.s IL_036e
IL_0362: ldloc.3
IL_0363: ldstr "GameStateManager.isEventActive"
IL_0368: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_036d: nop
IL_036e: ldloc.3
IL_036f: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0374: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_0379: call !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_037e: stloc.s V_8
IL_0380: br.s IL_0382
IL_0382: ldloc.s V_8
IL_0384: ret
TYPE ForestProbe
METHOD System.Void ForestProbe::DumpSaveContinuation() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: newobj System.Void ForestProbe/SaveContinuationState::.ctor()
IL_0006: stloc.s V_6
IL_0008: ldloc.s V_6
IL_000a: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_000f: stloc.s V_7
IL_0011: ldloca.s V_7
IL_0013: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0018: stfld System.String ForestProbe/SaveContinuationState::scene
IL_001d: ldloc.s V_6
IL_001f: call System.String UnityEngine.Application::get_companyName()
IL_0024: stfld System.String ForestProbe/SaveContinuationState::company
IL_0029: ldloc.s V_6
IL_002b: call System.String UnityEngine.Application::get_productName()
IL_0030: stfld System.String ForestProbe/SaveContinuationState::product
IL_0035: ldloc.s V_6
IL_0037: call System.String UnityEngine.Application::get_dataPath()
IL_003c: stfld System.String ForestProbe/SaveContinuationState::dataPath
IL_0041: ldloc.s V_6
IL_0043: call System.String UnityEngine.Application::get_persistentDataPath()
IL_0048: stfld System.String ForestProbe/SaveContinuationState::persistentDataPath
IL_004d: ldloc.s V_6
IL_004f: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0054: stfld System.Int32 ForestProbe/SaveContinuationState::frame
IL_0059: ldloc.s V_6
IL_005b: call System.Single UnityEngine.Time::get_realtimeSinceStartup()
IL_0060: stfld System.Single ForestProbe/SaveContinuationState::realtime
IL_0065: ldloc.s V_6
IL_0067: call System.Single UnityEngine.Time::get_time()
IL_006c: stfld System.Single ForestProbe/SaveContinuationState::scaledTime
IL_0071: ldloc.s V_6
IL_0073: call System.Single UnityEngine.Time::get_timeScale()
IL_0078: stfld System.Single ForestProbe/SaveContinuationState::timeScale
IL_007d: ldloc.s V_6
IL_007f: ldc.i4.0
IL_0080: newarr System.String
IL_0085: stfld System.String[] ForestProbe/SaveContinuationState::diagnostics
IL_008a: ldloc.s V_6
IL_008c: stloc.0
IL_008d: ldloc.0
IL_008e: ldarg.0
IL_008f: ldloc.0
IL_0090: ldflda System.Boolean ForestProbe/SaveContinuationState::dataServicePresent
IL_0095: ldloc.0
IL_0096: ldflda System.Boolean ForestProbe/SaveContinuationState::manifestPresent
IL_009b: ldloc.0
IL_009c: ldflda System.Int32 ForestProbe/SaveContinuationState::dataServiceInstance
IL_00a1: call System.String[] ForestProbe::ContinuationReadiness(System.Boolean&,System.Boolean&,System.Int32&)
IL_00a6: stfld System.String[] ForestProbe/SaveContinuationState::notReady
IL_00ab: ldloc.0
IL_00ac: ldloc.0
IL_00ad: ldfld System.String[] ForestProbe/SaveContinuationState::notReady
IL_00b2: ldlen
IL_00b3: ldc.i4.0
IL_00b4: ceq
IL_00b6: stfld System.Boolean ForestProbe/SaveContinuationState::diagnosticsReady
IL_00bb: ldloc.0
IL_00bc: ldfld System.Boolean ForestProbe/SaveContinuationState::diagnosticsReady
IL_00c1: ldc.i4.0
IL_00c2: ceq
IL_00c4: stloc.s V_8
IL_00c6: ldloc.s V_8
IL_00c8: brfalse.s IL_00ed
IL_00ca: nop
IL_00cb: ldarg.0
IL_00cc: ldfld System.String ForestProbe::root
IL_00d1: ldstr "save-continuation.json"
IL_00d6: call System.String System.IO.Path::Combine(System.String,System.String)
IL_00db: ldloc.0
IL_00dc: ldc.i4.1
IL_00dd: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_00e2: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_00e7: nop
IL_00e8: br IL_0306
IL_00ed: call TheForestOfLove.Services.Persistence.PlayerRespawnData TheForestOfLove.Services.Persistence.DataService::GetPlayerRespawnData()
IL_00f2: stloc.1
IL_00f3: call TheForestOfLove.Services.Persistence.GeneralData TheForestOfLove.Services.Persistence.DataService::GetGeneralData()
IL_00f8: stloc.2
IL_00f9: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_00fe: stloc.3
IL_00ff: ldstr "NewGame_Intro"
IL_0104: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String)
IL_0109: stloc.s V_4
IL_010b: ldloc.s V_4
IL_010d: ldnull
IL_010e: ceq
IL_0110: stloc.s V_9
IL_0112: ldloc.s V_9
IL_0114: brfalse.s IL_0121
IL_0116: ldstr "Missing original intro record"
IL_011b: newobj System.Void System.Exception::.ctor(System.String)
IL_0120: throw
IL_0121: ldc.i4.0
IL_0122: stloc.s V_5
IL_0124: nop
IL_0125: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<TheForestOfLove.TutorialQuestBunnyIntroduction>()
IL_012a: stloc.s V_10
IL_012c: ldc.i4.0
IL_012d: stloc.s V_11
IL_012f: br.s IL_0170
IL_0131: ldloc.s V_10
IL_0133: ldloc.s V_11
IL_0135: ldelem.ref
IL_0136: stloc.s V_12
IL_0138: ldloc.s V_12
IL_013a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_013f: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_0144: stloc.s V_7
IL_0146: ldloca.s V_7
IL_0148: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_014d: brfalse.s IL_015d
IL_014f: ldloc.s V_12
IL_0151: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0156: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_015b: br.s IL_015e
IL_015d: ldc.i4.0
IL_015e: stloc.s V_13
IL_0160: ldloc.s V_13
IL_0162: brfalse.s IL_016a
IL_0164: ldloc.s V_5
IL_0166: ldc.i4.1
IL_0167: add
IL_0168: stloc.s V_5
IL_016a: ldloc.s V_11
IL_016c: ldc.i4.1
IL_016d: add
IL_016e: stloc.s V_11
IL_0170: ldloc.s V_11
IL_0172: ldloc.s V_10
IL_0174: ldlen
IL_0175: conv.i4
IL_0176: blt.s IL_0131
IL_0178: ldloc.0
IL_0179: call System.Boolean TheForestOfLove.Services.Persistence.SaveManager::get_HasSavedPlaySession()
IL_017e: stfld System.Boolean ForestProbe/SaveContinuationState::hasSavedPlaySession
IL_0183: ldloc.0
IL_0184: ldsfld System.Boolean Globals::isChapterSelect
IL_0189: stfld System.Boolean ForestProbe/SaveContinuationState::isChapterSelect
IL_018e: ldloc.0
IL_018f: ldsfld System.Boolean Globals::isCheatCode
IL_0194: stfld System.Boolean ForestProbe/SaveContinuationState::isCheatCode
IL_0199: ldloc.0
IL_019a: ldsfld System.Boolean Globals::isFinishingSoftReset
IL_019f: stfld System.Boolean ForestProbe/SaveContinuationState::isFinishingSoftReset
IL_01a4: ldloc.0
IL_01a5: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_01aa: stfld System.Boolean ForestProbe/SaveContinuationState::gameplay
IL_01af: ldloc.0
IL_01b0: call System.Boolean TheForestOfLove.Events.GameStateManager::get_isAnyEventActive()
IL_01b5: stfld System.Boolean ForestProbe/SaveContinuationState::anyEvent
IL_01ba: ldloc.0
IL_01bb: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_IsConversationActive()
IL_01c0: stfld System.Boolean ForestProbe/SaveContinuationState::conversation
IL_01c5: ldloc.0
IL_01c6: ldloc.1
IL_01c7: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::currentAreaUnitySceneName
IL_01cc: stfld System.String ForestProbe/SaveContinuationState::currentArea
IL_01d1: ldloc.0
IL_01d2: ldloc.1
IL_01d3: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::lastAreaUnitySceneName
IL_01d8: stfld System.String ForestProbe/SaveContinuationState::lastArea
IL_01dd: ldloc.0
IL_01de: ldloc.1
IL_01df: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPosition
IL_01e4: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::lastPosition
IL_01e9: ldloc.0
IL_01ea: ldloc.1
IL_01eb: ldfld UnityEngine.Vector3 TheForestOfLove.Services.Persistence.PlayerRespawnData::lastSpawnPosition
IL_01f0: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::lastSpawnPosition
IL_01f5: ldloc.0
IL_01f6: ldloc.1
IL_01f7: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::lastPositionExact
IL_01fc: stfld System.Boolean ForestProbe/SaveContinuationState::lastPositionExact
IL_0201: ldloc.0
IL_0202: ldloc.1
IL_0203: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isSwimming
IL_0208: stfld System.Boolean ForestProbe/SaveContinuationState::isSwimming
IL_020d: ldloc.0
IL_020e: ldloc.1
IL_020f: ldfld System.Boolean TheForestOfLove.Services.Persistence.PlayerRespawnData::isFastTraveling
IL_0214: stfld System.Boolean ForestProbe/SaveContinuationState::isFastTraveling
IL_0219: ldloc.0
IL_021a: ldloc.1
IL_021b: ldfld System.String TheForestOfLove.Services.Persistence.PlayerRespawnData::cameraSettingsObjectName
IL_0220: stfld System.String ForestProbe/SaveContinuationState::cameraSettingsObjectName
IL_0225: ldloc.0
IL_0226: ldloc.2
IL_0227: ldfld System.Single TheForestOfLove.Services.Persistence.GeneralData::storyClock
IL_022c: stfld System.Single ForestProbe/SaveContinuationState::storyClock
IL_0231: ldloc.0
IL_0232: ldloc.2
IL_0233: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedControlTutorial
IL_0238: stfld System.Boolean ForestProbe/SaveContinuationState::finishedControlTutorial
IL_023d: ldloc.0
IL_023e: ldloc.2
IL_023f: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedDialogueTutorial
IL_0244: stfld System.Boolean ForestProbe/SaveContinuationState::finishedDialogueTutorial
IL_0249: ldloc.0
IL_024a: ldloc.2
IL_024b: ldfld System.Boolean TheForestOfLove.Services.Persistence.GeneralData::finishedGossipTutorial
IL_0250: stfld System.Boolean ForestProbe/SaveContinuationState::finishedGossipTutorial
IL_0255: ldloc.0
IL_0256: ldloc.3
IL_0257: ldnull
IL_0258: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_025d: brfalse.s IL_026c
IL_025f: ldloc.3
IL_0260: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0265: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_026a: br.s IL_026d
IL_026c: ldc.i4.0
IL_026d: stfld System.Boolean ForestProbe/SaveContinuationState::playerPresent
IL_0272: ldloc.0
IL_0273: ldloc.3
IL_0274: ldnull
IL_0275: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_027a: brtrue.s IL_0289
IL_027c: ldloc.3
IL_027d: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0282: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0287: br.s IL_028a
IL_0289: ldnull
IL_028a: stfld System.String ForestProbe/SaveContinuationState::playerPath
IL_028f: ldloc.0
IL_0290: ldloc.3
IL_0291: ldnull
IL_0292: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0297: brtrue.s IL_02a1
IL_0299: ldloc.3
IL_029a: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_029f: br.s IL_02a2
IL_02a1: ldc.i4.0
IL_02a2: stfld System.Int32 ForestProbe/SaveContinuationState::playerInstance
IL_02a7: ldloc.0
IL_02a8: ldloc.3
IL_02a9: ldnull
IL_02aa: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_02af: brtrue.s IL_02be
IL_02b1: ldloc.3
IL_02b2: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_02b7: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_02bc: br.s IL_02c3
IL_02be: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_02c3: stfld UnityEngine.Vector3 ForestProbe/SaveContinuationState::playerPosition
IL_02c8: ldloc.0
IL_02c9: ldloc.s V_4
IL_02cb: callvirt TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_02d0: stfld System.Int32 ForestProbe/SaveContinuationState::introStatus
IL_02d5: ldloc.0
IL_02d6: ldloc.s V_5
IL_02d8: stfld System.Int32 ForestProbe/SaveContinuationState::tutorialIntroControllers
IL_02dd: ldloc.0
IL_02de: ldarg.0
IL_02df: call System.String[] ForestProbe::TutorialRouteDiagnostics()
IL_02e4: stfld System.String[] ForestProbe/SaveContinuationState::diagnostics
IL_02e9: ldarg.0
IL_02ea: ldfld System.String ForestProbe::root
IL_02ef: ldstr "save-continuation.json"
IL_02f4: call System.String System.IO.Path::Combine(System.String,System.String)
IL_02f9: ldloc.0
IL_02fa: ldc.i4.1
IL_02fb: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_0300: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_0305: nop
IL_0306: ret
TYPE ForestProbe
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
IL_00c2: brfalse IL_01d1
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
IL_0182: ldsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__47_0
IL_0187: dup
IL_0188: brtrue.s IL_01a1
IL_018a: pop
IL_018b: ldsfld ForestProbe/<>c ForestProbe/<>c::<>9
IL_0190: ldftn System.String ForestProbe/<>c::<DumpIntro>b__47_0(ForestProbe/ResponseRow)
IL_0196: newobj System.Void System.Converter`2<ForestProbe/ResponseRow,System.String>::.ctor(System.Object,System.IntPtr)
IL_019b: dup
IL_019c: stsfld System.Converter`2<ForestProbe/ResponseRow,System.String> ForestProbe/<>c::<>9__47_0
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
IL_01d0: nop
IL_01d1: ldarg.0
IL_01d2: ldfld System.String ForestProbe::root
IL_01d7: ldstr "intro-state.json"
IL_01dc: call System.String System.IO.Path::Combine(System.String,System.String)
IL_01e1: ldloc.0
IL_01e2: ldc.i4.1
IL_01e3: call System.String UnityEngine.JsonUtility::ToJson(System.Object,System.Boolean)
IL_01e8: call System.Void System.IO.File::WriteAllText(System.String,System.String)
IL_01ed: nop
IL_01ee: ret
