TYPE PixelCrushers.UILocalizationManager/<Start>d__22
METHOD System.Boolean PixelCrushers.UILocalizationManager/<Start>d__22::MoveNext() | attributes=Private, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 PixelCrushers.UILocalizationManager/<Start>d__22::<>1__state
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: ldfld PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager/<Start>d__22::<>4__this
IL_000d: stloc.1
IL_000e: ldloc.0
IL_000f: brfalse.s IL_0017
IL_0011: ldloc.0
IL_0012: ldc.i4.1
IL_0013: beq.s IL_0032
IL_0015: ldc.i4.0
IL_0016: ret
IL_0017: ldarg.0
IL_0018: ldc.i4.m1
IL_0019: stfld System.Int32 PixelCrushers.UILocalizationManager/<Start>d__22::<>1__state
IL_001e: ldarg.0
IL_001f: newobj System.Void UnityEngine.WaitForEndOfFrame::.ctor()
IL_0024: stfld System.Object PixelCrushers.UILocalizationManager/<Start>d__22::<>2__current
IL_0029: ldarg.0
IL_002a: ldc.i4.1
IL_002b: stfld System.Int32 PixelCrushers.UILocalizationManager/<Start>d__22::<>1__state
IL_0030: ldc.i4.1
IL_0031: ret
IL_0032: ldarg.0
IL_0033: ldc.i4.m1
IL_0034: stfld System.Int32 PixelCrushers.UILocalizationManager/<Start>d__22::<>1__state
IL_0039: ldloc.1
IL_003a: ldloc.1
IL_003b: call System.String PixelCrushers.UILocalizationManager::get_currentLanguage()
IL_0040: call System.Void PixelCrushers.UILocalizationManager::UpdateUIs(System.String)
IL_0045: ldc.i4.0
IL_0046: ret
