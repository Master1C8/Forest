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
