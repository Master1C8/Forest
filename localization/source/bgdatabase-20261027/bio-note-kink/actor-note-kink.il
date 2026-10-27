TYPE TheForestOfLove.Narrative.Actor
METHOD TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::get_CurrentBioNotes() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::_currentBioNotes
IL_0006: brtrue.s IL_0014
IL_0008: ldarg.0
IL_0009: ldarg.0
IL_000a: call TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::ChooseBioNotes()
IL_000f: stfld TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::_currentBioNotes
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::_currentBioNotes
IL_001a: ret
METHOD TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::get_CurrentBioKinks() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::_currentBioKinks
IL_0006: brtrue.s IL_0014
IL_0008: ldarg.0
IL_0009: ldarg.0
IL_000a: call TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::ChooseBioKinks()
IL_000f: stfld TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::_currentBioKinks
IL_0014: ldarg.0
IL_0015: ldfld TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::_currentBioKinks
IL_001a: ret
METHOD TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::ChooseBioNotes() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioNotes> TheForestOfLove.Narrative.Actor::bioNotes
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioNotes>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_0057
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioNotes>::get_Current()
IL_0015: stloc.1
IL_0016: ldloc.1
IL_0017: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.BioNotes::enableWithTags
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
IL_0059: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioNotes>::MoveNext()
IL_005e: brtrue.s IL_000e
IL_0060: leave.s IL_0070
IL_0062: ldloca.s V_0
IL_0064: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioNotes>
IL_006a: callvirt System.Void System.IDisposable::Dispose()
IL_006f: endfinally
IL_0070: ldarg.0
IL_0071: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioNotes> TheForestOfLove.Narrative.Actor::bioNotes
IL_0076: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioNotes>::GetEnumerator()
IL_007b: stloc.0
IL_007c: br.s IL_0095
IL_007e: ldloca.s V_0
IL_0080: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioNotes>::get_Current()
IL_0085: stloc.s V_4
IL_0087: ldloc.s V_4
IL_0089: ldfld System.Boolean TheForestOfLove.Narrative.BioNotes::isDefault
IL_008e: brfalse.s IL_0095
IL_0090: ldloc.s V_4
IL_0092: stloc.3
IL_0093: leave.s IL_00cb
IL_0095: ldloca.s V_0
IL_0097: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioNotes>::MoveNext()
IL_009c: brtrue.s IL_007e
IL_009e: leave.s IL_00ae
IL_00a0: ldloca.s V_0
IL_00a2: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioNotes>
IL_00a8: callvirt System.Void System.IDisposable::Dispose()
IL_00ad: endfinally
IL_00ae: ldarg.0
IL_00af: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioNotes> TheForestOfLove.Narrative.Actor::bioNotes
IL_00b4: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioNotes>::get_Count()
IL_00b9: ldc.i4.0
IL_00ba: bgt.s IL_00be
IL_00bc: ldnull
IL_00bd: ret
IL_00be: ldarg.0
IL_00bf: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioNotes> TheForestOfLove.Narrative.Actor::bioNotes
IL_00c4: ldc.i4.0
IL_00c5: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioNotes>::get_Item(System.Int32)
IL_00ca: ret
IL_00cb: ldloc.3
IL_00cc: ret
METHOD TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::ChooseBioKinks() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKinks> TheForestOfLove.Narrative.Actor::bioKinks
IL_0006: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKinks>::GetEnumerator()
IL_000b: stloc.0
IL_000c: br.s IL_0057
IL_000e: ldloca.s V_0
IL_0010: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKinks>::get_Current()
IL_0015: stloc.1
IL_0016: ldloc.1
IL_0017: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.BioKinks::enableWithTags
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
IL_0059: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKinks>::MoveNext()
IL_005e: brtrue.s IL_000e
IL_0060: leave.s IL_0070
IL_0062: ldloca.s V_0
IL_0064: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKinks>
IL_006a: callvirt System.Void System.IDisposable::Dispose()
IL_006f: endfinally
IL_0070: ldarg.0
IL_0071: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKinks> TheForestOfLove.Narrative.Actor::bioKinks
IL_0076: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKinks>::GetEnumerator()
IL_007b: stloc.0
IL_007c: br.s IL_0095
IL_007e: ldloca.s V_0
IL_0080: call !0 System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKinks>::get_Current()
IL_0085: stloc.s V_4
IL_0087: ldloc.s V_4
IL_0089: ldfld System.Boolean TheForestOfLove.Narrative.BioKinks::isDefault
IL_008e: brfalse.s IL_0095
IL_0090: ldloc.s V_4
IL_0092: stloc.3
IL_0093: leave.s IL_00cb
IL_0095: ldloca.s V_0
IL_0097: call System.Boolean System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKinks>::MoveNext()
IL_009c: brtrue.s IL_007e
IL_009e: leave.s IL_00ae
IL_00a0: ldloca.s V_0
IL_00a2: constrained. System.Collections.Generic.List`1/Enumerator<TheForestOfLove.Narrative.BioKinks>
IL_00a8: callvirt System.Void System.IDisposable::Dispose()
IL_00ad: endfinally
IL_00ae: ldarg.0
IL_00af: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKinks> TheForestOfLove.Narrative.Actor::bioKinks
IL_00b4: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKinks>::get_Count()
IL_00b9: ldc.i4.0
IL_00ba: bgt.s IL_00be
IL_00bc: ldnull
IL_00bd: ret
IL_00be: ldarg.0
IL_00bf: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKinks> TheForestOfLove.Narrative.Actor::bioKinks
IL_00c4: ldc.i4.0
IL_00c5: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKinks>::get_Item(System.Int32)
IL_00ca: ret
IL_00cb: ldloc.3
IL_00cc: ret
METHOD System.Void TheForestOfLove.Narrative.Actor::SetDirtyBioData() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: stfld TheForestOfLove.Narrative.BioDetail TheForestOfLove.Narrative.Actor::_currentBioDetail
IL_0007: ldarg.0
IL_0008: ldnull
IL_0009: stfld TheForestOfLove.Narrative.BioNotes TheForestOfLove.Narrative.Actor::_currentBioNotes
IL_000e: ldarg.0
IL_000f: ldnull
IL_0010: stfld TheForestOfLove.Narrative.BioKinks TheForestOfLove.Narrative.Actor::_currentBioKinks
IL_0015: ret
