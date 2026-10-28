TYPE TheForestOfLove.Content.BeaverHouseSpawner
METHOD System.Void TheForestOfLove.Content.BeaverHouseSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.BeaverHouseSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.BeaverHouseSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.BeaverHouseSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.BeaverHouseSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.BeaverHouseSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.BeaverHouseSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.BeaverHouseSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.BeaverHouseSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.BeaverHouseSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.BeaverHouseSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.BeaverHouseSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldstr "carving"
IL_0080: ldarg.0
IL_0081: call AreaContentSet TheForestOfLove.Content.BeaverHouseSpawner::get_Elements()
IL_0086: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_008b: call System.Void TheForestOfLove.Content.BeaverHouseSpawner::set_CarvingInteraction(AreaContent)
IL_0090: ldarg.0
IL_0091: ldarg.0
IL_0092: ldarg.0
IL_0093: ldfld UnityEngine.GameObject TheForestOfLove.Content.BeaverHouseSpawner::workbenchInteraction
IL_0098: ldarg.0
IL_0099: call AreaContentSet TheForestOfLove.Content.BeaverHouseSpawner::get_Elements()
IL_009e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00a3: call System.Void TheForestOfLove.Content.BeaverHouseSpawner::set_WorkbenchInteraction(AreaContent)
IL_00a8: ldarg.0
IL_00a9: ldarg.0
IL_00aa: ldstr "Bucky"
IL_00af: ldarg.0
IL_00b0: call AreaContentSet TheForestOfLove.Content.BeaverHouseSpawner::get_Critters()
IL_00b5: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00ba: call System.Void TheForestOfLove.Content.BeaverHouseSpawner::set_Bucky(AreaContent)
IL_00bf: call System.Int32 TheForestOfLove.QuestTriggerHelper::GetCurrentAct()
IL_00c4: ldc.i4.3
IL_00c5: blt.s IL_00f8
IL_00c7: ldstr "Examinables_Beaverhouse_2Carving"
IL_00cc: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00d1: brfalse.s IL_00f8
IL_00d3: ldstr "Examinables_Beaverhouse_4Carving"
IL_00d8: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00dd: brtrue.s IL_00f8
IL_00df: ldarg.0
IL_00e0: ldfld UnityEngine.GameObject TheForestOfLove.Content.BeaverHouseSpawner::sculpture03
IL_00e5: ldarg.0
IL_00e6: call AreaContent TheForestOfLove.Content.BeaverHouseSpawner::get_CarvingInteraction()
IL_00eb: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_00f0: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_00f5: pop
IL_00f6: br.s IL_0148
IL_00f8: call System.Int32 TheForestOfLove.QuestTriggerHelper::GetCurrentAct()
IL_00fd: ldc.i4.2
IL_00fe: blt.s IL_0131
IL_0100: ldstr "Examinables_Beaverhouse_Carving"
IL_0105: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_010a: brfalse.s IL_0131
IL_010c: ldstr "Examinables_Beaverhouse_3Carving"
IL_0111: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0116: brtrue.s IL_0131
IL_0118: ldarg.0
IL_0119: ldfld UnityEngine.GameObject TheForestOfLove.Content.BeaverHouseSpawner::sculpture02
IL_011e: ldarg.0
IL_011f: call AreaContent TheForestOfLove.Content.BeaverHouseSpawner::get_CarvingInteraction()
IL_0124: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0129: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_012e: pop
IL_012f: br.s IL_0148
IL_0131: ldarg.0
IL_0132: ldfld UnityEngine.GameObject TheForestOfLove.Content.BeaverHouseSpawner::sculpture01
IL_0137: ldarg.0
IL_0138: call AreaContent TheForestOfLove.Content.BeaverHouseSpawner::get_CarvingInteraction()
IL_013d: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0142: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0147: pop
IL_0148: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_014d: brfalse.s IL_0150
IL_014f: ret
IL_0150: ldstr "beaver_started_toy"
IL_0155: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_015a: brfalse.s IL_0195
IL_015c: ldstr "deliver_dildo"
IL_0161: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0166: brtrue.s IL_0195
IL_0168: ldarg.0
IL_0169: ldfld UnityEngine.GameObject TheForestOfLove.Content.BeaverHouseSpawner::npcBucky
IL_016e: ldarg.0
IL_016f: call AreaContent TheForestOfLove.Content.BeaverHouseSpawner::get_Bucky()
IL_0174: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0179: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_017e: pop
IL_017f: ldarg.0
IL_0180: call AreaContent TheForestOfLove.Content.BeaverHouseSpawner::get_CarvingInteraction()
IL_0185: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_018a: ldarg.0
IL_018b: call AreaContent TheForestOfLove.Content.BeaverHouseSpawner::get_WorkbenchInteraction()
IL_0190: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_0195: ldstr "AfterstormQuest_ScarlettAndPeter"
IL_019a: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_019f: brfalse.s IL_01da
IL_01a1: ldstr "AfterstormQuest_Bucky"
IL_01a6: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01ab: brtrue.s IL_01da
IL_01ad: ldarg.0
IL_01ae: ldfld UnityEngine.GameObject TheForestOfLove.Content.BeaverHouseSpawner::npcBucky
IL_01b3: ldarg.0
IL_01b4: call AreaContent TheForestOfLove.Content.BeaverHouseSpawner::get_Bucky()
IL_01b9: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_01be: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01c3: pop
IL_01c4: ldarg.0
IL_01c5: call AreaContent TheForestOfLove.Content.BeaverHouseSpawner::get_CarvingInteraction()
IL_01ca: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_01cf: ldarg.0
IL_01d0: call AreaContent TheForestOfLove.Content.BeaverHouseSpawner::get_WorkbenchInteraction()
IL_01d5: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_01da: ret
