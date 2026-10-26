TYPE PixelCrushers.DialogueSystem.DialogueEntry
METHOD System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentDialogueText()
IL_0000: ldarg.0
IL_0001: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.DialogueEntry::GetCurrentDialogueTextField()
IL_0006: call System.String PixelCrushers.DialogueSystem.Field::FieldValue(PixelCrushers.DialogueSystem.Field)
IL_000b: ret
METHOD PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.DialogueEntry::GetCurrentDialogueTextField()
IL_0000: call System.String PixelCrushers.DialogueSystem.Localization::get_language()
IL_0005: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000a: brfalse.s IL_001d
IL_000c: ldarg.0
IL_000d: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_0012: ldstr "Dialogue Text"
IL_0017: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::Lookup(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_001c: ret
IL_001d: ldarg.0
IL_001e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_0023: call System.String PixelCrushers.DialogueSystem.Localization::get_language()
IL_0028: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::AssignedField(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_002d: dup
IL_002e: brtrue.s IL_0041
IL_0030: pop
IL_0031: ldarg.0
IL_0032: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_0037: ldstr "Dialogue Text"
IL_003c: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::Lookup(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0041: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueEntry::get_subtitleText()
IL_0000: ldarg.0
IL_0001: call System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentDialogueText()
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brtrue.s IL_0014
IL_000d: ldarg.0
IL_000e: call System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentDialogueText()
IL_0013: ret
IL_0014: ldarg.0
IL_0015: call System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentMenuText()
IL_001a: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueEntry::get_responseButtonText()
IL_0000: ldarg.0
IL_0001: call System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentMenuText()
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brtrue.s IL_0014
IL_000d: ldarg.0
IL_000e: call System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentMenuText()
IL_0013: ret
IL_0014: ldarg.0
IL_0015: call System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentDialogueText()
IL_001a: ret
METHOD System.String PixelCrushers.DialogueSystem.DialogueEntry::get_currentSequence()
IL_0000: ldarg.0
IL_0001: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.DialogueEntry::GetCurrentSequenceField()
IL_0006: call System.String PixelCrushers.DialogueSystem.Field::FieldValue(PixelCrushers.DialogueSystem.Field)
IL_000b: ret
