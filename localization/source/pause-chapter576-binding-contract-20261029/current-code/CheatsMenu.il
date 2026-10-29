TYPE TheForestOfLove.CheatsMenu
METHOD System.Boolean TheForestOfLove.CheatsMenu::get_unlockAllStoryChapters() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.CheatsMenu::<unlockAllStoryChapters>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.CheatsMenu::set_unlockAllStoryChapters(System.Boolean) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean TheForestOfLove.CheatsMenu::<unlockAllStoryChapters>k__BackingField
IL_0007: ret
METHOD System.Boolean TheForestOfLove.CheatsMenu::get_completeAllDates() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.CheatsMenu::<completeAllDates>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.CheatsMenu::set_completeAllDates(System.Boolean) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean TheForestOfLove.CheatsMenu::<completeAllDates>k__BackingField
IL_0007: ret
METHOD System.Boolean TheForestOfLove.CheatsMenu::get_completeAllGossips() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.CheatsMenu::<completeAllGossips>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.CheatsMenu::set_completeAllGossips(System.Boolean) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean TheForestOfLove.CheatsMenu::<completeAllGossips>k__BackingField
IL_0007: ret
METHOD System.Boolean TheForestOfLove.CheatsMenu::get_dustinMinigameInvincible() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.CheatsMenu::<dustinMinigameInvincible>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.CheatsMenu::set_dustinMinigameInvincible(System.Boolean) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean TheForestOfLove.CheatsMenu::<dustinMinigameInvincible>k__BackingField
IL_0007: ret
METHOD System.Boolean TheForestOfLove.CheatsMenu::get_plantMinigameHandsfree() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean TheForestOfLove.CheatsMenu::<plantMinigameHandsfree>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.CheatsMenu::set_plantMinigameHandsfree(System.Boolean) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Boolean TheForestOfLove.CheatsMenu::<plantMinigameHandsfree>k__BackingField
IL_0007: ret
METHOD System.Void TheForestOfLove.CheatsMenu::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.UIPanelMenu::Start()
IL_0006: ldarg.0
IL_0007: call System.Void TheForestOfLove.CheatsMenu::InitMenu()
IL_000c: ret
METHOD System.Void TheForestOfLove.CheatsMenu::InitMenu() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "cheats_unlock_all_story_chapters"
IL_0006: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_000b: ldnull
IL_000c: cgt.un
IL_000e: call System.Void TheForestOfLove.CheatsMenu::set_unlockAllStoryChapters(System.Boolean)
IL_0013: ldarg.0
IL_0014: ldstr "cheats_complete_all_dates"
IL_0019: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_001e: ldnull
IL_001f: cgt.un
IL_0021: call System.Void TheForestOfLove.CheatsMenu::set_completeAllDates(System.Boolean)
IL_0026: ldarg.0
IL_0027: ldstr "cheats_complete_all_gossips"
IL_002c: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_0031: ldnull
IL_0032: cgt.un
IL_0034: call System.Void TheForestOfLove.CheatsMenu::set_completeAllGossips(System.Boolean)
IL_0039: ldarg.0
IL_003a: ldstr "cheats_dustin_minigame_invincible"
IL_003f: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_0044: ldnull
IL_0045: cgt.un
IL_0047: call System.Void TheForestOfLove.CheatsMenu::set_dustinMinigameInvincible(System.Boolean)
IL_004c: ldarg.0
IL_004d: ldstr "cheats_plant_minigame_handsfree"
IL_0052: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_0057: ldnull
IL_0058: cgt.un
IL_005a: call System.Void TheForestOfLove.CheatsMenu::set_plantMinigameHandsfree(System.Boolean)
IL_005f: ldarg.0
IL_0060: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatUnlockAllStoryChaptersYes
IL_0065: ldarg.0
IL_0066: call System.Boolean TheForestOfLove.CheatsMenu::get_unlockAllStoryChapters()
IL_006b: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0070: ldarg.0
IL_0071: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatUnlockAllStoryChaptersNo
IL_0076: ldarg.0
IL_0077: call System.Boolean TheForestOfLove.CheatsMenu::get_unlockAllStoryChapters()
IL_007c: ldc.i4.0
IL_007d: ceq
IL_007f: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0084: ldarg.0
IL_0085: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatCompleteAllDatesYes
IL_008a: ldarg.0
IL_008b: call System.Boolean TheForestOfLove.CheatsMenu::get_completeAllDates()
IL_0090: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0095: ldarg.0
IL_0096: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatCompleteAllDatesNo
IL_009b: ldarg.0
IL_009c: call System.Boolean TheForestOfLove.CheatsMenu::get_completeAllDates()
IL_00a1: ldc.i4.0
IL_00a2: ceq
IL_00a4: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00a9: ldarg.0
IL_00aa: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatCompleteAllGossipsYes
IL_00af: ldarg.0
IL_00b0: call System.Boolean TheForestOfLove.CheatsMenu::get_completeAllGossips()
IL_00b5: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00ba: ldarg.0
IL_00bb: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatCompleteAllGossipsNo
IL_00c0: ldarg.0
IL_00c1: call System.Boolean TheForestOfLove.CheatsMenu::get_completeAllGossips()
IL_00c6: ldc.i4.0
IL_00c7: ceq
IL_00c9: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00ce: ldarg.0
IL_00cf: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatDustinMinigameInvincibleYes
IL_00d4: ldarg.0
IL_00d5: call System.Boolean TheForestOfLove.CheatsMenu::get_dustinMinigameInvincible()
IL_00da: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00df: ldarg.0
IL_00e0: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatDustinMinigameInvincibleNo
IL_00e5: ldarg.0
IL_00e6: call System.Boolean TheForestOfLove.CheatsMenu::get_dustinMinigameInvincible()
IL_00eb: ldc.i4.0
IL_00ec: ceq
IL_00ee: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00f3: ldarg.0
IL_00f4: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatPlantMinigameHandsfreeYes
IL_00f9: ldarg.0
IL_00fa: call System.Boolean TheForestOfLove.CheatsMenu::get_plantMinigameHandsfree()
IL_00ff: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0104: ldarg.0
IL_0105: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatPlantMinigameHandsfreeNo
IL_010a: ldarg.0
IL_010b: call System.Boolean TheForestOfLove.CheatsMenu::get_plantMinigameHandsfree()
IL_0110: ldc.i4.0
IL_0111: ceq
IL_0113: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0118: ret
METHOD System.Void TheForestOfLove.CheatsMenu::Update() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.UIPanelMenu::Update()
IL_0006: ldarg.0
IL_0007: ldarg.0
IL_0008: ldfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_000d: ldc.i4.1
IL_000e: sub
IL_000f: stfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0014: ret
METHOD System.Void TheForestOfLove.CheatsMenu::Cheat_UnlockAllStoryChapters() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0011: ldarg.0
IL_0012: ldc.i4.1
IL_0013: call System.Void TheForestOfLove.CheatsMenu::set_unlockAllStoryChapters(System.Boolean)
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatUnlockAllStoryChaptersYes
IL_001e: ldarg.0
IL_001f: call System.Boolean TheForestOfLove.CheatsMenu::get_unlockAllStoryChapters()
IL_0024: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatUnlockAllStoryChaptersNo
IL_002f: ldarg.0
IL_0030: call System.Boolean TheForestOfLove.CheatsMenu::get_unlockAllStoryChapters()
IL_0035: ldc.i4.0
IL_0036: ceq
IL_0038: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_003d: ldc.i4.s 100
IL_003f: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0044: ret
METHOD System.Void TheForestOfLove.CheatsMenu::Cheat_CompleteAllDates() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0011: ldarg.0
IL_0012: ldc.i4.1
IL_0013: call System.Void TheForestOfLove.CheatsMenu::set_completeAllDates(System.Boolean)
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatCompleteAllDatesYes
IL_001e: ldarg.0
IL_001f: call System.Boolean TheForestOfLove.CheatsMenu::get_completeAllDates()
IL_0024: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatCompleteAllDatesNo
IL_002f: ldarg.0
IL_0030: call System.Boolean TheForestOfLove.CheatsMenu::get_completeAllDates()
IL_0035: ldc.i4.0
IL_0036: ceq
IL_0038: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_003d: ldc.i4.s 100
IL_003f: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0044: ret
METHOD System.Void TheForestOfLove.CheatsMenu::Cheat_CompleteAllGossips() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0011: ldarg.0
IL_0012: ldc.i4.1
IL_0013: call System.Void TheForestOfLove.CheatsMenu::set_completeAllGossips(System.Boolean)
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatCompleteAllGossipsYes
IL_001e: ldarg.0
IL_001f: call System.Boolean TheForestOfLove.CheatsMenu::get_completeAllGossips()
IL_0024: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatCompleteAllGossipsNo
IL_002f: ldarg.0
IL_0030: call System.Boolean TheForestOfLove.CheatsMenu::get_completeAllGossips()
IL_0035: ldc.i4.0
IL_0036: ceq
IL_0038: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_003d: ldc.i4.s 100
IL_003f: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0044: ret
METHOD System.Void TheForestOfLove.CheatsMenu::Cheat_DustinMinigameInvincible() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0011: ldarg.0
IL_0012: ldarg.0
IL_0013: call System.Boolean TheForestOfLove.CheatsMenu::get_dustinMinigameInvincible()
IL_0018: ldc.i4.0
IL_0019: ceq
IL_001b: call System.Void TheForestOfLove.CheatsMenu::set_dustinMinigameInvincible(System.Boolean)
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatDustinMinigameInvincibleYes
IL_0026: ldarg.0
IL_0027: call System.Boolean TheForestOfLove.CheatsMenu::get_dustinMinigameInvincible()
IL_002c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0031: ldarg.0
IL_0032: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatDustinMinigameInvincibleNo
IL_0037: ldarg.0
IL_0038: call System.Boolean TheForestOfLove.CheatsMenu::get_dustinMinigameInvincible()
IL_003d: ldc.i4.0
IL_003e: ceq
IL_0040: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0045: ldc.i4.s 100
IL_0047: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_004c: ret
METHOD System.Void TheForestOfLove.CheatsMenu::Cheat_PlantMinigameHandsfree() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0006: ldc.i4.0
IL_0007: ble.s IL_000a
IL_0009: ret
IL_000a: ldarg.0
IL_000b: ldc.i4.2
IL_000c: stfld System.Int32 TheForestOfLove.CheatsMenu::waitFramesToClearInput
IL_0011: ldarg.0
IL_0012: ldarg.0
IL_0013: call System.Boolean TheForestOfLove.CheatsMenu::get_plantMinigameHandsfree()
IL_0018: ldc.i4.0
IL_0019: ceq
IL_001b: call System.Void TheForestOfLove.CheatsMenu::set_plantMinigameHandsfree(System.Boolean)
IL_0020: ldarg.0
IL_0021: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatPlantMinigameHandsfreeYes
IL_0026: ldarg.0
IL_0027: call System.Boolean TheForestOfLove.CheatsMenu::get_plantMinigameHandsfree()
IL_002c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0031: ldarg.0
IL_0032: ldfld UnityEngine.GameObject TheForestOfLove.CheatsMenu::cheatPlantMinigameHandsfreeNo
IL_0037: ldarg.0
IL_0038: call System.Boolean TheForestOfLove.CheatsMenu::get_plantMinigameHandsfree()
IL_003d: ldc.i4.0
IL_003e: ceq
IL_0040: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0045: ldc.i4.s 100
IL_0047: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_004c: ret
