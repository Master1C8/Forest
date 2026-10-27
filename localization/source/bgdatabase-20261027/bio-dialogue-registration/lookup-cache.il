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
