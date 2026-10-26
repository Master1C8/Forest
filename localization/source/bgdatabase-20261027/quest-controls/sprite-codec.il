TYPE BansheeGz.BGDatabase.BGFieldUnitySprite
METHOD System.Void BansheeGz.BGDatabase.BGFieldUnitySprite::ConfigFromBytes(System.ArraySegment`1<System.Byte>) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: newobj System.Void BansheeGz.BGDatabase.BGBinaryReader::.ctor(System.ArraySegment`1<System.Byte>)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_000d: stloc.1
IL_000e: ldloc.1
IL_000f: ldc.i4.1
IL_0010: beq.s IL_0018
IL_0012: ldloc.1
IL_0013: ldc.i4.2
IL_0014: beq.s IL_0020
IL_0016: br.s IL_0034
IL_0018: ldarg.0
IL_0019: ldloc.0
IL_001a: call System.Void BansheeGz.BGDatabase.BGFieldUnitySprite::ReadLoader(BansheeGz.BGDatabase.BGBinaryReader)
IL_001f: ret
IL_0020: ldarg.0
IL_0021: ldloc.0
IL_0022: call System.Void BansheeGz.BGDatabase.BGFieldUnitySprite::ReadLoader(BansheeGz.BGDatabase.BGBinaryReader)
IL_0027: ldarg.0
IL_0028: ldloc.0
IL_0029: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_002e: stfld BansheeGz.BGDatabase.BGFieldUnitySprite/LocationConstraintEnum BansheeGz.BGDatabase.BGFieldUnitySprite::locationConstraint
IL_0033: ret
IL_0034: ldstr "Unknown version: $"
IL_0039: ldc.i4.1
IL_003a: newarr System.Object
IL_003f: dup
IL_0040: ldc.i4.0
IL_0041: ldloc.1
IL_0042: box System.Int32
IL_0047: stelem.ref
IL_0048: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_004d: throw
METHOD System.Void BansheeGz.BGDatabase.BGFieldUnitySprite::ReadLoader(BansheeGz.BGDatabase.BGBinaryReader) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_0007: ldc.i4.0
IL_0008: ldc.i4.0
IL_0009: newarr System.Object
IL_000e: call T BansheeGz.BGDatabase.BGUtil::Create<BansheeGz.BGDatabase.BGAssetLoaderA>(System.String,System.Boolean,System.Object[])
IL_0013: stfld BansheeGz.BGDatabase.BGAssetLoaderA BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::assetLoader
IL_0018: ldarg.0
IL_0019: ldfld BansheeGz.BGDatabase.BGAssetLoaderA BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::assetLoader
IL_001e: ldarg.1
IL_001f: callvirt System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGBinaryReader::ReadByteArray()
IL_0024: callvirt System.Void BansheeGz.BGDatabase.BGAssetLoaderA::ConfigFromBytes(System.ArraySegment`1<System.Byte>)
IL_0029: ret
METHOD BansheeGz.BGDatabase.BGAddressablesLoaderModel BansheeGz.BGDatabase.BGFieldUnitySprite::GetAddressablesLoaderModel(System.Int32) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call TStoreType BansheeGz.BGDatabase.BGFieldCachedA`2<UnityEngine.Sprite,System.String>::GetStoredValue(System.Int32)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000e: brfalse.s IL_0012
IL_0010: ldnull
IL_0011: ret
IL_0012: ldloca.s V_1
IL_0014: ldloc.0
IL_0015: call System.Void BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::.ctor(System.String)
IL_001a: ldloca.s V_1
IL_001c: call BansheeGz.BGDatabase.BGFieldUnitySprite/LocationEnum BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_Location()
IL_0021: stloc.2
IL_0022: ldloc.2
IL_0023: switch IL_0036,IL_0047,IL_0059
IL_0034: br.s IL_0070
IL_0036: ldloc.0
IL_0037: ldtoken UnityEngine.Sprite
IL_003c: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_0041: newobj System.Void BansheeGz.BGDatabase.BGAddressablesLoaderModel::.ctor(System.String,System.Type)
IL_0046: ret
IL_0047: ldloca.s V_1
IL_0049: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_AssetPath()
IL_004e: ldsfld System.Type BansheeGz.BGDatabase.BGFieldUnitySprite::spriteArray
IL_0053: newobj System.Void BansheeGz.BGDatabase.BGAddressablesLoaderModel::.ctor(System.String,System.Type)
IL_0058: ret
IL_0059: ldloca.s V_1
IL_005b: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_AssetPath()
IL_0060: ldtoken UnityEngine.U2D.SpriteAtlas
IL_0065: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_006a: newobj System.Void BansheeGz.BGDatabase.BGAddressablesLoaderModel::.ctor(System.String,System.Type)
IL_006f: ret
IL_0070: ldstr "location.Location"
IL_0075: newobj System.Void System.ArgumentOutOfRangeException::.ctor(System.String)
IL_007a: throw
METHOD System.String BansheeGz.BGDatabase.BGFieldUnitySprite::GetAddressablesAddress(System.Int32) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call TStoreType BansheeGz.BGDatabase.BGFieldCachedA`2<UnityEngine.Sprite,System.String>::GetStoredValue(System.Int32)
IL_0007: stloc.0
IL_0008: ldloc.0
IL_0009: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_000e: brfalse.s IL_0012
IL_0010: ldnull
IL_0011: ret
IL_0012: ldloca.s V_1
IL_0014: ldloc.0
IL_0015: call System.Void BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::.ctor(System.String)
IL_001a: ldloca.s V_1
IL_001c: call BansheeGz.BGDatabase.BGFieldUnitySprite/LocationEnum BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_Location()
IL_0021: stloc.2
IL_0022: ldloc.2
IL_0023: brfalse.s IL_002d
IL_0025: ldloc.2
IL_0026: ldc.i4.1
IL_0027: sub
IL_0028: ldc.i4.1
IL_0029: ble.un.s IL_002f
IL_002b: br.s IL_006b
IL_002d: ldloc.0
IL_002e: ret
IL_002f: ldloca.s V_1
IL_0031: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_AssetPath()
IL_0036: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_003b: brtrue.s IL_004b
IL_003d: ldloca.s V_1
IL_003f: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_SubAssetPath()
IL_0044: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0049: brfalse.s IL_004d
IL_004b: ldnull
IL_004c: ret
IL_004d: ldloca.s V_1
IL_004f: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_AssetPath()
IL_0054: ldstr "["
IL_0059: ldloca.s V_1
IL_005b: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_SubAssetPath()
IL_0060: ldstr "]"
IL_0065: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_006a: ret
IL_006b: ldstr "location.Location"
IL_0070: newobj System.Void System.ArgumentOutOfRangeException::.ctor(System.String)
IL_0075: throw
METHOD UnityEngine.Sprite BansheeGz.BGDatabase.BGFieldUnitySprite::get_Item(System.Int32) | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BansheeGz.BGDatabase.BGAssetLoaderA BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::assetLoader
IL_0006: isinst BansheeGz.BGDatabase.BGAssetLoaderAddressables
IL_000b: brfalse.s IL_0064
IL_000d: ldarg.0
IL_000e: ldarg.1
IL_000f: callvirt System.String BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::GetAddressablesAddress(System.Int32)
IL_0014: stloc.2
IL_0015: ldloc.2
IL_0016: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_001b: brfalse.s IL_001f
IL_001d: ldnull
IL_001e: ret
IL_001f: ldarg.0
IL_0020: ldfld BansheeGz.BGDatabase.BGAssetLoaderA BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::assetLoader
IL_0025: ldloc.2
IL_0026: callvirt T BansheeGz.BGDatabase.BGAssetLoaderA::Load<UnityEngine.Sprite>(System.String)
IL_002b: stloc.3
IL_002c: ldloc.3
IL_002d: ldnull
IL_002e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0033: brfalse.s IL_0062
IL_0035: ldloc.3
IL_0036: callvirt System.String UnityEngine.Object::get_name()
IL_003b: ldstr "(Clone)"
IL_0040: callvirt System.Boolean System.String::EndsWith(System.String)
IL_0045: brfalse.s IL_0062
IL_0047: ldloc.3
IL_0048: ldloc.3
IL_0049: callvirt System.String UnityEngine.Object::get_name()
IL_004e: ldstr "(Clone)"
IL_0053: ldstr ""
IL_0058: callvirt System.String System.String::Replace(System.String,System.String)
IL_005d: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_0062: ldloc.3
IL_0063: ret
IL_0064: ldarg.0
IL_0065: ldarg.1
IL_0066: call TStoreType BansheeGz.BGDatabase.BGFieldCachedA`2<UnityEngine.Sprite,System.String>::GetStoredValue(System.Int32)
IL_006b: stloc.0
IL_006c: ldloc.0
IL_006d: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0072: brfalse.s IL_0076
IL_0074: ldnull
IL_0075: ret
IL_0076: ldloca.s V_1
IL_0078: ldloc.0
IL_0079: call System.Void BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::.ctor(System.String)
IL_007e: ldloca.s V_1
IL_0080: call BansheeGz.BGDatabase.BGFieldUnitySprite/LocationEnum BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_Location()
IL_0085: stloc.s V_4
IL_0087: ldloc.s V_4
IL_0089: switch IL_009f,IL_00b2,IL_0100
IL_009a: br IL_016d
IL_009f: ldarg.0
IL_00a0: ldfld BansheeGz.BGDatabase.BGAssetLoaderA BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::assetLoader
IL_00a5: ldloca.s V_1
IL_00a7: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_AssetPath()
IL_00ac: callvirt T BansheeGz.BGDatabase.BGAssetLoaderA::Load<UnityEngine.Sprite>(System.String)
IL_00b1: ret
IL_00b2: ldarg.0
IL_00b3: ldfld BansheeGz.BGDatabase.BGAssetLoaderA BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::assetLoader
IL_00b8: ldloca.s V_1
IL_00ba: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_AssetPath()
IL_00bf: callvirt T[] BansheeGz.BGDatabase.BGAssetLoaderA::LoadAll<UnityEngine.Sprite>(System.String)
IL_00c4: stloc.s V_5
IL_00c6: ldloc.s V_5
IL_00c8: brtrue.s IL_00cc
IL_00ca: ldnull
IL_00cb: ret
IL_00cc: ldc.i4.0
IL_00cd: stloc.s V_8
IL_00cf: br.s IL_00f6
IL_00d1: ldloc.s V_5
IL_00d3: ldloc.s V_8
IL_00d5: ldelem.ref
IL_00d6: stloc.s V_9
IL_00d8: ldloc.s V_9
IL_00da: callvirt System.String UnityEngine.Object::get_name()
IL_00df: ldloca.s V_1
IL_00e1: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_SubAssetPath()
IL_00e6: call System.Boolean System.String::Equals(System.String,System.String)
IL_00eb: brfalse.s IL_00f0
IL_00ed: ldloc.s V_9
IL_00ef: ret
IL_00f0: ldloc.s V_8
IL_00f2: ldc.i4.1
IL_00f3: add
IL_00f4: stloc.s V_8
IL_00f6: ldloc.s V_8
IL_00f8: ldloc.s V_5
IL_00fa: ldlen
IL_00fb: conv.i4
IL_00fc: blt.s IL_00d1
IL_00fe: ldnull
IL_00ff: ret
IL_0100: ldarg.0
IL_0101: ldfld BansheeGz.BGDatabase.BGAssetLoaderA BansheeGz.BGDatabase.BGFieldUnityAssetA`1<UnityEngine.Sprite>::assetLoader
IL_0106: ldloca.s V_1
IL_0108: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_AssetPath()
IL_010d: callvirt T BansheeGz.BGDatabase.BGAssetLoaderA::Load<UnityEngine.U2D.SpriteAtlas>(System.String)
IL_0112: stloc.s V_6
IL_0114: ldloc.s V_6
IL_0116: ldnull
IL_0117: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_011c: brfalse.s IL_0120
IL_011e: ldnull
IL_011f: ret
IL_0120: ldloc.s V_6
IL_0122: ldloca.s V_1
IL_0124: call System.String BansheeGz.BGDatabase.BGFieldUnitySprite/SpriteLocation::get_SubAssetPath()
IL_0129: callvirt UnityEngine.Sprite UnityEngine.U2D.SpriteAtlas::GetSprite(System.String)
IL_012e: stloc.s V_7
IL_0130: ldloc.s V_7
IL_0132: ldnull
IL_0133: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0138: brfalse.s IL_016a
IL_013a: ldloc.s V_7
IL_013c: callvirt System.String UnityEngine.Object::get_name()
IL_0141: ldstr "(Clone)"
IL_0146: callvirt System.Boolean System.String::EndsWith(System.String)
IL_014b: brfalse.s IL_016a
IL_014d: ldloc.s V_7
IL_014f: ldloc.s V_7
IL_0151: callvirt System.String UnityEngine.Object::get_name()
IL_0156: ldstr "(Clone)"
IL_015b: ldstr ""
IL_0160: callvirt System.String System.String::Replace(System.String,System.String)
IL_0165: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_016a: ldloc.s V_7
IL_016c: ret
IL_016d: ldstr "location.Location"
IL_0172: newobj System.Void System.ArgumentOutOfRangeException::.ctor(System.String)
IL_0177: throw
