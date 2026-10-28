TYPE TheForestOfLove.Content.OtterShopBackRoomSpawner
METHOD System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopBackRoomSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopBackRoomSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.OtterShopBackRoomSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopBackRoomSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.OtterShopBackRoomSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldstr "Maverick"
IL_0080: ldarg.0
IL_0081: call AreaContentSet TheForestOfLove.Content.OtterShopBackRoomSpawner::get_Critters()
IL_0086: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_008b: call System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::set_Maverick(AreaContent)
IL_0090: ldarg.0
IL_0091: ldarg.0
IL_0092: ldstr "Melody"
IL_0097: ldarg.0
IL_0098: call AreaContentSet TheForestOfLove.Content.OtterShopBackRoomSpawner::get_Critters()
IL_009d: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00a2: call System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::set_Melody(AreaContent)
IL_00a7: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00ac: brfalse.s IL_00b5
IL_00ae: ldarg.0
IL_00af: call System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::SpawnInstancedStoryStuff()
IL_00b4: ret
IL_00b5: ldstr "MelodyQuest_PhotoshootConclusion"
IL_00ba: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00bf: brfalse.s IL_012e
IL_00c1: ldstr "StormQuest_PostPhotoshootCutscene"
IL_00c6: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00cb: brtrue.s IL_012e
IL_00cd: ldarg.0
IL_00ce: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopBackRoomSpawner::npcMaverick
IL_00d3: ldarg.0
IL_00d4: call AreaContent TheForestOfLove.Content.OtterShopBackRoomSpawner::get_Maverick()
IL_00d9: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_00de: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_00e3: pop
IL_00e4: ldarg.0
IL_00e5: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopBackRoomSpawner::npcMelody
IL_00ea: ldarg.0
IL_00eb: call AreaContent TheForestOfLove.Content.OtterShopBackRoomSpawner::get_Melody()
IL_00f0: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_00f5: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_00fa: pop
IL_00fb: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0100: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0105: ldc.r4 1.5
IL_010a: ldsfld System.Action TheForestOfLove.Content.OtterShopBackRoomSpawner/<>c::<>9__44_0
IL_010f: dup
IL_0110: brtrue.s IL_0129
IL_0112: pop
IL_0113: ldsfld TheForestOfLove.Content.OtterShopBackRoomSpawner/<>c TheForestOfLove.Content.OtterShopBackRoomSpawner/<>c::<>9
IL_0118: ldftn System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner/<>c::<SpawnObjects>b__44_0()
IL_011e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0123: dup
IL_0124: stsfld System.Action TheForestOfLove.Content.OtterShopBackRoomSpawner/<>c::<>9__44_0
IL_0129: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_012e: ldstr "CharlotteSocialQuest_RoommatesLeaveTheCave"
IL_0133: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0138: brfalse.s IL_0154
IL_013a: ldstr "return_to_centralforest_after_photoshoot"
IL_013f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0144: brtrue.s IL_0154
IL_0146: ldarg.0
IL_0147: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopBackRoomSpawner::examinables
IL_014c: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0151: pop
IL_0152: br.s IL_0175
IL_0154: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanPlayMaverickRascalShopStory()
IL_0159: brfalse.s IL_0169
IL_015b: ldarg.0
IL_015c: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopBackRoomSpawner::examinablesDarkWithOpenDoor
IL_0161: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0166: pop
IL_0167: br.s IL_0175
IL_0169: ldarg.0
IL_016a: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopBackRoomSpawner::examinablesDark
IL_016f: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0174: pop
IL_0175: ldarg.0
IL_0176: call System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::SpawnDefaultCritters()
IL_017b: ret
METHOD System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::SpawnMaverick() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Maverick"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsPhotoshootHappening()
IL_0012: brtrue.s IL_0015
IL_0014: ret
IL_0015: ldarg.0
IL_0016: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopBackRoomSpawner::npcMaverick
IL_001b: ldarg.0
IL_001c: call AreaContent TheForestOfLove.Content.OtterShopBackRoomSpawner::get_Maverick()
IL_0021: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0026: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_002b: pop
IL_002c: ret
METHOD System.Void TheForestOfLove.Content.OtterShopBackRoomSpawner::SpawnMelody() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Melody"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsPhotoshootHappening()
IL_0012: brtrue.s IL_0015
IL_0014: ret
IL_0015: ldarg.0
IL_0016: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopBackRoomSpawner::npcMelody
IL_001b: ldarg.0
IL_001c: call AreaContent TheForestOfLove.Content.OtterShopBackRoomSpawner::get_Melody()
IL_0021: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0026: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_002b: pop
IL_002c: ret
