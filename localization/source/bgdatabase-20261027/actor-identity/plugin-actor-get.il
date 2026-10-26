TYPE PixelCrushers.DialogueSystem.DialogueDatabase
METHOD PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass28_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.String PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass28_0::actorName
IL_000d: ldarg.0
IL_000e: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::SetupCaches()
IL_0013: ldarg.0
IL_0014: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actorNameCache
IL_0019: ldloc.0
IL_001a: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass28_0::actorName
IL_001f: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Actor>::ContainsKey(!0)
IL_0024: brtrue.s IL_003e
IL_0026: ldarg.0
IL_0027: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_002c: ldloc.0
IL_002d: ldftn System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass28_0::<GetActor>b__0(PixelCrushers.DialogueSystem.Actor)
IL_0033: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.Actor>::.ctor(System.Object,System.IntPtr)
IL_0038: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor>::Find(System.Predicate`1<!0>)
IL_003d: ret
IL_003e: ldarg.0
IL_003f: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actorNameCache
IL_0044: ldloc.0
IL_0045: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass28_0::actorName
IL_004a: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Actor>::get_Item(!0)
IL_004f: ret
METHOD PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.Int32) | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass29_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.Int32 PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass29_0::id
IL_000d: ldarg.0
IL_000e: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_0013: ldloc.0
IL_0014: ldftn System.Boolean PixelCrushers.DialogueSystem.DialogueDatabase/<>c__DisplayClass29_0::<GetActor>b__0(PixelCrushers.DialogueSystem.Actor)
IL_001a: newobj System.Void System.Predicate`1<PixelCrushers.DialogueSystem.Actor>::.ctor(System.Object,System.IntPtr)
IL_001f: callvirt !0 System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor>::Find(System.Predicate`1<!0>)
IL_0024: ret
