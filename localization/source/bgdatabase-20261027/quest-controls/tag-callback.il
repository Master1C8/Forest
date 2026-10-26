TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass8_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass8_0::<GenerateTags>b__0(TheForestOfLove.DB.Tag) | attributes=Assembly, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.Tag::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: callvirt System.String TheForestOfLove.DB.Tag::get_name()
IL_000d: stfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_0012: ldloc.0
IL_0013: ldarg.1
IL_0014: stfld TheForestOfLove.DB.Tag TheForestOfLove.Narrative.Tag::dbTag
IL_0019: ldloc.0
IL_001a: ldarg.1
IL_001b: callvirt System.String TheForestOfLove.DB.Tag::get_savekey()
IL_0020: stfld System.String TheForestOfLove.Narrative.Tag::savekey
IL_0025: ldarg.0
IL_0026: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass8_0::manifest
IL_002b: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tags
IL_0030: ldloc.0
IL_0031: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Tag>::Add(!0)
IL_0036: ldarg.0
IL_0037: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass8_0::manifest
IL_003c: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbName
IL_0041: ldloc.0
IL_0042: ldfld System.String TheForestOfLove.Narrative.Tag::dbName
IL_0047: ldloc.0
IL_0048: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Tag>::Add(!0,!1)
IL_004d: ldarg.0
IL_004e: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass8_0::manifest
IL_0053: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag> TheForestOfLove.Narrative.DataManifest::tagsByDbTag
IL_0058: ldloc.0
IL_0059: ldfld TheForestOfLove.DB.Tag TheForestOfLove.Narrative.Tag::dbTag
IL_005e: ldloc.0
IL_005f: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Tag,TheForestOfLove.Narrative.Tag>::Add(!0,!1)
IL_0064: ret
