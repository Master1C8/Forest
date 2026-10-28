TYPE DarkTonic.MasterAudio.MasterAudio
METHOD System.Boolean DarkTonic.MasterAudio.MasterAudio::CanFindVariationToPlay(System.String,System.String,System.Boolean,System.Boolean,System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>,System.Boolean,DarkTonic.MasterAudio.SoundGroupVariation,DarkTonic.MasterAudio.MasterAudio/AudioInfo&,System.Collections.Generic.List`1<System.Int32>&,System.Nullable`1<System.Int32>&,System.Int32&,System.Collections.Generic.List`1<System.Int32>&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.s randomSource
IL_0002: ldind.ref
IL_0003: brfalse.s IL_0007
IL_0005: ldc.i4.1
IL_0006: ret
IL_0007: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_000c: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<System.Int32>> DarkTonic.MasterAudio.MasterAudio::_randomizer
IL_0011: ldarg.0
IL_0012: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<System.Int32>>::ContainsKey(!0)
IL_0017: brtrue.s IL_0030
IL_0019: ldstr "Sound Group '"
IL_001e: ldarg.0
IL_001f: ldstr "' has no active Variations."
IL_0024: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0029: call System.Void UnityEngine.Debug::Log(System.Object)
IL_002e: ldc.i4.0
IL_002f: ret
IL_0030: ldarg.2
IL_0031: brfalse IL_00be
IL_0036: ldarg.s choices
IL_0038: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_003d: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<System.Int32>> DarkTonic.MasterAudio.MasterAudio::_randomizer
IL_0042: ldarg.0
IL_0043: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<System.Int32>>::get_Item(!0)
IL_0048: stind.ref
IL_0049: ldarg.s randomIndex
IL_004b: ldc.i4.0
IL_004c: newobj System.Void System.Nullable`1<System.Int32>::.ctor(!0)
IL_0051: stobj System.Nullable`1<System.Int32>
IL_0056: ldarg.s pickedChoice
IL_0058: ldarg.s choices
IL_005a: ldind.ref
IL_005b: ldarg.s randomIndex
IL_005d: call !0 System.Nullable`1<System.Int32>::get_Value()
IL_0062: callvirt !0 System.Collections.Generic.List`1<System.Int32>::get_Item(System.Int32)
IL_0067: stind.i4
IL_0068: ldarg.s randomSource
IL_006a: ldarg.s sources
IL_006c: ldarg.s pickedChoice
IL_006e: ldind.i4
IL_006f: callvirt !0 System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::get_Item(System.Int32)
IL_0074: stind.ref
IL_0075: ldarg.s otherChoices
IL_0077: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_007c: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<System.Int32>> DarkTonic.MasterAudio.MasterAudio::_randomizerLeftovers
IL_0081: ldarg.0
IL_0082: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<System.Int32>>::get_Item(!0)
IL_0087: stind.ref
IL_0088: ldarg.s otherChoices
IL_008a: ldind.ref
IL_008b: ldarg.s pickedChoice
IL_008d: ldind.i4
IL_008e: callvirt System.Boolean System.Collections.Generic.List`1<System.Int32>::Remove(!0)
IL_0093: pop
IL_0094: ldarg.s loggingEnabledForGrp
IL_0096: brfalse.s IL_00bc
IL_0098: ldstr "Cueing child {0} of {1}"
IL_009d: ldarg.s choices
IL_009f: ldind.ref
IL_00a0: ldarg.s randomIndex
IL_00a2: call !0 System.Nullable`1<System.Int32>::get_Value()
IL_00a7: callvirt !0 System.Collections.Generic.List`1<System.Int32>::get_Item(System.Int32)
IL_00ac: box System.Int32
IL_00b1: ldarg.0
IL_00b2: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_00b7: call System.Void DarkTonic.MasterAudio.MasterAudio::LogMessage(System.String)
IL_00bc: ldc.i4.1
IL_00bd: ret
IL_00be: ldc.i4.0
IL_00bf: stloc.0
IL_00c0: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_00c5: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<System.Int32>> DarkTonic.MasterAudio.MasterAudio::_nonRandomChoices
IL_00ca: ldarg.0
IL_00cb: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<System.Int32>>::get_Item(!0)
IL_00d0: stloc.1
IL_00d1: ldloc.1
IL_00d2: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Clear()
IL_00d7: ldc.i4.0
IL_00d8: stloc.2
IL_00d9: br.s IL_014a
IL_00db: ldarg.s sources
IL_00dd: ldloc.2
IL_00de: callvirt !0 System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::get_Item(System.Int32)
IL_00e3: stloc.3
IL_00e4: ldloc.3
IL_00e5: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_00ea: ldfld System.String DarkTonic.MasterAudio.SoundGroupVariation::clipAlias
IL_00ef: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00f4: brtrue.s IL_0109
IL_00f6: ldloc.3
IL_00f7: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_00fc: ldfld System.String DarkTonic.MasterAudio.SoundGroupVariation::clipAlias
IL_0101: ldarg.1
IL_0102: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0107: brtrue.s IL_011c
IL_0109: ldloc.3
IL_010a: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_010f: callvirt System.String DarkTonic.MasterAudio.SoundGroupVariation::get_GameObjectName()
IL_0114: ldarg.1
IL_0115: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_011a: brfalse.s IL_0146
IL_011c: ldloc.0
IL_011d: ldc.i4.1
IL_011e: add
IL_011f: stloc.0
IL_0120: ldloc.3
IL_0121: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_0126: callvirt System.Boolean DarkTonic.MasterAudio.SoundGroupVariation::get_IsAvailableToPlay()
IL_012b: brtrue.s IL_013f
IL_012d: ldarg.3
IL_012e: brfalse.s IL_0146
IL_0130: ldloc.3
IL_0131: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_0136: ldarg.s busVoiceToStop
IL_0138: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_013d: brfalse.s IL_0146
IL_013f: ldloc.1
IL_0140: ldloc.2
IL_0141: callvirt System.Void System.Collections.Generic.List`1<System.Int32>::Add(!0)
IL_0146: ldloc.2
IL_0147: ldc.i4.1
IL_0148: add
IL_0149: stloc.2
IL_014a: ldloc.2
IL_014b: ldarg.s sources
IL_014d: callvirt System.Int32 System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::get_Count()
IL_0152: blt.s IL_00db
IL_0154: ldloc.0
IL_0155: brtrue.s IL_0173
IL_0157: ldarg.s loggingEnabledForGrp
IL_0159: brfalse.s IL_0171
IL_015b: ldstr "Can't find variation '"
IL_0160: ldarg.1
IL_0161: ldstr "' of "
IL_0166: ldarg.0
IL_0167: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_016c: call System.Void DarkTonic.MasterAudio.MasterAudio::LogMessage(System.String)
IL_0171: ldc.i4.0
IL_0172: ret
IL_0173: ldloc.1
IL_0174: callvirt System.Int32 System.Collections.Generic.List`1<System.Int32>::get_Count()
IL_0179: brtrue.s IL_019e
IL_017b: ldarg.s loggingEnabledForGrp
IL_017d: brtrue.s IL_0186
IL_017f: call System.Boolean DarkTonic.MasterAudio.MasterAudio::get_LogOutOfVoices()
IL_0184: brfalse.s IL_019c
IL_0186: ldstr "Can't find non-busy variation '"
IL_018b: ldarg.1
IL_018c: ldstr "' of "
IL_0191: ldarg.0
IL_0192: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_0197: call System.Void DarkTonic.MasterAudio.MasterAudio::LogMessage(System.String)
IL_019c: ldc.i4.0
IL_019d: ret
IL_019e: ldloc.1
IL_019f: callvirt System.Int32 System.Collections.Generic.List`1<System.Int32>::get_Count()
IL_01a4: ldc.i4.1
IL_01a5: bne.un.s IL_01b6
IL_01a7: ldarg.s randomIndex
IL_01a9: ldc.i4.0
IL_01aa: newobj System.Void System.Nullable`1<System.Int32>::.ctor(!0)
IL_01af: stobj System.Nullable`1<System.Int32>
IL_01b4: br.s IL_01ce
IL_01b6: ldarg.s randomIndex
IL_01b8: ldc.i4.0
IL_01b9: ldloc.1
IL_01ba: callvirt System.Int32 System.Collections.Generic.List`1<System.Int32>::get_Count()
IL_01bf: call System.Int32 UnityEngine.Random::Range(System.Int32,System.Int32)
IL_01c4: newobj System.Void System.Nullable`1<System.Int32>::.ctor(!0)
IL_01c9: stobj System.Nullable`1<System.Int32>
IL_01ce: ldarg.s pickedChoice
IL_01d0: ldloc.1
IL_01d1: ldarg.s randomIndex
IL_01d3: call !0 System.Nullable`1<System.Int32>::get_Value()
IL_01d8: callvirt !0 System.Collections.Generic.List`1<System.Int32>::get_Item(System.Int32)
IL_01dd: stind.i4
IL_01de: ldarg.s randomSource
IL_01e0: ldarg.s sources
IL_01e2: ldarg.s pickedChoice
IL_01e4: ldind.i4
IL_01e5: callvirt !0 System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::get_Item(System.Int32)
IL_01ea: stind.ref
IL_01eb: ldloc.1
IL_01ec: ldarg.s pickedChoice
IL_01ee: ldind.i4
IL_01ef: callvirt System.Boolean System.Collections.Generic.List`1<System.Int32>::Remove(!0)
IL_01f4: pop
IL_01f5: ldarg.s otherChoices
IL_01f7: ldloc.1
IL_01f8: stind.ref
IL_01f9: ldarg.s loggingEnabledForGrp
IL_01fb: brfalse.s IL_021a
IL_01fd: ldstr "Cueing child named '{0}' of {1}"
IL_0202: ldarg.s randomSource
IL_0204: ldind.ref
IL_0205: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_020a: callvirt System.String DarkTonic.MasterAudio.SoundGroupVariation::get_GameObjectName()
IL_020f: ldarg.0
IL_0210: call System.String System.String::Format(System.String,System.Object,System.Object)
IL_0215: call System.Void DarkTonic.MasterAudio.MasterAudio::LogMessage(System.String)
IL_021a: ldc.i4.1
IL_021b: ret
