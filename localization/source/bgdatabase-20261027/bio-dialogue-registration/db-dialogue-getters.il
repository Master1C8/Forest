TYPE TheForestOfLove.DB.Dialogue
METHOD BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::get_MetaDefault() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::_metaDefault
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::_metaDefault
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaEntity::get_IsDeleted()
IL_0011: brfalse.s IL_0039
IL_0013: call BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::get_I()
IL_0018: ldc.i8 5186994640575892041
IL_0021: ldc.i8 -5204880208797952639
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: callvirt !!0 BansheeGz.BGDatabase.BGRepo::GetMeta<BansheeGz.BGDatabase.BGMetaRow>(BansheeGz.BGDatabase.BGId)
IL_0034: stsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::_metaDefault
IL_0039: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::_metaDefault
IL_003e: ret
METHOD System.String TheForestOfLove.DB.Dialogue::get_name() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Dialogue::get__name()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.String TheForestOfLove.DB.Dialogue::get_savekey() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::get__savekey()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.String TheForestOfLove.DB.Dialogue::get_plugin_db_name() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::get__plugin_db_name()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.DialogueType TheForestOfLove.DB.Dialogue::get_type() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::get__type()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.DialogueType
IL_0015: ret
METHOD TheForestOfLove.DB.Actor TheForestOfLove.DB.Dialogue::get_primary_actor() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::get__primary_actor()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.Actor
IL_0015: ret
METHOD TheForestOfLove.DB.Actor TheForestOfLove.DB.Dialogue::get_initial_actor() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::get__initial_actor()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.Actor
IL_0015: ret
METHOD System.Boolean TheForestOfLove.DB.Dialogue::get_has_player_initiated_question() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Dialogue::get__has_player_initiated_question()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Dialogue::get__name() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Dialogue::_ufle12jhs77_name
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Dialogue::_ufle12jhs77_name
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::get_MetaDefault()
IL_0018: ldc.i8 4832079126583876694
IL_0021: ldc.i8 964365646006212277
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldEntityName
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Dialogue::_ufle12jhs77_name
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.Dialogue::_ufle12jhs77_name
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::get__savekey() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::_ufle12jhs77_savekey
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::_ufle12jhs77_savekey
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::get_MetaDefault()
IL_0018: ldc.i8 5315516878246595761
IL_0021: ldc.i8 -6529176669670059109
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::_ufle12jhs77_savekey
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::_ufle12jhs77_savekey
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::get__plugin_db_name() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::_ufle12jhs77_plugin_db_name
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::_ufle12jhs77_plugin_db_name
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::get_MetaDefault()
IL_0018: ldc.i8 4889001345981858315
IL_0021: ldc.i8 7627446667586252711
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::_ufle12jhs77_plugin_db_name
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Dialogue::_ufle12jhs77_plugin_db_name
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::get__type() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_type
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_type
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::get_MetaDefault()
IL_0018: ldc.i8 5482024998712019010
IL_0021: ldc.i8 -6520382398425632127
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_type
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_type
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::get__primary_actor() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_primary_actor
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_primary_actor
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::get_MetaDefault()
IL_0018: ldc.i8 5512898930386803913
IL_0021: ldc.i8 3905708340044543889
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_primary_actor
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_primary_actor
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::get__initial_actor() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_initial_actor
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_initial_actor
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::get_MetaDefault()
IL_0018: ldc.i8 5561099663721854302
IL_0021: ldc.i8 -8995505353553775191
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_initial_actor
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.Dialogue::_ufle12jhs77_initial_actor
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Dialogue::get__has_player_initiated_question() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Dialogue::_ufle12jhs77_has_player_initiated_question
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Dialogue::_ufle12jhs77_has_player_initiated_question
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::get_MetaDefault()
IL_0018: ldc.i8 4783167786055739498
IL_0021: ldc.i8 -8324635400639073396
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Dialogue::_ufle12jhs77_has_player_initiated_question
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Dialogue::_ufle12jhs77_has_player_initiated_question
IL_0044: ret
METHOD System.Void TheForestOfLove.DB.Dialogue::ForEachEntity(System.Action`1<TheForestOfLove.DB.Dialogue>,System.Predicate`1<TheForestOfLove.DB.Dialogue>,System.Comparison`1<TheForestOfLove.DB.Dialogue>) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.DB.Dialogue/<>c__DisplayClass1388_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.0
IL_0008: stfld System.Action`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.Dialogue/<>c__DisplayClass1388_0::action
IL_000d: ldloc.0
IL_000e: ldarg.1
IL_000f: stfld System.Predicate`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.Dialogue/<>c__DisplayClass1388_0::filter
IL_0014: ldloc.0
IL_0015: ldarg.2
IL_0016: stfld System.Comparison`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.Dialogue/<>c__DisplayClass1388_0::sort
IL_001b: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Dialogue::get_MetaDefault()
IL_0020: ldloc.0
IL_0021: ldftn System.Void TheForestOfLove.DB.Dialogue/<>c__DisplayClass1388_0::<ForEachEntity>b__0(BansheeGz.BGDatabase.BGEntity)
IL_0027: newobj System.Void System.Action`1<BansheeGz.BGDatabase.BGEntity>::.ctor(System.Object,System.IntPtr)
IL_002c: ldloc.0
IL_002d: ldfld System.Predicate`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.Dialogue/<>c__DisplayClass1388_0::filter
IL_0032: brfalse.s IL_0042
IL_0034: ldloc.0
IL_0035: ldftn System.Boolean TheForestOfLove.DB.Dialogue/<>c__DisplayClass1388_0::<ForEachEntity>b__1(BansheeGz.BGDatabase.BGEntity)
IL_003b: newobj System.Void System.Predicate`1<BansheeGz.BGDatabase.BGEntity>::.ctor(System.Object,System.IntPtr)
IL_0040: br.s IL_0043
IL_0042: ldnull
IL_0043: ldloc.0
IL_0044: ldfld System.Comparison`1<TheForestOfLove.DB.Dialogue> TheForestOfLove.DB.Dialogue/<>c__DisplayClass1388_0::sort
IL_0049: brfalse.s IL_0059
IL_004b: ldloc.0
IL_004c: ldftn System.Int32 TheForestOfLove.DB.Dialogue/<>c__DisplayClass1388_0::<ForEachEntity>b__2(BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGEntity)
IL_0052: newobj System.Void System.Comparison`1<BansheeGz.BGDatabase.BGEntity>::.ctor(System.Object,System.IntPtr)
IL_0057: br.s IL_005a
IL_0059: ldnull
IL_005a: callvirt System.Void BansheeGz.BGDatabase.BGMetaEntity::ForEachEntity(System.Action`1<BansheeGz.BGDatabase.BGEntity>,System.Predicate`1<BansheeGz.BGDatabase.BGEntity>,System.Comparison`1<BansheeGz.BGDatabase.BGEntity>)
IL_005f: ret
