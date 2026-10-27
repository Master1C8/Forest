TYPE PixelCrushers.DialogueSystem.DatabaseUtility
METHOD PixelCrushers.DialogueSystem.DialogueDatabase PixelCrushers.DialogueSystem.DatabaseUtility::CreateDialogueDatabaseInstance(System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call PixelCrushers.DialogueSystem.Template PixelCrushers.DialogueSystem.Template::FromDefault()
IL_0005: stloc.0
IL_0006: ldtoken PixelCrushers.DialogueSystem.DialogueDatabase
IL_000b: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0010: call System.Type PixelCrushers.RuntimeTypeUtility::GetWrapperType(System.Type)
IL_0015: dup
IL_0016: brtrue.s IL_0023
IL_0018: pop
IL_0019: ldtoken PixelCrushers.DialogueSystem.DialogueDatabase
IL_001e: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0023: call UnityEngine.ScriptableObject PixelCrushers.ScriptableObjectUtility::CreateScriptableObject(System.Type)
IL_0028: isinst PixelCrushers.DialogueSystem.DialogueDatabase
IL_002d: stloc.1
IL_002e: ldloc.1
IL_002f: callvirt System.Void PixelCrushers.DialogueSystem.DialogueDatabase::ResetEmphasisSettings()
IL_0034: ldarg.0
IL_0035: brfalse.s IL_006b
IL_0037: ldloc.1
IL_0038: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_003d: ldloc.0
IL_003e: ldc.i4.1
IL_003f: ldstr "Player"
IL_0044: ldc.i4.1
IL_0045: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.Template::CreateActor(System.Int32,System.String,System.Boolean)
IL_004a: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor>::Add(!0)
IL_004f: ldloc.1
IL_0050: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variables
IL_0055: ldloc.0
IL_0056: ldc.i4.1
IL_0057: ldstr "Alert"
IL_005c: ldsfld System.String System.String::Empty
IL_0061: callvirt PixelCrushers.DialogueSystem.Variable PixelCrushers.DialogueSystem.Template::CreateVariable(System.Int32,System.String,System.String)
IL_0066: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable>::Add(!0)
IL_006b: ldloc.1
IL_006c: ret
