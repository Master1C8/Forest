TYPE Febucci.UI.Core.TAnimCore
METHOD System.Void Febucci.UI.Core.TAnimCore::Animate(System.Single) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: callvirt System.Boolean Febucci.UI.Core.TAnimCore::IsReady()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld System.Boolean Febucci.UI.Core.TAnimCore::requiresTagRefresh
IL_000f: brfalse.s IL_001e
IL_0011: ldarg.0
IL_0012: ldarg.0
IL_0013: ldfld System.String Febucci.UI.Core.TAnimCore::_text
IL_0018: ldc.i4.3
IL_0019: call System.Void Febucci.UI.Core.TAnimCore::ConvertText(System.String,Febucci.UI.Core.TAnimCore/ShowTextMode)
IL_001e: ldarg.0
IL_001f: ldflda Febucci.UI.TimeData Febucci.UI.Core.TAnimCore::time
IL_0024: ldarg.1
IL_0025: call System.Void Febucci.UI.TimeData::UpdateDeltaTime(System.Single)
IL_002a: ldarg.0
IL_002b: ldflda Febucci.UI.TimeData Febucci.UI.Core.TAnimCore::time
IL_0030: call System.Void Febucci.UI.TimeData::IncreaseTime()
IL_0035: ldarg.0
IL_0036: call System.Void Febucci.UI.Core.TAnimCore::AnimateText()
IL_003b: ret
METHOD System.Void Febucci.UI.Core.TAnimCore::AnimateText() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Boolean Febucci.UI.Core.TAnimCore::get_hasText()
IL_0006: brtrue.s IL_0009
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call System.Void Febucci.UI.Core.TAnimCore::TryInitializing()
IL_000f: ldc.i4.0
IL_0010: stloc.0
IL_0011: br IL_014e
IL_0016: ldarg.0
IL_0017: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_001c: ldloc.0
IL_001d: ldelema Febucci.UI.Core.CharacterData
IL_0022: ldflda Febucci.UI.Core.CharInfo Febucci.UI.Core.CharacterData::info
IL_0027: ldfld System.Boolean Febucci.UI.Core.CharInfo::isRendered
IL_002c: brtrue.s IL_005a
IL_002e: ldarg.0
IL_002f: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_0034: ldloc.0
IL_0035: ldelema Febucci.UI.Core.CharacterData
IL_003a: ldc.r4 0
IL_003f: stfld System.Single Febucci.UI.Core.CharacterData::passedTime
IL_0044: ldarg.0
IL_0045: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_004a: ldloc.0
IL_004b: ldelema Febucci.UI.Core.CharacterData
IL_0050: call System.Void Febucci.UI.Core.CharacterData::Hide()
IL_0055: br IL_014a
IL_005a: ldarg.0
IL_005b: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_0060: ldloc.0
IL_0061: ldelema Febucci.UI.Core.CharacterData
IL_0066: call System.Void Febucci.UI.Core.CharacterData::ResetAnimation()
IL_006b: ldarg.0
IL_006c: ldloc.0
IL_006d: call System.Boolean Febucci.UI.Core.TAnimCore::IsCharacterAppearing(System.Int32)
IL_0072: brfalse.s IL_0099
IL_0074: ldarg.0
IL_0075: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_007a: ldloc.0
IL_007b: ldelema Febucci.UI.Core.CharacterData
IL_0080: ldflda System.Single Febucci.UI.Core.CharacterData::passedTime
IL_0085: dup
IL_0086: ldind.r4
IL_0087: ldarg.0
IL_0088: ldflda Febucci.UI.TimeData Febucci.UI.Core.TAnimCore::time
IL_008d: call System.Single Febucci.UI.TimeData::get_deltaTime()
IL_0092: add
IL_0093: stind.r4
IL_0094: br IL_014a
IL_0099: ldarg.0
IL_009a: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_009f: ldloc.0
IL_00a0: ldelema Febucci.UI.Core.CharacterData
IL_00a5: ldfld System.Single Febucci.UI.Core.CharacterData::passedTime
IL_00aa: ldarg.0
IL_00ab: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_00b0: ldloc.0
IL_00b1: ldelema Febucci.UI.Core.CharacterData
IL_00b6: ldflda Febucci.UI.Core.CharInfo Febucci.UI.Core.CharacterData::info
IL_00bb: ldfld System.Single Febucci.UI.Core.CharInfo::disappearancesMaxDuration
IL_00c0: ble.un.s IL_00eb
IL_00c2: ldarg.0
IL_00c3: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_00c8: ldloc.0
IL_00c9: ldelema Febucci.UI.Core.CharacterData
IL_00ce: ldarg.0
IL_00cf: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_00d4: ldloc.0
IL_00d5: ldelema Febucci.UI.Core.CharacterData
IL_00da: ldflda Febucci.UI.Core.CharInfo Febucci.UI.Core.CharacterData::info
IL_00df: ldfld System.Single Febucci.UI.Core.CharInfo::disappearancesMaxDuration
IL_00e4: stfld System.Single Febucci.UI.Core.CharacterData::passedTime
IL_00e9: br.s IL_010b
IL_00eb: ldarg.0
IL_00ec: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_00f1: ldloc.0
IL_00f2: ldelema Febucci.UI.Core.CharacterData
IL_00f7: ldflda System.Single Febucci.UI.Core.CharacterData::passedTime
IL_00fc: dup
IL_00fd: ldind.r4
IL_00fe: ldarg.0
IL_00ff: ldflda Febucci.UI.TimeData Febucci.UI.Core.TAnimCore::time
IL_0104: call System.Single Febucci.UI.TimeData::get_deltaTime()
IL_0109: sub
IL_010a: stind.r4
IL_010b: ldarg.0
IL_010c: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_0111: ldloc.0
IL_0112: ldelema Febucci.UI.Core.CharacterData
IL_0117: ldfld System.Single Febucci.UI.Core.CharacterData::passedTime
IL_011c: ldc.r4 0
IL_0121: bgt.un.s IL_014a
IL_0123: ldarg.0
IL_0124: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_0129: ldloc.0
IL_012a: ldelema Febucci.UI.Core.CharacterData
IL_012f: ldc.r4 0
IL_0134: stfld System.Single Febucci.UI.Core.CharacterData::passedTime
IL_0139: ldarg.0
IL_013a: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_013f: ldloc.0
IL_0140: ldelema Febucci.UI.Core.CharacterData
IL_0145: call System.Void Febucci.UI.Core.CharacterData::Hide()
IL_014a: ldloc.0
IL_014b: ldc.i4.1
IL_014c: add
IL_014d: stloc.0
IL_014e: ldloc.0
IL_014f: ldarg.0
IL_0150: ldfld System.Int32 Febucci.UI.Core.TAnimCore::charactersCount
IL_0155: bge.s IL_0165
IL_0157: ldloc.0
IL_0158: ldarg.0
IL_0159: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_015e: ldlen
IL_015f: conv.i4
IL_0160: blt IL_0016
IL_0165: ldarg.0
IL_0166: call System.Void Febucci.UI.Core.TAnimCore::UpdateUniformIntensity()
IL_016b: ldarg.0
IL_016c: ldfld System.Boolean Febucci.UI.Core.TAnimCore::isAnimatingBehaviors
IL_0171: brfalse.s IL_0191
IL_0173: ldarg.0
IL_0174: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_0179: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase> Febucci.UI.TextAnimatorSettings::behaviors
IL_017e: ldfld System.Boolean Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase>::enabled
IL_0183: brfalse.s IL_0191
IL_0185: ldarg.0
IL_0186: ldarg.0
IL_0187: ldfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::behaviors
IL_018c: call System.Void Febucci.UI.Core.TAnimCore::ProcessAnimationRegions(Febucci.UI.Core.Parsing.AnimationRegion[])
IL_0191: ldarg.0
IL_0192: ldfld System.Boolean Febucci.UI.Core.TAnimCore::isAnimatingAppearances
IL_0197: brfalse.s IL_01c3
IL_0199: ldarg.0
IL_019a: ldfld Febucci.UI.TextAnimatorSettings Febucci.UI.Core.TAnimCore::settings
IL_019f: ldflda Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase> Febucci.UI.TextAnimatorSettings::appearances
IL_01a4: ldfld System.Boolean Febucci.UI.TextAnimatorSettings/Category`1<Febucci.UI.Effects.AnimationsDatabase>::enabled
IL_01a9: brfalse.s IL_01c3
IL_01ab: ldarg.0
IL_01ac: ldarg.0
IL_01ad: ldfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::appearances
IL_01b2: call System.Void Febucci.UI.Core.TAnimCore::ProcessAnimationRegions(Febucci.UI.Core.Parsing.AnimationRegion[])
IL_01b7: ldarg.0
IL_01b8: ldarg.0
IL_01b9: ldfld Febucci.UI.Core.Parsing.AnimationRegion[] Febucci.UI.Core.TAnimCore::disappearances
IL_01be: call System.Void Febucci.UI.Core.TAnimCore::ProcessAnimationRegions(Febucci.UI.Core.Parsing.AnimationRegion[])
IL_01c3: ldarg.0
IL_01c4: ldarg.0
IL_01c5: ldfld Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_01ca: callvirt System.Void Febucci.UI.Core.TAnimCore::PasteMeshToSource(Febucci.UI.Core.CharacterData[])
IL_01cf: ldarg.0
IL_01d0: ldfld System.Boolean Febucci.UI.Core.TAnimCore::requiresMeshUpdate
IL_01d5: brtrue.s IL_01df
IL_01d7: ldarg.0
IL_01d8: callvirt System.Boolean Febucci.UI.Core.TAnimCore::HasChangedRenderingSettings()
IL_01dd: brfalse.s IL_01f1
IL_01df: ldarg.0
IL_01e0: call System.Void Febucci.UI.Core.TAnimCore::ForceMeshUpdate()
IL_01e5: ldarg.0
IL_01e6: ldarg.0
IL_01e7: ldflda Febucci.UI.Core.CharacterData[] Febucci.UI.Core.TAnimCore::characters
IL_01ec: callvirt System.Void Febucci.UI.Core.TAnimCore::CopyMeshFromSource(Febucci.UI.Core.CharacterData[]&)
IL_01f1: ret
