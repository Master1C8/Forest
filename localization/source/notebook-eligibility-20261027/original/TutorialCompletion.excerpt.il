TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::ExecuteTrigger(System.String)
IL_020c: ldarg.1
IL_020d: ldstr "intro_from_beaver"
IL_0212: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0217: brtrue.s IL_0243
IL_0219: ldarg.1
IL_021a: ldstr "intro_from_mouse"
IL_021f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0224: brtrue.s IL_0243
IL_0226: ldarg.1
IL_0227: ldstr "intro_from_otter"
IL_022c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0231: brtrue.s IL_0243
IL_0233: ldarg.1
IL_0234: ldstr "give_sugar_to_bunny"
IL_0239: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_023e: brfalse IL_02ce
IL_0243: ldstr "Act1_TutorialQuest"
IL_0248: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_024d: ldc.i4 200
IL_0252: beq.s IL_028e
IL_0254: ldstr "intro_from_beaver"
IL_0259: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_025e: brfalse.s IL_028e
IL_0260: ldstr "intro_from_mouse"
IL_0265: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_026a: brfalse.s IL_028e
IL_026c: ldstr "intro_from_otter"
IL_0271: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_0276: brfalse.s IL_028e
IL_0278: ldstr "give_sugar_to_bunny"
IL_027d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_0282: brfalse.s IL_028e
IL_0284: ldstr "Act1_TutorialQuest"
IL_0289: call System.Void TheForestOfLove.QuestTriggerHelper::CompleteQuest(System.String)
IL_028e: ldarg.1
IL_028f: ldstr "give_sugar_to_bunny"
IL_0294: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0299: brfalse.s IL_02ce
IL_029b: ldstr "intro_from_beaver"
IL_02a0: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_02a5: brfalse.s IL_02bf
IL_02a7: ldstr "intro_from_mouse"
IL_02ac: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_02b1: brfalse.s IL_02bf
IL_02b3: ldstr "intro_from_otter"
IL_02b8: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_02bd: brtrue.s IL_02ce
IL_02bf: ldstr "Act1_TutorialQuest_3"
IL_02c4: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_02c9: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
