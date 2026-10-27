TYPE PixelCrushers.DialogueSystem.ConversationModel
METHOD System.Void PixelCrushers.DialogueSystem.ConversationModel::CheckSequenceField(PixelCrushers.DialogueSystem.DialogueEntry) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentSequence()
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brfalse.s IL_0047
IL_000d: ldarg.1
IL_000e: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_VideoFile()
IL_0013: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0018: brtrue.s IL_0047
IL_001a: call System.Boolean PixelCrushers.DialogueSystem.DialogueDebug::get_logWarnings()
IL_001f: brfalse.s IL_0047
IL_0021: ldstr "{0}: Dialogue entry '{1}' Video File field is assigned but Sequence is blank. Cutscenes now use Sequence field."
IL_0026: ldc.i4.2
IL_0027: newarr System.Object
IL_002c: dup
IL_002d: ldc.i4.0
IL_002e: ldstr "Dialogue System"
IL_0033: stelem.ref
IL_0034: dup
IL_0035: ldc.i4.1
IL_0036: ldarg.1
IL_0037: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentDialogueText()
IL_003c: stelem.ref
IL_003d: call System.String System.String::Format(System.String,System.Object[])
IL_0042: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_0047: ret
