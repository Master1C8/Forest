TYPE TheForestOfLove.ConfirmBeginAdventureNotification
METHOD System.Void TheForestOfLove.ConfirmBeginAdventureNotification::AddAdventurePage(TheForestOfLove.Narrative.Adventure) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.ConfirmBeginAdventureNotificationPage TheForestOfLove.ConfirmBeginAdventureNotification::adventurePagePrefab
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.GameObject TheForestOfLove.ConfirmBeginAdventureNotification::pageRoot
IL_000c: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0011: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.ConfirmBeginAdventureNotificationPage>(!!0,UnityEngine.Transform)
IL_0016: stloc.0
IL_0017: ldarg.0
IL_0018: ldfld System.Collections.Generic.List`1<TheForestOfLove.ConfirmBeginAdventureNotificationPage> TheForestOfLove.ConfirmBeginAdventureNotification::pages
IL_001d: ldloc.0
IL_001e: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.ConfirmBeginAdventureNotificationPage>::Add(!0)
IL_0023: ldloc.0
IL_0024: ldarg.1
IL_0025: callvirt System.Void TheForestOfLove.ConfirmBeginAdventureNotificationPage::SetStory(TheForestOfLove.Narrative.Adventure)
IL_002a: ldloc.0
IL_002b: ldarg.1
IL_002c: callvirt System.String TheForestOfLove.Narrative.Adventure::get_Title()
IL_0031: callvirt System.Void TheForestOfLove.ConfirmBeginAdventureNotificationPage::SetTitle(System.String)
IL_0036: ldloc.0
IL_0037: ldarg.1
IL_0038: callvirt System.String TheForestOfLove.Narrative.Adventure::get_Body()
IL_003d: callvirt System.Void TheForestOfLove.ConfirmBeginAdventureNotificationPage::SetBody(System.String)
IL_0042: ldloc.0
IL_0043: ldarg.0
IL_0044: ldfld System.Collections.Generic.List`1<TheForestOfLove.ConfirmBeginAdventureNotificationPage> TheForestOfLove.ConfirmBeginAdventureNotification::pages
IL_0049: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ConfirmBeginAdventureNotificationPage>::get_Count()
IL_004e: ldc.i4.1
IL_004f: ceq
IL_0051: callvirt System.Void TheForestOfLove.ConfirmBeginAdventureNotificationPage::SetVisible(System.Boolean)
IL_0056: ret
METHOD System.Void TheForestOfLove.ConfirmBeginAdventureNotification::EnableNavigationConfirmationScreen() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Selectable TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenYesButton
IL_0006: ldc.i4.1
IL_0007: callvirt System.Void UnityEngine.UI.Selectable::set_interactable(System.Boolean)
IL_000c: ldarg.0
IL_000d: ldfld UnityEngine.UI.Selectable TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenNoButton
IL_0012: ldc.i4.1
IL_0013: callvirt System.Void UnityEngine.UI.Selectable::set_interactable(System.Boolean)
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.UI.Image TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenYesButtonCursorLGraphic
IL_001e: ldc.i4.1
IL_001f: callvirt System.Void UnityEngine.Behaviour::set_enabled(System.Boolean)
IL_0024: ldarg.0
IL_0025: ldfld UnityEngine.UI.Image TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenYesButtonCursorRGraphic
IL_002a: ldc.i4.1
IL_002b: callvirt System.Void UnityEngine.Behaviour::set_enabled(System.Boolean)
IL_0030: ldarg.0
IL_0031: ldfld UnityEngine.UI.Image TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenNoButtonCursorLGraphic
IL_0036: ldc.i4.1
IL_0037: callvirt System.Void UnityEngine.Behaviour::set_enabled(System.Boolean)
IL_003c: ldarg.0
IL_003d: ldfld UnityEngine.UI.Image TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenNoButtonCursorRGraphic
IL_0042: ldc.i4.1
IL_0043: callvirt System.Void UnityEngine.Behaviour::set_enabled(System.Boolean)
IL_0048: ldarg.0
IL_0049: ldfld TheForestOfLove.SelectableUiControl TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenYesButtonControl
IL_004e: callvirt System.Void TheForestOfLove.SelectableUiControl::SuppressSoundsUntilNextUpdate()
IL_0053: ldarg.0
IL_0054: ldfld TheForestOfLove.SelectableUiControl TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenNoButtonControl
IL_0059: callvirt System.Void TheForestOfLove.SelectableUiControl::SuppressSoundsUntilNextUpdate()
IL_005e: call UnityEngine.EventSystems.EventSystem UnityEngine.EventSystems.EventSystem::get_current()
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenLastSelectedControl
IL_0069: ldnull
IL_006a: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_006f: brtrue.s IL_007e
IL_0071: ldarg.0
IL_0072: ldfld UnityEngine.UI.Selectable TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenYesButton
IL_0077: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_007c: br.s IL_0084
IL_007e: ldarg.0
IL_007f: ldfld UnityEngine.GameObject TheForestOfLove.ConfirmBeginAdventureNotification::confirmationScreenLastSelectedControl
IL_0084: callvirt System.Void UnityEngine.EventSystems.EventSystem::SetSelectedGameObject(UnityEngine.GameObject)
IL_0089: ret
TYPE TheForestOfLove.Content.BaseSpawner
METHOD System.Void TheForestOfLove.Content.BaseSpawner::TryShowOutOfSyncContentNotification() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Int32 TheForestOfLove.GameVersionHelper::GetLastSavedGameVersion()
IL_0005: ldc.i4 20240406
IL_000a: bgt.s IL_0037
IL_000c: ldstr "MelodyQuest_PhotoshootConclusion"
IL_0011: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0016: brfalse.s IL_0037
IL_0018: ldstr "act3_melodyquest_stormscene_continuation"
IL_001d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0022: brtrue.s IL_0037
IL_0024: ldarg.0
IL_0025: ldc.i4 20240406
IL_002a: ldc.i4 2600
IL_002f: call System.Boolean TheForestOfLove.Content.BaseSpawner::TryShowOutOfSyncContentNotification(System.Int32,TheForestOfLove.Narrative.Chapter)
IL_0034: brfalse.s IL_0037
IL_0036: ret
IL_0037: call System.Int32 TheForestOfLove.GameVersionHelper::GetLastSavedGameVersion()
IL_003c: ldc.i4 20240603
IL_0041: bgt.s IL_006e
IL_0043: ldstr "StormQuest_MabelGrabbedTheLastPage"
IL_0048: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_004d: brfalse.s IL_006e
IL_004f: ldstr "act3_stormquest_afterstorm_continuation"
IL_0054: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0059: brtrue.s IL_006e
IL_005b: ldarg.0
IL_005c: ldc.i4 20240603
IL_0061: ldc.i4 2700
IL_0066: call System.Boolean TheForestOfLove.Content.BaseSpawner::TryShowOutOfSyncContentNotification(System.Int32,TheForestOfLove.Narrative.Chapter)
IL_006b: brfalse.s IL_006e
IL_006d: ret
IL_006e: call System.Int32 TheForestOfLove.GameVersionHelper::GetLastSavedGameVersion()
IL_0073: ldc.i4 20250328
IL_0078: bgt.s IL_0096
IL_007a: ldc.i4 20250328
IL_007f: call System.Boolean TheForestOfLove.GameVersionHelper::HasShownOosNotificationForGameVersionKey(System.Int32)
IL_0084: brtrue.s IL_0096
IL_0086: ldc.i4 20250328
IL_008b: call System.Void TheForestOfLove.GameVersionHelper::SaveOosNotificationFlagForGameVersionKey(System.Int32)
IL_0090: ldarg.0
IL_0091: call System.Void TheForestOfLove.Content.BaseSpawner::DoAdventureModeUpgradeScriptV041()
IL_0096: call System.Int32 TheForestOfLove.GameVersionHelper::GetLastSavedGameVersion()
IL_009b: ldc.i4 20250522
IL_00a0: bge.s IL_00a8
IL_00a2: ldarg.0
IL_00a3: call System.Void TheForestOfLove.Content.BaseSpawner::DoMelodyFlipbookQuestUpgradeScriptV042()
IL_00a8: ret
METHOD System.Boolean TheForestOfLove.Content.BaseSpawner::TryShowOutOfSyncContentNotification(System.Int32,TheForestOfLove.Narrative.Chapter) | attributes=Private, HideBySig | impl=IL
IL_0000: newobj System.Void TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::.ctor()
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: ldarg.1
IL_0008: stfld System.Int32 TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::gameVersionKey
IL_000d: ldloc.0
IL_000e: ldfld System.Int32 TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::gameVersionKey
IL_0013: call System.Boolean TheForestOfLove.GameVersionHelper::HasShownOosNotificationForGameVersionKey(System.Int32)
IL_0018: brfalse.s IL_001c
IL_001a: ldc.i4.0
IL_001b: ret
IL_001c: ldloc.0
IL_001d: ldarg.2
IL_001e: call TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Services.Persistence.DataService::GetChapterRecordByChapter(TheForestOfLove.Narrative.Chapter)
IL_0023: stfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::chapterRecord
IL_0028: ldloc.0
IL_0029: ldfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::chapterRecord
IL_002e: brtrue.s IL_0032
IL_0030: ldc.i4.0
IL_0031: ret
IL_0032: ldloc.0
IL_0033: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ItemGetNotification>()
IL_0038: stfld TheForestOfLove.ItemGetNotification TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::itemGetNotification
IL_003d: ldloc.0
IL_003e: ldfld TheForestOfLove.ItemGetNotification TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::itemGetNotification
IL_0043: ldnull
IL_0044: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0049: brfalse.s IL_004d
IL_004b: ldc.i4.0
IL_004c: ret
IL_004d: ldloc.0
IL_004e: ldstr "''{0}''"
IL_0053: ldloc.0
IL_0054: ldfld TheForestOfLove.Narrative.ChapterRecord TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::chapterRecord
IL_0059: ldfld System.String TheForestOfLove.Narrative.ChapterRecord::title
IL_005e: call System.String System.String::Format(System.String,System.Object)
IL_0063: stfld System.String TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::chapterNameText
IL_0068: ldloc.0
IL_0069: ldloc.0
IL_006a: ldftn System.Void TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::<TryShowOutOfSyncContentNotification>b__0()
IL_0070: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0075: stfld System.Action TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::onYes
IL_007a: ldloc.0
IL_007b: ldsfld System.Action TheForestOfLove.Content.BaseSpawner/<>c::<>9__38_1
IL_0080: dup
IL_0081: brtrue.s IL_009a
IL_0083: pop
IL_0084: ldsfld TheForestOfLove.Content.BaseSpawner/<>c TheForestOfLove.Content.BaseSpawner/<>c::<>9
IL_0089: ldftn System.Void TheForestOfLove.Content.BaseSpawner/<>c::<TryShowOutOfSyncContentNotification>b__38_1()
IL_008f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0094: dup
IL_0095: stsfld System.Action TheForestOfLove.Content.BaseSpawner/<>c::<>9__38_1
IL_009a: stfld System.Action TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::onNo
IL_009f: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_00a4: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_00a9: ldc.r4 1.5
IL_00ae: ldloc.0
IL_00af: ldftn System.Void TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::<TryShowOutOfSyncContentNotification>b__2()
IL_00b5: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00ba: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00bf: ldc.i4.1
IL_00c0: ret
TYPE TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0
METHOD System.Void TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::<TryShowOutOfSyncContentNotification>b__2() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0005: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_000a: ldarg.0
IL_000b: ldfld TheForestOfLove.ItemGetNotification TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::itemGetNotification
IL_0010: ldarg.0
IL_0011: ldfld System.String TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::chapterNameText
IL_0016: ldarg.0
IL_0017: ldfld System.Action TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::onYes
IL_001c: ldarg.0
IL_001d: ldfld System.Action TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::onNo
IL_0022: callvirt System.Void TheForestOfLove.ItemGetNotification::ShowOutOfSyncContentNotification(System.String,System.Action,System.Action)
IL_0027: ldarg.0
IL_0028: ldfld System.Int32 TheForestOfLove.Content.BaseSpawner/<>c__DisplayClass38_0::gameVersionKey
IL_002d: call System.Void TheForestOfLove.GameVersionHelper::SaveOosNotificationFlagForGameVersionKey(System.Int32)
IL_0032: ret
