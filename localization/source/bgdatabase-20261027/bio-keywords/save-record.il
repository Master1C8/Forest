TYPE TheForestOfLove.Services.Persistence.SavegameBioKeywordData
METHOD TheForestOfLove.Services.Persistence.SavegameBioKeywordData TheForestOfLove.Services.Persistence.SavegameBioKeywordData::DeepCopy() | attributes=Public, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Services.Persistence.SavegameBioKeywordData::.ctor()
IL_0005: dup
IL_0006: ldarg.0
IL_0007: ldfld System.String TheForestOfLove.Services.Persistence.SavegameBioKeywordData::keywordSavekey
IL_000c: stfld System.String TheForestOfLove.Services.Persistence.SavegameBioKeywordData::keywordSavekey
IL_0011: dup
IL_0012: ldarg.0
IL_0013: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameBioKeywordData::timeUnlocked
IL_0018: stfld System.Single TheForestOfLove.Services.Persistence.SavegameBioKeywordData::timeUnlocked
IL_001d: ret
METHOD System.Void TheForestOfLove.Services.Persistence.SavegameBioKeywordData::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: ret
