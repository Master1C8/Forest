TYPE ForestProbe
METHOD System.String ForestProbe::TutorialChoiceText(System.Int32) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldc.i4 159
IL_0007: beq.s IL_0016
IL_0009: ldarg.0
IL_000a: ldc.i4 181
IL_000f: ceq
IL_0011: ldc.i4.0
IL_0012: ceq
IL_0014: br.s IL_0017
IL_0016: ldc.i4.0
IL_0017: stloc.0
IL_0018: ldloc.0
IL_0019: brfalse.s IL_0026
IL_001b: ldstr "Unapproved Tutorial choice ID"
IL_0020: newobj System.Void System.Exception::.ctor(System.String)
IL_0025: throw
IL_0026: ldarg.0
IL_0027: ldc.i4 159
IL_002c: beq.s IL_0035
IL_002e: ldstr "The love. Definitely the love."
IL_0033: br.s IL_003a
IL_0035: ldstr "Well… uhh… You see…"
IL_003a: stloc.1
IL_003b: br.s IL_003d
IL_003d: ldloc.1
IL_003e: ret
METHOD ForestProbe/TutorialCompletion ForestProbe::ReadTutorialCompletion(UnityEngine.UI.Button&) | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0012
IL_000a: ldloc.0
IL_000b: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0010: br.s IL_0013
IL_0012: ldnull
IL_0013: stloc.1
IL_0014: ldloc.1
IL_0015: brfalse.s IL_001f
IL_0017: ldloc.1
IL_0018: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_001d: br.s IL_0020
IL_001f: ldnull
IL_0020: stloc.2
IL_0021: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0026: brfalse IL_0116
IL_002b: ldloc.2
IL_002c: brfalse IL_0116
IL_0031: ldloc.2
IL_0032: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0037: ldc.i4.s 120
IL_0039: bne.un IL_0116
IL_003e: ldloc.2
IL_003f: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0044: ldc.i4 158
IL_0049: bne.un IL_0116
IL_004e: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0053: ldstr "TutorialQuest_IntroFromBunny"
IL_0058: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_005d: brtrue IL_0116
IL_0062: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_0067: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_006c: brfalse IL_0116
IL_0071: ldloc.1
IL_0072: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0077: brfalse IL_0116
IL_007c: ldloc.1
IL_007d: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0082: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0087: ldstr "So tell me. What is it you’re here for?"
IL_008c: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0091: brtrue IL_0116
IL_0096: ldloc.2
IL_0097: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_009c: ldstr "[pic=3]So tell me. What is it you’re here for?"
IL_00a1: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_00a6: brtrue.s IL_0116
IL_00a8: ldloc.2
IL_00a9: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_00ae: ldc.i4.2
IL_00af: bne.un.s IL_0116
IL_00b1: ldloc.2
IL_00b2: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ConversantID()
IL_00b7: ldc.i4.1
IL_00b8: bne.un.s IL_0116
IL_00ba: ldloc.2
IL_00bb: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::conditionsString
IL_00c0: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00c5: brfalse.s IL_0116
IL_00c7: ldloc.2
IL_00c8: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::userScript
IL_00cd: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00d2: brfalse.s IL_0116
IL_00d4: ldloc.2
IL_00d5: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_MenuText()
IL_00da: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00df: brfalse.s IL_0116
IL_00e1: ldloc.2
IL_00e2: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Sequence()
IL_00e7: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00ec: brfalse.s IL_0116
IL_00ee: ldloc.2
IL_00ef: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_ResponseMenuSequence()
IL_00f4: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00f9: brfalse.s IL_0116
IL_00fb: ldloc.2
IL_00fc: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0101: brfalse.s IL_0113
IL_0103: ldloc.2
IL_0104: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0109: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_010e: ldc.i4.0
IL_010f: cgt.un
IL_0111: br.s IL_0114
IL_0113: ldc.i4.0
IL_0114: br.s IL_0117
IL_0116: ldc.i4.1
IL_0117: stloc.s V_9
IL_0119: ldloc.s V_9
IL_011b: brfalse.s IL_0128
IL_011d: ldstr "Tutorial158 exact source/binding differs"
IL_0122: newobj System.Void System.Exception::.ctor(System.String)
IL_0127: throw
IL_0128: ldloc.2
IL_0129: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_012e: brfalse.s IL_015e
IL_0130: ldloc.2
IL_0131: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0136: callvirt System.Int32 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Count()
IL_013b: ldc.i4.2
IL_013c: bne.un.s IL_015e
IL_013e: ldloc.0
IL_013f: callvirt System.Boolean PixelCrushers.DialogueSystem.ConversationState::get_hasNPCResponse()
IL_0144: brtrue.s IL_015e
IL_0146: ldloc.0
IL_0147: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_014c: brfalse.s IL_015e
IL_014e: ldloc.0
IL_014f: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_0154: ldlen
IL_0155: conv.i4
IL_0156: ldc.i4.2
IL_0157: ceq
IL_0159: ldc.i4.0
IL_015a: ceq
IL_015c: br.s IL_015f
IL_015e: ldc.i4.1
IL_015f: stloc.s V_10
IL_0161: ldloc.s V_10
IL_0163: brfalse.s IL_0170
IL_0165: ldstr "Tutorial158 source/available destinations differ"
IL_016a: newobj System.Void System.Exception::.ctor(System.String)
IL_016f: throw
IL_0170: newobj System.Void System.Collections.Generic.HashSet`1<System.Int32>::.ctor()
IL_0175: stloc.3
IL_0176: nop
IL_0177: ldloc.2
IL_0178: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_017d: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::GetEnumerator()
IL_0182: stloc.s V_11
IL_0184: br IL_020b
IL_0189: ldloca.s V_11
IL_018b: call !0 System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::get_Current()
IL_0190: stloc.s V_12
IL_0192: nop
IL_0193: ldloc.s V_12
IL_0195: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::originConversationID
IL_019a: ldc.i4.s 120
IL_019c: bne.un.s IL_01f8
IL_019e: ldloc.s V_12
IL_01a0: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::originDialogueID
IL_01a5: ldc.i4 158
IL_01aa: bne.un.s IL_01f8
IL_01ac: ldloc.s V_12
IL_01ae: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationConversationID
IL_01b3: ldc.i4.s 120
IL_01b5: bne.un.s IL_01f8
IL_01b7: ldloc.s V_12
IL_01b9: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_01be: ldc.i4 159
IL_01c3: beq.s IL_01d3
IL_01c5: ldloc.s V_12
IL_01c7: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_01cc: ldc.i4 181
IL_01d1: bne.un.s IL_01f8
IL_01d3: ldloc.s V_12
IL_01d5: ldfld System.Boolean PixelCrushers.DialogueSystem.Link::isConnector
IL_01da: brtrue.s IL_01f8
IL_01dc: ldloc.s V_12
IL_01de: ldfld PixelCrushers.DialogueSystem.ConditionPriority PixelCrushers.DialogueSystem.Link::priority
IL_01e3: ldc.i4.2
IL_01e4: bne.un.s IL_01f8
IL_01e6: ldloc.3
IL_01e7: ldloc.s V_12
IL_01e9: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_01ee: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_01f3: ldc.i4.0
IL_01f4: ceq
IL_01f6: br.s IL_01f9
IL_01f8: ldc.i4.1
IL_01f9: stloc.s V_13
IL_01fb: ldloc.s V_13
IL_01fd: brfalse.s IL_020a
IL_01ff: ldstr "Tutorial158 source links differ"
IL_0204: newobj System.Void System.Exception::.ctor(System.String)
IL_0209: throw
IL_020a: nop
IL_020b: ldloca.s V_11
IL_020d: call System.Boolean System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>::MoveNext()
IL_0212: brtrue IL_0189
IL_0217: leave.s IL_0228
IL_0219: ldloca.s V_11
IL_021b: constrained. System.Collections.Generic.List`1/Enumerator<PixelCrushers.DialogueSystem.Link>
IL_0221: callvirt System.Void System.IDisposable::Dispose()
IL_0226: nop
IL_0227: endfinally
IL_0228: ldloc.3
IL_0229: callvirt System.Void System.Collections.Generic.HashSet`1<System.Int32>::Clear()
IL_022e: nop
IL_022f: nop
IL_0230: ldloc.0
IL_0231: ldfld PixelCrushers.DialogueSystem.Response[] PixelCrushers.DialogueSystem.ConversationState::pcResponses
IL_0236: stloc.s V_14
IL_0238: ldc.i4.0
IL_0239: stloc.s V_15
IL_023b: br IL_038e
IL_0240: ldloc.s V_14
IL_0242: ldloc.s V_15
IL_0244: ldelem.ref
IL_0245: stloc.s V_16
IL_0247: nop
IL_0248: ldloc.s V_16
IL_024a: brfalse.s IL_0255
IL_024c: ldloc.s V_16
IL_024e: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Response::destinationEntry
IL_0253: br.s IL_0256
IL_0255: ldnull
IL_0256: stloc.s V_17
IL_0258: ldloc.s V_17
IL_025a: brfalse.s IL_026a
IL_025c: ldloc.s V_17
IL_025e: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0263: call System.String ForestProbe::TutorialChoiceText(System.Int32)
IL_0268: br.s IL_026b
IL_026a: ldnull
IL_026b: stloc.s V_18
IL_026d: ldloc.s V_17
IL_026f: brfalse IL_0375
IL_0274: ldloc.s V_17
IL_0276: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_027b: ldc.i4.s 120
IL_027d: bne.un IL_0375
IL_0282: ldloc.s V_17
IL_0284: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0289: ldc.i4 159
IL_028e: beq.s IL_02a1
IL_0290: ldloc.s V_17
IL_0292: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0297: ldc.i4 181
IL_029c: bne.un IL_0375
IL_02a1: ldloc.3
IL_02a2: ldloc.s V_17
IL_02a4: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_02a9: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_02ae: brfalse IL_0375
IL_02b3: ldloc.s V_17
IL_02b5: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_02ba: ldc.i4.1
IL_02bb: bne.un IL_0375
IL_02c0: ldloc.s V_17
IL_02c2: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ConversantID()
IL_02c7: ldc.i4.2
IL_02c8: bne.un IL_0375
IL_02cd: ldloc.s V_17
IL_02cf: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueEntry::isGroup
IL_02d4: brtrue IL_0375
IL_02d9: ldloc.s V_17
IL_02db: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_02e0: ldloc.s V_18
IL_02e2: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_02e7: brtrue IL_0375
IL_02ec: ldloc.s V_17
IL_02ee: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_MenuText()
IL_02f3: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_02f8: brfalse.s IL_0375
IL_02fa: ldloc.s V_17
IL_02fc: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::conditionsString
IL_0301: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0306: brfalse.s IL_0375
IL_0308: ldloc.s V_17
IL_030a: ldfld System.String PixelCrushers.DialogueSystem.DialogueEntry::userScript
IL_030f: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0314: brfalse.s IL_0375
IL_0316: ldloc.s V_17
IL_0318: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Sequence()
IL_031d: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0322: brfalse.s IL_0375
IL_0324: ldloc.s V_17
IL_0326: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_ResponseMenuSequence()
IL_032b: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0330: brfalse.s IL_0375
IL_0332: ldloc.s V_17
IL_0334: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0339: brfalse.s IL_0349
IL_033b: ldloc.s V_17
IL_033d: ldfld UnityEngine.Events.UnityEvent PixelCrushers.DialogueSystem.DialogueEntry::onExecute
IL_0342: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_0347: brtrue.s IL_0375
IL_0349: ldloc.s V_16
IL_034b: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_0350: brfalse.s IL_0375
IL_0352: ldloc.s V_16
IL_0354: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_0359: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_035e: ldloc.s V_18
IL_0360: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0365: brtrue.s IL_0375
IL_0367: ldloc.s V_16
IL_0369: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Response::formattedText
IL_036e: callvirt System.Boolean PixelCrushers.DialogueSystem.FormattedText::get_forceAuto()
IL_0373: br.s IL_0376
IL_0375: ldc.i4.1
IL_0376: stloc.s V_19
IL_0378: ldloc.s V_19
IL_037a: brfalse.s IL_0387
IL_037c: ldstr "Tutorial158 PC destination/text/conditions differ"
IL_0381: newobj System.Void System.Exception::.ctor(System.String)
IL_0386: throw
IL_0387: nop
IL_0388: ldloc.s V_15
IL_038a: ldc.i4.1
IL_038b: add
IL_038c: stloc.s V_15
IL_038e: ldloc.s V_15
IL_0390: ldloc.s V_14
IL_0392: ldlen
IL_0393: conv.i4
IL_0394: blt IL_0240
IL_0399: ldarg.0
IL_039a: call System.Collections.Generic.List`1<ForestProbe/ResponseRow> ForestProbe::ReadResponses()
IL_039f: stloc.s V_4
IL_03a1: ldloc.s V_4
IL_03a3: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_03a8: ldc.i4.0
IL_03a9: cgt.un
IL_03ab: stloc.s V_5
IL_03ad: ldloc.s V_5
IL_03af: stloc.s V_20
IL_03b1: ldloc.s V_20
IL_03b3: brfalse IL_04aa
IL_03b8: nop
IL_03b9: ldloc.3
IL_03ba: callvirt System.Void System.Collections.Generic.HashSet`1<System.Int32>::Clear()
IL_03bf: nop
IL_03c0: nop
IL_03c1: ldloc.s V_4
IL_03c3: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<ForestProbe/ResponseRow>::GetEnumerator()
IL_03c8: stloc.s V_21
IL_03ca: br IL_048c
IL_03cf: ldloca.s V_21
IL_03d1: call !0 System.Collections.Generic.List`1/Enumerator<ForestProbe/ResponseRow>::get_Current()
IL_03d6: stloc.s V_22
IL_03d8: nop
IL_03d9: ldloc.s V_22
IL_03db: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_03e0: call System.String ForestProbe::TutorialChoiceText(System.Int32)
IL_03e5: stloc.s V_23
IL_03e7: ldloc.s V_4
IL_03e9: callvirt System.Int32 System.Collections.Generic.List`1<ForestProbe/ResponseRow>::get_Count()
IL_03ee: ldc.i4.2
IL_03ef: bne.un IL_0479
IL_03f4: ldloc.s V_22
IL_03f6: ldfld System.Boolean ForestProbe/ResponseRow::visible
IL_03fb: brfalse.s IL_0479
IL_03fd: ldloc.s V_22
IL_03ff: ldfld System.Boolean ForestProbe/ResponseRow::clickable
IL_0404: brfalse.s IL_0479
IL_0406: ldloc.s V_22
IL_0408: ldfld System.Int32 ForestProbe/ResponseRow::conversationId
IL_040d: ldc.i4.s 120
IL_040f: bne.un.s IL_0479
IL_0411: ldloc.s V_22
IL_0413: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_0418: ldc.i4 159
IL_041d: beq.s IL_042d
IL_041f: ldloc.s V_22
IL_0421: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_0426: ldc.i4 181
IL_042b: bne.un.s IL_0479
IL_042d: ldloc.3
IL_042e: ldloc.s V_22
IL_0430: ldfld System.Int32 ForestProbe/ResponseRow::entryId
IL_0435: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_043a: brfalse.s IL_0479
IL_043c: ldloc.s V_22
IL_043e: ldfld System.String ForestProbe/ResponseRow::text
IL_0443: ldloc.s V_23
IL_0445: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_044a: brtrue.s IL_0479
IL_044c: ldloc.s V_22
IL_044e: ldfld System.String ForestProbe/ResponseRow::targetPath
IL_0453: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI"
IL_0458: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_045d: brtrue.s IL_0479
IL_045f: ldloc.s V_22
IL_0461: ldfld System.String ForestProbe/ResponseRow::path
IL_0466: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Response Menu Panel/Viewport/Content/Response: "
IL_046b: ldloc.s V_23
IL_046d: call System.String System.String::Concat(System.String,System.String)
IL_0472: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0477: br.s IL_047a
IL_0479: ldc.i4.1
IL_047a: stloc.s V_24
IL_047c: ldloc.s V_24
IL_047e: brfalse.s IL_048b
IL_0480: ldstr "Tutorial158 original response controls differ"
IL_0485: newobj System.Void System.Exception::.ctor(System.String)
IL_048a: throw
IL_048b: nop
IL_048c: ldloca.s V_21
IL_048e: call System.Boolean System.Collections.Generic.List`1/Enumerator<ForestProbe/ResponseRow>::MoveNext()
IL_0493: brtrue IL_03cf
IL_0498: leave.s IL_04a9
IL_049a: ldloca.s V_21
IL_049c: constrained. System.Collections.Generic.List`1/Enumerator<ForestProbe/ResponseRow>
IL_04a2: callvirt System.Void System.IDisposable::Dispose()
IL_04a7: nop
IL_04a8: endfinally
IL_04a9: nop
IL_04aa: ldnull
IL_04ab: stloc.s V_6
IL_04ad: nop
IL_04ae: call !!0[] UnityEngine.Resources::FindObjectsOfTypeAll<PixelCrushers.DialogueSystem.StandardUISubtitlePanel>()
IL_04b3: stloc.s V_25
IL_04b5: ldc.i4.0
IL_04b6: stloc.s V_26
IL_04b8: br.s IL_051c
IL_04ba: ldloc.s V_25
IL_04bc: ldloc.s V_26
IL_04be: ldelem.ref
IL_04bf: stloc.s V_27
IL_04c1: ldloc.s V_27
IL_04c3: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_04c8: callvirt UnityEngine.SceneManagement.Scene UnityEngine.GameObject::get_scene()
IL_04cd: stloc.s V_29
IL_04cf: ldloca.s V_29
IL_04d1: call System.Boolean UnityEngine.SceneManagement.Scene::IsValid()
IL_04d6: brfalse.s IL_04f0
IL_04d8: ldloc.s V_27
IL_04da: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_04df: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_04e4: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Subtitle Panel 0"
IL_04e9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04ee: br.s IL_04f1
IL_04f0: ldc.i4.0
IL_04f1: stloc.s V_28
IL_04f3: ldloc.s V_28
IL_04f5: brfalse.s IL_0516
IL_04f7: nop
IL_04f8: ldloc.s V_6
IL_04fa: ldnull
IL_04fb: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0500: stloc.s V_30
IL_0502: ldloc.s V_30
IL_0504: brfalse.s IL_0511
IL_0506: ldstr "Ambiguous Tutorial158 subtitle panel"
IL_050b: newobj System.Void System.Exception::.ctor(System.String)
IL_0510: throw
IL_0511: ldloc.s V_27
IL_0513: stloc.s V_6
IL_0515: nop
IL_0516: ldloc.s V_26
IL_0518: ldc.i4.1
IL_0519: add
IL_051a: stloc.s V_26
IL_051c: ldloc.s V_26
IL_051e: ldloc.s V_25
IL_0520: ldlen
IL_0521: conv.i4
IL_0522: blt.s IL_04ba
IL_0524: ldloc.s V_6
IL_0526: ldnull
IL_0527: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_052c: brtrue.s IL_055a
IL_052e: ldloc.s V_6
IL_0530: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUISubtitlePanel::continueButton
IL_0535: ldnull
IL_0536: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_053b: brtrue.s IL_055a
IL_053d: ldloc.s V_6
IL_053f: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_0544: brfalse.s IL_055a
IL_0546: ldloc.s V_6
IL_0548: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_054d: callvirt TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI()
IL_0552: ldnull
IL_0553: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0558: br.s IL_055b
IL_055a: ldc.i4.1
IL_055b: stloc.s V_31
IL_055d: ldloc.s V_31
IL_055f: brfalse.s IL_056c
IL_0561: ldstr "Tutorial158 original subtitle control missing"
IL_0566: newobj System.Void System.Exception::.ctor(System.String)
IL_056b: throw
IL_056c: ldarg.1
IL_056d: ldloc.s V_6
IL_056f: ldfld UnityEngine.UI.Button PixelCrushers.DialogueSystem.StandardUISubtitlePanel::continueButton
IL_0574: stind.ref
IL_0575: ldloc.s V_6
IL_0577: ldfld PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText
IL_057c: callvirt TMPro.TextMeshProUGUI PixelCrushers.UITextField::get_textMeshProUGUI()
IL_0581: stloc.s V_7
IL_0583: ldarg.1
IL_0584: ldind.ref
IL_0585: callvirt !!0 UnityEngine.Component::GetComponent<TheForestOfLove.TextMeshProUIContinueButtonFastForward>()
IL_058a: stloc.s V_8
IL_058c: ldarg.1
IL_058d: ldind.ref
IL_058e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0593: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0598: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Continue Button"
IL_059d: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_05a2: brtrue IL_065d
IL_05a7: ldloc.s V_7
IL_05a9: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_05ae: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_05b3: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI/Dialogue Panel/Text Panel/Subtitle Text"
IL_05b8: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_05bd: brtrue IL_065d
IL_05c2: ldloc.s V_8
IL_05c4: ldnull
IL_05c5: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05ca: brtrue IL_065d
IL_05cf: ldloc.s V_8
IL_05d1: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_05d6: brfalse IL_065d
IL_05db: ldloc.s V_8
IL_05dd: ldfld Febucci.UI.Core.TypewriterCore TheForestOfLove.TextMeshProUIContinueButtonFastForward::febucciTypewriterEffect
IL_05e2: ldnull
IL_05e3: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_05e8: brtrue.s IL_065d
IL_05ea: ldloc.s V_8
IL_05ec: ldfld Febucci.UI.Core.TypewriterCore TheForestOfLove.TextMeshProUIContinueButtonFastForward::febucciTypewriterEffect
IL_05f1: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_05f6: ldloc.s V_7
IL_05f8: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_05fd: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0602: brtrue.s IL_065d
IL_0604: ldloc.s V_8
IL_0606: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::hideContinueButtonOnContinue
IL_060b: brtrue.s IL_065d
IL_060d: ldloc.s V_8
IL_060f: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::continueSubtitlePanel
IL_0614: brfalse.s IL_065d
IL_0616: ldloc.s V_8
IL_0618: ldfld System.Boolean PixelCrushers.DialogueSystem.StandardUIContinueButtonFastForward::continueAlertPanel
IL_061d: brfalse.s IL_065d
IL_061f: ldarg.1
IL_0620: ldind.ref
IL_0621: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0626: callvirt System.Int32 UnityEngine.Events.UnityEventBase::GetPersistentEventCount()
IL_062b: ldc.i4.1
IL_062c: bne.un.s IL_065d
IL_062e: ldarg.1
IL_062f: ldind.ref
IL_0630: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_0635: ldc.i4.0
IL_0636: callvirt UnityEngine.Object UnityEngine.Events.UnityEventBase::GetPersistentTarget(System.Int32)
IL_063b: ldloc.s V_8
IL_063d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0642: brtrue.s IL_065d
IL_0644: ldarg.1
IL_0645: ldind.ref
IL_0646: callvirt UnityEngine.UI.Button/ButtonClickedEvent UnityEngine.UI.Button::get_onClick()
IL_064b: ldc.i4.0
IL_064c: callvirt System.String UnityEngine.Events.UnityEventBase::GetPersistentMethodName(System.Int32)
IL_0651: ldstr "OnFastForward"
IL_0656: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_065b: br.s IL_065e
IL_065d: ldc.i4.1
IL_065e: stloc.s V_32
IL_0660: ldloc.s V_32
IL_0662: brfalse.s IL_066f
IL_0664: ldstr "Tutorial158 original Continue binding differs"
IL_0669: newobj System.Void System.Exception::.ctor(System.String)
IL_066e: throw
IL_066f: ldloc.s V_5
IL_0671: brtrue.s IL_06ba
IL_0673: ldloc.s V_6
IL_0675: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_067a: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_067f: brfalse.s IL_06b7
IL_0681: ldloc.s V_6
IL_0683: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_0688: brfalse.s IL_06b7
IL_068a: ldloc.s V_6
IL_068c: callvirt PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.StandardUISubtitlePanel::get_currentSubtitle()
IL_0691: ldloc.1
IL_0692: bne.un.s IL_06b7
IL_0694: ldarg.1
IL_0695: ldind.ref
IL_0696: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_069b: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_06a0: brfalse.s IL_06b7
IL_06a2: ldarg.1
IL_06a3: ldind.ref
IL_06a4: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_06a9: brfalse.s IL_06b7
IL_06ab: ldarg.1
IL_06ac: ldind.ref
IL_06ad: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_06b2: ldc.i4.0
IL_06b3: ceq
IL_06b5: br.s IL_06b8
IL_06b7: ldc.i4.1
IL_06b8: br.s IL_06bb
IL_06ba: ldc.i4.0
IL_06bb: stloc.s V_33
IL_06bd: ldloc.s V_33
IL_06bf: brfalse.s IL_06cc
IL_06c1: ldstr "Tutorial158 original Continue not active/bound/interactable"
IL_06c6: newobj System.Void System.Exception::.ctor(System.String)
IL_06cb: throw
IL_06cc: newobj System.Void ForestProbe/TutorialCompletion::.ctor()
IL_06d1: dup
IL_06d2: ldstr "original"
IL_06d7: stfld System.String ForestProbe/TutorialCompletion::choiceMode
IL_06dc: dup
IL_06dd: call System.Int32 UnityEngine.Time::get_frameCount()
IL_06e2: stfld System.Int32 ForestProbe/TutorialCompletion::frame
IL_06e7: dup
IL_06e8: ldc.i4.s 120
IL_06ea: stfld System.Int32 ForestProbe/TutorialCompletion::conversationId
IL_06ef: dup
IL_06f0: ldc.i4 158
IL_06f5: stfld System.Int32 ForestProbe/TutorialCompletion::entryId
IL_06fa: dup
IL_06fb: ldloc.1
IL_06fc: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0701: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0706: stfld System.String ForestProbe/TutorialCompletion::text
IL_070b: dup
IL_070c: ldloc.2
IL_070d: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_0712: stfld System.String ForestProbe/TutorialCompletion::sourceText
IL_0717: dup
IL_0718: ldloc.s V_6
IL_071a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_071f: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0724: stfld System.String ForestProbe/TutorialCompletion::panelPath
IL_0729: dup
IL_072a: ldarg.1
IL_072b: ldind.ref
IL_072c: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0731: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0736: stfld System.String ForestProbe/TutorialCompletion::buttonPath
IL_073b: dup
IL_073c: ldloc.s V_7
IL_073e: callvirt UnityEngine.Transform TMPro.TMP_Text::get_transform()
IL_0743: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0748: stfld System.String ForestProbe/TutorialCompletion::textPath
IL_074d: dup
IL_074e: ldstr "Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI"
IL_0753: stfld System.String ForestProbe/TutorialCompletion::targetPath
IL_0758: dup
IL_0759: ldstr "OnFastForward"
IL_075e: stfld System.String ForestProbe/TutorialCompletion::listenerMethod
IL_0763: dup
IL_0764: ldloc.s V_8
IL_0766: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_076b: call System.String ForestProbe::Address(UnityEngine.Transform)
IL_0770: stfld System.String ForestProbe/TutorialCompletion::listenerTargetPath
IL_0775: dup
IL_0776: ldstr "120:159,120:181"
IL_077b: stfld System.String ForestProbe/TutorialCompletion::sourceDestinations
IL_0780: dup
IL_0781: ldstr "120:159,120:181"
IL_0786: stfld System.String ForestProbe/TutorialCompletion::pcDestinations
IL_078b: dup
IL_078c: ldc.i4.1
IL_078d: stfld System.Boolean ForestProbe/TutorialCompletion::graphVerified
IL_0792: dup
IL_0793: ldloc.s V_6
IL_0795: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_079a: stfld System.Int32 ForestProbe/TutorialCompletion::panelInstance
IL_079f: dup
IL_07a0: ldarg.1
IL_07a1: ldind.ref
IL_07a2: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_07a7: stfld System.Int32 ForestProbe/TutorialCompletion::buttonInstance
IL_07ac: dup
IL_07ad: ldloc.s V_7
IL_07af: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_07b4: stfld System.Int32 ForestProbe/TutorialCompletion::textInstance
IL_07b9: dup
IL_07ba: call System.Boolean TheForestOfLove.CustomTypewriterEffectTextMeshPro::IsTyping()
IL_07bf: stfld System.Boolean ForestProbe/TutorialCompletion::typing
IL_07c4: dup
IL_07c5: ldloc.s V_5
IL_07c7: stfld System.Boolean ForestProbe/TutorialCompletion::menuPresent
IL_07cc: dup
IL_07cd: ldarg.1
IL_07ce: ldind.ref
IL_07cf: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_07d4: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_07d9: stfld System.Boolean ForestProbe/TutorialCompletion::buttonActive
IL_07de: dup
IL_07df: ldarg.1
IL_07e0: ldind.ref
IL_07e1: callvirt System.Boolean UnityEngine.Behaviour::get_enabled()
IL_07e6: stfld System.Boolean ForestProbe/TutorialCompletion::buttonEnabled
IL_07eb: dup
IL_07ec: ldarg.1
IL_07ed: ldind.ref
IL_07ee: callvirt System.Boolean UnityEngine.UI.Selectable::IsInteractable()
IL_07f3: stfld System.Boolean ForestProbe/TutorialCompletion::buttonInteractable
IL_07f8: stloc.s V_34
IL_07fa: br.s IL_07fc
IL_07fc: ldloc.s V_34
IL_07fe: ret
