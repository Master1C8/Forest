TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateActors(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::.ctor()
IL_0005: dup
IL_0006: ldarg.2
IL_0007: stfld PixelCrushers.DialogueSystem.DialogueDatabase TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::database
IL_000c: dup
IL_000d: ldarg.1
IL_000e: stfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_0013: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::<GenerateActors>b__0(TheForestOfLove.DB.Actor)
IL_0019: newobj System.Void System.Action`1<TheForestOfLove.DB.Actor>::.ctor(System.Object,System.IntPtr)
IL_001e: ldnull
IL_001f: ldnull
IL_0020: call System.Void TheForestOfLove.DB.Actor::ForEachEntity(System.Action`1<TheForestOfLove.DB.Actor>,System.Predicate`1<TheForestOfLove.DB.Actor>,System.Comparison`1<TheForestOfLove.DB.Actor>)
IL_0025: ret
