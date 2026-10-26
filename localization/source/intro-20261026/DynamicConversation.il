TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0000: ldsfld System.String TheForestOfLove.Narrative.DialogueService::<CurrentDialogueDbName>k__BackingField
IL_0005: ret
METHOD System.String TheForestOfLove.Narrative.DialogueService::get_CurrentArcName()
IL_0000: ldsfld System.String TheForestOfLove.Narrative.DialogueService::<CurrentArcName>k__BackingField
IL_0005: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(BOC.BTagged.Tag,BOC.BTagged.Tag)
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_0007: ldarg.2
IL_0008: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_000d: call System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String,System.String)
IL_0012: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String)
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldnull
IL_0003: call System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String,System.String)
IL_0008: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String,System.String)
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldc.i4.0
IL_0003: stloc.1
IL_0004: ldarg.1
IL_0005: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String)
IL_000a: stloc.2
IL_000b: ldloc.2
IL_000c: brfalse IL_017c
IL_0011: ldarg.0
IL_0012: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_0017: ldstr "system/dynamicConversation"
IL_001c: stfld System.String PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversation
IL_0021: ldarg.2
IL_0022: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0027: brtrue.s IL_007e
IL_0029: ldloc.2
IL_002a: ldarg.2
IL_002b: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetArcByName(System.String)
IL_0030: stloc.s V_6
IL_0032: ldloc.s V_6
IL_0034: brtrue.s IL_0053
IL_0036: ldloc.2
IL_0037: ldarg.2
IL_0038: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetArcByGeneratedName(System.String)
IL_003d: stloc.s V_6
IL_003f: ldc.i4.1
IL_0040: stloc.0
IL_0041: ldloc.s V_6
IL_0043: ldfld System.String TheForestOfLove.Narrative.Arc::pluginDbSuffix
IL_0048: ldstr "p1"
IL_004d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0052: stloc.1
IL_0053: ldloc.s V_6
IL_0055: brtrue.s IL_006e
IL_0057: ldstr "dialogue "
IL_005c: ldarg.1
IL_005d: ldstr " could not find arc "
IL_0062: ldarg.2
IL_0063: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0068: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_006d: ret
IL_006e: ldarg.0
IL_006f: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::arcListCache
IL_0074: ldloc.s V_6
IL_0076: ldloc.2
IL_0077: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::Add(!0,!1)
IL_007c: br.s IL_00c6
IL_007e: ldloc.2
IL_007f: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetFirstPrimaryArc()
IL_0084: stloc.s V_6
IL_0086: ldloc.s V_6
IL_0088: brtrue.s IL_0092
IL_008a: ldloc.2
IL_008b: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetFirstIdleArc()
IL_0090: stloc.s V_6
IL_0092: ldloc.s V_6
IL_0094: brtrue.s IL_009e
IL_0096: ldloc.2
IL_0097: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetFirstNamedArc()
IL_009c: stloc.s V_6
IL_009e: ldloc.s V_6
IL_00a0: brtrue.s IL_00b8
IL_00a2: ldstr "dialogue "
IL_00a7: ldarg.1
IL_00a8: ldstr " found no arc to play"
IL_00ad: call System.String System.String::Concat(System.String,System.String,System.String)
IL_00b2: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_00b7: ret
IL_00b8: ldarg.0
IL_00b9: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::arcListCache
IL_00be: ldloc.s V_6
IL_00c0: ldloc.2
IL_00c1: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::Add(!0,!1)
IL_00c6: ldc.i4.0
IL_00c7: stloc.s V_7
IL_00c9: ldloc.2
IL_00ca: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_00cf: ldc.i4 400
IL_00d4: bne.un.s IL_00f6
IL_00d6: ldarg.2
IL_00d7: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_00dc: brfalse.s IL_00e4
IL_00de: ldloc.0
IL_00df: ldc.i4.0
IL_00e0: ceq
IL_00e2: br.s IL_00e5
IL_00e4: ldc.i4.0
IL_00e5: ldloc.1
IL_00e6: or
IL_00e7: brfalse.s IL_00f6
IL_00e9: ldc.i4.1
IL_00ea: stloc.s V_7
IL_00ec: call System.Boolean Globals::get_DevCommandActive()
IL_00f1: brfalse.s IL_00f6
IL_00f3: ldc.i4.0
IL_00f4: stloc.s V_7
IL_00f6: ldloc.2
IL_00f7: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00fc: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogueDbName(System.String)
IL_0101: ldloc.2
IL_0102: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogue(TheForestOfLove.Narrative.Dialogue)
IL_0107: ldloc.2
IL_0108: ldfld System.String TheForestOfLove.Narrative.Dialogue::pluginDbName
IL_010d: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialoguePluginDbName(System.String)
IL_0112: ldloc.s V_6
IL_0114: ldfld System.String TheForestOfLove.Narrative.Arc::customName
IL_0119: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArcName(System.String)
IL_011e: ldloc.s V_6
IL_0120: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArc(TheForestOfLove.Narrative.Arc)
IL_0125: ldloc.2
IL_0126: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_012b: call System.Void TheForestOfLove.Narrative.DialogueService::set_PrimaryActor(TheForestOfLove.Narrative.Actor)
IL_0130: ldloc.2
IL_0131: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::initialActor
IL_0136: call System.Void TheForestOfLove.Narrative.DialogueService::set_InitialActor(TheForestOfLove.Narrative.Actor)
IL_013b: ldloc.2
IL_013c: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::initialActor
IL_0141: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentActor(TheForestOfLove.Narrative.Actor)
IL_0146: ldarg.0
IL_0147: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_014c: ldnull
IL_014d: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::Fire(UnityEngine.Transform)
IL_0152: ldarg.0
IL_0153: ldarg.0
IL_0154: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::arcListCache
IL_0159: callvirt System.Collections.Generic.Dictionary`2/KeyCollection<!0,!1> System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::get_Keys()
IL_015e: ldc.i4.0
IL_015f: call TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::get_PrimaryActor()
IL_0164: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0169: ldloc.s V_7
IL_016b: call System.Void TheForestOfLove.Narrative.DialogueService::BuildDynamicConversation(System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>,System.Boolean,System.String,System.Boolean)
IL_0170: ldarg.0
IL_0171: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_0176: call System.Void TheForestOfLove.Narrative.DialogueService::LogPlayedDialogue(System.String)
IL_017b: ret
IL_017c: call PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueManager::get_databaseManager()
IL_0181: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_0186: stloc.3
IL_0187: ldloc.3
IL_0188: ldnull
IL_0189: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_018e: brfalse.s IL_01a6
IL_0190: ldstr "dialogue "
IL_0195: ldarg.1
IL_0196: ldstr " could not read dialogue db"
IL_019b: call System.String System.String::Concat(System.String,System.String,System.String)
IL_01a0: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_01a5: ret
IL_01a6: ldloc.3
IL_01a7: ldarg.1
IL_01a8: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_01ad: stloc.s V_4
IL_01af: ldloc.s V_4
IL_01b1: brtrue.s IL_01c9
IL_01b3: ldstr "dialogue "
IL_01b8: ldarg.1
IL_01b9: ldstr " could not find dialogue db conversation"
IL_01be: call System.String System.String::Concat(System.String,System.String,System.String)
IL_01c3: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_01c8: ret
IL_01c9: ldloc.3
IL_01ca: ldloc.s V_4
IL_01cc: callvirt System.Int32 PixelCrushers.DialogueSystem.Conversation::get_ConversantID()
IL_01d1: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_01d6: stloc.s V_5
IL_01d8: ldloc.s V_5
IL_01da: brtrue.s IL_01f2
IL_01dc: ldstr "dialogue "
IL_01e1: ldarg.1
IL_01e2: ldstr " could not find dialogue db actor"
IL_01e7: call System.String System.String::Concat(System.String,System.String,System.String)
IL_01ec: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_01f1: ret
IL_01f2: ldnull
IL_01f3: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogueDbName(System.String)
IL_01f8: ldnull
IL_01f9: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogue(TheForestOfLove.Narrative.Dialogue)
IL_01fe: ldloc.s V_4
IL_0200: callvirt System.String PixelCrushers.DialogueSystem.Conversation::get_Title()
IL_0205: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialoguePluginDbName(System.String)
IL_020a: ldnull
IL_020b: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArcName(System.String)
IL_0210: ldnull
IL_0211: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArc(TheForestOfLove.Narrative.Arc)
IL_0216: ldloc.s V_5
IL_0218: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_021d: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByPluginDbId(System.Int32)
IL_0222: call System.Void TheForestOfLove.Narrative.DialogueService::set_PrimaryActor(TheForestOfLove.Narrative.Actor)
IL_0227: call TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::get_PrimaryActor()
IL_022c: call System.Void TheForestOfLove.Narrative.DialogueService::set_InitialActor(TheForestOfLove.Narrative.Actor)
IL_0231: call TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::get_PrimaryActor()
IL_0236: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentActor(TheForestOfLove.Narrative.Actor)
IL_023b: ldarg.0
IL_023c: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_0241: ldnull
IL_0242: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::Fire(UnityEngine.Transform)
IL_0247: ldarg.0
IL_0248: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_024d: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialoguePluginDbName()
IL_0252: stfld System.String PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversation
IL_0257: ldarg.0
IL_0258: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialoguePluginDbName()
IL_025d: call System.Void TheForestOfLove.Narrative.DialogueService::LogPlayedDialogue(System.String)
IL_0262: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnLinkedConversationStart(UnityEngine.Transform)
IL_0000: call System.Boolean TheForestOfLove.Narrative.DialogueService::get_IsPlayerQuestionDialoguePlaying()
IL_0005: brfalse IL_014d
IL_000a: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.DialogueSystemController>()
IL_000f: stloc.0
IL_0010: ldloc.0
IL_0011: callvirt System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord> PixelCrushers.DialogueSystem.DialogueSystemController::get_activeConversations()
IL_0016: ldc.i4.0
IL_0017: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord>::get_Item(System.Int32)
IL_001c: callvirt PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ActiveConversationRecord::get_ConversationModel()
IL_0021: ldloc.0
IL_0022: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.DialogueSystemController::get_CurrentConversationState()
IL_0027: callvirt System.Int32 PixelCrushers.DialogueSystem.ConversationModel::GetConversationID(PixelCrushers.DialogueSystem.ConversationState)
IL_002c: stloc.1
IL_002d: call PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueManager::get_databaseManager()
IL_0032: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_0037: ldloc.1
IL_0038: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.Int32)
IL_003d: callvirt System.String PixelCrushers.DialogueSystem.Conversation::get_Title()
IL_0042: stloc.2
IL_0043: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0048: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_004d: ldc.i4 700
IL_0052: bne.un.s IL_0074
IL_0054: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0059: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_005e: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0063: ldloc.1
IL_0064: beq.s IL_0073
IL_0066: ldloc.2
IL_0067: ldstr "system/dynamicConversation"
IL_006c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0071: brfalse.s IL_0074
IL_0073: ret
IL_0074: ldc.i4.0
IL_0075: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsPlayerQuestionDialoguePlaying(System.Boolean)
IL_007a: ldarg.0
IL_007b: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::arcListCache
IL_0080: callvirt System.Collections.Generic.Dictionary`2/ValueCollection<!0,!1> System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::get_Values()
IL_0085: callvirt System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<!0,!1> System.Collections.Generic.Dictionary`2/ValueCollection<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_008a: stloc.3
IL_008b: br IL_0117
IL_0090: ldloca.s V_3
IL_0092: call !1 System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0097: stloc.s V_4
IL_0099: ldloc.s V_4
IL_009b: ldfld PixelCrushers.DialogueSystem.Conversation TheForestOfLove.Narrative.Dialogue::pluginDbConversation
IL_00a0: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00a5: ldloc.1
IL_00a6: bne.un.s IL_0117
IL_00a8: ldloc.s V_4
IL_00aa: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_00af: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogueDbName(System.String)
IL_00b4: ldloc.s V_4
IL_00b6: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogue(TheForestOfLove.Narrative.Dialogue)
IL_00bb: ldloc.s V_4
IL_00bd: ldfld System.String TheForestOfLove.Narrative.Dialogue::pluginDbName
IL_00c2: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialoguePluginDbName(System.String)
IL_00c7: ldloc.s V_4
IL_00c9: callvirt TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.Dialogue::GetFirstPrimaryArc()
IL_00ce: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArc(TheForestOfLove.Narrative.Arc)
IL_00d3: call TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.DialogueService::get_CurrentArc()
IL_00d8: ldfld System.String TheForestOfLove.Narrative.Arc::customName
IL_00dd: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArcName(System.String)
IL_00e2: ldloc.s V_4
IL_00e4: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::primaryActor
IL_00e9: call System.Void TheForestOfLove.Narrative.DialogueService::set_PrimaryActor(TheForestOfLove.Narrative.Actor)
IL_00ee: ldloc.s V_4
IL_00f0: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::initialActor
IL_00f5: call System.Void TheForestOfLove.Narrative.DialogueService::set_InitialActor(TheForestOfLove.Narrative.Actor)
IL_00fa: ldloc.s V_4
IL_00fc: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::initialActor
IL_0101: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentActor(TheForestOfLove.Narrative.Actor)
IL_0106: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onLinkedDialogueStart
IL_010b: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0110: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_0115: leave.s IL_014d
IL_0117: ldloca.s V_3
IL_0119: call System.Boolean System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::MoveNext()
IL_011e: brtrue IL_0090
IL_0123: leave.s IL_0133
IL_0125: ldloca.s V_3
IL_0127: constrained. System.Collections.Generic.Dictionary`2/ValueCollection/Enumerator<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>
IL_012d: callvirt System.Void System.IDisposable::Dispose()
IL_0132: endfinally
IL_0133: ldstr "player selected an untracked question "
IL_0138: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_013d: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0142: call System.String System.String::Concat(System.String,System.String)
IL_0147: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_014c: ret
IL_014d: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::BuildDynamicConversation(System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>,System.Boolean,System.String,System.Boolean)
IL_0000: call !!0 UnityEngine.Object::FindObjectOfType<PixelCrushers.DialogueSystem.DialogueSystemController>()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: callvirt System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::get_IsConversationActive()
IL_000c: brtrue.s IL_000f
IL_000e: ret
IL_000f: ldloc.0
IL_0010: callvirt System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord> PixelCrushers.DialogueSystem.DialogueSystemController::get_activeConversations()
IL_0015: ldc.i4.0
IL_0016: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord>::get_Item(System.Int32)
IL_001b: stloc.1
IL_001c: ldloc.0
IL_001d: callvirt PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::get_databaseManager()
IL_0022: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_defaultDatabase()
IL_0027: stloc.2
IL_0028: ldloc.2
IL_0029: ldstr "system/dynamicConversation"
IL_002e: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_0033: stloc.3
IL_0034: ldloc.3
IL_0035: ldstr "PASSTHROUGH"
IL_003a: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_003f: stloc.s V_4
IL_0041: ldloc.3
IL_0042: ldstr "DYNAMICROOT"
IL_0047: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_004c: stloc.s V_5
IL_004e: ldloc.3
IL_004f: ldstr "DYNAMICQUESTIONS"
IL_0054: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_0059: stloc.s V_6
IL_005b: ldloc.3
IL_005c: ldstr "GENERICFAREWELL"
IL_0061: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)
IL_0066: stloc.s V_7
IL_0068: ldloc.s V_6
IL_006a: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_006f: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Clear()
IL_0074: ldloc.s V_5
IL_0076: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_007b: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Clear()
IL_0080: ldarg.2
IL_0081: brfalse IL_016c
IL_0086: ldarg.3
IL_0087: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_008c: stloc.s V_8
IL_008e: ldloc.2
IL_008f: ldstr "system/dynamicQuestions/{0}"
IL_0094: ldloc.s V_8
IL_0096: ldfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_009b: call System.String System.String::Format(System.String,System.Object)
IL_00a0: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_00a5: stloc.s V_9
IL_00a7: ldloc.s V_9
IL_00a9: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetFirstDialogueEntry()
IL_00ae: stloc.s V_10
IL_00b0: ldloc.s V_5
IL_00b2: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00b7: ldloc.3
IL_00b8: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00bd: ldloc.s V_5
IL_00bf: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00c4: ldloc.s V_9
IL_00c6: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00cb: ldloc.s V_10
IL_00cd: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_00d2: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_00d7: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_00dc: ldarg.1
IL_00dd: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_00e2: stloc.s V_11
IL_00e4: br.s IL_0125
IL_00e6: ldloc.s V_11
IL_00e8: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Arc>::get_Current()
IL_00ed: stloc.s V_12
IL_00ef: ldloc.s V_6
IL_00f1: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_00f6: ldloc.3
IL_00f7: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_00fc: ldloc.s V_6
IL_00fe: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0103: ldloc.s V_12
IL_0105: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_010a: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_010f: ldloc.s V_12
IL_0111: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0116: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_011b: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0120: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_0125: ldloc.s V_11
IL_0127: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_012c: brtrue.s IL_00e6
IL_012e: leave.s IL_013c
IL_0130: ldloc.s V_11
IL_0132: brfalse.s IL_013b
IL_0134: ldloc.s V_11
IL_0136: callvirt System.Void System.IDisposable::Dispose()
IL_013b: endfinally
IL_013c: ldloc.s V_6
IL_013e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0143: ldloc.3
IL_0144: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0149: ldloc.s V_6
IL_014b: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0150: ldloc.3
IL_0151: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0156: ldloc.s V_7
IL_0158: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_015d: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0162: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_0167: br IL_0290
IL_016c: ldarg.1
IL_016d: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>::GetEnumerator()
IL_0172: stloc.s V_11
IL_0174: br IL_0276
IL_0179: ldloc.s V_11
IL_017b: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Arc>::get_Current()
IL_0180: stloc.s V_13
IL_0182: ldloc.s V_13
IL_0184: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0189: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_018e: stloc.s V_14
IL_0190: ldarg.s skipPlayerQuestion
IL_0192: brfalse IL_024a
IL_0197: ldloc.2
IL_0198: ldloc.s V_13
IL_019a: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_019f: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_01a4: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.Int32)
IL_01a9: stloc.s V_15
IL_01ab: ldloc.s V_15
IL_01ad: ldloc.s V_13
IL_01af: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01b4: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_01b9: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_01be: stloc.s V_16
IL_01c0: ldloc.s V_13
IL_01c2: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_01c7: brfalse.s IL_01d2
IL_01c9: ldloc.s V_13
IL_01cb: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_01d0: stloc.s V_16
IL_01d2: ldloc.s V_13
IL_01d4: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01d9: ldloc.s V_13
IL_01db: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstPlayerQuestionDialogueEntry
IL_01e0: beq.s IL_020c
IL_01e2: ldarg.0
IL_01e3: ldloc.s V_13
IL_01e5: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01ea: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_01ef: ldloc.s V_13
IL_01f1: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_01f6: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_01fb: ldloc.s V_13
IL_01fd: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0202: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_subtitleText()
IL_0207: call System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineEnd(System.Int32,System.Int32,System.String)
IL_020c: ldloc.2
IL_020d: ldloc.s V_16
IL_020f: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_0214: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32)
IL_0219: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_021e: ldstr "player"
IL_0223: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0228: brfalse.s IL_024a
IL_022a: ldloc.s V_15
IL_022c: ldloc.s V_16
IL_022e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0233: ldc.i4.0
IL_0234: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::get_Item(System.Int32)
IL_0239: ldfld System.Int32 PixelCrushers.DialogueSystem.Link::destinationDialogueID
IL_023e: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_0243: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_0248: stloc.s V_14
IL_024a: ldloc.s V_5
IL_024c: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link> PixelCrushers.DialogueSystem.DialogueEntry::outgoingLinks
IL_0251: ldloc.3
IL_0252: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0257: ldloc.s V_5
IL_0259: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_025e: ldloc.s V_13
IL_0260: ldfld PixelCrushers.DialogueSystem.DialogueEntry TheForestOfLove.Narrative.Arc::pluginDbFirstDialogueEntry
IL_0265: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_026a: ldloc.s V_14
IL_026c: newobj System.Void PixelCrushers.DialogueSystem.Link::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0271: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Link>::Add(!0)
IL_0276: ldloc.s V_11
IL_0278: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_027d: brtrue IL_0179
IL_0282: leave.s IL_0290
IL_0284: ldloc.s V_11
IL_0286: brfalse.s IL_028f
IL_0288: ldloc.s V_11
IL_028a: callvirt System.Void System.IDisposable::Dispose()
IL_028f: endfinally
IL_0290: ldloc.1
IL_0291: callvirt PixelCrushers.DialogueSystem.ConversationModel PixelCrushers.DialogueSystem.ActiveConversationRecord::get_conversationModel()
IL_0296: ldloc.s V_4
IL_0298: callvirt System.Void PixelCrushers.DialogueSystem.ConversationModel::ForceNextStateToLinkToEntry(PixelCrushers.DialogueSystem.DialogueEntry)
IL_029d: ret
