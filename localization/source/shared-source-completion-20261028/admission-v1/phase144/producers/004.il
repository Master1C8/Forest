TYPE RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript
METHOD System.String RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript::GetStringFormOfExample(RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript/Examples) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: switch IL_0024,IL_002a,IL_0030,IL_0036,IL_003c,IL_0042,IL_0048
IL_0022: br.s IL_004e
IL_0024: ldstr "Points In Circle"
IL_0029: ret
IL_002a: ldstr "Cone 3D"
IL_002f: ret
IL_0030: ldstr "Cone 2D"
IL_0035: ret
IL_0036: ldstr "Cylinder"
IL_003b: ret
IL_003c: ldstr "Mesh Face and Normal"
IL_0041: ret
IL_0042: ldstr "Weighted Randomizer"
IL_0047: ret
IL_0048: ldstr "Random Int"
IL_004d: ret
IL_004e: ldarga.s example
IL_0050: constrained. RandomUltimate.Demo.RandomUltimateDemo_DemoCanvasScript/Examples
IL_0056: callvirt System.String System.Object::ToString()
IL_005b: ret
