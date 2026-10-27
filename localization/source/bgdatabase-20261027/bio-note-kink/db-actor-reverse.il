TYPE TheForestOfLove.DB.Actor
METHOD System.Collections.Generic.List`1<TheForestOfLove.DB.BioNote> TheForestOfLove.DB.Actor::get_RelatedBioNoteListUsingactorRelation() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioNote::get__actor()
IL_0005: ldarg.0
IL_0006: call BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGObject::get_Id()
IL_000b: ldsfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> TheForestOfLove.DB.Actor::_tugjbyuhfv_reusableList
IL_0010: callvirt System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::GetRelatedIn(BansheeGz.BGDatabase.BGId,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>)
IL_0015: stloc.0
IL_0016: ldloc.0
IL_0017: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_001c: brtrue.s IL_0020
IL_001e: ldnull
IL_001f: ret
IL_0020: ldloc.0
IL_0021: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_0026: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DB.BioNote>::.ctor(System.Int32)
IL_002b: stloc.1
IL_002c: ldc.i4.0
IL_002d: stloc.2
IL_002e: br.s IL_0046
IL_0030: ldloc.1
IL_0031: ldloc.0
IL_0032: ldloc.2
IL_0033: callvirt !0 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0038: castclass TheForestOfLove.DB.BioNote
IL_003d: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DB.BioNote>::Add(!0)
IL_0042: ldloc.2
IL_0043: ldc.i4.1
IL_0044: add
IL_0045: stloc.2
IL_0046: ldloc.2
IL_0047: ldloc.0
IL_0048: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_004d: blt.s IL_0030
IL_004f: ldsfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> TheForestOfLove.DB.Actor::_tugjbyuhfv_reusableList
IL_0054: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Clear()
IL_0059: ldloc.1
IL_005a: ret
METHOD System.Collections.Generic.List`1<TheForestOfLove.DB.BioKink> TheForestOfLove.DB.Actor::get_RelatedBioKinkListUsingactorRelation() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: call BansheeGz.BGDatabase.BGFieldRelationSingle TheForestOfLove.DB.BioKink::get__actor()
IL_0005: ldarg.0
IL_0006: call BansheeGz.BGDatabase.BGId BansheeGz.BGDatabase.BGObject::get_Id()
IL_000b: ldsfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> TheForestOfLove.DB.Actor::_tugjbyuhfv_reusableList
IL_0010: callvirt System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> BansheeGz.BGDatabase.BGFieldRelationA`2<BansheeGz.BGDatabase.BGEntity,BansheeGz.BGDatabase.BGId>::GetRelatedIn(BansheeGz.BGDatabase.BGId,System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>)
IL_0015: stloc.0
IL_0016: ldloc.0
IL_0017: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_001c: brtrue.s IL_0020
IL_001e: ldnull
IL_001f: ret
IL_0020: ldloc.0
IL_0021: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_0026: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.DB.BioKink>::.ctor(System.Int32)
IL_002b: stloc.1
IL_002c: ldc.i4.0
IL_002d: stloc.2
IL_002e: br.s IL_0046
IL_0030: ldloc.1
IL_0031: ldloc.0
IL_0032: ldloc.2
IL_0033: callvirt !0 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Item(System.Int32)
IL_0038: castclass TheForestOfLove.DB.BioKink
IL_003d: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.DB.BioKink>::Add(!0)
IL_0042: ldloc.2
IL_0043: ldc.i4.1
IL_0044: add
IL_0045: stloc.2
IL_0046: ldloc.2
IL_0047: ldloc.0
IL_0048: callvirt System.Int32 System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::get_Count()
IL_004d: blt.s IL_0030
IL_004f: ldsfld System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity> TheForestOfLove.DB.Actor::_tugjbyuhfv_reusableList
IL_0054: callvirt System.Void System.Collections.Generic.List`1<BansheeGz.BGDatabase.BGEntity>::Clear()
IL_0059: ldloc.1
IL_005a: ret
