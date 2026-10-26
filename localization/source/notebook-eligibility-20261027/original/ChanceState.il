TYPE TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance
METHOD System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::IsConditionSatisfied() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldsfld System.Boolean Globals::Debug_DisableDialoguePrecondition_PercentChance
IL_0005: brfalse.s IL_0009
IL_0007: ldc.i4.1
IL_0008: ret
IL_0009: ldarg.0
IL_000a: ldfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::percentChance
IL_000f: ldc.r4 0
IL_0014: bne.un.s IL_0018
IL_0016: ldc.i4.1
IL_0017: ret
IL_0018: ldarg.0
IL_0019: call System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::CheckCondition()
IL_001e: stloc.0
IL_001f: call System.Int32 TheForestOfLove.Services.SceneManagement.SceneHelper::get_totalSceneLoads()
IL_0024: ldarg.0
IL_0025: ldfld System.Int32 TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::lastTotalSceneLoads
IL_002a: beq.s IL_009b
IL_002c: ldarg.0
IL_002d: call System.Int32 TheForestOfLove.Services.SceneManagement.SceneHelper::get_totalSceneLoads()
IL_0032: stfld System.Int32 TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::lastTotalSceneLoads
IL_0037: ldarg.0
IL_0038: ldc.r4 0
IL_003d: ldc.r4 1
IL_0042: call System.Single UnityEngine.Random::Range(System.Single,System.Single)
IL_0047: stfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::lastRandomValue
IL_004c: ldarg.0
IL_004d: call System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::CheckCondition()
IL_0052: stloc.0
IL_0053: ldloc.0
IL_0054: brtrue.s IL_009b
IL_0056: ldarg.0
IL_0057: ldarg.0
IL_0058: ldfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::currentUnluckyRolls
IL_005d: ldc.r4 1
IL_0062: add
IL_0063: stfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::currentUnluckyRolls
IL_0068: ldarg.0
IL_0069: ldfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::maxUnluckyRolls
IL_006e: ldc.r4 0
IL_0073: ble.un.s IL_009b
IL_0075: ldarg.0
IL_0076: ldfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::currentUnluckyRolls
IL_007b: ldarg.0
IL_007c: ldfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::maxUnluckyRolls
IL_0081: ble.un.s IL_009b
IL_0083: ldarg.0
IL_0084: ldc.r4 0
IL_0089: stfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::currentUnluckyRolls
IL_008e: ldarg.0
IL_008f: ldc.r4 1
IL_0094: stfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::lastRandomValue
IL_0099: ldc.i4.1
IL_009a: stloc.0
IL_009b: ldloc.0
IL_009c: ret
METHOD System.Boolean TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::CheckCondition() | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.r4 1
IL_0005: ldarg.0
IL_0006: ldfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::lastRandomValue
IL_000b: sub
IL_000c: ldarg.0
IL_000d: ldfld System.Single TheForestOfLove.Narrative.DialoguePreconditions.DialoguePreconditionPercentChance::percentChance
IL_0012: clt
IL_0014: ret
