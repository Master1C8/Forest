TYPE TheForestOfLove.Narrative.ActorTrackingService
METHOD System.Void TheForestOfLove.Narrative.ActorTrackingService::OnActiveTagsChanged() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Services.Persistence.DataService::GetActors()
IL_0005: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Actor>::GetEnumerator()
IL_000a: stloc.0
IL_000b: br.s IL_0018
IL_000d: ldloc.0
IL_000e: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Actor>::get_Current()
IL_0013: callvirt System.Void TheForestOfLove.Narrative.Actor::SetDirtyBioData()
IL_0018: ldloc.0
IL_0019: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_001e: brtrue.s IL_000d
IL_0020: leave.s IL_002c
IL_0022: ldloc.0
IL_0023: brfalse.s IL_002b
IL_0025: ldloc.0
IL_0026: callvirt System.Void System.IDisposable::Dispose()
IL_002b: endfinally
IL_002c: ret
