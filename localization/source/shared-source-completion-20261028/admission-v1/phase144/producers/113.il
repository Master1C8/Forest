TYPE TheForestOfLove.Narrative.Adventure
METHOD System.Void TheForestOfLove.Narrative.Adventure::.cctor() | attributes=Private, Static, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldstr "CentralForest"
IL_0005: stsfld System.String TheForestOfLove.Narrative.Adventure::PlayerSpawnAreaDbNameForReplaysAfterCompletedOnce
IL_000a: ldc.r4 5.44
IL_000f: ldc.r4 9.97
IL_0014: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_0019: stsfld UnityEngine.Vector2 TheForestOfLove.Narrative.Adventure::PlayerSpawnLocationForReplaysAfterCompletedOnce
IL_001e: call System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::RegenerateAdventuresPleaseMoveThisDataToDbSoItsNotStaticBruh()
IL_0023: stsfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::adventuresByStoryType
IL_0028: ret
