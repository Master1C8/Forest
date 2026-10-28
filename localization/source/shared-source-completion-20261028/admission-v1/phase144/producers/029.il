TYPE TheForestOfLove.Content.BearCaveSpawner
METHOD System.Void TheForestOfLove.Content.BearCaveSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.BearCaveSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.BearCaveSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.BearCaveSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.BearCaveSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.BearCaveSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.BearCaveSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.BearCaveSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.BearCaveSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldarg.0
IL_007c: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::plateOfCookies
IL_0081: callvirt System.String UnityEngine.Object::get_name()
IL_0086: ldarg.0
IL_0087: call AreaContentSet TheForestOfLove.Content.BearCaveSpawner::get_Elements()
IL_008c: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0091: call System.Void TheForestOfLove.Content.BearCaveSpawner::set_PlateOfCookies(AreaContent)
IL_0096: ldarg.0
IL_0097: ldarg.0
IL_0098: ldarg.0
IL_0099: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::finleyBoxOfStuff
IL_009e: callvirt System.String UnityEngine.Object::get_name()
IL_00a3: ldarg.0
IL_00a4: call AreaContentSet TheForestOfLove.Content.BearCaveSpawner::get_Elements()
IL_00a9: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00ae: call System.Void TheForestOfLove.Content.BearCaveSpawner::set_FinleyBoxOfStuff(AreaContent)
IL_00b3: ldarg.0
IL_00b4: ldarg.0
IL_00b5: ldarg.0
IL_00b6: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::jarOnShelf
IL_00bb: callvirt System.String UnityEngine.Object::get_name()
IL_00c0: ldarg.0
IL_00c1: call AreaContentSet TheForestOfLove.Content.BearCaveSpawner::get_Elements()
IL_00c6: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00cb: call System.Void TheForestOfLove.Content.BearCaveSpawner::set_JarOnShelf(AreaContent)
IL_00d0: ldarg.0
IL_00d1: ldarg.0
IL_00d2: ldarg.0
IL_00d3: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::adventuresGateway
IL_00d8: callvirt System.String UnityEngine.Object::get_name()
IL_00dd: ldarg.0
IL_00de: call AreaContentSet TheForestOfLove.Content.BearCaveSpawner::get_Elements()
IL_00e3: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00e8: call System.Void TheForestOfLove.Content.BearCaveSpawner::set_AdventuresGateway(AreaContent)
IL_00ed: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00f2: brfalse.s IL_00fb
IL_00f4: ldarg.0
IL_00f5: call System.Void TheForestOfLove.Content.BearCaveSpawner::SpawnInstancedStoryStuff()
IL_00fa: ret
IL_00fb: ldstr "FinleyQuest_MeetCharlotteAndMelody"
IL_0100: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0105: brtrue.s IL_0118
IL_0107: ldarg.0
IL_0108: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::bearCaveIntroCutscene
IL_010d: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0112: pop
IL_0113: br IL_01c5
IL_0118: ldstr "FinleyQuest_BringFinleyHisStuff"
IL_011d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0122: brfalse.s IL_0141
IL_0124: ldstr "FinleyQuest_RoommatesConclusion"
IL_0129: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_012e: brtrue.s IL_0141
IL_0130: ldarg.0
IL_0131: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::bearCaveFinleyCutscene
IL_0136: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_013b: pop
IL_013c: br IL_01c5
IL_0141: ldstr "CharlotteSocialQuest_MeetingTheCritters"
IL_0146: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_014b: brfalse.s IL_0167
IL_014d: ldstr "MelodyQuest_PhotoshootConclusion"
IL_0152: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0157: brtrue.s IL_0167
IL_0159: ldarg.0
IL_015a: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::bearCaveCharlotteAlonePrefab
IL_015f: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0164: pop
IL_0165: br.s IL_01c5
IL_0167: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsCharlotteMeetingCritters()
IL_016c: brfalse.s IL_017c
IL_016e: ldarg.0
IL_016f: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::bearCaveNoOneHome
IL_0174: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0179: pop
IL_017a: br.s IL_01c5
IL_017c: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsPhotoshootHappening()
IL_0181: brfalse.s IL_0191
IL_0183: ldarg.0
IL_0184: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::bearCavePostCutsceneCharlotteOnlyPrefabs
IL_0189: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_018e: pop
IL_018f: br.s IL_01c5
IL_0191: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3AfterstormQuest()
IL_0196: brtrue.s IL_019f
IL_0198: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3LightQuest()
IL_019d: brfalse.s IL_01b9
IL_019f: ldarg.0
IL_01a0: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::bearCaveAct3AfterstormCritters
IL_01a5: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_01aa: pop
IL_01ab: ldarg.0
IL_01ac: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::afterstormQuestMelodyGivesBellCutscene
IL_01b1: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_01b6: pop
IL_01b7: br.s IL_01c5
IL_01b9: ldarg.0
IL_01ba: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::bearCavePostCutscenePrefabs
IL_01bf: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_01c4: pop
IL_01c5: ldstr "CookieQuest_CharlotteIntroduction"
IL_01ca: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01cf: brfalse.s IL_01e2
IL_01d1: ldstr "CookieQuest_CookiesAreReady"
IL_01d6: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01db: brtrue.s IL_01e2
IL_01dd: call System.Void TheForestOfLove.Content.BearCaveSpawner::SpawnPlateOfCookies()
IL_01e2: ldstr "FinleyQuest_MelodyHasFinleyStuff"
IL_01e7: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01ec: brfalse.s IL_01ff
IL_01ee: ldstr "finleyquest_receive_finley_stuff"
IL_01f3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_01f8: brtrue.s IL_01ff
IL_01fa: call System.Void TheForestOfLove.Content.BearCaveSpawner::SpawnFinleyBoxOfStuff()
IL_01ff: ldstr "WolfQuest_AskAround_Charlotte"
IL_0204: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0209: brtrue.s IL_0222
IL_020b: ldarg.0
IL_020c: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::jarOnShelf
IL_0211: ldarg.0
IL_0212: call AreaContent TheForestOfLove.Content.BearCaveSpawner::get_JarOnShelf()
IL_0217: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_021c: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0221: pop
IL_0222: ldstr "WolfQuest_MeetTheWolf"
IL_0227: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_022c: brfalse.s IL_0250
IL_022e: ldstr "WolfQuest_AskAround_Charlotte"
IL_0233: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0238: brtrue.s IL_0250
IL_023a: ldarg.0
IL_023b: ldarg.0
IL_023c: ldfld UnityEngine.GameObject TheForestOfLove.Content.BearCaveSpawner::act3WolfQuestObtainSecondJarCutscene
IL_0241: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0246: callvirt !!0 UnityEngine.GameObject::GetComponentInChildren<TheForestOfLove.GeneralDialogueCameraSwapUnswapCutscene>()
IL_024b: stfld TheForestOfLove.GeneralDialogueCameraSwapUnswapCutscene TheForestOfLove.Content.BearCaveSpawner::act3WolfQuestObtainSecondJarCutscene_Instance
IL_0250: ldarg.0
IL_0251: ldstr "Mountains_BearCave"
IL_0256: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnAdventuresForGatewayName(System.String)
IL_025b: brfalse.s IL_0263
IL_025d: ldarg.0
IL_025e: call System.Void TheForestOfLove.Content.BearCaveSpawner::SpawnAdventuresTeleport()
IL_0263: ret
METHOD System.Void TheForestOfLove.Content.BearCaveSpawner::Act3AfterstormSetCharlotteInBedAnimatorTrigger_internal(System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Charlotte"
IL_0005: call TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Gameplay.SpawnableActor::FindActorByName(System.String)
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: ldnull
IL_000d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0012: brfalse.s IL_0020
IL_0014: ldloc.0
IL_0015: callvirt UnityEngine.Animator TheForestOfLove.Gameplay.SpawnableActor::get_Animator()
IL_001a: ldarg.1
IL_001b: callvirt System.Void UnityEngine.Animator::SetTrigger(System.String)
IL_0020: ret
