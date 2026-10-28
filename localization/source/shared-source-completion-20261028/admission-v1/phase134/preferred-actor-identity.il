TYPE TheForestOfLove.DialogueSettings
METHOD System.Void TheForestOfLove.DialogueSettings::SetInitialConversant(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: call BOC.BTagged.Tag BOC.BTagged.BTagged::ByName(System.String)
IL_0006: stloc.0
IL_0007: ldarg.0
IL_0008: ldloc.0
IL_0009: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::initialConversantActor
IL_000e: ldarg.0
IL_000f: ldloc.0
IL_0010: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::initialDialogueUiOverrideActor
IL_0015: ldarg.0
IL_0016: ldarg.1
IL_0017: stfld System.String TheForestOfLove.DialogueSettings::initialConversantActorDbName
IL_001c: ldarg.0
IL_001d: ldarg.1
IL_001e: stfld System.String TheForestOfLove.DialogueSettings::initialDialogueUiOverrideActorDbName
IL_0023: ret
