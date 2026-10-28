TYPE TheForestOfLove.IntroForestCutscene
METHOD System.Void TheForestOfLove.IntroForestCutscene::OnWaypointArrived(TheForestOfLove.Waypoint) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.String TheForestOfLove.Waypoint::title
IL_0006: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_000b: brfalse.s IL_000e
IL_000d: ret
IL_000e: ldstr "NewGame_Intro"
IL_0013: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0018: ldstr "Scarlett"
IL_001d: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0022: ldstr "Narrator"
IL_0027: stsfld System.String TheForestOfLove.QuestConversationHelper::preferredConversantActorName
IL_002c: ldarg.1
IL_002d: ldfld System.String TheForestOfLove.Waypoint::title
IL_0032: stloc.0
IL_0033: ldloc.0
IL_0034: brfalse IL_00d3
IL_0039: ldloc.0
IL_003a: ldstr "double_take"
IL_003f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0044: brtrue.s IL_006e
IL_0046: ldloc.0
IL_0047: ldstr "familiar_rock"
IL_004c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0051: brtrue.s IL_007e
IL_0053: ldloc.0
IL_0054: ldstr "familiar_tree"
IL_0059: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_005e: brtrue.s IL_009a
IL_0060: ldloc.0
IL_0061: ldstr "slow1"
IL_0066: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_006b: brtrue.s IL_00aa
IL_006d: ret
IL_006e: ldstr "red_double_take"
IL_0073: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0078: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_007d: ret
IL_007e: ldstr "red_recognizes_rock"
IL_0083: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0088: ldc.i4.1
IL_0089: stsfld System.Boolean TheForestOfLove.QuestConversationHelper::usePreferredDirection
IL_008e: ldc.i4.1
IL_008f: stsfld TheForestOfLove.Direction TheForestOfLove.QuestConversationHelper::preferredPlayerDirection
IL_0094: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0099: ret
IL_009a: ldstr "red_recognizes_tree"
IL_009f: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_00a4: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_00a9: ret
IL_00aa: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_00af: dup
IL_00b0: ldfld UnityEngine.Vector2 TheForestOfLove.Player::speed
IL_00b5: ldc.r4 0.25
IL_00ba: call UnityEngine.Vector2 UnityEngine.Vector2::op_Multiply(UnityEngine.Vector2,System.Single)
IL_00bf: stfld UnityEngine.Vector2 TheForestOfLove.Player::speed
IL_00c4: ldstr "red_feeling_woozy"
IL_00c9: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_00ce: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_00d3: ret
METHOD System.Void TheForestOfLove.IntroForestCutscene::OnWaypointWaitTimeElapsed(TheForestOfLove.Waypoint) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld System.String TheForestOfLove.Waypoint::title
IL_0006: stloc.0
IL_0007: ldloc.0
IL_0008: brfalse.s IL_0038
IL_000a: ldloc.0
IL_000b: ldstr "sleep"
IL_0010: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0015: brfalse.s IL_0038
IL_0017: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_001c: callvirt System.Void TheForestOfLove.Player::SleepIntroForest()
IL_0021: ldarg.0
IL_0022: ldfld System.Single TheForestOfLove.IntroForestCutscene::fadeoutSeconds
IL_0027: ldarg.0
IL_0028: ldftn System.Void TheForestOfLove.IntroForestCutscene::EndCutscene()
IL_002e: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0033: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0038: ret
