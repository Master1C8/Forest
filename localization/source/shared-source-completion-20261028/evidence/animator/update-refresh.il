TYPE Febucci.UI.Core.TAnimCore
METHOD System.Void Febucci.UI.Core.TAnimCore::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Boolean Febucci.UI.Core.TAnimCore::IsReady()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldarg.0
IL_000b: call System.String Febucci.UI.Core.TAnimCore::get_textWithoutTextAnimTags()
IL_0010: callvirt System.Boolean Febucci.UI.Core.TAnimCore::HasChangedText(System.String)
IL_0015: brfalse.s IL_0047
IL_0017: ldarg.0
IL_0018: ldfld System.Boolean Febucci.UI.Core.TAnimCore::typewriterStartsAutomatically
IL_001d: brfalse.s IL_0039
IL_001f: ldarg.0
IL_0020: call Febucci.UI.Core.TypewriterCore Febucci.UI.Core.TAnimCore::get_typewriter()
IL_0025: call System.Boolean UnityEngine.Object::op_Implicit(UnityEngine.Object)
IL_002a: brfalse.s IL_0039
IL_002c: ldarg.0
IL_002d: ldarg.0
IL_002e: callvirt System.String Febucci.UI.Core.TAnimCore::GetOriginalTextFromSource()
IL_0033: call System.Void Febucci.UI.Core.TAnimCore::SetTypewriterText(System.String)
IL_0038: ret
IL_0039: ldarg.0
IL_003a: ldarg.0
IL_003b: callvirt System.String Febucci.UI.Core.TAnimCore::GetOriginalTextFromSource()
IL_0040: ldc.i4.2
IL_0041: call System.Void Febucci.UI.Core.TAnimCore::ConvertText(System.String,Febucci.UI.Core.TAnimCore/ShowTextMode)
IL_0046: ret
IL_0047: ldarg.0
IL_0048: ldfld Febucci.UI.AnimationLoop Febucci.UI.Core.TAnimCore::animationLoop
IL_004d: brtrue.s IL_006a
IL_004f: ldarg.0
IL_0050: ldarg.0
IL_0051: ldfld Febucci.UI.TimeScale Febucci.UI.Core.TAnimCore::timeScale
IL_0056: ldc.i4.1
IL_0057: beq.s IL_0060
IL_0059: call System.Single UnityEngine.Time::get_deltaTime()
IL_005e: br.s IL_0065
IL_0060: call System.Single UnityEngine.Time::get_unscaledDeltaTime()
IL_0065: call System.Void Febucci.UI.Core.TAnimCore::Animate(System.Single)
IL_006a: ret
METHOD System.Void Febucci.UI.Core.TAnimCore::LateUpdate() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld Febucci.UI.AnimationLoop Febucci.UI.Core.TAnimCore::animationLoop
IL_0006: ldc.i4.1
IL_0007: bne.un.s IL_0024
IL_0009: ldarg.0
IL_000a: ldarg.0
IL_000b: ldfld Febucci.UI.TimeScale Febucci.UI.Core.TAnimCore::timeScale
IL_0010: ldc.i4.1
IL_0011: beq.s IL_001a
IL_0013: call System.Single UnityEngine.Time::get_deltaTime()
IL_0018: br.s IL_001f
IL_001a: call System.Single UnityEngine.Time::get_unscaledDeltaTime()
IL_001f: call System.Void Febucci.UI.Core.TAnimCore::Animate(System.Single)
IL_0024: ret
