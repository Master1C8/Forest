TYPE TheForestOfLove.IntroBunnyHouseCutscene
METHOD System.Void TheForestOfLove.IntroBunnyHouseCutscene::EndCutsceneStage()
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: switch IL_002b,IL_0034,IL_003d,IL_0046,IL_004f,IL_0058,IL_005f
IL_0029: br.s IL_005f
IL_002b: ldarg.0
IL_002c: ldc.i4.1
IL_002d: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_0032: br.s IL_005f
IL_0034: ldarg.0
IL_0035: ldc.i4.2
IL_0036: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_003b: br.s IL_005f
IL_003d: ldarg.0
IL_003e: ldc.i4.3
IL_003f: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_0044: br.s IL_005f
IL_0046: ldarg.0
IL_0047: ldc.i4.4
IL_0048: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_004d: br.s IL_005f
IL_004f: ldarg.0
IL_0050: ldc.i4.5
IL_0051: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_0056: br.s IL_005f
IL_0058: ldarg.0
IL_0059: ldc.i4.6
IL_005a: stfld TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage TheForestOfLove.IntroBunnyHouseCutscene::currentStage
IL_005f: ldarg.0
IL_0060: call System.Void TheForestOfLove.IntroBunnyHouseCutscene::ConfigureCutsceneStage()
IL_0065: ret
