TYPE viperTools.viperInput
METHOD System.Single viperTools.viperInput::GetAxis(viperTools.AXIS_INPUT) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.String viperTools.viperInput::ConvertToLegacyAxis(viperTools.AXIS_INPUT)
IL_0006: call System.Single UnityEngine.Input::GetAxis(System.String)
IL_000b: ret
