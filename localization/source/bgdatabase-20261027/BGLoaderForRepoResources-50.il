TYPE BansheeGz.BGDatabase.BGLoaderForRepoResources
METHOD System.Byte[] BansheeGz.BGDatabase.BGLoaderForRepoResources::Load(BansheeGz.BGDatabase.BGLoaderForRepo/LoadRequest) | attributes=Public, Virtual, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: ldarg.0
IL_0003: ldarg.1
IL_0004: call System.Boolean BansheeGz.BGDatabase.BGLoaderForRepo::IsEmpty(BansheeGz.BGDatabase.BGLoaderForRepo/LoadRequest)
IL_0009: brfalse.s IL_004b
IL_000b: ldc.i4.0
IL_000c: stloc.1
IL_000d: br.s IL_003f
IL_000f: ldsfld System.String[] BansheeGz.BGDatabase.BGLoaderForRepoResources::pathes
IL_0014: ldloc.1
IL_0015: ldelem.ref
IL_0016: stloc.2
IL_0017: ldarg.0
IL_0018: ldloc.2
IL_0019: call UnityEngine.TextAsset BansheeGz.BGDatabase.BGLoaderForRepoResources::Load(System.String)
IL_001e: stloc.0
IL_001f: ldloc.0
IL_0020: ldnull
IL_0021: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0026: brtrue.s IL_003b
IL_0028: ldloc.0
IL_0029: callvirt System.Int32 UnityEngine.Object::GetInstanceID()
IL_002e: call System.Void BansheeGz.BGDatabase.BGRepo::set_DefaultRepoAssetId(System.Int32)
IL_0033: ldloc.2
IL_0034: call System.Void BansheeGz.BGDatabase.BGRepo::set_DefaultRepoAssetPath(System.String)
IL_0039: br.s IL_0085
IL_003b: ldloc.1
IL_003c: ldc.i4.1
IL_003d: add
IL_003e: stloc.1
IL_003f: ldloc.1
IL_0040: ldsfld System.String[] BansheeGz.BGDatabase.BGLoaderForRepoResources::pathes
IL_0045: ldlen
IL_0046: conv.i4
IL_0047: blt.s IL_000f
IL_0049: br.s IL_0085
IL_004b: ldarg.0
IL_004c: ldarg.1
IL_004d: callvirt System.String BansheeGz.BGDatabase.BGLoaderForRepo::ToPath(BansheeGz.BGDatabase.BGLoaderForRepo/LoadRequest)
IL_0052: stloc.3
IL_0053: ldloc.3
IL_0054: call !!0[] UnityEngine.Resources::LoadAll<UnityEngine.TextAsset>(System.String)
IL_0059: stloc.s V_4
IL_005b: ldloc.s V_4
IL_005d: brfalse.s IL_0085
IL_005f: ldloc.s V_4
IL_0061: ldlen
IL_0062: brfalse.s IL_0085
IL_0064: ldloc.s V_4
IL_0066: ldlen
IL_0067: conv.i4
IL_0068: ldc.i4.1
IL_0069: ble.s IL_0080
IL_006b: ldstr "You have more than one file with name $ under Resources folder! Please, backup all these files and leave the only right one under Resources folder!"
IL_0070: ldc.i4.1
IL_0071: newarr System.Object
IL_0076: dup
IL_0077: ldc.i4.0
IL_0078: ldloc.3
IL_0079: stelem.ref
IL_007a: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_007f: throw
IL_0080: ldloc.s V_4
IL_0082: ldc.i4.0
IL_0083: ldelem.ref
IL_0084: stloc.0
IL_0085: ldloc.0
IL_0086: ldnull
IL_0087: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_008c: brtrue.s IL_0095
IL_008e: ldloc.0
IL_008f: callvirt System.Byte[] UnityEngine.TextAsset::get_bytes()
IL_0094: ret
IL_0095: ldnull
IL_0096: ret
METHOD UnityEngine.TextAsset BansheeGz.BGDatabase.BGLoaderForRepoResources::Load(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: call !!0 UnityEngine.Resources::Load<UnityEngine.TextAsset>(System.String)
IL_0006: ret
