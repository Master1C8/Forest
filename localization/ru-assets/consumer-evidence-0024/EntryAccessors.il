TYPE PixelCrushers.DialogueSystem.DialogueEntry
METHOD System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_0006: ldstr "Actor"
IL_000b: call System.Int32 PixelCrushers.DialogueSystem.Field::LookupInt(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0010: ret
METHOD System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ConversantID()
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_0006: ldstr "Conversant"
IL_000b: call System.Int32 PixelCrushers.DialogueSystem.Field::LookupInt(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0010: ret
METHOD PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.DialogueEntry::GetCurrentSequenceField()
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_0006: ldstr "Sequence"
IL_000b: call System.String PixelCrushers.DialogueSystem.Field::LocalizedTitle(System.String)
IL_0010: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::AssignedField(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0015: dup
IL_0016: brtrue.s IL_0029
IL_0018: pop
IL_0019: ldarg.0
IL_001a: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field> PixelCrushers.DialogueSystem.DialogueEntry::fields
IL_001f: ldstr "Sequence"
IL_0024: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::Lookup(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0029: ret
