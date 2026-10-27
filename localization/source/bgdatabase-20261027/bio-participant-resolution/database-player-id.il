TYPE PixelCrushers.DialogueSystem.DialogueDatabase
METHOD System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase::IsPlayerID(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass22_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.Int32 PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass22_0::actorID
IL_000d: ldarg.0
IL_000e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_0013: ldloc.0
IL_0014: ldftn System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass22_0::<IsPlayerID>b__0(PixelCrushers.DialogueSystem.Actor)
IL_001a: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.Actor>::.ctor(System.Object,System.IntPtr)
IL_001f: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor>::Find(System.Predicate`1<!0>)
IL_0024: stloc.1
IL_0025: ldloc.1
IL_0026: brtrue.s IL_002a
IL_0028: ldc.i4.0
IL_0029: ret
IL_002a: ldloc.1
IL_002b: callvirt System.Boolean PixelCrushers.DialogueSystem.Actor::get_IsPlayer()
IL_0030: ret
