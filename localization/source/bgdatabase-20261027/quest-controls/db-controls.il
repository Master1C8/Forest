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
METHOD System.String TheForestOfLove.DB.Quest::get_plugin_db_name_prefix() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::get__plugin_db_name_prefix()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.Boolean TheForestOfLove.DB.Quest::get_bio_hidden() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::get__bio_hidden()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD UnityEngine.Sprite TheForestOfLove.DB.Quest::get_bio_portrait() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.Quest::get__bio_portrait()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<UnityEngine.Sprite>::get_Item(System.Int32)
IL_0010: ret
METHOD System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.Quest::get_enable_with_tags() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::get__enable_with_tags()
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
METHOD System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.Quest::get_disable_with_tags() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::get__disable_with_tags()
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
METHOD System.Int32 TheForestOfLove.DB.Quest::get_priority() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.Quest::get__priority()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Int32>::get_Item(System.Int32)
IL_0010: ret
METHOD System.Boolean TheForestOfLove.DB.Quest::get_is_side_quest() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::get__is_side_quest()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::get__plugin_db_name_prefix() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_plugin_db_name_prefix
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_plugin_db_name_prefix
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 4961703850564667073
IL_0021: ldc.i8 -7286546008187290993
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_plugin_db_name_prefix
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.Quest::_ufle12jhs77_plugin_db_name_prefix
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::get__bio_hidden() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::_ufle12jhs77_bio_hidden
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::_ufle12jhs77_bio_hidden
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 4837992080774754454
IL_0021: ldc.i8 4630432799423371146
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::_ufle12jhs77_bio_hidden
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::_ufle12jhs77_bio_hidden
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.Quest::get__bio_portrait() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.Quest::_ufle12jhs77_bio_portrait
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.Quest::_ufle12jhs77_bio_portrait
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 5656940318246575807
IL_0021: ldc.i8 3722964259508705457
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldUnitySprite
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.Quest::_ufle12jhs77_bio_portrait
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.Quest::_ufle12jhs77_bio_portrait
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::get__enable_with_tags() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_enable_with_tags
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_enable_with_tags
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 4735364071870341901
IL_0021: ldc.i8 8129773118933413780
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationMultiple
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_enable_with_tags
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_enable_with_tags
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::get__disable_with_tags() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_disable_with_tags
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_disable_with_tags
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 5555996381496584989
IL_0021: ldc.i8 -4168778038082818391
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationMultiple
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_disable_with_tags
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.Quest::_ufle12jhs77_disable_with_tags
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.Quest::get__priority() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.Quest::_ufle12jhs77_priority
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.Quest::_ufle12jhs77_priority
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 4702927273403816490
IL_0021: ldc.i8 5364218654441041050
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldInt
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.Quest::_ufle12jhs77_priority
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.Quest::_ufle12jhs77_priority
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::get__is_side_quest() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::_ufle12jhs77_is_side_quest
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::_ufle12jhs77_is_side_quest
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.Quest::get_MetaDefault()
IL_0018: ldc.i8 5125635714417641105
IL_0021: ldc.i8 -4283958814135479889
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::_ufle12jhs77_is_side_quest
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.Quest::_ufle12jhs77_is_side_quest
IL_0044: ret
