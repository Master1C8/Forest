TYPE TheForestOfLove.Narrative.DialogueSystemLoader
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader::GenerateBioKeywords(TheForestOfLove.Narrative.DataManifest) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass9_0::.ctor()
IL_0005: dup
IL_0006: ldarg.1
IL_0007: stfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass9_0::manifest
IL_000c: ldftn System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass9_0::<GenerateBioKeywords>b__0(TheForestOfLove.DB.BioKeyword)
IL_0012: newobj System.Void System.Action`1<TheForestOfLove.DB.BioKeyword>::.ctor(System.Object,System.IntPtr)
IL_0017: ldnull
IL_0018: ldnull
IL_0019: call System.Void TheForestOfLove.DB.BioKeyword::ForEachEntity(System.Action`1<TheForestOfLove.DB.BioKeyword>,System.Predicate`1<TheForestOfLove.DB.BioKeyword>,System.Comparison`1<TheForestOfLove.DB.BioKeyword>)
IL_001e: ret
