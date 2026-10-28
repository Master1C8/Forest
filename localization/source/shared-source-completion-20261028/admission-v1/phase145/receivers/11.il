TYPE TheForestOfLove.DialogueSettings
METHOD System.Void TheForestOfLove.DialogueSettings::SetDialogueDbName(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call BOC.BTagged.Tag BOC.BTagged.BTagged::ByName(System.String)
IL_0007: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::dialogue
IL_000c: ldarg.0
IL_000d: ldarg.1
IL_000e: stfld System.String TheForestOfLove.DialogueSettings::dialogueDbName
IL_0013: ret
METHOD System.Void TheForestOfLove.DialogueSettings::SetArcDbName(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String TheForestOfLove.DialogueSettings::arcDbName
IL_0007: ret
