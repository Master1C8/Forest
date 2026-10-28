TYPE PixelCrushers.DialogueSystem.Field
METHOD PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::Lookup(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.Field/<>c__DisplayClass15_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.String PixelCrushers.DialogueSystem.Field/<>c__DisplayClass15_0::title
IL_000d: ldarg.0
IL_000e: brfalse.s IL_0023
IL_0010: ldarg.0
IL_0011: ldloc.0
IL_0012: ldftn System.Boolean PixelCrushers.DialogueSystem.Field/<>c__DisplayClass15_0::<Lookup>b__0(PixelCrushers.DialogueSystem.Field)
IL_0018: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.Field>::.ctor(System.Object,System.IntPtr)
IL_001d: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>::Find(System.Predicate`1<!0>)
IL_0022: ret
IL_0023: ldnull
IL_0024: ret
METHOD PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::AssignedField(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::Lookup(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: brfalse.s IL_0018
IL_000b: ldloc.0
IL_000c: ldfld System.String PixelCrushers.DialogueSystem.Field::value
IL_0011: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0016: brfalse.s IL_001a
IL_0018: ldnull
IL_0019: ret
IL_001a: ldloc.0
IL_001b: ret
METHOD System.String PixelCrushers.DialogueSystem.Field::FieldValue(PixelCrushers.DialogueSystem.Field) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: brtrue.s IL_0005
IL_0003: ldnull
IL_0004: ret
IL_0005: ldarg.0
IL_0006: ldfld System.String PixelCrushers.DialogueSystem.Field::value
IL_000b: ret
