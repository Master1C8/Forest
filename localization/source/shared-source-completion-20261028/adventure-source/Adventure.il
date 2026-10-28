TYPE TheForestOfLove.Narrative.Adventure
METHOD System.String TheForestOfLove.Narrative.Adventure::get_Title() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Narrative.Adventure::<Title>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.Narrative.Adventure::set_Title(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String TheForestOfLove.Narrative.Adventure::<Title>k__BackingField
IL_0007: ret
METHOD System.String TheForestOfLove.Narrative.Adventure::get_NotificationTitle() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Narrative.Adventure::<NotificationTitle>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.Narrative.Adventure::set_NotificationTitle(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String TheForestOfLove.Narrative.Adventure::<NotificationTitle>k__BackingField
IL_0007: ret
METHOD System.String TheForestOfLove.Narrative.Adventure::get_Body() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Narrative.Adventure::<Body>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.Narrative.Adventure::set_Body(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String TheForestOfLove.Narrative.Adventure::<Body>k__BackingField
IL_0007: ret
METHOD System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure> TheForestOfLove.Narrative.Adventure::RegenerateAdventuresPleaseMoveThisDataToDbSoItsNotStaticBruh() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::.ctor()
IL_0005: dup
IL_0006: ldc.i4.s 100
IL_0008: newobj System.Void TheForestOfLove.Narrative.Adventure::.ctor()
IL_000d: dup
IL_000e: ldc.i4.s 100
IL_0010: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_StoryType(TheForestOfLove.Narrative.AdventureType)
IL_0015: dup
IL_0016: ldstr "<SIZE=22>B</SIZE>LESSING OF THE <SIZE=22>B</SIZE>ELLS"
IL_001b: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Title(System.String)
IL_0020: dup
IL_0021: ldstr "Blessing of the Bells"
IL_0026: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_NotificationTitle(System.String)
IL_002b: dup
IL_002c: ldstr "What exactly is "The Blessing"? Find out what the forest critters know about the celebration!"
IL_0031: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Body(System.String)
IL_0036: dup
IL_0037: ldstr "BunnyHouse"
IL_003c: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_GatewayName(System.String)
IL_0041: dup
IL_0042: ldc.r4 2.58
IL_0047: ldc.r4 0.76
IL_004c: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_0051: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnLocation(UnityEngine.Vector2)
IL_0056: dup
IL_0057: ldstr "BunnyHouse"
IL_005c: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnAreaDbName(System.String)
IL_0061: dup
IL_0062: ldstr "blessing_of_the_bells"
IL_0067: stfld System.String TheForestOfLove.Narrative.Adventure::Savekey
IL_006c: dup
IL_006d: ldstr "completed_adventure_blessing_of_the_bells"
IL_0072: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_CompletionTrigger(System.String)
IL_0077: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::Add(!0,!1)
IL_007c: dup
IL_007d: ldc.i4 200
IL_0082: newobj System.Void TheForestOfLove.Narrative.Adventure::.ctor()
IL_0087: dup
IL_0088: ldc.i4 200
IL_008d: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_StoryType(TheForestOfLove.Narrative.AdventureType)
IL_0092: dup
IL_0093: ldstr "<SIZE=22>D</SIZE>UNGEONS AND <SIZE=22>J</SIZE>UICES"
IL_0098: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Title(System.String)
IL_009d: dup
IL_009e: ldstr "Dungeons and Juices"
IL_00a3: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_NotificationTitle(System.String)
IL_00a8: dup
IL_00a9: ldstr "The bunnies are renovating their basement dungeon and just prepared another area. Recruit some critters to join the fun!"
IL_00ae: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Body(System.String)
IL_00b3: dup
IL_00b4: ldstr "BunnyHouse"
IL_00b9: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_GatewayName(System.String)
IL_00be: dup
IL_00bf: ldc.r4 2.58
IL_00c4: ldc.r4 0.76
IL_00c9: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_00ce: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnLocation(UnityEngine.Vector2)
IL_00d3: dup
IL_00d4: ldstr "BunnyHouse"
IL_00d9: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnAreaDbName(System.String)
IL_00de: dup
IL_00df: ldstr "dungeons_and_juices_1"
IL_00e4: stfld System.String TheForestOfLove.Narrative.Adventure::Savekey
IL_00e9: dup
IL_00ea: ldstr "completed_adventure_dungeons_and_juices_1"
IL_00ef: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_CompletionTrigger(System.String)
IL_00f4: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::Add(!0,!1)
IL_00f9: dup
IL_00fa: ldc.i4 300
IL_00ff: newobj System.Void TheForestOfLove.Narrative.Adventure::.ctor()
IL_0104: dup
IL_0105: ldc.i4 300
IL_010a: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_StoryType(TheForestOfLove.Narrative.AdventureType)
IL_010f: dup
IL_0110: ldstr "<SIZE=22>D</SIZE>UNGEONS AND <SIZE=22>J</SIZE>UICES <SIZE=22>2</SIZE>"
IL_0115: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Title(System.String)
IL_011a: dup
IL_011b: ldstr "Dungeons and Juices 2"
IL_0120: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_NotificationTitle(System.String)
IL_0125: dup
IL_0126: ldstr "The bunnies upgraded their basement dungeon and want to host more critters. This time, recruit some female critters to join the fun!"
IL_012b: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Body(System.String)
IL_0130: dup
IL_0131: ldstr "BunnyHouse"
IL_0136: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_GatewayName(System.String)
IL_013b: dup
IL_013c: ldc.r4 2.58
IL_0141: ldc.r4 0.76
IL_0146: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_014b: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnLocation(UnityEngine.Vector2)
IL_0150: dup
IL_0151: ldstr "BunnyHouse"
IL_0156: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnAreaDbName(System.String)
IL_015b: dup
IL_015c: ldstr "dungeons_and_juices_2"
IL_0161: stfld System.String TheForestOfLove.Narrative.Adventure::Savekey
IL_0166: dup
IL_0167: ldstr "completed_adventure_dungeons_and_juices_2"
IL_016c: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_CompletionTrigger(System.String)
IL_0171: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::Add(!0,!1)
IL_0176: dup
IL_0177: ldc.i4 400
IL_017c: newobj System.Void TheForestOfLove.Narrative.Adventure::.ctor()
IL_0181: dup
IL_0182: ldc.i4 400
IL_0187: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_StoryType(TheForestOfLove.Narrative.AdventureType)
IL_018c: dup
IL_018d: ldstr "<SIZE=22>M</SIZE>YSTERY <SIZE=22>M</SIZE>EETS"
IL_0192: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Title(System.String)
IL_0197: dup
IL_0198: ldstr "Mystery Meets"
IL_019d: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_NotificationTitle(System.String)
IL_01a2: dup
IL_01a3: ldstr "Oliver's been romping around lately with other forest critters. Who else has he been seeing?"
IL_01a8: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Body(System.String)
IL_01ad: dup
IL_01ae: ldstr "Plains_Field"
IL_01b3: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_GatewayName(System.String)
IL_01b8: dup
IL_01b9: ldc.r4 3.02
IL_01be: ldc.r4 0.33
IL_01c3: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_01c8: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnLocation(UnityEngine.Vector2)
IL_01cd: dup
IL_01ce: ldstr "Plains_Field"
IL_01d3: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnAreaDbName(System.String)
IL_01d8: dup
IL_01d9: ldstr "mystery_meets"
IL_01de: stfld System.String TheForestOfLove.Narrative.Adventure::Savekey
IL_01e3: dup
IL_01e4: ldstr "completed_adventure_mystery_meets"
IL_01e9: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_CompletionTrigger(System.String)
IL_01ee: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::Add(!0,!1)
IL_01f3: dup
IL_01f4: ldc.i4 500
IL_01f9: newobj System.Void TheForestOfLove.Narrative.Adventure::.ctor()
IL_01fe: dup
IL_01ff: ldc.i4 500
IL_0204: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_StoryType(TheForestOfLove.Narrative.AdventureType)
IL_0209: dup
IL_020a: ldstr "<SIZE=22>S</SIZE>EASON'S <SIZE=22>G</SIZE>REETINGS"
IL_020f: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Title(System.String)
IL_0214: dup
IL_0215: ldstr "Season's Greetings"
IL_021a: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_NotificationTitle(System.String)
IL_021f: dup
IL_0220: ldstr "Melody made spicy greeting cards for last year's Blessing of the Bells. Maybe she has an extra?"
IL_0225: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Body(System.String)
IL_022a: dup
IL_022b: ldstr "Mountains_BearCave"
IL_0230: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_GatewayName(System.String)
IL_0235: dup
IL_0236: ldc.r4 3.81
IL_023b: ldc.r4 1.37
IL_0240: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_0245: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnLocation(UnityEngine.Vector2)
IL_024a: dup
IL_024b: ldstr "Mountains_BearCave"
IL_0250: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnAreaDbName(System.String)
IL_0255: dup
IL_0256: ldstr "seasons_greetings"
IL_025b: stfld System.String TheForestOfLove.Narrative.Adventure::Savekey
IL_0260: dup
IL_0261: ldstr "completed_adventure_seasons_greetings"
IL_0266: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_CompletionTrigger(System.String)
IL_026b: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::Add(!0,!1)
IL_0270: dup
IL_0271: ldc.i4 600
IL_0276: newobj System.Void TheForestOfLove.Narrative.Adventure::.ctor()
IL_027b: dup
IL_027c: ldc.i4 600
IL_0281: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_StoryType(TheForestOfLove.Narrative.AdventureType)
IL_0286: dup
IL_0287: ldstr "<SIZE=22>L</SIZE>ENDING A <SIZE=22>P</SIZE>AW"
IL_028c: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Title(System.String)
IL_0291: dup
IL_0292: ldstr "Lending a Paw"
IL_0297: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_NotificationTitle(System.String)
IL_029c: dup
IL_029d: ldstr "Scarlett had a strange dream!
A bunch of critters were together in a different time and place, searching for unusual stuff..."
IL_02a2: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_Body(System.String)
IL_02a7: dup
IL_02a8: ldstr "BunnyHouse"
IL_02ad: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_GatewayName(System.String)
IL_02b2: dup
IL_02b3: ldc.r4 7.68
IL_02b8: ldc.r4 7.86
IL_02bd: newobj System.Void UnityEngine.Vector2::.ctor(System.Single,System.Single)
IL_02c2: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnLocation(UnityEngine.Vector2)
IL_02c7: dup
IL_02c8: ldstr "CentralForest"
IL_02cd: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_PlayerSpawnAreaDbName(System.String)
IL_02d2: dup
IL_02d3: ldstr "lending_a_paw"
IL_02d8: stfld System.String TheForestOfLove.Narrative.Adventure::Savekey
IL_02dd: dup
IL_02de: ldstr "completed_adventure_lending_a_paw"
IL_02e3: callvirt System.Void TheForestOfLove.Narrative.Adventure::set_CompletionTrigger(System.String)
IL_02e8: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.AdventureType,TheForestOfLove.Narrative.Adventure>::Add(!0,!1)
IL_02ed: ret
