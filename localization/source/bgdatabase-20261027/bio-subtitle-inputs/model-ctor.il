TYPE PixelCrushers.DialogueSystem.ConversationModel
METHOD System.Void PixelCrushers.DialogueSystem.ConversationModel::.ctor(PixelCrushers.DialogueSystem.DialogueDatabase,System.String,UnityEngine.Transform,UnityEngine.Transform,System.Boolean,PixelCrushers.DialogueSystem.IsDialogueEntryValidDelegate,System.Int32,System.Boolean,System.Boolean) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.CharacterInfo>::.ctor()
IL_0006: stfld System.Collections.Generic.Dictionary`2<System.Int32,PixelCrushers.DialogueSystem.CharacterInfo> PixelCrushers.DialogueSystem.ConversationModel::m_characterInfoCache
IL_000b: ldarg.0
IL_000c: ldc.i4.m1
IL_000d: stfld System.Int32 PixelCrushers.DialogueSystem.ConversationModel::m_currentDialogTableConversationID
IL_0012: ldarg.0
IL_0013: call System.Void System.Object::.ctor()
IL_0018: ldarg.0
IL_0019: ldarg.s allowLuaExceptions
IL_001b: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationModel::m_allowLuaExceptions
IL_0020: ldarg.0
IL_0021: ldarg.1
IL_0022: stfld PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.ConversationModel::m_database
IL_0027: ldarg.0
IL_0028: ldarg.s isDialogueEntryValid
IL_002a: call System.Void PixelCrushers.DialogueSystem.ConversationModel::set_isDialogueEntryValid(PixelCrushers.DialogueSystem.IsDialogueEntryValidDelegate)
IL_002f: call PixelCrushers.DialogueSystem.DisplaySettings PixelCrushers.DialogueSystem.DialogueManager::get_displaySettings()
IL_0034: stloc.0
IL_0035: ldloc.0
IL_0036: brfalse.s IL_0087
IL_0038: ldloc.0
IL_0039: ldfld PixelCrushers.DialogueSystem.DisplaySettings/CameraSettings PixelCrushers.DialogueSystem.DisplaySettings::cameraSettings
IL_003e: brfalse.s IL_0051
IL_0040: ldarg.0
IL_0041: ldloc.0
IL_0042: ldfld PixelCrushers.DialogueSystem.DisplaySettings/CameraSettings PixelCrushers.DialogueSystem.DisplaySettings::cameraSettings
IL_0047: ldfld PixelCrushers.DialogueSystem.EntrytagFormat PixelCrushers.DialogueSystem.DisplaySettings/CameraSettings::entrytagFormat
IL_004c: stfld PixelCrushers.DialogueSystem.EntrytagFormat PixelCrushers.DialogueSystem.ConversationModel::m_entrytagFormat
IL_0051: ldloc.0
IL_0052: ldfld PixelCrushers.DialogueSystem.DisplaySettings/InputSettings PixelCrushers.DialogueSystem.DisplaySettings::inputSettings
IL_0057: brfalse.s IL_0087
IL_0059: ldarg.0
IL_005a: ldloc.0
IL_005b: ldfld PixelCrushers.DialogueSystem.DisplaySettings/InputSettings PixelCrushers.DialogueSystem.DisplaySettings::inputSettings
IL_0060: ldfld PixelCrushers.DialogueSystem.EmTag PixelCrushers.DialogueSystem.DisplaySettings/InputSettings::emTagForOldResponses
IL_0065: stfld PixelCrushers.DialogueSystem.EmTag PixelCrushers.DialogueSystem.ConversationModel::m_emTagForOldResponses
IL_006a: ldarg.0
IL_006b: ldloc.0
IL_006c: ldfld PixelCrushers.DialogueSystem.DisplaySettings/InputSettings PixelCrushers.DialogueSystem.DisplaySettings::inputSettings
IL_0071: ldfld PixelCrushers.DialogueSystem.EmTag PixelCrushers.DialogueSystem.DisplaySettings/InputSettings::emTagForInvalidResponses
IL_0076: stfld PixelCrushers.DialogueSystem.EmTag PixelCrushers.DialogueSystem.ConversationModel::m_emTagForInvalidResponses
IL_007b: ldarg.0
IL_007c: ldloc.0
IL_007d: callvirt System.Boolean PixelCrushers.DialogueSystem.DisplaySettings::GetIncludeInvalidEntries()
IL_0082: stfld System.Boolean PixelCrushers.DialogueSystem.ConversationModel::m_includeInvalidEntries
IL_0087: ldarg.1
IL_0088: ldarg.2
IL_0089: callvirt PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)
IL_008e: stloc.1
IL_008f: ldloc.1
IL_0090: brfalse.s IL_00d9
IL_0092: ldarg.0
IL_0093: ldloc.1
IL_0094: ldarg.3
IL_0095: ldarg.s conversant
IL_0097: call System.Void PixelCrushers.DialogueSystem.ConversationModel::SetParticipants(PixelCrushers.DialogueSystem.Conversation,UnityEngine.Transform,UnityEngine.Transform)
IL_009c: ldarg.s initialDialogueEntryID
IL_009e: ldc.i4.m1
IL_009f: bne.un.s IL_00bf
IL_00a1: ldarg.0
IL_00a2: ldarg.0
IL_00a3: ldloc.1
IL_00a4: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetFirstDialogueEntry()
IL_00a9: ldc.i4.1
IL_00aa: ldarg.s stopAtFirstValid
IL_00ac: ldarg.s skipExecution
IL_00ae: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean,System.Boolean,System.Boolean)
IL_00b3: call System.Void PixelCrushers.DialogueSystem.ConversationModel::set_firstState(PixelCrushers.DialogueSystem.ConversationState)
IL_00b8: ldarg.0
IL_00b9: call System.Void PixelCrushers.DialogueSystem.ConversationModel::FixFirstStateSequence()
IL_00be: ret
IL_00bf: ldarg.0
IL_00c0: ldarg.0
IL_00c1: ldloc.1
IL_00c2: ldarg.s initialDialogueEntryID
IL_00c4: callvirt PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.Int32)
IL_00c9: ldc.i4.1
IL_00ca: ldarg.s stopAtFirstValid
IL_00cc: ldarg.s skipExecution
IL_00ce: call PixelCrushers.DialogueSystem.ConversationState PixelCrushers.DialogueSystem.ConversationModel::GetState(PixelCrushers.DialogueSystem.DialogueEntry,System.Boolean,System.Boolean,System.Boolean)
IL_00d3: call System.Void PixelCrushers.DialogueSystem.ConversationModel::set_firstState(PixelCrushers.DialogueSystem.ConversationState)
IL_00d8: ret
IL_00d9: ldarg.0
IL_00da: ldnull
IL_00db: call System.Void PixelCrushers.DialogueSystem.ConversationModel::set_firstState(PixelCrushers.DialogueSystem.ConversationState)
IL_00e0: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logErrors()
IL_00e5: brfalse.s IL_0108
IL_00e7: ldstr "{0}: Conversation '{1}' not found in database."
IL_00ec: ldc.i4.2
IL_00ed: newarr System.Object
IL_00f2: dup
IL_00f3: ldc.i4.0
IL_00f4: ldstr "Dialogue System"
IL_00f9: stelem.ref
IL_00fa: dup
IL_00fb: ldc.i4.1
IL_00fc: ldarg.2
IL_00fd: stelem.ref
IL_00fe: call System.String System.String::Format(System.String,System.Object[])
IL_0103: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0108: ret
