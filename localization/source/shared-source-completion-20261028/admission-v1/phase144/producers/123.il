TYPE TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer
METHOD System.Void TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::RandomlyBlink() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::buckyCooldownLoopsRemaining
IL_0006: ldc.i4.0
IL_0007: bgt.s IL_006c
IL_0009: ldarg.0
IL_000a: ldfld System.Int32 TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::oliverCooldownLoopsRemaining
IL_000f: ldc.i4.0
IL_0010: bgt.s IL_006c
IL_0012: ldc.r4 0
IL_0017: ldc.r4 1
IL_001c: call System.Single UnityEngine.Random::Range(System.Single,System.Single)
IL_0021: ldarg.0
IL_0022: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_0027: ldfld System.Single TheForestOfLove.OliverBuckyOralMovie::buckyBlinkChance
IL_002c: ldarg.0
IL_002d: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_0032: ldfld System.Single TheForestOfLove.OliverBuckyOralMovie::oliverBlinkChance
IL_0037: call System.Single UnityEngine.Mathf::Max(System.Single,System.Single)
IL_003c: bgt.un.s IL_006c
IL_003e: ldarg.0
IL_003f: ldstr "blink_both"
IL_0044: call System.Void TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::SetAnimatorTriggers(System.String)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_0050: ldfld System.Int32 TheForestOfLove.OliverBuckyOralMovie::buckyBlinkCooldowns
IL_0055: stfld System.Int32 TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::buckyCooldownLoopsRemaining
IL_005a: ldarg.0
IL_005b: ldarg.0
IL_005c: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_0061: ldfld System.Int32 TheForestOfLove.OliverBuckyOralMovie::oliverBlinkCooldowns
IL_0066: stfld System.Int32 TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::oliverCooldownLoopsRemaining
IL_006b: ret
IL_006c: ldarg.0
IL_006d: ldfld System.Int32 TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::buckyCooldownLoopsRemaining
IL_0072: ldc.i4.0
IL_0073: bgt.s IL_00ae
IL_0075: ldc.r4 0
IL_007a: ldc.r4 1
IL_007f: call System.Single UnityEngine.Random::Range(System.Single,System.Single)
IL_0084: ldarg.0
IL_0085: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_008a: ldfld System.Single TheForestOfLove.OliverBuckyOralMovie::buckyBlinkChance
IL_008f: bgt.un.s IL_00ae
IL_0091: ldarg.0
IL_0092: ldstr "blink_bucky"
IL_0097: call System.Void TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::SetAnimatorTriggers(System.String)
IL_009c: ldarg.0
IL_009d: ldarg.0
IL_009e: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_00a3: ldfld System.Int32 TheForestOfLove.OliverBuckyOralMovie::buckyBlinkCooldowns
IL_00a8: stfld System.Int32 TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::buckyCooldownLoopsRemaining
IL_00ad: ret
IL_00ae: ldarg.0
IL_00af: ldfld System.Int32 TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::oliverCooldownLoopsRemaining
IL_00b4: ldc.i4.0
IL_00b5: bgt.s IL_00ef
IL_00b7: ldc.r4 0
IL_00bc: ldc.r4 1
IL_00c1: call System.Single UnityEngine.Random::Range(System.Single,System.Single)
IL_00c6: ldarg.0
IL_00c7: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_00cc: ldfld System.Single TheForestOfLove.OliverBuckyOralMovie::oliverBlinkChance
IL_00d1: bgt.un.s IL_00ef
IL_00d3: ldarg.0
IL_00d4: ldstr "blink_oliver"
IL_00d9: call System.Void TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::SetAnimatorTriggers(System.String)
IL_00de: ldarg.0
IL_00df: ldarg.0
IL_00e0: ldfld TheForestOfLove.OliverBuckyOralMovie TheForestOfLove.OliverBuckyOralMovie/Internal_AnimationWorker::movie
IL_00e5: ldfld System.Int32 TheForestOfLove.OliverBuckyOralMovie::oliverBlinkCooldowns
IL_00ea: stfld System.Int32 TheForestOfLove.OliverBuckyOralMovie/Internal_BlinkRandomizer::oliverCooldownLoopsRemaining
IL_00ef: ret
