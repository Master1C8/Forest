TYPE TheForestOfLove.QuestLog
METHOD System.Void TheForestOfLove.QuestLog::RefreshQuestLabels() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::activeQuests
IL_0006: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Clear()
IL_000b: ldarg.0
IL_000c: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::completedQuests
IL_0011: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Clear()
IL_0016: ldarg.0
IL_0017: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::hiddenQuests
IL_001c: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Clear()
IL_0021: ldc.i4.m1
IL_0022: stloc.0
IL_0023: ldnull
IL_0024: stloc.1
IL_0025: ldc.i4.0
IL_0026: stloc.2
IL_0027: br IL_01b2
IL_002c: ldarg.0
IL_002d: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::questLabels
IL_0032: ldloc.2
IL_0033: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::get_Item(System.Int32)
IL_0038: stloc.3
IL_0039: ldarg.0
IL_003a: ldloc.3
IL_003b: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_0040: call System.Boolean TheForestOfLove.QuestLog::IsAvailableInQuestLog(TheForestOfLove.Narrative.Quest)
IL_0045: brtrue.s IL_005f
IL_0047: ldloc.3
IL_0048: ldc.i4.0
IL_0049: callvirt System.Void TheForestOfLove.QuestLog/QuestLabel::SetReferenceStatus(TheForestOfLove.QuestLog/QuestLabelStatus)
IL_004e: ldarg.0
IL_004f: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::hiddenQuests
IL_0054: ldloc.3
IL_0055: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Add(!0)
IL_005a: br IL_01ae
IL_005f: ldloc.3
IL_0060: callvirt TheForestOfLove.QuestLog/QuestLabelStatus TheForestOfLove.QuestLog/QuestLabel::get_status()
IL_0065: ldc.i4.1
IL_0066: bne.un.s IL_006a
IL_0068: ldloc.2
IL_0069: stloc.0
IL_006a: ldloc.3
IL_006b: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_0070: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0075: ldstr "AdventureModePlaceholder"
IL_007a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_007f: brfalse IL_0117
IL_0084: ldsfld System.Boolean Globals::isCheatCode
IL_0089: brtrue.s IL_00e0
IL_008b: ldloc.3
IL_008c: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_0091: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_0096: ldc.i4.s 100
IL_0098: bne.un.s IL_00b2
IL_009a: ldloc.3
IL_009b: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_00a0: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.Quest::progressLogEntries
IL_00a5: ldc.i4.0
IL_00a6: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Item(System.Int32)
IL_00ab: callvirt System.Boolean TheForestOfLove.Narrative.QuestProgressLogEntry::get_IsUnlocked()
IL_00b0: brtrue.s IL_00e0
IL_00b2: ldc.i4.1
IL_00b3: stsfld System.Boolean Globals::isCheatCode
IL_00b8: ldloc.3
IL_00b9: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_00be: callvirt System.Void TheForestOfLove.Narrative.Quest::SetStatusStarted()
IL_00c3: ldloc.3
IL_00c4: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_00c9: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.Quest::progressLogEntries
IL_00ce: ldc.i4.0
IL_00cf: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::get_Item(System.Int32)
IL_00d4: ldc.i4.0
IL_00d5: callvirt System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::Unlock(System.Boolean)
IL_00da: ldc.i4.0
IL_00db: stsfld System.Boolean Globals::isCheatCode
IL_00e0: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00e5: brtrue.s IL_00ff
IL_00e7: ldloc.3
IL_00e8: ldc.i4.0
IL_00e9: callvirt System.Void TheForestOfLove.QuestLog/QuestLabel::SetReferenceStatus(TheForestOfLove.QuestLog/QuestLabelStatus)
IL_00ee: ldarg.0
IL_00ef: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::hiddenQuests
IL_00f4: ldloc.3
IL_00f5: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Add(!0)
IL_00fa: br IL_01ae
IL_00ff: ldloc.3
IL_0100: ldc.i4.3
IL_0101: callvirt System.Void TheForestOfLove.QuestLog/QuestLabel::SetReferenceStatus(TheForestOfLove.QuestLog/QuestLabelStatus)
IL_0106: ldarg.0
IL_0107: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::activeQuests
IL_010c: ldloc.3
IL_010d: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Add(!0)
IL_0112: br IL_01ae
IL_0117: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_011c: brfalse.s IL_014f
IL_011e: ldloc.1
IL_011f: brtrue.s IL_0127
IL_0121: call System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.InstancedStoryController::GetAllowedQuestDbNames()
IL_0126: stloc.1
IL_0127: ldloc.1
IL_0128: ldloc.3
IL_0129: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_012e: ldfld System.String TheForestOfLove.Narrative.Quest::dbName
IL_0133: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Contains(!0)
IL_0138: brtrue.s IL_014f
IL_013a: ldloc.3
IL_013b: ldc.i4.0
IL_013c: callvirt System.Void TheForestOfLove.QuestLog/QuestLabel::SetReferenceStatus(TheForestOfLove.QuestLog/QuestLabelStatus)
IL_0141: ldarg.0
IL_0142: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::hiddenQuests
IL_0147: ldloc.3
IL_0148: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Add(!0)
IL_014d: br.s IL_01ae
IL_014f: ldloc.3
IL_0150: callvirt TheForestOfLove.Narrative.Quest TheForestOfLove.QuestLog/QuestLabel::get_quest()
IL_0155: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_015a: stloc.s V_4
IL_015c: ldloc.s V_4
IL_015e: brfalse.s IL_019b
IL_0160: ldloc.s V_4
IL_0162: ldc.i4.s 100
IL_0164: beq.s IL_0171
IL_0166: ldloc.s V_4
IL_0168: ldc.i4 200
IL_016d: beq.s IL_0186
IL_016f: br.s IL_019b
IL_0171: ldloc.3
IL_0172: ldc.i4.2
IL_0173: callvirt System.Void TheForestOfLove.QuestLog/QuestLabel::SetReferenceStatus(TheForestOfLove.QuestLog/QuestLabelStatus)
IL_0178: ldarg.0
IL_0179: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::activeQuests
IL_017e: ldloc.3
IL_017f: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Add(!0)
IL_0184: br.s IL_01ae
IL_0186: ldloc.3
IL_0187: ldc.i4.3
IL_0188: callvirt System.Void TheForestOfLove.QuestLog/QuestLabel::SetReferenceStatus(TheForestOfLove.QuestLog/QuestLabelStatus)
IL_018d: ldarg.0
IL_018e: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::completedQuests
IL_0193: ldloc.3
IL_0194: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Add(!0)
IL_0199: br.s IL_01ae
IL_019b: ldloc.3
IL_019c: ldc.i4.0
IL_019d: callvirt System.Void TheForestOfLove.QuestLog/QuestLabel::SetReferenceStatus(TheForestOfLove.QuestLog/QuestLabelStatus)
IL_01a2: ldarg.0
IL_01a3: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::hiddenQuests
IL_01a8: ldloc.3
IL_01a9: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Add(!0)
IL_01ae: ldloc.2
IL_01af: ldc.i4.1
IL_01b0: add
IL_01b1: stloc.2
IL_01b2: ldloc.2
IL_01b3: ldarg.0
IL_01b4: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::questLabels
IL_01b9: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::get_Count()
IL_01be: blt IL_002c
IL_01c3: ldarg.0
IL_01c4: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::activeQuests
IL_01c9: ldsfld System.Comparison`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog/<>c::<>9__40_0
IL_01ce: dup
IL_01cf: brtrue.s IL_01e8
IL_01d1: pop
IL_01d2: ldsfld TheForestOfLove.QuestLog/<>c TheForestOfLove.QuestLog/<>c::<>9
IL_01d7: ldftn System.Int32 TheForestOfLove.QuestLog/<>c::<RefreshQuestLabels>b__40_0(TheForestOfLove.QuestLog/QuestLabel,TheForestOfLove.QuestLog/QuestLabel)
IL_01dd: newobj System.Void System.Comparison`1<TheForestOfLove.QuestLog/QuestLabel>::.ctor(System.Object,System.IntPtr)
IL_01e2: dup
IL_01e3: stsfld System.Comparison`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog/<>c::<>9__40_0
IL_01e8: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Sort(System.Comparison`1<!0>)
IL_01ed: ldarg.0
IL_01ee: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::completedQuests
IL_01f3: ldsfld System.Comparison`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog/<>c::<>9__40_1
IL_01f8: dup
IL_01f9: brtrue.s IL_0212
IL_01fb: pop
IL_01fc: ldsfld TheForestOfLove.QuestLog/<>c TheForestOfLove.QuestLog/<>c::<>9
IL_0201: ldftn System.Int32 TheForestOfLove.QuestLog/<>c::<RefreshQuestLabels>b__40_1(TheForestOfLove.QuestLog/QuestLabel,TheForestOfLove.QuestLog/QuestLabel)
IL_0207: newobj System.Void System.Comparison`1<TheForestOfLove.QuestLog/QuestLabel>::.ctor(System.Object,System.IntPtr)
IL_020c: dup
IL_020d: stsfld System.Comparison`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog/<>c::<>9__40_1
IL_0212: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Sort(System.Comparison`1<!0>)
IL_0217: ldarg.0
IL_0218: ldarg.0
IL_0219: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog::questListHeaderActive
IL_021e: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_0223: ldarg.0
IL_0224: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::activeQuests
IL_0229: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::GetEnumerator()
IL_022e: stloc.s V_5
IL_0230: br.s IL_0271
IL_0232: ldloca.s V_5
IL_0234: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.QuestLog/QuestLabel>::get_Current()
IL_0239: stloc.s V_6
IL_023b: ldarg.0
IL_023c: ldloc.s V_6
IL_023e: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog/QuestLabel::uiActive
IL_0243: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_0248: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_024d: ldarg.0
IL_024e: ldloc.s V_6
IL_0250: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog/QuestLabel::uiCompleted
IL_0255: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_025a: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_025f: ldarg.0
IL_0260: ldloc.s V_6
IL_0262: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog/QuestLabel::uiSelected
IL_0267: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_026c: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_0271: ldloca.s V_5
IL_0273: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.QuestLog/QuestLabel>::MoveNext()
IL_0278: brtrue.s IL_0232
IL_027a: leave.s IL_028a
IL_027c: ldloca.s V_5
IL_027e: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.QuestLog/QuestLabel>
IL_0284: callvirt System.Void System.IDisposable::Dispose()
IL_0289: endfinally
IL_028a: ldarg.0
IL_028b: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog::questListHeaderActiveSpacer
IL_0290: ldc.i4.1
IL_0291: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0296: ldarg.0
IL_0297: ldarg.0
IL_0298: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog::questListHeaderActiveSpacer
IL_029d: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_02a2: ldarg.0
IL_02a3: ldarg.0
IL_02a4: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog::questListHeaderCompleted
IL_02a9: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_02ae: ldarg.0
IL_02af: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::completedQuests
IL_02b4: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::GetEnumerator()
IL_02b9: stloc.s V_5
IL_02bb: br.s IL_02fc
IL_02bd: ldloca.s V_5
IL_02bf: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.QuestLog/QuestLabel>::get_Current()
IL_02c4: stloc.s V_7
IL_02c6: ldarg.0
IL_02c7: ldloc.s V_7
IL_02c9: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog/QuestLabel::uiActive
IL_02ce: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_02d3: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_02d8: ldarg.0
IL_02d9: ldloc.s V_7
IL_02db: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog/QuestLabel::uiCompleted
IL_02e0: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_02e5: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_02ea: ldarg.0
IL_02eb: ldloc.s V_7
IL_02ed: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog/QuestLabel::uiSelected
IL_02f2: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_02f7: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_02fc: ldloca.s V_5
IL_02fe: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.QuestLog/QuestLabel>::MoveNext()
IL_0303: brtrue.s IL_02bd
IL_0305: leave.s IL_0315
IL_0307: ldloca.s V_5
IL_0309: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.QuestLog/QuestLabel>
IL_030f: callvirt System.Void System.IDisposable::Dispose()
IL_0314: endfinally
IL_0315: ldarg.0
IL_0316: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::hiddenQuests
IL_031b: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::GetEnumerator()
IL_0320: stloc.s V_5
IL_0322: br.s IL_0363
IL_0324: ldloca.s V_5
IL_0326: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.QuestLog/QuestLabel>::get_Current()
IL_032b: stloc.s V_8
IL_032d: ldarg.0
IL_032e: ldloc.s V_8
IL_0330: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog/QuestLabel::uiActive
IL_0335: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_033a: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_033f: ldarg.0
IL_0340: ldloc.s V_8
IL_0342: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog/QuestLabel::uiCompleted
IL_0347: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_034c: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_0351: ldarg.0
IL_0352: ldloc.s V_8
IL_0354: ldfld UnityEngine.GameObject TheForestOfLove.QuestLog/QuestLabel::uiSelected
IL_0359: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_035e: call System.Void TheForestOfLove.QuestLog::ReparentQuestNamesContainerObject(UnityEngine.GameObject)
IL_0363: ldloca.s V_5
IL_0365: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.QuestLog/QuestLabel>::MoveNext()
IL_036a: brtrue.s IL_0324
IL_036c: leave.s IL_037c
IL_036e: ldloca.s V_5
IL_0370: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.QuestLog/QuestLabel>
IL_0376: callvirt System.Void System.IDisposable::Dispose()
IL_037b: endfinally
IL_037c: ldarg.0
IL_037d: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::questLabels
IL_0382: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::Clear()
IL_0387: ldarg.0
IL_0388: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::questLabels
IL_038d: ldarg.0
IL_038e: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::activeQuests
IL_0393: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_0398: ldarg.0
IL_0399: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::questLabels
IL_039e: ldarg.0
IL_039f: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::completedQuests
IL_03a4: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_03a9: ldarg.0
IL_03aa: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::questLabels
IL_03af: ldarg.0
IL_03b0: ldfld System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel> TheForestOfLove.QuestLog::hiddenQuests
IL_03b5: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.QuestLog/QuestLabel>::AddRange(System.Collections.Generic.IEnumerable`1<!0>)
IL_03ba: ldloc.0
IL_03bb: ldc.i4.m1
IL_03bc: beq.s IL_03c5
IL_03be: ldarg.0
IL_03bf: ldloc.0
IL_03c0: call System.Void TheForestOfLove.QuestLog::SelectQuestLabel(System.Int32)
IL_03c5: ret
