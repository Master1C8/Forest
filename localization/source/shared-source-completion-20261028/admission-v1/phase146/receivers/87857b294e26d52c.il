TYPE RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript
METHOD System.Void RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.TMP_Dropdown RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript::examplesDropdown
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_0053
IL_000e: newobj System.Void System.Collections.Generic.List`1<System.String>::.ctor()
IL_0013: stloc.0
IL_0014: ldc.i4.0
IL_0015: stloc.1
IL_0016: br.s IL_0029
IL_0018: ldloc.0
IL_0019: ldarg.0
IL_001a: ldloc.1
IL_001b: call System.String RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript::GetStringFormOfExample(RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript/Examples)
IL_0020: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0025: ldloc.1
IL_0026: ldc.i4.1
IL_0027: add
IL_0028: stloc.1
IL_0029: ldloc.1
IL_002a: ldtoken RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript/Examples
IL_002f: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0034: call System.Array System.Enum::GetValues(System.Type)
IL_0039: callvirt System.Int32 System.Array::get_Length()
IL_003e: blt.s IL_0018
IL_0040: ldarg.0
IL_0041: ldfld TMPro.TMP_Dropdown RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript::examplesDropdown
IL_0046: ldloc.0
IL_0047: callvirt System.Void TMPro.TMP_Dropdown::AddOptions(System.Collections.Generic.List`1<System.String>)
IL_004c: ldarg.0
IL_004d: ldc.i4.0
IL_004e: call System.Void RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript::ExampleDropdownValueChanged(System.Int32)
IL_0053: ret
