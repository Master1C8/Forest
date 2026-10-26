TYPE TheForestOfLove.DB.InventoryItem
METHOD BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::get_MetaDefault() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::_metaDefault
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::_metaDefault
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaEntity::get_IsDeleted()
IL_0011: brfalse.s IL_0039
IL_0013: call BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::get_I()
IL_0018: ldc.i8 4875482534925704400
IL_0021: ldc.i8 6300976021146803347
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: callvirt !!0 BansheeGz.BGDatabase.BGRepo::GetMeta<BansheeGz.BGDatabase.BGMetaRow>(BansheeGz.BGDatabase.BGId)
IL_0034: stsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::_metaDefault
IL_0039: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::_metaDefault
IL_003e: ret
METHOD System.String TheForestOfLove.DB.InventoryItem::get_title() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::get__title()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.String TheForestOfLove.DB.InventoryItem::get_notification_phrase() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::get__notification_phrase()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.String TheForestOfLove.DB.InventoryItem::get_description() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.InventoryItem::get__description()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.InventoryItem::get__name() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.InventoryItem::_ufle12jhs77_name
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.InventoryItem::_ufle12jhs77_name
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::get_MetaDefault()
IL_0018: ldc.i8 5231855555543886240
IL_0021: ldc.i8 -1731094571598500730
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldEntityName
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.InventoryItem::_ufle12jhs77_name
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.InventoryItem::_ufle12jhs77_name
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::get__savekey() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_savekey
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_savekey
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::get_MetaDefault()
IL_0018: ldc.i8 4842474032250506977
IL_0021: ldc.i8 -1540150254692081740
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_savekey
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_savekey
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::get__title() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_title
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_title
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::get_MetaDefault()
IL_0018: ldc.i8 5624891656969968777
IL_0021: ldc.i8 -1030243805044422986
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_title
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_title
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::get__notification_phrase() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_notification_phrase
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_notification_phrase
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::get_MetaDefault()
IL_0018: ldc.i8 5128251110548561762
IL_0021: ldc.i8 4262829653906012296
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_notification_phrase
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.InventoryItem::_ufle12jhs77_notification_phrase
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.InventoryItem::get__description() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.InventoryItem::_ufle12jhs77_description
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.InventoryItem::_ufle12jhs77_description
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::get_MetaDefault()
IL_0018: ldc.i8 4722192831951735628
IL_0021: ldc.i8 8338670270013747122
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldText
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.InventoryItem::_ufle12jhs77_description
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldText TheForestOfLove.DB.InventoryItem::_ufle12jhs77_description
IL_0044: ret
METHOD TheForestOfLove.DB.InventoryItem TheForestOfLove.DB.InventoryItem::get_db_Driftwood() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.InventoryItem::get_MetaDefault()
IL_0005: ldstr "Driftwood"
IL_000a: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::GetEntity(System.String)
IL_000f: castclass TheForestOfLove.DB.InventoryItem
IL_0014: ret
