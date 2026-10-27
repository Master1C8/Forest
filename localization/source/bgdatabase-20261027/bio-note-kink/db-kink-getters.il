TYPE TheForestOfLove.DB.BioKink
METHOD BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::_metaDefault
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::_metaDefault
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaEntity::get_IsDeleted()
IL_0011: brfalse.s IL_0039
IL_0013: call BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::get_I()
IL_0018: ldc.i8 5415372668414125338
IL_0021: ldc.i8 -4609522770903404131
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: callvirt !!0 BansheeGz.BGDatabase.BGRepo::GetMeta<BansheeGz.BGDatabase.BGMetaRow>(BansheeGz.BGDatabase.BGId)
IL_0034: stsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::_metaDefault
IL_0039: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::_metaDefault
IL_003e: ret
METHOD TheForestOfLove.DB.Actor TheForestOfLove.DB.BioKink::get_actor() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__actor()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.Actor
IL_0015: ret
METHOD System.String TheForestOfLove.DB.BioKink::get_name() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioKink::get__name()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink1() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink1()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list1() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list1()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink2() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink2()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list2() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list2()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink3() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink3()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list3() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list3()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink4() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink4()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list4() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list4()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink5() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink5()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list5() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list5()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink6() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink6()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list6() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list6()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink7() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink7()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list7() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list7()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink8() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink8()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list8() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list8()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioKink::get_kink9() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink9()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.BioKink::get_hide_in_list9() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list9()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.BioKink::get_enable_with_tags() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioKink::get__enable_with_tags()
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
METHOD System.Boolean TheForestOfLove.DB.BioKink::get_is_default() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__is_default()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__actor() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_actor
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_actor
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5236998036709556059
IL_0021: ldc.i8 2078688122715018660
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_actor
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_actor
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioKink::get__name() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioKink::_ufle12jhs77_name
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioKink::_ufle12jhs77_name
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5264988055843652369
IL_0021: ldc.i8 7816250005646683565
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldEntityName
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioKink::_ufle12jhs77_name
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioKink::_ufle12jhs77_name
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink1() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink1
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink1
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 4685224810630369131
IL_0021: ldc.i8 8513865963305736073
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink1
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink1
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list1() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list1
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list1
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5312023778917977106
IL_0021: ldc.i8 7321308461846195585
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list1
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list1
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink2() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink2
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink2
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 4825797351955662729
IL_0021: ldc.i8 4869745279165889418
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink2
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink2
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list2() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list2
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list2
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5635777437877888231
IL_0021: ldc.i8 -2155673729662876271
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list2
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list2
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink3() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink3
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink3
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5032102826153108868
IL_0021: ldc.i8 2344873266172378766
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink3
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink3
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list3() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list3
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list3
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5758547671070323547
IL_0021: ldc.i8 488062075803052693
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list3
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list3
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink4() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink4
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink4
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5234524297935563822
IL_0021: ldc.i8 7482459938446172294
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink4
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink4
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list4() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list4
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list4
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 4665608674022804422
IL_0021: ldc.i8 1244282467709499050
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list4
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list4
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink5() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink5
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink5
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5183845681922203729
IL_0021: ldc.i8 -4338012391659425661
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink5
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink5
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list5() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list5
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list5
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5313762068264452453
IL_0021: ldc.i8 -210354916580782964
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list5
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list5
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink6() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink6
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink6
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 4906123774219443465
IL_0021: ldc.i8 2839442253117794736
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink6
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink6
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list6() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list6
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list6
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 4953904470679347005
IL_0021: ldc.i8 2359485601702871960
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list6
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list6
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink7() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink7
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink7
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 4679218150311789638
IL_0021: ldc.i8 -5401462960322239324
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink7
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink7
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list7() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list7
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list7
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 4737271193370059065
IL_0021: ldc.i8 704893762578991279
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list7
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list7
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink8() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink8
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink8
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5631374983662025903
IL_0021: ldc.i8 539966666971862168
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink8
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink8
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list8() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list8
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list8
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5001664133422461666
IL_0021: ldc.i8 -6857995417662781567
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list8
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list8
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__kink9() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink9
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink9
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 4968730802088179351
IL_0021: ldc.i8 5497532262753037717
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink9
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::_ufle12jhs77_kink9
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__hide_in_list9() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list9
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list9
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5409927635927150188
IL_0021: ldc.i8 5348234262008908446
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list9
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_hide_in_list9
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioKink::get__enable_with_tags() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioKink::_ufle12jhs77_enable_with_tags
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioKink::_ufle12jhs77_enable_with_tags
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 4847668619881204241
IL_0021: ldc.i8 -8518988333927152453
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationMultiple
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioKink::_ufle12jhs77_enable_with_tags
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioKink::_ufle12jhs77_enable_with_tags
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::get__is_default() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_is_default
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_is_default
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioKink::get_MetaDefault()
IL_0018: ldc.i8 5273397240069056098
IL_0021: ldc.i8 -5788161457318952028
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_is_default
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioKink::_ufle12jhs77_is_default
IL_0044: ret
