TYPE PixelCrushers.DialogueSystem.DialogueSystemController
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::add_initializationComplete(System.Action) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Action PixelCrushers.DialogueSystem.DialogueSystemController::initializationComplete
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: stloc.1
IL_0009: ldloc.1
IL_000a: ldarg.1
IL_000b: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_0010: castclass System.Action
IL_0015: stloc.2
IL_0016: ldarg.0
IL_0017: ldflda System.Action PixelCrushers.DialogueSystem.DialogueSystemController::initializationComplete
IL_001c: ldloc.2
IL_001d: ldloc.1
IL_001e: call !!0 System.Threading.Interlocked::CompareExchange<System.Action>(!!0&,!!0,!!0)
IL_0023: stloc.0
IL_0024: ldloc.0
IL_0025: ldloc.1
IL_0026: bne.un.s IL_0007
IL_0028: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueSystemController::remove_initializationComplete(System.Action) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Action PixelCrushers.DialogueSystem.DialogueSystemController::initializationComplete
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: stloc.1
IL_0009: ldloc.1
IL_000a: ldarg.1
IL_000b: call System.Delegate System.Delegate::Remove(System.Delegate,System.Delegate)
IL_0010: castclass System.Action
IL_0015: stloc.2
IL_0016: ldarg.0
IL_0017: ldflda System.Action PixelCrushers.DialogueSystem.DialogueSystemController::initializationComplete
IL_001c: ldloc.2
IL_001d: ldloc.1
IL_001e: call !!0 System.Threading.Interlocked::CompareExchange<System.Action>(!!0&,!!0,!!0)
IL_0023: stloc.0
IL_0024: ldloc.0
IL_0025: ldloc.1
IL_0026: bne.un.s IL_0007
IL_0028: ret
