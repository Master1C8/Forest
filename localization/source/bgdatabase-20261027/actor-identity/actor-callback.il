TYPE TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0
METHOD System.Void TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::<GenerateActors>b__0(TheForestOfLove.DB.Actor) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld PixelCrushers.DialogueSystem.DialogueDatabase TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::database
IL_0006: ldarg.1
IL_0007: callvirt System.String TheForestOfLove.DB.Actor::get_plugin_db_name()
IL_000c: callvirt PixelCrushers.DialogueSystem.Actor PixelCrushers.DialogueSystem.DialogueDatabase::GetActor(System.String)
IL_0011: stloc.0
IL_0012: newobj System.Void TheForestOfLove.Narrative.Actor::.ctor()
IL_0017: stloc.1
IL_0018: ldloc.1
IL_0019: ldarg.1
IL_001a: callvirt System.String BansheeGz.BGDatabase.BGEntity::get_Name()
IL_001f: stfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0024: ldloc.1
IL_0025: ldarg.1
IL_0026: stfld TheForestOfLove.DB.Actor TheForestOfLove.Narrative.Actor::dbActor
IL_002b: ldloc.1
IL_002c: ldarg.1
IL_002d: callvirt System.String TheForestOfLove.DB.Actor::get_savekey()
IL_0032: stfld System.String TheForestOfLove.Narrative.Actor::savekey
IL_0037: ldloc.1
IL_0038: ldarg.1
IL_0039: callvirt System.String TheForestOfLove.DB.Actor::get_plugin_db_name()
IL_003e: stfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_0043: ldloc.1
IL_0044: ldloc.0
IL_0045: stfld PixelCrushers.DialogueSystem.Actor TheForestOfLove.Narrative.Actor::pluginDbActor
IL_004a: ldloc.1
IL_004b: ldloc.1
IL_004c: ldfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_0051: ldstr "player"
IL_0056: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_005b: stfld System.Boolean TheForestOfLove.Narrative.Actor::isPlayer
IL_0060: ldloc.1
IL_0061: ldloc.1
IL_0062: ldfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_0067: ldstr "narrator"
IL_006c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0071: stfld System.Boolean TheForestOfLove.Narrative.Actor::isNarrator
IL_0076: ldloc.1
IL_0077: ldarg.1
IL_0078: callvirt System.String TheForestOfLove.DB.Actor::get_nameplate_name()
IL_007d: stfld System.String TheForestOfLove.Narrative.Actor::nameplateNameDbDefault
IL_0082: ldloc.1
IL_0083: ldarg.1
IL_0084: callvirt System.String TheForestOfLove.DB.Actor::get_full_name()
IL_0089: stfld System.String TheForestOfLove.Narrative.Actor::fullNameDbDefault
IL_008e: ldloc.1
IL_008f: ldarg.1
IL_0090: callvirt System.Boolean TheForestOfLove.DB.Actor::get_exclude_from_save()
IL_0095: stfld System.Boolean TheForestOfLove.Narrative.Actor::isExcludedFromSavestate
IL_009a: ldloc.1
IL_009b: ldarg.1
IL_009c: callvirt System.Boolean TheForestOfLove.DB.Actor::get_exclude_from_critter_log()
IL_00a1: stfld System.Boolean TheForestOfLove.Narrative.Actor::isExcludedFromCritterLog
IL_00a6: ldloc.1
IL_00a7: newobj System.Void TheForestOfLove.Narrative.ActorDialogueOracle::.ctor(TheForestOfLove.Narrative.Actor)
IL_00ac: stloc.2
IL_00ad: ldarg.0
IL_00ae: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_00b3: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.ActorDialogueOracle> TheForestOfLove.Narrative.DataManifest::actorDialogueOracles
IL_00b8: ldloc.2
IL_00b9: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.ActorDialogueOracle>::Add(!0)
IL_00be: ldarg.0
IL_00bf: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_00c4: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ActorDialogueOracle> TheForestOfLove.Narrative.DataManifest::actorDialogueOraclesByActorDbName
IL_00c9: ldloc.1
IL_00ca: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00cf: ldloc.2
IL_00d0: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.ActorDialogueOracle>::Add(!0,!1)
IL_00d5: ldarg.0
IL_00d6: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_00db: ldfld System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actors
IL_00e0: ldloc.1
IL_00e1: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Actor>::Add(!0)
IL_00e6: ldarg.0
IL_00e7: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_00ec: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByDbName
IL_00f1: ldloc.1
IL_00f2: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_00f7: ldloc.1
IL_00f8: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::Add(!0,!1)
IL_00fd: ldarg.0
IL_00fe: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_0103: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByDbActor
IL_0108: ldloc.1
IL_0109: ldfld TheForestOfLove.DB.Actor TheForestOfLove.Narrative.Actor::dbActor
IL_010e: ldloc.1
IL_010f: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.DB.Actor,TheForestOfLove.Narrative.Actor>::Add(!0,!1)
IL_0114: ldloc.1
IL_0115: ldfld PixelCrushers.DialogueSystem.Actor TheForestOfLove.Narrative.Actor::pluginDbActor
IL_011a: brfalse.s IL_0138
IL_011c: ldarg.0
IL_011d: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_0122: ldfld System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbId
IL_0127: ldloc.1
IL_0128: ldfld PixelCrushers.DialogueSystem.Actor TheForestOfLove.Narrative.Actor::pluginDbActor
IL_012d: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0132: ldloc.1
IL_0133: callvirt System.Void System.Collections.Generic.Dictionary`2<System.Int32,TheForestOfLove.Narrative.Actor>::Add(!0,!1)
IL_0138: ldloc.1
IL_0139: ldfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_013e: brfalse.s IL_0157
IL_0140: ldarg.0
IL_0141: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_0146: ldfld System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DataManifest::actorsByPluginDbName
IL_014b: ldloc.1
IL_014c: ldfld System.String TheForestOfLove.Narrative.Actor::pluginDbName
IL_0151: ldloc.1
IL_0152: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::Add(!0,!1)
IL_0157: ldarg.0
IL_0158: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_015d: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesByActorDbName
IL_0162: ldloc.1
IL_0163: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0168: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_016d: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::Add(!0,!1)
IL_0172: ldarg.0
IL_0173: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_0178: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeDateByActorDbName
IL_017d: ldloc.1
IL_017e: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0183: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_0188: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::Add(!0,!1)
IL_018d: ldarg.0
IL_018e: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_0193: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeFinalIdleByActorDbName
IL_0198: ldloc.1
IL_0199: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_019e: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_01a3: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::Add(!0,!1)
IL_01a8: ldarg.0
IL_01a9: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_01ae: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGiftByActorDbName
IL_01b3: ldloc.1
IL_01b4: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_01b9: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_01be: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::Add(!0,!1)
IL_01c3: ldarg.0
IL_01c4: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_01c9: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeGossipByActorDbName
IL_01ce: ldloc.1
IL_01cf: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_01d4: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_01d9: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::Add(!0,!1)
IL_01de: ldarg.0
IL_01df: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_01e4: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeManualByActorDbName
IL_01e9: ldloc.1
IL_01ea: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_01ef: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_01f4: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::Add(!0,!1)
IL_01f9: ldarg.0
IL_01fa: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_01ff: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestByActorDbName
IL_0204: ldloc.1
IL_0205: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_020a: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_020f: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::Add(!0,!1)
IL_0214: ldarg.0
IL_0215: ldfld TheForestOfLove.Narrative.DataManifest TheForestOfLove.Narrative.DialogueSystemLoader/<>c__DisplayClass15_0::manifest
IL_021a: ldfld System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>> TheForestOfLove.Narrative.DataManifest::dialoguesOfTypeQuestionIdleByActorDbName
IL_021f: ldloc.1
IL_0220: ldfld System.String TheForestOfLove.Narrative.Actor::dbName
IL_0225: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_022a: callvirt System.Void System.Collections.Generic.Dictionary`2<System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>>::Add(!0,!1)
IL_022f: ret
