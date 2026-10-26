TYPE TheForestOfLove.DB.BioDetail
METHOD BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::_metaDefault
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::_metaDefault
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaEntity::get_IsDeleted()
IL_0011: brfalse.s IL_0039
IL_0013: call BansheeGz.BGDatabase.BGRepo BansheeGz.BGDatabase.BGRepo::get_I()
IL_0018: ldc.i8 5342626577799794434
IL_0021: ldc.i8 -2654646392181535325
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: callvirt !!0 BansheeGz.BGDatabase.BGRepo::GetMeta<BansheeGz.BGDatabase.BGMetaRow>(BansheeGz.BGDatabase.BGId)
IL_0034: stsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::_metaDefault
IL_0039: ldsfld BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::_metaDefault
IL_003e: ret
METHOD System.String TheForestOfLove.DB.BioDetail::get_name() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioDetail::get__name()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.Actor TheForestOfLove.DB.BioDetail::get_actor() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::get__actor()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.Actor
IL_0015: ret
METHOD UnityEngine.Sprite TheForestOfLove.DB.BioDetail::get_bio_portrait() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.BioDetail::get__bio_portrait()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<UnityEngine.Sprite>::get_Item(System.Int32)
IL_0010: ret
METHOD System.String TheForestOfLove.DB.BioDetail::get_nameplate_name_override() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::get__nameplate_name_override()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD System.String TheForestOfLove.DB.BioDetail::get_full_name_override() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::get__full_name_override()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.String>::get_Item(System.Int32)
IL_0010: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioDetail::get_line1() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::get__line1()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioDetail::get_line2() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::get__line2()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD TheForestOfLove.DB.BioKeyword TheForestOfLove.DB.BioDetail::get_line3() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::get__line3()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0010: castclass TheForestOfLove.DB.BioKeyword
IL_0015: ret
METHOD System.Collections.Generic.List`1<TheForestOfLove.DB.Tag> TheForestOfLove.DB.BioDetail::get_enable_with_tags() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioDetail::get__enable_with_tags()
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
METHOD System.Boolean TheForestOfLove.DB.BioDetail::get_is_default() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioDetail::get__is_default()
IL_0005: ldarg.0
IL_0006: call System.Int32 BansheeGz.BGDatabase.BGEntity::get_Index()
IL_000b: callvirt !0 BansheeGz.BGDatabase.BGField`1<System.Boolean>::get_Item(System.Int32)
IL_0010: ret
METHOD BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioDetail::get__name() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioDetail::_ufle12jhs77_name
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioDetail::_ufle12jhs77_name
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault()
IL_0018: ldc.i8 5432798026137392134
IL_0021: ldc.i8 828539843295080607
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldEntityName
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioDetail::_ufle12jhs77_name
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldEntityName TheForestOfLove.DB.BioDetail::_ufle12jhs77_name
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::get__actor() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_actor
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_actor
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault()
IL_0018: ldc.i8 4750627849456618795
IL_0021: ldc.i8 5200007095987569826
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_actor
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_actor
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.BioDetail::get__bio_portrait() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.BioDetail::_ufle12jhs77_bio_portrait
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.BioDetail::_ufle12jhs77_bio_portrait
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault()
IL_0018: ldc.i8 5365632016540816215
IL_0021: ldc.i8 7717455939792056494
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldUnitySprite
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.BioDetail::_ufle12jhs77_bio_portrait
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldUnitySprite TheForestOfLove.DB.BioDetail::_ufle12jhs77_bio_portrait
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::get__nameplate_name_override() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::_ufle12jhs77_nameplate_name_override
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::_ufle12jhs77_nameplate_name_override
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault()
IL_0018: ldc.i8 4728415867765000630
IL_0021: ldc.i8 1724385386212012722
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::_ufle12jhs77_nameplate_name_override
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::_ufle12jhs77_nameplate_name_override
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::get__full_name_override() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::_ufle12jhs77_full_name_override
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::_ufle12jhs77_full_name_override
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault()
IL_0018: ldc.i8 5455373711612677248
IL_0021: ldc.i8 485643166880701847
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldString
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::_ufle12jhs77_full_name_override
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldString TheForestOfLove.DB.BioDetail::_ufle12jhs77_full_name_override
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::get__line1() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line1
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line1
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault()
IL_0018: ldc.i8 4781238539337074424
IL_0021: ldc.i8 -9133934822613376128
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line1
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line1
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::get__line2() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line2
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line2
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault()
IL_0018: ldc.i8 5531204908234959095
IL_0021: ldc.i8 7020886449557525929
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line2
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line2
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::get__line3() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line3
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line3
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault()
IL_0018: ldc.i8 5553049655598499074
IL_0021: ldc.i8 -6336114194036340554
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationSingle
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line3
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioDetail::_ufle12jhs77_line3
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioDetail::get__enable_with_tags() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioDetail::_ufle12jhs77_enable_with_tags
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioDetail::_ufle12jhs77_enable_with_tags
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault()
IL_0018: ldc.i8 5099513676563224074
IL_0021: ldc.i8 3099266209387437189
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldRelationMultiple
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioDetail::_ufle12jhs77_enable_with_tags
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldRelationMultiple TheForestOfLove.DB.BioDetail::_ufle12jhs77_enable_with_tags
IL_0044: ret
METHOD BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioDetail::get__is_default() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioDetail::_ufle12jhs77_is_default
IL_0005: brfalse.s IL_0013
IL_0007: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioDetail::_ufle12jhs77_is_default
IL_000c: callvirt System.Boolean BansheeGz.BGDatabase.BGMetaObject::get_IsDeleted()
IL_0011: brfalse.s IL_003f
IL_0013: call BansheeGz.BGDatabase.BGMetaRow TheForestOfLove.DB.BioDetail::get_MetaDefault()
IL_0018: ldc.i8 5540480614163525852
IL_0021: ldc.i8 5785537830615932049
IL_002a: newobj System.Void BansheeGz.BGDatabase.BGId::.ctor(System.UInt64,System.UInt64)
IL_002f: ldc.i4.1
IL_0030: callvirt BansheeGz.BGDatabase.BGField BansheeGz.BGDatabase.BGMetaEntity::GetField(BansheeGz.BGDatabase.BGId,System.Boolean)
IL_0035: castclass BansheeGz.BGDatabase.BGFieldBool
IL_003a: stsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioDetail::_ufle12jhs77_is_default
IL_003f: ldsfld BansheeGz.BGDatabase.BGFieldBool TheForestOfLove.DB.BioDetail::_ufle12jhs77_is_default
IL_0044: ret
