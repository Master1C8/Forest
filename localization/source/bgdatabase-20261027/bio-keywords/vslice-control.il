TYPE TheForestOfLove.QuestTriggerHelper
METHOD System.Boolean TheForestOfLove.QuestTriggerHelper::InVsliceStoryInstance() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "Instanced Event Vslice"
IL_0005: call System.Boolean TheForestOfLove.Services.Persistence.DataService::IsTagActive(System.String)
IL_000a: ret
