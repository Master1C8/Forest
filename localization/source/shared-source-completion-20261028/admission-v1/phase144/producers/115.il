TYPE TheForestOfLove.Narrative.Dialogue
METHOD System.Void TheForestOfLove.Narrative.Dialogue::SetStatusDefault() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted()
IL_0006: brfalse.s IL_0037
IL_0008: call System.Boolean Globals::get_DevCommandActive()
IL_000d: brtrue.s IL_0037
IL_000f: ldsfld System.Boolean Globals::isChapterSelect
IL_0014: brtrue.s IL_0037
IL_0016: ldsfld System.Boolean Globals::isCheatCode
IL_001b: brtrue.s IL_0037
IL_001d: ldstr "Dialogue with id {0} set to default, but it was already set to completed."
IL_0022: ldarg.0
IL_0023: ldfld System.Int32 TheForestOfLove.Narrative.Dialogue::dbDialogueIndex
IL_0028: box System.Int32
IL_002d: call System.String System.String::Format(System.String,System.Object)
IL_0032: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0037: ldarg.0
IL_0038: call System.Boolean TheForestOfLove.Narrative.Dialogue::get_isInvalidated()
IL_003d: brfalse.s IL_006e
IL_003f: call System.Boolean Globals::get_DevCommandActive()
IL_0044: brtrue.s IL_006e
IL_0046: ldsfld System.Boolean Globals::isChapterSelect
IL_004b: brtrue.s IL_006e
IL_004d: ldsfld System.Boolean Globals::isCheatCode
IL_0052: brtrue.s IL_006e
IL_0054: ldstr "Dialogue with id {0} set to default, but it was already set to invalidated."
IL_0059: ldarg.0
IL_005a: ldfld System.Int32 TheForestOfLove.Narrative.Dialogue::dbDialogueIndex
IL_005f: box System.Int32
IL_0064: call System.String System.String::Format(System.String,System.Object)
IL_0069: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_006e: ldarg.0
IL_006f: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0074: brtrue.s IL_008c
IL_0076: call System.Boolean Globals::get_DevCommandActive()
IL_007b: brtrue.s IL_008c
IL_007d: ldsfld System.Boolean Globals::isChapterSelect
IL_0082: brtrue.s IL_008c
IL_0084: ldsfld System.Boolean Globals::isCheatCode
IL_0089: brtrue.s IL_008c
IL_008b: ret
IL_008c: ldarg.0
IL_008d: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0092: stloc.0
IL_0093: ldarg.0
IL_0094: ldc.i4.0
IL_0095: call TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Services.Persistence.DataService::GetDialogueStatusRecordByStatus(TheForestOfLove.Narrative.DialogueStatus)
IL_009a: stfld TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Narrative.Dialogue::statusRecord
IL_009f: ldsfld TheForestOfLove.Events.DialogueEvent TheForestOfLove.Events.NarrativeEvents::onDialogueStatusDefaulted
IL_00a4: ldarg.0
IL_00a5: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_00aa: ldsfld TheForestOfLove.Events.DialogueStatusEvent TheForestOfLove.Events.NarrativeEvents::onDialogueStatusUpdated
IL_00af: ldarg.0
IL_00b0: ldloc.0
IL_00b1: ldarg.0
IL_00b2: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_00b7: callvirt System.Void UnityEngine.Events.UnityEvent`3<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatus>::Invoke(!0,!1,!2)
IL_00bc: ret
METHOD System.Void TheForestOfLove.Narrative.Dialogue::SetStatusStarted() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted()
IL_0006: brfalse.s IL_0037
IL_0008: call System.Boolean Globals::get_DevCommandActive()
IL_000d: brtrue.s IL_0037
IL_000f: ldsfld System.Boolean Globals::isChapterSelect
IL_0014: brtrue.s IL_0037
IL_0016: ldsfld System.Boolean Globals::isCheatCode
IL_001b: brtrue.s IL_0037
IL_001d: ldstr "Dialogue with id {0} set to started, but it was already set to completed."
IL_0022: ldarg.0
IL_0023: ldfld System.Int32 TheForestOfLove.Narrative.Dialogue::dbDialogueIndex
IL_0028: box System.Int32
IL_002d: call System.String System.String::Format(System.String,System.Object)
IL_0032: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0037: ldarg.0
IL_0038: call System.Boolean TheForestOfLove.Narrative.Dialogue::get_isInvalidated()
IL_003d: brfalse.s IL_006e
IL_003f: call System.Boolean Globals::get_DevCommandActive()
IL_0044: brtrue.s IL_006e
IL_0046: ldsfld System.Boolean Globals::isChapterSelect
IL_004b: brtrue.s IL_006e
IL_004d: ldsfld System.Boolean Globals::isCheatCode
IL_0052: brtrue.s IL_006e
IL_0054: ldstr "Dialogue with id {0} set to started, but it was already set to invalidated."
IL_0059: ldarg.0
IL_005a: ldfld System.Int32 TheForestOfLove.Narrative.Dialogue::dbDialogueIndex
IL_005f: box System.Int32
IL_0064: call System.String System.String::Format(System.String,System.Object)
IL_0069: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_006e: ldarg.0
IL_006f: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0074: ldc.i4.s 100
IL_0076: bne.un.s IL_008e
IL_0078: call System.Boolean Globals::get_DevCommandActive()
IL_007d: brtrue.s IL_008e
IL_007f: ldsfld System.Boolean Globals::isChapterSelect
IL_0084: brtrue.s IL_008e
IL_0086: ldsfld System.Boolean Globals::isCheatCode
IL_008b: brtrue.s IL_008e
IL_008d: ret
IL_008e: ldarg.0
IL_008f: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0094: stloc.0
IL_0095: ldarg.0
IL_0096: ldc.i4.s 100
IL_0098: call TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Services.Persistence.DataService::GetDialogueStatusRecordByStatus(TheForestOfLove.Narrative.DialogueStatus)
IL_009d: stfld TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Narrative.Dialogue::statusRecord
IL_00a2: ldsfld TheForestOfLove.Events.DialogueEvent TheForestOfLove.Events.NarrativeEvents::onDialogueStatusStarted
IL_00a7: ldarg.0
IL_00a8: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_00ad: ldsfld TheForestOfLove.Events.DialogueStatusEvent TheForestOfLove.Events.NarrativeEvents::onDialogueStatusUpdated
IL_00b2: ldarg.0
IL_00b3: ldloc.0
IL_00b4: ldarg.0
IL_00b5: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_00ba: callvirt System.Void UnityEngine.Events.UnityEvent`3<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatus>::Invoke(!0,!1,!2)
IL_00bf: ret
METHOD System.Void TheForestOfLove.Narrative.Dialogue::SetStatusCompleted() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted()
IL_0006: brfalse.s IL_0066
IL_0008: ldarg.0
IL_0009: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_000e: ldc.i4 300
IL_0013: beq.s IL_0066
IL_0015: ldarg.0
IL_0016: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_001b: ldc.i4 400
IL_0020: beq.s IL_0066
IL_0022: ldarg.0
IL_0023: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0028: ldc.i4 700
IL_002d: beq.s IL_0066
IL_002f: ldarg.0
IL_0030: ldfld TheForestOfLove.Narrative.DialogueType TheForestOfLove.Narrative.Dialogue::dialogueType
IL_0035: brfalse.s IL_0066
IL_0037: call System.Boolean Globals::get_DevCommandActive()
IL_003c: brtrue.s IL_0066
IL_003e: ldsfld System.Boolean Globals::isChapterSelect
IL_0043: brtrue.s IL_0066
IL_0045: ldsfld System.Boolean Globals::isCheatCode
IL_004a: brtrue.s IL_0066
IL_004c: ldstr "Dialogue with id {0} set to completed, but it was already set to completed."
IL_0051: ldarg.0
IL_0052: ldfld System.Int32 TheForestOfLove.Narrative.Dialogue::dbDialogueIndex
IL_0057: box System.Int32
IL_005c: call System.String System.String::Format(System.String,System.Object)
IL_0061: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0066: ldarg.0
IL_0067: call System.Boolean TheForestOfLove.Narrative.Dialogue::get_isInvalidated()
IL_006c: brfalse.s IL_009d
IL_006e: call System.Boolean Globals::get_DevCommandActive()
IL_0073: brtrue.s IL_009d
IL_0075: ldsfld System.Boolean Globals::isChapterSelect
IL_007a: brtrue.s IL_009d
IL_007c: ldsfld System.Boolean Globals::isCheatCode
IL_0081: brtrue.s IL_009d
IL_0083: ldstr "Dialogue with id {0} set to completed, but it was already set to invalidated."
IL_0088: ldarg.0
IL_0089: ldfld System.Int32 TheForestOfLove.Narrative.Dialogue::dbDialogueIndex
IL_008e: box System.Int32
IL_0093: call System.String System.String::Format(System.String,System.Object)
IL_0098: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_009d: ldarg.0
IL_009e: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_00a3: ldc.i4 200
IL_00a8: bne.un.s IL_00c0
IL_00aa: call System.Boolean Globals::get_DevCommandActive()
IL_00af: brtrue.s IL_00c0
IL_00b1: ldsfld System.Boolean Globals::isChapterSelect
IL_00b6: brtrue.s IL_00c0
IL_00b8: ldsfld System.Boolean Globals::isCheatCode
IL_00bd: brtrue.s IL_00c0
IL_00bf: ret
IL_00c0: ldarg.0
IL_00c1: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_00c6: stloc.0
IL_00c7: ldarg.0
IL_00c8: ldc.i4 200
IL_00cd: call TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Services.Persistence.DataService::GetDialogueStatusRecordByStatus(TheForestOfLove.Narrative.DialogueStatus)
IL_00d2: stfld TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Narrative.Dialogue::statusRecord
IL_00d7: ldsfld TheForestOfLove.Events.DialogueEvent TheForestOfLove.Events.NarrativeEvents::onDialogueStatusCompleted
IL_00dc: ldarg.0
IL_00dd: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_00e2: ldsfld TheForestOfLove.Events.DialogueStatusEvent TheForestOfLove.Events.NarrativeEvents::onDialogueStatusUpdated
IL_00e7: ldarg.0
IL_00e8: ldloc.0
IL_00e9: ldarg.0
IL_00ea: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_00ef: callvirt System.Void UnityEngine.Events.UnityEvent`3<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatus>::Invoke(!0,!1,!2)
IL_00f4: ret
METHOD System.Void TheForestOfLove.Narrative.Dialogue::SetStatusInvalidated() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean TheForestOfLove.Narrative.Dialogue::get_isCompleted()
IL_0006: brfalse.s IL_0037
IL_0008: call System.Boolean Globals::get_DevCommandActive()
IL_000d: brtrue.s IL_0037
IL_000f: ldsfld System.Boolean Globals::isChapterSelect
IL_0014: brtrue.s IL_0037
IL_0016: ldsfld System.Boolean Globals::isCheatCode
IL_001b: brtrue.s IL_0037
IL_001d: ldstr "Dialogue with id {0} set to invalidated, but it was already set to completed."
IL_0022: ldarg.0
IL_0023: ldfld System.Int32 TheForestOfLove.Narrative.Dialogue::dbDialogueIndex
IL_0028: box System.Int32
IL_002d: call System.String System.String::Format(System.String,System.Object)
IL_0032: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0037: ldarg.0
IL_0038: call System.Boolean TheForestOfLove.Narrative.Dialogue::get_isInvalidated()
IL_003d: brfalse.s IL_006e
IL_003f: call System.Boolean Globals::get_DevCommandActive()
IL_0044: brtrue.s IL_006e
IL_0046: ldsfld System.Boolean Globals::isChapterSelect
IL_004b: brtrue.s IL_006e
IL_004d: ldsfld System.Boolean Globals::isCheatCode
IL_0052: brtrue.s IL_006e
IL_0054: ldstr "Dialogue with id {0} set to invalidated, but it was already set to invalidated."
IL_0059: ldarg.0
IL_005a: ldfld System.Int32 TheForestOfLove.Narrative.Dialogue::dbDialogueIndex
IL_005f: box System.Int32
IL_0064: call System.String System.String::Format(System.String,System.Object)
IL_0069: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_006e: ldarg.0
IL_006f: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0074: ldc.i4 300
IL_0079: bne.un.s IL_0091
IL_007b: call System.Boolean Globals::get_DevCommandActive()
IL_0080: brtrue.s IL_0091
IL_0082: ldsfld System.Boolean Globals::isChapterSelect
IL_0087: brtrue.s IL_0091
IL_0089: ldsfld System.Boolean Globals::isCheatCode
IL_008e: brtrue.s IL_0091
IL_0090: ret
IL_0091: ldarg.0
IL_0092: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_0097: stloc.0
IL_0098: ldarg.0
IL_0099: ldc.i4 300
IL_009e: call TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Services.Persistence.DataService::GetDialogueStatusRecordByStatus(TheForestOfLove.Narrative.DialogueStatus)
IL_00a3: stfld TheForestOfLove.Narrative.DialogueStatusRecord TheForestOfLove.Narrative.Dialogue::statusRecord
IL_00a8: ldsfld TheForestOfLove.Events.DialogueEvent TheForestOfLove.Events.NarrativeEvents::onDialogueStatusInvalidated
IL_00ad: ldarg.0
IL_00ae: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_00b3: ldsfld TheForestOfLove.Events.DialogueStatusEvent TheForestOfLove.Events.NarrativeEvents::onDialogueStatusUpdated
IL_00b8: ldarg.0
IL_00b9: ldloc.0
IL_00ba: ldarg.0
IL_00bb: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_00c0: callvirt System.Void UnityEngine.Events.UnityEvent`3<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.DialogueStatus,TheForestOfLove.Narrative.DialogueStatus>::Invoke(!0,!1,!2)
IL_00c5: ret
