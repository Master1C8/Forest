TYPE TheForestOfLove.Interaction.InteractionTrigger
METHOD System.Boolean TheForestOfLove.Interaction.InteractionTrigger::get_interactionBlocked() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Interaction.InteractionTrigger::<interactionBlocked>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.Interaction.InteractionTrigger::Fire() | attributes=Public, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call System.String TheForestOfLove.Interaction.InteractionTrigger::get_TriggerDbName()
IL_0006: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_000b: brtrue.s IL_001d
IL_000d: ldarg.0
IL_000e: call System.String TheForestOfLove.Interaction.InteractionTrigger::get_TriggerDbName()
IL_0013: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0018: callvirt System.Void TheForestOfLove.Narrative.Trigger::ActivateTrigger()
IL_001d: ret
METHOD System.Boolean TheForestOfLove.Interaction.InteractionTrigger::CanTrigger() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: call System.String TheForestOfLove.Interaction.InteractionTrigger::get_TriggerDbName()
IL_0006: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_000b: brtrue.s IL_0026
IL_000d: ldarg.0
IL_000e: call System.String TheForestOfLove.Interaction.InteractionTrigger::get_TriggerDbName()
IL_0013: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_0018: callvirt System.Int32 TheForestOfLove.Narrative.Trigger::get_CountActivated()
IL_001d: ldarg.0
IL_001e: ldfld System.Int32 TheForestOfLove.Interaction.InteractionTrigger::maxTimesTriggerable
IL_0023: clt
IL_0025: ret
IL_0026: ldc.i4.1
IL_0027: ret
