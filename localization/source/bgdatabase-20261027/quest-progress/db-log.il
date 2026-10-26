TYPE TheForestOfLove.DB.QuestProgressLogText
METHOD BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::get_MetaDefault() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::_metaDefault
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::_metaDefault
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaEntity::get_IsDeleted()
IL_0011: brfalse.s IL_0039
IL_0013: call BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::get_I()
IL_0018: ldc.i8 5397363346479325431
IL_0021: ldc.i8 -6215475936526550344
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: callvirt !!0 BansheeGz.BGDatabase.BGRepo::GetMeta<BansheeGz.BGDatabase.BGMetaRow>(BansheeGz.BGDatabase.BGId)
IL_0034: stsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::_metaDefault
IL_0039: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::_metaDefault
IL_003e: ret
METHOD System.String TheForestOfLove.DB.QuestProgressLogText::get_name() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.QuestProgressLogText::get__name()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.String TheForestOfLove.DB.QuestProgressLogText::get_savekey() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::get__savekey()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.Quest TheForestOfLove.DB.QuestProgressLogText::get_quest() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::get__quest()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.Quest
IL_0015: ret
METHOD System.String TheForestOfLove.DB.QuestProgressLogText::get_log_text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::get__log_text()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.Int32 TheForestOfLove.DB.QuestProgressLogText::get_priority() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.QuestProgressLogText::get__priority()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Int32>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.QuestProgressLogText TheForestOfLove.DB.QuestProgressLogText::get_replace_earlier_log_text() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::get__replace_earlier_log_text()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.QuestProgressLogText
IL_0015: ret
METHOD BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.QuestProgressLogText::get__name() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_name
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_name
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::get_MetaDefault()
IL_0018: ldc.i8 5071535877161837801
IL_0021: ldc.i8 7799249607326204315
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldEntityName
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_name
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_name
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::get__savekey() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_savekey
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_savekey
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::get_MetaDefault()
IL_0018: ldc.i8 5484872052118656193
IL_0021: ldc.i8 -4231124851988443764
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_savekey
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_savekey
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::get__quest() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_quest
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_quest
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::get_MetaDefault()
IL_0018: ldc.i8 5211814276320714740
IL_0021: ldc.i8 -1255584730107192156
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_quest
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_quest
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::get__log_text() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_log_text
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_log_text
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::get_MetaDefault()
IL_0018: ldc.i8 4715567209323608565
IL_0021: ldc.i8 6584987792663131790
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_log_text
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_log_text
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.QuestProgressLogText::get__priority() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_priority
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_priority
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::get_MetaDefault()
IL_0018: ldc.i8 5307520695686995902
IL_0021: ldc.i8 3021657292329584538
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldInt
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_priority
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldInt TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_priority
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::get__replace_earlier_log_text() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_replace_earlier_log_text
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_replace_earlier_log_text
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::get_MetaDefault()
IL_0018: ldc.i8 4694728823213588382
IL_0021: ldc.i8 -4166849755453408886
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_replace_earlier_log_text
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.QuestProgressLogText::_ufle12jhs77_replace_earlier_log_text
IL_0044: ret
METHOD TheForestOfLove.DB.QuestProgressLogText TheForestOfLove.DB.QuestProgressLogText::GetEntity(BansheeGz.BGDatabase.BGId) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::get_MetaDefault()
IL_0005: ldarg.0
IL_0006: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::GetEntity(BansheeGz.BGDatabase.BGId)
IL_000b: castclass TheForestOfLove.DB.QuestProgressLogText
IL_0010: ret
METHOD TheForestOfLove.DB.QuestProgressLogText TheForestOfLove.DB.QuestProgressLogText::GetEntity(System.Int32) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::get_MetaDefault()
IL_0005: ldarg.0
IL_0006: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::get_Item(System.Int32)
IL_000b: castclass TheForestOfLove.DB.QuestProgressLogText
IL_0010: ret
METHOD TheForestOfLove.DB.QuestProgressLogText TheForestOfLove.DB.QuestProgressLogText::GetEntity(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.QuestProgressLogText::get_MetaDefault()
IL_0005: ldarg.0
IL_0006: callvirt BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::GetEntity(System.String)
IL_000b: castclass TheForestOfLove.DB.QuestProgressLogText
IL_0010: ret
