TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass9_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass9_0::<GenerateBioKeywords>b__0(TheForestOfLove.DB.BioKeyword) | attributes=Assembly, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.BioKeyword::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld TheForestOfLove.DB.BioKeyword TheForestOfLove.Narrative.BioKeyword::dbBioKeyword
IL_000d: ldloc.0
IL_000e: ldarg.1
IL_000f: callvirt System.String TheForestOfLove.DB.BioKeyword::get_name()
IL_0014: stfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_0019: ldloc.0
IL_001a: ldarg.1
IL_001b: callvirt System.String TheForestOfLove.DB.BioKeyword::get_savekey()
IL_0020: stfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_0025: ldloc.0
IL_0026: ldarg.1
IL_0027: callvirt System.String TheForestOfLove.DB.BioKeyword::get_plugin_db_trigger_name()
IL_002c: stfld System.String TheForestOfLove.Narrative.BioKeyword::pluginDbTriggerName
IL_0031: ldloc.0
IL_0032: ldarg.1
IL_0033: callvirt System.String TheForestOfLove.DB.BioKeyword::get_bio_text()
IL_0038: stfld System.String TheForestOfLove.Narrative.BioKeyword::text
IL_003d: ldarg.0
IL_003e: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass9_0::manifest
IL_0043: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywords
IL_0048: ldloc.0
IL_0049: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>::Add(!0)
IL_004e: ldarg.0
IL_004f: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass9_0::manifest
IL_0054: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbName
IL_0059: ldloc.0
IL_005a: ldfld System.String TheForestOfLove.Narrative.BioKeyword::dbName
IL_005f: ldloc.0
IL_0060: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::Add(!0,!1)
IL_0065: ldarg.0
IL_0066: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass9_0::manifest
IL_006b: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByPluginDbTriggerName
IL_0070: ldloc.0
IL_0071: ldfld System.String TheForestOfLove.Narrative.BioKeyword::pluginDbTriggerName
IL_0076: ldloc.0
IL_0077: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::Add(!0,!1)
IL_007c: ldarg.0
IL_007d: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass9_0::manifest
IL_0082: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsBySavekey
IL_0087: ldloc.0
IL_0088: ldfld System.String TheForestOfLove.Narrative.BioKeyword::savekey
IL_008d: ldloc.0
IL_008e: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.BioKeyword>::Add(!0,!1)
IL_0093: ldarg.0
IL_0094: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass9_0::manifest
IL_0099: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword> TheForestOfLove.Narrative.DataManifest::bioKeywordsByDbKeyword
IL_009e: ldloc.0
IL_009f: ldfld TheForestOfLove.DB.BioKeyword TheForestOfLove.Narrative.BioKeyword::dbBioKeyword
IL_00a4: ldloc.0
IL_00a5: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.BioKeyword,TheForestOfLove.Narrative.BioKeyword>::Add(!0,!1)
IL_00aa: ret
