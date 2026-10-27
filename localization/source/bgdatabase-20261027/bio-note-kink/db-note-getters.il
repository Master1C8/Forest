TYPE TheForestOfLove.DB.BioNote
METHOD BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::_metaDefault
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::_metaDefault
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaEntity::get_IsDeleted()
IL_0011: brfalse.s IL_0039
IL_0013: call BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::get_I()
IL_0018: ldc.i8 4916296028795347281
IL_0021: ldc.i8 -5693403783081486689
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: callvirt !!0 BansheeGz.BGDatabase.BGRepo::GetMeta<BansheeGz.BGDatabase.BGMetaRow>(BansheeGz.BGDatabase.BGId)
IL_0034: stsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::_metaDefault
IL_0039: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::_metaDefault
IL_003e: ret
METHOD TheForestOfLove.DB.Actor TheForestOfLove.DB.BioNote::get_actor() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__actor()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.Actor
IL_0015: ret
METHOD System.String TheForestOfLove.DB.BioNote::get_name() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioNote::get__name()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note1() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note1()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list1() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list1()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note2() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note2()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list2() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list2()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note3() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note3()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list3() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list3()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note4() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note4()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list4() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list4()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note5() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note5()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list5() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list5()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioNote::get_note6() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note6()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioNote::get_hide_in_list6() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list6()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.BioNote::get_enable_with_tags() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioNote::get__enable_with_tags()
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
IL_001e: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::.ctor()
IL_0023: stloc.1
IL_0024: ldc.i4.0
IL_0025: stloc.2
IL_0026: br.s IL_003e
IL_0028: ldloc.1
IL_0029: ldloc.0
IL_002a: ldloc.2
IL_002b: callvirt !0 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0030: castclass TheForestOfLove.DB.Tag
IL_0035: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DB.Tag>::Add(!0)
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
METHOD System.Boolean TheForestOfLove.DB.BioNote::get_is_default() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__is_default()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__actor() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_actor
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_actor
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 4693894742948193352
IL_0021: ldc.i8 -9216029046157367362
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_actor
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_actor
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioNote::get__name() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioNote::_ufle12jhs77_name
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioNote::_ufle12jhs77_name
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 4734860737248431526
IL_0021: ldc.i8 4485319834181225113
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldEntityName
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioNote::_ufle12jhs77_name
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioNote::_ufle12jhs77_name
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note1() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note1
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note1
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 5129413509123655402
IL_0021: ldc.i8 -2346695317356338251
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note1
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note1
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list1() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list1
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list1
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 5329509569421122361
IL_0021: ldc.i8 -1254661472418791752
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list1
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list1
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note2() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note2
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note2
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 5244924622172097306
IL_0021: ldc.i8 -3618365025854324053
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note2
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note2
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list2() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list2
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list2
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 5184755479226807491
IL_0021: ldc.i8 7047254430511891636
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list2
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list2
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note3() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note3
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note3
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 4913854942254204886
IL_0021: ldc.i8 -570829425467872834
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note3
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note3
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list3() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list3
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list3
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 5535494510816295046
IL_0021: ldc.i8 -6027250455679360881
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list3
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list3
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note4() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note4
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note4
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 5055495815352444377
IL_0021: ldc.i8 6526145212969457596
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note4
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note4
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list4() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list4
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list4
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 5554557868552472065
IL_0021: ldc.i8 -27468804658525016
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list4
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list4
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note5() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note5
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note5
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 5438199876797032630
IL_0021: ldc.i8 -6237397597860174168
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note5
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note5
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list5() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list5
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list5
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 5356301597228230883
IL_0021: ldc.i8 6984345488994372029
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list5
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list5
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__note6() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note6
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note6
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 4665170037703364951
IL_0021: ldc.i8 9012401090116314303
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note6
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::_ufle12jhs77_note6
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__hide_in_list6() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list6
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list6
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 5178644195780902293
IL_0021: ldc.i8 -1838777885610627416
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list6
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_hide_in_list6
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioNote::get__enable_with_tags() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioNote::_ufle12jhs77_enable_with_tags
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioNote::_ufle12jhs77_enable_with_tags
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 4662688314245388999
IL_0021: ldc.i8 -2041826073970765148
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationMultiple
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioNote::_ufle12jhs77_enable_with_tags
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioNote::_ufle12jhs77_enable_with_tags
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::get__is_default() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_is_default
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_is_default
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioNote::get_MetaDefault()
IL_0018: ldc.i8 4752641689755277882
IL_0021: ldc.i8 7755828315855880850
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_is_default
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioNote::_ufle12jhs77_is_default
IL_0044: ret
