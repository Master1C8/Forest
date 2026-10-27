TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateDialogues(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.2
IL_0008: stfld PixelCrushers.DialogueSystem.DialogueDatabase TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::database
IL_000d: ldloc.0
IL_000e: ldarg.1
IL_000f: stfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0014: ldloc.0
IL_0015: ldarg.0
IL_0016: stfld TheForestOfLove.Narrative.DialogueSystemLoader TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::<>4__this
IL_001b: ldloc.0
IL_001c: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::<GenerateDialogues>b__0(TheForestOfLove.DB.Dialogue)
IL_0022: newobj System.Void System.Action`1<TheForestOfLove.DB.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0027: ldnull
IL_0028: ldnull
IL_0029: call System.Void TheForestOfLove.DB.Dialogue::ForEachEntity(System.Action`1<TheForestOfLove.DB.Dialogue>,System.Predicate`1<TheForestOfLove.DB.Dialogue>,System.Comparison`1<TheForestOfLove.DB.Dialogue>)
IL_002e: ldloc.0
IL_002f: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0034: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialogues
IL_0039: ldsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_1
IL_003e: dup
IL_003f: brtrue.s IL_0058
IL_0041: pop
IL_0042: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_0047: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateDialogues>b__24_1(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Dialogue)
IL_004d: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0052: dup
IL_0053: stsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_1
IL_0058: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Sort(System.Comparison`1<!0>)
IL_005d: ldloc.0
IL_005e: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0063: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesByActorDbName
IL_0068: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Values()
IL_006d: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::GetEnumerator()
IL_0072: stloc.1
IL_0073: br.s IL_00a0
IL_0075: ldloca.s V_1
IL_0077: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Current()
IL_007c: ldsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_2
IL_0081: dup
IL_0082: brtrue.s IL_009b
IL_0084: pop
IL_0085: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_008a: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateDialogues>b__24_2(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Dialogue)
IL_0090: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0095: dup
IL_0096: stsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_2
IL_009b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Sort(System.Comparison`1<!0>)
IL_00a0: ldloca.s V_1
IL_00a2: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::MoveNext()
IL_00a7: brtrue.s IL_0075
IL_00a9: leave.s IL_00b9
IL_00ab: ldloca.s V_1
IL_00ad: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>
IL_00b3: callvirt System.Void System.IDisposable::Dispose()
IL_00b8: endfinally
IL_00b9: ldloc.0
IL_00ba: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_00bf: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeDateByActorDbName
IL_00c4: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Values()
IL_00c9: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::GetEnumerator()
IL_00ce: stloc.1
IL_00cf: br.s IL_00fc
IL_00d1: ldloca.s V_1
IL_00d3: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Current()
IL_00d8: ldsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_3
IL_00dd: dup
IL_00de: brtrue.s IL_00f7
IL_00e0: pop
IL_00e1: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_00e6: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateDialogues>b__24_3(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Dialogue)
IL_00ec: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_00f1: dup
IL_00f2: stsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_3
IL_00f7: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Sort(System.Comparison`1<!0>)
IL_00fc: ldloca.s V_1
IL_00fe: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::MoveNext()
IL_0103: brtrue.s IL_00d1
IL_0105: leave.s IL_0115
IL_0107: ldloca.s V_1
IL_0109: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>
IL_010f: callvirt System.Void System.IDisposable::Dispose()
IL_0114: endfinally
IL_0115: ldloc.0
IL_0116: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_011b: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeFinalIdleByActorDbName
IL_0120: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Values()
IL_0125: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::GetEnumerator()
IL_012a: stloc.1
IL_012b: br.s IL_0158
IL_012d: ldloca.s V_1
IL_012f: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Current()
IL_0134: ldsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_4
IL_0139: dup
IL_013a: brtrue.s IL_0153
IL_013c: pop
IL_013d: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_0142: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateDialogues>b__24_4(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Dialogue)
IL_0148: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_014d: dup
IL_014e: stsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_4
IL_0153: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Sort(System.Comparison`1<!0>)
IL_0158: ldloca.s V_1
IL_015a: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::MoveNext()
IL_015f: brtrue.s IL_012d
IL_0161: leave.s IL_0171
IL_0163: ldloca.s V_1
IL_0165: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>
IL_016b: callvirt System.Void System.IDisposable::Dispose()
IL_0170: endfinally
IL_0171: ldloc.0
IL_0172: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0177: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGiftByActorDbName
IL_017c: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Values()
IL_0181: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::GetEnumerator()
IL_0186: stloc.1
IL_0187: br.s IL_01b4
IL_0189: ldloca.s V_1
IL_018b: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Current()
IL_0190: ldsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_5
IL_0195: dup
IL_0196: brtrue.s IL_01af
IL_0198: pop
IL_0199: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_019e: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateDialogues>b__24_5(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Dialogue)
IL_01a4: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_01a9: dup
IL_01aa: stsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_5
IL_01af: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Sort(System.Comparison`1<!0>)
IL_01b4: ldloca.s V_1
IL_01b6: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::MoveNext()
IL_01bb: brtrue.s IL_0189
IL_01bd: leave.s IL_01cd
IL_01bf: ldloca.s V_1
IL_01c1: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>
IL_01c7: callvirt System.Void System.IDisposable::Dispose()
IL_01cc: endfinally
IL_01cd: ldloc.0
IL_01ce: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_01d3: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGossipByActorDbName
IL_01d8: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Values()
IL_01dd: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::GetEnumerator()
IL_01e2: stloc.1
IL_01e3: br.s IL_0210
IL_01e5: ldloca.s V_1
IL_01e7: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Current()
IL_01ec: ldsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_6
IL_01f1: dup
IL_01f2: brtrue.s IL_020b
IL_01f4: pop
IL_01f5: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_01fa: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateDialogues>b__24_6(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Dialogue)
IL_0200: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0205: dup
IL_0206: stsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_6
IL_020b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Sort(System.Comparison`1<!0>)
IL_0210: ldloca.s V_1
IL_0212: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::MoveNext()
IL_0217: brtrue.s IL_01e5
IL_0219: leave.s IL_0229
IL_021b: ldloca.s V_1
IL_021d: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>
IL_0223: callvirt System.Void System.IDisposable::Dispose()
IL_0228: endfinally
IL_0229: ldloc.0
IL_022a: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_022f: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestByActorDbName
IL_0234: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Values()
IL_0239: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::GetEnumerator()
IL_023e: stloc.1
IL_023f: br.s IL_026c
IL_0241: ldloca.s V_1
IL_0243: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Current()
IL_0248: ldsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_7
IL_024d: dup
IL_024e: brtrue.s IL_0267
IL_0250: pop
IL_0251: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_0256: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateDialogues>b__24_7(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Dialogue)
IL_025c: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_0261: dup
IL_0262: stsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_7
IL_0267: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Sort(System.Comparison`1<!0>)
IL_026c: ldloca.s V_1
IL_026e: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::MoveNext()
IL_0273: brtrue.s IL_0241
IL_0275: leave.s IL_0285
IL_0277: ldloca.s V_1
IL_0279: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>
IL_027f: callvirt System.Void System.IDisposable::Dispose()
IL_0284: endfinally
IL_0285: ldloc.0
IL_0286: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_028b: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestionIdleByActorDbName
IL_0290: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Values()
IL_0295: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::GetEnumerator()
IL_029a: stloc.1
IL_029b: br.s IL_02c8
IL_029d: ldloca.s V_1
IL_029f: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Current()
IL_02a4: ldsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_8
IL_02a9: dup
IL_02aa: brtrue.s IL_02c3
IL_02ac: pop
IL_02ad: ldsfld TheForestOfLove.Narrative.DialogueSystemLoader/<>c TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9
IL_02b2: ldftn System.Int32 TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<GenerateDialogues>b__24_8(TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Dialogue)
IL_02b8: newobj System.Void System.Comparison`1<TheForestOfLove.Narrative.Dialogue>::.ctor(System.Object,System.IntPtr)
IL_02bd: dup
IL_02be: stsfld System.Comparison`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueSystemLoader/<>c::<>9__24_8
IL_02c3: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Sort(System.Comparison`1<!0>)
IL_02c8: ldloca.s V_1
IL_02ca: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::MoveNext()
IL_02cf: brtrue.s IL_029d
IL_02d1: leave.s IL_02e1
IL_02d3: ldloca.s V_1
IL_02d5: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>
IL_02db: callvirt System.Void System.IDisposable::Dispose()
IL_02e0: endfinally
IL_02e1: ret
