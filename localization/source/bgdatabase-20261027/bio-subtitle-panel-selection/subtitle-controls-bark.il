TYPE PixelCrushers.DialogueSystem.StandardUISubtitleControls
METHOD System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitleControls::DialogueActorUsesBarkUI(PixelCrushers.DialogueSystem.DialogueActor) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_0013
IL_0009: ldarg.1
IL_000a: callvirt PixelCrushers.DialogueSystem.SubtitlePanelNumber PixelCrushers.DialogueSystem.DialogueActor::GetSubtitlePanelNumber()
IL_000f: ldc.i4.1
IL_0010: ceq
IL_0012: ret
IL_0013: ldc.i4.0
IL_0014: ret
METHOD System.Boolean PixelCrushers.DialogueSystem.StandardUISubtitleControls::SubtitleUsesBarkUI(PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0005
IL_0003: ldc.i4.0
IL_0004: ret
IL_0005: ldarg.0
IL_0006: ldfld System.Collections.Generic.List`1<UnityEngine.Transform> PixelCrushers.DialogueSystem.StandardUISubtitleControls::m_useBarkUIs
IL_000b: ldarg.1
IL_000c: ldfld PixelCrushers.DialogueSystem.CharacterInfo PixelCrushers.DialogueSystem.Subtitle::speakerInfo
IL_0011: ldfld UnityEngine.Transform PixelCrushers.DialogueSystem.CharacterInfo::transform
IL_0016: callvirt System.Boolean System.Collections.Generic.List`1<UnityEngine.Transform>::Contains(!0)
IL_001b: ret
