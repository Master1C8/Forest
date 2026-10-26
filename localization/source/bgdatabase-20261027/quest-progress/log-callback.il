TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::<GenerateQuestProgressLogText>b__0(TheForestOfLove.DB.QuestProgressLogText) | attributes=Assembly, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.QuestProgressLogEntry::.ctor()
IL_0005: stloc.0
IL_0006: ldarg.0
IL_0007: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::manifest
IL_000c: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest> TheForestOfLove.Narrative.DataManifest::questsByDbQuest
IL_0011: ldarg.1
IL_0012: callvirt TheForestOfLove.DB.Quest TheForestOfLove.DB.QuestProgressLogText::get_quest()
IL_0017: callvirt !1 System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Quest,TheForestOfLove.Narrative.Quest>::get_Item(!0)
IL_001c: stloc.1
IL_001d: ldloc.0
IL_001e: ldarg.1
IL_001f: callvirt System.String TheForestOfLove.DB.QuestProgressLogText::get_name()
IL_0024: stfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::dbName
IL_0029: ldloc.0
IL_002a: ldarg.1
IL_002b: stfld TheForestOfLove.DB.QuestProgressLogText TheForestOfLove.Narrative.QuestProgressLogEntry::dbLog
IL_0030: ldloc.0
IL_0031: ldarg.1
IL_0032: callvirt System.String TheForestOfLove.DB.QuestProgressLogText::get_savekey()
IL_0037: stfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::savekey
IL_003c: ldloc.0
IL_003d: ldloc.1
IL_003e: stfld TheForestOfLove.Narrative.Quest TheForestOfLove.Narrative.QuestProgressLogEntry::quest
IL_0043: ldloc.0
IL_0044: ldarg.1
IL_0045: callvirt System.String TheForestOfLove.DB.QuestProgressLogText::get_log_text()
IL_004a: stfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::text
IL_004f: ldloc.0
IL_0050: ldarg.1
IL_0051: callvirt System.Int32 TheForestOfLove.DB.QuestProgressLogText::get_priority()
IL_0056: stfld System.Int32 TheForestOfLove.Narrative.QuestProgressLogEntry::priority
IL_005b: ldloc.1
IL_005c: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.Quest::progressLogEntries
IL_0061: ldloc.0
IL_0062: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::Add(!0)
IL_0067: ldarg.0
IL_0068: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::manifest
IL_006d: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntries
IL_0072: ldloc.0
IL_0073: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.QuestProgressLogEntry>::Add(!0)
IL_0078: ldarg.0
IL_0079: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::manifest
IL_007e: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntriesByDbName
IL_0083: ldloc.0
IL_0084: ldfld System.String TheForestOfLove.Narrative.QuestProgressLogEntry::dbName
IL_0089: ldloc.0
IL_008a: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.QuestProgressLogEntry>::Add(!0,!1)
IL_008f: ldarg.0
IL_0090: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass21_0::manifest
IL_0095: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.QuestProgressLogText,TheForestOfLove.Narrative.QuestProgressLogEntry> TheForestOfLove.Narrative.DataManifest::questProgressLogEntriesByDbLog
IL_009a: ldloc.0
IL_009b: ldfld TheForestOfLove.DB.QuestProgressLogText TheForestOfLove.Narrative.QuestProgressLogEntry::dbLog
IL_00a0: ldloc.0
IL_00a1: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.QuestProgressLogText,TheForestOfLove.Narrative.QuestProgressLogEntry>::Add(!0,!1)
IL_00a6: ret
