TYPE TheForestOfLove.DialogueSettings
METHOD System.String TheForestOfLove.DialogueSettings::get_ActorDbName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::actor
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_0015
IL_000e: ldarg.0
IL_000f: ldfld System.String TheForestOfLove.DialogueSettings::actorDbName
IL_0014: ret
IL_0015: ldarg.0
IL_0016: ldfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::actor
IL_001b: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_0020: ret
METHOD System.String TheForestOfLove.DialogueSettings::get_DialogueDbName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::dialogue
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brtrue.s IL_0015
IL_000e: ldarg.0
IL_000f: ldfld System.String TheForestOfLove.DialogueSettings::dialogueDbName
IL_0014: ret
IL_0015: ldarg.0
IL_0016: ldfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::dialogue
IL_001b: callvirt System.String BOC.BTagged.BTaggedSO::get_ShortName()
IL_0020: ret
METHOD System.String TheForestOfLove.DialogueSettings::get_ArcDbName() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.DialogueSettings::arcDbName
IL_0006: ret
METHOD System.Void TheForestOfLove.DialogueSettings::CopyFrom(TheForestOfLove.Gameplay.ConversationSettings) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::actorName
IL_0007: call BOC.BTagged.Tag BOC.BTagged.Tag::op_Implicit(System.String)
IL_000c: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::actor
IL_0011: ldarg.0
IL_0012: ldarg.1
IL_0013: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::actorName
IL_0018: stfld System.String TheForestOfLove.DialogueSettings::actorDbName
IL_001d: ldarg.0
IL_001e: ldarg.1
IL_001f: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::conversationName
IL_0024: call BOC.BTagged.Tag BOC.BTagged.Tag::op_Implicit(System.String)
IL_0029: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::dialogue
IL_002e: ldarg.0
IL_002f: ldarg.1
IL_0030: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::conversationName
IL_0035: stfld System.String TheForestOfLove.DialogueSettings::dialogueDbName
IL_003a: ldarg.0
IL_003b: ldarg.1
IL_003c: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::dialogueArcName
IL_0041: stfld System.String TheForestOfLove.DialogueSettings::arcDbName
IL_0046: ldarg.0
IL_0047: ldarg.1
IL_0048: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::preferredConversantName
IL_004d: call BOC.BTagged.Tag BOC.BTagged.Tag::op_Implicit(System.String)
IL_0052: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::initialConversantActor
IL_0057: ldarg.0
IL_0058: ldarg.1
IL_0059: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::preferredConversantName
IL_005e: stfld System.String TheForestOfLove.DialogueSettings::initialConversantActorDbName
IL_0063: ldarg.0
IL_0064: ldarg.1
IL_0065: ldfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::ignorePreferredConversantForDialogueBackground
IL_006a: brtrue.s IL_0074
IL_006c: ldarg.1
IL_006d: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::preferredConversantName
IL_0072: br.s IL_007a
IL_0074: ldarg.1
IL_0075: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::actorName
IL_007a: call BOC.BTagged.Tag BOC.BTagged.Tag::op_Implicit(System.String)
IL_007f: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::initialDialogueUiOverrideActor
IL_0084: ldarg.0
IL_0085: ldarg.1
IL_0086: ldfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::ignorePreferredConversantForDialogueBackground
IL_008b: brtrue.s IL_0095
IL_008d: ldarg.1
IL_008e: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::preferredConversantName
IL_0093: br.s IL_009b
IL_0095: ldarg.1
IL_0096: ldfld System.String TheForestOfLove.Gameplay.ConversationSettings::actorName
IL_009b: stfld System.String TheForestOfLove.DialogueSettings::initialDialogueUiOverrideActorDbName
IL_00a0: ldarg.0
IL_00a1: ldarg.1
IL_00a2: ldfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::usePreferredPlayerDirection
IL_00a7: stfld System.Boolean TheForestOfLove.DialogueSettings::setPlayerDirection
IL_00ac: ldarg.0
IL_00ad: ldarg.1
IL_00ae: ldfld TheForestOfLove.Direction TheForestOfLove.Gameplay.ConversationSettings::preferredPlayerDirection
IL_00b3: stfld TheForestOfLove.Direction TheForestOfLove.DialogueSettings::playerDirection
IL_00b8: ldarg.0
IL_00b9: ldarg.1
IL_00ba: ldfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::useOwnerDirection
IL_00bf: stfld System.Boolean TheForestOfLove.DialogueSettings::setOwnerDirection
IL_00c4: ldarg.0
IL_00c5: ldarg.1
IL_00c6: ldfld TheForestOfLove.Direction TheForestOfLove.Gameplay.ConversationSettings::ownerDirection
IL_00cb: stfld TheForestOfLove.Direction TheForestOfLove.DialogueSettings::ownerDirection
IL_00d0: ldarg.0
IL_00d1: ldarg.1
IL_00d2: ldfld System.Boolean TheForestOfLove.Gameplay.ConversationSettings::useInitialConversantDirection
IL_00d7: stfld System.Boolean TheForestOfLove.DialogueSettings::setInitialConversantDirection
IL_00dc: ldarg.0
IL_00dd: ldarg.1
IL_00de: ldfld TheForestOfLove.Direction TheForestOfLove.Gameplay.ConversationSettings::initialConversantDirection
IL_00e3: stfld TheForestOfLove.Direction TheForestOfLove.DialogueSettings::initialConversantDirection
IL_00e8: ret
METHOD System.Void TheForestOfLove.DialogueSettings::CopyFrom(TheForestOfLove.Narrative.Dialogue,System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_0007: call BOC.BTagged.Tag BOC.BTagged.Tag::op_Implicit(System.String)
IL_000c: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::actor
IL_0011: ldarg.0
IL_0012: ldarg.1
IL_0013: ldfld System.String TheForestOfLove.Narrative.Dialogue::primaryActorDbName
IL_0018: stfld System.String TheForestOfLove.DialogueSettings::actorDbName
IL_001d: ldarg.0
IL_001e: ldarg.1
IL_001f: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0024: call BOC.BTagged.Tag BOC.BTagged.Tag::op_Implicit(System.String)
IL_0029: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::dialogue
IL_002e: ldarg.0
IL_002f: ldarg.1
IL_0030: ldfld System.String TheForestOfLove.Narrative.Dialogue::dbName
IL_0035: stfld System.String TheForestOfLove.DialogueSettings::dialogueDbName
IL_003a: ldarg.0
IL_003b: ldarg.2
IL_003c: stfld System.String TheForestOfLove.DialogueSettings::arcDbName
IL_0041: ldarg.0
IL_0042: ldarg.1
IL_0043: ldfld System.String TheForestOfLove.Narrative.Dialogue::initialActorDbName
IL_0048: call BOC.BTagged.Tag BOC.BTagged.Tag::op_Implicit(System.String)
IL_004d: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::initialConversantActor
IL_0052: ldarg.0
IL_0053: ldarg.1
IL_0054: ldfld System.String TheForestOfLove.Narrative.Dialogue::initialActorDbName
IL_0059: stfld System.String TheForestOfLove.DialogueSettings::initialConversantActorDbName
IL_005e: ldarg.0
IL_005f: ldnull
IL_0060: stfld BOC.BTagged.Tag TheForestOfLove.DialogueSettings::initialDialogueUiOverrideActor
IL_0065: ldarg.0
IL_0066: ldnull
IL_0067: stfld System.String TheForestOfLove.DialogueSettings::initialDialogueUiOverrideActorDbName
IL_006c: ldarg.0
IL_006d: ldc.i4.0
IL_006e: stfld System.Boolean TheForestOfLove.DialogueSettings::setPlayerDirection
IL_0073: ldarg.0
IL_0074: ldc.i4.0
IL_0075: stfld TheForestOfLove.Direction TheForestOfLove.DialogueSettings::playerDirection
IL_007a: ldarg.0
IL_007b: ldc.i4.0
IL_007c: stfld System.Boolean TheForestOfLove.DialogueSettings::setOwnerDirection
IL_0081: ldarg.0
IL_0082: ldc.i4.0
IL_0083: stfld TheForestOfLove.Direction TheForestOfLove.DialogueSettings::ownerDirection
IL_0088: ldarg.0
IL_0089: ldc.i4.0
IL_008a: stfld System.Boolean TheForestOfLove.DialogueSettings::setInitialConversantDirection
IL_008f: ldarg.0
IL_0090: ldc.i4.0
IL_0091: stfld TheForestOfLove.Direction TheForestOfLove.DialogueSettings::initialConversantDirection
IL_0096: ret
