TYPE TheForestOfLove.SpawnManager
METHOD System.Void TheForestOfLove.SpawnManager::OnExitingDoorway(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0005: call TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordByUnitySceneName(System.String)
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: brfalse IL_00ff
IL_0011: ldarg.1
IL_0012: brtrue.s IL_002e
IL_0014: ldstr "respawned in area "
IL_0019: ldloc.0
IL_001a: ldfld System.String TheForestOfLove.Narrative.AreaRecord::dbName
IL_001f: call System.String System.String::Concat(System.String,System.String)
IL_0024: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_0029: br IL_00ff
IL_002e: ldarg.1
IL_002f: ldstr "fast_travel"
IL_0034: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0039: brfalse.s IL_005a
IL_003b: ldstr "respawned in area "
IL_0040: ldloc.0
IL_0041: ldfld System.String TheForestOfLove.Narrative.AreaRecord::dbName
IL_0046: ldstr " after penny fast travel"
IL_004b: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0050: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_0055: br IL_00ff
IL_005a: ldarg.1
IL_005b: ldstr "donkey_fast_travel_respawn"
IL_0060: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0065: brfalse.s IL_0083
IL_0067: ldstr "respawned in area "
IL_006c: ldloc.0
IL_006d: ldfld System.String TheForestOfLove.Narrative.AreaRecord::dbName
IL_0072: ldstr " after oliver fast travel"
IL_0077: call System.String System.String::Concat(System.String,System.String,System.String)
IL_007c: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_0081: br.s IL_00ff
IL_0083: ldarg.1
IL_0084: ldstr "plant_quest_minigame_respawn"
IL_0089: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_008e: brfalse.s IL_00ac
IL_0090: ldstr "respawned in area "
IL_0095: ldloc.0
IL_0096: ldfld System.String TheForestOfLove.Narrative.AreaRecord::dbName
IL_009b: ldstr " after plant quest minigame"
IL_00a0: call System.String System.String::Concat(System.String,System.String,System.String)
IL_00a5: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_00aa: br.s IL_00ff
IL_00ac: ldarg.1
IL_00ad: ldstr "dustin_minigame_spawn_point"
IL_00b2: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00b7: brfalse.s IL_00d5
IL_00b9: ldstr "respawned in area "
IL_00be: ldloc.0
IL_00bf: ldfld System.String TheForestOfLove.Narrative.AreaRecord::dbName
IL_00c4: ldstr " after dustin minigame"
IL_00c9: call System.String System.String::Concat(System.String,System.String,System.String)
IL_00ce: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_00d3: br.s IL_00ff
IL_00d5: ldarg.1
IL_00d6: call TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordByUnitySceneName(System.String)
IL_00db: stloc.1
IL_00dc: ldloc.1
IL_00dd: brfalse.s IL_00ff
IL_00df: ldstr "respawned in area "
IL_00e4: ldloc.0
IL_00e5: ldfld System.String TheForestOfLove.Narrative.AreaRecord::dbName
IL_00ea: ldstr " from "
IL_00ef: ldloc.1
IL_00f0: ldfld System.String TheForestOfLove.Narrative.AreaRecord::dbName
IL_00f5: call System.String System.String::Concat(System.String,System.String,System.String,System.String)
IL_00fa: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_00ff: ldsfld System.Action TheForestOfLove.SpawnManager/<>c::<>9__26_0
IL_0104: dup
IL_0105: brtrue.s IL_011e
IL_0107: pop
IL_0108: ldsfld TheForestOfLove.SpawnManager/<>c TheForestOfLove.SpawnManager/<>c::<>9
IL_010d: ldftn System.Void TheForestOfLove.SpawnManager/<>c::<OnExitingDoorway>b__26_0()
IL_0113: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0118: dup
IL_0119: stsfld System.Action TheForestOfLove.SpawnManager/<>c::<>9__26_0
IL_011e: call System.Void TheForestOfLove.Core.Timing.TimerHelper::NextUpdate(System.Action)
IL_0123: ret
