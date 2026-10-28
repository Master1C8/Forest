TYPE DarkTonic.MasterAudio.MasterAudio
METHOD System.Boolean DarkTonic.MasterAudio.MasterAudio::PlaySoundAndForget(System.String,System.Single,System.Nullable`1<System.Single>,System.Single,System.String,System.Nullable`1<System.Double>) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean DarkTonic.MasterAudio.MasterAudio::get_SceneHasMasterAudio()
IL_0005: brtrue.s IL_0009
IL_0007: ldc.i4.0
IL_0008: ret
IL_0009: call System.Boolean DarkTonic.MasterAudio.MasterAudio::get_SoundsReady()
IL_000e: brtrue.s IL_0022
IL_0010: ldstr "MasterAudio not finished initializing sounds. Cannot play: "
IL_0015: ldarg.0
IL_0016: call System.String System.String::Concat(System.String,System.String)
IL_001b: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0020: ldc.i4.0
IL_0021: ret
IL_0022: ldarg.0
IL_0023: ldarg.1
IL_0024: call UnityEngine.Vector3 UnityEngine.Vector3::get_zero()
IL_0029: ldarg.s timeToSchedulePlay
IL_002b: ldarg.2
IL_002c: ldnull
IL_002d: ldarg.s variationName
IL_002f: ldc.i4.0
IL_0030: ldarg.3
IL_0031: ldc.i4.0
IL_0032: ldc.i4.0
IL_0033: ldc.i4.0
IL_0034: ldc.i4.0
IL_0035: ldc.i4.0
IL_0036: call DarkTonic.MasterAudio.PlaySoundResult DarkTonic.MasterAudio.MasterAudio::PlaySoundAtVolume(System.String,System.Single,UnityEngine.Vector3,System.Nullable`1<System.Double>,System.Nullable`1<System.Single>,UnityEngine.Transform,System.String,System.Boolean,System.Single,System.Boolean,System.Boolean,System.Boolean,System.Boolean,System.Boolean)
IL_003b: call System.Boolean DarkTonic.MasterAudio.MasterAudio::PSRAsSuccessBool(DarkTonic.MasterAudio.PlaySoundResult)
IL_0040: ret
METHOD System.Void DarkTonic.MasterAudio.MasterAudio::StopAllOfSound(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call System.Boolean DarkTonic.MasterAudio.MasterAudio::get_SceneHasMasterAudio()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldarg.0
IL_0009: ldstr "_VideoPlayers"
IL_000e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0013: brfalse.s IL_0016
IL_0015: ret
IL_0016: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_001b: ldfld System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo> DarkTonic.MasterAudio.MasterAudio::AudioSourcesBySoundType
IL_0020: ldarg.0
IL_0021: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo>::ContainsKey(!0)
IL_0026: brtrue.s IL_003e
IL_0028: ldstr "Could not locate group '"
IL_002d: ldarg.0
IL_002e: ldstr "'."
IL_0033: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0038: call System.Void UnityEngine.Debug::LogWarning(System.Object)
IL_003d: ret
IL_003e: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_0043: ldfld System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo> DarkTonic.MasterAudio.MasterAudio::AudioSourcesBySoundType
IL_0048: ldarg.0
IL_0049: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo>::get_Item(!0)
IL_004e: ldfld System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo> DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Sources
IL_0053: ldarg.0
IL_0054: ldc.i4.1
IL_0055: call DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio::GrabGroup(System.String,System.Boolean)
IL_005a: stloc.0
IL_005b: ldloc.0
IL_005c: ldnull
IL_005d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0062: brfalse.s IL_006f
IL_0064: ldloc.0
IL_0065: ldfld DarkTonic.MasterAudio.MasterAudioGroup/VariationMode DarkTonic.MasterAudio.MasterAudioGroup::curVariationMode
IL_006a: ldc.i4.1
IL_006b: ceq
IL_006d: br.s IL_0070
IL_006f: ldc.i4.0
IL_0070: stloc.1
IL_0071: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::GetEnumerator()
IL_0076: stloc.2
IL_0077: br.s IL_00a9
IL_0079: ldloca.s V_2
IL_007b: call !0 System.Collections.Generic.List`1/Enumerator<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::get_Current()
IL_0080: stloc.3
IL_0081: ldloc.3
IL_0082: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_0087: ldnull
IL_0088: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_008d: brtrue.s IL_00a9
IL_008f: ldloc.3
IL_0090: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_0095: call System.Boolean DarkTonic.MasterAudio.MasterAudio::IsLinkedGroupPlay(DarkTonic.MasterAudio.SoundGroupVariation)
IL_009a: brtrue.s IL_00a9
IL_009c: ldloc.3
IL_009d: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_00a2: ldloc.1
IL_00a3: ldc.i4.0
IL_00a4: callvirt System.Void DarkTonic.MasterAudio.SoundGroupVariation::Stop(System.Boolean,System.Boolean)
IL_00a9: ldloca.s V_2
IL_00ab: call System.Boolean System.Collections.Generic.List`1/Enumerator<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::MoveNext()
IL_00b0: brtrue.s IL_0079
IL_00b2: leave.s IL_00c2
IL_00b4: ldloca.s V_2
IL_00b6: constrained. System.Collections.Generic.List`1/Enumerator<DarkTonic.MasterAudio.MasterAudio/AudioInfo>
IL_00bc: callvirt System.Void System.IDisposable::Dispose()
IL_00c1: endfinally
IL_00c2: ret
METHOD System.Void DarkTonic.MasterAudio.MasterAudio::PauseSoundGroup(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio::GrabGroup(System.String,System.Boolean)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: ldnull
IL_000a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000f: brtrue.s IL_0023
IL_0011: ldloc.0
IL_0012: callvirt System.String DarkTonic.MasterAudio.MasterAudioGroup::get_GameObjectName()
IL_0017: ldstr "_VideoPlayers"
IL_001c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0021: brfalse.s IL_0024
IL_0023: ret
IL_0024: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_0029: ldfld System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo> DarkTonic.MasterAudio.MasterAudio::AudioSourcesBySoundType
IL_002e: ldarg.0
IL_002f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo>::get_Item(!0)
IL_0034: ldfld System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo> DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Sources
IL_0039: stloc.1
IL_003a: ldc.i4.0
IL_003b: stloc.2
IL_003c: br.s IL_0053
IL_003e: ldloc.1
IL_003f: ldloc.2
IL_0040: callvirt !0 System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::get_Item(System.Int32)
IL_0045: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_004a: callvirt System.Void DarkTonic.MasterAudio.SoundGroupVariation::Pause()
IL_004f: ldloc.2
IL_0050: ldc.i4.1
IL_0051: add
IL_0052: stloc.2
IL_0053: ldloc.2
IL_0054: ldloc.1
IL_0055: callvirt System.Int32 System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::get_Count()
IL_005a: blt.s IL_003e
IL_005c: ret
METHOD System.Void DarkTonic.MasterAudio.MasterAudio::UnpauseSoundGroup(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.1
IL_0002: call DarkTonic.MasterAudio.MasterAudioGroup DarkTonic.MasterAudio.MasterAudio::GrabGroup(System.String,System.Boolean)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: ldnull
IL_000a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000f: brtrue.s IL_0023
IL_0011: ldloc.0
IL_0012: callvirt System.String DarkTonic.MasterAudio.MasterAudioGroup::get_GameObjectName()
IL_0017: ldstr "_VideoPlayers"
IL_001c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0021: brfalse.s IL_0024
IL_0023: ret
IL_0024: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_0029: ldfld System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo> DarkTonic.MasterAudio.MasterAudio::AudioSourcesBySoundType
IL_002e: ldarg.0
IL_002f: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo>::get_Item(!0)
IL_0034: ldfld System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo> DarkTonic.MasterAudio.MasterAudio/AudioGroupInfo::Sources
IL_0039: stloc.1
IL_003a: ldc.i4.0
IL_003b: stloc.2
IL_003c: br.s IL_0053
IL_003e: ldloc.1
IL_003f: ldloc.2
IL_0040: callvirt !0 System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::get_Item(System.Int32)
IL_0045: ldfld DarkTonic.MasterAudio.SoundGroupVariation DarkTonic.MasterAudio.MasterAudio/AudioInfo::Variation
IL_004a: callvirt System.Void DarkTonic.MasterAudio.SoundGroupVariation::Unpause()
IL_004f: ldloc.2
IL_0050: ldc.i4.1
IL_0051: add
IL_0052: stloc.2
IL_0053: ldloc.2
IL_0054: ldloc.1
IL_0055: callvirt System.Int32 System.Collections.Generic.List`1<DarkTonic.MasterAudio.MasterAudio/AudioInfo>::get_Count()
IL_005a: blt.s IL_003e
IL_005c: ret
METHOD System.Void DarkTonic.MasterAudio.MasterAudio::AddSoundGroupToDuckList(System.String,System.Single,System.Single,System.Single,System.Boolean) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call DarkTonic.MasterAudio.MasterAudio DarkTonic.MasterAudio.MasterAudio::get_Instance()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldfld System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.DuckGroupInfo> DarkTonic.MasterAudio.MasterAudio::duckingBySoundType
IL_000c: ldarg.0
IL_000d: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.DuckGroupInfo>::ContainsKey(!0)
IL_0012: brfalse.s IL_0015
IL_0014: ret
IL_0015: newobj System.Void DarkTonic.MasterAudio.DuckGroupInfo::.ctor()
IL_001a: dup
IL_001b: ldarg.0
IL_001c: stfld System.String DarkTonic.MasterAudio.DuckGroupInfo::soundType
IL_0021: dup
IL_0022: ldarg.1
IL_0023: stfld System.Single DarkTonic.MasterAudio.DuckGroupInfo::riseVolStart
IL_0028: dup
IL_0029: ldarg.2
IL_002a: stfld System.Single DarkTonic.MasterAudio.DuckGroupInfo::duckedVolumeCut
IL_002f: dup
IL_0030: ldarg.3
IL_0031: stfld System.Single DarkTonic.MasterAudio.DuckGroupInfo::unduckTime
IL_0036: dup
IL_0037: ldarg.s isTemporary
IL_0039: stfld System.Boolean DarkTonic.MasterAudio.DuckGroupInfo::isTemporary
IL_003e: stloc.1
IL_003f: ldloc.0
IL_0040: ldfld System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.DuckGroupInfo> DarkTonic.MasterAudio.MasterAudio::duckingBySoundType
IL_0045: ldarg.0
IL_0046: ldloc.1
IL_0047: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,DarkTonic.MasterAudio.DuckGroupInfo>::Add(!0,!1)
IL_004c: ldloc.0
IL_004d: ldfld System.Collections.Generic.List`1<DarkTonic.MasterAudio.DuckGroupInfo> DarkTonic.MasterAudio.MasterAudio::musicDuckingSounds
IL_0052: ldloc.1
IL_0053: callvirt System.Void System.Collections.Generic.List`1<DarkTonic.MasterAudio.DuckGroupInfo>::Add(!0)
IL_0058: ret
