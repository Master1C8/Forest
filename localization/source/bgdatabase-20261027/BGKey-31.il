TYPE BansheeGz.BGDatabase.BGKey
METHOD BansheeGz.BGDatabase.BGKey BansheeGz.BGDatabase.BGKey::FromBinary(BansheeGz.BGDatabase.BGBinaryReader,BansheeGz.BGDatabase.BGMetaEntity) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: newobj System.Void BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0::binder
IL_000d: ldloc.0
IL_000e: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0::binder
IL_0013: callvirt System.Int32 BansheeGz.BGDatabase.BGBinaryReader::ReadInt()
IL_0018: stloc.1
IL_0019: ldloc.1
IL_001a: ldc.i4.1
IL_001b: bne.un IL_00f8
IL_0020: newobj System.Void BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::.ctor()
IL_0025: stloc.2
IL_0026: ldloc.2
IL_0027: ldloc.0
IL_0028: stfld BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0 BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::CS$<>8__locals1
IL_002d: ldloc.2
IL_002e: ldfld BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0 BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::CS$<>8__locals1
IL_0033: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0::binder
IL_0038: callvirt BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGBinaryReader::ReadId()
IL_003d: stloc.3
IL_003e: ldloc.2
IL_003f: ldfld BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0 BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::CS$<>8__locals1
IL_0044: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0::binder
IL_0049: callvirt System.String BansheeGz.BGDatabase.BGBinaryReader::ReadString()
IL_004e: stloc.s V_4
IL_0050: ldloc.2
IL_0051: ldfld BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0 BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::CS$<>8__locals1
IL_0056: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0::binder
IL_005b: callvirt System.Boolean BansheeGz.BGDatabase.BGBinaryReader::ReadBool()
IL_0060: stloc.s V_5
IL_0062: ldloc.2
IL_0063: newobj System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>::.ctor()
IL_0068: stfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId> BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::fieldIds
IL_006d: ldloc.2
IL_006e: ldfld BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0 BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::CS$<>8__locals1
IL_0073: ldfld BansheeGz.BGDatabase.BGBinaryReader BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_0::binder
IL_0078: ldloc.2
IL_0079: ldftn System.Void BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::<FromBinary>b__0()
IL_007f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0084: callvirt System.Void BansheeGz.BGDatabase.BGBinaryReader::ReadArray(System.Action)
IL_0089: ldloc.2
IL_008a: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId> BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::fieldIds
IL_008f: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>::get_Count()
IL_0094: brtrue.s IL_0098
IL_0096: ldnull
IL_0097: ret
IL_0098: ldloc.2
IL_0099: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId> BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::fieldIds
IL_009e: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>::get_Count()
IL_00a3: newarr BansheeGz.BGDatabase.BGField
IL_00a8: stloc.s V_6
IL_00aa: ldc.i4.0
IL_00ab: stloc.s V_7
IL_00ad: br.s IL_00dc
IL_00af: ldloc.2
IL_00b0: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId> BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::fieldIds
IL_00b5: ldloc.s V_7
IL_00b7: callvirt !0 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>::get_Item(System.Int32)
IL_00bc: stloc.s V_8
IL_00be: ldarg.1
IL_00bf: ldloc.s V_8
IL_00c1: ldc.i4.0
IL_00c2: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_00c7: stloc.s V_9
IL_00c9: ldloc.s V_9
IL_00cb: brtrue.s IL_00cf
IL_00cd: ldnull
IL_00ce: ret
IL_00cf: ldloc.s V_6
IL_00d1: ldloc.s V_7
IL_00d3: ldloc.s V_9
IL_00d5: stelem.ref
IL_00d6: ldloc.s V_7
IL_00d8: ldc.i4.1
IL_00d9: add
IL_00da: stloc.s V_7
IL_00dc: ldloc.s V_7
IL_00de: ldloc.2
IL_00df: ldfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId> BansheeGz.BGDatabase.BGKey/<>c__DisplayClass32_1::fieldIds
IL_00e4: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGId>::get_Count()
IL_00e9: blt.s IL_00af
IL_00eb: ldloc.3
IL_00ec: ldloc.s V_4
IL_00ee: ldloc.s V_5
IL_00f0: ldloc.s V_6
IL_00f2: call BansheeGz.BGDatabase.BGKey BansheeGz.BGDatabase.BGKey::Create(BansheeGz.BGDatabase.BGId,System.String,System.Boolean,BansheeGz.BGDatabase.BGField[])
IL_00f7: ret
IL_00f8: ldstr "Can not read key from binary array: unsupported version $"
IL_00fd: ldc.i4.1
IL_00fe: newarr System.Object
IL_0103: dup
IL_0104: ldc.i4.0
IL_0105: ldloc.1
IL_0106: box System.Int32
IL_010b: stelem.ref
IL_010c: newobj System.Void BansheeGz.BGDatabase.BGException::.ctor(System.String,System.Object[])
IL_0111: throw
