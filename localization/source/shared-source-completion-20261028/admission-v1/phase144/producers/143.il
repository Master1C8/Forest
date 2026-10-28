TYPE TheForestOfLove.Services.Persistence.SaveManager
METHOD System.Void TheForestOfLove.Services.Persistence.SaveManager::SetupDefaultTags() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SaveManager::get_Savestate()
IL_0005: callvirt System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Services.Persistence.Savestate::LoadTags()
IL_000a: callvirt System.Int32 System.Collections.Generic.HashSet`1<System.String>::get_Count()
IL_000f: brtrue.s IL_002f
IL_0011: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SaveManager::get_Savestate()
IL_0016: ldstr "main"
IL_001b: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveAddTag(System.String)
IL_0020: call TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SaveManager::get_Savestate()
IL_0025: ldstr "main_act_1"
IL_002a: callvirt System.Void TheForestOfLove.Services.Persistence.Savestate::SaveAddTag(System.String)
IL_002f: ret
