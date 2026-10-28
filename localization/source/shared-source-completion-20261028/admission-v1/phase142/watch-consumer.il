TYPE TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen
METHOD System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::IsConditionSatisfied() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Globals::Debug_DisableDialoguePrecondition_ActorOnscreenOffscreen
IL_0005: brfalse.s IL_0009
IL_0007: ldc.i4.1
IL_0008: ret
IL_0009: ldarg.0
IL_000a: call System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::CheckOffscreenTrigger()
IL_000f: brfalse.s IL_0018
IL_0011: ldarg.0
IL_0012: call System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::CheckOnscreenTrigger()
IL_0017: ret
IL_0018: ldc.i4.0
IL_0019: ret
METHOD System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::CheckOffscreenTrigger() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::offscreenTriggerName
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.1
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::offscreenTriggerName
IL_0010: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0015: stloc.0
IL_0016: ldloc.0
IL_0017: brfalse.s IL_0021
IL_0019: ldloc.0
IL_001a: callvirt System.Boolean TheForestOfLove.Narrative.Trigger::get_IsActivated()
IL_001f: brtrue.s IL_0023
IL_0021: ldc.i4.0
IL_0022: ret
IL_0023: ldarg.0
IL_0024: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOffscreenAll
IL_0029: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_002e: stloc.2
IL_002f: br.s IL_004e
IL_0031: ldloca.s V_2
IL_0033: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_0038: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_003d: ldfld System.Single TheForestOfLove.Narrative.Actor::timePlayerWentOffscreen
IL_0042: ldloc.0
IL_0043: ldfld System.Single TheForestOfLove.Narrative.Trigger::gameplayTimeFirstActivated
IL_0048: bgt.un.s IL_004e
IL_004a: ldc.i4.0
IL_004b: stloc.3
IL_004c: leave.s IL_00be
IL_004e: ldloca.s V_2
IL_0050: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_0055: brtrue.s IL_0031
IL_0057: leave.s IL_0067
IL_0059: ldloca.s V_2
IL_005b: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_0061: callvirt System.Void System.IDisposable::Dispose()
IL_0066: endfinally
IL_0067: ldc.i4.0
IL_0068: stloc.1
IL_0069: ldarg.0
IL_006a: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOffscreenAny
IL_006f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_0074: stloc.2
IL_0075: br.s IL_0094
IL_0077: ldloca.s V_2
IL_0079: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_007e: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0083: ldfld System.Single TheForestOfLove.Narrative.Actor::timePlayerWentOffscreen
IL_0088: ldloc.0
IL_0089: ldfld System.Single TheForestOfLove.Narrative.Trigger::gameplayTimeFirstActivated
IL_008e: ble.un.s IL_0094
IL_0090: ldc.i4.1
IL_0091: stloc.1
IL_0092: leave.s IL_00ad
IL_0094: ldloca.s V_2
IL_0096: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_009b: brtrue.s IL_0077
IL_009d: leave.s IL_00ad
IL_009f: ldloca.s V_2
IL_00a1: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_00a7: callvirt System.Void System.IDisposable::Dispose()
IL_00ac: endfinally
IL_00ad: ldarg.0
IL_00ae: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOffscreenAny
IL_00b3: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_00b8: ldc.i4.0
IL_00b9: ceq
IL_00bb: ldloc.1
IL_00bc: or
IL_00bd: ret
IL_00be: ldloc.3
IL_00bf: ret
METHOD System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::CheckOnscreenTrigger() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::onscreenTriggerName
IL_0006: brtrue.s IL_000a
IL_0008: ldc.i4.1
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldfld System.String TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::onscreenTriggerName
IL_0010: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0015: stloc.0
IL_0016: ldloc.0
IL_0017: brfalse.s IL_0021
IL_0019: ldloc.0
IL_001a: callvirt System.Boolean TheForestOfLove.Narrative.Trigger::get_IsActivated()
IL_001f: brtrue.s IL_0023
IL_0021: ldc.i4.0
IL_0022: ret
IL_0023: ldarg.0
IL_0024: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOnscreenAll
IL_0029: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_002e: stloc.2
IL_002f: br.s IL_004e
IL_0031: ldloca.s V_2
IL_0033: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_0038: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_003d: ldfld System.Single TheForestOfLove.Narrative.Actor::timePlayerCameOnscreen
IL_0042: ldloc.0
IL_0043: ldfld System.Single TheForestOfLove.Narrative.Trigger::gameplayTimeFirstActivated
IL_0048: bgt.un.s IL_004e
IL_004a: ldc.i4.0
IL_004b: stloc.3
IL_004c: leave.s IL_00be
IL_004e: ldloca.s V_2
IL_0050: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_0055: brtrue.s IL_0031
IL_0057: leave.s IL_0067
IL_0059: ldloca.s V_2
IL_005b: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_0061: callvirt System.Void System.IDisposable::Dispose()
IL_0066: endfinally
IL_0067: ldc.i4.0
IL_0068: stloc.1
IL_0069: ldarg.0
IL_006a: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOnscreenAny
IL_006f: callvirt System.Collections.Generic.List`1/Enumerator<!0> System.Collections.Generic.List`1<System.String>::GetEnumerator()
IL_0074: stloc.2
IL_0075: br.s IL_0094
IL_0077: ldloca.s V_2
IL_0079: call !0 System.Collections.Generic.List`1/Enumerator<System.String>::get_Current()
IL_007e: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_0083: ldfld System.Single TheForestOfLove.Narrative.Actor::timePlayerCameOnscreen
IL_0088: ldloc.0
IL_0089: ldfld System.Single TheForestOfLove.Narrative.Trigger::gameplayTimeFirstActivated
IL_008e: ble.un.s IL_0094
IL_0090: ldc.i4.1
IL_0091: stloc.1
IL_0092: leave.s IL_00ad
IL_0094: ldloca.s V_2
IL_0096: call System.Boolean System.Collections.Generic.List`1/Enumerator<System.String>::MoveNext()
IL_009b: brtrue.s IL_0077
IL_009d: leave.s IL_00ad
IL_009f: ldloca.s V_2
IL_00a1: constrained. System.Collections.Generic.List`1/Enumerator<System.String>
IL_00a7: callvirt System.Void System.IDisposable::Dispose()
IL_00ac: endfinally
IL_00ad: ldarg.0
IL_00ae: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionActorOnscreenOffscreen::requireActorsOnscreenAny
IL_00b3: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_00b8: ldc.i4.0
IL_00b9: ceq
IL_00bb: ldloc.1
IL_00bc: or
IL_00bd: ret
IL_00be: ldloc.3
IL_00bf: ret
