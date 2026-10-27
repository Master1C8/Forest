TYPE TheForestOfLove.DB.DialogueType
METHOD BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.DialogueType::get_MetaDefault() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.DialogueType::_metaDefault
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.DialogueType::_metaDefault
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaEntity::get_IsDeleted()
IL_0011: brfalse.s IL_0039
IL_0013: call BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::get_I()
IL_0018: ldc.i8 5377512834470643499
IL_0021: ldc.i8 4884351825058482596
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: callvirt !!0 BansheeGz.BGDatabase.BGRepo::GetMeta<BansheeGz.BGDatabase.BGMetaRow>(BansheeGz.BGDatabase.BGId)
IL_0034: stsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.DialogueType::_metaDefault
IL_0039: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.DialogueType::_metaDefault
IL_003e: ret
METHOD TheForestOfLove.Narrative.DialogueType TheForestOfLove.DB.DialogueType::get_enum_type() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldEnum TheForestOfLove.DB.DialogueType::get__enum_type()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Enum>::get_Item(System.Int32)
IL_0010: unbox.any TheForestOfLove.Narrative.DialogueType
IL_0015: ret
METHOD BansheeGz.BGDatabase.BGFieldEnum TheForestOfLove.DB.DialogueType::get__enum_type() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldEnum TheForestOfLove.DB.DialogueType::_ufle12jhs77_enum_type
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldEnum TheForestOfLove.DB.DialogueType::_ufle12jhs77_enum_type
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.DialogueType::get_MetaDefault()
IL_0018: ldc.i8 5394450478734084809
IL_0021: ldc.i8 -6223840383886163063
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldEnum
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldEnum TheForestOfLove.DB.DialogueType::_ufle12jhs77_enum_type
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldEnum TheForestOfLove.DB.DialogueType::_ufle12jhs77_enum_type
IL_0044: ret
