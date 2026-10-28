TYPE viperTools.viperInput
METHOD System.String viperTools.viperInput::ConvertToLegacyAxis(viperTools.AXIS_INPUT) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: switch IL_0020,IL_0026,IL_002c,IL_0032,IL_0038,IL_003e
IL_001e: br.s IL_0044
IL_0020: ldstr "Horizontal"
IL_0025: ret
IL_0026: ldstr "Vertical"
IL_002b: ret
IL_002c: ldstr "Horizontal"
IL_0031: ret
IL_0032: ldstr "Vertical"
IL_0037: ret
IL_0038: ldstr "Horizontal"
IL_003d: ret
IL_003e: ldstr "Vertical"
IL_0043: ret
IL_0044: ldstr "Horizontal"
IL_0049: ret
