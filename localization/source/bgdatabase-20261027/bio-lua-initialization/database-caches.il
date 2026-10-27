TYPE PixelCrushers.DialogueSystem.DialogueDatabase
METHOD System.Void PixelCrushers.DialogueSystem.DialogueDatabase::SetupCaches() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actorNameCache
IL_0006: brtrue.s IL_001a
IL_0008: ldarg.0
IL_0009: ldarg.0
IL_000a: ldarg.0
IL_000b: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actors
IL_0010: call System.Collections.Generic.Dictionary`2<System.String,T> PixelCrushers.DialogueSystem.DialogueDatabase::CreateCache<PixelCrushers.DialogueSystem.Actor>(System.Collections.Generic.List`1<T>)
IL_0015: stfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actorNameCache
IL_001a: ldarg.0
IL_001b: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::itemNameCache
IL_0020: brtrue.s IL_0034
IL_0022: ldarg.0
IL_0023: ldarg.0
IL_0024: ldarg.0
IL_0025: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::items
IL_002a: call System.Collections.Generic.Dictionary`2<System.String,T> PixelCrushers.DialogueSystem.DialogueDatabase::CreateCache<PixelCrushers.DialogueSystem.Item>(System.Collections.Generic.List`1<T>)
IL_002f: stfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::itemNameCache
IL_0034: ldarg.0
IL_0035: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locationNameCache
IL_003a: brtrue.s IL_004e
IL_003c: ldarg.0
IL_003d: ldarg.0
IL_003e: ldarg.0
IL_003f: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locations
IL_0044: call System.Collections.Generic.Dictionary`2<System.String,T> PixelCrushers.DialogueSystem.DialogueDatabase::CreateCache<PixelCrushers.DialogueSystem.Location>(System.Collections.Generic.List`1<T>)
IL_0049: stfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locationNameCache
IL_004e: ldarg.0
IL_004f: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variableNameCache
IL_0054: brtrue.s IL_0068
IL_0056: ldarg.0
IL_0057: ldarg.0
IL_0058: ldarg.0
IL_0059: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variables
IL_005e: call System.Collections.Generic.Dictionary`2<System.String,T> PixelCrushers.DialogueSystem.DialogueDatabase::CreateCache<PixelCrushers.DialogueSystem.Variable>(System.Collections.Generic.List`1<T>)
IL_0063: stfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variableNameCache
IL_0068: ldarg.0
IL_0069: ldfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversationTitleCache
IL_006e: brtrue.s IL_0082
IL_0070: ldarg.0
IL_0071: ldarg.0
IL_0072: ldarg.0
IL_0073: ldfld System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversations
IL_0078: call System.Collections.Generic.Dictionary`2<System.String,T> PixelCrushers.DialogueSystem.DialogueDatabase::CreateCache<PixelCrushers.DialogueSystem.Conversation>(System.Collections.Generic.List`1<T>)
IL_007d: stfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversationTitleCache
IL_0082: ret
METHOD System.Collections.Generic.Dictionary`2<System.String,T> PixelCrushers.DialogueSystem.DialogueDatabase::CreateCache(System.Collections.Generic.List`1<T>) | attributes=Private, HideBySig | impl=IL
IL_0000: ldtoken T
IL_0005: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_000a: ldtoken PixelCrushers.DialogueSystem.Conversation
IL_000f: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0014: call System.Boolean System.Type::op_Equality(System.Type,System.Type)
IL_0019: stloc.0
IL_001a: newobj System.Void System.Collections.Generic.Dictionary`2<System.String,T>::.ctor()
IL_001f: stloc.1
IL_0020: call System.Boolean UnityEngine.Application::get_isPlaying()
IL_0025: brfalse.s IL_0075
IL_0027: ldc.i4.0
IL_0028: stloc.2
IL_0029: br.s IL_006c
IL_002b: ldarg.1
IL_002c: ldloc.2
IL_002d: callvirt !0 System.Collections.Generic.List`1<T>::get_Item(System.Int32)
IL_0032: stloc.3
IL_0033: ldloc.0
IL_0034: brtrue.s IL_0043
IL_0036: ldloc.3
IL_0037: box T
IL_003c: callvirt System.String PixelCrushers.DialogueSystem.Asset::get_Name()
IL_0041: br.s IL_0053
IL_0043: ldloc.3
IL_0044: box T
IL_0049: isinst PixelCrushers.DialogueSystem.Conversation
IL_004e: callvirt System.String PixelCrushers.DialogueSystem.Conversation::get_Title()
IL_0053: stloc.s V_4
IL_0055: ldloc.1
IL_0056: ldloc.s V_4
IL_0058: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,T>::ContainsKey(!0)
IL_005d: brtrue.s IL_0068
IL_005f: ldloc.1
IL_0060: ldloc.s V_4
IL_0062: ldloc.3
IL_0063: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,T>::Add(!0,!1)
IL_0068: ldloc.2
IL_0069: ldc.i4.1
IL_006a: add
IL_006b: stloc.2
IL_006c: ldloc.2
IL_006d: ldarg.1
IL_006e: callvirt System.Int32 System.Collections.Generic.List`1<T>::get_Count()
IL_0073: blt.s IL_002b
IL_0075: ldloc.1
IL_0076: ret
METHOD System.Void PixelCrushers.DialogueSystem.DialogueDatabase::ResetCache() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: stfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Actor> PixelCrushers.DialogueSystem.DialogueDatabase::actorNameCache
IL_0007: ldarg.0
IL_0008: ldnull
IL_0009: stfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Item> PixelCrushers.DialogueSystem.DialogueDatabase::itemNameCache
IL_000e: ldarg.0
IL_000f: ldnull
IL_0010: stfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Location> PixelCrushers.DialogueSystem.DialogueDatabase::locationNameCache
IL_0015: ldarg.0
IL_0016: ldnull
IL_0017: stfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Variable> PixelCrushers.DialogueSystem.DialogueDatabase::variableNameCache
IL_001c: ldarg.0
IL_001d: ldnull
IL_001e: stfld System.Collections.Generic.Dictionary`2<System.String,PixelCrushers.DialogueSystem.Conversation> PixelCrushers.DialogueSystem.DialogueDatabase::conversationTitleCache
IL_0023: ret
