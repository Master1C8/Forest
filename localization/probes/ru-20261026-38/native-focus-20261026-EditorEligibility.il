TYPE Rewired.ReInput
METHOD System.Boolean Rewired.ReInput::get_isReady()
IL_0000: ldsfld System.Boolean Rewired.ReInput::aLzbAjHdyinuPAkYilYZkIGyBOc
IL_0005: ret
METHOD System.Boolean Rewired.ReInput::get_isEditor()
IL_0000: ldsfld Rewired.Platforms.EditorPlatform Rewired.ReInput::oPUAJMywrLEmBbqmOIkACwccdcP
IL_0005: ldc.i4.0
IL_0006: ceq
IL_0008: ldc.i4.0
IL_0009: ceq
IL_000b: ret
METHOD System.Boolean Rewired.ReInput::get_isAllowedEditorWindowFocused()
IL_0000: ldsfld Rewired.Data.ConfigVars Rewired.ReInput::OJxXokxjIIFupQczlCnOgNGVMwNT
IL_0005: ldfld System.Boolean Rewired.Data.ConfigVars::allowInputInEditorSceneView
IL_000a: brfalse.s IL_001a
IL_000c: call Rewired.Utils.Interfaces.IExternalTools Rewired.Utils.UnityTools::get_externalTools()
IL_0011: callvirt System.Boolean Rewired.Utils.Interfaces.IExternalTools::IsEditorSceneViewFocused()
IL_0016: brfalse.s IL_001a
IL_0018: ldc.i4.1
IL_0019: ret
IL_001a: ldsfld System.Boolean Rewired.ReInput::cbmmwJPDGUhXqzzdtJQPbNHADIB
IL_001f: brtrue.s IL_0027
IL_0021: call System.Boolean Rewired.ReInput::get_isEditorGameViewFocused()
IL_0026: ret
IL_0027: ldc.i4.1
IL_0028: ret
METHOD System.Boolean Rewired.ReInput::get_isUnityEditorFocused()
IL_0000: ldsfld Rewired.PlatformInputManager Rewired.ReInput::EipmgiMCREFLYqaOyKWtcpJhWRc
IL_0005: isinst Rewired.Interfaces.INativePlatformHelper
IL_000a: stloc.0
IL_000b: ldc.i4 313063998
IL_0010: ldc.i4 313063999
IL_0015: xor
IL_0016: switch IL_0033,IL_0029,IL_000b
IL_0027: br.s IL_0033
IL_0029: ldloc.0
IL_002a: brfalse.s IL_003a
IL_002c: ldc.i4 313063999
IL_0031: br.s IL_0010
IL_0033: ldloc.0
IL_0034: callvirt System.Boolean Rewired.Interfaces.INativePlatformHelper::get_isApplicationFocused()
IL_0039: ret
IL_003a: ldsfld System.Boolean Rewired.ReInput::cbmmwJPDGUhXqzzdtJQPbNHADIB
IL_003f: ret
