TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass11_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass11_0::<GenerateTriggers>b__0(TheForestOfLove.DB.Trigger) | attributes=Assembly, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Narrative.Trigger::.ctor()
IL_0005: stloc.0
IL_0006: ldarg.1
IL_0007: callvirt System.String TheForestOfLove.DB.Trigger::get_plugin_db_named_trigger()
IL_000c: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0011: brfalse.s IL_0029
IL_0013: ldstr "trigger plugin db name must be provided "
IL_0018: ldarg.1
IL_0019: callvirt System.String TheForestOfLove.DB.Trigger::get_name()
IL_001e: call System.String System.String::Concat(System.String,System.String)
IL_0023: newobj System.Void System.Exception::.ctor(System.String)
IL_0028: throw
IL_0029: ldloc.0
IL_002a: ldarg.1
IL_002b: stfld TheForestOfLove.DB.Trigger TheForestOfLove.Narrative.Trigger::dbTrigger
IL_0030: ldloc.0
IL_0031: ldarg.1
IL_0032: callvirt System.String TheForestOfLove.DB.Trigger::get_savekey()
IL_0037: stfld System.String TheForestOfLove.Narrative.Trigger::savekey
IL_003c: ldloc.0
IL_003d: ldarg.1
IL_003e: callvirt System.String TheForestOfLove.DB.Trigger::get_plugin_db_named_trigger()
IL_0043: stfld System.String TheForestOfLove.Narrative.Trigger::name
IL_0048: ldarg.0
IL_0049: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass11_0::manifest
IL_004e: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggers
IL_0053: ldloc.0
IL_0054: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Trigger>::Add(!0)
IL_0059: ldarg.0
IL_005a: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass11_0::manifest
IL_005f: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByTriggerName
IL_0064: ldloc.0
IL_0065: ldfld System.String TheForestOfLove.Narrative.Trigger::name
IL_006a: ldloc.0
IL_006b: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::Add(!0,!1)
IL_0070: ldarg.0
IL_0071: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass11_0::manifest
IL_0076: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersBySavekey
IL_007b: ldloc.0
IL_007c: ldfld System.String TheForestOfLove.Narrative.Trigger::savekey
IL_0081: ldloc.0
IL_0082: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Trigger>::Add(!0,!1)
IL_0087: ldarg.0
IL_0088: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass11_0::manifest
IL_008d: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger> TheForestOfLove.Narrative.DataManifest::triggersByDbTrigger
IL_0092: ldloc.0
IL_0093: ldfld TheForestOfLove.DB.Trigger TheForestOfLove.Narrative.Trigger::dbTrigger
IL_0098: ldloc.0
IL_0099: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Trigger,TheForestOfLove.Narrative.Trigger>::Add(!0,!1)
IL_009e: ret
