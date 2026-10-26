TYPE TheForestOfLove.Narrative.Dialogue
METHOD System.Boolean TheForestOfLove.Narrative.Dialogue::CheckIfPreconditionSatisfied() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean Globals::get_DisablePreconditions()
IL_0005: brfalse.s IL_0009
IL_0007: ldc.i4.1
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call TheForestOfLove.Narrative.DialogueStatus TheForestOfLove.Narrative.Dialogue::get_status()
IL_000f: ldc.i4 300
IL_0014: bne.un.s IL_0018
IL_0016: ldc.i4.0
IL_0017: ret
IL_0018: ldarg.0
IL_0019: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition> TheForestOfLove.Narrative.Dialogue::preconditions
IL_001e: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::GetEnumerator()
IL_0023: stloc.0
IL_0024: br.s IL_0038
IL_0026: ldloca.s V_0
IL_0028: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::get_Current()
IL_002d: callvirt System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition::get_IsSatisfied()
IL_0032: brtrue.s IL_0038
IL_0034: ldc.i4.0
IL_0035: stloc.1
IL_0036: leave.s IL_0053
IL_0038: ldloca.s V_0
IL_003a: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>::MoveNext()
IL_003f: brtrue.s IL_0026
IL_0041: leave.s IL_0051
IL_0043: ldloca.s V_0
IL_0045: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialoguePreconditions.DialoguePrecondition>
IL_004b: callvirt System.Void System.IDisposable::Dispose()
IL_0050: endfinally
IL_0051: ldc.i4.1
IL_0052: ret
IL_0053: ldloc.1
IL_0054: ret
METHOD System.Void TheForestOfLove.Narrative.Dialogue::FireDialogueTriggers() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger> TheForestOfLove.Narrative.Dialogue::dialogueTriggers
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_001a
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::get_Current()
IL_0015: callvirt System.Void TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger::Execute()
IL_001a: ldloca.s V_0
IL_001c: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>::MoveNext()
IL_0021: brtrue.s IL_000e
IL_0023: leave.s IL_0033
IL_0025: ldloca.s V_0
IL_0027: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.DialogueTriggers.DialogueTrigger>
IL_002d: callvirt System.Void System.IDisposable::Dispose()
IL_0032: endfinally
IL_0033: ret
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
