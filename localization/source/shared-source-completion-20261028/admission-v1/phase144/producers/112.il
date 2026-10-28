TYPE TheForestOfLove.Narrative.ActorDialogueOracle
METHOD TheForestOfLove.Narrative.DialogueTrackingSchema TheForestOfLove.Narrative.ActorDialogueOracle::TrackSelectedGossip(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.ActorDialogueOracle::actor
IL_0006: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_000b: call System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Services.Persistence.DataService::GetGossipDialoguesByPrimaryActor(System.String)
IL_0010: ldnull
IL_0011: stloc.0
IL_0012: callvirt System.Collections.Generic.IEnumerator`1<!0> System.Collections.Generic.IEnumerable`1<TheForestOfLove.Narrative.Dialogue>::GetEnumerator()
IL_0017: stloc.2
IL_0018: br.s IL_0033
IL_001a: ldloc.2
IL_001b: callvirt !0 System.Collections.Generic.IEnumerator`1<TheForestOfLove.Narrative.Dialogue>::get_Current()
IL_0020: stloc.3
IL_0021: ldloc.3
IL_0022: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0027: ldarg.1
IL_0028: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_002d: brfalse.s IL_0033
IL_002f: ldloc.3
IL_0030: stloc.0
IL_0031: leave.s IL_0047
IL_0033: ldloc.2
IL_0034: callvirt System.Boolean System.Collections.IEnumerator::MoveNext()
IL_0039: brtrue.s IL_001a
IL_003b: leave.s IL_0047
IL_003d: ldloc.2
IL_003e: brfalse.s IL_0046
IL_0040: ldloc.2
IL_0041: callvirt System.Void System.IDisposable::Dispose()
IL_0046: endfinally
IL_0047: ldloc.0
IL_0048: brtrue.s IL_005b
IL_004a: ldstr "trying to track a gossip that does not exist! "
IL_004f: ldarg.1
IL_0050: call System.String System.String::Concat(System.String,System.String)
IL_0055: newobj System.Void System.Exception::.ctor(System.String)
IL_005a: throw
IL_005b: ldarg.0
IL_005c: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.DialogueTrackingSchema> TheForestOfLove.Narrative.ActorDialogueOracle::actorPrimaryDialogueSchemas
IL_0061: ldloc.0
IL_0062: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0067: callvirt !1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.DialogueTrackingSchema>::get_Item(!0)
IL_006c: stloc.1
IL_006d: ldarg.0
IL_006e: ldloc.1
IL_006f: call System.Void TheForestOfLove.Narrative.ActorDialogueOracle::SetLatestSchema(TheForestOfLove.Narrative.DialogueTrackingSchema)
IL_0074: ldloc.1
IL_0075: ret
