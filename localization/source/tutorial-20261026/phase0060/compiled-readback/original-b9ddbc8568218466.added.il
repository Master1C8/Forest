METHOD System.String[] ForestProbe::BuckyCompletionDiagnostics() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: call System.String[] ForestProbe::TutorialRouteDiagnostics()
IL_0007: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor(System.Collections.Generic.IEnumerable`1<!0>)
IL_000c: stloc.0
IL_000d: ldloc.0
IL_000e: ldc.i4.6
IL_000f: newarr System.String
IL_0014: dup
IL_0015: ldc.i4.0
IL_0016: ldstr "buckyCompletion | notebookLearned="
IL_001b: stelem.ref
IL_001c: dup
IL_001d: ldc.i4.1
IL_001e: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedNotebook()
IL_0023: stloc.3
IL_0024: ldloca.s V_3
IL_0026: call System.String System.Boolean::ToString()
IL_002b: stelem.ref
IL_002c: dup
IL_002d: ldc.i4.2
IL_002e: ldstr " | observerArmed="
IL_0033: stelem.ref
IL_0034: dup
IL_0035: ldc.i4.3
IL_0036: ldarg.0
IL_0037: ldfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> ForestProbe::buckyLineEndSource
IL_003c: ldnull
IL_003d: cgt.un
IL_003f: stloc.3
IL_0040: ldloca.s V_3
IL_0042: call System.String System.Boolean::ToString()
IL_0047: stelem.ref
IL_0048: dup
IL_0049: ldc.i4.4
IL_004a: ldstr " | lineEnd="
IL_004f: stelem.ref
IL_0050: dup
IL_0051: ldc.i4.5
IL_0052: ldarg.0
IL_0053: ldfld ForestProbe/Bucky212End ForestProbe::bucky212End
IL_0058: brfalse.s IL_0067
IL_005a: ldarg.0
IL_005b: ldfld ForestProbe/Bucky212End ForestProbe::bucky212End
IL_0060: call System.String UnityEngine.JsonUtility::ToJson(System.Object)
IL_0065: br.s IL_006c
IL_0067: ldstr "null"
IL_006c: stelem.ref
IL_006d: call System.String System.String::Concat(System.String[])
IL_0072: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0077: nop
IL_0078: ldstr "TutorialQuest_BeaverIntroduction"
IL_007d: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String)
IL_0082: stloc.1
IL_0083: ldloc.1
IL_0084: ldnull
IL_0085: ceq
IL_0087: stloc.s V_4
IL_0089: ldloc.s V_4
IL_008b: brfalse.s IL_0098
IL_008d: ldstr "Bucky completion dialogue absent"
IL_0092: newobj System.Void System.Exception::.ctor(System.String)
IL_0097: throw
IL_0098: nop
IL_0099: ldloc.1
IL_009a: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_009f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::GetEnumerator()
IL_00a4: stloc.s V_5
IL_00a6: br IL_0157
IL_00ab: ldloca.s V_5
IL_00ad: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::get_Current()
IL_00b2: stloc.s V_6
IL_00b4: nop
IL_00b5: ldloc.s V_6
IL_00b7: isinst TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger
IL_00bc: stloc.s V_7
IL_00be: ldloc.0
IL_00bf: ldc.i4.s 10
IL_00c1: newarr System.String
IL_00c6: dup
IL_00c7: ldc.i4.0
IL_00c8: ldstr "buckyArcTrigger | type="
IL_00cd: stelem.ref
IL_00ce: dup
IL_00cf: ldc.i4.1
IL_00d0: ldloc.s V_6
IL_00d2: callvirt System.Type System.Object::GetType()
IL_00d7: callvirt System.String System.Type::get_FullName()
IL_00dc: stelem.ref
IL_00dd: dup
IL_00de: ldc.i4.2
IL_00df: ldstr " | conversation="
IL_00e4: stelem.ref
IL_00e5: dup
IL_00e6: ldc.i4.3
IL_00e7: ldloc.s V_6
IL_00e9: callvirt System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::GetConversationId()
IL_00ee: stloc.s V_8
IL_00f0: ldloca.s V_8
IL_00f2: call System.String System.Int32::ToString()
IL_00f7: stelem.ref
IL_00f8: dup
IL_00f9: ldc.i4.4
IL_00fa: ldstr " | entry="
IL_00ff: stelem.ref
IL_0100: dup
IL_0101: ldc.i4.5
IL_0102: ldloc.s V_6
IL_0104: callvirt System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::GetDialogueEntryId()
IL_0109: stloc.s V_8
IL_010b: ldloca.s V_8
IL_010d: call System.String System.Int32::ToString()
IL_0112: stelem.ref
IL_0113: dup
IL_0114: ldc.i4.6
IL_0115: ldstr " | executed="
IL_011a: stelem.ref
IL_011b: dup
IL_011c: ldc.i4.7
IL_011d: ldloc.s V_6
IL_011f: callvirt System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_isExecuted()
IL_0124: stloc.3
IL_0125: ldloca.s V_3
IL_0127: call System.String System.Boolean::ToString()
IL_012c: stelem.ref
IL_012d: dup
IL_012e: ldc.i4.8
IL_012f: ldstr " | namedTrigger="
IL_0134: stelem.ref
IL_0135: dup
IL_0136: ldc.i4.s 9
IL_0138: ldloc.s V_7
IL_013a: brfalse.s IL_0145
IL_013c: ldloc.s V_7
IL_013e: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_0143: br.s IL_014a
IL_0145: ldstr ""
IL_014a: stelem.ref
IL_014b: call System.String System.String::Concat(System.String[])
IL_0150: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0155: nop
IL_0156: nop
IL_0157: ldloca.s V_5
IL_0159: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::MoveNext()
IL_015e: brtrue IL_00ab
IL_0163: leave.s IL_0174
IL_0165: ldloca.s V_5
IL_0167: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>
IL_016d: callvirt System.Void System.IDisposable::Dispose()
IL_0172: nop
IL_0173: endfinally
IL_0174: ldc.i4 225
IL_0179: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByPluginDbId(System.Int32)
IL_017e: stloc.2
IL_017f: ldloc.2
IL_0180: brfalse.s IL_0194
IL_0182: ldloc.2
IL_0183: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0188: ldstr "GossipQuest_GetTheNotebook"
IL_018d: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0192: br.s IL_0195
IL_0194: ldc.i4.1
IL_0195: stloc.s V_9
IL_0197: ldloc.s V_9
IL_0199: brfalse.s IL_01a6
IL_019b: ldstr "Notebook completion dialogue differs"
IL_01a0: newobj System.Void System.Exception::.ctor(System.String)
IL_01a5: throw
IL_01a6: nop
IL_01a7: ldloc.2
IL_01a8: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger> TheForestOfLove.Narrative.Dialogue::arcTriggers
IL_01ad: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::GetEnumerator()
IL_01b2: stloc.s V_10
IL_01b4: br IL_024d
IL_01b9: ldloca.s V_10
IL_01bb: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::get_Current()
IL_01c0: stloc.s V_11
IL_01c2: nop
IL_01c3: ldloc.s V_11
IL_01c5: isinst TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger
IL_01ca: stloc.s V_12
IL_01cc: ldloc.s V_12
IL_01ce: brfalse.s IL_01e3
IL_01d0: ldloc.s V_12
IL_01d2: ldfld System.String TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger::triggerPluginDbName
IL_01d7: ldstr "notebook_unlocked"
IL_01dc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01e1: br.s IL_01e4
IL_01e3: ldc.i4.0
IL_01e4: stloc.s V_13
IL_01e6: ldloc.s V_13
IL_01e8: brfalse.s IL_024c
IL_01ea: ldloc.0
IL_01eb: ldc.i4.6
IL_01ec: newarr System.String
IL_01f1: dup
IL_01f2: ldc.i4.0
IL_01f3: ldstr "buckyNotebookTrigger | conversation="
IL_01f8: stelem.ref
IL_01f9: dup
IL_01fa: ldc.i4.1
IL_01fb: ldloc.s V_12
IL_01fd: callvirt System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::GetConversationId()
IL_0202: stloc.s V_8
IL_0204: ldloca.s V_8
IL_0206: call System.String System.Int32::ToString()
IL_020b: stelem.ref
IL_020c: dup
IL_020d: ldc.i4.2
IL_020e: ldstr " | entry="
IL_0213: stelem.ref
IL_0214: dup
IL_0215: ldc.i4.3
IL_0216: ldloc.s V_12
IL_0218: callvirt System.Int32 TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::GetDialogueEntryId()
IL_021d: stloc.s V_8
IL_021f: ldloca.s V_8
IL_0221: call System.String System.Int32::ToString()
IL_0226: stelem.ref
IL_0227: dup
IL_0228: ldc.i4.4
IL_0229: ldstr " | executed="
IL_022e: stelem.ref
IL_022f: dup
IL_0230: ldc.i4.5
IL_0231: ldloc.s V_12
IL_0233: callvirt System.Boolean TheForestOfLove.Narrative.ArcTriggers.ArcTrigger::get_isExecuted()
IL_0238: stloc.3
IL_0239: ldloca.s V_3
IL_023b: call System.String System.Boolean::ToString()
IL_0240: stelem.ref
IL_0241: call System.String System.String::Concat(System.String[])
IL_0246: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_024b: nop
IL_024c: nop
IL_024d: ldloca.s V_10
IL_024f: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>::MoveNext()
IL_0254: brtrue IL_01b9
IL_0259: leave.s IL_026a
IL_025b: ldloca.s V_10
IL_025d: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.ArcTriggers.ArcTrigger>
IL_0263: callvirt System.Void System.IDisposable::Dispose()
IL_0268: nop
IL_0269: endfinally
IL_026a: ldloc.0
IL_026b: callvirt !0[] System.Collections.Generic.List`1<System.String>::ToArray()
IL_0270: stloc.s V_14
IL_0272: br.s IL_0274
IL_0274: ldloc.s V_14
IL_0276: ret
