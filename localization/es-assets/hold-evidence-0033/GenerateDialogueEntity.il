TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::<GenerateDialogues>b__0(TheForestOfLove.DB.Dialogue)
IL_0000: newobj System.Void TheForestOfLove.Narrative.Dialogue::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: callvirt System.String BansheeGz.BGDatabase.BGEntity::get_Name()
IL_000d: stfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0012: ldloc.0
IL_0013: ldarg.1
IL_0014: stfld TheForestOfLove.DB.Dialogue TheForestOfLove.Narrative.Dialogue::dbDialogue
IL_0019: ldloc.0
IL_001a: ldarg.1
IL_001b: callvirt System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_0020: stfld System.Int32 TheForestOfLove.Narrative.Dialogue::dbDialogueIndex
IL_0025: ldloc.0
IL_0026: ldarg.1
IL_0027: callvirt System.String TheForestOfLove.DB.Dialogue::get_savekey()
IL_002c: stfld System.String TheForestOfLove.Narrative.Dialogue::savekey
IL_0031: ldloc.0
IL_0032: ldarg.1
IL_0033: callvirt System.String TheForestOfLove.DB.Dialogue::get_plugin_db_name()
IL_0038: stfld System.String TheForestOfLove.Narrative.Dialogue::pluginDbName
IL_003d: ldloc.0
IL_003e: ldarg.0
IL_003f: ldfld PixelCrushers.DialogueSystem.DialogueDatabase TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::database
IL_0044: ldloc.0
IL_0045: ldfld System.String TheForestOfLove.Narrative.Dialogue::pluginDbName
IL_004a: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_004f: stfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0054: ldloc.0
IL_0055: ldarg.1
IL_0056: callvirt TheForestOfLove.DB.DialogueType TheForestOfLove.DB.Dialogue::get_type()
IL_005b: callvirt TheForestOfLove.Narrative.DialogueType TheForestOfLove.DB.DialogueType::get_enum_type()
IL_0060: stfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0065: ldloc.0
IL_0066: ldarg.0
IL_0067: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_006c: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByDbActor
IL_0071: ldarg.1
IL_0072: callvirt TheForestOfLove.DB.Actor TheForestOfLove.DB.Dialogue::get_primary_actor()
IL_0077: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_007c: stfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_0081: ldloc.0
IL_0082: ldloc.0
IL_0083: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_0088: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_008d: stfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_0092: ldloc.0
IL_0093: ldarg.1
IL_0094: callvirt TheForestOfLove.DB.Actor TheForestOfLove.DB.Dialogue::get_initial_actor()
IL_0099: brtrue.s IL_00a3
IL_009b: ldloc.0
IL_009c: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_00a1: br.s IL_00b9
IL_00a3: ldarg.0
IL_00a4: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_00a9: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByDbActor
IL_00ae: ldarg.1
IL_00af: callvirt TheForestOfLove.DB.Actor TheForestOfLove.DB.Dialogue::get_initial_actor()
IL_00b4: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_00b9: stfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::initialActor
IL_00be: ldloc.0
IL_00bf: ldloc.0
IL_00c0: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::initialActor
IL_00c5: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00ca: stfld System.String TheForestOfLove.Narrative.Dialogue::initialActorDbName
IL_00cf: ldloc.0
IL_00d0: ldarg.1
IL_00d1: callvirt TheForestOfLove.DB.Quest TheForestOfLove.DB.Dialogue::get_quest()
IL_00d6: brtrue.s IL_00db
IL_00d8: ldnull
IL_00d9: br.s IL_00f1
IL_00db: ldarg.0
IL_00dc: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_00e1: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbQuest
IL_00e6: ldarg.1
IL_00e7: callvirt TheForestOfLove.DB.Quest TheForestOfLove.DB.Dialogue::get_quest()
IL_00ec: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_00f1: stfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_00f6: ldloc.0
IL_00f7: ldarg.1
IL_00f8: callvirt System.Int32 TheForestOfLove.DB.Dialogue::get_priority()
IL_00fd: stfld System.Int32 TheForestOfLove.Narrative.Dialogue::priority
IL_0102: ldloc.0
IL_0103: ldarg.1
IL_0104: callvirt System.Boolean TheForestOfLove.DB.Dialogue::get_has_player_initiated_question()
IL_0109: stfld System.Boolean TheForestOfLove.Narrative.Dialogue::hasPlayerInitiatedQuestion
IL_010e: ldloc.0
IL_010f: ldarg.1
IL_0110: callvirt System.Boolean TheForestOfLove.DB.Dialogue::get_complete_if_skip_any_arc()
IL_0115: stfld System.Boolean TheForestOfLove.Narrative.Dialogue::completeStepIfSkippingAnyArc
IL_011a: ldloc.0
IL_011b: ldarg.1
IL_011c: callvirt TheForestOfLove.InteractionUiStatusIconProfileType TheForestOfLove.DB.Dialogue::get_interaction_icon_profile()
IL_0121: stfld TheForestOfLove.InteractionUiStatusIconProfileType TheForestOfLove.Narrative.Dialogue::interactionUiStatusIconProfileType
IL_0126: ldloc.0
IL_0127: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_012c: brtrue.s IL_0144
IL_012e: ldstr "dialogue is missing plugin db conversation, make sure it exists in the Dialogue System db "
IL_0133: ldloc.0
IL_0134: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0139: call System.String System.String::Concat(System.String,System.String)
IL_013e: newobj System.Void System.Exception::.ctor(System.String)
IL_0143: throw
IL_0144: ldloc.0
IL_0145: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_014a: ldc.i4 500
IL_014f: bne.un IL_0202
IL_0154: ldarg.1
IL_0155: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueDateSettings> TheForestOfLove.DB.Dialogue::get_RelatedDialogueDateSettingsListUsingdate_dialogueRelation()
IL_015a: brfalse.s IL_016a
IL_015c: ldarg.1
IL_015d: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueDateSettings> TheForestOfLove.DB.Dialogue::get_RelatedDialogueDateSettingsListUsingdate_dialogueRelation()
IL_0162: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueDateSettings>::get_Count()
IL_0167: ldc.i4.1
IL_0168: beq.s IL_0180
IL_016a: ldstr "all dates must have exactly one corresponding date settings record "
IL_016f: ldloc.0
IL_0170: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0175: call System.String System.String::Concat(System.String,System.String)
IL_017a: newobj System.Void System.Exception::.ctor(System.String)
IL_017f: throw
IL_0180: ldarg.1
IL_0181: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueDateSettings> TheForestOfLove.DB.Dialogue::get_RelatedDialogueDateSettingsListUsingdate_dialogueRelation()
IL_0186: ldc.i4.0
IL_0187: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueDateSettings>::get_Item(System.Int32)
IL_018c: stloc.1
IL_018d: ldloc.1
IL_018e: callvirt System.String TheForestOfLove.DB.DialogueDateSettings::get_legacy_date_prefab_name()
IL_0193: brtrue.s IL_01ab
IL_0195: ldstr "missing prefab for date "
IL_019a: ldloc.0
IL_019b: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_01a0: call System.String System.String::Concat(System.String,System.String)
IL_01a5: newobj System.Void System.Exception::.ctor(System.String)
IL_01aa: throw
IL_01ab: ldloc.0
IL_01ac: ldloc.1
IL_01ad: callvirt System.String TheForestOfLove.DB.DialogueDateSettings::get_legacy_date_prefab_name()
IL_01b2: stfld System.String TheForestOfLove.Narrative.Dialogue::legacyDatePrefabName
IL_01b7: ldloc.1
IL_01b8: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Actor> TheForestOfLove.DB.DialogueDateSettings::get_date_actors()
IL_01bd: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Actor>::GetEnumerator()
IL_01c2: stloc.2
IL_01c3: br.s IL_01e9
IL_01c5: ldloca.s V_2
IL_01c7: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>::get_Current()
IL_01cc: stloc.3
IL_01cd: ldloc.0
IL_01ce: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.Dialogue::dateActors
IL_01d3: ldarg.0
IL_01d4: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_01d9: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByDbActor
IL_01de: ldloc.3
IL_01df: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor>::get_Item(!0)
IL_01e4: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor>::Add(!0)
IL_01e9: ldloca.s V_2
IL_01eb: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>::MoveNext()
IL_01f0: brtrue.s IL_01c5
IL_01f2: leave.s IL_0202
IL_01f4: ldloca.s V_2
IL_01f6: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Actor>
IL_01fc: callvirt System.Void System.IDisposable::Dispose()
IL_0201: endfinally
IL_0202: ldarg.1
IL_0203: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueArcCustomConfig> TheForestOfLove.DB.Dialogue::get_RelatedDialogueArcCustomConfigListUsingdialogueRelation()
IL_0208: brfalse.s IL_027c
IL_020a: ldarg.1
IL_020b: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueArcCustomConfig> TheForestOfLove.DB.Dialogue::get_RelatedDialogueArcCustomConfigListUsingdialogueRelation()
IL_0210: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueArcCustomConfig>::GetEnumerator()
IL_0215: stloc.s V_4
IL_0217: br.s IL_0263
IL_0219: ldloca.s V_4
IL_021b: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueArcCustomConfig>::get_Current()
IL_0220: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueArc> TheForestOfLove.DB.DialogueArcCustomConfig::get_arcs()
IL_0225: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.DialogueArc>::GetEnumerator()
IL_022a: stloc.s V_5
IL_022c: br.s IL_024a
IL_022e: ldloca.s V_5
IL_0230: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueArc>::get_Current()
IL_0235: stloc.s V_6
IL_0237: ldloc.0
IL_0238: ldfld System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Narrative.Dialogue::arcSuffixesDisallowSkip
IL_023d: ldloc.s V_6
IL_023f: callvirt System.String TheForestOfLove.DB.DialogueArc::get_name()
IL_0244: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0249: pop
IL_024a: ldloca.s V_5
IL_024c: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueArc>::MoveNext()
IL_0251: brtrue.s IL_022e
IL_0253: leave.s IL_0263
IL_0255: ldloca.s V_5
IL_0257: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueArc>
IL_025d: callvirt System.Void System.IDisposable::Dispose()
IL_0262: endfinally
IL_0263: ldloca.s V_4
IL_0265: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueArcCustomConfig>::MoveNext()
IL_026a: brtrue.s IL_0219
IL_026c: leave.s IL_027c
IL_026e: ldloca.s V_4
IL_0270: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.DialogueArcCustomConfig>
IL_0276: callvirt System.Void System.IDisposable::Dispose()
IL_027b: endfinally
IL_027c: ldarg.1
IL_027d: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.Dialogue::get_skip_triggers_on_dialogue_skip()
IL_0282: brfalse.s IL_02d2
IL_0284: ldarg.1
IL_0285: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.Dialogue::get_skip_triggers_on_dialogue_skip()
IL_028a: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger>::GetEnumerator()
IL_028f: stloc.s V_7
IL_0291: br.s IL_02b9
IL_0293: ldloca.s V_7
IL_0295: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::get_Current()
IL_029a: stloc.s V_8
IL_029c: ldloc.0
IL_029d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringDialogueSkip
IL_02a2: ldarg.0
IL_02a3: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_02a8: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_02ad: ldloc.s V_8
IL_02af: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_02b4: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::Add(!0)
IL_02b9: ldloca.s V_7
IL_02bb: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::MoveNext()
IL_02c0: brtrue.s IL_0293
IL_02c2: leave.s IL_02d2
IL_02c4: ldloca.s V_7
IL_02c6: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>
IL_02cc: callvirt System.Void System.IDisposable::Dispose()
IL_02d1: endfinally
IL_02d2: ldarg.1
IL_02d3: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.Dialogue::get_skip_triggers_on_chapter_select()
IL_02d8: brfalse.s IL_0328
IL_02da: ldarg.1
IL_02db: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.Dialogue::get_skip_triggers_on_chapter_select()
IL_02e0: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger>::GetEnumerator()
IL_02e5: stloc.s V_7
IL_02e7: br.s IL_030f
IL_02e9: ldloca.s V_7
IL_02eb: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::get_Current()
IL_02f0: stloc.s V_9
IL_02f2: ldloc.0
IL_02f3: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringChapterSelect
IL_02f8: ldarg.0
IL_02f9: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_02fe: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_0303: ldloc.s V_9
IL_0305: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_030a: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::Add(!0)
IL_030f: ldloca.s V_7
IL_0311: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::MoveNext()
IL_0316: brtrue.s IL_02e9
IL_0318: leave.s IL_0328
IL_031a: ldloca.s V_7
IL_031c: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>
IL_0322: callvirt System.Void System.IDisposable::Dispose()
IL_0327: endfinally
IL_0328: ldarg.1
IL_0329: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.Dialogue::get_skip_triggers_on_cheat_code()
IL_032e: brfalse.s IL_037e
IL_0330: ldarg.1
IL_0331: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger> TheForestOfLove.DB.Dialogue::get_skip_triggers_on_cheat_code()
IL_0336: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Trigger>::GetEnumerator()
IL_033b: stloc.s V_7
IL_033d: br.s IL_0365
IL_033f: ldloca.s V_7
IL_0341: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::get_Current()
IL_0346: stloc.s V_10
IL_0348: ldloc.0
IL_0349: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.Dialogue::triggersSkipDuringCheatCode
IL_034e: ldarg.0
IL_034f: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0354: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_0359: ldloc.s V_10
IL_035b: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::get_Item(!0)
IL_0360: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::Add(!0)
IL_0365: ldloca.s V_7
IL_0367: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>::MoveNext()
IL_036c: brtrue.s IL_033f
IL_036e: leave.s IL_037e
IL_0370: ldloca.s V_7
IL_0372: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Trigger>
IL_0378: callvirt System.Void System.IDisposable::Dispose()
IL_037d: endfinally
IL_037e: ldarg.1
IL_037f: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.Dialogue::get_related_tags()
IL_0384: brfalse.s IL_03d4
IL_0386: ldarg.1
IL_0387: callvirt System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.Dialogue::get_related_tags()
IL_038c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::GetEnumerator()
IL_0391: stloc.s V_11
IL_0393: br.s IL_03bb
IL_0395: ldloca.s V_11
IL_0397: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::get_Current()
IL_039c: stloc.s V_12
IL_039e: ldloc.0
IL_039f: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.Dialogue::relatedTags
IL_03a4: ldarg.0
IL_03a5: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_03aa: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_03af: ldloc.s V_12
IL_03b1: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::get_Item(!0)
IL_03b6: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_03bb: ldloca.s V_11
IL_03bd: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>::MoveNext()
IL_03c2: brtrue.s IL_0395
IL_03c4: leave.s IL_03d4
IL_03c6: ldloca.s V_11
IL_03c8: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.DB.Tag>
IL_03ce: callvirt System.Void System.IDisposable::Dispose()
IL_03d3: endfinally
IL_03d4: ldloc.0
IL_03d5: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_03da: brtrue.s IL_03ff
IL_03dc: ldloc.0
IL_03dd: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_03e2: ldc.i4 200
IL_03e7: bne.un.s IL_03ff
IL_03e9: ldstr "could not find matching quest! "
IL_03ee: ldloc.0
IL_03ef: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_03f4: call System.String System.String::Concat(System.String,System.String)
IL_03f9: newobj System.Void System.Exception::.ctor(System.String)
IL_03fe: throw
IL_03ff: ldloc.0
IL_0400: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0405: ldc.i4 400
IL_040a: bne.un.s IL_042a
IL_040c: ldloc.0
IL_040d: ldfld System.Boolean TheForestOfLove.Narrative.Dialogue::hasPlayerInitiatedQuestion
IL_0412: brtrue.s IL_042a
IL_0414: ldstr "gossip dialogues must have a player initiated question! "
IL_0419: ldloc.0
IL_041a: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_041f: call System.String System.String::Concat(System.String,System.String)
IL_0424: newobj System.Void System.Exception::.ctor(System.String)
IL_0429: throw
IL_042a: ldarg.0
IL_042b: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0430: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialogues
IL_0435: ldloc.0
IL_0436: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_043b: ldarg.0
IL_043c: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0441: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbName
IL_0446: ldloc.0
IL_0447: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_044c: ldloc.0
IL_044d: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::Add(!0,!1)
IL_0452: ldarg.0
IL_0453: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0458: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByDbDialogue
IL_045d: ldloc.0
IL_045e: ldfld TheForestOfLove.DB.Dialogue TheForestOfLove.Narrative.Dialogue::dbDialogue
IL_0463: ldloc.0
IL_0464: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Dialogue,TheForestOfLove.Narrative.Dialogue>::Add(!0,!1)
IL_0469: ldarg.0
IL_046a: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_046f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesBySavekey
IL_0474: ldloc.0
IL_0475: ldfld System.String TheForestOfLove.Narrative.Dialogue::savekey
IL_047a: ldloc.0
IL_047b: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Dialogue>::Add(!0,!1)
IL_0480: ldarg.0
IL_0481: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0486: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DataManifest::dialoguesByPluginDbId
IL_048b: ldloc.0
IL_048c: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_0491: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0496: ldloc.0
IL_0497: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Dialogue>::Add(!0,!1)
IL_049c: ldarg.0
IL_049d: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_04a2: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesByActorDbName
IL_04a7: ldloc.0
IL_04a8: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_04ad: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_04b2: ldloc.0
IL_04b3: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_04b8: ldloc.0
IL_04b9: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_04be: brfalse.s IL_0520
IL_04c0: ldloc.0
IL_04c1: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_04c6: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.Quest::dialogues
IL_04cb: ldloc.0
IL_04cc: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_04d1: ldloc.0
IL_04d2: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_04d7: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Actor,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.Quest::dialoguesByActor
IL_04dc: ldloc.0
IL_04dd: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_04e2: callvirt System.Boolean System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Actor,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::ContainsKey(!0)
IL_04e7: brtrue.s IL_0504
IL_04e9: ldloc.0
IL_04ea: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_04ef: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Actor,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.Quest::dialoguesByActor
IL_04f4: ldloc.0
IL_04f5: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_04fa: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_04ff: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Actor,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::Add(!0,!1)
IL_0504: ldloc.0
IL_0505: ldfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.Dialogue::quest
IL_050a: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Actor,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.Quest::dialoguesByActor
IL_050f: ldloc.0
IL_0510: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_0515: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Actor,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_051a: ldloc.0
IL_051b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_0520: ldloc.0
IL_0521: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0526: stloc.s V_13
IL_0528: ldloc.s V_13
IL_052a: ldc.i4 300
IL_052f: bgt.s IL_0549
IL_0531: ldloc.s V_13
IL_0533: brfalse.s IL_0584
IL_0535: ldloc.s V_13
IL_0537: ldc.i4 200
IL_053c: beq.s IL_05a5
IL_053e: ldloc.s V_13
IL_0540: ldc.i4 300
IL_0545: beq.s IL_05c6
IL_0547: br.s IL_0584
IL_0549: ldloc.s V_13
IL_054b: ldc.i4 500
IL_0550: bgt.s IL_056c
IL_0552: ldloc.s V_13
IL_0554: ldc.i4 400
IL_0559: beq IL_05e4
IL_055e: ldloc.s V_13
IL_0560: ldc.i4 500
IL_0565: beq IL_0602
IL_056a: br.s IL_0584
IL_056c: ldloc.s V_13
IL_056e: ldc.i4 600
IL_0573: beq IL_0620
IL_0578: ldloc.s V_13
IL_057a: ldc.i4 700
IL_057f: beq IL_063e
IL_0584: ldarg.0
IL_0585: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_058a: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeManualByActorDbName
IL_058f: ldloc.0
IL_0590: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_0595: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_059a: ldloc.0
IL_059b: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_05a0: br IL_065a
IL_05a5: ldarg.0
IL_05a6: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_05ab: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestByActorDbName
IL_05b0: ldloc.0
IL_05b1: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_05b6: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_05bb: ldloc.0
IL_05bc: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_05c1: br IL_065a
IL_05c6: ldarg.0
IL_05c7: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_05cc: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeFinalIdleByActorDbName
IL_05d1: ldloc.0
IL_05d2: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_05d7: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_05dc: ldloc.0
IL_05dd: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_05e2: br.s IL_065a
IL_05e4: ldarg.0
IL_05e5: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_05ea: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGossipByActorDbName
IL_05ef: ldloc.0
IL_05f0: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_05f5: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_05fa: ldloc.0
IL_05fb: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_0600: br.s IL_065a
IL_0602: ldarg.0
IL_0603: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0608: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeDateByActorDbName
IL_060d: ldloc.0
IL_060e: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_0613: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0618: ldloc.0
IL_0619: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_061e: br.s IL_065a
IL_0620: ldarg.0
IL_0621: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0626: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGiftByActorDbName
IL_062b: ldloc.0
IL_062c: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_0631: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0636: ldloc.0
IL_0637: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_063c: br.s IL_065a
IL_063e: ldarg.0
IL_063f: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0644: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestionIdleByActorDbName
IL_0649: ldloc.0
IL_064a: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_064f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::get_Item(!0)
IL_0654: ldloc.0
IL_0655: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::Add(!0)
IL_065a: ldarg.0
IL_065b: ldfld TheForestOfLove.Narrative.DialogueSystemLoader TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::<>4__this
IL_0660: ldarg.0
IL_0661: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0666: ldarg.0
IL_0667: ldfld PixelCrushers.DialogueSystem.DialogueDatabase TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::database
IL_066c: ldloc.0
IL_066d: ldstr "PRIMARY"
IL_0672: ldloc.0
IL_0673: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::primaryArcs
IL_0678: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PopulateDialogueArcs(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Dialogue,System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>)
IL_067d: ldarg.0
IL_067e: ldfld TheForestOfLove.Narrative.DialogueSystemLoader TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::<>4__this
IL_0683: ldarg.0
IL_0684: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_0689: ldarg.0
IL_068a: ldfld PixelCrushers.DialogueSystem.DialogueDatabase TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::database
IL_068f: ldloc.0
IL_0690: ldstr "SECONDARY"
IL_0695: ldloc.0
IL_0696: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::secondaryArcs
IL_069b: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PopulateDialogueArcs(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Dialogue,System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>)
IL_06a0: ldarg.0
IL_06a1: ldfld TheForestOfLove.Narrative.DialogueSystemLoader TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::<>4__this
IL_06a6: ldarg.0
IL_06a7: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_06ac: ldarg.0
IL_06ad: ldfld PixelCrushers.DialogueSystem.DialogueDatabase TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::database
IL_06b2: ldloc.0
IL_06b3: ldstr "IDLE"
IL_06b8: ldloc.0
IL_06b9: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::idleArcs
IL_06be: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PopulateDialogueArcs(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Dialogue,System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>)
IL_06c3: ldarg.0
IL_06c4: ldfld TheForestOfLove.Narrative.DialogueSystemLoader TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::<>4__this
IL_06c9: ldarg.0
IL_06ca: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::manifest
IL_06cf: ldarg.0
IL_06d0: ldfld PixelCrushers.DialogueSystem.DialogueDatabase TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass24_0::database
IL_06d5: ldloc.0
IL_06d6: ldstr "NAMED"
IL_06db: ldloc.0
IL_06dc: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc> TheForestOfLove.Narrative.Dialogue::namedArcs
IL_06e1: call System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PopulateDialogueArcs(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Dialogue,System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>)
IL_06e6: ret
