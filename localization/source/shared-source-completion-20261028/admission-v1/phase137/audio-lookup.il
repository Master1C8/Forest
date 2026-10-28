TYPE DarkTonic.MasterAudio.MasterAudio
METHOD DarkTonic.MasterAudio.PlaySoundResult DarkTonic.MasterAudio.MasterAudio::PlaySoundAtVolume(System.String,System.Single,UnityEngine.Vector3,System.Nullable`1<System.Double>,System.Nullable`1<System.Single>,UnityEngine.Transform,System.String,System.Boolean,System.Single,System.Boolean,System.Boolean,System.Boolean,System.Boolean,System.Boolean) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.s sourceTrans
IL_0003: call System.Boolean DarkTonic.MasterAudio.MasterAudio::IsSoundGroupValidAndReady(System.String,UnityEngine.Transform)
IL_0008: brtrue.s IL_000c
IL_000a: ldnull
IL_000b: ret
IL_000c: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_0011: ldfld System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo> DarkTonic.MasterAudio.MasterAudio::AudioSourcesBySoundType
IL_0016: ldarg.0
IL_0017: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo>::get_Item(!0)
IL_001c: stloc.0
IL_001d: ldloc.0
IL_001e: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_0023: stloc.1
IL_0024: ldloc.0
IL_0025: ldfld System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo> DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Sources
IL_002a: stloc.2
IL_002b: ldloc.1
IL_002c: call System.Boolean DarkTonic.MasterAudio.MasterAudio::LoggingEnabledForGroup(DarkTonic.MasterAudio.MasterAudioGroup)
IL_0031: stloc.3
IL_0032: ldarg.0
IL_0033: ldloc.2
IL_0034: ldloc.3
IL_0035: call System.Boolean DarkTonic.MasterAudio.MasterAudio::SoundGroupHasVariations(System.String,System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>,System.Boolean)
IL_003a: brtrue.s IL_003e
IL_003c: ldnull
IL_003d: ret
IL_003e: ldloc.0
IL_003f: call System.Boolean DarkTonic.MasterAudio.MasterAudio::get_IsWarming()
IL_0044: stfld System.Boolean DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::PlayedForWarming
IL_0049: ldarg.0
IL_004a: ldloc.3
IL_004b: ldloc.1
IL_004c: call System.Void DarkTonic.MasterAudio.MasterAudio::LogIfSilentPlay(System.String,System.Boolean,DarkTonic.MasterAudio.MasterAudioGroup)
IL_0051: ldarg.0
IL_0052: ldloc.1
IL_0053: ldloc.0
IL_0054: ldloc.3
IL_0055: call System.Boolean DarkTonic.MasterAudio.MasterAudio::IsReplayLimited(System.String,DarkTonic.MasterAudio.MasterAudioGroup,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo,System.Boolean)
IL_005a: brfalse.s IL_005e
IL_005c: ldnull
IL_005d: ret
IL_005e: ldarg.s variationName
IL_0060: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0065: stloc.s V_4
IL_0067: ldnull
IL_0068: stloc.s V_5
IL_006a: ldloc.1
IL_006b: ldloc.0
IL_006c: call System.Boolean DarkTonic.MasterAudio.MasterAudio::IsGroupPolyphonyLimited(DarkTonic.MasterAudio.MasterAudioGroup,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo)
IL_0071: brfalse.s IL_00af
IL_0073: ldarg.s variationName
IL_0075: ldloc.s V_4
IL_0077: ldloc.2
IL_0078: ldloc.1
IL_0079: call DarkTonic.MasterAudio.MasterAudio/AudioInfo DarkTonic.MasterAudio.MasterAudio::FindRetriggerableVariationInGroup(System.String,System.Boolean,System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>,DarkTonic.MasterAudio.MasterAudioGroup)
IL_007e: stloc.s V_5
IL_0080: ldloc.s V_5
IL_0082: brtrue.s IL_00af
IL_0084: ldloc.3
IL_0085: brtrue.s IL_008e
IL_0087: call System.Boolean DarkTonic.MasterAudio.MasterAudio::get_LogOutOfVoices()
IL_008c: brfalse.s IL_00af
IL_008e: ldstr "Polyphony limit of group: "
IL_0093: ldloc.0
IL_0094: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_0099: callvirt System.String DarkTonic.MasterAudio.MasterAudioGroup::get_GameObjectName()
IL_009e: ldstr " exceeded and no playing Variation is usable for Retrigger Limit Mode. Will not play this sound for this instance."
IL_00a3: call System.String System.String::Concat(System.String,System.String,System.String)
IL_00a8: call System.Void DarkTonic.MasterAudio.MasterAudio::LogMessage(System.String)
IL_00ad: ldnull
IL_00ae: ret
IL_00af: ldloc.0
IL_00b0: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_00b5: callvirt DarkTonic.MasterAudio.GroupBus DarkTonic.MasterAudio.MasterAudioGroup::get_BusForGroup()
IL_00ba: stloc.s V_6
IL_00bc: ldnull
IL_00bd: stloc.s V_7
IL_00bf: ldloc.s V_6
IL_00c1: call System.Boolean DarkTonic.MasterAudio.MasterAudio::IsBusVoiceLimited(DarkTonic.MasterAudio.GroupBus)
IL_00c6: brfalse.s IL_00f0
IL_00c8: ldloc.s V_6
IL_00ca: ldloc.3
IL_00cb: ldloc.0
IL_00cc: call System.Boolean DarkTonic.MasterAudio.MasterAudio::CanStopLimitedBusVoice(DarkTonic.MasterAudio.GroupBus,System.Boolean,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo)
IL_00d1: brtrue.s IL_00d5
IL_00d3: ldnull
IL_00d4: ret
IL_00d5: ldloc.s V_6
IL_00d7: ldloc.0
IL_00d8: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_00dd: call DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio::FindBusVoiceToStop(DarkTonic.MasterAudio.GroupBus,DarkTonic.MasterAudio.MasterAudioGroup)
IL_00e2: stloc.s V_7
IL_00e4: ldloc.s V_7
IL_00e6: ldnull
IL_00e7: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00ec: brfalse.s IL_00f0
IL_00ee: ldnull
IL_00ef: ret
IL_00f0: ldc.i4.0
IL_00f1: stloc.s V_8
IL_00f3: ldarg.0
IL_00f4: ldloc.2
IL_00f5: ldloc.3
IL_00f6: ldloc.s V_5
IL_00f8: ldloc.1
IL_00f9: ldloca.s V_8
IL_00fb: call DarkTonic.MasterAudio.MasterAudio/AudioInfo DarkTonic.MasterAudio.MasterAudio::UseOnlyVariationIfOnlyOne(System.String,System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>,System.Boolean,DarkTonic.MasterAudio.MasterAudio/AudioInfo,DarkTonic.MasterAudio.MasterAudioGroup,System.Boolean&)
IL_0100: stloc.s V_5
IL_0102: ldnull
IL_0103: stloc.s V_9
IL_0105: ldloca.s V_10
IL_0107: initobj System.Nullable`1<System.Int32>
IL_010d: ldnull
IL_010e: stloc.s V_11
IL_0110: ldc.i4.m1
IL_0111: stloc.s V_12
IL_0113: ldloc.s V_7
IL_0115: ldnull
IL_0116: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_011b: brfalse.s IL_0130
IL_011d: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_0122: ldfld System.Single DarkTonic.MasterAudio.MasterAudio::stopOldestBusFadeTime
IL_0127: ldc.r4 0
IL_012c: ceq
IL_012e: br.s IL_0131
IL_0130: ldc.i4.0
IL_0131: stloc.s V_13
IL_0133: ldarg.0
IL_0134: ldarg.s variationName
IL_0136: ldloc.s V_4
IL_0138: ldloc.s V_13
IL_013a: ldloc.2
IL_013b: ldloc.3
IL_013c: ldloc.s V_7
IL_013e: ldloca.s V_5
IL_0140: ldloca.s V_9
IL_0142: ldloca.s V_10
IL_0144: ldloca.s V_12
IL_0146: ldloca.s V_11
IL_0148: call System.Boolean DarkTonic.MasterAudio.MasterAudio::CanFindVariationToPlay(System.String,System.String,System.Boolean,System.Boolean,System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>,System.Boolean,DarkTonic.MasterAudio.SoundGroupVariation,DarkTonic.MasterAudio.MasterAudio/AudioInfo&,System.Collections.Generic.List`1<System.Int32>&,System.Nullable`1<System.Int32>&,System.Int32&,System.Collections.Generic.List`1<System.Int32>&)
IL_014d: brtrue.s IL_0151
IL_014f: ldnull
IL_0150: ret
IL_0151: ldloc.s V_5
IL_0153: call System.Boolean DarkTonic.MasterAudio.MasterAudio::VariationIsUsable(DarkTonic.MasterAudio.MasterAudio/AudioInfo)
IL_0158: brtrue.s IL_015c
IL_015a: ldnull
IL_015b: ret
IL_015c: ldarg.0
IL_015d: ldarg.1
IL_015e: ldarg.s pitch
IL_0160: ldarg.s sourceTrans
IL_0162: ldarg.s attachToSource
IL_0164: ldarg.s isChaining
IL_0166: ldloc.s V_5
IL_0168: ldloc.3
IL_0169: ldloc.0
IL_016a: ldloc.s V_4
IL_016c: ldloc.s V_10
IL_016e: ldloc.s V_9
IL_0170: ldloc.s V_12
IL_0172: call System.Boolean DarkTonic.MasterAudio.MasterAudio::IsNoClipSilentPlay(System.String,System.Single,System.Nullable`1<System.Single>,UnityEngine.Transform,System.Boolean,System.Boolean,DarkTonic.MasterAudio.MasterAudio/AudioInfo,System.Boolean,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo,System.Boolean,System.Nullable`1<System.Int32>,System.Collections.Generic.List`1<System.Int32>,System.Int32)
IL_0177: brfalse.s IL_017b
IL_0179: ldnull
IL_017a: ret
IL_017b: ldarg.0
IL_017c: ldarg.1
IL_017d: ldarg.s pitch
IL_017f: ldarg.s sourceTrans
IL_0181: ldarg.s attachToSource
IL_0183: ldarg.s isChaining
IL_0185: ldloc.s V_5
IL_0187: ldloc.3
IL_0188: ldloc.0
IL_0189: ldloc.s V_4
IL_018b: ldloc.s V_10
IL_018d: ldloc.s V_9
IL_018f: ldloc.s V_12
IL_0191: call System.Boolean DarkTonic.MasterAudio.MasterAudio::VariationPassesProbabilityToPlayCheck(System.String,System.Single,System.Nullable`1<System.Single>,UnityEngine.Transform,System.Boolean,System.Boolean,DarkTonic.MasterAudio.MasterAudio/AudioInfo,System.Boolean,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo,System.Boolean,System.Nullable`1<System.Int32>,System.Collections.Generic.List`1<System.Int32>,System.Int32)
IL_0196: brtrue.s IL_019a
IL_0198: ldnull
IL_0199: ret
IL_019a: ldarg.0
IL_019b: ldarg.s sourceTrans
IL_019d: ldloc.0
IL_019e: ldloc.s V_5
IL_01a0: ldloc.3
IL_01a1: call System.Boolean DarkTonic.MasterAudio.MasterAudio::IsActorTooFarAwayToPlay(System.String,UnityEngine.Transform,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo,DarkTonic.MasterAudio.MasterAudio/AudioInfo,System.Boolean)
IL_01a6: brfalse.s IL_01aa
IL_01a8: ldnull
IL_01a9: ret
IL_01aa: ldarg.0
IL_01ab: ldloc.0
IL_01ac: ldloc.3
IL_01ad: ldloc.s V_5
IL_01af: call System.Boolean DarkTonic.MasterAudio.MasterAudio::CanPlayDialogBasedOnImportanceOrIsNotDialog(System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo,System.Boolean,DarkTonic.MasterAudio.MasterAudio/AudioInfo)
IL_01b4: brtrue.s IL_01b8
IL_01b6: ldnull
IL_01b7: ret
IL_01b8: ldc.i4.0
IL_01b9: stloc.s V_14
IL_01bb: ldc.i4.0
IL_01bc: stloc.s V_15
IL_01be: ldarg.0
IL_01bf: ldarg.1
IL_01c0: ldarg.2
IL_01c1: ldarg.3
IL_01c2: ldarg.s pitch
IL_01c4: ldarg.s sourceTrans
IL_01c6: ldarg.s attachToSource
IL_01c8: ldarg.s delaySoundTime
IL_01ca: ldarg.s useVector3
IL_01cc: ldarg.s makePlaySoundResult
IL_01ce: ldarg.s isChaining
IL_01d0: ldarg.s isSingleSubscribedPlay
IL_01d2: ldloc.s V_5
IL_01d4: ldloc.s V_7
IL_01d6: ldloc.s V_6
IL_01d8: ldloc.s V_13
IL_01da: ldloc.s V_14
IL_01dc: ldloc.0
IL_01dd: ldloc.s V_4
IL_01df: ldloc.s V_10
IL_01e1: ldloc.s V_9
IL_01e3: ldloc.s V_12
IL_01e5: ldloc.3
IL_01e6: ldloc.s V_8
IL_01e8: ldloc.s V_11
IL_01ea: ldloc.s V_15
IL_01ec: ldloc.2
IL_01ed: ldloca.s V_16
IL_01ef: call DarkTonic.MasterAudio.PlaySoundResult DarkTonic.MasterAudio.MasterAudio::TryPlayVariationOrOtherMatches(System.String,System.Single,UnityEngine.Vector3,System.Nullable`1<System.Double>,System.Nullable`1<System.Single>,UnityEngine.Transform,System.Boolean,System.Single,System.Boolean,System.Boolean,System.Boolean,System.Boolean,DarkTonic.MasterAudio.MasterAudio/AudioInfo,DarkTonic.MasterAudio.SoundGroupVariation,DarkTonic.MasterAudio.GroupBus,System.Boolean,System.Boolean,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo,System.Boolean,System.Nullable`1<System.Int32>,System.Collections.Generic.List`1<System.Int32>,System.Int32,System.Boolean,System.Boolean,System.Collections.Generic.List`1<System.Int32>,System.Boolean,System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>,System.Boolean&)
IL_01f4: stloc.s V_17
IL_01f6: ldloc.s V_16
IL_01f8: brtrue IL_0289
IL_01fd: ldloc.3
IL_01fe: brtrue.s IL_0207
IL_0200: call System.Boolean DarkTonic.MasterAudio.MasterAudio::get_LogOutOfVoices()
IL_0205: brfalse.s IL_0286
IL_0207: ldloc.s V_4
IL_0209: brfalse.s IL_024b
IL_020b: ldc.i4.5
IL_020c: newarr System.String
IL_0211: dup
IL_0212: ldc.i4.0
IL_0213: ldstr "All "
IL_0218: stelem.ref
IL_0219: dup
IL_021a: ldc.i4.1
IL_021b: ldloc.2
IL_021c: callvirt System.Int32 System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::get_Count()
IL_0221: stloc.s V_18
IL_0223: ldloca.s V_18
IL_0225: call System.String System.Int32::ToString()
IL_022a: stelem.ref
IL_022b: dup
IL_022c: ldc.i4.2
IL_022d: ldstr " children of "
IL_0232: stelem.ref
IL_0233: dup
IL_0234: ldc.i4.3
IL_0235: ldarg.0
IL_0236: stelem.ref
IL_0237: dup
IL_0238: ldc.i4.4
IL_0239: ldstr " were busy. Will not play this sound for this instance. If you need more voices, increase the 'Voices (Weight)' field on the Variation(s) in your Sound Group."
IL_023e: stelem.ref
IL_023f: call System.String System.String::Concat(System.String[])
IL_0244: call System.Void DarkTonic.MasterAudio.MasterAudio::LogMessage(System.String)
IL_0249: br.s IL_0286
IL_024b: ldc.i4.5
IL_024c: newarr System.String
IL_0251: dup
IL_0252: ldc.i4.0
IL_0253: ldstr "Child '"
IL_0258: stelem.ref
IL_0259: dup
IL_025a: ldc.i4.1
IL_025b: ldloc.s V_5
IL_025d: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_0262: callvirt System.String DarkTonic.MasterAudio.SoundGroupVariation::get_GameObjectName()
IL_0267: stelem.ref
IL_0268: dup
IL_0269: ldc.i4.2
IL_026a: ldstr "' of "
IL_026f: stelem.ref
IL_0270: dup
IL_0271: ldc.i4.3
IL_0272: ldarg.0
IL_0273: stelem.ref
IL_0274: dup
IL_0275: ldc.i4.4
IL_0276: ldstr " was busy. Will not play this sound for this instance. If you need more voices, increase the 'Voices (Weight)' field on the Variation(s) in your Sound Group."
IL_027b: stelem.ref
IL_027c: call System.String System.String::Concat(System.String[])
IL_0281: call System.Void DarkTonic.MasterAudio.MasterAudio::LogMessage(System.String)
IL_0286: ldloc.s V_17
IL_0288: ret
IL_0289: ldloc.0
IL_028a: call System.Void DarkTonic.MasterAudio.MasterAudio::SetLastPlayed(DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo)
IL_028f: ldarg.s triggeredAsChildGroup
IL_0291: brtrue IL_0348
IL_0296: call System.Boolean DarkTonic.MasterAudio.MasterAudio::get_IsWarming()
IL_029b: brtrue IL_0348
IL_02a0: ldloc.0
IL_02a1: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_02a6: ldfld DarkTonic.MasterAudio.MasterAudio/LinkedGroupSelectionType DarkTonic.MasterAudio.MasterAudioGroup::linkedStartGroupSelectionType
IL_02ab: stloc.s V_20
IL_02ad: ldloc.s V_20
IL_02af: brfalse.s IL_02bb
IL_02b1: ldloc.s V_20
IL_02b3: ldc.i4.1
IL_02b4: beq.s IL_0306
IL_02b6: br IL_0348
IL_02bb: ldc.i4.0
IL_02bc: stloc.s V_21
IL_02be: br.s IL_02f0
IL_02c0: ldloc.0
IL_02c1: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_02c6: ldfld System.Collections.Generic.List`1<System.String> DarkTonic.MasterAudio.MasterAudioGroup::childSoundGroups
IL_02cb: ldloc.s V_21
IL_02cd: callvirt !0 System.Collections.Generic.List`1<System.String>::get_Item(System.Int32)
IL_02d2: ldarg.1
IL_02d3: ldarg.2
IL_02d4: ldarg.3
IL_02d5: ldarg.s pitch
IL_02d7: ldarg.s sourceTrans
IL_02d9: ldnull
IL_02da: ldarg.s attachToSource
IL_02dc: ldarg.s delaySoundTime
IL_02de: ldarg.s useVector3
IL_02e0: ldc.i4.0
IL_02e1: ldc.i4.0
IL_02e2: ldc.i4.0
IL_02e3: ldc.i4.1
IL_02e4: call DarkTonic.MasterAudio.PlaySoundResult DarkTonic.MasterAudio.MasterAudio::PlaySoundAtVolume(System.String,System.Single,UnityEngine.Vector3,System.Nullable`1<System.Double>,System.Nullable`1<System.Single>,UnityEngine.Transform,System.String,System.Boolean,System.Single,System.Boolean,System.Boolean,System.Boolean,System.Boolean,System.Boolean)
IL_02e9: pop
IL_02ea: ldloc.s V_21
IL_02ec: ldc.i4.1
IL_02ed: add
IL_02ee: stloc.s V_21
IL_02f0: ldloc.s V_21
IL_02f2: ldloc.0
IL_02f3: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_02f8: ldfld System.Collections.Generic.List`1<System.String> DarkTonic.MasterAudio.MasterAudioGroup::childSoundGroups
IL_02fd: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0302: blt.s IL_02c0
IL_0304: br.s IL_0348
IL_0306: ldc.i4.0
IL_0307: ldloc.0
IL_0308: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_030d: ldfld System.Collections.Generic.List`1<System.String> DarkTonic.MasterAudio.MasterAudioGroup::childSoundGroups
IL_0312: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_0317: call System.Int32 UnityEngine.Random::Range(System.Int32,System.Int32)
IL_031c: stloc.s V_19
IL_031e: ldloc.0
IL_031f: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_0324: ldfld System.Collections.Generic.List`1<System.String> DarkTonic.MasterAudio.MasterAudioGroup::childSoundGroups
IL_0329: ldloc.s V_19
IL_032b: callvirt !0 System.Collections.Generic.List`1<System.String>::get_Item(System.Int32)
IL_0330: ldarg.1
IL_0331: ldarg.2
IL_0332: ldarg.3
IL_0333: ldarg.s pitch
IL_0335: ldarg.s sourceTrans
IL_0337: ldnull
IL_0338: ldarg.s attachToSource
IL_033a: ldarg.s delaySoundTime
IL_033c: ldarg.s useVector3
IL_033e: ldc.i4.0
IL_033f: ldc.i4.0
IL_0340: ldc.i4.0
IL_0341: ldc.i4.1
IL_0342: call DarkTonic.MasterAudio.PlaySoundResult DarkTonic.MasterAudio.MasterAudio::PlaySoundAtVolume(System.String,System.Single,UnityEngine.Vector3,System.Nullable`1<System.Double>,System.Nullable`1<System.Single>,UnityEngine.Transform,System.String,System.Boolean,System.Single,System.Boolean,System.Boolean,System.Boolean,System.Boolean,System.Boolean)
IL_0347: pop
IL_0348: ldloc.0
IL_0349: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_034e: ldfld System.Boolean DarkTonic.MasterAudio.MasterAudioGroup::soundPlayedEventActive
IL_0353: brfalse.s IL_0370
IL_0355: ldloc.0
IL_0356: ldfld DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Group
IL_035b: ldfld System.String DarkTonic.MasterAudio.MasterAudioGroup::soundPlayedCustomEvent
IL_0360: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_0365: ldfld UnityEngine.Transform DarkTonic.MasterAudio.MasterAudio::_trans
IL_036a: ldc.i4.1
IL_036b: call System.Void DarkTonic.MasterAudio.MasterAudio::FireCustomEvent(System.String,UnityEngine.Transform,System.Boolean)
IL_0370: ldarg.s makePlaySoundResult
IL_0372: brtrue.s IL_037a
IL_0374: ldsfld DarkTonic.MasterAudio.PlaySoundResult DarkTonic.MasterAudio.MasterAudio::AndForgetSuccessResult
IL_0379: ret
IL_037a: ldloc.s V_17
IL_037c: ret
