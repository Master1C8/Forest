TYPE PixelCrushers.DialogueSystem.DialogueDatabase
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
