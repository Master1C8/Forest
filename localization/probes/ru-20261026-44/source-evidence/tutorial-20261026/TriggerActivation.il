TYPE TheForestOfLove.Narrative.NarrativeActions
METHOD System.Void TheForestOfLove.Narrative.NarrativeActions::ActivateTrigger(System.String)
IL_0000: ldarg.0
IL_0001: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brtrue.s IL_0011
IL_000a: ldarg.0
IL_000b: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::CreateTriggerOnTheFly(System.String)
IL_0010: stloc.0
IL_0011: ldloc.0
IL_0012: callvirt System.Void TheForestOfLove.Narrative.Trigger::ActivateTrigger()
IL_0017: ret
