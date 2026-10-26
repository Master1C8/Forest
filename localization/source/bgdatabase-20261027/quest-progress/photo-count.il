TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerSideQuests
METHOD System.Int32 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerSideQuests::CountNumberUnlockedMelodyFlipbookPhotos() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldstr "melody_flipbook_story_unlock_01"
IL_0007: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_000c: brfalse.s IL_0012
IL_000e: ldloc.0
IL_000f: ldc.i4.1
IL_0010: add
IL_0011: stloc.0
IL_0012: ldstr "melody_flipbook_story_unlock_02"
IL_0017: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_001c: brfalse.s IL_0022
IL_001e: ldloc.0
IL_001f: ldc.i4.1
IL_0020: add
IL_0021: stloc.0
IL_0022: ldstr "melody_flipbook_story_unlock_03"
IL_0027: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_002c: brfalse.s IL_0032
IL_002e: ldloc.0
IL_002f: ldc.i4.1
IL_0030: add
IL_0031: stloc.0
IL_0032: ldstr "melody_flipbook_story_unlock_04"
IL_0037: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_003c: brfalse.s IL_0042
IL_003e: ldloc.0
IL_003f: ldc.i4.1
IL_0040: add
IL_0041: stloc.0
IL_0042: ldstr "melody_flipbook_story_unlock_05"
IL_0047: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_004c: brfalse.s IL_0052
IL_004e: ldloc.0
IL_004f: ldc.i4.1
IL_0050: add
IL_0051: stloc.0
IL_0052: ldstr "melody_flipbook_story_unlock_06"
IL_0057: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_005c: brfalse.s IL_0062
IL_005e: ldloc.0
IL_005f: ldc.i4.1
IL_0060: add
IL_0061: stloc.0
IL_0062: ldstr "melody_flipbook_story_unlock_07"
IL_0067: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_006c: brfalse.s IL_0072
IL_006e: ldloc.0
IL_006f: ldc.i4.1
IL_0070: add
IL_0071: stloc.0
IL_0072: ldstr "melody_flipbook_story_unlock_08"
IL_0077: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_007c: brfalse.s IL_0082
IL_007e: ldloc.0
IL_007f: ldc.i4.1
IL_0080: add
IL_0081: stloc.0
IL_0082: ldstr "melody_flipbook_story_unlock_09"
IL_0087: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_008c: brfalse.s IL_0092
IL_008e: ldloc.0
IL_008f: ldc.i4.1
IL_0090: add
IL_0091: stloc.0
IL_0092: ldloc.0
IL_0093: ret
METHOD System.Int32 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerSideQuests::GetNumberTotalMelodyFlipbookPhotos() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.s 9
IL_0002: ret
