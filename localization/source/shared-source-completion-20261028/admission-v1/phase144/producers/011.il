TYPE TheForestOfLove.Audio.MasterAudioPrefabDropper
METHOD System.Void TheForestOfLove.Audio.MasterAudioPrefabDropper::Awake() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: newobj System.Void UnityEngine.GameObject::.ctor()
IL_0006: stfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_000b: ldarg.0
IL_000c: ldfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_0011: ldstr "Container"
IL_0016: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_001b: ldarg.0
IL_001c: ldfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_0021: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0026: ldarg.0
IL_0027: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_002c: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0031: ldarg.0
IL_0032: ldfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_0037: ldc.i4.0
IL_0038: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_003d: call !!0 UnityEngine.Object::FindObjectOfType<DarkTonic.MasterAudio.MasterAudio>()
IL_0042: ldnull
IL_0043: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0048: brfalse.s IL_0086
IL_004a: ldarg.0
IL_004b: ldfld DarkTonic.MasterAudio.MasterAudio TheForestOfLove.Audio.MasterAudioPrefabDropper::masterAudio
IL_0050: ldarg.0
IL_0051: ldfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_0056: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_005b: call !!0 UnityEngine.Object::Instantiate<DarkTonic.MasterAudio.MasterAudio>(!!0,UnityEngine.Transform)
IL_0060: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0065: dup
IL_0066: dup
IL_0067: callvirt System.String UnityEngine.Object::get_name()
IL_006c: ldstr "(Clone)"
IL_0071: ldsfld System.String System.String::Empty
IL_0076: callvirt System.String System.String::Replace(System.String,System.String)
IL_007b: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_0080: ldnull
IL_0081: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0086: call !!0 UnityEngine.Object::FindObjectOfType<DarkTonic.MasterAudio.PlaylistController>()
IL_008b: ldnull
IL_008c: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0091: brfalse IL_01b2
IL_0096: ldarg.0
IL_0097: ldfld DarkTonic.MasterAudio.PlaylistController TheForestOfLove.Audio.MasterAudioPrefabDropper::primaryController
IL_009c: ldarg.0
IL_009d: ldfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_00a2: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_00a7: call !!0 UnityEngine.Object::Instantiate<DarkTonic.MasterAudio.PlaylistController>(!!0,UnityEngine.Transform)
IL_00ac: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00b1: dup
IL_00b2: dup
IL_00b3: callvirt System.String UnityEngine.Object::get_name()
IL_00b8: ldstr "(Clone)"
IL_00bd: ldsfld System.String System.String::Empty
IL_00c2: callvirt System.String System.String::Replace(System.String,System.String)
IL_00c7: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_00cc: dup
IL_00cd: ldnull
IL_00ce: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_00d3: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00d8: call System.Void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)
IL_00dd: ldarg.0
IL_00de: ldfld DarkTonic.MasterAudio.PlaylistController TheForestOfLove.Audio.MasterAudioPrefabDropper::secondaryController
IL_00e3: ldarg.0
IL_00e4: ldfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_00e9: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_00ee: call !!0 UnityEngine.Object::Instantiate<DarkTonic.MasterAudio.PlaylistController>(!!0,UnityEngine.Transform)
IL_00f3: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_00f8: dup
IL_00f9: dup
IL_00fa: callvirt System.String UnityEngine.Object::get_name()
IL_00ff: ldstr "(Clone)"
IL_0104: ldsfld System.String System.String::Empty
IL_0109: callvirt System.String System.String::Replace(System.String,System.String)
IL_010e: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_0113: dup
IL_0114: ldnull
IL_0115: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_011a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_011f: call System.Void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)
IL_0124: ldarg.0
IL_0125: ldfld DarkTonic.MasterAudio.PlaylistController TheForestOfLove.Audio.MasterAudioPrefabDropper::tertiaryController
IL_012a: ldarg.0
IL_012b: ldfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_0130: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0135: call !!0 UnityEngine.Object::Instantiate<DarkTonic.MasterAudio.PlaylistController>(!!0,UnityEngine.Transform)
IL_013a: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_013f: dup
IL_0140: dup
IL_0141: callvirt System.String UnityEngine.Object::get_name()
IL_0146: ldstr "(Clone)"
IL_014b: ldsfld System.String System.String::Empty
IL_0150: callvirt System.String System.String::Replace(System.String,System.String)
IL_0155: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_015a: dup
IL_015b: ldnull
IL_015c: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0161: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0166: call System.Void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)
IL_016b: ldarg.0
IL_016c: ldfld DarkTonic.MasterAudio.PlaylistController TheForestOfLove.Audio.MasterAudioPrefabDropper::fourthiaryController
IL_0171: ldarg.0
IL_0172: ldfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_0177: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_017c: call !!0 UnityEngine.Object::Instantiate<DarkTonic.MasterAudio.PlaylistController>(!!0,UnityEngine.Transform)
IL_0181: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0186: dup
IL_0187: dup
IL_0188: callvirt System.String UnityEngine.Object::get_name()
IL_018d: ldstr "(Clone)"
IL_0192: ldsfld System.String System.String::Empty
IL_0197: callvirt System.String System.String::Replace(System.String,System.String)
IL_019c: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_01a1: dup
IL_01a2: ldnull
IL_01a3: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_01a8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01ad: call System.Void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)
IL_01b2: ldarg.0
IL_01b3: call System.Void TheForestOfLove.Audio.MasterAudioPrefabDropper::InstantiateDynamicSoundGroupCreators()
IL_01b8: ldarg.0
IL_01b9: call UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01be: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_01c3: ret
METHOD System.Void TheForestOfLove.Audio.MasterAudioPrefabDropper::InstantiateDynamicSoundGroupCreators() | attributes=Private, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: call !!0 UnityEngine.Object::FindObjectOfType<DarkTonic.MasterAudio.DynamicSoundGroupCreator>()
IL_0007: ldnull
IL_0008: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_000d: brfalse IL_0096
IL_0012: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inStartMenu()
IL_0017: brfalse.s IL_003c
IL_0019: ldarg.0
IL_001a: ldfld System.String TheForestOfLove.Audio.MasterAudioPrefabDropper::dsgcStartMenuResourcePath
IL_001f: call !!0 UnityEngine.Resources::Load<DarkTonic.MasterAudio.DynamicSoundGroupCreator>(System.String)
IL_0024: ldarg.0
IL_0025: ldfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_002a: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_002f: call !!0 UnityEngine.Object::Instantiate<DarkTonic.MasterAudio.DynamicSoundGroupCreator>(!!0,UnityEngine.Transform)
IL_0034: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0039: stloc.0
IL_003a: br.s IL_006b
IL_003c: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inGameplayScene()
IL_0041: brtrue.s IL_004a
IL_0043: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inTestScene()
IL_0048: brfalse.s IL_006b
IL_004a: ldarg.0
IL_004b: ldfld System.String TheForestOfLove.Audio.MasterAudioPrefabDropper::dsgcOverworldResourcePath
IL_0050: call !!0 UnityEngine.Resources::Load<DarkTonic.MasterAudio.DynamicSoundGroupCreator>(System.String)
IL_0055: ldarg.0
IL_0056: ldfld UnityEngine.GameObject TheForestOfLove.Audio.MasterAudioPrefabDropper::container
IL_005b: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0060: call !!0 UnityEngine.Object::Instantiate<DarkTonic.MasterAudio.DynamicSoundGroupCreator>(!!0,UnityEngine.Transform)
IL_0065: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_006a: stloc.0
IL_006b: ldloc.0
IL_006c: ldnull
IL_006d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0072: brfalse.s IL_0096
IL_0074: ldloc.0
IL_0075: ldloc.0
IL_0076: callvirt System.String UnityEngine.Object::get_name()
IL_007b: ldstr "(Clone)"
IL_0080: ldsfld System.String System.String::Empty
IL_0085: callvirt System.String System.String::Replace(System.String,System.String)
IL_008a: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_008f: ldloc.0
IL_0090: ldnull
IL_0091: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0096: ret
