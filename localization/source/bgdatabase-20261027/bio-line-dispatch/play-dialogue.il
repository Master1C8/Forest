TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(BOC.BTagged.Tag,BOC.BTagged.Tag) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_0007: ldarg.2
IL_0008: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_000d: call System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String,System.String)
IL_0012: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldnull
IL_0003: call System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String,System.String)
IL_0008: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::PlayDialogue(System.String,System.String) | attributes=Public, HideBySig | impl=IL
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
METHOD System.Void TheForestOfLove.Narrative.DialogueService::PlayDialoguePlayerQuestion(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::arcListCache
IL_0006: callvirt System.Int32 System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::get_Count()
IL_000b: brtrue.s IL_0018
IL_000d: ldstr "no player questions added"
IL_0012: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0017: ret
IL_0018: ldarg.1
IL_0019: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Services.Persistence.DataService::GetDialogueByDbName(System.String)
IL_001e: stloc.0
IL_001f: ldloc.0
IL_0020: brtrue.s IL_0033
IL_0022: ldstr "cannot find player questions dialogue "
IL_0027: ldarg.1
IL_0028: call System.String System.String::Concat(System.String,System.String)
IL_002d: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0032: ret
IL_0033: ldloc.0
IL_0034: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.Dialogue::initialActor
IL_0039: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_003e: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0043: stloc.1
IL_0044: ldloc.0
IL_0045: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_004a: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogueDbName(System.String)
IL_004f: ldloc.0
IL_0050: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogue(TheForestOfLove.Narrative.Dialogue)
IL_0055: ldloc.0
IL_0056: ldfld System.String TheForestOfLove.Narrative.Dialogue::pluginDbName
IL_005b: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialoguePluginDbName(System.String)
IL_0060: ldnull
IL_0061: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArcName(System.String)
IL_0066: ldnull
IL_0067: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArc(TheForestOfLove.Narrative.Arc)
IL_006c: ldloc.1
IL_006d: call System.Void TheForestOfLove.Narrative.DialogueService::set_PrimaryActor(TheForestOfLove.Narrative.Actor)
IL_0072: call TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::get_PrimaryActor()
IL_0077: call System.Void TheForestOfLove.Narrative.DialogueService::set_InitialActor(TheForestOfLove.Narrative.Actor)
IL_007c: call TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::get_PrimaryActor()
IL_0081: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentActor(TheForestOfLove.Narrative.Actor)
IL_0086: ldc.i4.1
IL_0087: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsPlayerQuestionDialoguePlaying(System.Boolean)
IL_008c: ldarg.0
IL_008d: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_0092: ldstr "system/dynamicConversation"
IL_0097: stfld System.String PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversation
IL_009c: ldarg.0
IL_009d: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_00a2: ldnull
IL_00a3: callvirt System.Void PixelCrushers.DialogueSystem.DialogueSystemTrigger::Fire(UnityEngine.Transform)
IL_00a8: ldarg.0
IL_00a9: ldarg.0
IL_00aa: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::arcListCache
IL_00af: callvirt System.Collections.Generic.Dictionary`2/KeyCollection<!0,!1> System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::get_Keys()
IL_00b4: ldc.i4.1
IL_00b5: call TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::get_PrimaryActor()
IL_00ba: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00bf: ldc.i4.0
IL_00c0: call System.Void TheForestOfLove.Narrative.DialogueService::BuildDynamicConversation(System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Arc>,System.Boolean,System.String,System.Boolean)
IL_00c5: ldarg.0
IL_00c6: call System.String TheForestOfLove.Narrative.DialogueService::get_CurrentDialogueDbName()
IL_00cb: call System.Void TheForestOfLove.Narrative.DialogueService::LogPlayedDialogue(System.String)
IL_00d0: ret
