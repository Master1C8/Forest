TYPE TheForestOfLove.Narrative.ChapterRecord
METHOD System.Boolean TheForestOfLove.Narrative.ChapterRecord::get_IsUnlocked()
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.Narrative.ChapterRecord::<IsUnlocked>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.Narrative.ChapterRecord::Load(TheForestOfLove.Services.Persistence.SavegameChapterData)
IL_0000: ldarg.1
IL_0001: brtrue.s IL_0004
IL_0003: ret
IL_0004: ldarg.0
IL_0005: ldarg.1
IL_0006: ldfld System.Boolean TheForestOfLove.Services.Persistence.SavegameChapterData::isUnlocked
IL_000b: call System.Void TheForestOfLove.Narrative.ChapterRecord::set_IsUnlocked(System.Boolean)
IL_0010: ldarg.0
IL_0011: ldarg.1
IL_0012: ldfld System.Single TheForestOfLove.Services.Persistence.SavegameChapterData::timeUnlocked
IL_0017: stfld System.Single TheForestOfLove.Narrative.ChapterRecord::timeUnlocked
IL_001c: ret
METHOD System.Void TheForestOfLove.Narrative.ChapterRecord::Load(System.Boolean)
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void TheForestOfLove.Narrative.ChapterRecord::set_IsUnlocked(System.Boolean)
IL_0007: ret
