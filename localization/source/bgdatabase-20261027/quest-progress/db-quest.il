TYPE TheForestOfLove.DB.Quest
METHOD BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::_metaDefault
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::_metaDefault
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaEntity::get_IsDeleted()
IL_0011: brfalse.s IL_0039
IL_0013: call BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::get_I()
IL_0018: ldc.i8 5257695775012374967
IL_0021: ldc.i8 2939984458172287654
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: callvirt !!0 BansheeGz.BGDatabase.BGRepo::GetMeta<BansheeGz.BGDatabase.BGMetaRow>(BansheeGz.BGDatabase.BGId)
IL_0034: stsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::_metaDefault
IL_0039: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::_metaDefault
IL_003e: ret
METHOD System.String TheForestOfLove.DB.Quest::get_name() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Quest::get__name()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.String TheForestOfLove.DB.Quest::get_savekey() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::get__savekey()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.String TheForestOfLove.DB.Quest::get_bio_title() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::get__bio_title()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.String TheForestOfLove.DB.Quest::get_bio_description() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.Quest::get__bio_description()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.Collections.Generic.List`1<TheForestOfLove.DB.QuestProgressLogText> TheForestOfLove.DB.Quest::get_initial_progress_log_unlocks() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::get__initial_progress_log_unlocks()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>>::get_Item(System.Int32)
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: brfalse.s IL_001c
IL_0014: ldloc.0
IL_0015: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_001a: brtrue.s IL_001e
IL_001c: ldnull
IL_001d: ret
IL_001e: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DB.QuestProgressLogText>::.ctor()
IL_0023: stloc.1
IL_0024: ldc.i4.0
IL_0025: stloc.2
IL_0026: br.s IL_003e
IL_0028: ldloc.1
IL_0029: ldloc.0
IL_002a: ldloc.2
IL_002b: callvirt !0 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0030: castclass TheForestOfLove.DB.QuestProgressLogText
IL_0035: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DB.QuestProgressLogText>::Add(!0)
IL_003a: ldloc.2
IL_003b: ldc.i4.1
IL_003c: add
IL_003d: stloc.2
IL_003e: ldloc.2
IL_003f: ldloc.0
IL_0040: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_0045: blt.s IL_0028
IL_0047: ldloc.1
IL_0048: ret
METHOD BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Quest::get__name() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Quest::_ufle12jhs77_name
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Quest::_ufle12jhs77_name
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 5240878841487721689
IL_0021: ldc.i8 5396122465120423843
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldEntityName
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Quest::_ufle12jhs77_name
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Quest::_ufle12jhs77_name
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::get__savekey() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_savekey
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_savekey
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 4750088267899250312
IL_0021: ldc.i8 -8122192254305908061
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_savekey
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_savekey
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::get__bio_title() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_bio_title
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_bio_title
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 4691033715268080036
IL_0021: ldc.i8 1165774211390421653
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_bio_title
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_bio_title
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.Quest::get__bio_description() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.Quest::_ufle12jhs77_bio_description
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.Quest::_ufle12jhs77_bio_description
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 5534811597815733634
IL_0021: ldc.i8 -5712898835662811262
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldText
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.Quest::_ufle12jhs77_bio_description
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.Quest::_ufle12jhs77_bio_description
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::get__initial_progress_log_unlocks() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_initial_progress_log_unlocks
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_initial_progress_log_unlocks
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 4888298260764154450
IL_0021: ldc.i8 -7375910795658574428
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationMultiple
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_initial_progress_log_unlocks
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_initial_progress_log_unlocks
IL_0044: ret
