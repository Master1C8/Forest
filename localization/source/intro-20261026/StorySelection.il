TYPE TheForestOfLove.Narrative.StoryManager
METHOD System.Boolean TheForestOfLove.Narrative.StoryManager::IsInferredSchema(TheForestOfLove.DialogueSettings)
IL_0000: ldarg.0
IL_0001: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_0006: call System.Boolean TheForestOfLove.Narrative.StoryManager::IsInferredSchema(System.String)
IL_000b: ret
METHOD System.Boolean TheForestOfLove.Narrative.StoryManager::IsInferredSchema(System.String)
IL_0000: ldarg.0
IL_0001: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0006: brtrue.s IL_0014
IL_0008: ldarg.0
IL_0009: ldstr "- Untagged -"
IL_000e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0013: ret
IL_0014: ldc.i4.1
IL_0015: ret
METHOD TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.StoryManager::ChooseTargetStepAndArc(TheForestOfLove.Narrative.QuestManagerInteractionMode,TheForestOfLove.DialogueSettings,TheForestOfLove.Narrative.Actor,TheForestOfLove.Narrative.ActorDialogueOracle)
IL_0000: ldarg.1
IL_0001: call System.Boolean TheForestOfLove.Narrative.StoryManager::IsInferredSchema(TheForestOfLove.DialogueSettings)
IL_0006: brfalse IL_01bf
IL_000b: ldarg.0
IL_000c: brfalse.s IL_001a
IL_000e: ldarg.0
IL_000f: ldc.i4.1
IL_0010: beq IL_0197
IL_0015: br IL_01bd
IL_001a: ldarg.2
IL_001b: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isSelectedForDate
IL_0020: brfalse.s IL_0084
IL_0022: ldarg.2
IL_0023: ldfld System.Boolean TheForestOfLove.Narrative.Actor::hasStartedDate
IL_0028: brtrue.s IL_0084
IL_002a: ldsfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::selectedDateDialogue
IL_002f: brfalse.s IL_0084
IL_0031: ldarg.3
IL_0032: ldsfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::selectedDateDialogue
IL_0037: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackSelectedDate(TheForestOfLove.Narrative.Dialogue)
IL_003c: stloc.0
IL_003d: ldloc.0
IL_003e: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedPrimaryArc()
IL_0043: ldarg.2
IL_0044: ldc.i4.1
IL_0045: stfld System.Boolean TheForestOfLove.Narrative.Actor::hasStartedDate
IL_004a: ldsfld TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::selectedDateDialogue
IL_004f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.Dialogue::dateActors
IL_0054: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor>::GetEnumerator()
IL_0059: stloc.1
IL_005a: br.s IL_0069
IL_005c: ldloca.s V_1
IL_005e: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Actor>::get_Current()
IL_0063: ldc.i4.1
IL_0064: stfld System.Boolean TheForestOfLove.Narrative.Actor::hasStartedDate
IL_0069: ldloca.s V_1
IL_006b: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Actor>::MoveNext()
IL_0070: brtrue.s IL_005c
IL_0072: leave.s IL_0082
IL_0074: ldloca.s V_1
IL_0076: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Actor>
IL_007c: callvirt System.Void System.IDisposable::Dispose()
IL_0081: endfinally
IL_0082: ldloc.0
IL_0083: ret
IL_0084: ldarg.3
IL_0085: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::get_LatestDialogueSchema()
IL_008a: brfalse.s IL_00a8
IL_008c: ldarg.3
IL_008d: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::get_LatestDialogueSchema()
IL_0092: callvirt System.Boolean TheForestOfLove.Narrative.DialogueTrackingSchema::get_hasUnplayedPrimaryArcs()
IL_0097: brfalse.s IL_00a8
IL_0099: ldarg.3
IL_009a: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::get_LatestDialogueSchema()
IL_009f: stloc.0
IL_00a0: ldloc.0
IL_00a1: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedPrimaryArc()
IL_00a6: ldloc.0
IL_00a7: ret
IL_00a8: ldarg.3
IL_00a9: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::HasQuestToTurnIn()
IL_00ae: brfalse.s IL_00bf
IL_00b0: ldarg.3
IL_00b1: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackFirstEncounteredQuestToTurnIn()
IL_00b6: stloc.0
IL_00b7: ldloc.0
IL_00b8: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedPrimaryArc()
IL_00bd: ldloc.0
IL_00be: ret
IL_00bf: ldarg.3
IL_00c0: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::HasNewMainQuest()
IL_00c5: brfalse.s IL_00d6
IL_00c7: ldarg.3
IL_00c8: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackFirstEncounteredNewQuest()
IL_00cd: stloc.0
IL_00ce: ldloc.0
IL_00cf: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedPrimaryArc()
IL_00d4: ldloc.0
IL_00d5: ret
IL_00d6: ldarg.3
IL_00d7: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::HasNewSideQuest()
IL_00dc: brfalse.s IL_00ed
IL_00de: ldarg.3
IL_00df: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackFirstEncounteredNewSideQuest()
IL_00e4: stloc.0
IL_00e5: ldloc.0
IL_00e6: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedPrimaryArc()
IL_00eb: ldloc.0
IL_00ec: ret
IL_00ed: ldarg.3
IL_00ee: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::HasAvailableUnplayedQuestDialogue()
IL_00f3: brfalse.s IL_0104
IL_00f5: ldarg.3
IL_00f6: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackFirstEncounteredUnplayedQuestDialogue()
IL_00fb: stloc.0
IL_00fc: ldloc.0
IL_00fd: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedPrimaryArc()
IL_0102: ldloc.0
IL_0103: ret
IL_0104: ldarg.3
IL_0105: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::HasAvailableDynamicQuestions()
IL_010a: brfalse.s IL_0115
IL_010c: ldarg.3
IL_010d: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackDynamicQuestions()
IL_0112: stloc.0
IL_0113: ldloc.0
IL_0114: ret
IL_0115: ldarg.2
IL_0116: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isSelectedForDate
IL_011b: brtrue.s IL_014b
IL_011d: ldarg.2
IL_011e: ldfld System.Boolean TheForestOfLove.Narrative.Actor::isSelectedForGift
IL_0123: brfalse.s IL_014b
IL_0125: ldarg.2
IL_0126: ldfld System.Boolean TheForestOfLove.Narrative.Actor::hasStartedGift
IL_012b: brtrue.s IL_014b
IL_012d: ldarg.3
IL_012e: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::HasUnplayedGift()
IL_0133: brfalse.s IL_014b
IL_0135: ldarg.3
IL_0136: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackFirstUnplayedGift()
IL_013b: stloc.0
IL_013c: ldloc.0
IL_013d: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedPrimaryArc()
IL_0142: ldarg.2
IL_0143: ldc.i4.1
IL_0144: stfld System.Boolean TheForestOfLove.Narrative.Actor::hasStartedGift
IL_0149: ldloc.0
IL_014a: ret
IL_014b: ldarg.3
IL_014c: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::HasDialogueWithIdleArcsInUnfinishedQuest()
IL_0151: brfalse.s IL_0162
IL_0153: ldarg.3
IL_0154: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackFirstEncounteredDialogueWithIdleArcsInUnfinishedQuest()
IL_0159: stloc.0
IL_015a: ldloc.0
IL_015b: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextRoundRobinIdleArc()
IL_0160: ldloc.0
IL_0161: ret
IL_0162: ldarg.3
IL_0163: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::HasAvailableFinalIdle()
IL_0168: brfalse.s IL_0195
IL_016a: ldarg.3
IL_016b: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackFirstEncounteredAvailableFinalIdle()
IL_0170: stloc.0
IL_0171: ldloc.0
IL_0172: callvirt System.Boolean TheForestOfLove.Narrative.DialogueTrackingSchema::get_hasUnplayedPrimaryArcs()
IL_0177: brfalse.s IL_0181
IL_0179: ldloc.0
IL_017a: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedPrimaryArc()
IL_017f: br.s IL_0193
IL_0181: ldloc.0
IL_0182: callvirt System.Boolean TheForestOfLove.Narrative.DialogueTrackingSchema::get_hasIdleArcs()
IL_0187: brfalse.s IL_0191
IL_0189: ldloc.0
IL_018a: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextRoundRobinIdleArc()
IL_018f: br.s IL_0193
IL_0191: ldnull
IL_0192: stloc.0
IL_0193: ldloc.0
IL_0194: ret
IL_0195: ldnull
IL_0196: ret
IL_0197: ldarg.3
IL_0198: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::get_LatestDialogueSchema()
IL_019d: brfalse.s IL_01bb
IL_019f: ldarg.3
IL_01a0: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::get_LatestDialogueSchema()
IL_01a5: callvirt System.Boolean TheForestOfLove.Narrative.DialogueTrackingSchema::get_hasUnplayedSecondaryArcs()
IL_01aa: brfalse.s IL_01bb
IL_01ac: ldarg.3
IL_01ad: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::get_LatestDialogueSchema()
IL_01b2: stloc.0
IL_01b3: ldloc.0
IL_01b4: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedSecondaryArc()
IL_01b9: ldloc.0
IL_01ba: ret
IL_01bb: ldnull
IL_01bc: ret
IL_01bd: ldnull
IL_01be: ret
IL_01bf: ldarg.1
IL_01c0: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_01c5: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_01ca: brtrue.s IL_020f
IL_01cc: ldc.i4.1
IL_01cd: call System.Void TheForestOfLove.Narrative.StoryManager::set_BypassPreconditionsForSingleDialogue(System.Boolean)
IL_01d2: ldarg.3
IL_01d3: ldarg.1
IL_01d4: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_01d9: ldarg.1
IL_01da: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_01df: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableSingleDialogue(System.String,System.String)
IL_01e4: brfalse.s IL_020d
IL_01e6: ldarg.3
IL_01e7: ldarg.1
IL_01e8: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_01ed: ldarg.1
IL_01ee: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_01f3: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackSingleDialogue(System.String,System.String)
IL_01f8: stloc.0
IL_01f9: ldloc.0
IL_01fa: ldarg.1
IL_01fb: callvirt System.String TheForestOfLove.DialogueSettings::get_ArcDbName()
IL_0200: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNamedDialogueArc(System.String)
IL_0205: ldc.i4.0
IL_0206: call System.Void TheForestOfLove.Narrative.StoryManager::set_BypassPreconditionsForSingleDialogue(System.Boolean)
IL_020b: ldloc.0
IL_020c: ret
IL_020d: ldnull
IL_020e: ret
IL_020f: ldarg.0
IL_0210: switch IL_0226,IL_0275,IL_02b4
IL_0221: br IL_02d9
IL_0226: ldc.i4.1
IL_0227: call System.Void TheForestOfLove.Narrative.StoryManager::set_BypassPreconditionsForSingleDialogue(System.Boolean)
IL_022c: ldarg.3
IL_022d: ldarg.1
IL_022e: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_0233: ldnull
IL_0234: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableSingleDialogue(System.String,System.String)
IL_0239: brfalse.s IL_0273
IL_023b: ldarg.3
IL_023c: ldarg.1
IL_023d: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_0242: ldnull
IL_0243: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackSingleDialogue(System.String,System.String)
IL_0248: stloc.0
IL_0249: ldloc.0
IL_024a: callvirt System.Boolean TheForestOfLove.Narrative.DialogueTrackingSchema::get_hasUnplayedPrimaryArcs()
IL_024f: brfalse.s IL_0259
IL_0251: ldloc.0
IL_0252: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedPrimaryArc()
IL_0257: br.s IL_026b
IL_0259: ldloc.0
IL_025a: callvirt System.Boolean TheForestOfLove.Narrative.DialogueTrackingSchema::get_hasIdleArcs()
IL_025f: brfalse.s IL_0269
IL_0261: ldloc.0
IL_0262: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextRoundRobinIdleArc()
IL_0267: br.s IL_026b
IL_0269: ldnull
IL_026a: stloc.0
IL_026b: ldc.i4.0
IL_026c: call System.Void TheForestOfLove.Narrative.StoryManager::set_BypassPreconditionsForSingleDialogue(System.Boolean)
IL_0271: ldloc.0
IL_0272: ret
IL_0273: ldnull
IL_0274: ret
IL_0275: ldc.i4.1
IL_0276: call System.Void TheForestOfLove.Narrative.StoryManager::set_BypassPreconditionsForSingleDialogue(System.Boolean)
IL_027b: ldarg.3
IL_027c: ldarg.1
IL_027d: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_0282: ldnull
IL_0283: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableSingleDialogue(System.String,System.String)
IL_0288: brfalse.s IL_02b2
IL_028a: ldarg.3
IL_028b: ldarg.1
IL_028c: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_0291: ldnull
IL_0292: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackSingleDialogue(System.String,System.String)
IL_0297: stloc.0
IL_0298: ldloc.0
IL_0299: callvirt System.Boolean TheForestOfLove.Narrative.DialogueTrackingSchema::get_hasUnplayedSecondaryArcs()
IL_029e: brfalse.s IL_02a8
IL_02a0: ldloc.0
IL_02a1: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextUnplayedSecondaryArc()
IL_02a6: br.s IL_02aa
IL_02a8: ldnull
IL_02a9: stloc.0
IL_02aa: ldc.i4.0
IL_02ab: call System.Void TheForestOfLove.Narrative.StoryManager::set_BypassPreconditionsForSingleDialogue(System.Boolean)
IL_02b0: ldloc.0
IL_02b1: ret
IL_02b2: ldnull
IL_02b3: ret
IL_02b4: ldarg.3
IL_02b5: ldarg.1
IL_02b6: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_02bb: callvirt System.Boolean TheForestOfLove.Narrative.ActorDialogueOracle::IsAvailableGossip(System.String)
IL_02c0: brfalse.s IL_02d7
IL_02c2: ldarg.3
IL_02c3: ldarg.1
IL_02c4: callvirt System.String TheForestOfLove.DialogueSettings::get_DialogueDbName()
IL_02c9: callvirt TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackSelectedGossip(System.String)
IL_02ce: stloc.0
IL_02cf: ldloc.0
IL_02d0: callvirt System.Void TheForestOfLove.Narrative.DialogueTrackingSchema::TrackNextRoundRobinPrimaryArc()
IL_02d5: ldloc.0
IL_02d6: ret
IL_02d7: ldnull
IL_02d8: ret
IL_02d9: ldnull
IL_02da: ret
