TYPE TheForestOfLove.Content.PlainsFieldSpawner
METHOD System.Void TheForestOfLove.Content.PlainsFieldSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.PlainsFieldSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.PlainsFieldSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldarg.0
IL_007c: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::longWalkWarning
IL_0081: ldarg.0
IL_0082: call AreaContentSet TheForestOfLove.Content.PlainsFieldSpawner::get_Elements()
IL_0087: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_008c: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_LongWalkWarning(AreaContent)
IL_0091: ldarg.0
IL_0092: ldarg.0
IL_0093: ldarg.0
IL_0094: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::longWalk
IL_0099: ldarg.0
IL_009a: call AreaContentSet TheForestOfLove.Content.PlainsFieldSpawner::get_Elements()
IL_009f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00a4: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_LongWalk(AreaContent)
IL_00a9: ldarg.0
IL_00aa: ldarg.0
IL_00ab: ldarg.0
IL_00ac: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::longerWalk
IL_00b1: ldarg.0
IL_00b2: call AreaContentSet TheForestOfLove.Content.PlainsFieldSpawner::get_Elements()
IL_00b7: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00bc: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_LongerWalk(AreaContent)
IL_00c1: ldarg.0
IL_00c2: ldarg.0
IL_00c3: ldarg.0
IL_00c4: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::glyphStones
IL_00c9: callvirt System.String UnityEngine.Object::get_name()
IL_00ce: ldarg.0
IL_00cf: call AreaContentSet TheForestOfLove.Content.PlainsFieldSpawner::get_Elements()
IL_00d4: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00d9: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_GlyphStones(AreaContent)
IL_00de: ldarg.0
IL_00df: ldarg.0
IL_00e0: ldstr "Oliver"
IL_00e5: ldarg.0
IL_00e6: call AreaContentSet TheForestOfLove.Content.PlainsFieldSpawner::get_Critters()
IL_00eb: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00f0: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_Oliver(AreaContent)
IL_00f5: ldarg.0
IL_00f6: ldarg.0
IL_00f7: ldarg.0
IL_00f8: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::adventuresGateway
IL_00fd: callvirt System.String UnityEngine.Object::get_name()
IL_0102: ldarg.0
IL_0103: call AreaContentSet TheForestOfLove.Content.PlainsFieldSpawner::get_Elements()
IL_0108: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_010d: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::set_AdventuresGateway(AreaContent)
IL_0112: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_0117: brfalse.s IL_0132
IL_0119: ldarg.0
IL_011a: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::glyphStonesGlowy
IL_011f: ldarg.0
IL_0120: call AreaContent TheForestOfLove.Content.PlainsFieldSpawner::get_GlyphStones()
IL_0125: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_012a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_012f: pop
IL_0130: br.s IL_0149
IL_0132: ldarg.0
IL_0133: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::glyphStones
IL_0138: ldarg.0
IL_0139: call AreaContent TheForestOfLove.Content.PlainsFieldSpawner::get_GlyphStones()
IL_013e: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0143: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0148: pop
IL_0149: call System.Boolean TheForestOfLove.SpawnManager::get_donkeyFastTravel()
IL_014e: brfalse.s IL_018c
IL_0150: call System.Void TheForestOfLove.CutsceneManager::ConstantBlack()
IL_0155: ldarg.0
IL_0156: ldfld TheForestOfLove.DonkeyRunCutscene TheForestOfLove.Content.PlainsFieldSpawner::donkeyRunCutscene
IL_015b: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.DonkeyRunCutscene>(!!0)
IL_0160: pop
IL_0161: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0166: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_016b: ldarg.0
IL_016c: call AreaContent TheForestOfLove.Content.PlainsFieldSpawner::get_LongWalkWarning()
IL_0171: callvirt System.Void AreaContent::Disable()
IL_0176: ldarg.0
IL_0177: call AreaContent TheForestOfLove.Content.PlainsFieldSpawner::get_LongWalk()
IL_017c: callvirt System.Void AreaContent::Disable()
IL_0181: ldarg.0
IL_0182: call AreaContent TheForestOfLove.Content.PlainsFieldSpawner::get_LongerWalk()
IL_0187: callvirt System.Void AreaContent::Disable()
IL_018c: ldstr "Claire"
IL_0191: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorIntroduced(System.String)
IL_0196: brfalse.s IL_01a3
IL_0198: ldarg.0
IL_0199: call AreaContent TheForestOfLove.Content.PlainsFieldSpawner::get_LongWalkWarning()
IL_019e: callvirt System.Void AreaContent::Disable()
IL_01a3: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_01a8: brfalse.s IL_01b1
IL_01aa: ldarg.0
IL_01ab: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::SpawnInstancedStoryStuff()
IL_01b0: ret
IL_01b1: ldarg.0
IL_01b2: ldstr "Plains_Field"
IL_01b7: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnAdventuresForGatewayName(System.String)
IL_01bc: brfalse.s IL_01c4
IL_01be: ldarg.0
IL_01bf: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::SpawnAdventuresTeleport()
IL_01c4: ldarg.0
IL_01c5: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::SpawnDefaultCritters()
IL_01ca: ret
METHOD System.Void TheForestOfLove.Content.PlainsFieldSpawner::SpawnOliver() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Oliver"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsFieldSpawner::npcOliver
IL_0013: ldarg.0
IL_0014: call AreaContent TheForestOfLove.Content.PlainsFieldSpawner::get_Oliver()
IL_0019: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_001e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0023: pop
IL_0024: ret
