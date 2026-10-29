TYPE TheForestOfLove.PauseScreenMainMenu
METHOD System.Void TheForestOfLove.PauseScreenMainMenu::Start() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.UIPanelMenu::Start()
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::cancelAdventureButton
IL_000c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0011: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAdventuresMechanicDisabled()
IL_0016: brtrue.s IL_001f
IL_0018: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_001d: br.s IL_0020
IL_001f: ldc.i4.0
IL_0020: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0025: ldarg.0
IL_0026: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::replayAdventureButton
IL_002b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0030: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAdventuresMechanicDisabled()
IL_0035: brtrue.s IL_0045
IL_0037: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_003c: brtrue.s IL_0045
IL_003e: call System.Boolean TheForestOfLove.QuestTriggerHelper::HasAnyUnlockedCompletedOnceAdventures()
IL_0043: br.s IL_0046
IL_0045: ldc.i4.0
IL_0046: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_004b: ldarg.0
IL_004c: call System.Void TheForestOfLove.PauseScreenMainMenu::ConfigureCentralMenuItemsToAdventureButtonNav()
IL_0051: ldarg.0
IL_0052: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::restartButton
IL_0057: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005c: ldc.i4.0
IL_005d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0062: ldarg.0
IL_0063: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::forfeitButton
IL_0068: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_006d: ldc.i4.0
IL_006e: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0073: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_0078: brfalse IL_0159
IL_007d: ldarg.0
IL_007e: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::optionsButton
IL_0083: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0088: ldc.i4.0
IL_0089: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_008e: ldarg.0
IL_008f: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::cancelAdventureButton
IL_0094: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0099: ldc.i4.0
IL_009a: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_009f: ldarg.0
IL_00a0: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::replayAdventureButton
IL_00a5: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00aa: ldc.i4.0
IL_00ab: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00b0: ldarg.0
IL_00b1: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::reportBugButton
IL_00b6: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00bb: ldc.i4.0
IL_00bc: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00c1: ldarg.0
IL_00c2: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::chapterSelectButton
IL_00c7: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00cc: ldc.i4.0
IL_00cd: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00d2: ldarg.0
IL_00d3: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::cheatsButton
IL_00d8: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00dd: ldc.i4.0
IL_00de: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00e3: ldarg.0
IL_00e4: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::saveButton
IL_00e9: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00ee: ldc.i4.0
IL_00ef: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00f4: ldarg.0
IL_00f5: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::menuButton
IL_00fa: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00ff: ldc.i4.0
IL_0100: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0105: ldarg.0
IL_0106: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::quitButton
IL_010b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0110: ldc.i4.0
IL_0111: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0116: ldarg.0
IL_0117: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::restartButton
IL_011c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0121: ldc.i4.1
IL_0122: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0127: ldarg.0
IL_0128: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::forfeitButton
IL_012d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0132: ldc.i4.1
IL_0133: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0138: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_013d: ldnull
IL_013e: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0143: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0148: ldarg.0
IL_0149: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::restartButton
IL_014e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0153: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0158: ret
IL_0159: ret
METHOD System.Void TheForestOfLove.PauseScreenMainMenu::OnOpen() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.UIPanelMenu::OnOpen()
IL_0006: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inDustinMinigame()
IL_000b: brfalse IL_00cc
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::optionsButton
IL_0016: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001b: ldc.i4.0
IL_001c: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0021: ldarg.0
IL_0022: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::cancelAdventureButton
IL_0027: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_002c: ldc.i4.0
IL_002d: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0032: ldarg.0
IL_0033: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::replayAdventureButton
IL_0038: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_003d: ldc.i4.0
IL_003e: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0043: ldarg.0
IL_0044: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::reportBugButton
IL_0049: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_004e: ldc.i4.0
IL_004f: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0054: ldarg.0
IL_0055: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::chapterSelectButton
IL_005a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_005f: ldc.i4.0
IL_0060: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0065: ldarg.0
IL_0066: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::cheatsButton
IL_006b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0070: ldc.i4.0
IL_0071: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0076: ldarg.0
IL_0077: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::saveButton
IL_007c: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0081: ldc.i4.0
IL_0082: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0087: ldarg.0
IL_0088: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::menuButton
IL_008d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0092: ldc.i4.0
IL_0093: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0098: ldarg.0
IL_0099: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::quitButton
IL_009e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00a3: ldc.i4.0
IL_00a4: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00a9: ldarg.0
IL_00aa: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::restartButton
IL_00af: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00b4: ldc.i4.1
IL_00b5: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00ba: ldarg.0
IL_00bb: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::forfeitButton
IL_00c0: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00c5: ldc.i4.1
IL_00c6: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00cb: ret
IL_00cc: ldarg.0
IL_00cd: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::optionsButton
IL_00d2: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00d7: ldc.i4.1
IL_00d8: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00dd: ldarg.0
IL_00de: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::cancelAdventureButton
IL_00e3: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00e8: ldc.i4.1
IL_00e9: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00ee: ldarg.0
IL_00ef: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::replayAdventureButton
IL_00f4: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00f9: ldc.i4.1
IL_00fa: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_00ff: ldarg.0
IL_0100: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::reportBugButton
IL_0105: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_010a: call System.Boolean TheForestOfLove.DeploymentHelper::get_IsWebGL()
IL_010f: ldc.i4.0
IL_0110: ceq
IL_0112: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0117: ldarg.0
IL_0118: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::chapterSelectButton
IL_011d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0122: ldc.i4.1
IL_0123: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0128: ldarg.0
IL_0129: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::cheatsButton
IL_012e: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0133: ldc.i4.1
IL_0134: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0139: ldarg.0
IL_013a: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::saveButton
IL_013f: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0144: ldc.i4.1
IL_0145: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_014a: ldarg.0
IL_014b: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::menuButton
IL_0150: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0155: ldc.i4.1
IL_0156: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_015b: ldarg.0
IL_015c: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::quitButton
IL_0161: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0166: call System.Boolean TheForestOfLove.DeploymentHelper::get_IsWebGL()
IL_016b: ldc.i4.0
IL_016c: ceq
IL_016e: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0173: ldarg.0
IL_0174: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::restartButton
IL_0179: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_017e: ldc.i4.0
IL_017f: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0184: ldarg.0
IL_0185: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::forfeitButton
IL_018a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_018f: ldc.i4.0
IL_0190: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_0195: ldarg.0
IL_0196: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::cancelAdventureButton
IL_019b: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01a0: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAdventuresMechanicDisabled()
IL_01a5: brtrue.s IL_01ae
IL_01a7: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_01ac: br.s IL_01af
IL_01ae: ldc.i4.0
IL_01af: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_01b4: ldarg.0
IL_01b5: ldfld UnityEngine.UI.Selectable TheForestOfLove.PauseScreenMainMenu::replayAdventureButton
IL_01ba: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_01bf: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAdventuresMechanicDisabled()
IL_01c4: brtrue.s IL_01d4
IL_01c6: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_01cb: brtrue.s IL_01d4
IL_01cd: call System.Boolean TheForestOfLove.QuestTriggerHelper::HasAnyUnlockedCompletedOnceAdventures()
IL_01d2: br.s IL_01d5
IL_01d4: ldc.i4.0
IL_01d5: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_01da: ldarg.0
IL_01db: call System.Void TheForestOfLove.PauseScreenMainMenu::ConfigureCentralMenuItemsToAdventureButtonNav()
IL_01e0: ret
METHOD System.Void TheForestOfLove.PauseScreenMainMenu::OnClickSave() | attributes=Public, HideBySig | impl=IL
IL_0000: ldc.i4 200
IL_0005: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_000a: ldarg.0
IL_000b: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickSave
IL_0010: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0015: ret
METHOD System.Void TheForestOfLove.PauseScreenMainMenu::OnClickChapterSelect() | attributes=Public, HideBySig | impl=IL
IL_0000: ldc.i4 200
IL_0005: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_000a: ldarg.0
IL_000b: ldfld UnityEngine.Events.UnityEvent TheForestOfLove.PauseScreenMainMenu::onClickChapterSelect
IL_0010: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0015: ret
