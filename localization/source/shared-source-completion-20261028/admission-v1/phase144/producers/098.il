TYPE TheForestOfLove.Interaction.InteractionTrigger
METHOD System.Void TheForestOfLove.Interaction.InteractionTrigger::Start() | attributes=Family, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Core.BaseBehavior::Start()
IL_0006: ldarg.0
IL_0007: call System.String TheForestOfLove.Interaction.InteractionTrigger::get_TriggerDbName()
IL_000c: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0011: brtrue.s IL_003a
IL_0013: ldarg.0
IL_0014: call System.String TheForestOfLove.Interaction.InteractionTrigger::get_TriggerDbName()
IL_0019: call TheForestOfLove.Narrative.Trigger TheForestOfLove.Services.Persistence.DataService::GetTriggerByName(System.String)
IL_001e: brtrue.s IL_003a
IL_0020: ldstr "trigger "
IL_0025: ldarg.0
IL_0026: call System.String TheForestOfLove.Interaction.InteractionTrigger::get_TriggerDbName()
IL_002b: ldstr " is used by an InteractionTrigger, but missing in the data service. it will never fire"
IL_0030: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0035: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_003a: ret
