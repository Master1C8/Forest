TYPE PixelCrushers.DialogueSystem.DialogueSystemController
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::StartConversation(System.String,UnityEngine.Transform,UnityEngine.Transform,System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::get_isConversationActive()
IL_0006: brfalse.s IL_001e
IL_0008: ldarg.0
IL_0009: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::allowSimultaneousConversations
IL_000e: brtrue.s IL_001e
IL_0010: ldarg.0
IL_0011: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::interruptActiveConversations
IL_0016: brfalse.s IL_001e
IL_0018: ldarg.0
IL_0019: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::StopConversation()
IL_001e: ldarg.0
IL_001f: call System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::get_isConversationActive()
IL_0024: brfalse.s IL_005a
IL_0026: ldarg.0
IL_0027: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::allowSimultaneousConversations
IL_002c: brtrue.s IL_005a
IL_002e: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_0033: brfalse IL_036d
IL_0038: ldstr "{0}: Another conversation is already active. Not starting '{1}'."
IL_003d: ldc.i4.2
IL_003e: newarr System.Object
IL_0043: dup
IL_0044: ldc.i4.0
IL_0045: ldstr "Dialogue System"
IL_004a: stelem.ref
IL_004b: dup
IL_004c: ldc.i4.1
IL_004d: ldarg.1
IL_004e: stelem.ref
IL_004f: call System.String System.String::Format(System.String,System.Object[])
IL_0054: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0059: ret
IL_005a: ldarg.0
IL_005b: call PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::get_dialogueUI()
IL_0060: brtrue.s IL_008e
IL_0062: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logErrors()
IL_0067: brfalse IL_036d
IL_006c: ldstr "{0}: No Dialogue UI is assigned. Can't start conversation '{1}'."
IL_0071: ldc.i4.2
IL_0072: newarr System.Object
IL_0077: dup
IL_0078: ldc.i4.0
IL_0079: ldstr "Dialogue System"
IL_007e: stelem.ref
IL_007f: dup
IL_0080: ldc.i4.1
IL_0081: ldarg.1
IL_0082: stelem.ref
IL_0083: call System.String System.String::Format(System.String,System.Object[])
IL_0088: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_008d: ret
IL_008e: ldarg.2
IL_008f: ldnull
IL_0090: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0095: brfalse.s IL_00a5
IL_0097: ldarg.0
IL_0098: ldarg.1
IL_0099: ldstr "Actor"
IL_009e: call UnityEngine.Transform PixelCrushers.DialogueSystem.DialogueSystemController::FindActorTransformFromConversation(System.String,System.String)
IL_00a3: starg.s actor
IL_00a5: ldarg.3
IL_00a6: ldnull
IL_00a7: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00ac: brfalse.s IL_00bc
IL_00ae: ldarg.0
IL_00af: ldarg.1
IL_00b0: ldstr "Conversant"
IL_00b5: call UnityEngine.Transform PixelCrushers.DialogueSystem.DialogueSystemController::FindActorTransformFromConversation(System.String,System.String)
IL_00ba: starg.s conversant
IL_00bc: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logInfo()
IL_00c1: brfalse.s IL_00ed
IL_00c3: ldstr "{0}: Starting conversation '{1}', actor={2}, conversant={3}."
IL_00c8: ldc.i4.4
IL_00c9: newarr System.Object
IL_00ce: dup
IL_00cf: ldc.i4.0
IL_00d0: ldstr "Dialogue System"
IL_00d5: stelem.ref
IL_00d6: dup
IL_00d7: ldc.i4.1
IL_00d8: ldarg.1
IL_00d9: stelem.ref
IL_00da: dup
IL_00db: ldc.i4.2
IL_00dc: ldarg.2
IL_00dd: stelem.ref
IL_00de: dup
IL_00df: ldc.i4.3
IL_00e0: ldarg.3
IL_00e1: stelem.ref
IL_00e2: call System.String System.String::Format(System.String,System.Object[])
IL_00e7: ldarg.2
IL_00e8: call System.Void UnityEngine.Debug::Log(System.Object,UnityEngine.Object)
IL_00ed: ldarg.0
IL_00ee: call System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::get_warnIfActorAndConversantSame()
IL_00f3: brfalse.s IL_012b
IL_00f5: ldarg.2
IL_00f6: ldnull
IL_00f7: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00fc: brfalse.s IL_012b
IL_00fe: ldarg.2
IL_00ff: ldarg.3
IL_0100: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0105: brfalse.s IL_012b
IL_0107: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_010c: brfalse.s IL_012b
IL_010e: ldstr "{0}: Actor and conversant are the same GameObject."
IL_0113: ldc.i4.1
IL_0114: newarr System.Object
IL_0119: dup
IL_011a: ldc.i4.0
IL_011b: ldstr "Dialogue System"
IL_0120: stelem.ref
IL_0121: call System.String System.String::Format(System.String,System.Object[])
IL_0126: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_012b: ldarg.0
IL_012c: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::CheckDebugLevel()
IL_0131: ldarg.0
IL_0132: ldarg.2
IL_0133: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_currentActor(UnityEngine.Transform)
IL_0138: ldarg.0
IL_0139: ldarg.3
IL_013a: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_currentConversant(UnityEngine.Transform)
IL_013f: ldarg.0
IL_0140: ldarg.1
IL_0141: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_lastConversationStarted(System.String)
IL_0146: ldarg.0
IL_0147: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::m_overrodeDisplaySettings
IL_014c: brfalse.s IL_0156
IL_014e: ldarg.0
IL_014f: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::m_originalDisplaySettings
IL_0154: brtrue.s IL_015e
IL_0156: ldarg.0
IL_0157: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::m_originalDialogueUI
IL_015c: brfalse.s IL_0164
IL_015e: ldarg.0
IL_015f: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::RestoreOriginalUI()
IL_0164: ldarg.0
IL_0165: ldarg.2
IL_0166: ldarg.3
IL_0167: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::SetConversationUI(UnityEngine.Transform,UnityEngine.Transform)
IL_016c: ldarg.0
IL_016d: ldc.i4.0
IL_016e: stfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::m_calledRandomizeNextEntry
IL_0173: ldarg.0
IL_0174: newobj System.Void PixelCrushers.DialogueSystem.ConversationController::.ctor()
IL_0179: stfld PixelCrushers.DialogueSystem.ConversationController PixelCrushers.DialogueSystem.DialogueSystemController::m_conversationController
IL_017e: ldarg.0
IL_017f: ldfld PixelCrushers.DialogueSystem.DatabaseManager PixelCrushers.DialogueSystem.DialogueSystemController::m_databaseManager
IL_0184: callvirt PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseManager::get_masterDatabase()
IL_0189: ldarg.1
IL_018a: ldarg.2
IL_018b: ldarg.3
IL_018c: ldarg.0
IL_018d: call System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::get_allowLuaExceptions()
IL_0192: ldarg.0
IL_0193: call PixelCrushers.DialogueSystem.IsDialogueEntryValidDelegate PixelCrushers.DialogueSystem.DialogueSystemController::get_isDialogueEntryValid()
IL_0198: ldarg.s initialDialogueEntryID
IL_019a: ldc.i4.0
IL_019b: ldc.i4.0
IL_019c: newobj System.Void PixelCrushers.DialogueSystem.ConversationModel::.ctor(PixelCrushers.DialogueSystem.DialogueDatabase,System.String,UnityEngine.Transform,UnityEngine.Transform,System.Boolean,PixelCrushers.DialogueSystem.IsDialogueEntryValidDelegate,System.Int32,System.Boolean,System.Boolean)
IL_01a1: stloc.0
IL_01a2: ldarg.0
IL_01a3: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::m_calledRandomizeNextEntry
IL_01a8: stloc.1
IL_01a9: ldarg.0
IL_01aa: ldc.i4.0
IL_01ab: stfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::m_calledRandomizeNextEntry
IL_01b0: ldloc.0
IL_01b1: callvirt System.Boolean PixelCrushers.DialogueSystem.ConversationModel::get_hasValidEntry()
IL_01b6: brtrue.s IL_01b9
IL_01b8: ret
IL_01b9: ldloc.0
IL_01ba: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_01bf: brfalse IL_0255
IL_01c4: ldloc.0
IL_01c5: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_01ca: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_01cf: brfalse IL_0255
IL_01d4: ldloc.0
IL_01d5: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_01da: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_01df: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_01e4: brfalse.s IL_0255
IL_01e6: ldarg.0
IL_01e7: ldloc.0
IL_01e8: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_01ed: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_01f2: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_01f7: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_01fc: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_lastConversationID(System.Int32)
IL_0201: ldloc.0
IL_0202: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_0207: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_020c: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0211: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueEntry::isGroup
IL_0216: brfalse.s IL_0255
IL_0218: ldloc.0
IL_0219: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_021e: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_0223: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0228: ldsfld System.String System.String::Empty
IL_022d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0232: brfalse.s IL_0255
IL_0234: ldloc.0
IL_0235: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_023a: ldc.i4.0
IL_023b: callvirt System.Void PixelCrushers.DialogueSystem.ConversationState::set_isGroup(System.Boolean)
IL_0240: ldloc.0
IL_0241: callvirt PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::get_firstState()
IL_0246: ldfld PixelCrushers.DialogueSystem.Subtitle PixelCrushers.DialogueSystem.ConversationState::subtitle
IL_024b: ldstr "Continue()"
IL_0250: stfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0255: ldarg.0
IL_0256: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_025b: callvirt !!0 UnityEngine.GameObject::AddComponent<PixelCrushers.DialogueSystem.ConversationView>()
IL_0260: stloc.2
IL_0261: ldloc.2
IL_0262: ldarg.0
IL_0263: call PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::get_dialogueUI()
IL_0268: ldarg.0
IL_0269: call PixelCrushers.DialogueSystem.Sequencer PixelCrushers.DialogueSystem.DialogueSystemController::GetNewSequencer()
IL_026e: ldarg.0
IL_026f: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_0274: ldarg.0
IL_0275: ldftn System.Void PixelCrushers.DialogueSystem.DialogueSystemController::OnDialogueEntrySpoken(PixelCrushers.DialogueSystem.Subtitle)
IL_027b: newobj System.Void PixelCrushers.DialogueSystem.DialogueEntrySpokenDelegate::.ctor(System.Object,System.IntPtr)
IL_0280: callvirt System.Void PixelCrushers.DialogueSystem.ConversationView::Initialize(PixelCrushers.DialogueSystem.IDialogueUI,PixelCrushers.DialogueSystem.Sequencer,PixelCrushers.DialogueSystem.DisplaySettings,PixelCrushers.DialogueSystem.DialogueEntrySpokenDelegate)
IL_0285: ldloc.2
IL_0286: ldloc.0
IL_0287: callvirt UnityEngine.Sprite PixelCrushers.DialogueSystem.ConversationModel::GetPCSprite()
IL_028c: ldloc.0
IL_028d: callvirt System.String PixelCrushers.DialogueSystem.ConversationModel::GetPCName()
IL_0292: callvirt System.Void PixelCrushers.DialogueSystem.ConversationView::SetPCPortrait(UnityEngine.Sprite,System.String)
IL_0297: ldarg.0
IL_0298: ldfld PixelCrushers.DialogueSystem.ConversationController PixelCrushers.DialogueSystem.DialogueSystemController::m_conversationController
IL_029d: ldloc.0
IL_029e: ldloc.2
IL_029f: ldarg.0
IL_02a0: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::displaySettings
IL_02a5: ldfld PixelCrushers.DialogueSystem.DisplaySettings/InputSettings PixelCrushers.DialogueSystem.DisplaySettings::inputSettings
IL_02aa: ldfld System.Boolean PixelCrushers.DialogueSystem.DisplaySettings/InputSettings::alwaysForceResponseMenu
IL_02af: ldarg.0
IL_02b0: ldftn System.Void PixelCrushers.DialogueSystem.DialogueSystemController::OnEndConversation(PixelCrushers.DialogueSystem.ConversationController)
IL_02b6: newobj System.Void PixelCrushers.DialogueSystem.ConversationController/EndConversationDelegate::.ctor(System.Object,System.IntPtr)
IL_02bb: callvirt System.Void PixelCrushers.DialogueSystem.ConversationController::Initialize(PixelCrushers.DialogueSystem.ConversationModel,PixelCrushers.DialogueSystem.ConversationView,System.Boolean,PixelCrushers.DialogueSystem.ConversationController/EndConversationDelegate)
IL_02c0: ldloc.1
IL_02c1: brfalse.s IL_02c9
IL_02c3: ldarg.0
IL_02c4: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::RandomizeNextEntry()
IL_02c9: newobj System.Void PixelCrushers.DialogueSystem.ActiveConversationRecord::.ctor()
IL_02ce: stloc.3
IL_02cf: ldloc.3
IL_02d0: ldarg.2
IL_02d1: callvirt System.Void PixelCrushers.DialogueSystem.ActiveConversationRecord::set_actor(UnityEngine.Transform)
IL_02d6: ldloc.3
IL_02d7: ldarg.3
IL_02d8: callvirt System.Void PixelCrushers.DialogueSystem.ActiveConversationRecord::set_conversant(UnityEngine.Transform)
IL_02dd: ldloc.3
IL_02de: ldarg.0
IL_02df: ldfld PixelCrushers.DialogueSystem.ConversationController PixelCrushers.DialogueSystem.DialogueSystemController::m_conversationController
IL_02e4: callvirt System.Void PixelCrushers.DialogueSystem.ActiveConversationRecord::set_conversationController(PixelCrushers.DialogueSystem.ConversationController)
IL_02e9: ldloc.3
IL_02ea: callvirt PixelCrushers.DialogueSystem.ConversationController PixelCrushers.DialogueSystem.ActiveConversationRecord::get_conversationController()
IL_02ef: ldloc.3
IL_02f0: callvirt System.Void PixelCrushers.DialogueSystem.ConversationController::set_activeConversationRecord(PixelCrushers.DialogueSystem.ActiveConversationRecord)
IL_02f5: ldloc.3
IL_02f6: ldarg.0
IL_02f7: ldfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.DialogueSystemController::m_originalDialogueUI
IL_02fc: stfld PixelCrushers.DialogueSystem.IDialogueUI PixelCrushers.DialogueSystem.ActiveConversationRecord::originalDialogueUI
IL_0301: ldloc.3
IL_0302: ldarg.0
IL_0303: ldfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueSystemController::m_originalDisplaySettings
IL_0308: stfld PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.ActiveConversationRecord::originalDisplaySettings
IL_030d: ldloc.3
IL_030e: ldarg.0
IL_030f: ldfld System.Boolean PixelCrushers.DialogueSystem.DialogueSystemController::m_isOverrideUIPrefab
IL_0314: stfld System.Boolean PixelCrushers.DialogueSystem.ActiveConversationRecord::isOverrideUIPrefab
IL_0319: ldarg.0
IL_031a: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord> PixelCrushers.DialogueSystem.DialogueSystemController::m_activeConversations
IL_031f: ldloc.3
IL_0320: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.ActiveConversationRecord>::Add(!0)
IL_0325: ldarg.0
IL_0326: ldloc.3
IL_0327: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::set_activeConversation(PixelCrushers.DialogueSystem.ActiveConversationRecord)
IL_032c: ldloc.2
IL_032d: callvirt PixelCrushers.DialogueSystem.Sequencer PixelCrushers.DialogueSystem.ConversationView::get_sequencer()
IL_0332: ldloc.3
IL_0333: callvirt System.Void PixelCrushers.DialogueSystem.Sequencer::set_activeConversationRecord(PixelCrushers.DialogueSystem.ActiveConversationRecord)
IL_0338: ldarg.2
IL_0339: ldnull
IL_033a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_033f: brtrue.s IL_0349
IL_0341: ldarg.0
IL_0342: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0347: br.s IL_034a
IL_0349: ldarg.2
IL_034a: stloc.s V_4
IL_034c: ldarg.2
IL_034d: ldarg.0
IL_034e: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0353: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0358: brfalse.s IL_036d
IL_035a: ldarg.0
IL_035b: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0360: ldstr "OnConversationStart"
IL_0365: ldloc.s V_4
IL_0367: ldc.i4.1
IL_0368: callvirt System.Void UnityEngine.GameObject::BroadcastMessage(System.String,System.Object,UnityEngine.SendMessageOptions)
IL_036d: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::StartConversation(System.String,UnityEngine.Transform,UnityEngine.Transform) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: ldarg.3
IL_0004: ldc.i4.m1
IL_0005: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::StartConversation(System.String,UnityEngine.Transform,UnityEngine.Transform,System.Int32)
IL_000a: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::StartConversation(System.String,UnityEngine.Transform) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldarg.2
IL_0003: ldnull
IL_0004: ldc.i4.m1
IL_0005: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::StartConversation(System.String,UnityEngine.Transform,UnityEngine.Transform,System.Int32)
IL_000a: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::StartConversation(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldnull
IL_0003: ldnull
IL_0004: ldc.i4.m1
IL_0005: call System.Void PixelCrushers.DialogueSystem.DialogueSystemController::StartConversation(System.String,UnityEngine.Transform,UnityEngine.Transform,System.Int32)
IL_000a: ret
