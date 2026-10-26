TYPE TheForestOfLove.InventoryInfoTicker
METHOD System.Void TheForestOfLove.InventoryInfoTicker::RandomizeGlitchItemInfoTickerText() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.GameObject TheForestOfLove.InventoryInfoTicker::glitchItemInfoTicker
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_001b
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.GameObject TheForestOfLove.InventoryInfoTicker::glitchItemInfoTicker
IL_0014: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0019: brtrue.s IL_001c
IL_001b: ret
IL_001c: ldstr "NullReferenceException: Object reference not set to an instance of an object
TheForestOfLove.Graphs.Graph.DoWakeUpEdges (System.Collections.Generic.List`1[T] inEdges, System.Collections.Generic.List`1[T] ok, System.Collections.Generic.List`1[T] error, System.Boolean inEdgesUsedToBeValid) (at <b82d8d0a349d4d70807c2fc5746a710f>:0)
at (wrapper managed-to-native) System.Reflection.MonoMethod.InternalInvoke(System.Reflection.MonoMethod,object,object[],System.Exception&)
at System.MonoMethod.Invoke (System.Object obj, System.Reflection.BindingFlags invokeAttr, System.Object[] parameters) [0x00032] in <695d1cc93cca45069c528c15c9fdd749>:0 
"
IL_0021: stloc.0
IL_0022: ldloc.0
IL_0023: ldc.i4.s 10
IL_0025: ldc.i4.s 32
IL_0027: callvirt System.String System.String::Replace(System.Char,System.Char)
IL_002c: ldc.i4.0
IL_002d: ldloc.0
IL_002e: callvirt System.Int32 System.String::get_Length()
IL_0033: ldarg.0
IL_0034: ldfld System.Int32 TheForestOfLove.InventoryInfoTicker::glitchInfoTickerSubstringLength
IL_0039: sub
IL_003a: ldc.i4.1
IL_003b: sub
IL_003c: call System.Int32 UnityEngine.Random::Range(System.Int32,System.Int32)
IL_0041: ldarg.0
IL_0042: ldfld System.Int32 TheForestOfLove.InventoryInfoTicker::glitchInfoTickerSubstringLength
IL_0047: callvirt System.String System.String::Substring(System.Int32,System.Int32)
IL_004c: stloc.1
IL_004d: ldarg.0
IL_004e: ldfld TMPro.TMP_Text TheForestOfLove.InventoryInfoTicker::glitchItemInfoTickerText
IL_0053: ldloc.1
IL_0054: ldstr " <color="purple">(Use Me)</color>"
IL_0059: call System.String System.String::Concat(System.String,System.String)
IL_005e: callvirt System.Void TMPro.TMP_Text::set_text(System.String)
IL_0063: ldarg.0
IL_0064: ldfld System.Single TheForestOfLove.InventoryInfoTicker::glitchInfoTickerRandomizeInterval
IL_0069: ldarg.0
IL_006a: ldftn System.Void TheForestOfLove.InventoryInfoTicker::RandomizeGlitchItemInfoTickerText()
IL_0070: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0075: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_007a: ret
