TYPE TheForestOfLove.Narrative.Actor
METHOD System.String TheForestOfLove.Narrative.Actor::get_NameplateName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0006: brfalse.s IL_0015
IL_0008: ldarg.0
IL_0009: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_000e: ldfld System.String TheForestOfLove.Narrative.BioDetail::overrideNameplateName
IL_0013: brtrue.s IL_001c
IL_0015: ldarg.0
IL_0016: ldfld System.String TheForestOfLove.Narrative.Actor::nameplateNameDbDefault
IL_001b: ret
IL_001c: ldarg.0
IL_001d: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0022: ldfld System.String TheForestOfLove.Narrative.BioDetail::overrideNameplateName
IL_0027: ret
METHOD System.String TheForestOfLove.Narrative.Actor::get_FullName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0006: brfalse.s IL_0015
IL_0008: ldarg.0
IL_0009: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_000e: ldfld System.String TheForestOfLove.Narrative.BioDetail::overrideNameplateName
IL_0013: brtrue.s IL_001c
IL_0015: ldarg.0
IL_0016: ldfld System.String TheForestOfLove.Narrative.Actor::fullNameDbDefault
IL_001b: ret
IL_001c: ldarg.0
IL_001d: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail()
IL_0022: ldfld System.String TheForestOfLove.Narrative.BioDetail::overrideNameplateName
IL_0027: ret
METHOD TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::get_CurrentBioDetail() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::_currentBioDetail
IL_0006: brtrue.s IL_0014
IL_0008: ldarg.0
IL_0009: ldarg.0
IL_000a: call TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::ChooseBioDetail()
IL_000f: stfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::_currentBioDetail
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::_currentBioDetail
IL_001a: ret
METHOD TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::ChooseBioDetail() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail> TheForestOfLove.Narrative.Actor::bioDetails
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_0057
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>::get_Current()
IL_0015: stloc.1
IL_0016: ldloc.1
IL_0017: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.BioDetail::enableWithTags
IL_001c: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::GetEnumerator()
IL_0021: stloc.2
IL_0022: br.s IL_003e
IL_0024: ldloca.s V_2
IL_0026: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::get_Current()
IL_002b: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_0030: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_0035: brfalse.s IL_003e
IL_0037: ldloc.1
IL_0038: stloc.3
IL_0039: leave IL_00cb
IL_003e: ldloca.s V_2
IL_0040: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>::MoveNext()
IL_0045: brtrue.s IL_0024
IL_0047: leave.s IL_0057
IL_0049: ldloca.s V_2
IL_004b: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.Tag>
IL_0051: callvirt System.Void System.IDisposable::Dispose()
IL_0056: endfinally
IL_0057: ldloca.s V_0
IL_0059: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>::MoveNext()
IL_005e: brtrue.s IL_000e
IL_0060: leave.s IL_0070
IL_0062: ldloca.s V_0
IL_0064: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>
IL_006a: callvirt System.Void System.IDisposable::Dispose()
IL_006f: endfinally
IL_0070: ldarg.0
IL_0071: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail> TheForestOfLove.Narrative.Actor::bioDetails
IL_0076: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail>::GetEnumerator()
IL_007b: stloc.0
IL_007c: br.s IL_0095
IL_007e: ldloca.s V_0
IL_0080: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>::get_Current()
IL_0085: stloc.s V_4
IL_0087: ldloc.s V_4
IL_0089: ldfld System.Boolean TheForestOfLove.Narrative.BioDetail::isDefault
IL_008e: brfalse.s IL_0095
IL_0090: ldloc.s V_4
IL_0092: stloc.3
IL_0093: leave.s IL_00cb
IL_0095: ldloca.s V_0
IL_0097: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>::MoveNext()
IL_009c: brtrue.s IL_007e
IL_009e: leave.s IL_00ae
IL_00a0: ldloca.s V_0
IL_00a2: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioDetail>
IL_00a8: callvirt System.Void System.IDisposable::Dispose()
IL_00ad: endfinally
IL_00ae: ldarg.0
IL_00af: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail> TheForestOfLove.Narrative.Actor::bioDetails
IL_00b4: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail>::get_Count()
IL_00b9: ldc.i4.0
IL_00ba: bgt.s IL_00be
IL_00bc: ldnull
IL_00bd: ret
IL_00be: ldarg.0
IL_00bf: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail> TheForestOfLove.Narrative.Actor::bioDetails
IL_00c4: ldc.i4.0
IL_00c5: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioDetail>::get_Item(System.Int32)
IL_00ca: ret
IL_00cb: ldloc.3
IL_00cc: ret
