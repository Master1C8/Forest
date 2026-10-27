TYPE PixelCrushers.DialogueSystem.DialogueDatabase
METHOD System.Void PixelCrushers.DialogueSystem.DialogueDatabase::Add(PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse IL_009d
IL_000c: ldarg.0
IL_000d: ldarg.1
IL_000e: ldfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.DialogueDatabase::emphasisSettings
IL_0013: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::AddEmphasisSettings(PixelCrushers.DialogueSystem.EmphasisSetting[])
IL_0018: ldarg.0
IL_0019: ldarg.1
IL_001a: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::AddGlobalUserScript(PixelCrushers.DialogueSystem.DialogueDatabase)
IL_001f: ldarg.0
IL_0020: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::SetupCaches()
IL_0025: ldarg.0
IL_0026: ldarg.0
IL_0027: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_002c: ldarg.1
IL_002d: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_0032: ldarg.0
IL_0033: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actorNameCache
IL_0038: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::AddAssets<PixelCrushers.DialogueSystem.Actor>(System.Collections.Generic.List`1<T>,System.Collections.Generic.List`1<T>,System.Collections.Generic.Dictionary`2<System.String,T>)
IL_003d: ldarg.0
IL_003e: ldarg.0
IL_003f: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::items
IL_0044: ldarg.1
IL_0045: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::items
IL_004a: ldarg.0
IL_004b: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::itemNameCache
IL_0050: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::AddAssets<PixelCrushers.DialogueSystem.Item>(System.Collections.Generic.List`1<T>,System.Collections.Generic.List`1<T>,System.Collections.Generic.Dictionary`2<System.String,T>)
IL_0055: ldarg.0
IL_0056: ldarg.0
IL_0057: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locations
IL_005c: ldarg.1
IL_005d: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locations
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locationNameCache
IL_0068: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::AddAssets<PixelCrushers.DialogueSystem.Location>(System.Collections.Generic.List`1<T>,System.Collections.Generic.List`1<T>,System.Collections.Generic.Dictionary`2<System.String,T>)
IL_006d: ldarg.0
IL_006e: ldarg.0
IL_006f: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variables
IL_0074: ldarg.1
IL_0075: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variables
IL_007a: ldarg.0
IL_007b: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variableNameCache
IL_0080: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::AddAssets<PixelCrushers.DialogueSystem.Variable>(System.Collections.Generic.List`1<T>,System.Collections.Generic.List`1<T>,System.Collections.Generic.Dictionary`2<System.String,T>)
IL_0085: ldarg.0
IL_0086: ldarg.0
IL_0087: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversations
IL_008c: ldarg.1
IL_008d: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversations
IL_0092: ldarg.0
IL_0093: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversationTitleCache
IL_0098: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::AddAssets<PixelCrushers.DialogueSystem.Conversation>(System.Collections.Generic.List`1<T>,System.Collections.Generic.List`1<T>,System.Collections.Generic.Dictionary`2<System.String,T>)
IL_009d: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueDatabase::AddAssets(System.Collections.Generic.List`1<T>,System.Collections.Generic.List`1<T>,System.Collections.Generic.Dictionary`2<System.String,T>) | attributes=Private, HideBySig | impl=IL
IL_0000: ldtoken T
IL_0005: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_000a: ldtoken PixelCrushers.DialogueSystem.Conversation
IL_000f: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0014: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_0019: stloc.0
IL_001a: ldc.i4.0
IL_001b: stloc.1
IL_001c: br.s IL_0063
IL_001e: ldarg.2
IL_001f: ldloc.1
IL_0020: callvirt !0 System.Collections.Generic.List`1<T>::get_Item(System.Int32)
IL_0025: stloc.2
IL_0026: ldloc.0
IL_0027: brtrue.s IL_0036
IL_0029: ldloc.2
IL_002a: box T
IL_002f: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_0034: br.s IL_0046
IL_0036: ldloc.2
IL_0037: box T
IL_003c: isinst PixelCrushers.DialogueSystem.Conversation
IL_0041: callvirt System.String PixelCrushers.DialogueSystem.Conversation::get_Title()
IL_0046: stloc.3
IL_0047: ldarg.3
IL_0048: ldloc.3
IL_0049: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,T>::ContainsKey(!0)
IL_004e: brtrue.s IL_005f
IL_0050: ldarg.3
IL_0051: ldloc.3
IL_0052: ldloc.2
IL_0053: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,T>::Add(!0,!1)
IL_0058: ldarg.1
IL_0059: ldloc.2
IL_005a: callvirt System.Void System.Collections.Generic.List`1<T>::Add(!0)
IL_005f: ldloc.1
IL_0060: ldc.i4.1
IL_0061: add
IL_0062: stloc.1
IL_0063: ldloc.1
IL_0064: ldarg.2
IL_0065: callvirt System.Int32 System.Collections.Generic.List`1<T>::get_Count()
IL_006a: blt.s IL_001e
IL_006c: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueDatabase::AddGlobalUserScript(PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::globalUserScript
IL_0006: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000b: brtrue.s IL_0043
IL_000d: ldarg.1
IL_000e: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::globalUserScript
IL_0013: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0018: brtrue.s IL_005c
IL_001a: ldarg.0
IL_001b: ldstr "{0}; {1}"
IL_0020: ldc.i4.2
IL_0021: newarr System.Object
IL_0026: dup
IL_0027: ldc.i4.0
IL_0028: ldarg.0
IL_0029: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::globalUserScript
IL_002e: stelem.ref
IL_002f: dup
IL_0030: ldc.i4.1
IL_0031: ldarg.1
IL_0032: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::globalUserScript
IL_0037: stelem.ref
IL_0038: call System.String System.String::Format(System.String,System.Object[])
IL_003d: stfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::globalUserScript
IL_0042: ret
IL_0043: ldarg.1
IL_0044: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::globalUserScript
IL_0049: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_004e: brtrue.s IL_005c
IL_0050: ldarg.0
IL_0051: ldarg.1
IL_0052: ldfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::globalUserScript
IL_0057: stfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::globalUserScript
IL_005c: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueDatabase::Clear() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_0006: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor>::Clear()
IL_000b: ldarg.0
IL_000c: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::items
IL_0011: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Item>::Clear()
IL_0016: ldarg.0
IL_0017: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locations
IL_001c: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Location>::Clear()
IL_0021: ldarg.0
IL_0022: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variables
IL_0027: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable>::Clear()
IL_002c: ldarg.0
IL_002d: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversations
IL_0032: callvirt System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation>::Clear()
IL_0037: ldarg.0
IL_0038: call System.Void PixelCrushers.DialogueSystem.DialogueDatabase::ResetCache()
IL_003d: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueDatabase::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.4
IL_0002: newarr PixelCrushers.DialogueSystem.EmphasisSetting
IL_0007: stfld PixelCrushers.DialogueSystem.EmphasisSetting[] PixelCrushers.DialogueSystem.DialogueDatabase::emphasisSettings
IL_000c: ldarg.0
IL_000d: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor>::.ctor()
IL_0012: stfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_0017: ldarg.0
IL_0018: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Item>::.ctor()
IL_001d: stfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::items
IL_0022: ldarg.0
IL_0023: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Location>::.ctor()
IL_0028: stfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locations
IL_002d: ldarg.0
IL_002e: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable>::.ctor()
IL_0033: stfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variables
IL_0038: ldarg.0
IL_0039: newobj System.Void System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation>::.ctor()
IL_003e: stfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversations
IL_0043: ldarg.0
IL_0044: newobj System.Void PixelCrushers.DialogueSystem.DialogueDatabase/SyncInfo::.ctor()
IL_0049: stfld PixelCrushers.DialogueSystem.DialogueDatabase/SyncInfo PixelCrushers.DialogueSystem.DialogueDatabase::syncInfo
IL_004e: ldarg.0
IL_004f: ldsfld System.String System.String::Empty
IL_0054: stfld System.String PixelCrushers.DialogueSystem.DialogueDatabase::templateJson
IL_0059: ldarg.0
IL_005a: call System.Void UnityEngine.ScriptableObject::.ctor()
IL_005f: ret
