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
