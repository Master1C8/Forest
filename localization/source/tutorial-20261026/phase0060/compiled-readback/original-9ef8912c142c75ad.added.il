METHOD ForestProbe/Bucky141Subtitle ForestProbe::ReadBucky141() | attributes=Private, HideBySig | impl=IL
IL_0000: nop
IL_0001: call System.Boolean PixelCrushers.DialogueSystem.DialogueManager::get_isConversationActive()
IL_0006: brfalse.s IL_0044
IL_0008: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_000d: ldstr "TutorialQuest_BeaverIntroduction"
IL_0012: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0017: brtrue.s IL_0044
IL_0019: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_001e: ldstr "p1"
IL_0023: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0028: brtrue.s IL_0044
IL_002a: call UnityEngine.SceneManagement.Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()
IL_002f: stloc.s V_5
IL_0031: ldloca.s V_5
IL_0033: call System.String UnityEngine.SceneManagement.Scene::get_name()
IL_0038: ldstr "CentralForest"
IL_003d: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0042: br.s IL_0045
IL_0044: ldc.i4.1
IL_0045: stloc.s V_4
IL_0047: ldloc.s V_4
IL_0049: brfalse.s IL_0056
IL_004b: ldstr "Bucky141 original narrative binding differs"
IL_0050: newobj System.Void System.Exception::.ctor(System.String)
IL_0055: throw
IL_0056: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueManager::get_currentConversationState()
IL_005b: stloc.0
IL_005c: ldloc.0
IL_005d: brfalse.s IL_0067
IL_005f: ldloc.0
IL_0060: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0065: br.s IL_0068
IL_0067: ldnull
IL_0068: stloc.1
IL_0069: ldloc.1
IL_006a: brfalse.s IL_0074
IL_006c: ldloc.1
IL_006d: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0072: br.s IL_0075
IL_0074: ldnull
IL_0075: stloc.2
IL_0076: ldloc.2
IL_0077: brfalse.s IL_00c2
IL_0079: ldloc.2
IL_007a: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_007f: ldc.i4 141
IL_0084: bne.un.s IL_00c2
IL_0086: ldloc.2
IL_0087: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_008c: ldc.i4 215
IL_0091: beq.s IL_00bf
IL_0093: ldloc.2
IL_0094: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0099: ldc.i4 217
IL_009e: beq.s IL_00bf
IL_00a0: ldloc.2
IL_00a1: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00a6: ldc.i4 194
IL_00ab: blt.s IL_00bc
IL_00ad: ldloc.2
IL_00ae: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00b3: ldc.i4 212
IL_00b8: cgt
IL_00ba: br.s IL_00bd
IL_00bc: ldc.i4.1
IL_00bd: br.s IL_00c0
IL_00bf: ldc.i4.0
IL_00c0: br.s IL_00c3
IL_00c2: ldc.i4.1
IL_00c3: stloc.s V_6
IL_00c5: ldloc.s V_6
IL_00c7: brfalse.s IL_00d4
IL_00c9: ldstr "Bucky141 unexpected current entry"
IL_00ce: newobj System.Void System.Exception::.ctor(System.String)
IL_00d3: throw
IL_00d4: ldarg.0
IL_00d5: call System.Void ForestProbe::Bucky141Graph()
IL_00da: nop
IL_00db: ldloc.2
IL_00dc: call PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DialogueManager::get_masterDatabase()
IL_00e1: ldc.i4 141
IL_00e6: ldloc.2
IL_00e7: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00ec: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.DialogueDatabase::GetDialogueEntry(System.Int32,System.Int32)
IL_00f1: ceq
IL_00f3: ldc.i4.0
IL_00f4: ceq
IL_00f6: stloc.s V_7
IL_00f8: ldloc.s V_7
IL_00fa: brfalse.s IL_0107
IL_00fc: ldstr "Bucky141 current source entry identity differs"
IL_0101: newobj System.Void System.Exception::.ctor(System.String)
IL_0106: throw
IL_0107: ldloc.2
IL_0108: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_010d: stloc.3
IL_010e: ldloc.3
IL_010f: ldstr "[pic="
IL_0114: callvirt System.Boolean System.String::StartsWith(System.String)
IL_0119: stloc.s V_8
IL_011b: ldloc.s V_8
IL_011d: brfalse.s IL_0130
IL_011f: ldloc.3
IL_0120: ldloc.3
IL_0121: ldc.i4.s 93
IL_0123: callvirt System.Int32 System.String::IndexOf(System.Char)
IL_0128: ldc.i4.1
IL_0129: add
IL_012a: callvirt System.String System.String::Substring(System.Int32)
IL_012f: stloc.3
IL_0130: ldloc.1
IL_0131: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0136: brfalse.s IL_014b
IL_0138: ldloc.1
IL_0139: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_013e: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0143: ldloc.3
IL_0144: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0149: br.s IL_014c
IL_014b: ldc.i4.1
IL_014c: stloc.s V_9
IL_014e: ldloc.s V_9
IL_0150: brfalse.s IL_015d
IL_0152: ldstr "Bucky141 exact current subtitle differs"
IL_0157: newobj System.Void System.Exception::.ctor(System.String)
IL_015c: throw
IL_015d: newobj System.Void ForestProbe/Bucky141Subtitle::.ctor()
IL_0162: dup
IL_0163: ldstr "original"
IL_0168: stfld System.String ForestProbe/Bucky141Subtitle::choiceMode
IL_016d: dup
IL_016e: call System.Int32 UnityEngine.Time::get_frameCount()
IL_0173: stfld System.Int32 ForestProbe/Bucky141Subtitle::frame
IL_0178: dup
IL_0179: ldc.i4 141
IL_017e: stfld System.Int32 ForestProbe/Bucky141Subtitle::conversationId
IL_0183: dup
IL_0184: ldloc.2
IL_0185: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_018a: stfld System.Int32 ForestProbe/Bucky141Subtitle::entryId
IL_018f: dup
IL_0190: ldloc.2
IL_0191: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_DialogueText()
IL_0196: stfld System.String ForestProbe/Bucky141Subtitle::sourceText
IL_019b: dup
IL_019c: ldloc.2
IL_019d: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_01a2: stfld System.Int32 ForestProbe/Bucky141Subtitle::actorId
IL_01a7: dup
IL_01a8: ldloc.2
IL_01a9: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ConversantID()
IL_01ae: stfld System.Int32 ForestProbe/Bucky141Subtitle::conversantId
IL_01b3: dup
IL_01b4: ldc.i4.1
IL_01b5: stfld System.Boolean ForestProbe/Bucky141Subtitle::graphVerified
IL_01ba: stloc.s V_10
IL_01bc: br.s IL_01be
IL_01be: ldloc.s V_10
IL_01c0: ret
