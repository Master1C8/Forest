TYPE BansheeGz.BGDatabase.BGRepoBinaryV5
METHOD BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5::Read(System.Byte[]) | attributes=Public, Final, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: newobj System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: newobj System.Void BansheeGz.BGDatabase.BGBinaryReader::.ctor(System.Byte[])
IL_000d: stfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0012: ldloc.0
IL_0013: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0018: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_001d: stloc.1
IL_001e: ldloc.0
IL_001f: newobj System.Void BansheeGz.BGDatabase.BGRepo::.ctor()
IL_0024: dup
IL_0025: ldloc.1
IL_0026: callvirt System.Void BansheeGz.BGDatabase.BGRepo::set_BinaryFormatVersion(System.Int32)
IL_002b: stfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::repo
IL_0030: ldarg.1
IL_0031: ldlen
IL_0032: conv.i4
IL_0033: ldc.i4.s 21
IL_0035: bge.s IL_003e
IL_0037: ldloc.0
IL_0038: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::repo
IL_003d: ret
IL_003e: ldloc.0
IL_003f: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0044: callvirt BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGBinaryReader::ReadId()
IL_0049: ldsfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGRepoBinaryV5::UniqueId
IL_004e: call System.Boolean BansheeGz.BGDatabase.BGId::op_Inequality(BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGId)
IL_0053: brfalse.s IL_0060
IL_0055: ldstr "Provided binary array is not a valid BGDatabase content!"
IL_005a: newobj System.Void System.Exception::.ctor(System.String)
IL_005f: throw
IL_0060: ldloc.0
IL_0061: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0066: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::get_Cursor()
IL_006b: ldc.i4.s 16
IL_006d: add
IL_006e: ldloc.0
IL_006f: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0074: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::get_Length()
IL_0079: bge IL_0161
IL_007e: ldloc.0
IL_007f: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0084: callvirt BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGBinaryReader::ReadId()
IL_0089: ldsfld BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGRepoBinaryV5::EncryptionId
IL_008e: call System.Boolean BansheeGz.BGDatabase.BGId::op_Equality(BansheeGz.BGDatabase.BGId,BansheeGz.BGDatabase.BGId)
IL_0093: brfalse IL_0154
IL_0098: ldloc.0
IL_0099: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_009e: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_00a3: stloc.3
IL_00a4: ldloc.0
IL_00a5: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_00aa: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_00af: stloc.s V_4
IL_00b1: ldloc.3
IL_00b2: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_00b7: brfalse.s IL_00ca
IL_00b9: ldstr "BGDatabase content is encrypted, but encryptor is not set!"
IL_00be: ldc.i4.0
IL_00bf: newarr System.Object
IL_00c4: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_00c9: throw
IL_00ca: ldloc.3
IL_00cb: call System.Type BansheeGz.BGDatabase.BGUtil::GetType(System.String)
IL_00d0: stloc.s V_5
IL_00d2: ldloc.s V_5
IL_00d4: brtrue.s IL_00eb
IL_00d6: ldstr "BGDatabase content is encrypted, can not load encryptor class $!"
IL_00db: ldc.i4.1
IL_00dc: newarr System.Object
IL_00e1: dup
IL_00e2: ldc.i4.0
IL_00e3: ldloc.3
IL_00e4: stelem.ref
IL_00e5: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_00ea: throw
IL_00eb: ldloc.s V_5
IL_00ed: call System.Object System.Activator::CreateInstance(System.Type)
IL_00f2: isinst BansheeGz.BGDatabase.BGEncryptor
IL_00f7: stloc.s V_6
IL_00f9: ldloc.s V_6
IL_00fb: brtrue.s IL_0112
IL_00fd: ldstr "BGDatabase content is encrypted, can not create encryptor $- it does not implement BGEncryptor interface!"
IL_0102: ldc.i4.1
IL_0103: newarr System.Object
IL_0108: dup
IL_0109: ldc.i4.0
IL_010a: ldloc.3
IL_010b: stelem.ref
IL_010c: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_0111: throw
IL_0112: ldloc.s V_6
IL_0114: ldarg.1
IL_0115: ldloc.0
IL_0116: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_011b: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::get_Cursor()
IL_0120: ldloc.0
IL_0121: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0126: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::get_Length()
IL_012b: ldloc.0
IL_012c: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0131: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::get_Cursor()
IL_0136: sub
IL_0137: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_013c: ldloc.s V_4
IL_013e: callvirt System.ArraySegment`1<System.Byte> BansheeGz.BGDatabase.BGEncryptor::Decrypt(System.ArraySegment`1<System.Byte>,System.String)
IL_0143: stloc.s V_7
IL_0145: ldloc.0
IL_0146: ldloc.s V_7
IL_0148: newobj System.Void BansheeGz.BGDatabase.BGBinaryReader::.ctor(System.ArraySegment`1<System.Byte>)
IL_014d: stfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0152: br.s IL_0161
IL_0154: ldloc.0
IL_0155: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_015a: ldc.i4.s -16
IL_015c: callvirt System.Void BansheeGz.BGDatabase.BGBinaryReader::ShiftCursor(System.Int32)
IL_0161: ldloc.0
IL_0162: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_0167: ldloc.0
IL_0168: ldftn System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::<Read>b__0()
IL_016e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0173: callvirt System.Void BansheeGz.BGDatabase.BGBinaryReader::ReadArray(System.Action)
IL_0178: ldloc.0
IL_0179: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::repo
IL_017e: callvirt BansheeGz.BGDatabase.BGRepoAddons BansheeGz.BGDatabase.BGRepo::get_Addons()
IL_0183: callvirt T BansheeGz.BGDatabase.BGRepoAddons::Get<BansheeGz.BGDatabase.BGAddonSettings>()
IL_0188: stloc.2
IL_0189: ldloc.0
IL_018a: ldc.i4.0
IL_018b: stfld System.Boolean BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::multithreaded
IL_0190: ldloc.2
IL_0191: brfalse.s IL_020b
IL_0193: ldloc.0
IL_0194: ldloc.2
IL_0195: callvirt System.Boolean BansheeGz.BGDatabase.BGAddonSettings::get_MultiThreadedLoading()
IL_019a: stfld System.Boolean BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::multithreaded
IL_019f: ldloc.2
IL_01a0: callvirt System.Boolean BansheeGz.BGDatabase.BGAddonSettings::get_ZippedContent()
IL_01a5: brfalse.s IL_020b
IL_01a7: ldarg.1
IL_01a8: ldloc.0
IL_01a9: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_01ae: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::get_Cursor()
IL_01b3: ldarg.1
IL_01b4: ldlen
IL_01b5: conv.i4
IL_01b6: ldloc.0
IL_01b7: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_01bc: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::get_Cursor()
IL_01c1: sub
IL_01c2: newobj System.Void System.IO.MemoryStream::.ctor(System.Byte[],System.Int32,System.Int32)
IL_01c7: ldc.i4.0
IL_01c8: newobj System.Void System.IO.Compression.DeflateStream::.ctor(System.IO.Stream,System.IO.Compression.CompressionMode)
IL_01cd: stloc.s V_8
IL_01cf: newobj System.Void System.IO.MemoryStream::.ctor()
IL_01d4: stloc.s V_9
IL_01d6: ldloc.s V_8
IL_01d8: ldloc.s V_9
IL_01da: call System.Void BansheeGz.BGDatabase.BGRepoBinaryV5::CopyTo(System.IO.Stream,System.IO.Stream)
IL_01df: ldloc.0
IL_01e0: ldloc.s V_9
IL_01e2: callvirt System.Byte[] System.IO.MemoryStream::ToArray()
IL_01e7: newobj System.Void BansheeGz.BGDatabase.BGBinaryReader::.ctor(System.Byte[])
IL_01ec: stfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_01f1: leave.s IL_020b
IL_01f3: ldloc.s V_9
IL_01f5: brfalse.s IL_01fe
IL_01f7: ldloc.s V_9
IL_01f9: callvirt System.Void System.IDisposable::Dispose()
IL_01fe: endfinally
IL_01ff: ldloc.s V_8
IL_0201: brfalse.s IL_020a
IL_0203: ldloc.s V_8
IL_0205: callvirt System.Void System.IDisposable::Dispose()
IL_020a: endfinally
IL_020b: ldloc.0
IL_020c: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::repo
IL_0211: call System.Boolean BansheeGz.BGDatabase.BGAddonLazyLoad::Enabled(BansheeGz.BGDatabase.BGRepo)
IL_0216: brfalse.s IL_0236
IL_0218: ldloc.0
IL_0219: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::repo
IL_021e: ldloc.0
IL_021f: ldftn System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::<Read>b__1()
IL_0225: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_022a: newobj System.Void BansheeGz.BGDatabase.BGLazyLoaderRepo::.ctor(System.Action)
IL_022f: stfld BansheeGz.BGDatabase.BGLazyLoaderRepoI BansheeGz.BGDatabase.BGRepo::LazyLoader
IL_0234: br.s IL_024e
IL_0236: ldloc.0
IL_0237: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::binder
IL_023c: ldloc.0
IL_023d: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::repo
IL_0242: ldc.i4.0
IL_0243: ldloc.0
IL_0244: ldfld System.Boolean BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::multithreaded
IL_0249: call System.Void BansheeGz.BGDatabase.BGRepoBinaryV5::ReadMetas(BansheeGz.BGDatabase.BGBinaryReader,BansheeGz.BGDatabase.BGRepo,System.Boolean,System.Boolean)
IL_024e: ldloc.0
IL_024f: ldfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass3_0::repo
IL_0254: ret
METHOD System.Void BansheeGz.BGDatabase.BGRepoBinaryV5::ReadMetas(BansheeGz.BGDatabase.BGBinaryReader,BansheeGz.BGDatabase.BGRepo,System.Boolean,System.Boolean) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: newobj System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::binder
IL_000d: ldloc.0
IL_000e: ldarg.1
IL_000f: stfld BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::repo
IL_0014: ldloc.0
IL_0015: ldarg.2
IL_0016: stfld System.Boolean BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::lazyLoadEnabled
IL_001b: ldloc.0
IL_001c: ldarg.3
IL_001d: stfld System.Boolean BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::multithreaded
IL_0022: call UnityEngine.RuntimePlatform UnityEngine.Application::get_platform()
IL_0027: ldc.i4.s 17
IL_0029: bne.un.s IL_0032
IL_002b: ldloc.0
IL_002c: ldc.i4.0
IL_002d: stfld System.Boolean BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::multithreaded
IL_0032: ldloc.0
IL_0033: ldnull
IL_0034: stfld BansheeGz.BGDatabase.BGMultiThreadedLoader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::multiThreadedLoader
IL_0039: ldloc.0
IL_003a: ldfld System.Boolean BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::lazyLoadEnabled
IL_003f: ldc.i4.0
IL_0040: ceq
IL_0042: ldloc.0
IL_0043: ldfld System.Boolean BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::multithreaded
IL_0048: and
IL_0049: brfalse.s IL_0056
IL_004b: ldloc.0
IL_004c: newobj System.Void BansheeGz.BGDatabase.BGMultiThreadedLoader::.ctor()
IL_0051: stfld BansheeGz.BGDatabase.BGMultiThreadedLoader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::multiThreadedLoader
IL_0056: ldloc.0
IL_0057: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::binder
IL_005c: ldloc.0
IL_005d: ldftn System.Void BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::<ReadMetas>b__0()
IL_0063: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0068: callvirt System.Void BansheeGz.BGDatabase.BGBinaryReader::ReadArray(System.Action)
IL_006d: ldloc.0
IL_006e: ldfld BansheeGz.BGDatabase.BGMultiThreadedLoader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::multiThreadedLoader
IL_0073: brfalse.s IL_0080
IL_0075: ldloc.0
IL_0076: ldfld BansheeGz.BGDatabase.BGMultiThreadedLoader BansheeGz.BGDatabase.BGRepoBinaryV5/<>c__DisplayClass4_0::multiThreadedLoader
IL_007b: callvirt System.Void BansheeGz.BGDatabase.BGMultiThreadedLoader::Load()
IL_0080: ret
METHOD System.Void BansheeGz.BGDatabase.BGRepoBinaryV5::ReadFieldValues(System.ArraySegment`1<System.Byte>,BansheeGz.BGDatabase.BGField,System.Int32,System.Action`1<System.Exception>) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: callvirt BansheeGz.BGDatabase.BGMetaEntity BansheeGz.BGDatabase.BGField::get_Meta()
IL_0006: stloc.0
IL_0007: ldarga.s fieldValues
IL_0009: call !0[] System.ArraySegment`1<System.Byte>::get_Array()
IL_000e: stloc.1
IL_000f: ldarga.s fieldValues
IL_0011: call System.Int32 System.ArraySegment`1<System.Byte>::get_Offset()
IL_0016: stloc.2
IL_0017: ldarg.1
IL_0018: callvirt System.Int32 BansheeGz.BGDatabase.BGField::get_ConstantSize()
IL_001d: stloc.3
IL_001e: ldloc.3
IL_001f: ldc.i4.0
IL_0020: ble.s IL_0057
IL_0022: ldc.i4.0
IL_0023: stloc.s V_4
IL_0025: br.s IL_0051
IL_0027: ldloc.0
IL_0028: ldloc.s V_4
IL_002a: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::get_Item(System.Int32)
IL_002f: stloc.s V_5
IL_0031: ldarg.1
IL_0032: ldloc.s V_5
IL_0034: callvirt System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_0039: ldloc.1
IL_003a: ldloc.2
IL_003b: ldloc.s V_4
IL_003d: ldloc.3
IL_003e: mul
IL_003f: add
IL_0040: ldloc.3
IL_0041: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_0046: callvirt System.Void BansheeGz.BGDatabase.BGField::FromBytes(System.Int32,System.ArraySegment`1<System.Byte>)
IL_004b: ldloc.s V_4
IL_004d: ldc.i4.1
IL_004e: add
IL_004f: stloc.s V_4
IL_0051: ldloc.s V_4
IL_0053: ldarg.2
IL_0054: blt.s IL_0027
IL_0056: ret
IL_0057: ldloc.1
IL_0058: ldloc.2
IL_0059: ldc.i4.4
IL_005a: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_005f: call System.Int32 BansheeGz.BGDatabase.BGFieldInt::ValueFromBytes(System.ArraySegment`1<System.Byte>)
IL_0064: stloc.s V_6
IL_0066: ldloc.s V_6
IL_0068: brtrue.s IL_006b
IL_006a: ret
IL_006b: ldloc.2
IL_006c: ldc.i4.4
IL_006d: add
IL_006e: stloc.s V_7
IL_0070: ldloc.s V_7
IL_0072: ldloc.s V_6
IL_0074: ldc.i4.8
IL_0075: mul
IL_0076: add
IL_0077: stloc.s V_8
IL_0079: ldc.i4.0
IL_007a: stloc.s V_9
IL_007c: ldarg.1
IL_007d: isinst BansheeGz.BGDatabase.BGFieldEntityName
IL_0082: brfalse IL_010b
IL_0087: ldarg.1
IL_0088: castclass BansheeGz.BGDatabase.BGFieldEntityName
IL_008d: stloc.s V_10
IL_008f: ldc.i4.0
IL_0090: stloc.s V_11
IL_0092: br.s IL_0104
IL_0094: ldloc.s V_7
IL_0096: ldloc.s V_11
IL_0098: ldc.i4.8
IL_0099: mul
IL_009a: add
IL_009b: stloc.s V_12
IL_009d: ldloc.1
IL_009e: ldloc.s V_12
IL_00a0: ldc.i4.4
IL_00a1: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_00a6: call System.Int32 BansheeGz.BGDatabase.BGFieldInt::ValueFromBytes(System.ArraySegment`1<System.Byte>)
IL_00ab: stloc.s V_13
IL_00ad: ldloc.0
IL_00ae: ldloc.s V_13
IL_00b0: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::get_Item(System.Int32)
IL_00b5: stloc.s V_14
IL_00b7: ldloc.1
IL_00b8: ldloc.s V_12
IL_00ba: ldc.i4.4
IL_00bb: add
IL_00bc: ldc.i4.4
IL_00bd: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_00c2: call System.Int32 BansheeGz.BGDatabase.BGFieldInt::ValueFromBytes(System.ArraySegment`1<System.Byte>)
IL_00c7: stloc.s V_15
IL_00c9: ldloc.s V_10
IL_00cb: ldloc.s V_14
IL_00cd: callvirt System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_00d2: ldloc.1
IL_00d3: ldloc.s V_8
IL_00d5: ldloc.s V_9
IL_00d7: add
IL_00d8: ldloc.s V_15
IL_00da: ldloc.s V_9
IL_00dc: sub
IL_00dd: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_00e2: call System.String BansheeGz.BGDatabase.BGFieldStringA::ValueFromBytes(System.ArraySegment`1<System.Byte>)
IL_00e7: callvirt System.Void BansheeGz.BGDatabase.BGFieldEntityName::SetEntityValue(System.Int32,System.String)
IL_00ec: leave.s IL_00fa
IL_00ee: stloc.s V_16
IL_00f0: ldarg.3
IL_00f1: ldloc.s V_16
IL_00f3: callvirt System.Void System.Action`1<System.Exception>::Invoke(!0)
IL_00f8: leave.s IL_00fa
IL_00fa: ldloc.s V_15
IL_00fc: stloc.s V_9
IL_00fe: ldloc.s V_11
IL_0100: ldc.i4.1
IL_0101: add
IL_0102: stloc.s V_11
IL_0104: ldloc.s V_11
IL_0106: ldloc.s V_6
IL_0108: blt.s IL_0094
IL_010a: ret
IL_010b: ldc.i4.0
IL_010c: stloc.s V_17
IL_010e: br.s IL_017a
IL_0110: ldloc.s V_7
IL_0112: ldloc.s V_17
IL_0114: ldc.i4.8
IL_0115: mul
IL_0116: add
IL_0117: stloc.s V_18
IL_0119: ldloc.1
IL_011a: ldloc.s V_18
IL_011c: ldc.i4.4
IL_011d: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_0122: call System.Int32 BansheeGz.BGDatabase.BGFieldInt::ValueFromBytes(System.ArraySegment`1<System.Byte>)
IL_0127: stloc.s V_19
IL_0129: ldloc.0
IL_012a: ldloc.s V_19
IL_012c: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::get_Item(System.Int32)
IL_0131: stloc.s V_20
IL_0133: ldloc.1
IL_0134: ldloc.s V_18
IL_0136: ldc.i4.4
IL_0137: add
IL_0138: ldc.i4.4
IL_0139: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_013e: call System.Int32 BansheeGz.BGDatabase.BGFieldInt::ValueFromBytes(System.ArraySegment`1<System.Byte>)
IL_0143: stloc.s V_21
IL_0145: ldarg.1
IL_0146: ldloc.s V_20
IL_0148: callvirt System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_014d: ldloc.1
IL_014e: ldloc.s V_8
IL_0150: ldloc.s V_9
IL_0152: add
IL_0153: ldloc.s V_21
IL_0155: ldloc.s V_9
IL_0157: sub
IL_0158: newobj System.Void System.ArraySegment`1<System.Byte>::.ctor(!0[],System.Int32,System.Int32)
IL_015d: callvirt System.Void BansheeGz.BGDatabase.BGField::FromBytes(System.Int32,System.ArraySegment`1<System.Byte>)
IL_0162: leave.s IL_0170
IL_0164: stloc.s V_22
IL_0166: ldarg.3
IL_0167: ldloc.s V_22
IL_0169: callvirt System.Void System.Action`1<System.Exception>::Invoke(!0)
IL_016e: leave.s IL_0170
IL_0170: ldloc.s V_21
IL_0172: stloc.s V_9
IL_0174: ldloc.s V_17
IL_0176: ldc.i4.1
IL_0177: add
IL_0178: stloc.s V_17
IL_017a: ldloc.s V_17
IL_017c: ldloc.s V_6
IL_017e: blt.s IL_0110
IL_0180: ret
